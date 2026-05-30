module 0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::issue {
    struct Issue has store, key {
        id: 0x2::object::UID,
        repo_id: 0x2::object::ID,
        author: address,
        title: 0x1::string::String,
        body_blob: 0x1::string::String,
        status: u8,
        comment_count: u64,
    }

    struct IssueComment has store, key {
        id: 0x2::object::UID,
        issue_id: 0x2::object::ID,
        author: address,
        body_blob: 0x1::string::String,
    }

    struct IssueOpened has copy, drop {
        issue_id: 0x2::object::ID,
        repo_id: 0x2::object::ID,
        author: address,
        title: 0x1::string::String,
    }

    struct IssueClosed has copy, drop {
        issue_id: 0x2::object::ID,
        repo_id: 0x2::object::ID,
    }

    struct IssueCommented has copy, drop {
        comment_id: 0x2::object::ID,
        issue_id: 0x2::object::ID,
        author: address,
        body_blob: 0x1::string::String,
    }

    public fun close_issue(arg0: &mut Issue, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.author == 0x2::tx_context::sender(arg1), 1);
        assert!(arg0.status == 0, 2);
        arg0.status = 1;
        let v0 = IssueClosed{
            issue_id : 0x2::object::id<Issue>(arg0),
            repo_id  : arg0.repo_id,
        };
        0x2::event::emit<IssueClosed>(v0);
    }

    public fun close_issue_as_owner(arg0: &0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::Repository, arg1: &mut Issue, arg2: &0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::RepoOwnerCap) {
        0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::assert_owner(arg0, arg2);
        assert!(arg1.repo_id == 0x2::object::id<0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::Repository>(arg0), 0);
        assert!(arg1.status == 0, 2);
        arg1.status = 1;
        let v0 = IssueClosed{
            issue_id : 0x2::object::id<Issue>(arg1),
            repo_id  : arg1.repo_id,
        };
        0x2::event::emit<IssueClosed>(v0);
    }

    public fun comment_author(arg0: &IssueComment) : address {
        arg0.author
    }

    public fun comment_body(arg0: &IssueComment) : 0x1::string::String {
        arg0.body_blob
    }

    public fun comment_issue(arg0: &mut Issue, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 2);
        let v0 = IssueComment{
            id        : 0x2::object::new(arg2),
            issue_id  : 0x2::object::id<Issue>(arg0),
            author    : 0x2::tx_context::sender(arg2),
            body_blob : arg1,
        };
        arg0.comment_count = arg0.comment_count + 1;
        let v1 = IssueCommented{
            comment_id : 0x2::object::id<IssueComment>(&v0),
            issue_id   : 0x2::object::id<Issue>(arg0),
            author     : v0.author,
            body_blob  : arg1,
        };
        0x2::event::emit<IssueCommented>(v1);
        0x2::transfer::share_object<IssueComment>(v0);
    }

    public fun comment_issue_id(arg0: &IssueComment) : 0x2::object::ID {
        arg0.issue_id
    }

    public fun issue_author(arg0: &Issue) : address {
        arg0.author
    }

    public fun issue_body(arg0: &Issue) : 0x1::string::String {
        arg0.body_blob
    }

    public fun issue_comment_count(arg0: &Issue) : u64 {
        arg0.comment_count
    }

    public fun issue_repo(arg0: &Issue) : 0x2::object::ID {
        arg0.repo_id
    }

    public fun issue_status(arg0: &Issue) : u8 {
        arg0.status
    }

    public fun issue_title(arg0: &Issue) : 0x1::string::String {
        arg0.title
    }

    public fun open_issue(arg0: &0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::Repository, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Issue{
            id            : 0x2::object::new(arg3),
            repo_id       : 0x2::object::id<0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::Repository>(arg0),
            author        : 0x2::tx_context::sender(arg3),
            title         : arg1,
            body_blob     : arg2,
            status        : 0,
            comment_count : 0,
        };
        let v1 = IssueOpened{
            issue_id : 0x2::object::id<Issue>(&v0),
            repo_id  : v0.repo_id,
            author   : v0.author,
            title    : v0.title,
        };
        0x2::event::emit<IssueOpened>(v1);
        0x2::transfer::share_object<Issue>(v0);
    }

    public fun status_closed() : u8 {
        1
    }

    public fun status_open() : u8 {
        0
    }

    // decompiled from Move bytecode v7
}

