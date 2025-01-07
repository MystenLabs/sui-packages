module 0x57c3008880285085e5fd94092f21923158e3d8906161cf24d6ec1bb4e5b9036a::coinflip {
    struct Coinflip has copy, drop, store {
        dummy_field: bool,
    }

    public fun start_game<T0>(arg0: &mut 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::UniHouse, arg1: &mut 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::bls_settler::BlsSettler, arg2: vector<u8>, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) : 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::receipt::GameReceipt<T0, Coinflip> {
        assert!(arg3 < 2, 0);
        let v0 = 0x2::coin::value<T0>(&arg4);
        let v1 = Coinflip{dummy_field: false};
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v2, arg4);
        let v3 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v3, v0);
        let v4 = 0x1::vector::empty<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::Ranges>();
        0x1::vector::push_back<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::Ranges>(&mut v4, 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::from_single_range(arg3 * 500, arg3 * 500 + 485));
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::bls_settler::add_bet_data<T0, Coinflip>(arg0, arg1, v1, false, 0x2::tx_context::sender(arg5), 1000, v2, v3, v4, arg2, arg5);
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::new_game_receipt<T0, Coinflip>(v1, arg0, v0)
    }

    // decompiled from Move bytecode v6
}

