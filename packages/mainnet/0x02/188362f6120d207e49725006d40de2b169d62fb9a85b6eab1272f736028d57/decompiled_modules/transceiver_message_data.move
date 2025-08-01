module 0x2188362f6120d207e49725006d40de2b169d62fb9a85b6eab1272f736028d57::transceiver_message_data {
    struct TransceiverMessageData<T0> has copy, drop {
        source_ntt_manager_address: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress,
        recipient_ntt_manager_address: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress,
        ntt_manager_payload: 0x2188362f6120d207e49725006d40de2b169d62fb9a85b6eab1272f736028d57::ntt_manager_message::NttManagerMessage<T0>,
    }

    public fun take_bytes(arg0: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::Cursor<u8>) : TransceiverMessageData<vector<u8>> {
        assert!(((0x1::vector::length<u8>(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::data<u8>(arg0)) - 0x1::vector::length<u8>(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::data<u8>(arg0))) as u16) == 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u16_be(arg0), 13906834548005535745);
        TransceiverMessageData<vector<u8>>{
            source_ntt_manager_address    : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::take_bytes(arg0),
            recipient_ntt_manager_address : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::take_bytes(arg0),
            ntt_manager_payload           : 0x2188362f6120d207e49725006d40de2b169d62fb9a85b6eab1272f736028d57::ntt_manager_message::take_bytes(arg0),
        }
    }

    public fun to_bytes(arg0: TransceiverMessageData<vector<u8>>) : vector<u8> {
        let TransceiverMessageData {
            source_ntt_manager_address    : v0,
            recipient_ntt_manager_address : v1,
            ntt_manager_payload           : v2,
        } = arg0;
        let v3 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_bytes(v0));
        0x1::vector::append<u8>(&mut v3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_bytes(v1));
        let v4 = 0x2188362f6120d207e49725006d40de2b169d62fb9a85b6eab1272f736028d57::ntt_manager_message::to_bytes(v2);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u16_be(&mut v3, (0x1::vector::length<u8>(&v4) as u16));
        0x1::vector::append<u8>(&mut v3, 0x2188362f6120d207e49725006d40de2b169d62fb9a85b6eab1272f736028d57::ntt_manager_message::to_bytes(v2));
        v3
    }

    public fun destruct<T0>(arg0: TransceiverMessageData<T0>) : (0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress, 0x2188362f6120d207e49725006d40de2b169d62fb9a85b6eab1272f736028d57::ntt_manager_message::NttManagerMessage<T0>) {
        let TransceiverMessageData {
            source_ntt_manager_address    : v0,
            recipient_ntt_manager_address : v1,
            ntt_manager_payload           : v2,
        } = arg0;
        (v0, v1, v2)
    }

    public fun new<T0>(arg0: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress, arg1: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress, arg2: 0x2188362f6120d207e49725006d40de2b169d62fb9a85b6eab1272f736028d57::ntt_manager_message::NttManagerMessage<T0>) : TransceiverMessageData<T0> {
        TransceiverMessageData<T0>{
            source_ntt_manager_address    : arg0,
            recipient_ntt_manager_address : arg1,
            ntt_manager_payload           : arg2,
        }
    }

    public fun parse(arg0: vector<u8>) : TransceiverMessageData<vector<u8>> {
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg0);
        let v1 = &mut v0;
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(v0);
        take_bytes(v1)
    }

    // decompiled from Move bytecode v6
}

