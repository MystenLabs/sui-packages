module 0x6e9ebc16d35fde59c2fea2dad093b0f9054c147ad5841194fc53de42fd69b98f::my_oapp {
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

    struct OFTReceivedEvent has copy, drop {
        guid: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
        src_eid: u32,
        to_address: address,
        amount_received_ld: u64,
        amount_sd: u64,
        compose_from: 0x1::option::Option<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>,
        compose_msg: 0x1::option::Option<vector<u8>>,
    }

    struct OFTMessage has copy, drop {
        send_to: address,
        amount_sd: u64,
        compose_from: 0x1::option::Option<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>,
        compose_msg: 0x1::option::Option<vector<u8>>,
    }

    struct MsgReceivedEvent has copy, drop {
        guid: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
        src_eid: u32,
        to_address: address,
        msg_received: vector<u8>,
    }

    struct MsgMessage has copy, drop {
        msg: vector<u8>,
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

    public fun lz_receive(arg0: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg1: &0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap, arg2: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::LzReceiveParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void>, arg3: &mut 0x2::tx_context::TxContext) {
        lz_receive_msg_internal(arg0, arg1, arg2, arg3);
    }

    public fun amount_sd(arg0: &OFTMessage) : u64 {
        arg0.amount_sd
    }

    public fun compose_from(arg0: &OFTMessage) : 0x1::option::Option<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32> {
        arg0.compose_from
    }

    public fun compose_msg(arg0: &OFTMessage) : 0x1::option::Option<vector<u8>> {
        arg0.compose_msg
    }

    public fun decode(arg0: vector<u8>) : OFTMessage {
        let v0 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::create(arg0);
        if (0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::remaining_length(&v0) > 0) {
            OFTMessage{send_to: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_address(&mut v0), amount_sd: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_u64(&mut v0), compose_from: 0x1::option::some<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_bytes32(&mut v0)), compose_msg: 0x1::option::some<vector<u8>>(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_bytes_until_end(&mut v0))}
        } else {
            OFTMessage{send_to: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_address(&mut v0), amount_sd: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_u64(&mut v0), compose_from: 0x1::option::none<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>(), compose_msg: 0x1::option::none<vector<u8>>()}
        }
    }

    public fun decode_msg(arg0: vector<u8>) : MsgMessage {
        let v0 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::create(arg0);
        MsgMessage{msg: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_bytes_until_end(&mut v0)}
    }

    public fun encode(arg0: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg1: u64, arg2: 0x1::option::Option<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>, arg3: 0x1::option::Option<vector<u8>>) : vector<u8> {
        let v0 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::new();
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u64(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_bytes32(&mut v0, arg0), arg1);
        if (0x1::option::is_some<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>(&arg2) && 0x1::option::is_some<vector<u8>>(&arg3)) {
            0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_bytes32(&mut v0, 0x1::option::destroy_some<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>(arg2));
            0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_bytes(&mut v0, 0x1::option::destroy_some<vector<u8>>(arg3));
        };
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::to_bytes(v0)
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

    public fun is_composed(arg0: &OFTMessage) : bool {
        0x1::option::is_some<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>(&arg0.compose_from) && 0x1::option::is_some<vector<u8>>(&arg0.compose_msg)
    }

    fun lz_receive_internal<T0>(arg0: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg1: &0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap, arg2: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::LzReceiveParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void>, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, _, v2, v3, v4, _, _, v7) = 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::destroy(0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::lz_receive(arg0, arg1, arg2));
        let v8 = decode(v4);
        0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::utils::transfer_coin_option<0x2::sui::SUI>(v7, 0x2::tx_context::sender(arg3));
        let v9 = OFTReceivedEvent{
            guid               : v3,
            src_eid            : v0,
            to_address         : send_to(&v8),
            amount_received_ld : v2,
            amount_sd          : amount_sd(&v8),
            compose_from       : compose_from(&v8),
            compose_msg        : compose_msg(&v8),
        };
        0x2::event::emit<OFTReceivedEvent>(v9);
    }

    fun lz_receive_msg_internal(arg0: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg1: &0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap, arg2: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::LzReceiveParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void>, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, _, _, v3, v4, _, _, v7) = 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::destroy(0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::lz_receive(arg0, arg1, arg2));
        let v8 = decode_msg(v4);
        0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::utils::transfer_coin_option<0x2::sui::SUI>(v7, 0x2::tx_context::sender(arg3));
        let v9 = MsgReceivedEvent{
            guid         : v3,
            src_eid      : v0,
            to_address   : 0x2::tx_context::sender(arg3),
            msg_received : msg(&v8),
        };
        0x2::event::emit<MsgReceivedEvent>(v9);
    }

    public fun msg(arg0: &MsgMessage) : vector<u8> {
        arg0.msg
    }

    public fun send_to(arg0: &OFTMessage) : address {
        arg0.send_to
    }

    // decompiled from Move bytecode v6
}

