module 0x8e4271ce4eab9f469f47e511004d19a309780a045aba09d418d7848c00ad10f8::settlement {
    struct UsdcTypeHashKey has copy, drop, store {
        dummy_field: bool,
    }

    struct FeePoolKey<phantom T0> has copy, drop, store {
        addr: address,
    }

    struct SETTLEMENT has drop {
        dummy_field: bool,
    }

    struct SettlementAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SwapOrder has drop, store {
        cctp_nonce: u64,
        output_token: address,
        min_output: u64,
        recipient: address,
        fulfilled: bool,
        created_at: u64,
        src_eid: u32,
        quote_id: u64,
        solver_fee_usdc: u64,
        solver_address: address,
        affiliate_fee_usdc: u64,
        affiliate_address: address,
    }

    struct SettlementState has key {
        id: 0x2::object::UID,
        oapp_cap: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap,
        oapp_address: address,
        orders: 0x2::table::Table<u128, SwapOrder>,
        accepted_sources: 0x2::table::Table<u32, bool>,
        protocol_fee_bps: u16,
        protocol_fee_recipient: address,
    }

    public fun lz_receive(arg0: &mut SettlementState, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::LzReceiveParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, _, _, _, v4, _, _, v7) = 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::destroy(0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::lz_receive(arg1, &arg0.oapp_cap, arg2));
        let v8 = v7;
        let v9 = v4;
        if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&v8)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::option::destroy_some<0x2::coin::Coin<0x2::sui::SUI>>(v8), 0x2::tx_context::sender(arg4));
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v8);
        };
        assert!(0x2::table::contains<u32, bool>(&arg0.accepted_sources, v0) && *0x2::table::borrow<u32, bool>(&arg0.accepted_sources, v0), 8);
        let (v10, v11, v12, v13, v14, v15, v16, v17, v18, v19) = decode_swap_order(&v9);
        let v20 = order_key(v0, v10);
        assert!(!0x2::table::contains<u128, SwapOrder>(&arg0.orders, v20), 0);
        let v21 = SwapOrder{
            cctp_nonce         : v10,
            output_token       : v11,
            min_output         : v12,
            recipient          : v13,
            fulfilled          : false,
            created_at         : v19,
            src_eid            : v0,
            quote_id           : v14,
            solver_fee_usdc    : v15,
            solver_address     : v16,
            affiliate_fee_usdc : v17,
            affiliate_address  : v18,
        };
        0x2::table::add<u128, SwapOrder>(&mut arg0.orders, v20, v21);
        0x8e4271ce4eab9f469f47e511004d19a309780a045aba09d418d7848c00ad10f8::events::emit_swap_order_received(v0, v10, v11, v12, v13, v14);
    }

    fun accrue_fee<T0>(arg0: &mut SettlementState, arg1: address, arg2: 0x2::coin::Coin<T0>) {
        let v0 = FeePoolKey<T0>{addr: arg1};
        if (0x2::dynamic_field::exists_<FeePoolKey<T0>>(&arg0.id, v0)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<FeePoolKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), 0x2::coin::into_balance<T0>(arg2));
        } else {
            0x2::dynamic_field::add<FeePoolKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, 0x2::coin::into_balance<T0>(arg2));
        };
    }

    entry fun add_accepted_source(arg0: &mut SettlementState, arg1: &SettlementAdminCap, arg2: u32) {
        if (0x2::table::contains<u32, bool>(&arg0.accepted_sources, arg2)) {
            *0x2::table::borrow_mut<u32, bool>(&mut arg0.accepted_sources, arg2) = true;
        } else {
            0x2::table::add<u32, bool>(&mut arg0.accepted_sources, arg2, true);
        };
        0x8e4271ce4eab9f469f47e511004d19a309780a045aba09d418d7848c00ad10f8::events::emit_accepted_source_updated(arg2, true);
    }

    fun address_to_bytes(arg0: address) : vector<u8> {
        0x2::bcs::to_bytes<address>(&arg0)
    }

    fun compute_type_hash<T0>() : vector<u8> {
        let v0 = b"0x";
        0x1::vector::append<u8>(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        0x2::hash::blake2b256(&v0)
    }

    public fun compute_type_hash_view<T0>(arg0: &SettlementState) : vector<u8> {
        compute_type_hash<T0>()
    }

    fun decode_swap_order(arg0: &vector<u8>) : (u64, address, u64, address, u64, u64, address, u64, address, u64) {
        assert!(0x1::vector::length<u8>(arg0) == 177, 7);
        assert!(*0x1::vector::borrow<u8>(arg0, 0) == 2, 7);
        (read_u64_le(arg0, 1), read_address(arg0, 9), read_u64_le(arg0, 41), read_address(arg0, 49), read_u64_le(arg0, 81), read_u64_le(arg0, 89), read_address(arg0, 97), read_u64_le(arg0, 129), read_address(arg0, 137), read_u64_le(arg0, 169))
    }

    public fun emergency_withdraw<T0: store + key>(arg0: &mut SettlementState, arg1: &SettlementAdminCap, arg2: 0x2::transfer::Receiving<T0>, arg3: address) {
        let v0 = 0x2::transfer::public_receive<T0>(&mut arg0.id, arg2);
        0x2::transfer::public_transfer<T0>(v0, arg3);
        0x8e4271ce4eab9f469f47e511004d19a309780a045aba09d418d7848c00ad10f8::events::emit_emergency_withdraw(0x2::object::id_address<T0>(&v0), 0, arg3);
    }

    public fun fulfill_order_swap_a_to_b<T0, T1>(arg0: &mut SettlementState, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u32, arg4: u64, arg5: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = order_key(arg3, arg4);
        assert!(0x2::table::contains<u128, SwapOrder>(&arg0.orders, v0), 1);
        let v1 = 0x2::table::borrow<u128, SwapOrder>(&arg0.orders, v0);
        assert!(!v1.fulfilled, 2);
        let v2 = v1.output_token;
        let v3 = v1.min_output;
        let v4 = v1.recipient;
        let v5 = v1.quote_id;
        let v6 = v1.solver_fee_usdc;
        let v7 = v1.solver_address;
        let v8 = v1.affiliate_fee_usdc;
        let v9 = v1.affiliate_address;
        let v10 = 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg5);
        let v11 = 0x2::coin::value<T0>(&v10);
        assert!(compute_type_hash<T1>() == address_to_bytes(v2), 6);
        let v12 = v11 * (arg0.protocol_fee_bps as u64) / 10000;
        assert!(v12 + v6 + v8 <= v11, 12);
        if (v12 > 0) {
            assert!(arg0.protocol_fee_recipient != @0x0, 13);
            let v13 = arg0.protocol_fee_recipient;
            accrue_fee<T0>(arg0, v13, 0x2::coin::split<T0>(&mut v10, v12, arg7));
        };
        let v14 = if (v6 > 0 && v7 != @0x0) {
            accrue_fee<T0>(arg0, v7, 0x2::coin::split<T0>(&mut v10, v6, arg7));
            v6
        } else {
            0
        };
        let v15 = if (v8 > 0 && v9 != @0x0) {
            accrue_fee<T0>(arg0, v9, 0x2::coin::split<T0>(&mut v10, v8, arg7));
            v8
        } else {
            0
        };
        let v16 = if (v12 > 0) {
            true
        } else if (v14 > 0) {
            true
        } else {
            v15 > 0
        };
        if (v16) {
            0x8e4271ce4eab9f469f47e511004d19a309780a045aba09d418d7848c00ad10f8::events::emit_fees_accrued(arg0.protocol_fee_recipient, v12, v7, v14, v9, v15);
        };
        let (v17, v18) = 0x8e4271ce4eab9f469f47e511004d19a309780a045aba09d418d7848c00ad10f8::aggregator::swap_a_to_b<T0, T1>(arg1, arg2, v10, v3, arg6, arg7);
        let v19 = v18;
        let v20 = v17;
        if (0x2::coin::value<T0>(&v19) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v19, 0x2::tx_context::sender(arg7));
        } else {
            0x2::coin::destroy_zero<T0>(v19);
        };
        0x2::table::borrow_mut<u128, SwapOrder>(&mut arg0.orders, v0).fulfilled = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v20, v4);
        0x8e4271ce4eab9f469f47e511004d19a309780a045aba09d418d7848c00ad10f8::events::emit_order_fulfilled(arg3, arg4, v11, 0x2::coin::value<T1>(&v20), v2, v4, 0x2::tx_context::sender(arg7), v5, v12, v14, v15);
    }

    public fun fulfill_order_swap_b_to_a<T0, T1>(arg0: &mut SettlementState, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u32, arg4: u64, arg5: 0x2::transfer::Receiving<0x2::coin::Coin<T1>>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = order_key(arg3, arg4);
        assert!(0x2::table::contains<u128, SwapOrder>(&arg0.orders, v0), 1);
        let v1 = 0x2::table::borrow<u128, SwapOrder>(&arg0.orders, v0);
        assert!(!v1.fulfilled, 2);
        let v2 = v1.output_token;
        let v3 = v1.min_output;
        let v4 = v1.recipient;
        let v5 = v1.quote_id;
        let v6 = v1.solver_fee_usdc;
        let v7 = v1.solver_address;
        let v8 = v1.affiliate_fee_usdc;
        let v9 = v1.affiliate_address;
        let v10 = 0x2::transfer::public_receive<0x2::coin::Coin<T1>>(&mut arg0.id, arg5);
        let v11 = 0x2::coin::value<T1>(&v10);
        assert!(compute_type_hash<T0>() == address_to_bytes(v2), 6);
        let v12 = v11 * (arg0.protocol_fee_bps as u64) / 10000;
        assert!(v12 + v6 + v8 <= v11, 12);
        if (v12 > 0) {
            assert!(arg0.protocol_fee_recipient != @0x0, 13);
            let v13 = arg0.protocol_fee_recipient;
            accrue_fee<T1>(arg0, v13, 0x2::coin::split<T1>(&mut v10, v12, arg7));
        };
        let v14 = if (v6 > 0 && v7 != @0x0) {
            accrue_fee<T1>(arg0, v7, 0x2::coin::split<T1>(&mut v10, v6, arg7));
            v6
        } else {
            0
        };
        let v15 = if (v8 > 0 && v9 != @0x0) {
            accrue_fee<T1>(arg0, v9, 0x2::coin::split<T1>(&mut v10, v8, arg7));
            v8
        } else {
            0
        };
        let v16 = if (v12 > 0) {
            true
        } else if (v14 > 0) {
            true
        } else {
            v15 > 0
        };
        if (v16) {
            0x8e4271ce4eab9f469f47e511004d19a309780a045aba09d418d7848c00ad10f8::events::emit_fees_accrued(arg0.protocol_fee_recipient, v12, v7, v14, v9, v15);
        };
        let (v17, v18) = 0x8e4271ce4eab9f469f47e511004d19a309780a045aba09d418d7848c00ad10f8::aggregator::swap_b_to_a<T0, T1>(arg1, arg2, v10, v3, arg6, arg7);
        let v19 = v18;
        let v20 = v17;
        if (0x2::coin::value<T1>(&v19) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v19, 0x2::tx_context::sender(arg7));
        } else {
            0x2::coin::destroy_zero<T1>(v19);
        };
        0x2::table::borrow_mut<u128, SwapOrder>(&mut arg0.orders, v0).fulfilled = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v20, v4);
        0x8e4271ce4eab9f469f47e511004d19a309780a045aba09d418d7848c00ad10f8::events::emit_order_fulfilled(arg3, arg4, v11, 0x2::coin::value<T0>(&v20), v2, v4, 0x2::tx_context::sender(arg7), v5, v12, v14, v15);
    }

    public fun fulfill_order_usdc<T0: drop>(arg0: &mut SettlementState, arg1: u32, arg2: u64, arg3: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = order_key(arg1, arg2);
        assert!(0x2::table::contains<u128, SwapOrder>(&arg0.orders, v0), 1);
        let v1 = 0x2::table::borrow<u128, SwapOrder>(&arg0.orders, v0);
        assert!(!v1.fulfilled, 2);
        let v2 = v1.output_token;
        let v3 = v1.min_output;
        let v4 = v1.recipient;
        let v5 = v1.quote_id;
        let v6 = v1.solver_fee_usdc;
        let v7 = v1.solver_address;
        let v8 = v1.affiliate_fee_usdc;
        let v9 = v1.affiliate_address;
        let v10 = 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg3);
        let v11 = 0x2::coin::value<T0>(&v10);
        assert!(compute_type_hash<T0>() == address_to_bytes(v2), 6);
        let v12 = v11 * (arg0.protocol_fee_bps as u64) / 10000;
        assert!(v12 + v6 + v8 <= v11, 12);
        if (v12 > 0) {
            assert!(arg0.protocol_fee_recipient != @0x0, 13);
            let v13 = arg0.protocol_fee_recipient;
            accrue_fee<T0>(arg0, v13, 0x2::coin::split<T0>(&mut v10, v12, arg5));
        };
        let v14 = if (v6 > 0 && v7 != @0x0) {
            accrue_fee<T0>(arg0, v7, 0x2::coin::split<T0>(&mut v10, v6, arg5));
            v6
        } else {
            0
        };
        let v15 = if (v8 > 0 && v9 != @0x0) {
            accrue_fee<T0>(arg0, v9, 0x2::coin::split<T0>(&mut v10, v8, arg5));
            v8
        } else {
            0
        };
        let v16 = if (v12 > 0) {
            true
        } else if (v14 > 0) {
            true
        } else {
            v15 > 0
        };
        if (v16) {
            0x8e4271ce4eab9f469f47e511004d19a309780a045aba09d418d7848c00ad10f8::events::emit_fees_accrued(arg0.protocol_fee_recipient, v12, v7, v14, v9, v15);
        };
        let v17 = 0x2::coin::value<T0>(&v10);
        assert!(v17 >= v3, 3);
        0x2::table::borrow_mut<u128, SwapOrder>(&mut arg0.orders, v0).fulfilled = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v10, v4);
        0x8e4271ce4eab9f469f47e511004d19a309780a045aba09d418d7848c00ad10f8::events::emit_order_fulfilled(arg1, arg2, v11, v17, v2, v4, 0x2::tx_context::sender(arg5), v5, v12, v14, v15);
    }

    public fun get_order_min_output(arg0: &SettlementState, arg1: u32, arg2: u64) : u64 {
        0x2::table::borrow<u128, SwapOrder>(&arg0.orders, order_key(arg1, arg2)).min_output
    }

    public fun get_order_output_token(arg0: &SettlementState, arg1: u32, arg2: u64) : address {
        0x2::table::borrow<u128, SwapOrder>(&arg0.orders, order_key(arg1, arg2)).output_token
    }

    public fun get_order_recipient(arg0: &SettlementState, arg1: u32, arg2: u64) : address {
        0x2::table::borrow<u128, SwapOrder>(&arg0.orders, order_key(arg1, arg2)).recipient
    }

    public fun get_order_src_eid(arg0: &SettlementState, arg1: u32, arg2: u64) : u32 {
        0x2::table::borrow<u128, SwapOrder>(&arg0.orders, order_key(arg1, arg2)).src_eid
    }

    fun init(arg0: SETTLEMENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::new<SETTLEMENT>(&arg0, arg1);
        let v3 = SettlementState{
            id                     : 0x2::object::new(arg1),
            oapp_cap               : v0,
            oapp_address           : v2,
            orders                 : 0x2::table::new<u128, SwapOrder>(arg1),
            accepted_sources       : 0x2::table::new<u32, bool>(arg1),
            protocol_fee_bps       : 0,
            protocol_fee_recipient : @0x0,
        };
        0x2::transfer::share_object<SettlementState>(v3);
        0x2::transfer::public_transfer<0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::AdminCap>(v1, 0x2::tx_context::sender(arg1));
        let v4 = SettlementAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<SettlementAdminCap>(v4, 0x2::tx_context::sender(arg1));
    }

    public fun is_accepted_source(arg0: &SettlementState, arg1: u32) : bool {
        0x2::table::contains<u32, bool>(&arg0.accepted_sources, arg1) && *0x2::table::borrow<u32, bool>(&arg0.accepted_sources, arg1)
    }

    public fun is_order_fulfilled(arg0: &SettlementState, arg1: u32, arg2: u64) : bool {
        let v0 = order_key(arg1, arg2);
        if (!0x2::table::contains<u128, SwapOrder>(&arg0.orders, v0)) {
            return false
        };
        0x2::table::borrow<u128, SwapOrder>(&arg0.orders, v0).fulfilled
    }

    public fun is_order_received(arg0: &SettlementState, arg1: u32, arg2: u64) : bool {
        0x2::table::contains<u128, SwapOrder>(&arg0.orders, order_key(arg1, arg2))
    }

    public fun oapp_address(arg0: &SettlementState) : address {
        arg0.oapp_address
    }

    fun order_key(arg0: u32, arg1: u64) : u128 {
        (arg0 as u128) << 64 | (arg1 as u128)
    }

    fun read_address(arg0: &vector<u8>, arg1: u64) : address {
        assert!(arg1 + 32 <= 0x1::vector::length<u8>(arg0), 7);
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 32) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1 + v1));
            v1 = v1 + 1;
        };
        0x2::address::from_bytes(v0)
    }

    fun read_u64_le(arg0: &vector<u8>, arg1: u64) : u64 {
        assert!(arg1 + 8 <= 0x1::vector::length<u8>(arg0), 7);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 8) {
            v0 = v0 | (*0x1::vector::borrow<u8>(arg0, arg1 + v1) as u64) << (v1 as u8) * 8;
            v1 = v1 + 1;
        };
        v0
    }

    entry fun remove_accepted_source(arg0: &mut SettlementState, arg1: &SettlementAdminCap, arg2: u32) {
        if (0x2::table::contains<u32, bool>(&arg0.accepted_sources, arg2)) {
            *0x2::table::borrow_mut<u32, bool>(&mut arg0.accepted_sources, arg2) = false;
        };
        0x8e4271ce4eab9f469f47e511004d19a309780a045aba09d418d7848c00ad10f8::events::emit_accepted_source_updated(arg2, false);
    }

    entry fun set_protocol_fee(arg0: &mut SettlementState, arg1: &SettlementAdminCap, arg2: u16) {
        assert!(arg2 <= 100, 11);
        arg0.protocol_fee_bps = arg2;
        0x8e4271ce4eab9f469f47e511004d19a309780a045aba09d418d7848c00ad10f8::events::emit_protocol_fee_set(arg2);
    }

    entry fun set_protocol_fee_recipient(arg0: &mut SettlementState, arg1: &SettlementAdminCap, arg2: address) {
        assert!(arg2 != @0x0, 13);
        arg0.protocol_fee_recipient = arg2;
        0x8e4271ce4eab9f469f47e511004d19a309780a045aba09d418d7848c00ad10f8::events::emit_protocol_fee_recipient_set(arg2);
    }

    entry fun set_usdc_type_hash(arg0: &mut SettlementState, arg1: &SettlementAdminCap, arg2: vector<u8>) {
        let v0 = UsdcTypeHashKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<UsdcTypeHashKey>(&arg0.id, v0)) {
            let v1 = UsdcTypeHashKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<UsdcTypeHashKey, vector<u8>>(&mut arg0.id, v1) = arg2;
        } else {
            let v2 = UsdcTypeHashKey{dummy_field: false};
            0x2::dynamic_field::add<UsdcTypeHashKey, vector<u8>>(&mut arg0.id, v2, arg2);
        };
    }

    public fun withdraw_fallback<T0: drop>(arg0: &mut SettlementState, arg1: u32, arg2: u64, arg3: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = UsdcTypeHashKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<UsdcTypeHashKey>(&arg0.id, v0), 10);
        let v1 = UsdcTypeHashKey{dummy_field: false};
        assert!(compute_type_hash<T0>() == *0x2::dynamic_field::borrow<UsdcTypeHashKey, vector<u8>>(&arg0.id, v1), 9);
        let v2 = order_key(arg1, arg2);
        assert!(0x2::table::contains<u128, SwapOrder>(&arg0.orders, v2), 1);
        let v3 = 0x2::table::borrow<u128, SwapOrder>(&arg0.orders, v2);
        assert!(!v3.fulfilled, 2);
        assert!(0x2::tx_context::sender(arg5) == v3.recipient, 5);
        assert!(0x2::clock::timestamp_ms(arg4) / 1000 >= v3.created_at + 86400, 4);
        let v4 = v3.recipient;
        let v5 = v3.quote_id;
        let v6 = 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg3);
        0x2::table::borrow_mut<u128, SwapOrder>(&mut arg0.orders, v2).fulfilled = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, v4);
        0x8e4271ce4eab9f469f47e511004d19a309780a045aba09d418d7848c00ad10f8::events::emit_fallback_withdrawn(arg1, arg2, 0x2::coin::value<T0>(&v6), v4, v5);
    }

    entry fun withdraw_fees<T0>(arg0: &mut SettlementState, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = FeePoolKey<T0>{addr: v0};
        assert!(0x2::dynamic_field::exists_<FeePoolKey<T0>>(&arg0.id, v1), 14);
        let v2 = 0x2::dynamic_field::remove<FeePoolKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v1);
        let v3 = 0x2::balance::value<T0>(&v2);
        assert!(v3 > 0, 14);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg1), v0);
        0x8e4271ce4eab9f469f47e511004d19a309780a045aba09d418d7848c00ad10f8::events::emit_fees_withdrawn(v0, v3);
    }

    // decompiled from Move bytecode v6
}

