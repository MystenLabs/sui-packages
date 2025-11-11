module 0xc3fb5558194e623e3bfeda6f53a99e6ebe950247899b2a5fb62b35fc35423a75::my_oapp {
    struct MessageSentEvent has copy, drop {
        guid: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
        dst_eid: u32,
        nonce: u64,
    }

    struct MessageReceivedEvent has copy, drop {
        guid: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
        src_eid: u32,
        sender: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
        nonce: u64,
        executor: address,
        payload: vector<u8>,
        extra_data: vector<u8>,
    }

    struct MyOApp has key {
        id: 0x2::object::UID,
        oapp_address: address,
        messaging_channel: 0x1::option::Option<address>,
        last_message: vector<u8>,
        last_src_eid: u32,
        last_sender: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
        last_guid: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
        last_nonce: u64,
    }

    struct MY_OAPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MY_OAPP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2, v3) = 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::new<MY_OAPP>(&arg0, arg1);
        let v4 = MyOApp{
            id                : 0x2::object::new(arg1),
            oapp_address      : v3,
            messaging_channel : 0x1::option::none<address>(),
            last_message      : 0x1::vector::empty<u8>(),
            last_src_eid      : 0,
            last_sender       : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::zero_bytes32(),
            last_guid         : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::zero_bytes32(),
            last_nonce        : 0,
        };
        0x2::transfer::public_transfer<0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap>(v1, v0);
        0x2::transfer::public_transfer<0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::AdminCap>(v2, v0);
        0x2::transfer::transfer<MyOApp>(v4, v0);
    }

    // decompiled from Move bytecode v6
}

