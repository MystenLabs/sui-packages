module 0xa6b953eb3494eed075b4ea23386137a59f138e929bfef82fd98cfebe0587ccce::boosting {
    struct PaidEvent has copy, drop {
        coin_id: 0x1::type_name::TypeName,
        address: address,
        point: u64,
        duration: u64,
        amount: u64,
    }

    public fun pay<T0>(arg0: &0xa6b953eb3494eed075b4ea23386137a59f138e929bfef82fd98cfebe0587ccce::config::Config, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa6b953eb3494eed075b4ea23386137a59f138e929bfef82fd98cfebe0587ccce::config::get_tier(arg0, arg1);
        let v1 = 0xa6b953eb3494eed075b4ea23386137a59f138e929bfef82fd98cfebe0587ccce::config::get_tier_amount(&v0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v1, 201);
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, 0x2::coin::value<0x2::sui::SUI>(&arg2) - v1, arg3), 0x2::tx_context::sender(arg3));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0xa6b953eb3494eed075b4ea23386137a59f138e929bfef82fd98cfebe0587ccce::config::get_fee_receiver(arg0));
        let v2 = PaidEvent{
            coin_id  : 0x1::type_name::with_original_ids<T0>(),
            address  : 0x2::tx_context::sender(arg3),
            point    : 0xa6b953eb3494eed075b4ea23386137a59f138e929bfef82fd98cfebe0587ccce::config::get_tier_point(&v0),
            duration : 0xa6b953eb3494eed075b4ea23386137a59f138e929bfef82fd98cfebe0587ccce::config::get_tier_duration(&v0),
            amount   : v1,
        };
        0x2::event::emit<PaidEvent>(v2);
    }

    public fun pay_with_admin<T0>(arg0: &0xa6b953eb3494eed075b4ea23386137a59f138e929bfef82fd98cfebe0587ccce::admin::AdminCap, arg1: &0xa6b953eb3494eed075b4ea23386137a59f138e929bfef82fd98cfebe0587ccce::config::Config, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa6b953eb3494eed075b4ea23386137a59f138e929bfef82fd98cfebe0587ccce::config::get_tier(arg1, arg2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= arg3, 201);
        if (0x2::coin::value<0x2::sui::SUI>(&arg4) > arg3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, 0x2::coin::value<0x2::sui::SUI>(&arg4) - arg3, arg5), 0x2::tx_context::sender(arg5));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, 0xa6b953eb3494eed075b4ea23386137a59f138e929bfef82fd98cfebe0587ccce::config::get_fee_receiver(arg1));
        let v1 = PaidEvent{
            coin_id  : 0x1::type_name::with_original_ids<T0>(),
            address  : 0x2::tx_context::sender(arg5),
            point    : 0xa6b953eb3494eed075b4ea23386137a59f138e929bfef82fd98cfebe0587ccce::config::get_tier_point(&v0),
            duration : 0xa6b953eb3494eed075b4ea23386137a59f138e929bfef82fd98cfebe0587ccce::config::get_tier_duration(&v0),
            amount   : arg3,
        };
        0x2::event::emit<PaidEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

