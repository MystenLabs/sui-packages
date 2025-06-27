module 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned {
    struct GlobalPauseDfKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Versioned has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct Upgraded has copy, drop, store {
        previous_version: u64,
        new_version: u64,
    }

    struct Paused has copy, drop, store {
        sender: address,
    }

    struct Unpaused has copy, drop, store {
        sender: address,
    }

    public fun check_pause(arg0: &Versioned) {
        if (is_paused(arg0)) {
            abort 1001
        };
    }

    public fun check_version(arg0: &Versioned) {
        if (arg0.version != 4) {
            abort 999
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Versioned{
            id      : 0x2::object::new(arg0),
            version : 4,
        };
        0x2::transfer::share_object<Versioned>(v0);
    }

    public fun is_paused(arg0: &Versioned) : bool {
        let v0 = GlobalPauseDfKey{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<GlobalPauseDfKey, bool>(&arg0.id, v0)) {
            let v2 = GlobalPauseDfKey{dummy_field: false};
            *0x2::dynamic_field::borrow<GlobalPauseDfKey, bool>(&arg0.id, v2)
        } else {
            false
        }
    }

    public entry fun pause(arg0: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::admin_cap::AdminCap, arg1: &mut Versioned, arg2: &0x2::tx_context::TxContext) {
        check_version(arg1);
        let v0 = GlobalPauseDfKey{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<GlobalPauseDfKey, bool>(&arg1.id, v0)) {
            let v1 = GlobalPauseDfKey{dummy_field: false};
            let v2 = 0x2::dynamic_field::borrow_mut<GlobalPauseDfKey, bool>(&mut arg1.id, v1);
            assert!(*v2 == false, 1001);
            *v2 = true;
        } else {
            let v3 = GlobalPauseDfKey{dummy_field: false};
            0x2::dynamic_field::add<GlobalPauseDfKey, bool>(&mut arg1.id, v3, true);
        };
        let v4 = Paused{sender: 0x2::tx_context::sender(arg2)};
        0x2::event::emit<Paused>(v4);
    }

    fun ugrade_internal(arg0: &mut Versioned) {
        let v0 = Upgraded{
            previous_version : arg0.version,
            new_version      : 4,
        };
        0x2::event::emit<Upgraded>(v0);
        arg0.version = 4;
    }

    public entry fun unpause(arg0: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::admin_cap::AdminCap, arg1: &mut Versioned, arg2: &0x2::tx_context::TxContext) {
        check_version(arg1);
        let v0 = GlobalPauseDfKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<GlobalPauseDfKey, bool>(&arg1.id, v0), 1002);
        let v1 = GlobalPauseDfKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<GlobalPauseDfKey, bool>(&mut arg1.id, v1);
        assert!(*v2 == true, 1002);
        *v2 = false;
        let v3 = Unpaused{sender: 0x2::tx_context::sender(arg2)};
        0x2::event::emit<Unpaused>(v3);
    }

    public fun upgrade(arg0: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::admin_cap::AdminCap, arg1: &mut Versioned) {
        assert!(arg1.version < 4, 1000);
        ugrade_internal(arg1);
    }

    // decompiled from Move bytecode v6
}

