module 0x6af5bd45bd8e8f7fb5282a146f5143a6eb393e2b4479df40709bba8f584e3d06::gateway {
    struct GATEWAY has drop {
        dummy_field: bool,
    }

    struct GatewayAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct DestConfig has copy, drop, store {
        cctp_domain: u32,
        mint_recipient: address,
        active: bool,
    }

    struct GatewayState has key {
        id: 0x2::object::UID,
        oapp_cap: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap,
        destinations: 0x2::table::Table<u32, DestConfig>,
        paused: bool,
    }

    entry fun activate_destination(arg0: &mut GatewayState, arg1: &GatewayAdminCap, arg2: u32) {
        assert!(0x2::table::contains<u32, DestConfig>(&arg0.destinations, arg2), 6);
        0x2::table::borrow_mut<u32, DestConfig>(&mut arg0.destinations, arg2).active = true;
        let v0 = *0x2::table::borrow<u32, DestConfig>(&arg0.destinations, arg2);
        0x6af5bd45bd8e8f7fb5282a146f5143a6eb393e2b4479df40709bba8f584e3d06::events::emit_destination_updated(arg2, v0.cctp_domain, v0.mint_recipient, true);
    }

    entry fun add_destination(arg0: &mut GatewayState, arg1: &GatewayAdminCap, arg2: u32, arg3: u32, arg4: address) {
        assert!(!0x2::table::contains<u32, DestConfig>(&arg0.destinations, arg2), 8);
        assert!(arg4 != @0x0, 9);
        let v0 = DestConfig{
            cctp_domain    : arg3,
            mint_recipient : arg4,
            active         : true,
        };
        0x2::table::add<u32, DestConfig>(&mut arg0.destinations, arg2, v0);
        0x6af5bd45bd8e8f7fb5282a146f5143a6eb393e2b4479df40709bba8f584e3d06::events::emit_destination_updated(arg2, arg3, arg4, true);
    }

    fun compute_type_hash<T0>() : address {
        let v0 = b"0x";
        0x1::vector::append<u8>(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        0x2::address::from_bytes(0x2::hash::blake2b256(&v0))
    }

    entry fun deactivate_destination(arg0: &mut GatewayState, arg1: &GatewayAdminCap, arg2: u32) {
        assert!(0x2::table::contains<u32, DestConfig>(&arg0.destinations, arg2), 6);
        0x2::table::borrow_mut<u32, DestConfig>(&mut arg0.destinations, arg2).active = false;
        let v0 = *0x2::table::borrow<u32, DestConfig>(&arg0.destinations, arg2);
        0x6af5bd45bd8e8f7fb5282a146f5143a6eb393e2b4479df40709bba8f584e3d06::events::emit_destination_updated(arg2, v0.cctp_domain, v0.mint_recipient, false);
    }

    public fun destination_active(arg0: &GatewayState, arg1: u32) : bool {
        if (!0x2::table::contains<u32, DestConfig>(&arg0.destinations, arg1)) {
            return false
        };
        0x2::table::borrow<u32, DestConfig>(&arg0.destinations, arg1).active
    }

    public fun destination_cctp_domain(arg0: &GatewayState, arg1: u32) : u32 {
        0x2::table::borrow<u32, DestConfig>(&arg0.destinations, arg1).cctp_domain
    }

    public fun destination_mint_recipient(arg0: &GatewayState, arg1: u32) : address {
        0x2::table::borrow<u32, DestConfig>(&arg0.destinations, arg1).mint_recipient
    }

    entry fun emergency_cctp_recover(arg0: &GatewayState, arg1: &GatewayAdminCap, arg2: vector<u8>, arg3: vector<u8>, arg4: address, arg5: &0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::State, arg6: &0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State) {
        assert!(arg4 != @0x0, 9);
        let (_, _) = 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::deposit_for_burn::replace_deposit_for_burn_with_package_auth<0x6af5bd45bd8e8f7fb5282a146f5143a6eb393e2b4479df40709bba8f584e3d06::auth::GatewayAuth>(0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::deposit_for_burn::create_replace_deposit_for_burn_ticket<0x6af5bd45bd8e8f7fb5282a146f5143a6eb393e2b4479df40709bba8f584e3d06::auth::GatewayAuth>(0x6af5bd45bd8e8f7fb5282a146f5143a6eb393e2b4479df40709bba8f584e3d06::auth::new(), arg2, arg3, 0x1::option::none<address>(), 0x1::option::some<address>(arg4)), arg5, arg6);
        0x6af5bd45bd8e8f7fb5282a146f5143a6eb393e2b4479df40709bba8f584e3d06::events::emit_emergency_cctp_recover(arg4);
    }

    entry fun emergency_pause(arg0: &mut GatewayState, arg1: &GatewayAdminCap) {
        arg0.paused = true;
        0x6af5bd45bd8e8f7fb5282a146f5143a6eb393e2b4479df40709bba8f584e3d06::events::emit_paused(true);
    }

    entry fun emergency_unpause(arg0: &mut GatewayState, arg1: &GatewayAdminCap) {
        arg0.paused = false;
        0x6af5bd45bd8e8f7fb5282a146f5143a6eb393e2b4479df40709bba8f584e3d06::events::emit_paused(false);
    }

    public fun encode_swap_order(arg0: u64, arg1: address, arg2: u64, arg3: address, arg4: u64, arg5: u64, arg6: address, arg7: u64, arg8: address, arg9: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 2);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg6));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg7));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg8));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg9));
        v0
    }

    public fun has_destination(arg0: &GatewayState, arg1: u32) : bool {
        0x2::table::contains<u32, DestConfig>(&arg0.destinations, arg1)
    }

    fun init(arg0: GATEWAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, _) = 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::new<GATEWAY>(&arg0, arg1);
        let v3 = GatewayState{
            id           : 0x2::object::new(arg1),
            oapp_cap     : v0,
            destinations : 0x2::table::new<u32, DestConfig>(arg1),
            paused       : false,
        };
        0x2::transfer::share_object<GatewayState>(v3);
        0x2::transfer::public_transfer<0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::AdminCap>(v1, 0x2::tx_context::sender(arg1));
        let v4 = GatewayAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<GatewayAdminCap>(v4, 0x2::tx_context::sender(arg1));
    }

    public fun initiate_order<T0: drop>(arg0: &mut GatewayState, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: u32, arg3: 0x2::coin::Coin<T0>, arg4: address, arg5: u64, arg6: address, arg7: u64, arg8: u64, arg9: u64, arg10: address, arg11: u64, arg12: address, arg13: vector<u8>, arg14: 0x2::coin::Coin<0x2::sui::SUI>, arg15: &0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::State, arg16: &mut 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State, arg17: &0x2::deny_list::DenyList, arg18: &mut 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::Treasury<T0>, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt> {
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(v0 > 0, 0);
        assert!(arg5 > 0, 1);
        assert!(0x2::table::contains<u32, DestConfig>(&arg0.destinations, arg2), 6);
        let v1 = *0x2::table::borrow<u32, DestConfig>(&arg0.destinations, arg2);
        assert!(v1.active, 7);
        initiate_order_internal<T0>(arg0, arg1, v1, arg3, arg2, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, compute_type_hash<T0>(), v0, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20)
    }

    fun initiate_order_internal<T0: drop>(arg0: &mut GatewayState, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: DestConfig, arg3: 0x2::coin::Coin<T0>, arg4: u32, arg5: address, arg6: u64, arg7: address, arg8: u64, arg9: u64, arg10: u64, arg11: address, arg12: u64, arg13: address, arg14: address, arg15: u64, arg16: vector<u8>, arg17: 0x2::coin::Coin<0x2::sui::SUI>, arg18: &0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::State, arg19: &mut 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State, arg20: &0x2::deny_list::DenyList, arg21: &mut 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::Treasury<T0>, arg22: &0x2::clock::Clock, arg23: &mut 0x2::tx_context::TxContext) : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt> {
        assert!(!arg0.paused, 10);
        assert!(0x2::clock::timestamp_ms(arg22) / 1000 <= arg9, 11);
        let (_, v1) = 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::deposit_for_burn::deposit_for_burn_with_package_auth<T0, 0x6af5bd45bd8e8f7fb5282a146f5143a6eb393e2b4479df40709bba8f584e3d06::auth::GatewayAuth>(0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::deposit_for_burn::create_deposit_for_burn_ticket<T0, 0x6af5bd45bd8e8f7fb5282a146f5143a6eb393e2b4479df40709bba8f584e3d06::auth::GatewayAuth>(0x6af5bd45bd8e8f7fb5282a146f5143a6eb393e2b4479df40709bba8f584e3d06::auth::new(), arg3, arg2.cctp_domain, arg2.mint_recipient), arg18, arg19, arg20, arg21, arg23);
        let v2 = v1;
        let v3 = 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::nonce(&v2);
        let v4 = 0x2::clock::timestamp_ms(arg22) / 1000;
        0x6af5bd45bd8e8f7fb5282a146f5143a6eb393e2b4479df40709bba8f584e3d06::events::emit_swap_order_created(v3, 0x2::tx_context::sender(arg23), 0x2::coin::value<T0>(&arg3), arg5, arg6, arg7, v4, arg4, 1, arg8, arg10, arg11, arg12, arg13, arg14, arg15);
        0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::lz_send_and_refund(arg1, &arg0.oapp_cap, arg4, encode_swap_order(v3, arg5, arg6, arg7, arg8, arg10, arg11, arg12, arg13, v4), arg16, arg17, 0x1::option::none<0x2::coin::Coin<0x3de1504cf3fd75762759e353d9d95389618e557d0552697f19b52e4e927c1dee::zro::ZRO>>(), 0x2::tx_context::sender(arg23), arg23)
    }

    public fun initiate_order_with_swap_a_to_b<T0, T1: drop>(arg0: &mut GatewayState, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: u32, arg7: address, arg8: u64, arg9: address, arg10: u64, arg11: u64, arg12: u64, arg13: address, arg14: u64, arg15: address, arg16: vector<u8>, arg17: 0x2::coin::Coin<0x2::sui::SUI>, arg18: &0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::State, arg19: &mut 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State, arg20: &0x2::deny_list::DenyList, arg21: &mut 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::Treasury<T1>, arg22: &0x2::clock::Clock, arg23: &mut 0x2::tx_context::TxContext) : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt> {
        assert!(0x2::coin::value<T0>(&arg4) > 0, 0);
        assert!(arg8 > 0, 1);
        assert!(0x2::table::contains<u32, DestConfig>(&arg0.destinations, arg6), 6);
        let v0 = *0x2::table::borrow<u32, DestConfig>(&arg0.destinations, arg6);
        assert!(v0.active, 7);
        assert!(!arg0.paused, 10);
        assert!(0x2::clock::timestamp_ms(arg22) / 1000 <= arg11, 11);
        let (v1, v2) = 0x6af5bd45bd8e8f7fb5282a146f5143a6eb393e2b4479df40709bba8f584e3d06::aggregator::swap_a_to_b<T0, T1>(arg2, arg3, arg4, arg5, arg22, arg23);
        0x2::coin::destroy_zero<T0>(v2);
        initiate_order_internal<T1>(arg0, arg1, v0, v1, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, compute_type_hash<T0>(), 0x2::coin::value<T0>(&arg4), arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23)
    }

    public fun initiate_order_with_swap_b_to_a<T0: drop, T1>(arg0: &mut GatewayState, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u32, arg7: address, arg8: u64, arg9: address, arg10: u64, arg11: u64, arg12: u64, arg13: address, arg14: u64, arg15: address, arg16: vector<u8>, arg17: 0x2::coin::Coin<0x2::sui::SUI>, arg18: &0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::State, arg19: &mut 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State, arg20: &0x2::deny_list::DenyList, arg21: &mut 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::Treasury<T0>, arg22: &0x2::clock::Clock, arg23: &mut 0x2::tx_context::TxContext) : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt> {
        assert!(0x2::coin::value<T1>(&arg4) > 0, 0);
        assert!(arg8 > 0, 1);
        assert!(0x2::table::contains<u32, DestConfig>(&arg0.destinations, arg6), 6);
        let v0 = *0x2::table::borrow<u32, DestConfig>(&arg0.destinations, arg6);
        assert!(v0.active, 7);
        assert!(!arg0.paused, 10);
        assert!(0x2::clock::timestamp_ms(arg22) / 1000 <= arg11, 11);
        let (v1, v2) = 0x6af5bd45bd8e8f7fb5282a146f5143a6eb393e2b4479df40709bba8f584e3d06::aggregator::swap_b_to_a<T0, T1>(arg2, arg3, arg4, arg5, arg22, arg23);
        0x2::coin::destroy_zero<T1>(v2);
        initiate_order_internal<T0>(arg0, arg1, v0, v1, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, compute_type_hash<T1>(), 0x2::coin::value<T1>(&arg4), arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23)
    }

    public fun is_paused(arg0: &GatewayState) : bool {
        arg0.paused
    }

    public fun quote_fee(arg0: &GatewayState, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: u32, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_quote::QuoteParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::MessagingFee> {
        0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::quote(arg1, &arg0.oapp_cap, arg2, arg3, arg4, false, arg5)
    }

    entry fun set_mint_recipient(arg0: &mut GatewayState, arg1: &GatewayAdminCap, arg2: u32, arg3: address) {
        assert!(0x2::table::contains<u32, DestConfig>(&arg0.destinations, arg2), 6);
        assert!(arg3 != @0x0, 9);
        0x2::table::borrow_mut<u32, DestConfig>(&mut arg0.destinations, arg2).mint_recipient = arg3;
        let v0 = *0x2::table::borrow<u32, DestConfig>(&arg0.destinations, arg2);
        0x6af5bd45bd8e8f7fb5282a146f5143a6eb393e2b4479df40709bba8f584e3d06::events::emit_destination_updated(arg2, v0.cctp_domain, v0.mint_recipient, v0.active);
    }

    // decompiled from Move bytecode v6
}

