module 0x83651370065f70112b20007137c7235a2a243055d9f59cb5e162c00c4a1680a7::simple_message_lib {
    struct SIMPLE_MESSAGE_LIB has drop {
        dummy_field: bool,
    }

    struct SimpleMessageLib has key {
        id: 0x2::object::UID,
        call_cap: 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::CallCap,
        endpoint: address,
        native_fee: u64,
        zro_fee: u64,
        fee_recipient: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun get_fee_recipient(arg0: &SimpleMessageLib) : address {
        arg0.fee_recipient
    }

    public fun get_native_fee(arg0: &SimpleMessageLib) : u64 {
        arg0.native_fee
    }

    public fun get_zro_fee(arg0: &SimpleMessageLib) : u64 {
        arg0.zro_fee
    }

    fun init(arg0: SIMPLE_MESSAGE_LIB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SimpleMessageLib{
            id            : 0x2::object::new(arg1),
            call_cap      : 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::new_package_cap<SIMPLE_MESSAGE_LIB>(&arg0, arg1),
            endpoint      : 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::package::original_package_of_type<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::EndpointV2>(),
            native_fee    : 100,
            zro_fee       : 99,
            fee_recipient : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<SimpleMessageLib>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun quote(arg0: &SimpleMessageLib, arg1: &mut 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_quote::QuoteParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee::MessagingFee>) {
        0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::assert_caller<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_quote::QuoteParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee::MessagingFee>(arg1, arg0.endpoint);
        let v0 = 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_quote::pay_in_zro(0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::param<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_quote::QuoteParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee::MessagingFee>(arg1));
        validate_zro_fee_payment(arg0, v0);
        let v1 = if (v0) {
            arg0.zro_fee
        } else {
            0
        };
        0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::complete<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_quote::QuoteParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee::MessagingFee>(arg1, &arg0.call_cap, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee::create(arg0.native_fee, v1));
    }

    public fun send(arg0: &SimpleMessageLib, arg1: &0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::EndpointV2, arg2: &mut 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::MessagingChannel, arg3: &mut 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_receipt::MessagingReceipt>, arg4: 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendResult>, arg5: &mut 0x2::tx_context::TxContext) {
        0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::assert_caller<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendResult>(&arg4, arg0.endpoint);
        let v0 = 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_quote::pay_in_zro(0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::base(0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::param<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendResult>(&arg4)));
        validate_zro_fee_payment(arg0, v0);
        let v1 = if (v0) {
            arg0.zro_fee
        } else {
            0
        };
        0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::complete<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendResult>(&mut arg4, &arg0.call_cap, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::create_result(0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::packet_v1_codec::encode_packet(0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_quote::packet(0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::base(0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::param<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendResult>(&arg4)))), 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee::create(arg0.native_fee, v1)));
        let (v2, v3) = 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::confirm_send(arg1, &arg0.call_cap, arg2, arg3, arg4, arg5);
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::utils::transfer_coin<0x2::sui::SUI>(v2, arg0.fee_recipient);
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::utils::transfer_coin<0xcdf19828a455468c4e4ffbd74ad641dddb58b49cd7d043da4cfa12f76c599d0a::zro::ZRO>(v3, arg0.fee_recipient);
    }

    public fun set_config(arg0: &SimpleMessageLib, arg1: 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_set_config::SetConfigParam, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Void>) {
        abort 1
    }

    public fun set_fee_recipient(arg0: &mut SimpleMessageLib, arg1: &AdminCap, arg2: address) {
        arg0.fee_recipient = arg2;
    }

    public fun set_messaging_fee(arg0: &mut SimpleMessageLib, arg1: &AdminCap, arg2: u64, arg3: u64) {
        arg0.zro_fee = arg2;
        arg0.native_fee = arg3;
    }

    public fun validate_packet(arg0: &SimpleMessageLib, arg1: &0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::EndpointV2, arg2: &AdminCap, arg3: &mut 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::MessagingChannel, arg4: vector<u8>, arg5: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32, arg6: &0x2::clock::Clock) {
        let v0 = 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::packet_v1_codec::decode_header(arg4);
        assert!(0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::packet_v1_codec::dst_eid(&v0) == 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::eid(arg1), 3);
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::verify(arg1, &arg0.call_cap, arg3, 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::packet_v1_codec::src_eid(&v0), 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::packet_v1_codec::sender(&v0), 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::packet_v1_codec::nonce(&v0), arg5, arg6);
    }

    fun validate_zro_fee_payment(arg0: &SimpleMessageLib, arg1: bool) {
        assert!(!arg1 || arg0.zro_fee > 0, 2);
    }

    public fun version() : (u64, u8, u8) {
        (0, 0, 2)
    }

    // decompiled from Move bytecode v6
}

