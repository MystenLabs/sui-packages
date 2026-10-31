module 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::executor {
    struct Executor has key {
        id: 0x2::object::UID,
        owner: address,
        settlement: 0x1::type_name::TypeName,
        cap: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap,
        peers: 0x2::vec_map::VecMap<u16, address>,
    }

    struct AdapterKey has copy, drop, store {
        witness: 0x1::type_name::TypeName,
    }

    struct Claim<phantom T0, phantom T1> {
        coin: 0x2::coin::Coin<T0>,
        owner: address,
        minimum: u64,
        source_chain: u16,
        source_sender: address,
    }

    struct Settled has copy, drop {
        owner: address,
        input_type: 0x1::type_name::TypeName,
        output_type: 0x1::type_name::TypeName,
        input_amount: u64,
        output_amount: u64,
        sold: bool,
        source_chain: u16,
        source_sender: address,
    }

    fun emit<T0, T1>(arg0: address, arg1: u64, arg2: u64, arg3: bool, arg4: u16, arg5: address) {
        let v0 = Settled{
            owner         : arg0,
            input_type    : 0x1::type_name::with_defining_ids<T0>(),
            output_type   : 0x1::type_name::with_defining_ids<T1>(),
            input_amount  : arg1,
            output_amount : arg2,
            sold          : arg3,
            source_chain  : arg4,
            source_sender : arg5,
        };
        0x2::event::emit<Settled>(v0);
    }

    public(friend) fun assert_adapter<T0, T1, T2: drop>(arg0: &Executor, arg1: &Claim<T0, T1>, arg2: &T2) {
        assert!(arg0.owner == arg1.owner && arg0.settlement == 0x1::type_name::with_defining_ids<T1>(), 6);
        let v0 = AdapterKey{witness: 0x1::type_name::with_defining_ids<T2>()};
        assert!(0x2::dynamic_field::exists_<AdapterKey>(&arg0.id, v0), 6);
        assert!(*0x2::dynamic_field::borrow<AdapterKey, bool>(&arg0.id, v0), 6);
    }

    fun check_owner_and_settlement<T0>(arg0: address, arg1: 0x1::type_name::TypeName, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0, 0);
        assert!(arg1 == 0x1::type_name::with_defining_ids<T0>(), 1);
    }

    fun check_source(arg0: &0x2::vec_map::VecMap<u16, address>, arg1: u16, arg2: address, arg3: vector<u8>) {
        assert!(0x2::vec_map::contains<u16, address>(arg0, &arg1), 2);
        assert!(*0x2::vec_map::get<u16, address>(arg0, &arg1) == arg2, 2);
        assert!(arg3 == b"pybots:sui:v1", 3);
    }

    public(friend) fun claim_amount<T0, T1>(arg0: &Claim<T0, T1>) : u64 {
        0x2::coin::value<T0>(&arg0.coin)
    }

    public(friend) fun claim_minimum<T0, T1>(arg0: &Claim<T0, T1>) : u64 {
        arg0.minimum
    }

    public fun claim_only<T0, T1>(arg0: Claim<T0, T1>) {
        let Claim {
            coin          : v0,
            owner         : v1,
            minimum       : _,
            source_chain  : v3,
            source_sender : v4,
        } = arg0;
        let v5 = v0;
        let v6 = 0x2::coin::value<T0>(&v5);
        emit<T0, T0>(v1, v6, v6, false, v3, v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, v1);
    }

    public fun create<T0>(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = Executor{
            id         : 0x2::object::new(arg1),
            owner      : v0,
            settlement : 0x1::type_name::with_defining_ids<T0>(),
            cap        : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::new(arg0, arg1),
            peers      : 0x2::vec_map::empty<u16, address>(),
        };
        0x2::transfer::transfer<Executor>(v1, v0);
    }

    fun finish<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: address, arg3: u64, arg4: u64, arg5: u16, arg6: address) {
        assert!(0x2::coin::value<T0>(&arg0) == 0, 5);
        assert!(0x2::coin::value<T1>(&arg1) > arg3, 4);
        0x2::coin::destroy_zero<T0>(arg0);
        emit<T0, T1>(arg2, arg4, 0x2::coin::value<T1>(&arg1), true, arg5, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg1, arg2);
    }

    public(friend) fun finish_route<T0, T1>(arg0: Claim<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64) {
        let Claim {
            coin          : v0,
            owner         : v1,
            minimum       : v2,
            source_chain  : v3,
            source_sender : v4,
        } = arg0;
        finish<T0, T1>(v0, arg1, v1, v2, arg2, v3, v4);
    }

    fun quote<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: bool, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &mut 0x2::tx_context::TxContext) : (u128, u128, u128) {
        let v0 = if (arg1) {
            4295048016
        } else {
            79226673515401279992447579055
        };
        let v1 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool_fetcher::compute_swap_result<T0, T1, T2>(arg0, arg1, (arg2 as u128), true, v0, arg3, arg4, arg5);
        0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::decision::quote_amounts(0x1::bcs::to_bytes<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::ComputeSwapState>(&v1), arg1)
    }

    public fun receiver(arg0: &Executor) : 0x2::object::ID {
        0x2::object::id<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap>(&arg0.cap)
    }

    public fun redeem_wm<T0, T1>(arg0: &Executor, arg1: 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::complete_transfer_with_payload::RedeemerReceipt<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) : Claim<T0, T1> {
        check_owner_and_settlement<T1>(arg0.owner, arg0.settlement, arg3);
        let (v0, v1, v2) = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::complete_transfer_with_payload::redeem_coin<T0>(&arg0.cap, arg1);
        let v3 = v1;
        let v4 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_address(0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_with_payload::sender(&v3));
        check_source(&arg0.peers, v2, v4, 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_with_payload::take_payload(v3));
        Claim<T0, T1>{
            coin          : v0,
            owner         : arg0.owner,
            minimum       : arg2,
            source_chain  : v2,
            source_sender : v4,
        }
    }

    public fun sell_a_b<T0, T1, T2>(arg0: Claim<T0, T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &0x2::clock::Clock, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0.coin);
        if (v0 == 0) {
            claim_only<T0, T1>(arg0);
            return
        };
        let (v1, v2, v3) = quote<T0, T1, T2>(arg1, true, v0, arg2, arg3, arg4);
        if (!0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::decision::should_sell(v0, v1, v2, v3, arg0.minimum)) {
            claim_only<T0, T1>(arg0);
            return
        };
        let Claim {
            coin          : v4,
            owner         : v5,
            minimum       : v6,
            source_chain  : v7,
            source_sender : v8,
        } = arg0;
        let v9 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v9, v4);
        let (v10, v11) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg1, v9, v0, v6 + 1, 4295048016, true, v5, 0x2::clock::timestamp_ms(arg2), arg2, arg3, arg4);
        finish<T0, T1>(v11, v10, v5, v6, v0, v7, v8);
    }

    public fun sell_a_b_b_c<T0, T1, T2, T3, T4>(arg0: Claim<T0, T2>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T3>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T2, T4>, arg3: &0x2::clock::Clock, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0.coin);
        if (v0 == 0) {
            claim_only<T0, T2>(arg0);
            return
        };
        let (v1, v2, v3) = quote<T0, T1, T3>(arg1, true, v0, arg3, arg4, arg5);
        if (!0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::decision::should_sell(v0, v1, v2, v3, 0)) {
            claim_only<T0, T2>(arg0);
            return
        };
        let (v4, v5, v6) = quote<T1, T2, T4>(arg2, true, (v2 as u64), arg3, arg4, arg5);
        if (!0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::decision::should_sell((v2 as u64), v4, v5, v6, arg0.minimum)) {
            claim_only<T0, T2>(arg0);
            return
        };
        let Claim {
            coin          : v7,
            owner         : v8,
            minimum       : v9,
            source_chain  : v10,
            source_sender : v11,
        } = arg0;
        let v12 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v12, v7);
        let (v13, v14) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_b_c_with_return_<T0, T3, T1, T4, T2>(arg1, arg2, v12, v0, v9 + 1, 4295048016, 4295048016, true, v8, 0x2::clock::timestamp_ms(arg3), arg3, arg4, arg5);
        finish<T0, T2>(v14, v13, v8, v9, v0, v10, v11);
    }

    public fun sell_a_b_c_b<T0, T1, T2, T3, T4>(arg0: Claim<T0, T2>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T3>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T1, T4>, arg3: &0x2::clock::Clock, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0.coin);
        if (v0 == 0) {
            claim_only<T0, T2>(arg0);
            return
        };
        let (v1, v2, v3) = quote<T0, T1, T3>(arg1, true, v0, arg3, arg4, arg5);
        if (!0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::decision::should_sell(v0, v1, v2, v3, 0)) {
            claim_only<T0, T2>(arg0);
            return
        };
        let (v4, v5, v6) = quote<T2, T1, T4>(arg2, false, (v2 as u64), arg3, arg4, arg5);
        if (!0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::decision::should_sell((v2 as u64), v4, v5, v6, arg0.minimum)) {
            claim_only<T0, T2>(arg0);
            return
        };
        let Claim {
            coin          : v7,
            owner         : v8,
            minimum       : v9,
            source_chain  : v10,
            source_sender : v11,
        } = arg0;
        let v12 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v12, v7);
        let (v13, v14) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_c_b_with_return_<T0, T3, T1, T4, T2>(arg1, arg2, v12, v0, v9 + 1, 4295048016, 79226673515401279992447579055, true, v8, 0x2::clock::timestamp_ms(arg3), arg3, arg4, arg5);
        finish<T0, T2>(v14, v13, v8, v9, v0, v10, v11);
    }

    public fun sell_b_a<T0, T1, T2>(arg0: Claim<T1, T0>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &0x2::clock::Clock, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T1>(&arg0.coin);
        if (v0 == 0) {
            claim_only<T1, T0>(arg0);
            return
        };
        let (v1, v2, v3) = quote<T0, T1, T2>(arg1, false, v0, arg2, arg3, arg4);
        if (!0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::decision::should_sell(v0, v1, v2, v3, arg0.minimum)) {
            claim_only<T1, T0>(arg0);
            return
        };
        let Claim {
            coin          : v4,
            owner         : v5,
            minimum       : v6,
            source_chain  : v7,
            source_sender : v8,
        } = arg0;
        let v9 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v9, v4);
        let (v10, v11) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg1, v9, v0, v6 + 1, 79226673515401279992447579055, true, v5, 0x2::clock::timestamp_ms(arg2), arg2, arg3, arg4);
        finish<T1, T0>(v11, v10, v5, v6, v0, v7, v8);
    }

    public fun sell_b_a_b_c<T0, T1, T2, T3, T4>(arg0: Claim<T0, T2>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T3>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T2, T4>, arg3: &0x2::clock::Clock, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0.coin);
        if (v0 == 0) {
            claim_only<T0, T2>(arg0);
            return
        };
        let (v1, v2, v3) = quote<T1, T0, T3>(arg1, false, v0, arg3, arg4, arg5);
        if (!0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::decision::should_sell(v0, v1, v2, v3, 0)) {
            claim_only<T0, T2>(arg0);
            return
        };
        let (v4, v5, v6) = quote<T1, T2, T4>(arg2, true, (v2 as u64), arg3, arg4, arg5);
        if (!0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::decision::should_sell((v2 as u64), v4, v5, v6, arg0.minimum)) {
            claim_only<T0, T2>(arg0);
            return
        };
        let Claim {
            coin          : v7,
            owner         : v8,
            minimum       : v9,
            source_chain  : v10,
            source_sender : v11,
        } = arg0;
        let v12 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v12, v7);
        let (v13, v14) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_b_c_with_return_<T0, T3, T1, T4, T2>(arg1, arg2, v12, v0, v9 + 1, 79226673515401279992447579055, 4295048016, true, v8, 0x2::clock::timestamp_ms(arg3), arg3, arg4, arg5);
        finish<T0, T2>(v14, v13, v8, v9, v0, v10, v11);
    }

    public fun sell_b_a_c_b<T0, T1, T2, T3, T4>(arg0: Claim<T0, T2>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T3>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T1, T4>, arg3: &0x2::clock::Clock, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0.coin);
        if (v0 == 0) {
            claim_only<T0, T2>(arg0);
            return
        };
        let (v1, v2, v3) = quote<T1, T0, T3>(arg1, false, v0, arg3, arg4, arg5);
        if (!0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::decision::should_sell(v0, v1, v2, v3, 0)) {
            claim_only<T0, T2>(arg0);
            return
        };
        let (v4, v5, v6) = quote<T2, T1, T4>(arg2, false, (v2 as u64), arg3, arg4, arg5);
        if (!0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::decision::should_sell((v2 as u64), v4, v5, v6, arg0.minimum)) {
            claim_only<T0, T2>(arg0);
            return
        };
        let Claim {
            coin          : v7,
            owner         : v8,
            minimum       : v9,
            source_chain  : v10,
            source_sender : v11,
        } = arg0;
        let v12 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v12, v7);
        let (v13, v14) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_c_b_with_return_<T0, T3, T1, T4, T2>(arg1, arg2, v12, v0, v9 + 1, 79226673515401279992447579055, 79226673515401279992447579055, true, v8, 0x2::clock::timestamp_ms(arg3), arg3, arg4, arg5);
        finish<T0, T2>(v14, v13, v8, v9, v0, v10, v11);
    }

    public fun set_adapter<T0: drop>(arg0: &mut Executor, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        let v0 = AdapterKey{witness: 0x1::type_name::with_defining_ids<T0>()};
        if (0x2::dynamic_field::exists_<AdapterKey>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow_mut<AdapterKey, bool>(&mut arg0.id, v0) = arg1;
        } else {
            0x2::dynamic_field::add<AdapterKey, bool>(&mut arg0.id, v0, arg1);
        };
    }

    public fun set_peer(arg0: &mut Executor, arg1: u16, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 0);
        assert!(arg1 != 0 && arg2 != @0x0, 2);
        if (0x2::vec_map::contains<u16, address>(&arg0.peers, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<u16, address>(&mut arg0.peers, &arg1);
        };
        0x2::vec_map::insert<u16, address>(&mut arg0.peers, arg1, arg2);
    }

    public(friend) fun withdraw_for_route<T0, T1>(arg0: &mut Claim<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::split<T0>(&mut arg0.coin, 0x2::coin::value<T0>(&arg0.coin), arg1)
    }

    // decompiled from Move bytecode v7
}

