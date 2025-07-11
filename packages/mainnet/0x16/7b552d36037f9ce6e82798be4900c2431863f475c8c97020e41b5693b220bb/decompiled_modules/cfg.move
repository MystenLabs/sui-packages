module 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::cfg {
    struct Capability has store, key {
        id: 0x2::object::UID,
    }

    struct Settings has key {
        id: 0x2::object::UID,
        pfee: u64,
        bps: u64,
        a: 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::p::A,
    }

    public fun add(arg0: &mut Settings, arg1: &Capability, arg2: address, arg3: u128) {
        0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::p::add(&mut arg0.a, arg2, arg3);
    }

    public fun get_bps(arg0: &Settings) : u64 {
        arg0.bps
    }

    public fun get_p(arg0: &Settings) : u64 {
        arg0.pfee
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Capability{id: 0x2::object::new(arg0)};
        let v1 = Settings{
            id   : 0x2::object::new(arg0),
            pfee : 0,
            bps  : 400,
            a    : 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::p::new(arg0),
        };
        0x2::transfer::transfer<Capability>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Settings>(v1);
    }

    public fun remove(arg0: &mut Settings, arg1: &Capability, arg2: address) {
        0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::p::remove(&mut arg0.a, arg2);
    }

    public fun update_p(arg0: &mut Settings, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        valid_admin(arg0, 0x2::tx_context::sender(arg2));
        arg0.pfee = arg1;
    }

    public fun valid_admin(arg0: &Settings, arg1: address) {
        assert!(0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::p::has(&arg0.a, arg1, 1), 1003);
    }

    public fun valid_keeper_role(arg0: &Settings, arg1: address) {
        assert!(0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::p::has(&arg0.a, arg1, 0), 1001);
    }

    public fun valid_user(arg0: &Settings, arg1: address) {
        assert!(0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::p::has(&arg0.a, arg1, 2), 1004);
    }

    // decompiled from Move bytecode v6
}

