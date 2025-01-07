module 0x7a05d26f35fee4e6ab9d59cb6f7f48e90cefe2c0742e304b555fa3be8dcf2cea::dice_range {
    struct DiceRange has copy, drop, store {
        dummy_field: bool,
    }

    public fun start_over_under_game<T0>(arg0: &mut 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::UniHouse, arg1: &mut 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::bls_settler::BlsSettler, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) : 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::receipt::GameReceipt<T0, DiceRange> {
        assert!(arg4 == 0 || arg4 == 1, 0);
        assert!(arg3 <= 10000 || arg3 >= 0, 1);
        let (v0, v1) = if (arg4 == 0) {
            (arg3 / (10000 - arg3), 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::from_single_range(arg3, 10000))
        } else {
            ((10000 - arg3) / arg3, 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::from_single_range(0, arg3))
        };
        let v2 = 0x2::coin::value<T0>(&arg5);
        let v3 = DiceRange{dummy_field: false};
        let v4 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v4, arg5);
        let v5 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v5, v2 * v0);
        let v6 = 0x1::vector::empty<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::Ranges>();
        0x1::vector::push_back<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::Ranges>(&mut v6, v1);
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::bls_settler::add_bet_data<T0, DiceRange>(arg0, arg1, v3, false, 0x2::tx_context::sender(arg6), 10300, v4, v5, v6, arg2, arg6);
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::new_game_receipt<T0, DiceRange>(v3, arg0, v2)
    }

    public fun start_range_game<T0>(arg0: &mut 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::UniHouse, arg1: &mut 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::bls_settler::BlsSettler, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0x2::tx_context::TxContext) : 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::receipt::GameReceipt<T0, DiceRange> {
        assert!(arg5 == 2 || arg5 == 3, 0);
        assert!(arg3 <= 10000 || arg3 >= 0, 1);
        assert!(arg4 <= 10000 || arg4 >= 0, 1);
        assert!(arg4 > arg3, 1);
        let (v0, v1) = if (arg5 == 2) {
            (10000 / (arg4 - arg3), 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::from_single_range(arg3, arg4))
        } else {
            let v2 = 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::empty();
            0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::push_back(&mut v2, 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::range::new(0, arg3));
            0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::push_back(&mut v2, 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::range::new(arg4, 10000));
            (10000 / (arg3 - 0 + 10000 - arg4), v2)
        };
        let v3 = 0x2::coin::value<T0>(&arg6);
        let v4 = DiceRange{dummy_field: false};
        let v5 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v5, arg6);
        let v6 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v6, v3 * v0);
        let v7 = 0x1::vector::empty<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::Ranges>();
        0x1::vector::push_back<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::Ranges>(&mut v7, v1);
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::bls_settler::add_bet_data<T0, DiceRange>(arg0, arg1, v4, false, 0x2::tx_context::sender(arg7), 10300, v5, v6, v7, arg2, arg7);
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::new_game_receipt<T0, DiceRange>(v4, arg0, v3)
    }

    // decompiled from Move bytecode v6
}

