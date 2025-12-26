module 0x4a23ef4f323411fd1fd7852b842f434beb81b2b3e0f5d292a78e7f789c740da6::receiver {
    struct RECEIVER has drop {
        dummy_field: bool,
    }

    struct DecodedPayload has copy, drop, store {
        user_address: vector<u8>,
        amount: u256,
        token_address: vector<u8>,
        source_chain_id: u32,
        message_nonce: u64,
    }

    struct ReceiverStore has key {
        id: 0x2::object::UID,
        last_message: 0x1::option::Option<DecodedPayload>,
        message_count: u64,
        admin: address,
        oapp_cap: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap,
    }

    struct MessageReceived has copy, drop {
        src_eid: u32,
        sender: vector<u8>,
        user_address: vector<u8>,
        amount: u256,
        token_address: vector<u8>,
        source_chain_id: u32,
        message_nonce: u64,
        guid: vector<u8>,
    }

    struct MessageDecodingFailed has copy, drop {
        src_eid: u32,
        sender: vector<u8>,
        raw_payload: vector<u8>,
        error: vector<u8>,
    }

    public fun lz_receive(arg0: &mut ReceiverStore, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::LzReceiveParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::lz_receive(arg1, &arg0.oapp_cap, arg2);
        let v1 = 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::sender(&v0);
        0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::nonce(&v0);
        let v2 = 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::guid(&v0);
        let v3 = decode_payload(0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::message(&v0));
        arg0.last_message = 0x1::option::some<DecodedPayload>(v3);
        arg0.message_count = arg0.message_count + 1;
        let v4 = MessageReceived{
            src_eid         : 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::src_eid(&v0),
            sender          : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::to_bytes(&v1),
            user_address    : v3.user_address,
            amount          : v3.amount,
            token_address   : v3.token_address,
            source_chain_id : v3.source_chain_id,
            message_nonce   : v3.message_nonce,
            guid            : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::to_bytes(&v2),
        };
        0x2::event::emit<MessageReceived>(v4);
        let (_, _, _, _, _, _, _, v12) = 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::destroy(v0);
        let v13 = v12;
        if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&v13)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::option::destroy_some<0x2::coin::Coin<0x2::sui::SUI>>(v13), arg0.admin);
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v13);
        };
    }

    public fun decode_payload(arg0: &vector<u8>) : DecodedPayload {
        assert!(0x1::vector::length<u8>(arg0) >= 108, 1);
        DecodedPayload{
            user_address    : extract_bytes(arg0, 0, 32),
            amount          : extract_u256(arg0, 32),
            token_address   : extract_bytes(arg0, 64, 32),
            source_chain_id : extract_u32(arg0, 96),
            message_nonce   : extract_u64(arg0, 100),
        }
    }

    fun extract_bytes(arg0: &vector<u8>, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < arg2) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1 + v1));
            v1 = v1 + 1;
        };
        v0
    }

    fun extract_u256(arg0: &vector<u8>, arg1: u64) : u256 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 32) {
            let v2 = v0 << 8;
            v0 = v2 | (*0x1::vector::borrow<u8>(arg0, arg1 + v1) as u256);
            v1 = v1 + 1;
        };
        v0
    }

    fun extract_u32(arg0: &vector<u8>, arg1: u64) : u32 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 4) {
            let v2 = v0 << 8;
            v0 = v2 | (*0x1::vector::borrow<u8>(arg0, arg1 + v1) as u32);
            v1 = v1 + 1;
        };
        v0
    }

    fun extract_u64(arg0: &vector<u8>, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 8) {
            let v2 = v0 << 8;
            v0 = v2 | (*0x1::vector::borrow<u8>(arg0, arg1 + v1) as u64);
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_admin(arg0: &ReceiverStore) : address {
        arg0.admin
    }

    public fun get_last_message(arg0: &ReceiverStore) : 0x1::option::Option<DecodedPayload> {
        arg0.last_message
    }

    public fun get_message_count(arg0: &ReceiverStore) : u64 {
        arg0.message_count
    }

    fun init(arg0: RECEIVER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, _) = 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::new<RECEIVER>(&arg0, arg1);
        let v3 = ReceiverStore{
            id            : 0x2::object::new(arg1),
            last_message  : 0x1::option::none<DecodedPayload>(),
            message_count : 0,
            admin         : 0x2::tx_context::sender(arg1),
            oapp_cap      : v0,
        };
        0x2::transfer::share_object<ReceiverStore>(v3);
        0x2::transfer::public_transfer<0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun register_with_endpoint(arg0: &ReceiverStore, arg1: &mut 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : address {
        0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::register_oapp(arg1, &arg0.oapp_cap, arg2, arg3)
    }

    public fun set_peer(arg0: &mut 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::AdminCap, arg2: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2, arg3: &mut 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_channel::MessagingChannel, arg4: u32, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::set_peer(arg0, arg1, arg2, arg3, arg4, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::from_bytes(arg5), arg6);
    }

    public fun update_admin(arg0: &mut ReceiverStore, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 2);
        arg0.admin = arg1;
    }

    // decompiled from Move bytecode v6
}

