module 0x9ae0cd10d66b12af12a3dad838acd20184d02704f7fae5b1ce86974433636669::counter_ptb_builder {
    struct CounterPtbBuilder {
        dummy_field: bool,
    }

    fun add_lz_compose_aba_call(arg0: &mut 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::MoveCallsBuilder, arg1: &0x9ae0cd10d66b12af12a3dad838acd20184d02704f7fae5b1ce86974433636669::counter::Counter, arg2: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp) : 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument {
        let v0 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>();
        let v1 = &mut v0;
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0x9ae0cd10d66b12af12a3dad838acd20184d02704f7fae5b1ce86974433636669::counter::Counter>(arg1)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp>(arg2)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_id(0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::ptb_builder_helper::lz_compose_call_id()));
        let v2 = 0x1::vector::empty<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>();
        0x1::vector::push_back<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>(&mut v2, 0x28417daea895a3dc2e70b5765ec67b99973e612107d56382e399cc75e666f2ba::endpoint_ptb_builder::endpoint_send_call_id());
        let v3 = 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::add(arg0, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::create(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::package::package_of_type<0x9ae0cd10d66b12af12a3dad838acd20184d02704f7fae5b1ce86974433636669::counter::Counter>(), 0x1::ascii::string(b"counter"), 0x1::ascii::string(b"lz_compose_aba"), v0, 0x1::vector::empty<0x1::type_name::TypeName>(), false, v2));
        0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::to_nested_result_arg(&v3, 0)
    }

    fun add_lz_compose_call(arg0: &mut 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::MoveCallsBuilder, arg1: &0x9ae0cd10d66b12af12a3dad838acd20184d02704f7fae5b1ce86974433636669::counter::Counter) {
        let v0 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>();
        let v1 = &mut v0;
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0x9ae0cd10d66b12af12a3dad838acd20184d02704f7fae5b1ce86974433636669::counter::Counter>(arg1)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_id(0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::ptb_builder_helper::lz_compose_call_id()));
        0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::add(arg0, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::create(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::package::package_of_type<0x9ae0cd10d66b12af12a3dad838acd20184d02704f7fae5b1ce86974433636669::counter::Counter>(), 0x1::ascii::string(b"counter"), 0x1::ascii::string(b"lz_compose"), v0, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>()));
    }

    fun add_lz_receive_aba_call(arg0: &mut 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::MoveCallsBuilder, arg1: &0x9ae0cd10d66b12af12a3dad838acd20184d02704f7fae5b1ce86974433636669::counter::Counter, arg2: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp) : 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument {
        let v0 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>();
        let v1 = &mut v0;
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0x9ae0cd10d66b12af12a3dad838acd20184d02704f7fae5b1ce86974433636669::counter::Counter>(arg1)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp>(arg2)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_id(0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::ptb_builder_helper::lz_receive_call_id()));
        let v2 = 0x1::vector::empty<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>();
        0x1::vector::push_back<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>(&mut v2, 0x28417daea895a3dc2e70b5765ec67b99973e612107d56382e399cc75e666f2ba::endpoint_ptb_builder::endpoint_send_call_id());
        let v3 = 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::add(arg0, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::create(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::package::package_of_type<0x9ae0cd10d66b12af12a3dad838acd20184d02704f7fae5b1ce86974433636669::counter::Counter>(), 0x1::ascii::string(b"counter"), 0x1::ascii::string(b"lz_receive_aba"), v0, 0x1::vector::empty<0x1::type_name::TypeName>(), false, v2));
        0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::to_nested_result_arg(&v3, 0)
    }

    fun add_lz_receive_call(arg0: &mut 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::MoveCallsBuilder, arg1: &0x9ae0cd10d66b12af12a3dad838acd20184d02704f7fae5b1ce86974433636669::counter::Counter, arg2: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg3: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2) {
        let v0 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>();
        let v1 = &mut v0;
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0x9ae0cd10d66b12af12a3dad838acd20184d02704f7fae5b1ce86974433636669::counter::Counter>(arg1)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp>(arg2)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_id(0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::ptb_builder_helper::lz_receive_call_id()));
        0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::add(arg0, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::create(counter_package(), 0x1::ascii::string(b"counter"), 0x1::ascii::string(b"lz_receive"), v0, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>()));
    }

    fun add_refund_fee_call(arg0: &mut 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::MoveCallsBuilder, arg1: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2, arg2: 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument) {
        let v0 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>();
        let v1 = &mut v0;
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2>(arg1)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, arg2);
        0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::add(arg0, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::create(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::package::package_of_type<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2>(), 0x1::ascii::string(b"endpoint_v2"), 0x1::ascii::string(b"refund"), v0, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>()));
    }

    public fun build_ptb_for_lz_compose(arg0: &0x9ae0cd10d66b12af12a3dad838acd20184d02704f7fae5b1ce86974433636669::counter::Counter, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2, arg3: &0x28417daea895a3dc2e70b5765ec67b99973e612107d56382e399cc75e666f2ba::endpoint_ptb_builder::EndpointPtbBuilder, arg4: &0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_compose::LzComposeParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void>) : vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall> {
        let v0 = 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_compose::message(0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::param<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_compose::LzComposeParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void>(arg4));
        let v1 = 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::new();
        if (0x9ae0cd10d66b12af12a3dad838acd20184d02704f7fae5b1ce86974433636669::msg_codec::get_msg_type(v0) != 4) {
            let v2 = &mut v1;
            add_lz_compose_call(v2, arg0);
        } else {
            let v3 = &mut v1;
            0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::append(&mut v1, 0x28417daea895a3dc2e70b5765ec67b99973e612107d56382e399cc75e666f2ba::endpoint_ptb_builder::build_send_ptb(arg3, arg2, 0x9ae0cd10d66b12af12a3dad838acd20184d02704f7fae5b1ce86974433636669::counter::call_cap_address(arg0), 0x9ae0cd10d66b12af12a3dad838acd20184d02704f7fae5b1ce86974433636669::msg_codec::get_src_eid(v0), false));
            let v4 = &mut v1;
            add_refund_fee_call(v4, arg2, add_lz_compose_aba_call(v3, arg0, arg1));
        };
        0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::build(v1)
    }

    public fun build_ptb_for_lz_receive(arg0: &0x9ae0cd10d66b12af12a3dad838acd20184d02704f7fae5b1ce86974433636669::counter::Counter, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2, arg3: &0x28417daea895a3dc2e70b5765ec67b99973e612107d56382e399cc75e666f2ba::endpoint_ptb_builder::EndpointPtbBuilder, arg4: &0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::LzReceiveParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void>) : vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall> {
        0x9ae0cd10d66b12af12a3dad838acd20184d02704f7fae5b1ce86974433636669::msg_codec::get_msg_type(0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::message(0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::param<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::LzReceiveParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void>(arg4)));
        let v0 = 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::new();
        let v1 = &mut v0;
        add_lz_receive_call(v1, arg0, arg1, arg2);
        0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::build(v0)
    }

    fun counter_package() : address {
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::package::package_of_type<CounterPtbBuilder>()
    }

    public fun lz_compose_info(arg0: &0x9ae0cd10d66b12af12a3dad838acd20184d02704f7fae5b1ce86974433636669::counter::Counter, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2, arg3: &0x28417daea895a3dc2e70b5765ec67b99973e612107d56382e399cc75e666f2ba::endpoint_ptb_builder::EndpointPtbBuilder) : vector<u8> {
        let v0 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>();
        let v1 = &mut v0;
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0x9ae0cd10d66b12af12a3dad838acd20184d02704f7fae5b1ce86974433636669::counter::Counter>(arg0)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp>(arg1)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2>(arg2)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0x28417daea895a3dc2e70b5765ec67b99973e612107d56382e399cc75e666f2ba::endpoint_ptb_builder::EndpointPtbBuilder>(arg3)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_id(0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::ptb_builder_helper::lz_compose_call_id()));
        let v2 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>();
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>(&mut v2, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::create(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::package::package_of_type<0x9ae0cd10d66b12af12a3dad838acd20184d02704f7fae5b1ce86974433636669::counter::Counter>(), 0x1::ascii::string(b"counter_ptb_builder"), 0x1::ascii::string(b"build_ptb_for_lz_compose"), v0, 0x1::vector::empty<0x1::type_name::TypeName>(), true, 0x1::vector::empty<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>()));
        let v3 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::new();
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_bytes(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u16(&mut v3, 1), 0x2::bcs::to_bytes<vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>>(&v2));
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::to_bytes(v3)
    }

    public fun lz_receive_info(arg0: &0x9ae0cd10d66b12af12a3dad838acd20184d02704f7fae5b1ce86974433636669::counter::Counter, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2, arg3: &0x28417daea895a3dc2e70b5765ec67b99973e612107d56382e399cc75e666f2ba::endpoint_ptb_builder::EndpointPtbBuilder) : vector<u8> {
        let v0 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>();
        let v1 = &mut v0;
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0x9ae0cd10d66b12af12a3dad838acd20184d02704f7fae5b1ce86974433636669::counter::Counter>(arg0)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp>(arg1)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2>(arg2)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0x28417daea895a3dc2e70b5765ec67b99973e612107d56382e399cc75e666f2ba::endpoint_ptb_builder::EndpointPtbBuilder>(arg3)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_id(0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::ptb_builder_helper::lz_receive_call_id()));
        let v2 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>();
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>(&mut v2, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::create(counter_package(), 0x1::ascii::string(b"counter_ptb_builder"), 0x1::ascii::string(b"build_ptb_for_lz_receive"), v0, 0x1::vector::empty<0x1::type_name::TypeName>(), true, 0x1::vector::empty<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>()));
        let v3 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::new();
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_bytes(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u16(&mut v3, 1), 0x2::bcs::to_bytes<vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>>(&v2));
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::to_bytes(v3)
    }

    // decompiled from Move bytecode v6
}

