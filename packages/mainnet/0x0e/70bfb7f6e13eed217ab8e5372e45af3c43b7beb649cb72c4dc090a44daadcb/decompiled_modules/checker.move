module 0xe70bfb7f6e13eed217ab8e5372e45af3c43b7beb649cb72c4dc090a44daadcb::checker {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        threshold: u64,
    }

    public fun check_if_profit<T0>(arg0: &Config, arg1: &0x2::coin::Coin<T0>) {
        assert!(0x2::coin::value<T0>(arg1) >= arg0.threshold, 1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id        : 0x2::object::new(arg0),
            threshold : 0,
        };
        0x2::transfer::share_object<Config>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun set_threshold(arg0: &mut Config, arg1: u64) {
        arg0.threshold = arg1;
    }

    // decompiled from Move bytecode v6
}

