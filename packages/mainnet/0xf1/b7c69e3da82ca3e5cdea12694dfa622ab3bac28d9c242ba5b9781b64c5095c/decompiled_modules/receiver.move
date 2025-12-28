module 0xf1b7c69e3da82ca3e5cdea12694dfa622ab3bac28d9c242ba5b9781b64c5095c::receiver {
    struct RECEIVER has drop {
        dummy_field: bool,
    }

    struct OFTMessage has copy, drop {
        send_to: address,
        amount_sd: u64,
    }

    struct OFT has key {
        id: 0x2::object::UID,
        oft_cap: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap,
    }

    struct OFTInitTicket has key {
        id: 0x2::object::UID,
        oft_cap: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap,
        oapp_object: address,
        admin_cap: 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::AdminCap,
    }

    struct OFTInfoV1 has copy, drop, store {
        oft_package: address,
        oft_object: address,
    }

    struct OFTReceivedEvent has copy, drop {
        guid: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
        src_eid: u32,
        send_to: address,
        amount_sd: u64,
    }

    public fun lz_receive(arg0: &mut OFT, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::LzReceiveParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void>) {
        let (v0, _, _, v3, v4, _, _, v7) = 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::destroy(0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::lz_receive(arg1, &arg0.oft_cap, arg2));
        let v8 = v7;
        let v9 = decode(v4);
        if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&v8)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::option::destroy_some<0x2::coin::Coin<0x2::sui::SUI>>(v8), v9.send_to);
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v8);
        };
        let v10 = OFTReceivedEvent{
            guid      : v3,
            src_eid   : v0,
            send_to   : v9.send_to,
            amount_sd : v9.amount_sd,
        };
        0x2::event::emit<OFTReceivedEvent>(v10);
    }

    fun decode(arg0: vector<u8>) : OFTMessage {
        let v0 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::create(arg0);
        OFTMessage{
            send_to   : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_address(&mut v0),
            amount_sd : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_u64(&mut v0),
        }
    }

    fun init(arg0: RECEIVER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::new<RECEIVER>(&arg0, arg1);
        let v3 = OFTInitTicket{
            id          : 0x2::object::new(arg1),
            oft_cap     : v0,
            oapp_object : v2,
            admin_cap   : v1,
        };
        0x2::transfer::transfer<OFTInitTicket>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun init_oft(arg0: OFTInitTicket, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: &mut 0x2::tx_context::TxContext) : 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::AdminCap {
        let OFTInitTicket {
            id          : v0,
            oft_cap     : v1,
            oapp_object : v2,
            admin_cap   : v3,
        } = arg0;
        let v4 = v1;
        assert!(v2 == 0x2::object::id_address<0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp>(arg1), 0);
        0x2::object::delete(v0);
        0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::assert_oapp_cap(arg1, &v4);
        let v5 = OFT{
            id      : 0x2::object::new(arg2),
            oft_cap : v4,
        };
        0x2::transfer::share_object<OFT>(v5);
        v3
    }

    fun oft_info_encode(arg0: &OFT) : vector<u8> {
        let v0 = OFTInfoV1{
            oft_package : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::package::package_of_type<OFT>(),
            oft_object  : 0x2::object::id_address<OFT>(arg0),
        };
        let v1 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::new();
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_bytes(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u16(&mut v1, 1), 0x2::bcs::to_bytes<OFTInfoV1>(&v0));
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::to_bytes(v1)
    }

    public fun register_oapp(arg0: &OFT, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::AdminCap, arg3: &mut 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::assert_oapp_cap(arg1, &arg0.oft_cap);
        let v0 = 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp_info_v1::create(0x2::object::id_address<0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp>(arg1), b"", arg4, oft_info_encode(arg0));
        0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::endpoint_calls::register_oapp(arg1, arg2, arg3, 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp_info_v1::encode(&v0), arg5);
    }

    // decompiled from Move bytecode v6
}

