module 0xc4ace88a7bda637cade13cd6e9a012f680f96bc25d47ebf3ad4705be1ce6e754::uln_302_ptb_builder {
    struct ULN_302_PTB_BUILDER has drop {
        dummy_field: bool,
    }

    struct Uln302PtbBuilder has key {
        id: 0x2::object::UID,
        call_cap: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap,
        worker_ptbs: 0x2::table::Table<address, WorkerPtbs>,
    }

    struct WorkerPtbs has copy, drop, store {
        get_fee_ptb: vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>,
        assign_job_ptb: vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>,
    }

    public fun build_quote_ptb(arg0: &Uln302PtbBuilder, arg1: &0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_302::Uln302, arg2: &0xc26c5b4189f046e7c0866b29be102e4dae63da8df95c28ea08ae244b814fdf1::treasury::Treasury, arg3: &0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_quote::QuoteParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::MessagingFee>) : vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall> {
        let v0 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::package::original_package_of_type<0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_302::Uln302>();
        let v1 = 0x2::object::id_address<0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_302::Uln302>(arg1);
        let v2 = 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_quote::packet(0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::param<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_quote::QuoteParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::MessagingFee>(arg3));
        let v3 = 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::new();
        let v4 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>();
        let v5 = &mut v4;
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v5, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(v1));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v5, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_id(0x28417daea895a3dc2e70b5765ec67b99973e612107d56382e399cc75e666f2ba::endpoint_ptb_builder::message_lib_quote_call_id()));
        let v6 = 0x1::vector::empty<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>(v7, executor_get_fee_call_id());
        0x1::vector::push_back<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>(v7, dvn_get_fee_multi_call_id());
        let v8 = 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::add(&mut v3, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::create(v0, 0x1::ascii::string(b"uln_302"), 0x1::ascii::string(b"quote"), v4, 0x1::vector::empty<0x1::type_name::TypeName>(), false, v6));
        let v9 = 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_302::get_effective_executor_config(arg1, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::outbound_packet::sender(v2), 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::outbound_packet::dst_eid(v2));
        0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::append(&mut v3, *get_fee_ptb(get_worker_ptbs(arg0, 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::executor_config::executor(&v9))));
        let v10 = 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_302::get_effective_send_uln_config(arg1, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::outbound_packet::sender(v2), 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::outbound_packet::dst_eid(v2));
        let v11 = 0x1::vector::empty<vector<address>>();
        let v12 = &mut v11;
        0x1::vector::push_back<vector<address>>(v12, *0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_config::required_dvns(&v10));
        0x1::vector::push_back<vector<address>>(v12, *0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_config::optional_dvns(&v10));
        let v13 = 0x1::vector::flatten<address>(v11);
        let v14 = &v13;
        let v15 = 0;
        while (v15 < 0x1::vector::length<address>(v14)) {
            0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::append(&mut v3, *get_fee_ptb(get_worker_ptbs(arg0, *0x1::vector::borrow<address>(v14, v15))));
            v15 = v15 + 1;
        };
        let v16 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>();
        let v17 = &mut v16;
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v17, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(v1));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v17, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0xc26c5b4189f046e7c0866b29be102e4dae63da8df95c28ea08ae244b814fdf1::treasury::Treasury>(arg2)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v17, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_id(0x28417daea895a3dc2e70b5765ec67b99973e612107d56382e399cc75e666f2ba::endpoint_ptb_builder::message_lib_quote_call_id()));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v17, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::to_nested_result_arg(&v8, 0));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v17, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::to_nested_result_arg(&v8, 1));
        0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::add(&mut v3, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::create(v0, 0x1::ascii::string(b"uln_302"), 0x1::ascii::string(b"confirm_quote"), v16, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>()));
        0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::build(v3)
    }

    public fun build_send_ptb(arg0: &Uln302PtbBuilder, arg1: &0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_302::Uln302, arg2: &0xc26c5b4189f046e7c0866b29be102e4dae63da8df95c28ea08ae244b814fdf1::treasury::Treasury, arg3: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2, arg4: &0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_send::SendResult>) : vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall> {
        let v0 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::package::original_package_of_type<0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_302::Uln302>();
        let v1 = 0x2::object::id_address<0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_302::Uln302>(arg1);
        let v2 = 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_quote::packet(0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_send::base(0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::param<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_send::SendResult>(arg4)));
        let v3 = 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::new();
        let v4 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>();
        let v5 = &mut v4;
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v5, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(v1));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v5, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_id(0x28417daea895a3dc2e70b5765ec67b99973e612107d56382e399cc75e666f2ba::endpoint_ptb_builder::message_lib_send_call_id()));
        let v6 = 0x1::vector::empty<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>(v7, executor_assign_job_call_id());
        0x1::vector::push_back<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>(v7, dvn_assign_job_multi_call_id());
        let v8 = 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::add(&mut v3, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::create(v0, 0x1::ascii::string(b"uln_302"), 0x1::ascii::string(b"send"), v4, 0x1::vector::empty<0x1::type_name::TypeName>(), false, v6));
        let v9 = 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_302::get_effective_executor_config(arg1, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::outbound_packet::sender(v2), 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::outbound_packet::dst_eid(v2));
        0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::append(&mut v3, *get_assign_job_ptb(get_worker_ptbs(arg0, 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::executor_config::executor(&v9))));
        let v10 = 0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_302::get_effective_send_uln_config(arg1, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::outbound_packet::sender(v2), 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::outbound_packet::dst_eid(v2));
        let v11 = 0x1::vector::empty<vector<address>>();
        let v12 = &mut v11;
        0x1::vector::push_back<vector<address>>(v12, *0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_config::required_dvns(&v10));
        0x1::vector::push_back<vector<address>>(v12, *0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_config::optional_dvns(&v10));
        let v13 = 0x1::vector::flatten<address>(v11);
        let v14 = &v13;
        let v15 = 0;
        while (v15 < 0x1::vector::length<address>(v14)) {
            0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::append(&mut v3, *get_assign_job_ptb(get_worker_ptbs(arg0, *0x1::vector::borrow<address>(v14, v15))));
            v15 = v15 + 1;
        };
        let v16 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>();
        let v17 = &mut v16;
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v17, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(v1));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v17, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2>(arg3)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v17, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0xc26c5b4189f046e7c0866b29be102e4dae63da8df95c28ea08ae244b814fdf1::treasury::Treasury>(arg2)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v17, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::get_messaging_channel(arg3, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::outbound_packet::sender(v2))));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v17, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_id(0x28417daea895a3dc2e70b5765ec67b99973e612107d56382e399cc75e666f2ba::endpoint_ptb_builder::endpoint_send_call_id()));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v17, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_id(0x28417daea895a3dc2e70b5765ec67b99973e612107d56382e399cc75e666f2ba::endpoint_ptb_builder::message_lib_send_call_id()));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v17, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::to_nested_result_arg(&v8, 0));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v17, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::to_nested_result_arg(&v8, 1));
        0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::add(&mut v3, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::create(v0, 0x1::ascii::string(b"uln_302"), 0x1::ascii::string(b"confirm_send"), v16, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>()));
        0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::build(v3)
    }

    public fun build_set_config_ptb(arg0: &0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_302::Uln302) : vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall> {
        let v0 = 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::new();
        let v1 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>();
        let v2 = &mut v1;
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v2, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_302::Uln302>(arg0)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v2, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_id(0x28417daea895a3dc2e70b5765ec67b99973e612107d56382e399cc75e666f2ba::endpoint_ptb_builder::message_lib_set_config_call_id()));
        0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::add(&mut v0, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::create(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::package::original_package_of_type<0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_302::Uln302>(), 0x1::ascii::string(b"uln_302"), 0x1::ascii::string(b"set_config"), v1, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>()));
        0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::build(v0)
    }

    public fun dvn_assign_job_multi_call_id() : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get_with_original_ids<0xf00ed2e3fedf4a517c5ab2a2a52d985a127381d49bb24c8428b1f757846c5cdd::multi_call::MultiCall<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_assign_job::AssignJobParam, 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::fee_recipient::FeeRecipient>>());
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::from_bytes(0x2::hash::keccak256(0x1::ascii::as_bytes(&v0)))
    }

    public fun dvn_get_fee_multi_call_id() : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get_with_original_ids<0xf00ed2e3fedf4a517c5ab2a2a52d985a127381d49bb24c8428b1f757846c5cdd::multi_call::MultiCall<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::dvn_get_fee::GetFeeParam, u64>>());
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::from_bytes(0x2::hash::keccak256(0x1::ascii::as_bytes(&v0)))
    }

    public fun executor_assign_job_call_id() : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get_with_original_ids<0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::executor_assign_job::AssignJobParam, 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::fee_recipient::FeeRecipient>>());
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::from_bytes(0x2::hash::keccak256(0x1::ascii::as_bytes(&v0)))
    }

    public fun executor_get_fee_call_id() : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get_with_original_ids<0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::executor_get_fee::GetFeeParam, u64>>());
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::from_bytes(0x2::hash::keccak256(0x1::ascii::as_bytes(&v0)))
    }

    public fun get_assign_job_ptb(arg0: &WorkerPtbs) : &vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall> {
        &arg0.assign_job_ptb
    }

    public fun get_fee_ptb(arg0: &WorkerPtbs) : &vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall> {
        &arg0.get_fee_ptb
    }

    public fun get_ptb_builder_info(arg0: &Uln302PtbBuilder, arg1: &0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_302::Uln302, arg2: &0xc26c5b4189f046e7c0866b29be102e4dae63da8df95c28ea08ae244b814fdf1::treasury::Treasury, arg3: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2) : 0x28417daea895a3dc2e70b5765ec67b99973e612107d56382e399cc75e666f2ba::msglib_ptb_builder_info::MsglibPtbBuilderInfo {
        let v0 = 0x1::ascii::string(b"uln_302_ptb_builder");
        let v1 = 0x2::object::id_address<Uln302PtbBuilder>(arg0);
        let v2 = 0x2::object::id_address<0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_302::Uln302>(arg1);
        let v3 = 0x2::object::id_address<0xc26c5b4189f046e7c0866b29be102e4dae63da8df95c28ea08ae244b814fdf1::treasury::Treasury>(arg2);
        let v4 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>();
        let v5 = &mut v4;
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v5, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(v1));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v5, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(v2));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v5, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(v3));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v5, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_id(0x28417daea895a3dc2e70b5765ec67b99973e612107d56382e399cc75e666f2ba::endpoint_ptb_builder::message_lib_quote_call_id()));
        let v6 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>();
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>(&mut v6, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::create(0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::id(&arg0.call_cap), v0, 0x1::ascii::string(b"build_quote_ptb"), v4, 0x1::vector::empty<0x1::type_name::TypeName>(), true, 0x1::vector::empty<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>()));
        let v7 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>();
        let v8 = &mut v7;
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v8, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(v1));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v8, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(v2));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v8, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(v3));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v8, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2>(arg3)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v8, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_id(0x28417daea895a3dc2e70b5765ec67b99973e612107d56382e399cc75e666f2ba::endpoint_ptb_builder::message_lib_send_call_id()));
        let v9 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>();
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>(&mut v9, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::create(0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::id(&arg0.call_cap), v0, 0x1::ascii::string(b"build_send_ptb"), v7, 0x1::vector::empty<0x1::type_name::TypeName>(), true, 0x1::vector::empty<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>()));
        0x28417daea895a3dc2e70b5765ec67b99973e612107d56382e399cc75e666f2ba::msglib_ptb_builder_info::create(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::package::original_package_of_type<0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_302::Uln302>(), 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::id(&arg0.call_cap), v6, v9, build_set_config_ptb(arg1))
    }

    public fun get_worker_ptbs(arg0: &Uln302PtbBuilder, arg1: address) : &WorkerPtbs {
        let v0 = &arg0.worker_ptbs;
        assert!(0x2::table::contains<address, WorkerPtbs>(v0, arg1), 1);
        0x2::table::borrow<address, WorkerPtbs>(v0, arg1)
    }

    fun init(arg0: ULN_302_PTB_BUILDER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Uln302PtbBuilder{
            id          : 0x2::object::new(arg1),
            call_cap    : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::new_package_cap<ULN_302_PTB_BUILDER>(&arg0, arg1),
            worker_ptbs : 0x2::table::new<address, WorkerPtbs>(arg1),
        };
        0x2::transfer::share_object<Uln302PtbBuilder>(v0);
    }

    public fun is_worker_ptbs_set(arg0: &Uln302PtbBuilder, arg1: address) : bool {
        0x2::table::contains<address, WorkerPtbs>(&arg0.worker_ptbs, arg1)
    }

    public fun set_worker_ptbs(arg0: &mut Uln302PtbBuilder, arg1: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0xd412a95bfe4645ddb920e3c08cfb8f7cfe9c8fe9897e957ca161cc6b85987fc5::set_worker_ptb::SetWorkerPtbParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void>) {
        let v0 = 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::caller<0xd412a95bfe4645ddb920e3c08cfb8f7cfe9c8fe9897e957ca161cc6b85987fc5::set_worker_ptb::SetWorkerPtbParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void>(&arg1);
        let (v1, v2) = 0xd412a95bfe4645ddb920e3c08cfb8f7cfe9c8fe9897e957ca161cc6b85987fc5::set_worker_ptb::unpack(0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::complete_and_destroy<0xd412a95bfe4645ddb920e3c08cfb8f7cfe9c8fe9897e957ca161cc6b85987fc5::set_worker_ptb::SetWorkerPtbParam>(arg1, &arg0.call_cap));
        let v3 = &mut arg0.worker_ptbs;
        if (0x2::table::contains<address, WorkerPtbs>(v3, v0)) {
            let v4 = WorkerPtbs{
                get_fee_ptb    : v1,
                assign_job_ptb : v2,
            };
            *0x2::table::borrow_mut<address, WorkerPtbs>(v3, v0) = v4;
        } else {
            let v5 = WorkerPtbs{
                get_fee_ptb    : v1,
                assign_job_ptb : v2,
            };
            0x2::table::add<address, WorkerPtbs>(v3, v0, v5);
        };
    }

    // decompiled from Move bytecode v6
}

