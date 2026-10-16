module 0xd8a3f03367b0e975fa7a3c4ebfcf78abb5a6dd7bab4a97f2c3ecae9cd413fff5::control {
    struct Control has key {
        id: 0x2::object::UID,
        paused: bool,
        hot: address,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct PauseChanged has copy, drop {
        control: 0x2::object::ID,
        paused: bool,
        by: address,
    }

    struct HotChanged has copy, drop {
        control: 0x2::object::ID,
        hot: address,
    }

    public fun admin_pause(arg0: &AdminCap, arg1: &mut Control, arg2: &mut 0x2::tx_context::TxContext) {
        set_paused(arg1, true, 0x2::tx_context::sender(arg2));
    }

    public fun assert_live(arg0: &Control) {
        assert!(!arg0.paused, 7002);
    }

    public fun hot(arg0: &Control) : address {
        arg0.hot
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Control{
            id     : 0x2::object::new(arg0),
            paused : true,
            hot    : @0x0,
        };
        0x2::transfer::share_object<Control>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_paused(arg0: &Control) : bool {
        arg0.paused
    }

    public fun pause(arg0: &mut Control, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.hot, 7001);
        set_paused(arg0, true, 0x2::tx_context::sender(arg1));
    }

    public fun set_hot(arg0: &AdminCap, arg1: &mut Control, arg2: address) {
        arg1.hot = arg2;
        let v0 = HotChanged{
            control : 0x2::object::id<Control>(arg1),
            hot     : arg2,
        };
        0x2::event::emit<HotChanged>(v0);
    }

    fun set_paused(arg0: &mut Control, arg1: bool, arg2: address) {
        arg0.paused = arg1;
        let v0 = PauseChanged{
            control : 0x2::object::id<Control>(arg0),
            paused  : arg1,
            by      : arg2,
        };
        0x2::event::emit<PauseChanged>(v0);
    }

    public fun transfer_admin(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    public fun unpause(arg0: &AdminCap, arg1: &mut Control, arg2: &mut 0x2::tx_context::TxContext) {
        set_paused(arg1, false, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v7
}

