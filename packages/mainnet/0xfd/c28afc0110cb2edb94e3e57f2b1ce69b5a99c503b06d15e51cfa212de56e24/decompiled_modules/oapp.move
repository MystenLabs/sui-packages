module 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct OApp has key {
        id: 0x2::object::UID,
        oapp_cap: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap,
        admin_cap: address,
        peer: 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp_peer::Peer,
        enforced_options: 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::enforced_options::EnforcedOptions,
        sending_call: 0x1::option::Option<address>,
    }

    public fun new<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) : (0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap, AdminCap, address) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = OApp{
            id               : 0x2::object::new(arg1),
            oapp_cap         : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::new_package_cap<T0>(arg0, arg1),
            admin_cap        : 0x2::object::id_address<AdminCap>(&v0),
            peer             : 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp_peer::new(arg1),
            enforced_options : 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::enforced_options::new(arg1),
            sending_call     : 0x1::option::none<address>(),
        };
        0x2::transfer::share_object<OApp>(v1);
        (0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::new_package_cap<T0>(arg0, arg1), v0, 0x2::object::id_address<OApp>(&v1))
    }

    public fun lz_receive(arg0: &OApp, arg1: &0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap, arg2: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::LzReceiveParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void>) : 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::LzReceiveParam {
        assert_oapp_cap(arg0, arg1);
        assert!(0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::caller<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::LzReceiveParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void>(&arg2) == 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::package::original_package_of_type<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2>(), 5);
        let v0 = 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::complete_and_destroy<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::LzReceiveParam>(arg2, arg1);
        assert!(get_peer(arg0, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::src_eid(&v0)) == 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::sender(&v0), 6);
        v0
    }

    public fun combine_options(arg0: &OApp, arg1: u32, arg2: u16, arg3: vector<u8>) : vector<u8> {
        0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::enforced_options::combine_options(&arg0.enforced_options, arg1, arg2, arg3)
    }

    public fun get_enforced_options(arg0: &OApp, arg1: u32, arg2: u16) : &vector<u8> {
        0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::enforced_options::get_enforced_options(&arg0.enforced_options, arg1, arg2)
    }

    public fun set_enforced_options(arg0: &mut OApp, arg1: &AdminCap, arg2: u32, arg3: u16, arg4: vector<u8>) {
        assert_admin(arg0, arg1);
        0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::enforced_options::set_enforced_options(&mut arg0.enforced_options, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::id(&arg0.oapp_cap), arg2, arg3, arg4);
    }

    public fun admin_cap(arg0: &OApp) : address {
        arg0.admin_cap
    }

    public fun assert_admin(arg0: &OApp, arg1: &AdminCap) {
        assert!(0x2::object::id_address<AdminCap>(arg1) == arg0.admin_cap, 1);
    }

    public fun assert_oapp_cap(arg0: &OApp, arg1: &0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap) {
        assert!(0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::id(arg1) == oapp_cap_id(arg0), 2);
    }

    public fun confirm_lz_send(arg0: &mut OApp, arg1: &0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap, arg2: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt>) : (0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt) {
        assert_oapp_cap(arg0, arg1);
        assert!(0x1::option::some<address>(0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::id<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt>(&arg2)) == arg0.sending_call, 4);
        arg0.sending_call = 0x1::option::none<address>();
        let (_, v1, v2) = 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::destroy<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt>(arg2, arg1);
        (v1, v2)
    }

    public fun confirm_quote(arg0: &OApp, arg1: &0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap, arg2: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_quote::QuoteParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::MessagingFee>) : (0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_quote::QuoteParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::MessagingFee) {
        assert_oapp_cap(arg0, arg1);
        let (v0, v1, v2) = 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::destroy<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_quote::QuoteParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::MessagingFee>(arg2, arg1);
        assert!(v0 == 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::package::original_package_of_type<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2>(), 5);
        (v1, v2)
    }

    public fun get_peer(arg0: &OApp, arg1: u32) : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32 {
        0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp_peer::get_peer(&arg0.peer, arg1)
    }

    public fun has_peer(arg0: &OApp, arg1: u32) : bool {
        0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp_peer::has_peer(&arg0.peer, arg1)
    }

    public fun lz_send(arg0: &mut OApp, arg1: &0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap, arg2: u32, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: 0x1::option::Option<0x2::coin::Coin<0x3de1504cf3fd75762759e353d9d95389618e557d0552697f19b52e4e927c1dee::zro::ZRO>>, arg7: 0x1::option::Option<address>, arg8: &mut 0x2::tx_context::TxContext) : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt> {
        assert_oapp_cap(arg0, arg1);
        assert!(0x1::option::is_none<address>(&arg0.sending_call), 7);
        assert!(0x1::option::is_none<address>(&arg7) || *0x1::option::borrow<address>(&arg7) != @0x0, 3);
        let v0 = 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::create<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt>(arg1, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::package::original_package_of_type<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2>(), false, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::create_param(arg2, 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp_peer::get_peer(&arg0.peer, arg2), arg3, arg4, arg5, arg6, arg7), arg8);
        0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::enable_mutable_param<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt>(&mut v0, arg1);
        arg0.sending_call = 0x1::option::some<address>(0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::id<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt>(&v0));
        v0
    }

    public fun lz_send_and_refund(arg0: &OApp, arg1: &0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap, arg2: u32, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: 0x1::option::Option<0x2::coin::Coin<0x3de1504cf3fd75762759e353d9d95389618e557d0552697f19b52e4e927c1dee::zro::ZRO>>, arg7: address, arg8: &mut 0x2::tx_context::TxContext) : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt> {
        assert_oapp_cap(arg0, arg1);
        assert!(arg7 != @0x0, 3);
        let v0 = 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::create<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt>(arg1, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::package::original_package_of_type<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2>(), true, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::create_param(arg2, 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp_peer::get_peer(&arg0.peer, arg2), arg3, arg4, arg5, arg6, 0x1::option::some<address>(arg7)), arg8);
        0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::enable_mutable_param<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt>(&mut v0, arg1);
        v0
    }

    public(friend) fun oapp_cap(arg0: &OApp) : &0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap {
        &arg0.oapp_cap
    }

    public fun oapp_cap_id(arg0: &OApp) : address {
        0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::id(&arg0.oapp_cap)
    }

    public fun quote(arg0: &OApp, arg1: &0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap, arg2: u32, arg3: vector<u8>, arg4: vector<u8>, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_quote::QuoteParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::MessagingFee> {
        assert_oapp_cap(arg0, arg1);
        0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::create<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_quote::QuoteParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::MessagingFee>(arg1, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::package::original_package_of_type<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2>(), false, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_quote::create_param(arg2, 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp_peer::get_peer(&arg0.peer, arg2), arg3, arg4, arg5), arg6)
    }

    public fun set_peer(arg0: &mut OApp, arg1: &AdminCap, arg2: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2, arg3: &mut 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_channel::MessagingChannel, arg4: u32, arg5: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg6: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        if (!0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::is_channel_inited(arg3, arg4, arg5)) {
            0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::init_channel(arg2, oapp_cap(arg0), arg3, arg4, arg5, arg6);
        };
        0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp_peer::set_peer(&mut arg0.peer, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::id(&arg0.oapp_cap), arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

