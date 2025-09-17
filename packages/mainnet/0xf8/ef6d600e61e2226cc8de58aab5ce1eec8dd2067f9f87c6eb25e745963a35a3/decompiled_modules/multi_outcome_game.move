module 0xf8ef6d600e61e2226cc8de58aab5ce1eec8dd2067f9f87c6eb25e745963a35a3::multi_outcome_game {
    struct Game has store, key {
        id: 0x2::object::UID,
        game_start_epoch: u64,
        stake: 0x2::balance::Balance<0x2::sui::SUI>,
        outcome_guess: u8,
        player: address,
        vrf_input: vector<u8>,
        fee_bp: u16,
        status: u8,
    }

    struct NewGame has copy, drop {
        game_id: 0x2::object::ID,
        player: address,
        vrf_input: vector<u8>,
        outcome_guess: u8,
        stake: u64,
    }

    struct Outcome has copy, drop {
        game_id: 0x2::object::ID,
        status: u8,
        result: u8,
        stake: u64,
        player: address,
        challenged: bool,
    }

    public fun challenge(arg0: &mut Game, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.player;
        assert!(0x2::tx_context::epoch(arg1) > arg0.game_start_epoch + 7, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.stake), arg1), v0);
        arg0.status = 2;
        let v1 = Outcome{
            game_id    : 0x2::object::uid_to_inner(&arg0.id),
            status     : 2,
            result     : 0,
            stake      : 0x2::balance::value<0x2::sui::SUI>(&arg0.stake),
            player     : v0,
            challenged : true,
        };
        0x2::event::emit<Outcome>(v1);
    }

    public fun finish_game(arg0: &mut Game, arg1: vector<u8>, arg2: &mut 0xf8ef6d600e61e2226cc8de58aab5ce1eec8dd2067f9f87c6eb25e745963a35a3::house_data::HouseData, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.player;
        let v1 = arg0.vrf_input;
        let v2 = 0xf8ef6d600e61e2226cc8de58aab5ce1eec8dd2067f9f87c6eb25e745963a35a3::house_data::public_key(arg2);
        let v3 = !0x2::bls12381::bls12381_min_pk_verify(&arg1, &v2, &v1);
        let v4 = get_outcome(arg1);
        0x2::balance::value<0x2::sui::SUI>(&arg0.stake);
        let v5 = 0x2::balance::value<0x2::sui::SUI>(&arg0.stake);
        let v6 = Outcome{
            game_id    : 0x2::object::uid_to_inner(&arg0.id),
            status     : arg0.status,
            result     : v4,
            stake      : v5,
            player     : v0,
            challenged : v3,
        };
        0x2::event::emit<Outcome>(v6);
        if (!v3) {
            arg0.status = 1;
            if (arg0.outcome_guess == v4 || v4 > 3) {
                let v7 = v5 * get_multiplier(v4);
                let v8 = v7 * (arg0.fee_bp as u64) / 10000;
                0x2::balance::join<0x2::sui::SUI>(0xf8ef6d600e61e2226cc8de58aab5ce1eec8dd2067f9f87c6eb25e745963a35a3::house_data::borrow_fees_mut(arg2), 0x2::balance::split<0x2::sui::SUI>(&mut arg0.stake, v8));
                0x2::balance::join<0x2::sui::SUI>(&mut arg0.stake, 0x2::balance::split<0x2::sui::SUI>(0xf8ef6d600e61e2226cc8de58aab5ce1eec8dd2067f9f87c6eb25e745963a35a3::house_data::borrow_balance_mut(arg2), v7 - v8));
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.stake), arg3), v0);
            } else {
                0x2::balance::join<0x2::sui::SUI>(0xf8ef6d600e61e2226cc8de58aab5ce1eec8dd2067f9f87c6eb25e745963a35a3::house_data::borrow_balance_mut(arg2), 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.stake));
            };
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.stake), arg3), v0);
        };
    }

    fun get_multiplier(arg0: u8) : u64 {
        if (arg0 == 1) {
            1
        } else if (arg0 == 2) {
            2
        } else if (arg0 == 3) {
            3
        } else if (arg0 == 4) {
            4
        } else if (arg0 == 5) {
            5
        } else {
            6
        }
    }

    fun get_outcome(arg0: vector<u8>) : u8 {
        let v0 = 0x2::hash::blake2b256(&arg0);
        *0x1::vector::borrow<u8>(&v0, 0) % 6 + 1
    }

    public fun map_guess(arg0: u8) : u8 {
        assert!(arg0 >= 1 && arg0 <= 6, 4);
        arg0
    }

    public fun start_game(arg0: u8, arg1: &mut 0xf8ef6d600e61e2226cc8de58aab5ce1eec8dd2067f9f87c6eb25e745963a35a3::counter_nft::Counter, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0xf8ef6d600e61e2226cc8de58aab5ce1eec8dd2067f9f87c6eb25e745963a35a3::house_data::HouseData, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = map_guess(arg0);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v1 >= 0xf8ef6d600e61e2226cc8de58aab5ce1eec8dd2067f9f87c6eb25e745963a35a3::house_data::min_stake(arg3), 0);
        assert!(v1 <= 0xf8ef6d600e61e2226cc8de58aab5ce1eec8dd2067f9f87c6eb25e745963a35a3::house_data::max_stake(arg3), 1);
        assert!(0xf8ef6d600e61e2226cc8de58aab5ce1eec8dd2067f9f87c6eb25e745963a35a3::house_data::balance(arg3) >= v1 * 5, 3);
        0xf8ef6d600e61e2226cc8de58aab5ce1eec8dd2067f9f87c6eb25e745963a35a3::counter_nft::increment(arg1);
        let v2 = 0xf8ef6d600e61e2226cc8de58aab5ce1eec8dd2067f9f87c6eb25e745963a35a3::counter_nft::get_vrf_input(arg1);
        let v3 = 0x2::object::new(arg4);
        let v4 = 0x2::object::uid_to_inner(&v3);
        let v5 = NewGame{
            game_id       : v4,
            player        : 0x2::tx_context::sender(arg4),
            vrf_input     : v2,
            outcome_guess : v0,
            stake         : v1,
        };
        0x2::event::emit<NewGame>(v5);
        let v6 = Game{
            id               : v3,
            game_start_epoch : 0x2::tx_context::epoch(arg4),
            stake            : 0x2::coin::into_balance<0x2::sui::SUI>(arg2),
            outcome_guess    : v0,
            player           : 0x2::tx_context::sender(arg4),
            vrf_input        : v2,
            fee_bp           : 0xf8ef6d600e61e2226cc8de58aab5ce1eec8dd2067f9f87c6eb25e745963a35a3::house_data::base_fee_in_bp(arg3),
            status           : 0,
        };
        0x2::transfer::share_object<Game>(v6);
        v4
    }

    // decompiled from Move bytecode v6
}

