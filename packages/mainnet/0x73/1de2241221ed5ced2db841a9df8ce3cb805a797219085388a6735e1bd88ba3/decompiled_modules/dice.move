module 0xde11c0d5b2b28ca3ade6f1aa3c345a7d6fe7ba74a198f11f284525920be90eb6::dice {
    struct DiceGame<phantom T0> has key {
        id: 0x2::object::UID,
        min_bet: u64,
        max_bet: u64,
        min_bet_threshold: u64,
        max_number_of_dices: u8,
        min_rtp: 0x1::uq32_32::UQ32_32,
        max_rtp: 0x1::uq32_32::UQ32_32,
        bets: 0x2::vec_map::VecMap<0x2::object::ID, Bet<T0>>,
    }

    struct Bet<phantom T0> has store, key {
        id: 0x2::object::UID,
        gambler: address,
        bet_threshold: u64,
        roll_under: bool,
        number_of_dices: u8,
        total_stake_value: u64,
        fund: 0x2::balance::Balance<T0>,
    }

    public fun bet<T0>(arg0: &mut DiceGame<T0>, arg1: &mut 0xde11c0d5b2b28ca3ade6f1aa3c345a7d6fe7ba74a198f11f284525920be90eb6::vault::Vault<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: bool, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        place_bet<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    entry fun bet_and_reveal_onchain_randomness<T0>(arg0: &mut DiceGame<T0>, arg1: &mut 0xde11c0d5b2b28ca3ade6f1aa3c345a7d6fe7ba74a198f11f284525920be90eb6::vault::Vault<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: bool, arg5: u8, arg6: &0x2::random::Random, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = place_bet<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg7);
        reveal_bet<T0>(arg0, arg1, v0, arg6, arg7);
    }

    public fun create_dice_game<T0>(arg0: &0xde11c0d5b2b28ca3ade6f1aa3c345a7d6fe7ba74a198f11f284525920be90eb6::vault::AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = DiceGame<T0>{
            id                  : 0x2::object::new(arg5),
            min_bet             : arg1,
            max_bet             : arg2,
            min_bet_threshold   : arg3,
            max_number_of_dices : arg4,
            min_rtp             : 0x1::uq32_32::from_quotient(95, 100),
            max_rtp             : 0x1::uq32_32::from_quotient(98, 100),
            bets                : 0x2::vec_map::empty<0x2::object::ID, Bet<T0>>(),
        };
        0x2::transfer::share_object<DiceGame<T0>>(v0);
    }

    public fun edit_dice_game<T0>(arg0: &0xde11c0d5b2b28ca3ade6f1aa3c345a7d6fe7ba74a198f11f284525920be90eb6::vault::AdminCap, arg1: &mut DiceGame<T0>, arg2: u64, arg3: u64, arg4: u8) {
        arg1.max_bet = arg2;
        arg1.min_bet_threshold = arg3;
        arg1.min_rtp = 0x1::uq32_32::from_quotient(95, 100);
        arg1.max_rtp = 0x1::uq32_32::from_quotient(98, 100);
        arg1.max_number_of_dices = arg4;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DiceGame<0x2::sui::SUI>{
            id                  : 0x2::object::new(arg0),
            min_bet             : 100000000,
            max_bet             : 50000000000,
            min_bet_threshold   : 6000000,
            max_number_of_dices : 10,
            min_rtp             : 0x1::uq32_32::from_quotient(95, 100),
            max_rtp             : 0x1::uq32_32::from_quotient(98, 100),
            bets                : 0x2::vec_map::empty<0x2::object::ID, Bet<0x2::sui::SUI>>(),
        };
        0x2::transfer::share_object<DiceGame<0x2::sui::SUI>>(v0);
    }

    fun place_bet<T0>(arg0: &mut DiceGame<T0>, arg1: &mut 0xde11c0d5b2b28ca3ade6f1aa3c345a7d6fe7ba74a198f11f284525920be90eb6::vault::Vault<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: bool, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(arg5 <= arg0.max_number_of_dices, 6);
        let v1 = v0 / (arg5 as u64);
        assert!(v1 <= arg0.max_bet, 4);
        assert!(v1 >= arg0.min_bet, 4);
        assert!(arg3 >= 0, 7);
        assert!(arg3 <= 100, 7);
        if (arg4) {
        };
        0xde11c0d5b2b28ca3ade6f1aa3c345a7d6fe7ba74a198f11f284525920be90eb6::vault::deposit<T0>(arg1, arg2);
        let v2 = Bet<T0>{
            id                : 0x2::object::new(arg6),
            gambler           : 0x2::tx_context::sender(arg6),
            bet_threshold     : arg3,
            roll_under        : arg4,
            number_of_dices   : arg5,
            total_stake_value : v0,
            fund              : 0xde11c0d5b2b28ca3ade6f1aa3c345a7d6fe7ba74a198f11f284525920be90eb6::vault::take_fund_balance<T0>(arg1, v0 * 100 / arg3),
        };
        0xde11c0d5b2b28ca3ade6f1aa3c345a7d6fe7ba74a198f11f284525920be90eb6::vault::distribute_referral_rewards<T0>(arg1, v0, 0x2::tx_context::sender(arg6));
        0xde11c0d5b2b28ca3ade6f1aa3c345a7d6fe7ba74a198f11f284525920be90eb6::events::emit_dice_bet_event(0x2::object::uid_to_inner(&v2.id), v0, arg3, arg4, arg5, 0x2::tx_context::sender(arg6), 0x1::type_name::into_string(0x1::type_name::get<T0>()));
        let v3 = 0x2::object::uid_to_inner(&v2.id);
        0x2::vec_map::insert<0x2::object::ID, Bet<T0>>(&mut arg0.bets, v3, v2);
        v3
    }

    fun reveal_bet<T0>(arg0: &mut DiceGame<T0>, arg1: &mut 0xde11c0d5b2b28ca3ade6f1aa3c345a7d6fe7ba74a198f11f284525920be90eb6::vault::Vault<T0>, arg2: 0x2::object::ID, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_map::contains<0x2::object::ID, Bet<T0>>(&arg0.bets, &arg2), 5);
        let (_, v1) = 0x2::vec_map::remove<0x2::object::ID, Bet<T0>>(&mut arg0.bets, &arg2);
        let Bet {
            id                : v2,
            gambler           : v3,
            bet_threshold     : v4,
            roll_under        : v5,
            number_of_dices   : v6,
            total_stake_value : v7,
            fund              : v8,
        } = v1;
        let v9 = v8;
        let v10 = 0x2::random::new_generator(arg3, arg4);
        let v11 = 0;
        let v12 = 0x1::vector::empty<u64>();
        let v13 = 0x1::vector::empty<bool>();
        let v14 = 0x1::vector::empty<u64>();
        let v15 = v7 / (v6 as u64);
        let v16 = 0;
        while (v16 < v6) {
            let v17 = 0x2::random::generate_u64_in_range(&mut v10, 0, 100000000);
            let (v18, v19) = if (v5 && v17 >= 1000000 * (100 - v4)) {
                (0x2::balance::value<T0>(&v9) / (v6 as u64), true)
            } else {
                (0, false)
            };
            0x1::vector::push_back<u64>(&mut v12, v18);
            0x1::vector::push_back<bool>(&mut v13, v19);
            0x1::vector::push_back<u64>(&mut v14, v17);
            v11 = v11 + v18;
            v16 = v16 + 1;
        };
        let v20 = 0x2::coin::from_balance<T0>(v9, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v20, v11, arg4), v3);
        0xde11c0d5b2b28ca3ade6f1aa3c345a7d6fe7ba74a198f11f284525920be90eb6::vault::deposit<T0>(arg1, v20);
        while (0x1::vector::length<u64>(&v12) > 0) {
            let v21 = 0x1::vector::pop_back<u64>(&mut v12);
            let (v22, v23) = if (0x1::vector::pop_back<bool>(&mut v13)) {
                (0x1::uq32_32::from_quotient(v21, v15), true)
            } else {
                (0x1::uq32_32::from_int(0), false)
            };
            0xde11c0d5b2b28ca3ade6f1aa3c345a7d6fe7ba74a198f11f284525920be90eb6::events::emit_revealed_dice_bet_event(arg2, v23, v15, v22, v4, v5, 0x1::vector::pop_back<u64>(&mut v14), v21, v3, 0x1::type_name::into_string(0x1::type_name::get<T0>()));
        };
        0x2::object::delete(v2);
    }

    entry fun reveal_bet_onchain_randomness<T0>(arg0: &mut DiceGame<T0>, arg1: &mut 0xde11c0d5b2b28ca3ade6f1aa3c345a7d6fe7ba74a198f11f284525920be90eb6::vault::Vault<T0>, arg2: 0x2::object::ID, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        reveal_bet<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

