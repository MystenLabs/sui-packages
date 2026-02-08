module 0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_deposit {
    struct SplitResult<phantom T0> has store {
        coins: 0x2::vec_map::VecMap<u8, 0x2::coin::Coin<T0>>,
    }

    struct DepositResult has copy, drop {
        shares_to_mint: u128,
        allocation: vector<0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_allocation_plan::ProtocolAmount>,
    }

    public(friend) fun add_to_position<T0>(arg0: &0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_pool::LLVPool<T0>, arg1: &mut 0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_position::LLVPoolPosition<T0>, arg2: u128, arg3: u128) {
        assert!(0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_position::pool_id<T0>(arg1) == 0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_pool::id<T0>(arg0), 3);
        0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_position::add_shares<T0>(arg1, arg2, arg3);
    }

    public fun allocation(arg0: &DepositResult) : &vector<0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_allocation_plan::ProtocolAmount> {
        &arg0.allocation
    }

    public fun calculate_allocation_plan<T0>(arg0: &0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_pool::LLVPool<T0>, arg1: u64) : vector<0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_allocation_plan::ProtocolAmount> {
        let v0 = 0x1::vector::empty<0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_allocation_plan::ProtocolAmount>();
        let v1 = 0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_pool::get_enabled_protocol_ids<T0>(arg0);
        let v2 = 0x1::vector::length<u8>(&v1);
        if (v2 == 0) {
            0x1::vector::push_back<0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_allocation_plan::ProtocolAmount>(&mut v0, 0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_allocation_plan::create(0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_allocation_plan::PROTOCOL_VAULT(), (arg1 as u128)));
            return v0
        };
        let v3 = 0;
        let v4 = 0;
        while (v4 < v2) {
            v3 = v3 + 0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_pool::get_protocol_ratio<T0>(arg0, *0x1::vector::borrow<u8>(&v1, v4));
            v4 = v4 + 1;
        };
        if (v3 == 0) {
            0x1::vector::push_back<0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_allocation_plan::ProtocolAmount>(&mut v0, 0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_allocation_plan::create(0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_allocation_plan::PROTOCOL_VAULT(), (arg1 as u128)));
            return v0
        };
        let v5 = 0;
        let v6 = 0;
        while (v6 < v2) {
            let v7 = *0x1::vector::borrow<u8>(&v1, v6);
            let v8 = if (v6 == v2 - 1) {
                (arg1 as u128) - v5
            } else {
                (arg1 as u128) * (0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_pool::get_protocol_ratio<T0>(arg0, v7) as u128) / (v3 as u128)
            };
            if (v8 > 0) {
                0x1::vector::push_back<0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_allocation_plan::ProtocolAmount>(&mut v0, 0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_allocation_plan::create(v7, v8));
                v5 = v5 + v8;
            };
            v6 = v6 + 1;
        };
        v0
    }

    public fun calculate_deposit<T0>(arg0: &0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_pool::LLVPool<T0>, arg1: u64) : DepositResult {
        let (v0, v1) = calculate_deposit_with_queue<T0>(arg0, arg1);
        DepositResult{
            shares_to_mint : calculate_shares_for_amount<T0>(arg0, (arg1 as u128) - (v1 as u128)),
            allocation     : v0,
        }
    }

    public fun calculate_deposit_with_queue<T0>(arg0: &0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_pool::LLVPool<T0>, arg1: u64) : (vector<0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_allocation_plan::ProtocolAmount>, u64) {
        assert!(!0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_pool::is_paused<T0>(arg0), 1);
        assert!(arg1 > 0, 2);
        assert!(arg1 >= 0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_pool::get_min_deposit<T0>(arg0), 4);
        let v0 = 0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_pool::get_total_assets<T0>(arg0);
        0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_pool::assert_deposit_cap<T0>(arg0, v0, arg1);
        let v1 = 0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_pool::get_supply_queue<T0>(arg0);
        assert!(0x1::vector::length<u8>(&v1) > 0, 6);
        let v2 = (arg1 as u128);
        let v3 = 0x1::vector::empty<0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_allocation_plan::ProtocolAmount>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<u8>(&v1) && v2 > 0) {
            let v5 = *0x1::vector::borrow<u8>(&v1, v4);
            if (0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_pool::is_protocol_enabled<T0>(arg0, v5)) {
                let v6 = (v0 + (arg1 as u128)) * (0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_pool::get_protocol_ratio<T0>(arg0, v5) as u128) / 10000;
                let v7 = 0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_pool::get_protocol_balance<T0>(arg0, v5);
                if (v6 > v7) {
                    let v8 = v6 - v7;
                    let v9 = if (v8 < v2) {
                        v8
                    } else {
                        v2
                    };
                    if (v9 > 0) {
                        0x1::vector::push_back<0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_allocation_plan::ProtocolAmount>(&mut v3, 0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_allocation_plan::create(v5, v9));
                        v2 = v2 - v9;
                    };
                };
            };
            v4 = v4 + 1;
        };
        (v3, (v2 as u64))
    }

    public fun calculate_shares_for_amount<T0>(arg0: &0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_pool::LLVPool<T0>, arg1: u128) : u128 {
        0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_math::calculate_shares_with_min(0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_pool::total_shares<T0>(arg0), 0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_pool::get_total_assets<T0>(arg0), (arg1 as u64))
    }

    public(friend) fun create_position<T0>(arg0: &0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_pool::LLVPool<T0>, arg1: u128, arg2: u128, arg3: &mut 0x2::tx_context::TxContext) : 0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_position::LLVPoolPosition<T0> {
        0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_position::create<T0>(0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_pool::id<T0>(arg0), arg1, arg2, 0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_pool::global_yield_index<T0>(arg0), arg3)
    }

    public fun destroy_empty_result<T0>(arg0: SplitResult<T0>) {
        let SplitResult { coins: v0 } = arg0;
        0x2::vec_map::destroy_empty<u8, 0x2::coin::Coin<T0>>(v0);
    }

    public fun extract_coin<T0>(arg0: &mut SplitResult<T0>, arg1: u8) : 0x2::coin::Coin<T0> {
        let (_, v1) = 0x2::vec_map::remove<u8, 0x2::coin::Coin<T0>>(&mut arg0.coins, &arg1);
        v1
    }

    public fun has_coin<T0>(arg0: &SplitResult<T0>, arg1: u8) : bool {
        0x2::vec_map::contains<u8, 0x2::coin::Coin<T0>>(&arg0.coins, &arg1)
    }

    public(friend) fun record_deposit<T0>(arg0: &mut 0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_pool::LLVPool<T0>, arg1: &DepositResult, arg2: &vector<0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_allocation_plan::ProtocolAmount>, arg3: 0x2::object::ID, arg4: address, arg5: u64, arg6: &0x2::clock::Clock) {
        let v0 = 0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_pool::total_shares<T0>(arg0) + arg1.shares_to_mint;
        0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_pool::set_total_shares<T0>(arg0, v0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_allocation_plan::ProtocolAmount>(arg2)) {
            let v2 = 0x1::vector::borrow<0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_allocation_plan::ProtocolAmount>(arg2, v1);
            let v3 = 0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_allocation_plan::amount(v2);
            if (v3 > 0) {
                0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_pool::record_deposit<T0>(arg0, 0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_allocation_plan::protocol_id(v2), v3);
            };
            v1 = v1 + 1;
        };
        0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_pool::set_yield_index<T0>(arg0, 0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_math::calculate_yield_index(v0, 0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_pool::get_total_assets<T0>(arg0)));
        0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_events::emit_deposited(0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_pool::id<T0>(arg0), arg3, arg4, arg5, arg1.shares_to_mint, *arg2, 0x2::clock::timestamp_ms(arg6));
    }

    public(friend) fun record_deposit_and_add_to_position<T0>(arg0: &mut 0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_pool::LLVPool<T0>, arg1: u64, arg2: u128, arg3: &vector<0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_allocation_plan::ProtocolAmount>, arg4: &mut 0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_position::LLVPoolPosition<T0>, arg5: address, arg6: &0x2::clock::Clock) {
        let v0 = 0x1::vector::empty<0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_allocation_plan::ProtocolAmount>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_allocation_plan::ProtocolAmount>(arg3)) {
            let v2 = 0x1::vector::borrow<0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_allocation_plan::ProtocolAmount>(arg3, v1);
            0x1::vector::push_back<0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_allocation_plan::ProtocolAmount>(&mut v0, 0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_allocation_plan::create(0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_allocation_plan::protocol_id(v2), 0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_allocation_plan::amount(v2)));
            v1 = v1 + 1;
        };
        let v3 = DepositResult{
            shares_to_mint : arg2,
            allocation     : v0,
        };
        record_deposit<T0>(arg0, &v3, arg3, 0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_position::id<T0>(arg4), arg5, arg1, arg6);
        add_to_position<T0>(arg0, arg4, arg2, (arg1 as u128));
    }

    public(friend) fun record_deposit_and_mint_position<T0>(arg0: &mut 0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_pool::LLVPool<T0>, arg1: &DepositResult, arg2: &vector<0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_allocation_plan::ProtocolAmount>, arg3: address, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = create_position<T0>(arg0, arg5, (arg4 as u128), arg7);
        record_deposit<T0>(arg0, arg1, arg2, 0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_position::id<T0>(&v0), arg3, arg4, arg6);
        0x2::transfer::public_transfer<0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_position::LLVPoolPosition<T0>>(v0, arg3);
    }

    public(friend) fun record_deposit_and_mint_position_from_allocation<T0>(arg0: &mut 0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_pool::LLVPool<T0>, arg1: u64, arg2: u128, arg3: &vector<0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_allocation_plan::ProtocolAmount>, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_allocation_plan::ProtocolAmount>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_allocation_plan::ProtocolAmount>(arg3)) {
            let v2 = 0x1::vector::borrow<0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_allocation_plan::ProtocolAmount>(arg3, v1);
            0x1::vector::push_back<0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_allocation_plan::ProtocolAmount>(&mut v0, 0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_allocation_plan::create(0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_allocation_plan::protocol_id(v2), 0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_allocation_plan::amount(v2)));
            v1 = v1 + 1;
        };
        let v3 = DepositResult{
            shares_to_mint : arg2,
            allocation     : v0,
        };
        let v4 = create_position<T0>(arg0, arg2, (arg1 as u128), arg6);
        record_deposit<T0>(arg0, &v3, arg3, 0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_position::id<T0>(&v4), arg4, arg1, arg5);
        0x2::transfer::public_transfer<0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_position::LLVPoolPosition<T0>>(v4, arg4);
    }

    public fun shares_to_mint(arg0: &DepositResult) : u128 {
        arg0.shares_to_mint
    }

    public fun split_for_allocation<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &vector<0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_allocation_plan::ProtocolAmount>, arg2: &mut 0x2::tx_context::TxContext) : SplitResult<T0> {
        let v0 = 0x2::vec_map::empty<u8, 0x2::coin::Coin<T0>>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_allocation_plan::ProtocolAmount>(arg1)) {
            let v2 = 0x1::vector::borrow<0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_allocation_plan::ProtocolAmount>(arg1, v1);
            let v3 = (0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_allocation_plan::amount(v2) as u64);
            if (v3 > 0) {
                0x2::vec_map::insert<u8, 0x2::coin::Coin<T0>>(&mut v0, 0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_allocation_plan::protocol_id(v2), 0x2::coin::split<T0>(&mut arg0, v3, arg2));
            };
            v1 = v1 + 1;
        };
        if (0x2::coin::value<T0>(&arg0) > 0) {
            if (!0x2::vec_map::is_empty<u8, 0x2::coin::Coin<T0>>(&v0)) {
                let (v4, _) = 0x2::vec_map::get_entry_by_idx<u8, 0x2::coin::Coin<T0>>(&v0, 0);
                let v6 = *v4;
                0x2::coin::join<T0>(0x2::vec_map::get_mut<u8, 0x2::coin::Coin<T0>>(&mut v0, &v6), arg0);
            } else {
                0x2::vec_map::insert<u8, 0x2::coin::Coin<T0>>(&mut v0, 0x6f350dd2a0500a534ef5f8a6863b131ca4ee7f7f7600ef2788fdbc38d1424872::llv_allocation_plan::PROTOCOL_VAULT(), arg0);
            };
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
        SplitResult<T0>{coins: v0}
    }

    public fun verify_min_shares(arg0: u128, arg1: u128) {
        assert!(arg0 >= arg1, 5);
    }

    // decompiled from Move bytecode v6
}

