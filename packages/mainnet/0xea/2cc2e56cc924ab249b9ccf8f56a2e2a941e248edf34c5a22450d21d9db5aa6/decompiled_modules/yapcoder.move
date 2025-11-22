module 0xea2cc2e56cc924ab249b9ccf8f56a2e2a941e248edf34c5a22450d21d9db5aa6::yapcoder {
    struct YapCoder has key {
        id: 0x2::object::UID,
        github_user_id: u64,
        repo_id: u64,
        username: 0x1::string::String,
        repo_name: 0x1::string::String,
        is_validated: bool,
    }

    struct YapCoderCreated has copy, drop {
        coder_id: 0x2::object::ID,
        github_user_id: u64,
        repo_id: u64,
        yapper: address,
    }

    struct YapCoderValidated has copy, drop {
        coder_id: 0x2::object::ID,
        is_validated: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct YapCoderIndex has store, key {
        id: 0x2::object::UID,
        by_github: 0x2::table::Table<u64, 0x2::object::ID>,
    }

    public fun create_yap_coder(arg0: &mut YapCoderIndex, arg1: u64, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: address, arg6: &AdminCap, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = YapCoder{
            id             : 0x2::object::new(arg7),
            github_user_id : arg1,
            repo_id        : arg2,
            username       : arg3,
            repo_name      : arg4,
            is_validated   : false,
        };
        if (!0x2::table::contains<u64, 0x2::object::ID>(&arg0.by_github, arg1)) {
            0x2::table::add<u64, 0x2::object::ID>(&mut arg0.by_github, arg1, 0x2::object::uid_to_inner(&v0.id));
        };
        let v1 = YapCoderCreated{
            coder_id       : 0x2::object::uid_to_inner(&v0.id),
            github_user_id : arg1,
            repo_id        : arg2,
            yapper         : arg5,
        };
        0x2::event::emit<YapCoderCreated>(v1);
        0x2::transfer::transfer<YapCoder>(v0, arg5);
    }

    public fun get_yapcoder_data(arg0: &YapCoder) : (0x2::object::ID, u64, u64, 0x1::string::String, 0x1::string::String, bool) {
        (0x2::object::id<YapCoder>(arg0), arg0.github_user_id, arg0.repo_id, arg0.username, arg0.repo_name, arg0.is_validated)
    }

    public fun get_yapcoder_id_by_github_user_id(arg0: &YapCoderIndex, arg1: u64) : 0x2::object::ID {
        *0x2::table::borrow<u64, 0x2::object::ID>(&arg0.by_github, arg1)
    }

    public fun index_yapcoder(arg0: &mut YapCoderIndex, arg1: &YapCoder, arg2: &AdminCap) {
        let v0 = arg1.github_user_id;
        if (!0x2::table::contains<u64, 0x2::object::ID>(&arg0.by_github, v0)) {
            0x2::table::add<u64, 0x2::object::ID>(&mut arg0.by_github, v0, 0x2::object::id<YapCoder>(arg1));
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = YapCoderIndex{
            id        : 0x2::object::new(arg0),
            by_github : 0x2::table::new<u64, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<YapCoderIndex>(v1);
    }

    public fun update_validation_status(arg0: &mut YapCoder, arg1: &AdminCap) {
        arg0.is_validated = true;
        let v0 = YapCoderValidated{
            coder_id     : 0x2::object::id<YapCoder>(arg0),
            is_validated : true,
        };
        0x2::event::emit<YapCoderValidated>(v0);
    }

    // decompiled from Move bytecode v6
}

