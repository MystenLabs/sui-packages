module 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_302 {
    struct ULN_302 has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Uln302 has key {
        id: 0x2::object::UID,
        call_cap: 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::CallCap,
        send_uln: 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::send_uln::SendUln,
        receive_uln: 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::receive_uln::ReceiveUln,
    }

    public fun get_confirmations(arg0: &0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::receive_uln::Verification, arg1: address, arg2: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32, arg3: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32) : u64 {
        0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::receive_uln::get_confirmations(arg0, arg1, arg2, arg3)
    }

    public fun get_verification(arg0: &Uln302) : address {
        0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::receive_uln::get_verification(&arg0.receive_uln)
    }

    public fun is_supported_eid(arg0: &Uln302, arg1: u32) : bool {
        0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::send_uln::is_supported_eid(&arg0.send_uln, arg1) && 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::receive_uln::is_supported_eid(&arg0.receive_uln, arg1)
    }

    public fun verifiable(arg0: &Uln302, arg1: &0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::receive_uln::Verification, arg2: &0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::EndpointV2, arg3: vector<u8>, arg4: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32) : bool {
        0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::receive_uln::verifiable(&arg0.receive_uln, arg1, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::eid(arg2), arg3, arg4)
    }

    public fun verify(arg0: &mut 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::receive_uln::Verification, arg1: &0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::CallCap, arg2: vector<u8>, arg3: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32, arg4: u64) {
        0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::receive_uln::verify(arg0, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::id(arg1), arg2, arg3, arg4);
    }

    public fun confirm_quote(arg0: &Uln302, arg1: &0xcb8bc76ad2dde43cb83fe4f27a702df0874e99c047317251ee878893c17c83c5::treasury::Treasury, arg2: &mut 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_quote::QuoteParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee::MessagingFee>, arg3: 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_get_fee::GetFeeParam, u64>, arg4: 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::multi_call::MultiCall<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_get_fee::GetFeeParam, u64>) {
        let v0 = vector[];
        let v1 = 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::multi_call::destroy<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_get_fee::GetFeeParam, u64>(arg4, &arg0.call_cap);
        0x1::vector::reverse<0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_get_fee::GetFeeParam, u64>>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_get_fee::GetFeeParam, u64>>(&v1)) {
            let (_, _, v5) = 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::destroy_child<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_quote::QuoteParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee::MessagingFee, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_get_fee::GetFeeParam, u64>(arg2, &arg0.call_cap, 0x1::vector::pop_back<0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_get_fee::GetFeeParam, u64>>(&mut v1));
            0x1::vector::push_back<u64>(&mut v0, v5);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_get_fee::GetFeeParam, u64>>(v1);
        let (_, _, v8) = 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::destroy_child<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_quote::QuoteParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee::MessagingFee, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_get_fee::GetFeeParam, u64>(arg2, &arg0.call_cap, arg3);
        0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::complete<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_quote::QuoteParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee::MessagingFee>(arg2, &arg0.call_cap, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::send_uln::confirm_quote(0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::param<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_quote::QuoteParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee::MessagingFee>(arg2), v8, v0, arg1));
    }

    public fun confirm_send(arg0: &Uln302, arg1: &0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::EndpointV2, arg2: &0xcb8bc76ad2dde43cb83fe4f27a702df0874e99c047317251ee878893c17c83c5::treasury::Treasury, arg3: &mut 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::MessagingChannel, arg4: &mut 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_receipt::MessagingReceipt>, arg5: 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendResult>, arg6: 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_assign_job::AssignJobParam, 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::fee_recipient::FeeRecipient>, arg7: 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::multi_call::MultiCall<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_assign_job::AssignJobParam, 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::fee_recipient::FeeRecipient>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::fee_recipient::FeeRecipient>();
        let v1 = vector[];
        let v2 = 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::multi_call::destroy<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_assign_job::AssignJobParam, 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::fee_recipient::FeeRecipient>(arg7, &arg0.call_cap);
        0x1::vector::reverse<0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_assign_job::AssignJobParam, 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::fee_recipient::FeeRecipient>>(&mut v2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_assign_job::AssignJobParam, 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::fee_recipient::FeeRecipient>>(&v2)) {
            let (v4, _, v6) = 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::destroy_child<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendResult, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_assign_job::AssignJobParam, 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::fee_recipient::FeeRecipient>(&mut arg5, &arg0.call_cap, 0x1::vector::pop_back<0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_assign_job::AssignJobParam, 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::fee_recipient::FeeRecipient>>(&mut v2));
            0x1::vector::push_back<address>(&mut v1, v4);
            0x1::vector::push_back<0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::fee_recipient::FeeRecipient>(&mut v0, v6);
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_assign_job::AssignJobParam, 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::fee_recipient::FeeRecipient>>(v2);
        let (v7, _, v9) = 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::destroy_child<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendResult, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_assign_job::AssignJobParam, 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::fee_recipient::FeeRecipient>(&mut arg5, &arg0.call_cap, arg6);
        0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::complete<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendResult>(&mut arg5, &arg0.call_cap, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::send_uln::confirm_send(0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::param<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendResult>(&arg5), v7, v9, v1, v0, arg2));
        let (v10, v11) = 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::confirm_send(arg1, &arg0.call_cap, arg3, arg4, arg5, arg8);
        0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::send_uln::handle_fees(arg2, v9, v0, v10, v11, arg8);
    }

    public fun get_default_executor_config(arg0: &Uln302, arg1: u32) : &0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_config::ExecutorConfig {
        0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::send_uln::get_default_executor_config(&arg0.send_uln, arg1)
    }

    public fun get_effective_executor_config(arg0: &Uln302, arg1: address, arg2: u32) : 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_config::ExecutorConfig {
        0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::send_uln::get_effective_executor_config(&arg0.send_uln, arg1, arg2)
    }

    public fun get_oapp_executor_config(arg0: &Uln302, arg1: address, arg2: u32) : &0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_config::ExecutorConfig {
        0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::send_uln::get_oapp_executor_config(&arg0.send_uln, arg1, arg2)
    }

    public fun quote(arg0: &Uln302, arg1: &mut 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_quote::QuoteParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee::MessagingFee>, arg2: &mut 0x2::tx_context::TxContext) : (0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_get_fee::GetFeeParam, u64>, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::multi_call::MultiCall<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_get_fee::GetFeeParam, u64>) {
        0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::assert_caller<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_quote::QuoteParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee::MessagingFee>(arg1, 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::package::original_package_of_type<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::EndpointV2>());
        let (v0, v1, v2, v3) = 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::send_uln::quote(&arg0.send_uln, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::param<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_quote::QuoteParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee::MessagingFee>(arg1));
        0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::new_child_batch<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_quote::QuoteParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee::MessagingFee>(arg1, &arg0.call_cap, 1);
        let v4 = 0x1::vector::empty<0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_get_fee::GetFeeParam, u64>>();
        let v5 = v2;
        let v6 = v3;
        0x1::vector::reverse<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_get_fee::GetFeeParam>(&mut v6);
        assert!(0x1::vector::length<address>(&v5) == 0x1::vector::length<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_get_fee::GetFeeParam>(&v6), 13906834715509260287);
        0x1::vector::reverse<address>(&mut v5);
        let v7 = 0;
        while (v7 < 0x1::vector::length<address>(&v5)) {
            0x1::vector::push_back<0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_get_fee::GetFeeParam, u64>>(&mut v4, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::create_child<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_quote::QuoteParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee::MessagingFee, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_get_fee::GetFeeParam, u64>(arg1, &arg0.call_cap, 0x1::vector::pop_back<address>(&mut v5), 0x1::vector::pop_back<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_get_fee::GetFeeParam>(&mut v6), false, arg2));
            v7 = v7 + 1;
        };
        0x1::vector::destroy_empty<address>(v5);
        0x1::vector::destroy_empty<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_get_fee::GetFeeParam>(v6);
        (0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::create_child<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_quote::QuoteParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee::MessagingFee, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_get_fee::GetFeeParam, u64>(arg1, &arg0.call_cap, v0, v1, true, arg2), 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::multi_call::create<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_get_fee::GetFeeParam, u64>(&arg0.call_cap, v4))
    }

    public fun send(arg0: &Uln302, arg1: &mut 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendResult>, arg2: &mut 0x2::tx_context::TxContext) : (0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_assign_job::AssignJobParam, 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::fee_recipient::FeeRecipient>, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::multi_call::MultiCall<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_assign_job::AssignJobParam, 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::fee_recipient::FeeRecipient>) {
        0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::assert_caller<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendResult>(arg1, 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::package::original_package_of_type<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::EndpointV2>());
        assert!(is_supported_eid(arg0, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::outbound_packet::dst_eid(0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_quote::packet(0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::base(0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::param<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendResult>(arg1))))), 3);
        let (v0, v1, v2, v3) = 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::send_uln::send(&arg0.send_uln, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::param<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendResult>(arg1));
        0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::new_child_batch<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendResult>(arg1, &arg0.call_cap, 1);
        let v4 = 0x1::vector::empty<0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_assign_job::AssignJobParam, 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::fee_recipient::FeeRecipient>>();
        let v5 = v2;
        let v6 = v3;
        0x1::vector::reverse<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_assign_job::AssignJobParam>(&mut v6);
        assert!(0x1::vector::length<address>(&v5) == 0x1::vector::length<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_assign_job::AssignJobParam>(&v6), 13906834938847559679);
        0x1::vector::reverse<address>(&mut v5);
        let v7 = 0;
        while (v7 < 0x1::vector::length<address>(&v5)) {
            0x1::vector::push_back<0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_assign_job::AssignJobParam, 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::fee_recipient::FeeRecipient>>(&mut v4, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::create_child<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendResult, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_assign_job::AssignJobParam, 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::fee_recipient::FeeRecipient>(arg1, &arg0.call_cap, 0x1::vector::pop_back<address>(&mut v5), 0x1::vector::pop_back<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_assign_job::AssignJobParam>(&mut v6), false, arg2));
            v7 = v7 + 1;
        };
        0x1::vector::destroy_empty<address>(v5);
        0x1::vector::destroy_empty<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_assign_job::AssignJobParam>(v6);
        (0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::create_child<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendResult, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_assign_job::AssignJobParam, 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::fee_recipient::FeeRecipient>(arg1, &arg0.call_cap, v0, v1, true, arg2), 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::multi_call::create<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_assign_job::AssignJobParam, 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::fee_recipient::FeeRecipient>(&arg0.call_cap, v4))
    }

    public fun set_default_executor_config(arg0: &mut Uln302, arg1: &AdminCap, arg2: u32, arg3: 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_config::ExecutorConfig) {
        0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::send_uln::set_default_executor_config(&mut arg0.send_uln, arg2, arg3);
    }

    public fun commit_verification(arg0: &Uln302, arg1: &mut 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::receive_uln::Verification, arg2: &0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::EndpointV2, arg3: &mut 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::MessagingChannel, arg4: vector<u8>, arg5: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32, arg6: &0x2::clock::Clock) {
        let v0 = 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::receive_uln::verify_and_reclaim_storage(&arg0.receive_uln, arg1, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::eid(arg2), arg4, arg5);
        assert!(is_supported_eid(arg0, 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::packet_v1_codec::src_eid(&v0)), 3);
        let v1 = 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::packet_v1_codec::receiver(&v0);
        assert!(0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::to_address(&v1) == 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::get_oapp(arg3), 2);
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::verify(arg2, &arg0.call_cap, arg3, 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::packet_v1_codec::src_eid(&v0), 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::packet_v1_codec::sender(&v0), 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::packet_v1_codec::nonce(&v0), arg5, arg6);
    }

    public fun get_default_receive_uln_config(arg0: &Uln302, arg1: u32) : &0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_config::UlnConfig {
        0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::receive_uln::get_default_uln_config(&arg0.receive_uln, arg1)
    }

    public fun get_default_send_uln_config(arg0: &Uln302, arg1: u32) : &0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_config::UlnConfig {
        0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::send_uln::get_default_uln_config(&arg0.send_uln, arg1)
    }

    public fun get_effective_receive_uln_config(arg0: &Uln302, arg1: address, arg2: u32) : 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_config::UlnConfig {
        0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::receive_uln::get_effective_uln_config(&arg0.receive_uln, arg1, arg2)
    }

    public fun get_effective_send_uln_config(arg0: &Uln302, arg1: address, arg2: u32) : 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_config::UlnConfig {
        0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::send_uln::get_effective_uln_config(&arg0.send_uln, arg1, arg2)
    }

    public fun get_oapp_receive_uln_config(arg0: &Uln302, arg1: address, arg2: u32) : &0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::oapp_uln_config::OAppUlnConfig {
        0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::receive_uln::get_oapp_uln_config(&arg0.receive_uln, arg1, arg2)
    }

    public fun get_oapp_send_uln_config(arg0: &Uln302, arg1: address, arg2: u32) : &0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::oapp_uln_config::OAppUlnConfig {
        0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::send_uln::get_oapp_uln_config(&arg0.send_uln, arg1, arg2)
    }

    fun init(arg0: ULN_302, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Uln302{
            id          : 0x2::object::new(arg1),
            call_cap    : 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::new_package_cap<ULN_302>(&arg0, arg1),
            send_uln    : 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::send_uln::new_send_uln(arg1),
            receive_uln : 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::receive_uln::new_receive_uln(arg1),
        };
        0x2::transfer::share_object<Uln302>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun set_config(arg0: &mut Uln302, arg1: 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_set_config::SetConfigParam, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Void>) {
        0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::assert_caller<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_set_config::SetConfigParam, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Void>(&arg1, 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::package::original_package_of_type<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::EndpointV2>());
        assert!(is_supported_eid(arg0, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_set_config::eid(0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::param<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_set_config::SetConfigParam, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Void>(&arg1))), 3);
        let v0 = 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::param<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_set_config::SetConfigParam, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Void>(&arg1);
        let v1 = 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_set_config::config_type(v0);
        if (v1 == 1) {
            0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::send_uln::set_executor_config(&mut arg0.send_uln, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_set_config::oapp(v0), 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_set_config::eid(v0), 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_config::deserialize(*0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_set_config::config(v0)));
        } else if (v1 == 2) {
            0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::send_uln::set_uln_config(&mut arg0.send_uln, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_set_config::oapp(v0), 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_set_config::eid(v0), 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::oapp_uln_config::deserialize(*0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_set_config::config(v0)));
        } else {
            assert!(v1 == 3, 1);
            0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::receive_uln::set_uln_config(&mut arg0.receive_uln, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_set_config::oapp(v0), 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_set_config::eid(v0), 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::oapp_uln_config::deserialize(*0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_set_config::config(v0)));
        };
        0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::complete_and_destroy<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_set_config::SetConfigParam>(arg1, &arg0.call_cap);
    }

    public fun set_default_receive_uln_config(arg0: &mut Uln302, arg1: &AdminCap, arg2: u32, arg3: 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_config::UlnConfig) {
        0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::receive_uln::set_default_uln_config(&mut arg0.receive_uln, arg2, arg3);
    }

    public fun set_default_send_uln_config(arg0: &mut Uln302, arg1: &AdminCap, arg2: u32, arg3: 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_config::UlnConfig) {
        0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::send_uln::set_default_uln_config(&mut arg0.send_uln, arg2, arg3);
    }

    public fun version() : (u64, u8, u8) {
        (3, 0, 2)
    }

    // decompiled from Move bytecode v6
}

