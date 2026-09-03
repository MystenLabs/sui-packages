module 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::creator_prefs {
    struct PrefsRegistry has key {
        id: 0x2::object::UID,
        version: u64,
        prefs: 0x2::table::Table<address, Prefs>,
    }

    struct Prefs has copy, drop, store {
        profile_locked: bool,
        show_locked_previews: bool,
    }

    struct PrefsChanged has copy, drop {
        creator: address,
        profile_locked: bool,
        show_locked_previews: bool,
    }

    fun assert_version(arg0: &PrefsRegistry) {
        assert!(arg0.version == 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::current_version(), 0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PrefsRegistry{
            id      : 0x2::object::new(arg0),
            version : 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::current_version(),
            prefs   : 0x2::table::new<address, Prefs>(arg0),
        };
        0x2::transfer::share_object<PrefsRegistry>(v0);
    }

    public fun migrate(arg0: &mut PrefsRegistry, arg1: &0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::platform::FeeConfigCap) {
        assert!(arg0.version < 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::current_version(), 1);
        arg0.version = 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::current_version();
    }

    public fun prefs_of(arg0: &PrefsRegistry, arg1: address) : (bool, bool) {
        if (0x2::table::contains<address, Prefs>(&arg0.prefs, arg1)) {
            let v2 = 0x2::table::borrow<address, Prefs>(&arg0.prefs, arg1);
            (v2.profile_locked, v2.show_locked_previews)
        } else {
            (false, true)
        }
    }

    public fun set_prefs(arg0: &mut PrefsRegistry, arg1: bool, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        if (0x2::table::contains<address, Prefs>(&arg0.prefs, v0)) {
            0x2::table::remove<address, Prefs>(&mut arg0.prefs, v0);
        };
        let v1 = Prefs{
            profile_locked       : arg1,
            show_locked_previews : arg2,
        };
        0x2::table::add<address, Prefs>(&mut arg0.prefs, v0, v1);
        let v2 = PrefsChanged{
            creator              : v0,
            profile_locked       : arg1,
            show_locked_previews : arg2,
        };
        0x2::event::emit<PrefsChanged>(v2);
    }

    // decompiled from Move bytecode v7
}

