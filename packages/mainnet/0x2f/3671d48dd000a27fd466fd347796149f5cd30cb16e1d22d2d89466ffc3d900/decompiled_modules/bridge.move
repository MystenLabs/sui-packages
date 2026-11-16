module 0x2f3671d48dd000a27fd466fd347796149f5cd30cb16e1d22d2d89466ffc3d900::bridge {
    struct BRIDGE has drop {
        dummy_field: bool,
    }

    struct DisposableNFT has store, key {
        id: 0x2::object::UID,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
        app: 0x2::object::ID,
    }

    struct Bridge has key {
        id: 0x2::object::UID,
        cap: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap,
        oapp: address,
        nft: 0x1::option::Option<DisposableNFT>,
        backing: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
        route: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
        peer: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
        bound: bool,
        released: bool,
        request: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
        recipient: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
    }

    struct Bound has copy, drop {
        app: 0x2::object::ID,
        peer: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
        route: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
        nft: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
    }

    struct Released has copy, drop {
        app: 0x2::object::ID,
        request: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
        recipient: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
    }

    public fun backing(arg0: &Bridge) : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32 {
        arg0.backing
    }

    public fun bind(arg0: &mut Bridge, arg1: &AdminCap, arg2: &mut 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg3: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::AdminCap, arg4: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2, arg5: &mut 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_channel::MessagingChannel, arg6: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.app == 0x2::object::id<Bridge>(arg0) && !arg0.bound, 2);
        assert!(0x2::object::id_address<0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp>(arg2) == arg0.oapp && !0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::is_zero(&arg6), 1);
        0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::set_peer(arg2, arg3, arg4, arg5, 30102, arg6, arg7);
        arg0.peer = arg6;
        arg0.bound = true;
        let v0 = Bound{
            app   : 0x2::object::id<Bridge>(arg0),
            peer  : arg6,
            route : arg0.route,
            nft   : arg0.backing,
        };
        0x2::event::emit<Bound>(v0);
    }

    public fun confirm_quote(arg0: &Bridge, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_quote::QuoteParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::MessagingFee>) : (0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_quote::QuoteParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::MessagingFee) {
        validate(arg0, arg1);
        0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::confirm_quote(arg1, &arg0.cap, arg2)
    }

    public fun confirm_send(arg0: &Bridge, arg1: &mut 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt>) : (0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt) {
        validate(arg0, arg1);
        0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::confirm_lz_send(arg1, &arg0.cap, arg2)
    }

    fun init(arg0: BRIDGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::new<BRIDGE>(&arg0, arg1);
        let v3 = new_bridge(v0, v2, arg1);
        let v4 = AdminCap{
            id  : 0x2::object::new(arg1),
            app : 0x2::object::id<Bridge>(&v3),
        };
        0x2::transfer::transfer<AdminCap>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::AdminCap>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Bridge>(v3);
    }

    public fun lz_receive(arg0: &mut Bridge, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::LzReceiveParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void>) {
        validate(arg0, arg1);
        let (v0, v1, _, _, v4, _, _, v7) = 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::destroy(0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::lz_receive(arg1, &arg0.cap, arg2));
        let v8 = v7;
        let v9 = v4;
        let v10 = if (v0 == 30102) {
            if (v1 == arg0.peer) {
                0x1::option::is_none<0x2::coin::Coin<0x2::sui::SUI>>(&v8)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v10, 3);
        0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v8);
        process(arg0, &v9);
    }

    fun new_bridge(arg0: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : Bridge {
        let v0 = DisposableNFT{id: 0x2::object::new(arg2)};
        let v1 = 0x2::object::new(arg2);
        Bridge{
            id        : v1,
            cap       : arg0,
            oapp      : arg1,
            nft       : 0x1::option::some<DisposableNFT>(v0),
            backing   : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::from_id(0x2::object::id<DisposableNFT>(&v0)),
            route     : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::from_id(0x2::object::uid_to_inner(&v1)),
            peer      : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::zero_bytes32(),
            bound     : false,
            released  : false,
            request   : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::zero_bytes32(),
            recipient : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::zero_bytes32(),
        }
    }

    fun payload(arg0: &Bridge, arg1: u8) : vector<u8> {
        if (arg1 == 1) {
            assert!(!arg0.released, 1);
            0x2f3671d48dd000a27fd466fd347796149f5cd30cb16e1d22d2d89466ffc3d900::codec::encode(1, arg0.route, arg0.backing, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::zero_bytes32(), 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::zero_bytes32())
        } else {
            assert!(arg1 == 3 && arg0.released, 1);
            0x2f3671d48dd000a27fd466fd347796149f5cd30cb16e1d22d2d89466ffc3d900::codec::encode(3, arg0.route, arg0.backing, arg0.request, arg0.recipient)
        }
    }

    fun process(arg0: &mut Bridge, arg1: &vector<u8>) {
        let (v0, v1, v2, v3, v4) = 0x2f3671d48dd000a27fd466fd347796149f5cd30cb16e1d22d2d89466ffc3d900::codec::decode(arg1);
        let v5 = v4;
        let v6 = v3;
        let v7 = if (v0 == 2) {
            if (v1 == arg0.route) {
                v2 == arg0.backing
            } else {
                false
            }
        } else {
            false
        };
        assert!(v7, 1);
        assert!(!0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::is_zero(&v6) && !0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::is_zero(&v5), 1);
        if (arg0.released) {
            assert!(v6 == arg0.request && v5 == arg0.recipient, 4);
        } else {
            arg0.released = true;
            arg0.request = v6;
            arg0.recipient = v5;
            0x2::transfer::public_transfer<DisposableNFT>(0x1::option::extract<DisposableNFT>(&mut arg0.nft), 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::to_address(&v5));
        };
        let v8 = Released{
            app       : 0x2::object::id<Bridge>(arg0),
            request   : v6,
            recipient : v5,
        };
        0x2::event::emit<Released>(v8);
    }

    public fun quote(arg0: &Bridge, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: u8, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_quote::QuoteParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::MessagingFee> {
        validate(arg0, arg1);
        0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::quote(arg1, &arg0.cap, 30102, payload(arg0, arg2), arg3, false, arg4)
    }

    public fun register(arg0: &Bridge, arg1: &AdminCap, arg2: &mut 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : address {
        assert!(arg1.app == 0x2::object::id<Bridge>(arg0), 2);
        0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::register_oapp(arg2, &arg0.cap, arg3, arg4)
    }

    public fun released(arg0: &Bridge) : bool {
        arg0.released
    }

    public fun route(arg0: &Bridge) : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32 {
        arg0.route
    }

    public fun send(arg0: &Bridge, arg1: &mut 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: u8, arg3: vector<u8>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt> {
        validate(arg0, arg1);
        0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::lz_send(arg1, &arg0.cap, 30102, payload(arg0, arg2), arg3, arg4, 0x1::option::none<0x2::coin::Coin<0x3de1504cf3fd75762759e353d9d95389618e557d0552697f19b52e4e927c1dee::zro::ZRO>>(), 0x1::option::some<address>(0x2::tx_context::sender(arg5)), arg5)
    }

    fun validate(arg0: &Bridge, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp) {
        assert!(0x2::object::id_address<0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp>(arg1) == arg0.oapp, 2);
        assert!(arg0.bound && 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::get_peer(arg1, 30102) == arg0.peer, 3);
    }

    // decompiled from Move bytecode v7
}

