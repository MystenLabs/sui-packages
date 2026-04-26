module 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::emergency {
    struct EmergencyStatus has store, key {
        id: 0x2::object::UID,
        pause: bool,
    }

    struct EmergencyAdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun assert_no_emergency(arg0: &EmergencyStatus) {
        assert!(!is_emergency(arg0), 2);
    }

    public(friend) fun initialize(arg0: &mut 0x2::tx_context::TxContext) : EmergencyStatus {
        let v0 = EmergencyAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<EmergencyAdminCap>(v0, 0x2::tx_context::sender(arg0));
        EmergencyStatus{
            id    : 0x2::object::new(arg0),
            pause : false,
        }
    }

    public fun is_emergency(arg0: &EmergencyStatus) : bool {
        arg0.pause
    }

    public entry fun pause(arg0: &EmergencyAdminCap, arg1: &mut EmergencyStatus) {
        assert_no_emergency(arg1);
        arg1.pause = true;
    }

    public entry fun resume(arg0: &EmergencyAdminCap, arg1: &mut EmergencyStatus) {
        assert!(is_emergency(arg1), 3);
        arg1.pause = false;
    }

    // decompiled from Move bytecode v6
}

