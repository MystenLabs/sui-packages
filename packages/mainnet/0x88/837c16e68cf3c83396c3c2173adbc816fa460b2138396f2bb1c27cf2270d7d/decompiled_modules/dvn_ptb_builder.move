module 0x88837c16e68cf3c83396c3c2173adbc816fa460b2138396f2bb1c27cf2270d7d::dvn_ptb_builder {
    fun append_get_fee_move_calls(arg0: &mut 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::MoveCallsBuilder, arg1: &0xc3213e769e222f573edb14c63bf11b6481f3d3b66f2206f5911be07032390883::dvn_fee_lib::DvnFeeLib, arg2: &0xea932d79771b24103a1cda8e87a65068d6116c047f9dccc3e487cf8316625576::price_feed::PriceFeed, arg3: 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument) {
        let v0 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::package::package_of_type<0xc3213e769e222f573edb14c63bf11b6481f3d3b66f2206f5911be07032390883::dvn_fee_lib::DvnFeeLib>();
        let v1 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>();
        let v2 = &mut v1;
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v2, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0xc3213e769e222f573edb14c63bf11b6481f3d3b66f2206f5911be07032390883::dvn_fee_lib::DvnFeeLib>(arg1)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v2, arg3);
        let v3 = 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::add(arg0, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::create(v0, 0x1::ascii::string(b"dvn_fee_lib"), 0x1::ascii::string(b"get_fee"), v1, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>()));
        let v4 = 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::to_nested_result_arg(&v3, 0);
        let v5 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>();
        let v6 = &mut v5;
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v6, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0xea932d79771b24103a1cda8e87a65068d6116c047f9dccc3e487cf8316625576::price_feed::PriceFeed>(arg2)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v6, v4);
        let v7 = 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::add(arg0, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::create(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::package::package_of_type<0xea932d79771b24103a1cda8e87a65068d6116c047f9dccc3e487cf8316625576::price_feed::PriceFeed>(), 0x1::ascii::string(b"price_feed"), 0x1::ascii::string(b"estimate_fee_by_eid"), v5, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>()));
        0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::to_nested_result_arg(&v7, 0);
        let v8 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>();
        let v9 = &mut v8;
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v9, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0xc3213e769e222f573edb14c63bf11b6481f3d3b66f2206f5911be07032390883::dvn_fee_lib::DvnFeeLib>(arg1)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v9, arg3);
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v9, v4);
        0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::add(arg0, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::create(v0, 0x1::ascii::string(b"dvn_fee_lib"), 0x1::ascii::string(b"confirm_get_fee"), v8, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>()));
    }

    public fun build_assign_job_ptb(arg0: &0x60d4ef2e0e057d19e947406ccec3ac4d0208adc8e1981964ab2552166a30f461::dvn::DVN, arg1: &0xc3213e769e222f573edb14c63bf11b6481f3d3b66f2206f5911be07032390883::dvn_fee_lib::DvnFeeLib, arg2: &0xea932d79771b24103a1cda8e87a65068d6116c047f9dccc3e487cf8316625576::price_feed::PriceFeed) : vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall> {
        let v0 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::package::package_of_type<0x60d4ef2e0e057d19e947406ccec3ac4d0208adc8e1981964ab2552166a30f461::dvn::DVN>();
        let v1 = 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::new();
        let v2 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>();
        let v3 = &mut v2;
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v3, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0x60d4ef2e0e057d19e947406ccec3ac4d0208adc8e1981964ab2552166a30f461::dvn::DVN>(arg0)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v3, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_id(0xc4ace88a7bda637cade13cd6e9a012f680f96bc25d47ebf3ad4705be1ce6e754::uln_302_ptb_builder::dvn_assign_job_multi_call_id()));
        let v4 = 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::add(&mut v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::create(v0, 0x1::ascii::string(b"dvn"), 0x1::ascii::string(b"assign_job"), v2, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>()));
        let v5 = 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::to_nested_result_arg(&v4, 0);
        let v6 = &mut v1;
        append_get_fee_move_calls(v6, arg1, arg2, v5);
        let v7 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>();
        let v8 = &mut v7;
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v8, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0x60d4ef2e0e057d19e947406ccec3ac4d0208adc8e1981964ab2552166a30f461::dvn::DVN>(arg0)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v8, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_id(0xc4ace88a7bda637cade13cd6e9a012f680f96bc25d47ebf3ad4705be1ce6e754::uln_302_ptb_builder::dvn_assign_job_multi_call_id()));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v8, v5);
        0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::add(&mut v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::create(v0, 0x1::ascii::string(b"dvn"), 0x1::ascii::string(b"confirm_assign_job"), v7, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>()));
        0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::build(v1)
    }

    public fun build_dvn_ptb(arg0: &0x60d4ef2e0e057d19e947406ccec3ac4d0208adc8e1981964ab2552166a30f461::dvn::DVN, arg1: &0xc3213e769e222f573edb14c63bf11b6481f3d3b66f2206f5911be07032390883::dvn_fee_lib::DvnFeeLib, arg2: &0xea932d79771b24103a1cda8e87a65068d6116c047f9dccc3e487cf8316625576::price_feed::PriceFeed) : (vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>, vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>) {
        (build_get_fee_ptb(arg0, arg1, arg2), build_assign_job_ptb(arg0, arg1, arg2))
    }

    public fun build_get_fee_ptb(arg0: &0x60d4ef2e0e057d19e947406ccec3ac4d0208adc8e1981964ab2552166a30f461::dvn::DVN, arg1: &0xc3213e769e222f573edb14c63bf11b6481f3d3b66f2206f5911be07032390883::dvn_fee_lib::DvnFeeLib, arg2: &0xea932d79771b24103a1cda8e87a65068d6116c047f9dccc3e487cf8316625576::price_feed::PriceFeed) : vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall> {
        let v0 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::package::package_of_type<0x60d4ef2e0e057d19e947406ccec3ac4d0208adc8e1981964ab2552166a30f461::dvn::DVN>();
        let v1 = 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::new();
        let v2 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>();
        let v3 = &mut v2;
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v3, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0x60d4ef2e0e057d19e947406ccec3ac4d0208adc8e1981964ab2552166a30f461::dvn::DVN>(arg0)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v3, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_id(0xc4ace88a7bda637cade13cd6e9a012f680f96bc25d47ebf3ad4705be1ce6e754::uln_302_ptb_builder::dvn_get_fee_multi_call_id()));
        let v4 = 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::add(&mut v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::create(v0, 0x1::ascii::string(b"dvn"), 0x1::ascii::string(b"get_fee"), v2, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>()));
        let v5 = 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::to_nested_result_arg(&v4, 0);
        let v6 = &mut v1;
        append_get_fee_move_calls(v6, arg1, arg2, v5);
        let v7 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>();
        let v8 = &mut v7;
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v8, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0x60d4ef2e0e057d19e947406ccec3ac4d0208adc8e1981964ab2552166a30f461::dvn::DVN>(arg0)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v8, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_id(0xc4ace88a7bda637cade13cd6e9a012f680f96bc25d47ebf3ad4705be1ce6e754::uln_302_ptb_builder::dvn_get_fee_multi_call_id()));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v8, v5);
        0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::add(&mut v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::create(v0, 0x1::ascii::string(b"dvn"), 0x1::ascii::string(b"confirm_get_fee"), v7, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>()));
        0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::build(v1)
    }

    // decompiled from Move bytecode v6
}

