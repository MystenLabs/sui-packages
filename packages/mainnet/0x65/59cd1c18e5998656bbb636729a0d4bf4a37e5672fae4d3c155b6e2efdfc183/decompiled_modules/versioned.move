module 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned {
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
        if (arg0.version != 3) {
            abort 999
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Versioned{
            id      : 0x2::object::new(arg0),
            version : 3,
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

    public entry fun pause(arg0: &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::admin_cap::AdminCap, arg1: &mut Versioned, arg2: &0x2::tx_context::TxContext) {
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

    public entry fun unpause(arg0: &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::admin_cap::AdminCap, arg1: &mut Versioned, arg2: &0x2::tx_context::TxContext) {
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

    public entry fun upgrade(arg0: &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::admin_cap::AdminCap, arg1: &mut Versioned) {
        assert!(arg1.version < 3, 1000);
        upgrade_internal(arg1);
    }

    fun upgrade_internal(arg0: &mut Versioned) {
        let v0 = Upgraded{
            previous_version : arg0.version,
            new_version      : 3,
        };
        0x2::event::emit<Upgraded>(v0);
        arg0.version = 3;
    }

    // decompiled from Move bytecode v6
}

