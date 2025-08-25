module 0x3bb0f8d38d0e3e64c7b23cd98f51ba07f4949698472daf381c37bad6c39e05a0::outbound_message {
    struct OutboundMessage<phantom T0, phantom T1> {
        message: 0x3bb0f8d38d0e3e64c7b23cd98f51ba07f4949698472daf381c37bad6c39e05a0::ntt_manager_message::NttManagerMessage<vector<u8>>,
        source_ntt_manager: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress,
        recipient_ntt_manager: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress,
    }

    public fun new<T0, T1, T2: key>(arg0: &T0, arg1: &T2, arg2: 0x3bb0f8d38d0e3e64c7b23cd98f51ba07f4949698472daf381c37bad6c39e05a0::ntt_manager_message::NttManagerMessage<vector<u8>>, arg3: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress) : OutboundMessage<T0, T1> {
        OutboundMessage<T0, T1>{
            message               : arg2,
            source_ntt_manager    : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::from_address(0x3bb0f8d38d0e3e64c7b23cd98f51ba07f4949698472daf381c37bad6c39e05a0::contract_auth::auth_as<T0, T2>(arg0, b"ManagerAuth", arg1)),
            recipient_ntt_manager : arg3,
        }
    }

    public fun unwrap_outbound_message<T0, T1>(arg0: OutboundMessage<T0, T1>, arg1: &T1) : (0x3bb0f8d38d0e3e64c7b23cd98f51ba07f4949698472daf381c37bad6c39e05a0::ntt_manager_message::NttManagerMessage<vector<u8>>, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress) {
        0x3bb0f8d38d0e3e64c7b23cd98f51ba07f4949698472daf381c37bad6c39e05a0::contract_auth::assert_auth_type<T1>(arg1, b"TransceiverAuth");
        let OutboundMessage {
            message               : v0,
            source_ntt_manager    : v1,
            recipient_ntt_manager : v2,
        } = arg0;
        (v0, v1, v2)
    }

    // decompiled from Move bytecode v6
}

