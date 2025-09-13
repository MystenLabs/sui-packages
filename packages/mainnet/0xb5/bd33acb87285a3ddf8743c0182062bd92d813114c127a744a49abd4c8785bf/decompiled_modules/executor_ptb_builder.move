module 0xb5bd33acb87285a3ddf8743c0182062bd92d813114c127a744a49abd4c8785bf::executor_ptb_builder {
    fun append_get_fee_move_calls(arg0: &mut 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::MoveCallsBuilder, arg1: &0xf4a1d39e207110d3abe05c9df7e89844ec56fe2b85d86b674cc018a336a030d8::executor_fee_lib::ExecutorFeeLib, arg2: &0x1fbacb4e93fb8cef461cc14542816d73c3cd9482447f4a01748a36235e9fbbde::price_feed::PriceFeed, arg3: 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument) {
        let v0 = 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::package::package_of_type<0xf4a1d39e207110d3abe05c9df7e89844ec56fe2b85d86b674cc018a336a030d8::executor_fee_lib::ExecutorFeeLib>();
        let v1 = 0x1::vector::empty<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v2, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_object(0x2::object::id_address<0xf4a1d39e207110d3abe05c9df7e89844ec56fe2b85d86b674cc018a336a030d8::executor_fee_lib::ExecutorFeeLib>(arg1)));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v2, arg3);
        let v3 = 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::add(arg0, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::create(v0, 0x1::ascii::string(b"executor_fee_lib"), 0x1::ascii::string(b"get_fee"), v1, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32>()));
        let v4 = 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::to_nested_result_arg(&v3, 0);
        let v5 = 0x1::vector::empty<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v6, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_object(0x2::object::id_address<0x1fbacb4e93fb8cef461cc14542816d73c3cd9482447f4a01748a36235e9fbbde::price_feed::PriceFeed>(arg2)));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v6, v4);
        0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::add(arg0, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::create(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::package::package_of_type<0x1fbacb4e93fb8cef461cc14542816d73c3cd9482447f4a01748a36235e9fbbde::price_feed::PriceFeed>(), 0x1::ascii::string(b"price_feed"), 0x1::ascii::string(b"estimate_fee_by_eid"), v5, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32>()));
        let v7 = 0x1::vector::empty<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v8, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_object(0x2::object::id_address<0xf4a1d39e207110d3abe05c9df7e89844ec56fe2b85d86b674cc018a336a030d8::executor_fee_lib::ExecutorFeeLib>(arg1)));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v8, arg3);
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v8, v4);
        0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::add(arg0, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::create(v0, 0x1::ascii::string(b"executor_fee_lib"), 0x1::ascii::string(b"confirm_get_fee"), v7, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32>()));
    }

    public fun build_assign_job_ptb(arg0: &0x8d9ea9aa165f57b65b46174132d3db456ac05f083f76600f25de2a0b81f3eff7::executor_worker::Executor, arg1: &0xf4a1d39e207110d3abe05c9df7e89844ec56fe2b85d86b674cc018a336a030d8::executor_fee_lib::ExecutorFeeLib, arg2: &0x1fbacb4e93fb8cef461cc14542816d73c3cd9482447f4a01748a36235e9fbbde::price_feed::PriceFeed) : vector<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall> {
        let v0 = 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::package::package_of_type<0x8d9ea9aa165f57b65b46174132d3db456ac05f083f76600f25de2a0b81f3eff7::executor_worker::Executor>();
        let v1 = 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::new();
        let v2 = 0x1::vector::empty<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v3, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_object(0x2::object::id_address<0x8d9ea9aa165f57b65b46174132d3db456ac05f083f76600f25de2a0b81f3eff7::executor_worker::Executor>(arg0)));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v3, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_id(0x30baf1976f59c6dcd5a7bb5af67af1476d819ce93eeb1b944bef069c7c0e42a7::uln_302_ptb_builder::executor_assign_job_call_id()));
        let v4 = 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::add(&mut v1, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::create(v0, 0x1::ascii::string(b"executor_worker"), 0x1::ascii::string(b"assign_job"), v2, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32>()));
        let v5 = 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::to_nested_result_arg(&v4, 0);
        let v6 = &mut v1;
        append_get_fee_move_calls(v6, arg1, arg2, v5);
        let v7 = 0x1::vector::empty<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v8, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_object(0x2::object::id_address<0x8d9ea9aa165f57b65b46174132d3db456ac05f083f76600f25de2a0b81f3eff7::executor_worker::Executor>(arg0)));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v8, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_id(0x30baf1976f59c6dcd5a7bb5af67af1476d819ce93eeb1b944bef069c7c0e42a7::uln_302_ptb_builder::executor_assign_job_call_id()));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v8, v5);
        0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::add(&mut v1, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::create(v0, 0x1::ascii::string(b"executor_worker"), 0x1::ascii::string(b"confirm_assign_job"), v7, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32>()));
        0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::build(v1)
    }

    public fun build_executor_ptb(arg0: &0x8d9ea9aa165f57b65b46174132d3db456ac05f083f76600f25de2a0b81f3eff7::executor_worker::Executor, arg1: &0xf4a1d39e207110d3abe05c9df7e89844ec56fe2b85d86b674cc018a336a030d8::executor_fee_lib::ExecutorFeeLib, arg2: &0x1fbacb4e93fb8cef461cc14542816d73c3cd9482447f4a01748a36235e9fbbde::price_feed::PriceFeed) : (vector<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall>, vector<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall>) {
        (build_get_fee_ptb(arg0, arg1, arg2), build_assign_job_ptb(arg0, arg1, arg2))
    }

    public fun build_get_fee_ptb(arg0: &0x8d9ea9aa165f57b65b46174132d3db456ac05f083f76600f25de2a0b81f3eff7::executor_worker::Executor, arg1: &0xf4a1d39e207110d3abe05c9df7e89844ec56fe2b85d86b674cc018a336a030d8::executor_fee_lib::ExecutorFeeLib, arg2: &0x1fbacb4e93fb8cef461cc14542816d73c3cd9482447f4a01748a36235e9fbbde::price_feed::PriceFeed) : vector<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall> {
        let v0 = 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::package::package_of_type<0x8d9ea9aa165f57b65b46174132d3db456ac05f083f76600f25de2a0b81f3eff7::executor_worker::Executor>();
        let v1 = 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::new();
        let v2 = 0x1::vector::empty<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v3, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_object(0x2::object::id_address<0x8d9ea9aa165f57b65b46174132d3db456ac05f083f76600f25de2a0b81f3eff7::executor_worker::Executor>(arg0)));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v3, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_id(0x30baf1976f59c6dcd5a7bb5af67af1476d819ce93eeb1b944bef069c7c0e42a7::uln_302_ptb_builder::executor_get_fee_call_id()));
        let v4 = 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::add(&mut v1, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::create(v0, 0x1::ascii::string(b"executor_worker"), 0x1::ascii::string(b"get_fee"), v2, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32>()));
        let v5 = 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::to_nested_result_arg(&v4, 0);
        let v6 = &mut v1;
        append_get_fee_move_calls(v6, arg1, arg2, v5);
        let v7 = 0x1::vector::empty<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v8, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_object(0x2::object::id_address<0x8d9ea9aa165f57b65b46174132d3db456ac05f083f76600f25de2a0b81f3eff7::executor_worker::Executor>(arg0)));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v8, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_id(0x30baf1976f59c6dcd5a7bb5af67af1476d819ce93eeb1b944bef069c7c0e42a7::uln_302_ptb_builder::executor_get_fee_call_id()));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v8, v5);
        0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::add(&mut v1, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::create(v0, 0x1::ascii::string(b"executor_worker"), 0x1::ascii::string(b"confirm_get_fee"), v7, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32>()));
        0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::build(v1)
    }

    // decompiled from Move bytecode v6
}

