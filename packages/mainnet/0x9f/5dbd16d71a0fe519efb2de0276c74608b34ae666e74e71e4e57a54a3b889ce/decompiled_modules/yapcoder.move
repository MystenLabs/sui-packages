module 0x9f5dbd16d71a0fe519efb2de0276c74608b34ae666e74e71e4e57a54a3b889ce::yapcoder {
    struct YapCoder has store, key {
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

    public fun create_yap_coder(arg0: u64, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext, arg5: address, arg6: &AdminCap) {
        let v0 = YapCoder{
            id             : 0x2::object::new(arg4),
            github_user_id : arg0,
            repo_id        : arg1,
            username       : arg2,
            repo_name      : arg3,
            is_validated   : false,
        };
        let v1 = YapCoderCreated{
            coder_id       : 0x2::object::uid_to_inner(&v0.id),
            github_user_id : arg0,
            repo_id        : arg1,
            yapper         : arg5,
        };
        0x2::event::emit<YapCoderCreated>(v1);
        0x2::transfer::transfer<YapCoder>(v0, arg5);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
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

