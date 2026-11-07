module 0xdfbee49d7a160da68034d7a0e85fe181bab07a20184d916b75a3a19c233497b1::pvp_battle {
    struct Challenge has key {
        id: 0x2::object::UID,
        challenger: address,
        opponent: address,
        extra_wager_mist: u64,
        challenger_extra_stake: 0x2::balance::Balance<0x2::sui::SUI>,
        challenger_miner: 0xc5bee5493cc8e161aa4f6d37b2ac650c7120f568a56b9e9fac59ce61ddb22f6::sui_miner::SuiMiner,
    }

    struct ChallengeCreated has copy, drop {
        challenge_id: 0x2::object::ID,
        challenger: address,
        opponent: address,
        extra_wager_mist: u64,
    }

    struct ChallengeWithdrawn has copy, drop {
        challenge_id: 0x2::object::ID,
    }

    struct PvpResolved has copy, drop {
        challenger: address,
        opponent: address,
        winner: address,
        jackpot: bool,
        extra_wager_mist: u64,
    }

    entry fun accept_challenge(arg0: Challenge, arg1: 0xc5bee5493cc8e161aa4f6d37b2ac650c7120f568a56b9e9fac59ce61ddb22f6::sui_miner::SuiMiner, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        let Challenge {
            id                     : v0,
            challenger             : v1,
            opponent               : v2,
            extra_wager_mist       : v3,
            challenger_extra_stake : v4,
            challenger_miner       : v5,
        } = arg0;
        assert!(0x2::tx_context::sender(arg5) == v2, 4);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == 1000000000, 0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == v3, 1);
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, @0x186807ccacbeba45fcbaa234d314536b715f38a91d7ba7dbdc1dca669111db88);
        let v6 = v4;
        0x2::balance::join<0x2::sui::SUI>(&mut v6, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        let v7 = 0x2::random::new_generator(arg4, arg5);
        let v8 = 0x2::random::generate_u32_in_range(&mut v7, 0, 9999);
        let v9 = v8 < 100;
        let v10 = !v9 && v8 % 2 == 0;
        let v11 = if (v9) {
            @0x186807ccacbeba45fcbaa234d314536b715f38a91d7ba7dbdc1dca669111db88
        } else if (v10) {
            v1
        } else {
            v2
        };
        0x2::transfer::public_transfer<0xc5bee5493cc8e161aa4f6d37b2ac650c7120f568a56b9e9fac59ce61ddb22f6::sui_miner::SuiMiner>(v5, v11);
        0x2::transfer::public_transfer<0xc5bee5493cc8e161aa4f6d37b2ac650c7120f568a56b9e9fac59ce61ddb22f6::sui_miner::SuiMiner>(arg1, v11);
        if (0x2::balance::value<0x2::sui::SUI>(&v6) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v6, arg5), v11);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v6);
        };
        let v12 = PvpResolved{
            challenger       : v1,
            opponent         : v2,
            winner           : v11,
            jackpot          : v9,
            extra_wager_mist : v3,
        };
        0x2::event::emit<PvpResolved>(v12);
    }

    public fun create_challenge(arg0: address, arg1: 0xc5bee5493cc8e161aa4f6d37b2ac650c7120f568a56b9e9fac59ce61ddb22f6::sui_miner::SuiMiner, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg0 != v0, 3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == 1000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, @0x186807ccacbeba45fcbaa234d314536b715f38a91d7ba7dbdc1dca669111db88);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        let v2 = Challenge{
            id                     : 0x2::object::new(arg4),
            challenger             : v0,
            opponent               : arg0,
            extra_wager_mist       : v1,
            challenger_extra_stake : 0x2::coin::into_balance<0x2::sui::SUI>(arg3),
            challenger_miner       : arg1,
        };
        let v3 = ChallengeCreated{
            challenge_id     : 0x2::object::id<Challenge>(&v2),
            challenger       : v0,
            opponent         : arg0,
            extra_wager_mist : v1,
        };
        0x2::event::emit<ChallengeCreated>(v3);
        0x2::transfer::share_object<Challenge>(v2);
    }

    public fun withdraw_challenge(arg0: Challenge, arg1: &mut 0x2::tx_context::TxContext) {
        let Challenge {
            id                     : v0,
            challenger             : v1,
            opponent               : v2,
            extra_wager_mist       : _,
            challenger_extra_stake : v4,
            challenger_miner       : v5,
        } = arg0;
        let v6 = v4;
        let v7 = v0;
        let v8 = 0x2::tx_context::sender(arg1);
        assert!(v8 == v1 || v8 == v2, 2);
        0x2::object::delete(v7);
        if (0x2::balance::value<0x2::sui::SUI>(&v6) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v6, arg1), v1);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v6);
        };
        0x2::transfer::public_transfer<0xc5bee5493cc8e161aa4f6d37b2ac650c7120f568a56b9e9fac59ce61ddb22f6::sui_miner::SuiMiner>(v5, v1);
        let v9 = ChallengeWithdrawn{challenge_id: 0x2::object::uid_to_inner(&v7)};
        0x2::event::emit<ChallengeWithdrawn>(v9);
    }

    // decompiled from Move bytecode v7
}

