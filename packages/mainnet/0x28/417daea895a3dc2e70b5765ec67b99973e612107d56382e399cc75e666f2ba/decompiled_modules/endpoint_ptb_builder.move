module 0x28417daea895a3dc2e70b5765ec67b99973e612107d56382e399cc75e666f2ba::endpoint_ptb_builder {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct EndpointPtbBuilder has key {
        id: 0x2::object::UID,
        registry: MsglibPtbBuilderRegistry,
        default_configs: 0x2::table::Table<address, address>,
        oapp_configs: 0x2::table::Table<OAppConfigKey, address>,
    }

    struct OAppConfigKey has copy, drop, store {
        oapp: address,
        lib: address,
    }

    struct MsglibPtbBuilderRegistry has store {
        builders: 0x2::table_vec::TableVec<address>,
        builder_infos: 0x2::table::Table<address, 0x28417daea895a3dc2e70b5765ec67b99973e612107d56382e399cc75e666f2ba::msglib_ptb_builder_info::MsglibPtbBuilderInfo>,
    }

    struct MsglibPtbBuilderRegisteredEvent has copy, drop {
        message_lib: address,
        ptb_builder: address,
    }

    struct DefaultMsglibPtbBuilderSetEvent has copy, drop {
        message_lib: address,
        ptb_builder: address,
    }

    struct MsglibPtbBuilderSetEvent has copy, drop {
        oapp: address,
        message_lib: address,
        ptb_builder: address,
    }

    fun assert_msglib_ptb_builder_supported(arg0: &MsglibPtbBuilderRegistry, arg1: address, arg2: address) {
        let v0 = &arg0.builder_infos;
        assert!(0x2::table::contains<address, 0x28417daea895a3dc2e70b5765ec67b99973e612107d56382e399cc75e666f2ba::msglib_ptb_builder_info::MsglibPtbBuilderInfo>(v0, arg2), 1);
        assert!(0x28417daea895a3dc2e70b5765ec67b99973e612107d56382e399cc75e666f2ba::msglib_ptb_builder_info::message_lib(0x2::table::borrow<address, 0x28417daea895a3dc2e70b5765ec67b99973e612107d56382e399cc75e666f2ba::msglib_ptb_builder_info::MsglibPtbBuilderInfo>(v0, arg2)) == arg1, 3);
    }

    public fun build_quote_ptb(arg0: &EndpointPtbBuilder, arg1: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2, arg2: address, arg3: u32) : vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall> {
        let v0 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::package::original_package_of_type<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2>();
        let v1 = 0x2::object::id_address<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2>(arg1);
        let (v2, _) = 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::get_send_library(arg1, arg2, arg3);
        let v4 = 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::new();
        let v5 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>();
        let v6 = &mut v5;
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v6, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(v1));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v6, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::get_messaging_channel(arg1, arg2)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v6, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_id(endpoint_quote_call_id()));
        let v7 = 0x1::vector::empty<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>();
        0x1::vector::push_back<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>(&mut v7, message_lib_quote_call_id());
        let v8 = 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::add(&mut v4, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::create(v0, 0x1::ascii::string(b"endpoint_v2"), 0x1::ascii::string(b"quote"), v5, 0x1::vector::empty<0x1::type_name::TypeName>(), false, v7));
        0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::append(&mut v4, *0x28417daea895a3dc2e70b5765ec67b99973e612107d56382e399cc75e666f2ba::msglib_ptb_builder_info::quote_ptb(get_msglib_ptb_builder_info(arg0, get_effective_msglib_ptb_builder(arg0, arg2, v2))));
        let v9 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>();
        let v10 = &mut v9;
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v10, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(v1));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v10, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_id(endpoint_quote_call_id()));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v10, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::to_nested_result_arg(&v8, 0));
        0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::add(&mut v4, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::create(v0, 0x1::ascii::string(b"endpoint_v2"), 0x1::ascii::string(b"confirm_quote"), v9, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>()));
        0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::build(v4)
    }

    public fun build_quote_ptb_by_call(arg0: &EndpointPtbBuilder, arg1: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2, arg2: &0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_quote::QuoteParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::MessagingFee>) : vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall> {
        build_quote_ptb(arg0, arg1, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::caller<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_quote::QuoteParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::MessagingFee>(arg2), 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_quote::dst_eid(0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::param<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_quote::QuoteParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::MessagingFee>(arg2)))
    }

    public fun build_send_ptb(arg0: &EndpointPtbBuilder, arg1: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2, arg2: address, arg3: u32, arg4: bool) : vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall> {
        let v0 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::package::original_package_of_type<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2>();
        let v1 = 0x2::object::id_address<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2>(arg1);
        let (v2, _) = 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::get_send_library(arg1, arg2, arg3);
        let v4 = 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::new();
        let v5 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>();
        let v6 = &mut v5;
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v6, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(v1));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v6, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::get_messaging_channel(arg1, arg2)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v6, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_id(endpoint_send_call_id()));
        let v7 = 0x1::vector::empty<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>();
        0x1::vector::push_back<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>(&mut v7, message_lib_send_call_id());
        0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::add(&mut v4, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::create(v0, 0x1::ascii::string(b"endpoint_v2"), 0x1::ascii::string(b"send"), v5, 0x1::vector::empty<0x1::type_name::TypeName>(), false, v7));
        0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::append(&mut v4, *0x28417daea895a3dc2e70b5765ec67b99973e612107d56382e399cc75e666f2ba::msglib_ptb_builder_info::send_ptb(get_msglib_ptb_builder_info(arg0, get_effective_msglib_ptb_builder(arg0, arg2, v2))));
        if (arg4) {
            let v8 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>();
            let v9 = &mut v8;
            0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v9, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(v1));
            0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v9, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_id(endpoint_send_call_id()));
            0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::add(&mut v4, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::create(v0, 0x1::ascii::string(b"endpoint_v2"), 0x1::ascii::string(b"refund"), v8, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>()));
        };
        0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::build(v4)
    }

    public fun build_send_ptb_by_call(arg0: &EndpointPtbBuilder, arg1: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2, arg2: &0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt>) : vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall> {
        build_send_ptb(arg0, arg1, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::caller<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt>(arg2), 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::dst_eid(0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::param<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt>(arg2)), 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::one_way<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt>(arg2))
    }

    public fun build_set_config_ptb(arg0: &EndpointPtbBuilder, arg1: address, arg2: address) : vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall> {
        *0x28417daea895a3dc2e70b5765ec67b99973e612107d56382e399cc75e666f2ba::msglib_ptb_builder_info::set_config_ptb(get_msglib_ptb_builder_info(arg0, get_effective_msglib_ptb_builder(arg0, arg1, arg2)))
    }

    public fun build_set_config_ptb_by_call(arg0: &EndpointPtbBuilder, arg1: &0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_set_config::SetConfigParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void>) : vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall> {
        build_set_config_ptb(arg0, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_set_config::oapp(0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::param<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_set_config::SetConfigParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void>(arg1)), 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::callee<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_set_config::SetConfigParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void>(arg1))
    }

    public fun endpoint_quote_call_id() : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get_with_original_ids<0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_quote::QuoteParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::MessagingFee>>());
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::from_bytes(0x2::hash::keccak256(0x1::ascii::as_bytes(&v0)))
    }

    public fun endpoint_send_call_id() : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get_with_original_ids<0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt>>());
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::from_bytes(0x2::hash::keccak256(0x1::ascii::as_bytes(&v0)))
    }

    public fun get_default_msglib_ptb_builder(arg0: &EndpointPtbBuilder, arg1: address) : address {
        let v0 = &arg0.default_configs;
        assert!(0x2::table::contains<address, address>(v0, arg1), 1);
        *0x2::table::borrow<address, address>(v0, arg1)
    }

    public fun get_effective_msglib_ptb_builder(arg0: &EndpointPtbBuilder, arg1: address, arg2: address) : address {
        let v0 = &arg0.oapp_configs;
        let v1 = OAppConfigKey{
            oapp : arg1,
            lib  : arg2,
        };
        let v2 = if (0x2::table::contains<OAppConfigKey, address>(v0, v1)) {
            let v3 = OAppConfigKey{
                oapp : arg1,
                lib  : arg2,
            };
            0x2::table::borrow<OAppConfigKey, address>(v0, v3)
        } else {
            let v4 = @0x0;
            &v4
        };
        let v5 = *v2;
        if (v5 != @0x0) {
            v5
        } else {
            get_default_msglib_ptb_builder(arg0, arg2)
        }
    }

    public fun get_msglib_ptb_builder_info(arg0: &EndpointPtbBuilder, arg1: address) : &0x28417daea895a3dc2e70b5765ec67b99973e612107d56382e399cc75e666f2ba::msglib_ptb_builder_info::MsglibPtbBuilderInfo {
        assert!(is_msglib_ptb_builder_registered(arg0, arg1), 1);
        0x2::table::borrow<address, 0x28417daea895a3dc2e70b5765ec67b99973e612107d56382e399cc75e666f2ba::msglib_ptb_builder_info::MsglibPtbBuilderInfo>(&arg0.registry.builder_infos, arg1)
    }

    public fun get_oapp_msglib_ptb_builder(arg0: &EndpointPtbBuilder, arg1: address, arg2: address) : address {
        let v0 = &arg0.oapp_configs;
        let v1 = OAppConfigKey{
            oapp : arg1,
            lib  : arg2,
        };
        assert!(0x2::table::contains<OAppConfigKey, address>(v0, v1), 1);
        let v2 = OAppConfigKey{
            oapp : arg1,
            lib  : arg2,
        };
        *0x2::table::borrow<OAppConfigKey, address>(v0, v2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MsglibPtbBuilderRegistry{
            builders      : 0x2::table_vec::empty<address>(arg0),
            builder_infos : 0x2::table::new<address, 0x28417daea895a3dc2e70b5765ec67b99973e612107d56382e399cc75e666f2ba::msglib_ptb_builder_info::MsglibPtbBuilderInfo>(arg0),
        };
        let v1 = EndpointPtbBuilder{
            id              : 0x2::object::new(arg0),
            registry        : v0,
            default_configs : 0x2::table::new<address, address>(arg0),
            oapp_configs    : 0x2::table::new<OAppConfigKey, address>(arg0),
        };
        0x2::transfer::share_object<EndpointPtbBuilder>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg0));
    }

    public fun is_msglib_ptb_builder_registered(arg0: &EndpointPtbBuilder, arg1: address) : bool {
        0x2::table::contains<address, 0x28417daea895a3dc2e70b5765ec67b99973e612107d56382e399cc75e666f2ba::msglib_ptb_builder_info::MsglibPtbBuilderInfo>(&arg0.registry.builder_infos, arg1)
    }

    public fun message_lib_quote_call_id() : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get_with_original_ids<0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_quote::QuoteParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::MessagingFee>>());
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::from_bytes(0x2::hash::keccak256(0x1::ascii::as_bytes(&v0)))
    }

    public fun message_lib_send_call_id() : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get_with_original_ids<0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_send::SendResult>>());
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::from_bytes(0x2::hash::keccak256(0x1::ascii::as_bytes(&v0)))
    }

    public fun message_lib_set_config_call_id() : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get_with_original_ids<0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_set_config::SetConfigParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void>>());
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::from_bytes(0x2::hash::keccak256(0x1::ascii::as_bytes(&v0)))
    }

    public fun register_msglib_ptb_builder(arg0: &mut EndpointPtbBuilder, arg1: &AdminCap, arg2: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2, arg3: 0x28417daea895a3dc2e70b5765ec67b99973e612107d56382e399cc75e666f2ba::msglib_ptb_builder_info::MsglibPtbBuilderInfo) {
        let v0 = 0x28417daea895a3dc2e70b5765ec67b99973e612107d56382e399cc75e666f2ba::msglib_ptb_builder_info::ptb_builder(&arg3);
        assert!(v0 != @0x0, 5);
        assert!(!is_msglib_ptb_builder_registered(arg0, v0), 2);
        assert!(0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::is_registered_library(arg2, 0x28417daea895a3dc2e70b5765ec67b99973e612107d56382e399cc75e666f2ba::msglib_ptb_builder_info::message_lib(&arg3)), 6);
        0x2::table_vec::push_back<address>(&mut arg0.registry.builders, v0);
        0x2::table::add<address, 0x28417daea895a3dc2e70b5765ec67b99973e612107d56382e399cc75e666f2ba::msglib_ptb_builder_info::MsglibPtbBuilderInfo>(&mut arg0.registry.builder_infos, v0, arg3);
        let v1 = MsglibPtbBuilderRegisteredEvent{
            message_lib : 0x28417daea895a3dc2e70b5765ec67b99973e612107d56382e399cc75e666f2ba::msglib_ptb_builder_info::message_lib(&arg3),
            ptb_builder : v0,
        };
        0x2::event::emit<MsglibPtbBuilderRegisteredEvent>(v1);
    }

    public fun registered_msglib_ptb_builders(arg0: &EndpointPtbBuilder, arg1: u64, arg2: u64) : vector<address> {
        let v0 = 0x1::u64::min(arg1 + arg2, registered_msglib_ptb_builders_count(arg0));
        assert!(arg1 <= v0, 4);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < v0 - arg1) {
            0x1::vector::push_back<address>(&mut v1, *0x2::table_vec::borrow<address>(&arg0.registry.builders, arg1 + v2));
            v2 = v2 + 1;
        };
        v1
    }

    public fun registered_msglib_ptb_builders_count(arg0: &EndpointPtbBuilder) : u64 {
        0x2::table_vec::length<address>(&arg0.registry.builders)
    }

    public fun set_default_msglib_ptb_builder(arg0: &mut EndpointPtbBuilder, arg1: &AdminCap, arg2: address, arg3: address) {
        assert_msglib_ptb_builder_supported(&arg0.registry, arg2, arg3);
        let v0 = &mut arg0.default_configs;
        if (0x2::table::contains<address, address>(v0, arg2)) {
            *0x2::table::borrow_mut<address, address>(v0, arg2) = arg3;
        } else {
            0x2::table::add<address, address>(v0, arg2, arg3);
        };
        let v1 = DefaultMsglibPtbBuilderSetEvent{
            message_lib : arg2,
            ptb_builder : arg3,
        };
        0x2::event::emit<DefaultMsglibPtbBuilderSetEvent>(v1);
    }

    public fun set_msglib_ptb_builder(arg0: &mut EndpointPtbBuilder, arg1: &0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap, arg2: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2, arg3: address, arg4: address, arg5: address) {
        assert!(0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::id(arg1) == arg3 || 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::id(arg1) == 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::get_delegate(arg2, arg3), 7);
        if (arg5 != @0x0) {
            assert_msglib_ptb_builder_supported(&arg0.registry, arg4, arg5);
        };
        let v0 = &mut arg0.oapp_configs;
        let v1 = OAppConfigKey{
            oapp : arg3,
            lib  : arg4,
        };
        if (0x2::table::contains<OAppConfigKey, address>(v0, v1)) {
            let v2 = OAppConfigKey{
                oapp : arg3,
                lib  : arg4,
            };
            *0x2::table::borrow_mut<OAppConfigKey, address>(v0, v2) = arg5;
        } else {
            let v3 = OAppConfigKey{
                oapp : arg3,
                lib  : arg4,
            };
            0x2::table::add<OAppConfigKey, address>(v0, v3, arg5);
        };
        let v4 = MsglibPtbBuilderSetEvent{
            oapp        : arg3,
            message_lib : arg4,
            ptb_builder : arg5,
        };
        0x2::event::emit<MsglibPtbBuilderSetEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

