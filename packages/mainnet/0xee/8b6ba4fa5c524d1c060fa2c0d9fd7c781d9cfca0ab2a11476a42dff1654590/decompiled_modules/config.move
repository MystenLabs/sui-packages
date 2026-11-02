module 0xee8b6ba4fa5c524d1c060fa2c0d9fd7c781d9cfca0ab2a11476a42dff1654590::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        recipient: address,
        paused: bool,
    }

    public fun assert_active(arg0: &Config) {
        assert!(!arg0.paused, 1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Config{
            id        : 0x2::object::new(arg0),
            recipient : 0x2::tx_context::sender(arg0),
            paused    : false,
        };
        0x2::transfer::share_object<Config>(v1);
    }

    public fun paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun recipient(arg0: &Config) : address {
        arg0.recipient
    }

    public fun set_paused(arg0: &mut Config, arg1: &AdminCap, arg2: bool) {
        arg0.paused = arg2;
    }

    public fun set_recipient(arg0: &mut Config, arg1: &AdminCap, arg2: address) {
        assert!(arg2 != @0x0, 2);
        arg0.recipient = arg2;
    }

    // decompiled from Move bytecode v7
}

