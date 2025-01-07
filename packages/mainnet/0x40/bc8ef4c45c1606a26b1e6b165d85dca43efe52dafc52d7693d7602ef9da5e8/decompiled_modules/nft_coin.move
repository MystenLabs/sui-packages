module 0x40bc8ef4c45c1606a26b1e6b165d85dca43efe52dafc52d7693d7602ef9da5e8::nft_coin {
    struct NftCoin<phantom T0> has drop, store {
        dummy_field: bool,
    }

    struct NftStore<T0> has store {
        nfts: vector<T0>,
        supply: 0x2::balance::Supply<NftCoin<T0>>,
    }

    struct NftGlobal has key {
        id: 0x2::object::UID,
        nft_bag: 0x2::bag::Bag,
    }

    public entry fun claim_nfts_by_coin<T0: store + key>(arg0: &mut NftGlobal, arg1: 0x2::coin::Coin<NftCoin<T0>>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = claim_nfts_by_coin_inner<T0>(arg0, arg1, arg2);
        transfer_nfts<T0>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun claim_nfts_by_coin_inner<T0: store + key>(arg0: &mut NftGlobal, arg1: 0x2::coin::Coin<NftCoin<T0>>, arg2: &mut 0x2::tx_context::TxContext) : vector<T0> {
        let v0 = 0x2::coin::value<NftCoin<T0>>(&arg1);
        let v1 = v0 / 1000000000;
        assert!(v1 > 0, 3);
        let v2 = v0 % 1000000000;
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<NftCoin<T0>>>(0x2::coin::split<NftCoin<T0>>(&mut arg1, v2, arg2), 0x2::tx_context::sender(arg2));
        };
        let v3 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(0x2::bag::contains<0x1::ascii::String>(&arg0.nft_bag, v3), 2);
        let v4 = 0x2::bag::borrow_mut<0x1::ascii::String, NftStore<T0>>(&mut arg0.nft_bag, v3);
        0x2::balance::decrease_supply<NftCoin<T0>>(&mut v4.supply, 0x2::coin::into_balance<NftCoin<T0>>(arg1));
        let v5 = 0;
        let v6 = 0x1::vector::empty<T0>();
        while (v5 < v1) {
            0x1::vector::push_back<T0>(&mut v6, 0x1::vector::pop_back<T0>(&mut v4.nfts));
            v5 = v5 + 1;
        };
        v6
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NftGlobal{
            id      : 0x2::object::new(arg0),
            nft_bag : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<NftGlobal>(v0);
    }

    fun merge_vectors<T0>(arg0: &mut vector<T0>, arg1: vector<T0>) : u64 {
        let v0 = 0x1::vector::length<T0>(&arg1);
        let v1 = 0;
        while (v1 < v0) {
            0x1::vector::push_back<T0>(arg0, 0x1::vector::pop_back<T0>(&mut arg1));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<T0>(arg1);
        v0
    }

    public fun mint_coin_by_nfts<T0: store + key>(arg0: &mut NftGlobal, arg1: vector<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<NftCoin<T0>> {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        if (!0x2::bag::contains<0x1::ascii::String>(&arg0.nft_bag, v0)) {
            let v1 = NftCoin<T0>{dummy_field: false};
            let v2 = NftStore<T0>{
                nfts   : 0x1::vector::empty<T0>(),
                supply : 0x2::balance::create_supply<NftCoin<T0>>(v1),
            };
            0x2::bag::add<0x1::ascii::String, NftStore<T0>>(&mut arg0.nft_bag, v0, v2);
        };
        let v3 = 0x2::bag::borrow_mut<0x1::ascii::String, NftStore<T0>>(&mut arg0.nft_bag, v0);
        let v4 = &mut v3.nfts;
        let v5 = merge_vectors<T0>(v4, arg1);
        assert!(v5 > 0, 3);
        0x2::coin::from_balance<NftCoin<T0>>(0x2::balance::increase_supply<NftCoin<T0>>(&mut v3.supply, v5 * 1000000000), arg2)
    }

    public fun swap_coin_to_nfts<T0: store + key, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x40bc8ef4c45c1606a26b1e6b165d85dca43efe52dafc52d7693d7602ef9da5e8::implements::Global, arg2: &mut NftGlobal, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = swap_coin_to_nfts_innter<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        transfer_nfts<T0>(v0, 0x2::tx_context::sender(arg5));
    }

    public fun swap_coin_to_nfts_innter<T0: store + key, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x40bc8ef4c45c1606a26b1e6b165d85dca43efe52dafc52d7693d7602ef9da5e8::implements::Global, arg2: &mut NftGlobal, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : vector<T0> {
        assert!(arg4 > 0, 3);
        let v0 = 0x40bc8ef4c45c1606a26b1e6b165d85dca43efe52dafc52d7693d7602ef9da5e8::interface::swap_v2_inner<T1, NftCoin<T0>>(arg0, arg1, arg3, arg4 * 9, arg5);
        claim_nfts_by_coin_inner<T0>(arg2, v0, arg5)
    }

    public entry fun swap_nfts_to_coin<T0: store + key, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x40bc8ef4c45c1606a26b1e6b165d85dca43efe52dafc52d7693d7602ef9da5e8::implements::Global, arg2: &mut NftGlobal, arg3: vector<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = mint_coin_by_nfts<T0>(arg2, arg3, arg5);
        0x40bc8ef4c45c1606a26b1e6b165d85dca43efe52dafc52d7693d7602ef9da5e8::interface::swap_v2<NftCoin<T0>, T1>(arg0, arg1, v0, arg4, arg5);
    }

    public fun transfer_nfts<T0: store + key>(arg0: vector<T0>, arg1: address) : u64 {
        let v0 = 0x1::vector::length<T0>(&arg0);
        let v1 = 0;
        while (v1 < v0) {
            0x2::transfer::public_transfer<T0>(0x1::vector::pop_back<T0>(&mut arg0), arg1);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<T0>(arg0);
        v0
    }

    // decompiled from Move bytecode v6
}

