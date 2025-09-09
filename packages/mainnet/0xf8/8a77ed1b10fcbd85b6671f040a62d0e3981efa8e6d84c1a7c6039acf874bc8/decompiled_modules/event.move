module 0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::event {
    struct ManagerEvent has copy, drop {
        action: 0x1::string::String,
        log: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        bcs_padding: 0x2::vec_map::VecMap<0x1::string::String, vector<u8>>,
    }

    struct UserEvent has copy, drop {
        action: 0x1::string::String,
        log: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        bcs_padding: 0x2::vec_map::VecMap<0x1::string::String, vector<u8>>,
    }

    public fun emit_manager_event(arg0: 0x1::string::String, arg1: 0x2::vec_map::VecMap<0x1::string::String, u64>, arg2: 0x2::vec_map::VecMap<0x1::string::String, vector<u8>>) {
        let v0 = ManagerEvent{
            action      : arg0,
            log         : arg1,
            bcs_padding : arg2,
        };
        0x2::event::emit<ManagerEvent>(v0);
    }

    public fun emit_user_event(arg0: 0x1::string::String, arg1: 0x2::vec_map::VecMap<0x1::string::String, u64>, arg2: 0x2::vec_map::VecMap<0x1::string::String, vector<u8>>) {
        let v0 = UserEvent{
            action      : arg0,
            log         : arg1,
            bcs_padding : arg2,
        };
        0x2::event::emit<UserEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

