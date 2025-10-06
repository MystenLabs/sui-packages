module 0xd674d54881a1856ff29b303283345032cd63f0f140979865dc9602daf36416b7::boosting {
    struct PaidEvent has copy, drop {
        coin_id: 0x1::type_name::TypeName,
        address: address,
        duration: u64,
        amount: u64,
    }

    public fun pay<T0>(arg0: &0xd674d54881a1856ff29b303283345032cd63f0f140979865dc9602daf36416b7::config::Config, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd674d54881a1856ff29b303283345032cd63f0f140979865dc9602daf36416b7::config::get_tier(arg0, arg1);
        let v1 = 0xd674d54881a1856ff29b303283345032cd63f0f140979865dc9602daf36416b7::config::get_tier_amount(&v0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v1, 201);
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, 0x2::coin::value<0x2::sui::SUI>(&arg2) - v1, arg3), 0x2::tx_context::sender(arg3));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0xd674d54881a1856ff29b303283345032cd63f0f140979865dc9602daf36416b7::config::get_fee_receiver(arg0));
        let v2 = PaidEvent{
            coin_id  : 0x1::type_name::with_original_ids<T0>(),
            address  : 0x2::tx_context::sender(arg3),
            duration : 0xd674d54881a1856ff29b303283345032cd63f0f140979865dc9602daf36416b7::config::get_tier_duration(&v0),
            amount   : v1,
        };
        0x2::event::emit<PaidEvent>(v2);
    }

    public fun pay_with_admin<T0>(arg0: &0xd674d54881a1856ff29b303283345032cd63f0f140979865dc9602daf36416b7::admin::AdminCap, arg1: &0xd674d54881a1856ff29b303283345032cd63f0f140979865dc9602daf36416b7::config::Config, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd674d54881a1856ff29b303283345032cd63f0f140979865dc9602daf36416b7::config::get_tier(arg1, arg2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= arg3, 201);
        if (0x2::coin::value<0x2::sui::SUI>(&arg4) > arg3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, 0x2::coin::value<0x2::sui::SUI>(&arg4) - arg3, arg5), 0x2::tx_context::sender(arg5));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, 0xd674d54881a1856ff29b303283345032cd63f0f140979865dc9602daf36416b7::config::get_fee_receiver(arg1));
        let v1 = PaidEvent{
            coin_id  : 0x1::type_name::with_original_ids<T0>(),
            address  : 0x2::tx_context::sender(arg5),
            duration : 0xd674d54881a1856ff29b303283345032cd63f0f140979865dc9602daf36416b7::config::get_tier_duration(&v0),
            amount   : arg3,
        };
        0x2::event::emit<PaidEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

