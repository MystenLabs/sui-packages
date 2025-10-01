module 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_302 {
    struct ULN_302 has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Uln302 has key {
        id: 0x2::object::UID,
        call_cap: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap,
        send_uln: 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::send_uln::SendUln,
        receive_uln: 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::receive_uln::ReceiveUln,
    }

    public fun confirm_send(arg0: &Uln302, arg1: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2, arg2: &0xc26c5b4189f046e7c0866b29be102e4dae63da8df95c28ea08ae244b814fdf1::treasury::Treasury, arg3: &mut 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_channel::MessagingChannel, arg4: &mut 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt>, arg5: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_send::SendResult>, arg6: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::executor_assign_job::AssignJobParam, 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::fee_recipient::FeeRecipient>, arg7: 0xf00ed2e3fedf4a517c5ab2a2a52d985a127381d49bb24c8428b1f757846c5cdd::multi_call::MultiCall<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_assign_job::AssignJobParam, 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::fee_recipient::FeeRecipient>, arg8: &mut 0x2::tx_context::TxContext) {
        0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::assert_caller<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_send::SendResult>(&arg5, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::package::original_package_of_type<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2>());
        let v0 = 0x1::vector::empty<0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::fee_recipient::FeeRecipient>();
        let v1 = vector[];
        let v2 = 0xf00ed2e3fedf4a517c5ab2a2a52d985a127381d49bb24c8428b1f757846c5cdd::multi_call::destroy<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_assign_job::AssignJobParam, 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::fee_recipient::FeeRecipient>(arg7, &arg0.call_cap);
        0x1::vector::reverse<0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_assign_job::AssignJobParam, 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::fee_recipient::FeeRecipient>>(&mut v2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_assign_job::AssignJobParam, 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::fee_recipient::FeeRecipient>>(&v2)) {
            let (v4, _, v6) = 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::destroy_child<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_send::SendResult, 0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_assign_job::AssignJobParam, 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::fee_recipient::FeeRecipient>(&mut arg5, &arg0.call_cap, 0x1::vector::pop_back<0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_assign_job::AssignJobParam, 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::fee_recipient::FeeRecipient>>(&mut v2));
            0x1::vector::push_back<address>(&mut v1, v4);
            0x1::vector::push_back<0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::fee_recipient::FeeRecipient>(&mut v0, v6);
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_assign_job::AssignJobParam, 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::fee_recipient::FeeRecipient>>(v2);
        let (v7, _, v9) = 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::destroy_child<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_send::SendResult, 0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::executor_assign_job::AssignJobParam, 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::fee_recipient::FeeRecipient>(&mut arg5, &arg0.call_cap, arg6);
        0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::complete<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_send::SendResult>(&mut arg5, &arg0.call_cap, 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::send_uln::confirm_send(0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::param<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_send::SendResult>(&arg5), v7, v9, v1, v0, arg2));
        let (v10, v11) = 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::confirm_send(arg1, &arg0.call_cap, arg3, arg4, arg5, arg8);
        0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::send_uln::handle_fees(arg2, v9, v0, v10, v11, arg8);
    }

    public fun verify(arg0: &Uln302, arg1: &mut 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::receive_uln::Verification, arg2: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_verify::VerifyParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void>) {
        let v0 = 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::complete_and_destroy<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_verify::VerifyParam>(arg2, &arg0.call_cap);
        0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::receive_uln::verify(arg1, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::caller<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_verify::VerifyParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void>(&arg2), *0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_verify::packet_header(&v0), 0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_verify::payload_hash(&v0), 0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_verify::confirmations(&v0));
    }

    public fun get_confirmations(arg0: &0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::receive_uln::Verification, arg1: address, arg2: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg3: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32) : u64 {
        0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::receive_uln::get_confirmations(arg0, arg1, arg2, arg3)
    }

    public fun get_verification(arg0: &Uln302) : address {
        0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::receive_uln::get_verification(&arg0.receive_uln)
    }

    public fun is_supported_eid(arg0: &Uln302, arg1: u32) : bool {
        0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::send_uln::is_supported_eid(&arg0.send_uln, arg1) && 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::receive_uln::is_supported_eid(&arg0.receive_uln, arg1)
    }

    public fun verifiable(arg0: &Uln302, arg1: &0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::receive_uln::Verification, arg2: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2, arg3: vector<u8>, arg4: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32) : bool {
        0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::receive_uln::verifiable(&arg0.receive_uln, arg1, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::eid(arg2), arg3, arg4)
    }

    public fun confirm_quote(arg0: &Uln302, arg1: &0xc26c5b4189f046e7c0866b29be102e4dae63da8df95c28ea08ae244b814fdf1::treasury::Treasury, arg2: &mut 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_quote::QuoteParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::MessagingFee>, arg3: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::executor_get_fee::GetFeeParam, u64>, arg4: 0xf00ed2e3fedf4a517c5ab2a2a52d985a127381d49bb24c8428b1f757846c5cdd::multi_call::MultiCall<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_get_fee::GetFeeParam, u64>) {
        0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::assert_caller<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_quote::QuoteParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::MessagingFee>(arg2, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::package::original_package_of_type<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2>());
        let v0 = vector[];
        let v1 = 0xf00ed2e3fedf4a517c5ab2a2a52d985a127381d49bb24c8428b1f757846c5cdd::multi_call::destroy<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_get_fee::GetFeeParam, u64>(arg4, &arg0.call_cap);
        0x1::vector::reverse<0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_get_fee::GetFeeParam, u64>>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_get_fee::GetFeeParam, u64>>(&v1)) {
            let (_, _, v5) = 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::destroy_child<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_quote::QuoteParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::MessagingFee, 0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_get_fee::GetFeeParam, u64>(arg2, &arg0.call_cap, 0x1::vector::pop_back<0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_get_fee::GetFeeParam, u64>>(&mut v1));
            0x1::vector::push_back<u64>(&mut v0, v5);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_get_fee::GetFeeParam, u64>>(v1);
        let (_, _, v8) = 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::destroy_child<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_quote::QuoteParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::MessagingFee, 0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::executor_get_fee::GetFeeParam, u64>(arg2, &arg0.call_cap, arg3);
        0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::complete<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_quote::QuoteParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::MessagingFee>(arg2, &arg0.call_cap, 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::send_uln::confirm_quote(0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::param<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_quote::QuoteParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::MessagingFee>(arg2), v8, v0, arg1));
    }

    public fun get_default_executor_config(arg0: &Uln302, arg1: u32) : &0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::executor_config::ExecutorConfig {
        0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::send_uln::get_default_executor_config(&arg0.send_uln, arg1)
    }

    public fun get_effective_executor_config(arg0: &Uln302, arg1: address, arg2: u32) : 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::executor_config::ExecutorConfig {
        0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::send_uln::get_effective_executor_config(&arg0.send_uln, arg1, arg2)
    }

    public fun get_oapp_executor_config(arg0: &Uln302, arg1: address, arg2: u32) : &0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::executor_config::ExecutorConfig {
        0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::send_uln::get_oapp_executor_config(&arg0.send_uln, arg1, arg2)
    }

    public fun quote(arg0: &Uln302, arg1: &mut 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_quote::QuoteParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::MessagingFee>, arg2: &mut 0x2::tx_context::TxContext) : (0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::executor_get_fee::GetFeeParam, u64>, 0xf00ed2e3fedf4a517c5ab2a2a52d985a127381d49bb24c8428b1f757846c5cdd::multi_call::MultiCall<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_get_fee::GetFeeParam, u64>) {
        0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::assert_caller<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_quote::QuoteParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::MessagingFee>(arg1, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::package::original_package_of_type<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2>());
        let (v0, v1, v2, v3) = 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::send_uln::quote(&arg0.send_uln, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::param<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_quote::QuoteParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::MessagingFee>(arg1));
        0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::new_child_batch<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_quote::QuoteParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::MessagingFee>(arg1, &arg0.call_cap, 1);
        let v4 = 0x1::vector::empty<0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_get_fee::GetFeeParam, u64>>();
        let v5 = v2;
        let v6 = v3;
        0x1::vector::reverse<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_get_fee::GetFeeParam>(&mut v6);
        assert!(0x1::vector::length<address>(&v5) == 0x1::vector::length<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_get_fee::GetFeeParam>(&v6), 13906834732689129471);
        0x1::vector::reverse<address>(&mut v5);
        let v7 = 0;
        while (v7 < 0x1::vector::length<address>(&v5)) {
            0x1::vector::push_back<0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_get_fee::GetFeeParam, u64>>(&mut v4, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::create_child<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_quote::QuoteParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::MessagingFee, 0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_get_fee::GetFeeParam, u64>(arg1, &arg0.call_cap, 0x1::vector::pop_back<address>(&mut v5), 0x1::vector::pop_back<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_get_fee::GetFeeParam>(&mut v6), false, arg2));
            v7 = v7 + 1;
        };
        0x1::vector::destroy_empty<address>(v5);
        0x1::vector::destroy_empty<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_get_fee::GetFeeParam>(v6);
        (0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::create_child<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_quote::QuoteParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::MessagingFee, 0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::executor_get_fee::GetFeeParam, u64>(arg1, &arg0.call_cap, v0, v1, true, arg2), 0xf00ed2e3fedf4a517c5ab2a2a52d985a127381d49bb24c8428b1f757846c5cdd::multi_call::create<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_get_fee::GetFeeParam, u64>(&arg0.call_cap, v4))
    }

    public fun send(arg0: &Uln302, arg1: &mut 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_send::SendResult>, arg2: &mut 0x2::tx_context::TxContext) : (0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::executor_assign_job::AssignJobParam, 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::fee_recipient::FeeRecipient>, 0xf00ed2e3fedf4a517c5ab2a2a52d985a127381d49bb24c8428b1f757846c5cdd::multi_call::MultiCall<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_assign_job::AssignJobParam, 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::fee_recipient::FeeRecipient>) {
        0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::assert_caller<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_send::SendResult>(arg1, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::package::original_package_of_type<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2>());
        assert!(is_supported_eid(arg0, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::outbound_packet::dst_eid(0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_quote::packet(0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_send::base(0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::param<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_send::SendResult>(arg1))))), 3);
        let (v0, v1, v2, v3) = 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::send_uln::send(&arg0.send_uln, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::param<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_send::SendResult>(arg1));
        0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::new_child_batch<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_send::SendResult>(arg1, &arg0.call_cap, 1);
        let v4 = 0x1::vector::empty<0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_assign_job::AssignJobParam, 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::fee_recipient::FeeRecipient>>();
        let v5 = v2;
        let v6 = v3;
        0x1::vector::reverse<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_assign_job::AssignJobParam>(&mut v6);
        assert!(0x1::vector::length<address>(&v5) == 0x1::vector::length<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_assign_job::AssignJobParam>(&v6), 13906834960322396159);
        0x1::vector::reverse<address>(&mut v5);
        let v7 = 0;
        while (v7 < 0x1::vector::length<address>(&v5)) {
            0x1::vector::push_back<0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_assign_job::AssignJobParam, 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::fee_recipient::FeeRecipient>>(&mut v4, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::create_child<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_send::SendResult, 0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_assign_job::AssignJobParam, 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::fee_recipient::FeeRecipient>(arg1, &arg0.call_cap, 0x1::vector::pop_back<address>(&mut v5), 0x1::vector::pop_back<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_assign_job::AssignJobParam>(&mut v6), false, arg2));
            v7 = v7 + 1;
        };
        0x1::vector::destroy_empty<address>(v5);
        0x1::vector::destroy_empty<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_assign_job::AssignJobParam>(v6);
        (0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::create_child<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_send::SendResult, 0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::executor_assign_job::AssignJobParam, 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::fee_recipient::FeeRecipient>(arg1, &arg0.call_cap, v0, v1, true, arg2), 0xf00ed2e3fedf4a517c5ab2a2a52d985a127381d49bb24c8428b1f757846c5cdd::multi_call::create<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_assign_job::AssignJobParam, 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::fee_recipient::FeeRecipient>(&arg0.call_cap, v4))
    }

    public fun set_default_executor_config(arg0: &mut Uln302, arg1: &AdminCap, arg2: u32, arg3: 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::executor_config::ExecutorConfig) {
        0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::send_uln::set_default_executor_config(&mut arg0.send_uln, arg2, arg3);
    }

    public fun commit_verification(arg0: &Uln302, arg1: &mut 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::receive_uln::Verification, arg2: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2, arg3: &mut 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_channel::MessagingChannel, arg4: vector<u8>, arg5: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg6: &0x2::clock::Clock) {
        let v0 = 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::receive_uln::verify_and_reclaim_storage(&arg0.receive_uln, arg1, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::eid(arg2), arg4, arg5);
        assert!(is_supported_eid(arg0, 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::packet_v1_codec::src_eid(&v0)), 3);
        let v1 = 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::packet_v1_codec::receiver(&v0);
        assert!(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::to_address(&v1) == 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::get_oapp(arg3), 2);
        0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::verify(arg2, &arg0.call_cap, arg3, 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::packet_v1_codec::src_eid(&v0), 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::packet_v1_codec::sender(&v0), 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::packet_v1_codec::nonce(&v0), arg5, arg6);
    }

    public fun get_default_receive_uln_config(arg0: &Uln302, arg1: u32) : &0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_config::UlnConfig {
        0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::receive_uln::get_default_uln_config(&arg0.receive_uln, arg1)
    }

    public fun get_default_send_uln_config(arg0: &Uln302, arg1: u32) : &0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_config::UlnConfig {
        0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::send_uln::get_default_uln_config(&arg0.send_uln, arg1)
    }

    public fun get_effective_receive_uln_config(arg0: &Uln302, arg1: address, arg2: u32) : 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_config::UlnConfig {
        0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::receive_uln::get_effective_uln_config(&arg0.receive_uln, arg1, arg2)
    }

    public fun get_effective_send_uln_config(arg0: &Uln302, arg1: address, arg2: u32) : 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_config::UlnConfig {
        0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::send_uln::get_effective_uln_config(&arg0.send_uln, arg1, arg2)
    }

    public fun get_oapp_receive_uln_config(arg0: &Uln302, arg1: address, arg2: u32) : &0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::oapp_uln_config::OAppUlnConfig {
        0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::receive_uln::get_oapp_uln_config(&arg0.receive_uln, arg1, arg2)
    }

    public fun get_oapp_send_uln_config(arg0: &Uln302, arg1: address, arg2: u32) : &0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::oapp_uln_config::OAppUlnConfig {
        0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::send_uln::get_oapp_uln_config(&arg0.send_uln, arg1, arg2)
    }

    fun init(arg0: ULN_302, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Uln302{
            id          : 0x2::object::new(arg1),
            call_cap    : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::new_package_cap<ULN_302>(&arg0, arg1),
            send_uln    : 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::send_uln::new_send_uln(arg1),
            receive_uln : 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::receive_uln::new_receive_uln(arg1),
        };
        0x2::transfer::share_object<Uln302>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun set_config(arg0: &mut Uln302, arg1: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_set_config::SetConfigParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void>) {
        0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::assert_caller<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_set_config::SetConfigParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void>(&arg1, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::package::original_package_of_type<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2>());
        assert!(is_supported_eid(arg0, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_set_config::eid(0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::param<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_set_config::SetConfigParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void>(&arg1))), 3);
        let v0 = 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::param<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_set_config::SetConfigParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void>(&arg1);
        let v1 = 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_set_config::config_type(v0);
        if (v1 == 1) {
            0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::send_uln::set_executor_config(&mut arg0.send_uln, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_set_config::oapp(v0), 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_set_config::eid(v0), 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::executor_config::deserialize(*0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_set_config::config(v0)));
        } else if (v1 == 2) {
            0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::send_uln::set_uln_config(&mut arg0.send_uln, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_set_config::oapp(v0), 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_set_config::eid(v0), 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::oapp_uln_config::deserialize(*0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_set_config::config(v0)));
        } else {
            assert!(v1 == 3, 1);
            0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::receive_uln::set_uln_config(&mut arg0.receive_uln, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_set_config::oapp(v0), 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_set_config::eid(v0), 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::oapp_uln_config::deserialize(*0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_set_config::config(v0)));
        };
        0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::complete_and_destroy<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_set_config::SetConfigParam>(arg1, &arg0.call_cap);
    }

    public fun set_default_receive_uln_config(arg0: &mut Uln302, arg1: &AdminCap, arg2: u32, arg3: 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_config::UlnConfig) {
        0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::receive_uln::set_default_uln_config(&mut arg0.receive_uln, arg2, arg3);
    }

    public fun set_default_send_uln_config(arg0: &mut Uln302, arg1: &AdminCap, arg2: u32, arg3: 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_config::UlnConfig) {
        0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::send_uln::set_default_uln_config(&mut arg0.send_uln, arg2, arg3);
    }

    public fun version() : (u64, u8, u8) {
        (3, 0, 2)
    }

    // decompiled from Move bytecode v6
}

