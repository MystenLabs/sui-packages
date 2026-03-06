module 0x8e1b35f109f185fc12f62f091b1f4ec45d07ee8b116dd87d1b52da59205d0c05::settlement {
    struct UsdcTypeHashKey has copy, drop, store {
        dummy_field: bool,
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
    }

    struct FulfillReceipt {
        src_eid: u32,
        cctp_nonce: u64,
        output_token: address,
        min_output: u64,
        recipient: address,
        quote_id: u64,
    }

    struct SettlementState has key {
        id: 0x2::object::UID,
        oapp_cap: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap,
        oapp_address: address,
        orders: 0x2::table::Table<u128, SwapOrder>,
        accepted_sources: 0x2::table::Table<u32, bool>,
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
        let (v10, v11, v12, v13, v14) = decode_swap_order(&v9);
        let v15 = order_key(v0, v10);
        assert!(!0x2::table::contains<u128, SwapOrder>(&arg0.orders, v15), 0);
        let v16 = SwapOrder{
            cctp_nonce   : v10,
            output_token : v11,
            min_output   : v12,
            recipient    : v13,
            fulfilled    : false,
            created_at   : 0x2::clock::timestamp_ms(arg3),
            src_eid      : v0,
            quote_id     : v14,
        };
        0x2::table::add<u128, SwapOrder>(&mut arg0.orders, v15, v16);
        0x8e1b35f109f185fc12f62f091b1f4ec45d07ee8b116dd87d1b52da59205d0c05::events::emit_swap_order_received(v0, v10, v11, v12, v13, v14);
    }

    entry fun add_accepted_source(arg0: &mut SettlementState, arg1: &SettlementAdminCap, arg2: u32) {
        if (0x2::table::contains<u32, bool>(&arg0.accepted_sources, arg2)) {
            *0x2::table::borrow_mut<u32, bool>(&mut arg0.accepted_sources, arg2) = true;
        } else {
            0x2::table::add<u32, bool>(&mut arg0.accepted_sources, arg2, true);
        };
    }

    fun address_to_bytes(arg0: address) : vector<u8> {
        0x2::bcs::to_bytes<address>(&arg0)
    }

    public fun claim_usdc<T0: drop>(arg0: &mut SettlementState, arg1: u32, arg2: u64, arg3: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>) : (0x2::coin::Coin<T0>, FulfillReceipt) {
        let v0 = order_key(arg1, arg2);
        assert!(0x2::table::contains<u128, SwapOrder>(&arg0.orders, v0), 1);
        let v1 = 0x2::table::borrow<u128, SwapOrder>(&arg0.orders, v0);
        assert!(!v1.fulfilled, 2);
        let v2 = FulfillReceipt{
            src_eid      : v1.src_eid,
            cctp_nonce   : v1.cctp_nonce,
            output_token : v1.output_token,
            min_output   : v1.min_output,
            recipient    : v1.recipient,
            quote_id     : v1.quote_id,
        };
        (0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg3), v2)
    }

    public fun complete_fulfill<T0: drop>(arg0: &mut SettlementState, arg1: FulfillReceipt, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        let FulfillReceipt {
            src_eid      : v0,
            cctp_nonce   : v1,
            output_token : v2,
            min_output   : v3,
            recipient    : v4,
            quote_id     : v5,
        } = arg1;
        let v6 = b"0x";
        0x1::vector::append<u8>(&mut v6, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        assert!(0x2::hash::blake2b256(&v6) == address_to_bytes(v2), 6);
        let v7 = 0x2::coin::value<T0>(&arg2);
        assert!(v7 >= v3, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v4);
        0x2::table::borrow_mut<u128, SwapOrder>(&mut arg0.orders, order_key(v0, v1)).fulfilled = true;
        0x8e1b35f109f185fc12f62f091b1f4ec45d07ee8b116dd87d1b52da59205d0c05::events::emit_order_fulfilled(v0, v1, 0, v7, v2, v4, 0x2::tx_context::sender(arg3), v5);
    }

    fun compute_type_hash<T0>() : vector<u8> {
        let v0 = b"0x";
        0x1::vector::append<u8>(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        0x2::hash::blake2b256(&v0)
    }

    public fun create_fulfill_receipt(arg0: &SettlementState, arg1: u32, arg2: u64) : FulfillReceipt {
        let v0 = order_key(arg1, arg2);
        assert!(0x2::table::contains<u128, SwapOrder>(&arg0.orders, v0), 1);
        let v1 = 0x2::table::borrow<u128, SwapOrder>(&arg0.orders, v0);
        assert!(!v1.fulfilled, 2);
        FulfillReceipt{
            src_eid      : v1.src_eid,
            cctp_nonce   : v1.cctp_nonce,
            output_token : v1.output_token,
            min_output   : v1.min_output,
            recipient    : v1.recipient,
            quote_id     : v1.quote_id,
        }
    }

    fun decode_swap_order(arg0: &vector<u8>) : (u64, address, u64, address, u64) {
        assert!(0x1::vector::length<u8>(arg0) == 88, 7);
        (read_u64_le(arg0, 0), read_address(arg0, 8), read_u64_le(arg0, 40), read_address(arg0, 48), read_u64_le(arg0, 80))
    }

    public fun emergency_withdraw<T0: store + key>(arg0: &mut SettlementState, arg1: &SettlementAdminCap, arg2: 0x2::transfer::Receiving<T0>, arg3: address) {
        0x2::transfer::public_transfer<T0>(0x2::transfer::public_receive<T0>(&mut arg0.id, arg2), arg3);
    }

    public fun fulfill_order_swap_a_to_b<T0, T1>(arg0: &mut SettlementState, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u32, arg4: u64, arg5: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = order_key(arg3, arg4);
        assert!(0x2::table::contains<u128, SwapOrder>(&arg0.orders, v0), 1);
        let v1 = 0x2::table::borrow<u128, SwapOrder>(&arg0.orders, v0);
        assert!(!v1.fulfilled, 2);
        let v2 = v1.output_token;
        let v3 = v1.recipient;
        let v4 = v1.quote_id;
        assert!(compute_type_hash<T1>() == address_to_bytes(v2), 6);
        let (v5, v6) = 0x8e1b35f109f185fc12f62f091b1f4ec45d07ee8b116dd87d1b52da59205d0c05::aggregator::swap_a_to_b<T0, T1>(arg1, arg2, 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg5), v1.min_output, arg6, arg7);
        let v7 = v6;
        let v8 = v5;
        if (0x2::coin::value<T0>(&v7) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v7, 0x2::tx_context::sender(arg7));
        } else {
            0x2::coin::destroy_zero<T0>(v7);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v8, v3);
        0x2::table::borrow_mut<u128, SwapOrder>(&mut arg0.orders, v0).fulfilled = true;
        0x8e1b35f109f185fc12f62f091b1f4ec45d07ee8b116dd87d1b52da59205d0c05::events::emit_order_fulfilled(arg3, arg4, 0, 0x2::coin::value<T1>(&v8), v2, v3, 0x2::tx_context::sender(arg7), v4);
    }

    public fun fulfill_order_swap_b_to_a<T0, T1>(arg0: &mut SettlementState, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u32, arg4: u64, arg5: 0x2::transfer::Receiving<0x2::coin::Coin<T1>>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = order_key(arg3, arg4);
        assert!(0x2::table::contains<u128, SwapOrder>(&arg0.orders, v0), 1);
        let v1 = 0x2::table::borrow<u128, SwapOrder>(&arg0.orders, v0);
        assert!(!v1.fulfilled, 2);
        let v2 = v1.output_token;
        let v3 = v1.recipient;
        let v4 = v1.quote_id;
        assert!(compute_type_hash<T0>() == address_to_bytes(v2), 6);
        let (v5, v6) = 0x8e1b35f109f185fc12f62f091b1f4ec45d07ee8b116dd87d1b52da59205d0c05::aggregator::swap_b_to_a<T0, T1>(arg1, arg2, 0x2::transfer::public_receive<0x2::coin::Coin<T1>>(&mut arg0.id, arg5), v1.min_output, arg6, arg7);
        let v7 = v6;
        let v8 = v5;
        if (0x2::coin::value<T1>(&v7) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v7, 0x2::tx_context::sender(arg7));
        } else {
            0x2::coin::destroy_zero<T1>(v7);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v8, v3);
        0x2::table::borrow_mut<u128, SwapOrder>(&mut arg0.orders, v0).fulfilled = true;
        0x8e1b35f109f185fc12f62f091b1f4ec45d07ee8b116dd87d1b52da59205d0c05::events::emit_order_fulfilled(arg3, arg4, 0, 0x2::coin::value<T0>(&v8), v2, v3, 0x2::tx_context::sender(arg7), v4);
    }

    public fun fulfill_order_usdc<T0: drop>(arg0: &mut SettlementState, arg1: u32, arg2: u64, arg3: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = order_key(arg1, arg2);
        assert!(0x2::table::contains<u128, SwapOrder>(&arg0.orders, v0), 1);
        let v1 = 0x2::table::borrow<u128, SwapOrder>(&arg0.orders, v0);
        assert!(!v1.fulfilled, 2);
        let v2 = v1.output_token;
        let v3 = v1.min_output;
        let v4 = v1.recipient;
        let v5 = v1.quote_id;
        let v6 = 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg3);
        assert!(compute_type_hash<T0>() == address_to_bytes(v2), 6);
        let v7 = 0x2::coin::value<T0>(&v6);
        assert!(v7 >= v3, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, v4);
        0x2::table::borrow_mut<u128, SwapOrder>(&mut arg0.orders, v0).fulfilled = true;
        0x8e1b35f109f185fc12f62f091b1f4ec45d07ee8b116dd87d1b52da59205d0c05::events::emit_order_fulfilled(arg1, arg2, 0, v7, v2, v4, 0x2::tx_context::sender(arg5), v5);
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
            id               : 0x2::object::new(arg1),
            oapp_cap         : v0,
            oapp_address     : v2,
            orders           : 0x2::table::new<u128, SwapOrder>(arg1),
            accepted_sources : 0x2::table::new<u32, bool>(arg1),
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
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 32) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1 + v1));
            v1 = v1 + 1;
        };
        0x2::address::from_bytes(v0)
    }

    fun read_u64_le(arg0: &vector<u8>, arg1: u64) : u64 {
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
        assert!(0x2::clock::timestamp_ms(arg4) >= v3.created_at + 86400000, 4);
        let v4 = v3.recipient;
        let v5 = v3.quote_id;
        let v6 = 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, v4);
        0x2::table::borrow_mut<u128, SwapOrder>(&mut arg0.orders, v2).fulfilled = true;
        0x8e1b35f109f185fc12f62f091b1f4ec45d07ee8b116dd87d1b52da59205d0c05::events::emit_fallback_withdrawn(arg1, arg2, 0x2::coin::value<T0>(&v6), v4, v5);
    }

    // decompiled from Move bytecode v6
}

