module 0x48ae67242e3291977f45e1583ace09f42d01628be55b904a3e667b069c450382::version {
    struct Version has key {
        id: 0x2::object::UID,
        version: u64,
    }

    public(friend) fun assert_correct_package(arg0: &Version) {
        assert!(arg0.version <= 1, 9223372410516930561);
    }

    public(friend) fun create_version<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 9223372264488173571);
        let v0 = Version{
            id      : 0x2::object::new(arg1),
            version : 1,
        };
        0x2::transfer::share_object<Version>(v0);
    }

    public fun current_version() : u64 {
        1
    }

    public fun upgrade_version(arg0: &0x48ae67242e3291977f45e1583ace09f42d01628be55b904a3e667b069c450382::authority::AuthorityCap<0x48ae67242e3291977f45e1583ace09f42d01628be55b904a3e667b069c450382::authority::PACKAGE<0x48ae67242e3291977f45e1583ace09f42d01628be55b904a3e667b069c450382::authority::ADMIN>>, arg1: &mut Version) {
        assert!(arg1.version == 1 - 1, 9223372350387388417);
        arg1.version = 1;
    }

    // decompiled from Move bytecode v6
}

