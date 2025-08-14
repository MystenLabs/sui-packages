module 0x1e6a8e5f9c271f50cc62151ae995344f42304827ace685649a19747e088893b0::lemonjet {
    struct Outcome has copy, drop {
        address: address,
        payout: u64,
        random_number: u64,
        x: u64,
    }

    fun calc_threshold(arg0: u64) : u64 {
        9900000 / arg0
    }

    fun calc_winner_payout(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 100) as u64)
    }

    fun calc_x(arg0: u64) : u64 {
        9900000 / arg0
    }

    fun generate_random_number(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        0x2::random::generate_u64_in_range(&mut v0, 1, 100000)
    }

    fun is_player_won(arg0: u64, arg1: u64) : bool {
        arg0 <= arg1
    }

    fun play<T0>(arg0: &0x2::random::Random, arg1: &0x1e6a8e5f9c271f50cc62151ae995344f42304827ace685649a19747e088893b0::player::Player, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x1e6a8e5f9c271f50cc62151ae995344f42304827ace685649a19747e088893b0::vault::Vault<T0>, arg5: &mut 0x2::tx_context::TxContext) : Outcome {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 >= 1000, 1);
        assert!(arg3 >= 101 && arg3 <= 500000, 2);
        assert!(calc_winner_payout(v0, arg3) <= 0x1e6a8e5f9c271f50cc62151ae995344f42304827ace685649a19747e088893b0::vault::max_payout<T0>(arg4), 3);
        let v1 = 0x2::coin::value<T0>(&arg2) / 100;
        0x1e6a8e5f9c271f50cc62151ae995344f42304827ace685649a19747e088893b0::vault::mint_and_deposit<T0>(arg4, v1 * 20 / 100, @0x0);
        let v2 = 0x1e6a8e5f9c271f50cc62151ae995344f42304827ace685649a19747e088893b0::player::referrer(arg1);
        if (0x1::option::is_some<address>(v2)) {
            0x1e6a8e5f9c271f50cc62151ae995344f42304827ace685649a19747e088893b0::vault::mint_and_deposit<T0>(arg4, v1 * 30 / 100, *0x1::option::borrow<address>(v2));
        };
        0x1e6a8e5f9c271f50cc62151ae995344f42304827ace685649a19747e088893b0::vault::add<T0>(arg4, arg2);
        let v3 = generate_random_number(arg0, arg5);
        let v4 = if (is_player_won(v3, calc_threshold(arg3))) {
            let v5 = calc_winner_payout(v0, arg3);
            0x1e6a8e5f9c271f50cc62151ae995344f42304827ace685649a19747e088893b0::vault::payout<T0>(arg4, v5, arg5);
            v5
        } else {
            0
        };
        let v6 = Outcome{
            address       : 0x2::tx_context::sender(arg5),
            payout        : v4,
            random_number : v3,
            x             : calc_x(v3),
        };
        0x2::event::emit<Outcome>(v6);
        v6
    }

    entry fun playAndEarnPointsWithRef<T0>(arg0: &0x2::random::Random, arg1: &0x2::clock::Clock, arg2: &0x1e6a8e5f9c271f50cc62151ae995344f42304827ace685649a19747e088893b0::player::Player, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &mut 0x1e6a8e5f9c271f50cc62151ae995344f42304827ace685649a19747e088893b0::points::Volume<T0>, arg6: &mut 0x1e6a8e5f9c271f50cc62151ae995344f42304827ace685649a19747e088893b0::points::TotalVolume<T0>, arg7: &mut 0x1e6a8e5f9c271f50cc62151ae995344f42304827ace685649a19747e088893b0::vault::Vault<T0>, arg8: &mut 0x1e6a8e5f9c271f50cc62151ae995344f42304827ace685649a19747e088893b0::points::VolumeRewardRegistry<T0>, arg9: &mut 0x2::tx_context::TxContext) : Outcome {
        0x1e6a8e5f9c271f50cc62151ae995344f42304827ace685649a19747e088893b0::points::add_ref<T0>(&arg3, arg2, arg6, arg8, arg9);
        play_and_earn_points<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9)
    }

    entry fun playAndEarnPointsWithoutRef<T0>(arg0: &0x2::random::Random, arg1: &0x2::clock::Clock, arg2: &0x1e6a8e5f9c271f50cc62151ae995344f42304827ace685649a19747e088893b0::player::Player, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &mut 0x1e6a8e5f9c271f50cc62151ae995344f42304827ace685649a19747e088893b0::points::Volume<T0>, arg6: &mut 0x1e6a8e5f9c271f50cc62151ae995344f42304827ace685649a19747e088893b0::points::TotalVolume<T0>, arg7: &mut 0x1e6a8e5f9c271f50cc62151ae995344f42304827ace685649a19747e088893b0::vault::Vault<T0>, arg8: &mut 0x2::tx_context::TxContext) : Outcome {
        assert!(0x1::option::is_none<address>(0x1e6a8e5f9c271f50cc62151ae995344f42304827ace685649a19747e088893b0::player::referrer(arg2)), 5);
        play_and_earn_points<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    fun play_and_earn_points<T0>(arg0: &0x2::random::Random, arg1: &0x2::clock::Clock, arg2: &0x1e6a8e5f9c271f50cc62151ae995344f42304827ace685649a19747e088893b0::player::Player, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &mut 0x1e6a8e5f9c271f50cc62151ae995344f42304827ace685649a19747e088893b0::points::Volume<T0>, arg6: &mut 0x1e6a8e5f9c271f50cc62151ae995344f42304827ace685649a19747e088893b0::points::TotalVolume<T0>, arg7: &mut 0x1e6a8e5f9c271f50cc62151ae995344f42304827ace685649a19747e088893b0::vault::Vault<T0>, arg8: &mut 0x2::tx_context::TxContext) : Outcome {
        assert!(!0x1e6a8e5f9c271f50cc62151ae995344f42304827ace685649a19747e088893b0::points::is_completed<T0>(arg6, arg1), 4);
        0x1e6a8e5f9c271f50cc62151ae995344f42304827ace685649a19747e088893b0::points::add<T0>(&arg3, arg6, arg5);
        play<T0>(arg0, arg2, arg3, arg4, arg7, arg8)
    }

    // decompiled from Move bytecode v6
}

