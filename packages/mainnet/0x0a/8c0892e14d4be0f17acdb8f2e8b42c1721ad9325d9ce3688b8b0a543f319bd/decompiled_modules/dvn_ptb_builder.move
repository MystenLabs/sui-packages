module 0xa8c0892e14d4be0f17acdb8f2e8b42c1721ad9325d9ce3688b8b0a543f319bd::dvn_ptb_builder {
    fun append_get_fee_move_calls(arg0: &mut 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::MoveCallsBuilder, arg1: &0x6b25ab1e9681f46d8893924ba5a6cd265ba3226cf33bb8706d26afc1e853084f::dvn_fee_lib::DvnFeeLib, arg2: &0x1fbacb4e93fb8cef461cc14542816d73c3cd9482447f4a01748a36235e9fbbde::price_feed::PriceFeed, arg3: 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument) {
        let v0 = 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::package::package_of_type<0x6b25ab1e9681f46d8893924ba5a6cd265ba3226cf33bb8706d26afc1e853084f::dvn_fee_lib::DvnFeeLib>();
        let v1 = 0x1::vector::empty<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v2, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_object(0x2::object::id_address<0x6b25ab1e9681f46d8893924ba5a6cd265ba3226cf33bb8706d26afc1e853084f::dvn_fee_lib::DvnFeeLib>(arg1)));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v2, arg3);
        let v3 = 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::add(arg0, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::create(v0, 0x1::ascii::string(b"dvn_fee_lib"), 0x1::ascii::string(b"get_fee"), v1, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32>()));
        let v4 = 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::to_nested_result_arg(&v3, 0);
        let v5 = 0x1::vector::empty<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v6, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_object(0x2::object::id_address<0x1fbacb4e93fb8cef461cc14542816d73c3cd9482447f4a01748a36235e9fbbde::price_feed::PriceFeed>(arg2)));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v6, v4);
        let v7 = 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::add(arg0, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::create(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::package::package_of_type<0x1fbacb4e93fb8cef461cc14542816d73c3cd9482447f4a01748a36235e9fbbde::price_feed::PriceFeed>(), 0x1::ascii::string(b"price_feed"), 0x1::ascii::string(b"estimate_fee_by_eid"), v5, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32>()));
        0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::to_nested_result_arg(&v7, 0);
        let v8 = 0x1::vector::empty<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>();
        let v9 = &mut v8;
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v9, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_object(0x2::object::id_address<0x6b25ab1e9681f46d8893924ba5a6cd265ba3226cf33bb8706d26afc1e853084f::dvn_fee_lib::DvnFeeLib>(arg1)));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v9, arg3);
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v9, v4);
        0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::add(arg0, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::create(v0, 0x1::ascii::string(b"dvn_fee_lib"), 0x1::ascii::string(b"confirm_get_fee"), v8, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32>()));
    }

    public fun build_assign_job_ptb(arg0: &0x47e44a6c44436603a3e1f9cbbe91c47f92247fbd0254a696cd7da4627af381b9::dvn::DVN, arg1: &0x6b25ab1e9681f46d8893924ba5a6cd265ba3226cf33bb8706d26afc1e853084f::dvn_fee_lib::DvnFeeLib, arg2: &0x1fbacb4e93fb8cef461cc14542816d73c3cd9482447f4a01748a36235e9fbbde::price_feed::PriceFeed) : vector<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall> {
        let v0 = 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::package::package_of_type<0x47e44a6c44436603a3e1f9cbbe91c47f92247fbd0254a696cd7da4627af381b9::dvn::DVN>();
        let v1 = 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::new();
        let v2 = 0x1::vector::empty<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v3, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_object(0x2::object::id_address<0x47e44a6c44436603a3e1f9cbbe91c47f92247fbd0254a696cd7da4627af381b9::dvn::DVN>(arg0)));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v3, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_id(0x30baf1976f59c6dcd5a7bb5af67af1476d819ce93eeb1b944bef069c7c0e42a7::uln_302_ptb_builder::dvn_assign_job_multi_call_id()));
        let v4 = 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::add(&mut v1, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::create(v0, 0x1::ascii::string(b"dvn"), 0x1::ascii::string(b"assign_job"), v2, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32>()));
        let v5 = 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::to_nested_result_arg(&v4, 0);
        let v6 = &mut v1;
        append_get_fee_move_calls(v6, arg1, arg2, v5);
        let v7 = 0x1::vector::empty<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v8, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_object(0x2::object::id_address<0x47e44a6c44436603a3e1f9cbbe91c47f92247fbd0254a696cd7da4627af381b9::dvn::DVN>(arg0)));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v8, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_id(0x30baf1976f59c6dcd5a7bb5af67af1476d819ce93eeb1b944bef069c7c0e42a7::uln_302_ptb_builder::dvn_assign_job_multi_call_id()));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v8, v5);
        0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::add(&mut v1, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::create(v0, 0x1::ascii::string(b"dvn"), 0x1::ascii::string(b"confirm_assign_job"), v7, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32>()));
        0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::build(v1)
    }

    public fun build_dvn_ptb(arg0: &0x47e44a6c44436603a3e1f9cbbe91c47f92247fbd0254a696cd7da4627af381b9::dvn::DVN, arg1: &0x6b25ab1e9681f46d8893924ba5a6cd265ba3226cf33bb8706d26afc1e853084f::dvn_fee_lib::DvnFeeLib, arg2: &0x1fbacb4e93fb8cef461cc14542816d73c3cd9482447f4a01748a36235e9fbbde::price_feed::PriceFeed) : (vector<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall>, vector<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall>) {
        (build_get_fee_ptb(arg0, arg1, arg2), build_assign_job_ptb(arg0, arg1, arg2))
    }

    public fun build_get_fee_ptb(arg0: &0x47e44a6c44436603a3e1f9cbbe91c47f92247fbd0254a696cd7da4627af381b9::dvn::DVN, arg1: &0x6b25ab1e9681f46d8893924ba5a6cd265ba3226cf33bb8706d26afc1e853084f::dvn_fee_lib::DvnFeeLib, arg2: &0x1fbacb4e93fb8cef461cc14542816d73c3cd9482447f4a01748a36235e9fbbde::price_feed::PriceFeed) : vector<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall> {
        let v0 = 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::package::package_of_type<0x47e44a6c44436603a3e1f9cbbe91c47f92247fbd0254a696cd7da4627af381b9::dvn::DVN>();
        let v1 = 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::new();
        let v2 = 0x1::vector::empty<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v3, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_object(0x2::object::id_address<0x47e44a6c44436603a3e1f9cbbe91c47f92247fbd0254a696cd7da4627af381b9::dvn::DVN>(arg0)));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v3, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_id(0x30baf1976f59c6dcd5a7bb5af67af1476d819ce93eeb1b944bef069c7c0e42a7::uln_302_ptb_builder::dvn_get_fee_multi_call_id()));
        let v4 = 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::add(&mut v1, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::create(v0, 0x1::ascii::string(b"dvn"), 0x1::ascii::string(b"get_fee"), v2, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32>()));
        let v5 = 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::to_nested_result_arg(&v4, 0);
        let v6 = &mut v1;
        append_get_fee_move_calls(v6, arg1, arg2, v5);
        let v7 = 0x1::vector::empty<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v8, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_object(0x2::object::id_address<0x47e44a6c44436603a3e1f9cbbe91c47f92247fbd0254a696cd7da4627af381b9::dvn::DVN>(arg0)));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v8, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_id(0x30baf1976f59c6dcd5a7bb5af67af1476d819ce93eeb1b944bef069c7c0e42a7::uln_302_ptb_builder::dvn_get_fee_multi_call_id()));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v8, v5);
        0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::add(&mut v1, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::create(v0, 0x1::ascii::string(b"dvn"), 0x1::ascii::string(b"confirm_get_fee"), v7, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32>()));
        0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::build(v1)
    }

    // decompiled from Move bytecode v6
}

