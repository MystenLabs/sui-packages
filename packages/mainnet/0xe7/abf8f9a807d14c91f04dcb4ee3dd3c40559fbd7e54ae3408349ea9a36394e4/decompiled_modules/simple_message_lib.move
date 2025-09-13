module 0xe7abf8f9a807d14c91f04dcb4ee3dd3c40559fbd7e54ae3408349ea9a36394e4::simple_message_lib {
    struct SIMPLE_MESSAGE_LIB has drop {
        dummy_field: bool,
    }

    struct SimpleMessageLib has key {
        id: 0x2::object::UID,
        call_cap: 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::CallCap,
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
            call_cap      : 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::new_package_cap<SIMPLE_MESSAGE_LIB>(&arg0, arg1),
            endpoint      : 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::package::original_package_of_type<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::EndpointV2>(),
            native_fee    : 100,
            zro_fee       : 99,
            fee_recipient : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<SimpleMessageLib>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun quote(arg0: &SimpleMessageLib, arg1: &mut 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_quote::QuoteParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_fee::MessagingFee>) {
        0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::assert_caller<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_quote::QuoteParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_fee::MessagingFee>(arg1, arg0.endpoint);
        let v0 = 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_quote::pay_in_zro(0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::param<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_quote::QuoteParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_fee::MessagingFee>(arg1));
        validate_zro_fee_payment(arg0, v0);
        let v1 = if (v0) {
            arg0.zro_fee
        } else {
            0
        };
        0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::complete<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_quote::QuoteParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_fee::MessagingFee>(arg1, &arg0.call_cap, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_fee::create(arg0.native_fee, v1));
    }

    public fun send(arg0: &SimpleMessageLib, arg1: &0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::EndpointV2, arg2: &mut 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_channel::MessagingChannel, arg3: &mut 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_send::SendParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_receipt::MessagingReceipt>, arg4: 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_send::SendParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_send::SendResult>, arg5: &mut 0x2::tx_context::TxContext) {
        0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::assert_caller<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_send::SendParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_send::SendResult>(&arg4, arg0.endpoint);
        let v0 = 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_quote::pay_in_zro(0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_send::base(0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::param<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_send::SendParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_send::SendResult>(&arg4)));
        validate_zro_fee_payment(arg0, v0);
        let v1 = if (v0) {
            arg0.zro_fee
        } else {
            0
        };
        0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::complete<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_send::SendParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_send::SendResult>(&mut arg4, &arg0.call_cap, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_send::create_result(0x5d62c9e28bb3af663b8fd746d36293cd642c26acf8836028eebb6b72ba55ccdc::packet_v1_codec::encode_packet(0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_quote::packet(0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_send::base(0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::param<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_send::SendParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_send::SendResult>(&arg4)))), 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_fee::create(arg0.native_fee, v1)));
        let (v2, v3) = 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::confirm_send(arg1, &arg0.call_cap, arg2, arg3, arg4, arg5);
        0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::utils::transfer_coin<0x2::sui::SUI>(v2, arg0.fee_recipient);
        0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::utils::transfer_coin<0x30675609f2d9bf3fbd6ae9f3720a9769146a1d1421dfe92506fa63f2670c1627::zro::ZRO>(v3, arg0.fee_recipient);
    }

    public fun set_config(arg0: &SimpleMessageLib, arg1: 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_set_config::SetConfigParam, 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Void>) {
        abort 1
    }

    public fun set_fee_recipient(arg0: &mut SimpleMessageLib, arg1: &AdminCap, arg2: address) {
        arg0.fee_recipient = arg2;
    }

    public fun set_messaging_fee(arg0: &mut SimpleMessageLib, arg1: &AdminCap, arg2: u64, arg3: u64) {
        arg0.zro_fee = arg2;
        arg0.native_fee = arg3;
    }

    public fun validate_packet(arg0: &SimpleMessageLib, arg1: &0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::EndpointV2, arg2: &AdminCap, arg3: &mut 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_channel::MessagingChannel, arg4: vector<u8>, arg5: 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32, arg6: &0x2::clock::Clock) {
        let v0 = 0x5d62c9e28bb3af663b8fd746d36293cd642c26acf8836028eebb6b72ba55ccdc::packet_v1_codec::decode_header(arg4);
        assert!(0x5d62c9e28bb3af663b8fd746d36293cd642c26acf8836028eebb6b72ba55ccdc::packet_v1_codec::dst_eid(&v0) == 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::eid(arg1), 3);
        0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::verify(arg1, &arg0.call_cap, arg3, 0x5d62c9e28bb3af663b8fd746d36293cd642c26acf8836028eebb6b72ba55ccdc::packet_v1_codec::src_eid(&v0), 0x5d62c9e28bb3af663b8fd746d36293cd642c26acf8836028eebb6b72ba55ccdc::packet_v1_codec::sender(&v0), 0x5d62c9e28bb3af663b8fd746d36293cd642c26acf8836028eebb6b72ba55ccdc::packet_v1_codec::nonce(&v0), arg5, arg6);
    }

    fun validate_zro_fee_payment(arg0: &SimpleMessageLib, arg1: bool) {
        assert!(!arg1 || arg0.zro_fee > 0, 2);
    }

    public fun version() : (u64, u8, u8) {
        (0, 0, 2)
    }

    // decompiled from Move bytecode v6
}

