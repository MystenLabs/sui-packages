module 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::pause {
    struct Pause has key {
        id: 0x2::object::UID,
        owner: address,
        pending_owner: address,
        paused: bool,
        version: u64,
    }

    public entry fun accept_owner(arg0: &mut Pause, arg1: &0x2::tx_context::TxContext) {
        validate_code_version(arg0);
        assert!(arg0.pending_owner != @0x0, 1001);
        assert!(arg0.pending_owner == 0x2::tx_context::sender(arg1), 1002);
        arg0.owner = arg0.pending_owner;
        arg0.pending_owner = @0x0;
    }

    public entry fun change_owner(arg0: &mut Pause, arg1: address, arg2: &0x2::tx_context::TxContext) {
        validate_code_version(arg0);
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 1000);
        arg0.pending_owner = arg1;
    }

    public fun ensure_not_paused(arg0: &Pause) {
        validate_code_version(arg0);
        assert!(!arg0.paused, 1003);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pause{
            id            : 0x2::object::new(arg0),
            owner         : @0xe2c2c7404f74200e1bd7e6db8063bda76068705c02ff76347375cd0e20482c2,
            pending_owner : @0x0,
            paused        : false,
            version       : 0,
        };
        0x2::transfer::share_object<Pause>(v0);
    }

    public entry fun set_paused(arg0: &mut Pause, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        validate_code_version(arg0);
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 1000);
        arg0.paused = arg1;
    }

    public entry fun upgrade_version(arg0: &mut Pause, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 1000);
        assert!(arg0.version < 0, 1004);
        arg0.version = 0;
    }

    fun validate_code_version(arg0: &Pause) {
        assert!(arg0.version == 0, 1005);
    }

    // decompiled from Move bytecode v6
}

