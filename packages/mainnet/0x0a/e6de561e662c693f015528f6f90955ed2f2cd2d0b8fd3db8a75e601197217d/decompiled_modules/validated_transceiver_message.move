module 0xae6de561e662c693f015528f6f90955ed2f2cd2d0b8fd3db8a75e601197217d::validated_transceiver_message {
    struct ValidatedTransceiverMessage<phantom T0, T1> {
        from_chain: u16,
        message: 0xae6de561e662c693f015528f6f90955ed2f2cd2d0b8fd3db8a75e601197217d::transceiver_message_data::TransceiverMessageData<T1>,
    }

    public fun destruct_recipient_only<T0, T1, T2: key, T3>(arg0: ValidatedTransceiverMessage<T0, T3>, arg1: &T1, arg2: &T2) : (u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress, 0xae6de561e662c693f015528f6f90955ed2f2cd2d0b8fd3db8a75e601197217d::ntt_manager_message::NttManagerMessage<T3>) {
        let ValidatedTransceiverMessage {
            from_chain : v0,
            message    : v1,
        } = arg0;
        let (v2, v3, v4) = 0xae6de561e662c693f015528f6f90955ed2f2cd2d0b8fd3db8a75e601197217d::transceiver_message_data::destruct<T3>(v1);
        assert!(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::from_address(0xae6de561e662c693f015528f6f90955ed2f2cd2d0b8fd3db8a75e601197217d::contract_auth::auth_as<T1, T2>(arg1, b"ManagerAuth", arg2)) == v3, 13906834410566582273);
        (v0, v2, v4)
    }

    public fun new<T0, T1>(arg0: &T0, arg1: u16, arg2: 0xae6de561e662c693f015528f6f90955ed2f2cd2d0b8fd3db8a75e601197217d::transceiver_message_data::TransceiverMessageData<T1>) : ValidatedTransceiverMessage<T0, T1> {
        0xae6de561e662c693f015528f6f90955ed2f2cd2d0b8fd3db8a75e601197217d::contract_auth::assert_auth_type<T0>(arg0, b"TransceiverAuth");
        ValidatedTransceiverMessage<T0, T1>{
            from_chain : arg1,
            message    : arg2,
        }
    }

    // decompiled from Move bytecode v6
}

