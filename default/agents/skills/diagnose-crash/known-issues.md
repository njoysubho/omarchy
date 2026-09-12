# Existing Crash Reports and Fixes

Read this during every crash diagnosis, before writing the report. Start with [omacom/omarchy](https://github.com/omacom/omarchy) for source, issues, and pull requests; specify the repository explicitly rather than relying on a local checkout's remote or a fork.

## Connect the crash to the source

Record the Omarchy version and relevant package versions at the time of the crash, accounting for updates since then. If Omarchy code, configuration, or packaging is implicated, inspect the relevant installed files under `$OMARCHY_PATH` and compare them with the corresponding tag or commit in `omacom/omarchy`. Follow the affected code and its history to explain the mechanism; current branch contents may differ from what crashed. Cite the relevant source or commit when it supports the diagnosis.

A report in Omarchy's tracker does not establish that Omarchy caused the crash. If the evidence points to a third-party application or library, retain that attribution and follow relevant upstream links from the Omarchy discussion when useful.

## Search issues and pull requests

Search both issues and PRs using combinations of the program or component, signal or assertion, distinctive stack symbols, and trigger. Try a broader component search when specific terms find nothing; a fix may describe the mechanism without using the word "crash". Use only non-sensitive search terms from the diagnostics.

```bash
gh search issues --repo omacom/omarchy "<program> crash"
gh search issues --repo omacom/omarchy "<distinctive symbol or assertion>"
gh search prs --repo omacom/omarchy "<component>"
gh search prs --repo omacom/omarchy "<distinctive symbol or trigger>"
```

Include open and closed issues, and open, draft, merged, and closed-unmerged PRs. Leave `--state` off these search commands to search across states; `gh search` accepts only `open` or `closed` for `--state`, not `all`. Narrow the query or increase `--limit` when results are truncated. See the [issue search](https://cli.github.com/manual/gh_search_issues) and [PR search](https://cli.github.com/manual/gh_search_prs) command references.

If `gh` is unavailable or cannot search, use public GitHub pages or an available web tool with `repo:omacom/omarchy is:issue` and `repo:omacom/omarchy is:pr`, without an open-only filter. Do not install or authenticate tools just for this lookup. If access fails, report that the lookup could not be completed; an unavailable search is not evidence that no report exists.

## Verify each plausible match

Read the discussion and linked fixes, then inspect the relevant PR diff:

```bash
gh issue view <number> --repo omacom/omarchy --comments
gh pr view <number> --repo omacom/omarchy --comments
gh pr view <number> --repo omacom/omarchy --json url,state,isDraft,mergedAt,mergeCommit,baseRefName
gh pr diff <number> --repo omacom/omarchy
```

Compare the trigger, stack or assertion, affected versions, and environment with the local evidence. The same application crashing is not enough to establish the same bug. Explain which evidence matches and what remains uncertain. A PR is relevant when its changes address the observed or suspected mechanism; its title alone is insufficient.

For each relevant PR, distinguish a proposed fix (open or draft), merged work, and a PR closed without merging. Follow any replacement PR or revert mentioned in the discussion. Before recommending an update as a fix, verify which release or package contains the change and whether the user's installed version includes it. Merging does not establish that a fix has shipped. If release inclusion cannot be verified, say so.

A closed issue is not proof of a fix. Read why it was closed. If the same failure occurs on a version verified to contain the intended fix, describe it as a possible regression or incomplete fix, supported by the version and stack comparison.

Return matching issue and PR links, current status, relevance, and fix availability in the diagnosis. If nothing matches, say "No matching issue or PR found in omacom/omarchy" and briefly state what was searched; do not claim the bug has never been reported. This is a read-only lookup; filing or commenting follows [`reporting.md`](reporting.md).
