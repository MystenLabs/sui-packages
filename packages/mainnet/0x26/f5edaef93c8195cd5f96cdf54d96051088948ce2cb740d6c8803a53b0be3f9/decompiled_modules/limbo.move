module 0xbca3313d753bba2e3b3d911d2306c5024de99dfdb2fc456850186b18867ac36c::limbo {
    struct Limbo has copy, drop, store {
        dummy_field: bool,
    }

    struct LimboResult<phantom T0> has copy, drop {
        bet_size: u64,
        bet_returned: u64,
        outcome: u64,
    }

    struct LimboResults<phantom T0> has copy, drop {
        player: address,
        results: vector<LimboResult<T0>>,
    }

    public fun get_threshold(arg0: u64) : u64 {
        let v0 = arg0 - 1;
        ((100 * arg0 - 10000) * 100000 + v0) / v0
    }

    public fun payout_amount(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 >= 101 && arg1 <= 10000, 4);
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::math::mul_and_div(arg0, arg1 - 100, 100)
    }

    public fun resolve_bet_outcome<T0>(arg0: &mut 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::UniHouse, arg1: 0x1::option::Option<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::bls_settler::BetOutcome<T0, Limbo>>) {
        let v0 = Limbo{dummy_field: false};
        let (v1, v2, v3) = 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::bls_settler::destroy_bet_outcome<T0, Limbo>(0x1::option::destroy_some<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::bls_settler::BetOutcome<T0, Limbo>>(arg1), v0);
        let v4 = v3;
        let v5 = 0x1::vector::empty<LimboResult<T0>>();
        while (!0x1::vector::is_empty<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::bls_settler::Bet<T0>>(&v4)) {
            let (v6, v7, v8) = 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::bls_settler::destroy_bet<T0>(0x1::vector::pop_back<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::bls_settler::Bet<T0>>(&mut v4));
            let v9 = v8;
            let v10 = v6;
            let v11 = 0x2::coin::value<T0>(&v10);
            0x2::coin::join<T0>(&mut v10, v7);
            if (!0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::contains(&v9, v2) || v2 % 69 == 0) {
                0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::put<T0, Limbo>(v0, arg0, v10);
                let v12 = LimboResult<T0>{
                    bet_size     : v11,
                    bet_returned : 0,
                    outcome      : v2,
                };
                0x1::vector::push_back<LimboResult<T0>>(&mut v5, v12);
                continue
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v10, v1);
            let v13 = LimboResult<T0>{
                bet_size     : v11,
                bet_returned : 0x2::coin::value<T0>(&v10),
                outcome      : v2,
            };
            0x1::vector::push_back<LimboResult<T0>>(&mut v5, v13);
        };
        let v14 = LimboResults<T0>{
            player  : v1,
            results : v5,
        };
        0x2::event::emit<LimboResults<T0>>(v14);
        0x1::vector::destroy_empty<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::bls_settler::Bet<T0>>(v4);
    }

    public fun start_game<T0>(arg0: &mut 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::UniHouse, arg1: &mut 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::bls_settler::BlsSettler, arg2: vector<u8>, arg3: vector<u64>, arg4: vector<0x2::coin::Coin<T0>>, arg5: &mut 0x2::tx_context::TxContext) : 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::receipt::GameReceipt<T0, Limbo> {
        let v0 = 0x1::vector::length<0x2::coin::Coin<T0>>(&arg4);
        assert!(v0 == 0x1::vector::length<u64>(&arg3), 3);
        assert!(v0 <= 10, 1);
        let v1 = 0;
        let v2 = Limbo{dummy_field: false};
        let v3 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::Ranges>();
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg4)) {
            let v6 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg4);
            let v7 = 0x1::vector::pop_back<u64>(&mut arg3);
            let v8 = 0x2::coin::value<T0>(&v6);
            assert!(v8 > 0, 0);
            0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::add_volume<T0, Limbo>(v2, arg0, v8, arg5);
            0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v3, v6);
            0x1::vector::push_back<u64>(&mut v4, payout_amount(v8, v7));
            0x1::vector::push_back<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::Ranges>(&mut v5, 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::from_single_range(get_threshold(v7) + 1, 9950000));
            v1 = v1 + v8;
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg4);
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::bls_settler::add_bet_data<T0, Limbo>(arg0, arg1, v2, true, 0x2::tx_context::sender(arg5), 9950000, v3, v4, v5, arg2, arg5);
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::new_game_receipt<T0, Limbo>(v2, arg0, v1)
    }

    // decompiled from Move bytecode v6
}

