module 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_302 {
    struct ULN_302 has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Uln302 has key {
        id: 0x2::object::UID,
        call_cap: 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::CallCap,
        send_uln: 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::send_uln::SendUln,
        receive_uln: 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::receive_uln::ReceiveUln,
    }

    public fun confirm_send(arg0: &Uln302, arg1: &0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::EndpointV2, arg2: &0xc8241ec5be82f02e6b0d1bb7fdaed0ba4ae9cc423fe67545fa52466ca80f87cb::treasury::Treasury, arg3: &mut 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_channel::MessagingChannel, arg4: &mut 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_send::SendParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_receipt::MessagingReceipt>, arg5: 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_send::SendParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_send::SendResult>, arg6: 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::executor_assign_job::AssignJobParam, 0x5d62c9e28bb3af663b8fd746d36293cd642c26acf8836028eebb6b72ba55ccdc::fee_recipient::FeeRecipient>, arg7: 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::multi_call::MultiCall<0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::dvn_assign_job::AssignJobParam, 0x5d62c9e28bb3af663b8fd746d36293cd642c26acf8836028eebb6b72ba55ccdc::fee_recipient::FeeRecipient>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x5d62c9e28bb3af663b8fd746d36293cd642c26acf8836028eebb6b72ba55ccdc::fee_recipient::FeeRecipient>();
        let v1 = vector[];
        let v2 = 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::multi_call::destroy<0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::dvn_assign_job::AssignJobParam, 0x5d62c9e28bb3af663b8fd746d36293cd642c26acf8836028eebb6b72ba55ccdc::fee_recipient::FeeRecipient>(arg7, &arg0.call_cap);
        0x1::vector::reverse<0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::dvn_assign_job::AssignJobParam, 0x5d62c9e28bb3af663b8fd746d36293cd642c26acf8836028eebb6b72ba55ccdc::fee_recipient::FeeRecipient>>(&mut v2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::dvn_assign_job::AssignJobParam, 0x5d62c9e28bb3af663b8fd746d36293cd642c26acf8836028eebb6b72ba55ccdc::fee_recipient::FeeRecipient>>(&v2)) {
            let (v4, _, v6) = 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::destroy_child<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_send::SendParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_send::SendResult, 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::dvn_assign_job::AssignJobParam, 0x5d62c9e28bb3af663b8fd746d36293cd642c26acf8836028eebb6b72ba55ccdc::fee_recipient::FeeRecipient>(&mut arg5, &arg0.call_cap, 0x1::vector::pop_back<0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::dvn_assign_job::AssignJobParam, 0x5d62c9e28bb3af663b8fd746d36293cd642c26acf8836028eebb6b72ba55ccdc::fee_recipient::FeeRecipient>>(&mut v2));
            0x1::vector::push_back<address>(&mut v1, v4);
            0x1::vector::push_back<0x5d62c9e28bb3af663b8fd746d36293cd642c26acf8836028eebb6b72ba55ccdc::fee_recipient::FeeRecipient>(&mut v0, v6);
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::dvn_assign_job::AssignJobParam, 0x5d62c9e28bb3af663b8fd746d36293cd642c26acf8836028eebb6b72ba55ccdc::fee_recipient::FeeRecipient>>(v2);
        let (v7, _, v9) = 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::destroy_child<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_send::SendParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_send::SendResult, 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::executor_assign_job::AssignJobParam, 0x5d62c9e28bb3af663b8fd746d36293cd642c26acf8836028eebb6b72ba55ccdc::fee_recipient::FeeRecipient>(&mut arg5, &arg0.call_cap, arg6);
        0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::complete<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_send::SendParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_send::SendResult>(&mut arg5, &arg0.call_cap, 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::send_uln::confirm_send(0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::param<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_send::SendParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_send::SendResult>(&arg5), v7, v9, v1, v0, arg2));
        let (v10, v11) = 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::confirm_send(arg1, &arg0.call_cap, arg3, arg4, arg5, arg8);
        0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::send_uln::handle_fees(arg2, v9, v0, v10, v11, arg8);
    }

    public fun verify(arg0: &mut 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::receive_uln::Verification, arg1: &0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::CallCap, arg2: vector<u8>, arg3: 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32, arg4: u64) {
        0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::receive_uln::verify(arg0, 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::id(arg1), arg2, arg3, arg4);
    }

    public fun get_confirmations(arg0: &0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::receive_uln::Verification, arg1: address, arg2: 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32, arg3: 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32) : u64 {
        0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::receive_uln::get_confirmations(arg0, arg1, arg2, arg3)
    }

    public fun get_verification(arg0: &Uln302) : address {
        0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::receive_uln::get_verification(&arg0.receive_uln)
    }

    public fun is_supported_eid(arg0: &Uln302, arg1: u32) : bool {
        0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::send_uln::is_supported_eid(&arg0.send_uln, arg1) && 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::receive_uln::is_supported_eid(&arg0.receive_uln, arg1)
    }

    public fun verifiable(arg0: &Uln302, arg1: &0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::receive_uln::Verification, arg2: &0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::EndpointV2, arg3: vector<u8>, arg4: 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32) : bool {
        0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::receive_uln::verifiable(&arg0.receive_uln, arg1, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::eid(arg2), arg3, arg4)
    }

    public fun confirm_quote(arg0: &Uln302, arg1: &0xc8241ec5be82f02e6b0d1bb7fdaed0ba4ae9cc423fe67545fa52466ca80f87cb::treasury::Treasury, arg2: &mut 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_quote::QuoteParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_fee::MessagingFee>, arg3: 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::executor_get_fee::GetFeeParam, u64>, arg4: 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::multi_call::MultiCall<0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::dvn_get_fee::GetFeeParam, u64>) {
        let v0 = vector[];
        let v1 = 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::multi_call::destroy<0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::dvn_get_fee::GetFeeParam, u64>(arg4, &arg0.call_cap);
        0x1::vector::reverse<0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::dvn_get_fee::GetFeeParam, u64>>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::dvn_get_fee::GetFeeParam, u64>>(&v1)) {
            let (_, _, v5) = 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::destroy_child<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_quote::QuoteParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_fee::MessagingFee, 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::dvn_get_fee::GetFeeParam, u64>(arg2, &arg0.call_cap, 0x1::vector::pop_back<0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::dvn_get_fee::GetFeeParam, u64>>(&mut v1));
            0x1::vector::push_back<u64>(&mut v0, v5);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::dvn_get_fee::GetFeeParam, u64>>(v1);
        let (_, _, v8) = 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::destroy_child<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_quote::QuoteParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_fee::MessagingFee, 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::executor_get_fee::GetFeeParam, u64>(arg2, &arg0.call_cap, arg3);
        0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::complete<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_quote::QuoteParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_fee::MessagingFee>(arg2, &arg0.call_cap, 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::send_uln::confirm_quote(0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::param<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_quote::QuoteParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_fee::MessagingFee>(arg2), v8, v0, arg1));
    }

    public fun get_default_executor_config(arg0: &Uln302, arg1: u32) : &0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::executor_config::ExecutorConfig {
        0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::send_uln::get_default_executor_config(&arg0.send_uln, arg1)
    }

    public fun get_effective_executor_config(arg0: &Uln302, arg1: address, arg2: u32) : 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::executor_config::ExecutorConfig {
        0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::send_uln::get_effective_executor_config(&arg0.send_uln, arg1, arg2)
    }

    public fun get_oapp_executor_config(arg0: &Uln302, arg1: address, arg2: u32) : &0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::executor_config::ExecutorConfig {
        0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::send_uln::get_oapp_executor_config(&arg0.send_uln, arg1, arg2)
    }

    public fun quote(arg0: &Uln302, arg1: &mut 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_quote::QuoteParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_fee::MessagingFee>, arg2: &mut 0x2::tx_context::TxContext) : (0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::executor_get_fee::GetFeeParam, u64>, 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::multi_call::MultiCall<0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::dvn_get_fee::GetFeeParam, u64>) {
        0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::assert_caller<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_quote::QuoteParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_fee::MessagingFee>(arg1, 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::package::original_package_of_type<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::EndpointV2>());
        let (v0, v1, v2, v3) = 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::send_uln::quote(&arg0.send_uln, 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::param<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_quote::QuoteParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_fee::MessagingFee>(arg1));
        0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::new_child_batch<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_quote::QuoteParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_fee::MessagingFee>(arg1, &arg0.call_cap, 1);
        let v4 = 0x1::vector::empty<0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::dvn_get_fee::GetFeeParam, u64>>();
        let v5 = v2;
        let v6 = v3;
        0x1::vector::reverse<0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::dvn_get_fee::GetFeeParam>(&mut v6);
        assert!(0x1::vector::length<address>(&v5) == 0x1::vector::length<0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::dvn_get_fee::GetFeeParam>(&v6), 13906834715509260287);
        0x1::vector::reverse<address>(&mut v5);
        let v7 = 0;
        while (v7 < 0x1::vector::length<address>(&v5)) {
            0x1::vector::push_back<0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::dvn_get_fee::GetFeeParam, u64>>(&mut v4, 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::create_child<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_quote::QuoteParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_fee::MessagingFee, 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::dvn_get_fee::GetFeeParam, u64>(arg1, &arg0.call_cap, 0x1::vector::pop_back<address>(&mut v5), 0x1::vector::pop_back<0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::dvn_get_fee::GetFeeParam>(&mut v6), false, arg2));
            v7 = v7 + 1;
        };
        0x1::vector::destroy_empty<address>(v5);
        0x1::vector::destroy_empty<0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::dvn_get_fee::GetFeeParam>(v6);
        (0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::create_child<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_quote::QuoteParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_fee::MessagingFee, 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::executor_get_fee::GetFeeParam, u64>(arg1, &arg0.call_cap, v0, v1, true, arg2), 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::multi_call::create<0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::dvn_get_fee::GetFeeParam, u64>(&arg0.call_cap, v4))
    }

    public fun send(arg0: &Uln302, arg1: &mut 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_send::SendParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_send::SendResult>, arg2: &mut 0x2::tx_context::TxContext) : (0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::executor_assign_job::AssignJobParam, 0x5d62c9e28bb3af663b8fd746d36293cd642c26acf8836028eebb6b72ba55ccdc::fee_recipient::FeeRecipient>, 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::multi_call::MultiCall<0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::dvn_assign_job::AssignJobParam, 0x5d62c9e28bb3af663b8fd746d36293cd642c26acf8836028eebb6b72ba55ccdc::fee_recipient::FeeRecipient>) {
        0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::assert_caller<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_send::SendParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_send::SendResult>(arg1, 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::package::original_package_of_type<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::EndpointV2>());
        assert!(is_supported_eid(arg0, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::outbound_packet::dst_eid(0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_quote::packet(0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_send::base(0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::param<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_send::SendParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_send::SendResult>(arg1))))), 3);
        let (v0, v1, v2, v3) = 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::send_uln::send(&arg0.send_uln, 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::param<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_send::SendParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_send::SendResult>(arg1));
        0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::new_child_batch<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_send::SendParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_send::SendResult>(arg1, &arg0.call_cap, 1);
        let v4 = 0x1::vector::empty<0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::dvn_assign_job::AssignJobParam, 0x5d62c9e28bb3af663b8fd746d36293cd642c26acf8836028eebb6b72ba55ccdc::fee_recipient::FeeRecipient>>();
        let v5 = v2;
        let v6 = v3;
        0x1::vector::reverse<0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::dvn_assign_job::AssignJobParam>(&mut v6);
        assert!(0x1::vector::length<address>(&v5) == 0x1::vector::length<0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::dvn_assign_job::AssignJobParam>(&v6), 13906834938847559679);
        0x1::vector::reverse<address>(&mut v5);
        let v7 = 0;
        while (v7 < 0x1::vector::length<address>(&v5)) {
            0x1::vector::push_back<0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::dvn_assign_job::AssignJobParam, 0x5d62c9e28bb3af663b8fd746d36293cd642c26acf8836028eebb6b72ba55ccdc::fee_recipient::FeeRecipient>>(&mut v4, 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::create_child<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_send::SendParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_send::SendResult, 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::dvn_assign_job::AssignJobParam, 0x5d62c9e28bb3af663b8fd746d36293cd642c26acf8836028eebb6b72ba55ccdc::fee_recipient::FeeRecipient>(arg1, &arg0.call_cap, 0x1::vector::pop_back<address>(&mut v5), 0x1::vector::pop_back<0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::dvn_assign_job::AssignJobParam>(&mut v6), false, arg2));
            v7 = v7 + 1;
        };
        0x1::vector::destroy_empty<address>(v5);
        0x1::vector::destroy_empty<0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::dvn_assign_job::AssignJobParam>(v6);
        (0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::create_child<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_send::SendParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_send::SendResult, 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::executor_assign_job::AssignJobParam, 0x5d62c9e28bb3af663b8fd746d36293cd642c26acf8836028eebb6b72ba55ccdc::fee_recipient::FeeRecipient>(arg1, &arg0.call_cap, v0, v1, true, arg2), 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::multi_call::create<0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::dvn_assign_job::AssignJobParam, 0x5d62c9e28bb3af663b8fd746d36293cd642c26acf8836028eebb6b72ba55ccdc::fee_recipient::FeeRecipient>(&arg0.call_cap, v4))
    }

    public fun set_default_executor_config(arg0: &mut Uln302, arg1: &AdminCap, arg2: u32, arg3: 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::executor_config::ExecutorConfig) {
        0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::send_uln::set_default_executor_config(&mut arg0.send_uln, arg2, arg3);
    }

    public fun commit_verification(arg0: &Uln302, arg1: &mut 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::receive_uln::Verification, arg2: &0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::EndpointV2, arg3: &mut 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_channel::MessagingChannel, arg4: vector<u8>, arg5: 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32, arg6: &0x2::clock::Clock) {
        let v0 = 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::receive_uln::verify_and_reclaim_storage(&arg0.receive_uln, arg1, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::eid(arg2), arg4, arg5);
        assert!(is_supported_eid(arg0, 0x5d62c9e28bb3af663b8fd746d36293cd642c26acf8836028eebb6b72ba55ccdc::packet_v1_codec::src_eid(&v0)), 3);
        let v1 = 0x5d62c9e28bb3af663b8fd746d36293cd642c26acf8836028eebb6b72ba55ccdc::packet_v1_codec::receiver(&v0);
        assert!(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::to_address(&v1) == 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::get_oapp(arg3), 2);
        0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::verify(arg2, &arg0.call_cap, arg3, 0x5d62c9e28bb3af663b8fd746d36293cd642c26acf8836028eebb6b72ba55ccdc::packet_v1_codec::src_eid(&v0), 0x5d62c9e28bb3af663b8fd746d36293cd642c26acf8836028eebb6b72ba55ccdc::packet_v1_codec::sender(&v0), 0x5d62c9e28bb3af663b8fd746d36293cd642c26acf8836028eebb6b72ba55ccdc::packet_v1_codec::nonce(&v0), arg5, arg6);
    }

    public fun get_default_receive_uln_config(arg0: &Uln302, arg1: u32) : &0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_config::UlnConfig {
        0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::receive_uln::get_default_uln_config(&arg0.receive_uln, arg1)
    }

    public fun get_default_send_uln_config(arg0: &Uln302, arg1: u32) : &0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_config::UlnConfig {
        0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::send_uln::get_default_uln_config(&arg0.send_uln, arg1)
    }

    public fun get_effective_receive_uln_config(arg0: &Uln302, arg1: address, arg2: u32) : 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_config::UlnConfig {
        0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::receive_uln::get_effective_uln_config(&arg0.receive_uln, arg1, arg2)
    }

    public fun get_effective_send_uln_config(arg0: &Uln302, arg1: address, arg2: u32) : 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_config::UlnConfig {
        0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::send_uln::get_effective_uln_config(&arg0.send_uln, arg1, arg2)
    }

    public fun get_oapp_receive_uln_config(arg0: &Uln302, arg1: address, arg2: u32) : &0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::oapp_uln_config::OAppUlnConfig {
        0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::receive_uln::get_oapp_uln_config(&arg0.receive_uln, arg1, arg2)
    }

    public fun get_oapp_send_uln_config(arg0: &Uln302, arg1: address, arg2: u32) : &0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::oapp_uln_config::OAppUlnConfig {
        0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::send_uln::get_oapp_uln_config(&arg0.send_uln, arg1, arg2)
    }

    fun init(arg0: ULN_302, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Uln302{
            id          : 0x2::object::new(arg1),
            call_cap    : 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::new_package_cap<ULN_302>(&arg0, arg1),
            send_uln    : 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::send_uln::new_send_uln(arg1),
            receive_uln : 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::receive_uln::new_receive_uln(arg1),
        };
        0x2::transfer::share_object<Uln302>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun set_config(arg0: &mut Uln302, arg1: 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_set_config::SetConfigParam, 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Void>) {
        0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::assert_caller<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_set_config::SetConfigParam, 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Void>(&arg1, 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::package::original_package_of_type<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::EndpointV2>());
        assert!(is_supported_eid(arg0, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_set_config::eid(0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::param<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_set_config::SetConfigParam, 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Void>(&arg1))), 3);
        let v0 = 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::param<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_set_config::SetConfigParam, 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Void>(&arg1);
        let v1 = 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_set_config::config_type(v0);
        if (v1 == 1) {
            0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::send_uln::set_executor_config(&mut arg0.send_uln, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_set_config::oapp(v0), 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_set_config::eid(v0), 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::executor_config::deserialize(*0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_set_config::config(v0)));
        } else if (v1 == 2) {
            0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::send_uln::set_uln_config(&mut arg0.send_uln, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_set_config::oapp(v0), 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_set_config::eid(v0), 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::oapp_uln_config::deserialize(*0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_set_config::config(v0)));
        } else {
            assert!(v1 == 3, 1);
            0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::receive_uln::set_uln_config(&mut arg0.receive_uln, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_set_config::oapp(v0), 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_set_config::eid(v0), 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::oapp_uln_config::deserialize(*0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_set_config::config(v0)));
        };
        0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::complete<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_set_config::SetConfigParam, 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Void>(&mut arg1, &arg0.call_cap, 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::void());
        let (_, _, _) = 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::destroy<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_set_config::SetConfigParam, 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Void>(arg1, &arg0.call_cap);
    }

    public fun set_default_receive_uln_config(arg0: &mut Uln302, arg1: &AdminCap, arg2: u32, arg3: 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_config::UlnConfig) {
        0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::receive_uln::set_default_uln_config(&mut arg0.receive_uln, arg2, arg3);
    }

    public fun set_default_send_uln_config(arg0: &mut Uln302, arg1: &AdminCap, arg2: u32, arg3: 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_config::UlnConfig) {
        0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::send_uln::set_default_uln_config(&mut arg0.send_uln, arg2, arg3);
    }

    public fun version() : (u64, u8, u8) {
        (3, 0, 2)
    }

    // decompiled from Move bytecode v6
}

