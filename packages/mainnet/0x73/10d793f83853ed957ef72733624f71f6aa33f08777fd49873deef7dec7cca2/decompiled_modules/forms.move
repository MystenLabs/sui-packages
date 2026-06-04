module 0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms {
    struct Form has key {
        id: 0x2::object::UID,
        creator: address,
        title: 0x1::string::String,
        schema_blob_id: 0x1::string::String,
        is_private: bool,
        require_wallet: bool,
        allow_duplicate: bool,
        allowlist: 0x2::vec_set::VecSet<address>,
        submitters: 0x2::vec_set::VecSet<address>,
        archived: bool,
        admins: 0x2::vec_set::VecSet<address>,
        submission_count: u64,
        created_at_ms: u64,
        updated_at_ms: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        form_id: 0x2::object::ID,
    }

    struct FormCreated has copy, drop {
        form_id: 0x2::object::ID,
        creator: address,
        title: 0x1::string::String,
        schema_blob_id: 0x1::string::String,
        is_private: bool,
        require_wallet: bool,
        allow_duplicate: bool,
        created_at_ms: u64,
    }

    struct FormUpdated has copy, drop {
        form_id: 0x2::object::ID,
        schema_blob_id: 0x1::string::String,
        title: 0x1::string::String,
        updated_at_ms: u64,
    }

    struct FormArchived has copy, drop {
        form_id: 0x2::object::ID,
        archived: bool,
    }

    struct AdminAdded has copy, drop {
        form_id: 0x2::object::ID,
        admin: address,
    }

    struct AdminRemoved has copy, drop {
        form_id: 0x2::object::ID,
        admin: address,
    }

    struct AllowlistAdded has copy, drop {
        form_id: 0x2::object::ID,
        addr: address,
    }

    struct AllowlistRemoved has copy, drop {
        form_id: 0x2::object::ID,
        addr: address,
    }

    struct AllowDuplicateUpdated has copy, drop {
        form_id: 0x2::object::ID,
        allow_duplicate: bool,
    }

    public fun add_admin(arg0: &mut Form, arg1: &AdminCap, arg2: address) {
        assert_authorizes(arg1, arg0);
        if (!0x2::vec_set::contains<address>(&arg0.admins, &arg2)) {
            0x2::vec_set::insert<address>(&mut arg0.admins, arg2);
        };
        let v0 = AdminAdded{
            form_id : 0x2::object::id<Form>(arg0),
            admin   : arg2,
        };
        0x2::event::emit<AdminAdded>(v0);
    }

    public fun add_allowlist(arg0: &mut Form, arg1: &AdminCap, arg2: address) {
        assert_authorizes(arg1, arg0);
        assert!(arg0.require_wallet, 13906835282445336583);
        if (!0x2::vec_set::contains<address>(&arg0.allowlist, &arg2)) {
            0x2::vec_set::insert<address>(&mut arg0.allowlist, arg2);
        };
        let v0 = AllowlistAdded{
            form_id : 0x2::object::id<Form>(arg0),
            addr    : arg2,
        };
        0x2::event::emit<AllowlistAdded>(v0);
    }

    public fun admins(arg0: &Form) : &0x2::vec_set::VecSet<address> {
        &arg0.admins
    }

    public fun allow_duplicate(arg0: &Form) : bool {
        arg0.allow_duplicate
    }

    public fun allowlist(arg0: &Form) : &0x2::vec_set::VecSet<address> {
        &arg0.allowlist
    }

    public fun allowlist_size(arg0: &Form) : u64 {
        0x2::vec_set::length<address>(&arg0.allowlist)
    }

    public fun archived(arg0: &Form) : bool {
        arg0.archived
    }

    public(friend) fun assert_authorized_sender(arg0: &Form, arg1: address) {
        assert!(is_authorized(arg0, arg1), 13906835557323112453);
    }

    public(friend) fun assert_authorizes(arg0: &AdminCap, arg1: &Form) {
        assert!(arg0.form_id == 0x2::object::id<Form>(arg1), 13906835540142981121);
    }

    public fun cap_form_id(arg0: &AdminCap) : 0x2::object::ID {
        arg0.form_id
    }

    public fun create(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: bool, arg3: bool, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (Form, AdminCap) {
        if (!arg4) {
            assert!(arg3, 13906834698329915401);
        };
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let v2 = Form{
            id               : 0x2::object::new(arg6),
            creator          : v0,
            title            : arg0,
            schema_blob_id   : arg1,
            is_private       : arg2,
            require_wallet   : arg3,
            allow_duplicate  : arg4,
            allowlist        : 0x2::vec_set::empty<address>(),
            submitters       : 0x2::vec_set::empty<address>(),
            archived         : false,
            admins           : 0x2::vec_set::empty<address>(),
            submission_count : 0,
            created_at_ms    : v1,
            updated_at_ms    : v1,
        };
        let v3 = 0x2::object::id<Form>(&v2);
        let v4 = AdminCap{
            id      : 0x2::object::new(arg6),
            form_id : v3,
        };
        let v5 = FormCreated{
            form_id         : v3,
            creator         : v0,
            title           : v2.title,
            schema_blob_id  : v2.schema_blob_id,
            is_private      : arg2,
            require_wallet  : arg3,
            allow_duplicate : arg4,
            created_at_ms   : v1,
        };
        0x2::event::emit<FormCreated>(v5);
        (v2, v4)
    }

    entry fun create_and_share(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: bool, arg3: bool, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x2::transfer::share_object<Form>(v0);
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg6));
    }

    public fun creator(arg0: &Form) : address {
        arg0.creator
    }

    public fun has_submitted(arg0: &Form, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.submitters, &arg1)
    }

    public(friend) fun increment_submissions(arg0: &mut Form) : u64 {
        let v0 = arg0.submission_count;
        arg0.submission_count = v0 + 1;
        v0
    }

    public fun is_admin(arg0: &Form, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.admins, &arg1)
    }

    public fun is_allowlisted(arg0: &Form, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.allowlist, &arg1)
    }

    public fun is_authorized(arg0: &Form, arg1: address) : bool {
        arg0.creator == arg1 || 0x2::vec_set::contains<address>(&arg0.admins, &arg1)
    }

    public fun is_private(arg0: &Form) : bool {
        arg0.is_private
    }

    public(friend) fun record_submitter(arg0: &mut Form, arg1: address) {
        if (!0x2::vec_set::contains<address>(&arg0.submitters, &arg1)) {
            0x2::vec_set::insert<address>(&mut arg0.submitters, arg1);
        };
    }

    public fun remove_admin(arg0: &mut Form, arg1: &AdminCap, arg2: address) {
        assert_authorizes(arg1, arg0);
        if (0x2::vec_set::contains<address>(&arg0.admins, &arg2)) {
            0x2::vec_set::remove<address>(&mut arg0.admins, &arg2);
        };
        let v0 = AdminRemoved{
            form_id : 0x2::object::id<Form>(arg0),
            admin   : arg2,
        };
        0x2::event::emit<AdminRemoved>(v0);
    }

    public fun remove_allowlist(arg0: &mut Form, arg1: &AdminCap, arg2: address) {
        assert_authorizes(arg1, arg0);
        if (0x2::vec_set::contains<address>(&arg0.allowlist, &arg2)) {
            0x2::vec_set::remove<address>(&mut arg0.allowlist, &arg2);
        };
        let v0 = AllowlistRemoved{
            form_id : 0x2::object::id<Form>(arg0),
            addr    : arg2,
        };
        0x2::event::emit<AllowlistRemoved>(v0);
    }

    public fun require_wallet(arg0: &Form) : bool {
        arg0.require_wallet
    }

    public fun schema_blob_id(arg0: &Form) : &0x1::string::String {
        &arg0.schema_blob_id
    }

    public fun set_allow_duplicate(arg0: &mut Form, arg1: &AdminCap, arg2: bool, arg3: &0x2::clock::Clock) {
        assert_authorizes(arg1, arg0);
        if (!arg2) {
            assert!(arg0.require_wallet, 13906835222315925513);
        };
        arg0.allow_duplicate = arg2;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg3);
        let v0 = AllowDuplicateUpdated{
            form_id         : 0x2::object::id<Form>(arg0),
            allow_duplicate : arg2,
        };
        0x2::event::emit<AllowDuplicateUpdated>(v0);
    }

    public fun set_archived(arg0: &mut Form, arg1: &AdminCap, arg2: bool, arg3: &0x2::clock::Clock) {
        assert_authorizes(arg1, arg0);
        arg0.archived = arg2;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg3);
        let v0 = FormArchived{
            form_id  : 0x2::object::id<Form>(arg0),
            archived : arg2,
        };
        0x2::event::emit<FormArchived>(v0);
    }

    public fun submission_count(arg0: &Form) : u64 {
        arg0.submission_count
    }

    public fun title(arg0: &Form) : &0x1::string::String {
        &arg0.title
    }

    public(friend) fun uid(arg0: &Form) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun uid_mut(arg0: &mut Form) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun update_schema(arg0: &mut Form, arg1: &AdminCap, arg2: 0x1::string::String, arg3: &0x2::clock::Clock) {
        assert_authorizes(arg1, arg0);
        assert!(!arg0.archived, 13906834990387298307);
        arg0.schema_blob_id = arg2;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg3);
        let v0 = FormUpdated{
            form_id        : 0x2::object::id<Form>(arg0),
            schema_blob_id : arg0.schema_blob_id,
            title          : arg0.title,
            updated_at_ms  : arg0.updated_at_ms,
        };
        0x2::event::emit<FormUpdated>(v0);
    }

    public fun update_title(arg0: &mut Form, arg1: &AdminCap, arg2: 0x1::string::String, arg3: &0x2::clock::Clock) {
        assert_authorizes(arg1, arg0);
        assert!(!arg0.archived, 13906835046221873155);
        arg0.title = arg2;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg3);
        let v0 = FormUpdated{
            form_id        : 0x2::object::id<Form>(arg0),
            schema_blob_id : arg0.schema_blob_id,
            title          : arg0.title,
            updated_at_ms  : arg0.updated_at_ms,
        };
        0x2::event::emit<FormUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

