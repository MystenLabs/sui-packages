module 0x2188362f6120d207e49725006d40de2b169d62fb9a85b6eab1272f736028d57::transceiver_message {
    struct PrefixOf<phantom T0> has copy, drop {
        prefix: 0x2188362f6120d207e49725006d40de2b169d62fb9a85b6eab1272f736028d57::bytes4::Bytes4,
    }

    struct TransceiverMessage<phantom T0, T1> has copy, drop {
        message_data: 0x2188362f6120d207e49725006d40de2b169d62fb9a85b6eab1272f736028d57::transceiver_message_data::TransceiverMessageData<T1>,
        transceiver_payload: vector<u8>,
    }

    public fun to_bytes<T0>(arg0: TransceiverMessage<T0, vector<u8>>, arg1: PrefixOf<T0>) : vector<u8> {
        let TransceiverMessage {
            message_data        : v0,
            transceiver_payload : v1,
        } = arg0;
        let v2 = v1;
        let v3 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v3, 0x2188362f6120d207e49725006d40de2b169d62fb9a85b6eab1272f736028d57::bytes4::to_bytes(arg1.prefix));
        0x1::vector::append<u8>(&mut v3, 0x2188362f6120d207e49725006d40de2b169d62fb9a85b6eab1272f736028d57::transceiver_message_data::to_bytes(v0));
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u16_be(&mut v3, (0x1::vector::length<u8>(&v2) as u16));
        0x1::vector::append<u8>(&mut v3, v2);
        v3
    }

    public fun destruct<T0, T1>(arg0: TransceiverMessage<T0, T1>) : (0x2188362f6120d207e49725006d40de2b169d62fb9a85b6eab1272f736028d57::transceiver_message_data::TransceiverMessageData<T1>, vector<u8>) {
        let TransceiverMessage {
            message_data        : v0,
            transceiver_payload : v1,
        } = arg0;
        (v0, v1)
    }

    public fun new<T0, T1>(arg0: 0x2188362f6120d207e49725006d40de2b169d62fb9a85b6eab1272f736028d57::transceiver_message_data::TransceiverMessageData<T1>, arg1: vector<u8>) : TransceiverMessage<T0, T1> {
        TransceiverMessage<T0, T1>{
            message_data        : arg0,
            transceiver_payload : arg1,
        }
    }

    public fun parse<T0>(arg0: PrefixOf<T0>, arg1: vector<u8>) : TransceiverMessage<T0, vector<u8>> {
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg1);
        let v1 = &mut v0;
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(v0);
        take_bytes<T0>(arg0, v1)
    }

    public fun prefix<T0>(arg0: &T0, arg1: 0x2188362f6120d207e49725006d40de2b169d62fb9a85b6eab1272f736028d57::bytes4::Bytes4) : PrefixOf<T0> {
        PrefixOf<T0>{prefix: arg1}
    }

    public fun take_bytes<T0>(arg0: PrefixOf<T0>, arg1: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::Cursor<u8>) : TransceiverMessage<T0, vector<u8>> {
        assert!(0x2188362f6120d207e49725006d40de2b169d62fb9a85b6eab1272f736028d57::bytes4::take(arg1) == arg0.prefix, 13906834973207298049);
        TransceiverMessage<T0, vector<u8>>{
            message_data        : 0x2188362f6120d207e49725006d40de2b169d62fb9a85b6eab1272f736028d57::transceiver_message_data::take_bytes(arg1),
            transceiver_payload : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_bytes(arg1, (0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u16_be(arg1) as u64)),
        }
    }

    // decompiled from Move bytecode v6
}

