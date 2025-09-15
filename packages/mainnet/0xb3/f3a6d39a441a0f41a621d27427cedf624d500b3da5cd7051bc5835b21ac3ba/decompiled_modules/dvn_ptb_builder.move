module 0xb3f3a6d39a441a0f41a621d27427cedf624d500b3da5cd7051bc5835b21ac3ba::dvn_ptb_builder {
    fun append_get_fee_move_calls(arg0: &mut 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::MoveCallsBuilder, arg1: &0xb94f476ccd37034f4f5fb9c541320b85f86e61ae7f654fa66f3b987e8fb3f825::dvn_fee_lib::DvnFeeLib, arg2: &0x9f12f79a355fca76492bc1908fc7a9a8518d2a83e65cffc93f134144dfa4e5bb::price_feed::PriceFeed, arg3: 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument) {
        let v0 = 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::package::package_of_type<0xb94f476ccd37034f4f5fb9c541320b85f86e61ae7f654fa66f3b987e8fb3f825::dvn_fee_lib::DvnFeeLib>();
        let v1 = 0x1::vector::empty<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>();
        let v2 = &mut v1;
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v2, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_object(0x2::object::id_address<0xb94f476ccd37034f4f5fb9c541320b85f86e61ae7f654fa66f3b987e8fb3f825::dvn_fee_lib::DvnFeeLib>(arg1)));
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v2, arg3);
        let v3 = 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::add(arg0, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::create(v0, 0x1::ascii::string(b"dvn_fee_lib"), 0x1::ascii::string(b"get_fee"), v1, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32>()));
        let v4 = 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::to_nested_result_arg(&v3, 0);
        let v5 = 0x1::vector::empty<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>();
        let v6 = &mut v5;
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v6, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_object(0x2::object::id_address<0x9f12f79a355fca76492bc1908fc7a9a8518d2a83e65cffc93f134144dfa4e5bb::price_feed::PriceFeed>(arg2)));
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v6, v4);
        let v7 = 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::add(arg0, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::create(0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::package::package_of_type<0x9f12f79a355fca76492bc1908fc7a9a8518d2a83e65cffc93f134144dfa4e5bb::price_feed::PriceFeed>(), 0x1::ascii::string(b"price_feed"), 0x1::ascii::string(b"estimate_fee_by_eid"), v5, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32>()));
        0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::to_nested_result_arg(&v7, 0);
        let v8 = 0x1::vector::empty<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>();
        let v9 = &mut v8;
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v9, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_object(0x2::object::id_address<0xb94f476ccd37034f4f5fb9c541320b85f86e61ae7f654fa66f3b987e8fb3f825::dvn_fee_lib::DvnFeeLib>(arg1)));
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v9, arg3);
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v9, v4);
        0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::add(arg0, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::create(v0, 0x1::ascii::string(b"dvn_fee_lib"), 0x1::ascii::string(b"confirm_get_fee"), v8, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32>()));
    }

    public fun build_assign_job_ptb(arg0: &0x6810f5568936a9a2b5fcb043f59a3cbf681e06f0db61c90bf3ff5530d4f470c0::dvn::DVN, arg1: &0xb94f476ccd37034f4f5fb9c541320b85f86e61ae7f654fa66f3b987e8fb3f825::dvn_fee_lib::DvnFeeLib, arg2: &0x9f12f79a355fca76492bc1908fc7a9a8518d2a83e65cffc93f134144dfa4e5bb::price_feed::PriceFeed) : vector<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::MoveCall> {
        let v0 = 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::package::package_of_type<0x6810f5568936a9a2b5fcb043f59a3cbf681e06f0db61c90bf3ff5530d4f470c0::dvn::DVN>();
        let v1 = 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::new();
        let v2 = 0x1::vector::empty<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>();
        let v3 = &mut v2;
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v3, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_object(0x2::object::id_address<0x6810f5568936a9a2b5fcb043f59a3cbf681e06f0db61c90bf3ff5530d4f470c0::dvn::DVN>(arg0)));
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v3, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_id(0x67b3a43a3aa962e1a6012b04f68e6f358803f5970858f4de22684d6d13fcd747::uln_302_ptb_builder::dvn_assign_job_multi_call_id()));
        let v4 = 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::add(&mut v1, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::create(v0, 0x1::ascii::string(b"dvn"), 0x1::ascii::string(b"assign_job"), v2, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32>()));
        let v5 = 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::to_nested_result_arg(&v4, 0);
        let v6 = &mut v1;
        append_get_fee_move_calls(v6, arg1, arg2, v5);
        let v7 = 0x1::vector::empty<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>();
        let v8 = &mut v7;
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v8, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_object(0x2::object::id_address<0x6810f5568936a9a2b5fcb043f59a3cbf681e06f0db61c90bf3ff5530d4f470c0::dvn::DVN>(arg0)));
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v8, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_id(0x67b3a43a3aa962e1a6012b04f68e6f358803f5970858f4de22684d6d13fcd747::uln_302_ptb_builder::dvn_assign_job_multi_call_id()));
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v8, v5);
        0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::add(&mut v1, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::create(v0, 0x1::ascii::string(b"dvn"), 0x1::ascii::string(b"confirm_assign_job"), v7, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32>()));
        0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::build(v1)
    }

    public fun build_dvn_ptb(arg0: &0x6810f5568936a9a2b5fcb043f59a3cbf681e06f0db61c90bf3ff5530d4f470c0::dvn::DVN, arg1: &0xb94f476ccd37034f4f5fb9c541320b85f86e61ae7f654fa66f3b987e8fb3f825::dvn_fee_lib::DvnFeeLib, arg2: &0x9f12f79a355fca76492bc1908fc7a9a8518d2a83e65cffc93f134144dfa4e5bb::price_feed::PriceFeed) : (vector<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::MoveCall>, vector<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::MoveCall>) {
        (build_get_fee_ptb(arg0, arg1, arg2), build_assign_job_ptb(arg0, arg1, arg2))
    }

    public fun build_get_fee_ptb(arg0: &0x6810f5568936a9a2b5fcb043f59a3cbf681e06f0db61c90bf3ff5530d4f470c0::dvn::DVN, arg1: &0xb94f476ccd37034f4f5fb9c541320b85f86e61ae7f654fa66f3b987e8fb3f825::dvn_fee_lib::DvnFeeLib, arg2: &0x9f12f79a355fca76492bc1908fc7a9a8518d2a83e65cffc93f134144dfa4e5bb::price_feed::PriceFeed) : vector<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::MoveCall> {
        let v0 = 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::package::package_of_type<0x6810f5568936a9a2b5fcb043f59a3cbf681e06f0db61c90bf3ff5530d4f470c0::dvn::DVN>();
        let v1 = 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::new();
        let v2 = 0x1::vector::empty<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>();
        let v3 = &mut v2;
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v3, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_object(0x2::object::id_address<0x6810f5568936a9a2b5fcb043f59a3cbf681e06f0db61c90bf3ff5530d4f470c0::dvn::DVN>(arg0)));
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v3, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_id(0x67b3a43a3aa962e1a6012b04f68e6f358803f5970858f4de22684d6d13fcd747::uln_302_ptb_builder::dvn_get_fee_multi_call_id()));
        let v4 = 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::add(&mut v1, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::create(v0, 0x1::ascii::string(b"dvn"), 0x1::ascii::string(b"get_fee"), v2, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32>()));
        let v5 = 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::to_nested_result_arg(&v4, 0);
        let v6 = &mut v1;
        append_get_fee_move_calls(v6, arg1, arg2, v5);
        let v7 = 0x1::vector::empty<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>();
        let v8 = &mut v7;
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v8, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_object(0x2::object::id_address<0x6810f5568936a9a2b5fcb043f59a3cbf681e06f0db61c90bf3ff5530d4f470c0::dvn::DVN>(arg0)));
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v8, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_id(0x67b3a43a3aa962e1a6012b04f68e6f358803f5970858f4de22684d6d13fcd747::uln_302_ptb_builder::dvn_get_fee_multi_call_id()));
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v8, v5);
        0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::add(&mut v1, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::create(v0, 0x1::ascii::string(b"dvn"), 0x1::ascii::string(b"confirm_get_fee"), v7, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32>()));
        0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::build(v1)
    }

    // decompiled from Move bytecode v6
}

