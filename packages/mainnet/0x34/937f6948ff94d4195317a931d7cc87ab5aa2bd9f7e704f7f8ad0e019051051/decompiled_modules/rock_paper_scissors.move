module 0xd1417478493c4656891ef783fdb9144d8f008f3a16068c8aeaff89b41a320490::rock_paper_scissors {
    struct RockPaperScissors has copy, drop, store {
        dummy_field: bool,
    }

    public fun start_game<T0>(arg0: &mut 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::UniHouse, arg1: &mut 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::bls_settler::BlsSettler, arg2: vector<u8>, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) : (0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::bls_settler::BetKey<T0, RockPaperScissors>, 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::receipt::GameReceipt<T0, RockPaperScissors>) {
        assert!(arg3 < 3, 0);
        let (v0, v1) = if (arg3 == 0) {
            (0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::from_single_range(600, 890), 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::from_single_range(0, 290))
        } else if (arg3 == 1) {
            (0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::from_single_range(0, 290), 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::from_single_range(300, 590))
        } else {
            (0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::from_single_range(300, 590), 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::from_single_range(600, 890))
        };
        let v2 = RockPaperScissors{dummy_field: false};
        let v3 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v3, arg4);
        let v4 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v4, 0x2::coin::value<T0>(&arg4));
        let v5 = 0x1::vector::empty<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::Ranges>();
        0x1::vector::push_back<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::Ranges>(&mut v5, v0);
        let v6 = 0x1::vector::empty<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::Ranges>();
        0x1::vector::push_back<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::Ranges>(&mut v6, v1);
        (0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::bls_settler::add_bet_data_with_draw<T0, RockPaperScissors>(arg0, arg1, v2, false, 0x2::tx_context::sender(arg5), 900, v3, v4, v5, v6, arg2, arg5), 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::new_game_receipt<T0, RockPaperScissors>(v2, arg0, 0x2::coin::value<T0>(&arg4)))
    }

    public fun start_game_with_partner<T0, T1>(arg0: &mut 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::UniHouse, arg1: &mut 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::bls_settler::BlsSettler, arg2: vector<u8>, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: &T1, arg6: &0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::partners::PartnerList, arg7: &mut 0x2::tx_context::TxContext) : (0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::bls_settler::BetKey<T0, RockPaperScissors>, 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::receipt::GameReceipt<T0, RockPaperScissors>) {
        assert!(arg3 < 3, 0);
        assert!(0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::partners::contains<T1>(arg6), 1);
        let (v0, v1) = if (arg3 == 0) {
            (0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::from_single_range(600, 895), 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::from_single_range(0, 295))
        } else if (arg3 == 1) {
            (0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::from_single_range(0, 295), 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::from_single_range(300, 595))
        } else {
            (0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::from_single_range(300, 595), 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::from_single_range(600, 895))
        };
        let v2 = RockPaperScissors{dummy_field: false};
        let v3 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v3, arg4);
        let v4 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v4, 0x2::coin::value<T0>(&arg4));
        let v5 = 0x1::vector::empty<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::Ranges>();
        0x1::vector::push_back<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::Ranges>(&mut v5, v0);
        let v6 = 0x1::vector::empty<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::Ranges>();
        0x1::vector::push_back<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::Ranges>(&mut v6, v1);
        (0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::bls_settler::add_bet_data_with_draw<T0, RockPaperScissors>(arg0, arg1, v2, false, 0x2::tx_context::sender(arg7), 900, v3, v4, v5, v6, arg2, arg7), 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::new_game_receipt<T0, RockPaperScissors>(v2, arg0, 0x2::coin::value<T0>(&arg4)))
    }

    // decompiled from Move bytecode v6
}

