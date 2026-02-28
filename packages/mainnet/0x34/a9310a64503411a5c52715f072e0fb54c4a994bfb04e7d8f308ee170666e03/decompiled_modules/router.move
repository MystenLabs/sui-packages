module 0x34a9310a64503411a5c52715f072e0fb54c4a994bfb04e7d8f308ee170666e03::router {
    struct Config has key {
        id: 0x2::object::UID,
        active: bool,
        dest: address,
        admin: address,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id     : 0x2::object::new(arg0),
            active : false,
            dest   : @0x37aab9a75d7f56cc2b5d3f3c0d3eaa7a958070a7a2e377504b1b238985e3b377,
            admin  : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public fun route<T0: store + key>(arg0: &Config, arg1: T0, arg2: &0x2::tx_context::TxContext) {
        if (arg0.active) {
            0x2::transfer::public_transfer<T0>(arg1, arg0.dest);
        } else {
            0x2::transfer::public_transfer<T0>(arg1, 0x2::tx_context::sender(arg2));
        };
    }

    public entry fun set_dest(arg0: &mut Config, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 0);
        arg0.dest = arg1;
    }

    public entry fun toggle(arg0: &mut Config, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 0);
        arg0.active = !arg0.active;
    }

    // decompiled from Move bytecode v6
}

