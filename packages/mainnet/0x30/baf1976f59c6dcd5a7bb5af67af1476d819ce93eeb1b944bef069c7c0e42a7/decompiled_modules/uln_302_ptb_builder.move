module 0x30baf1976f59c6dcd5a7bb5af67af1476d819ce93eeb1b944bef069c7c0e42a7::uln_302_ptb_builder {
    struct ULN_302_PTB_BUILDER has drop {
        dummy_field: bool,
    }

    struct Uln302PtbBuilder has key {
        id: 0x2::object::UID,
        call_cap: 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::CallCap,
        worker_ptbs: 0x2::table::Table<address, WorkerPtbs>,
    }

    struct WorkerPtbs has copy, drop, store {
        get_fee_ptb: vector<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall>,
        assign_job_ptb: vector<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall>,
    }

    public fun build_quote_ptb(arg0: &Uln302PtbBuilder, arg1: &0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_302::Uln302, arg2: &0xc8241ec5be82f02e6b0d1bb7fdaed0ba4ae9cc423fe67545fa52466ca80f87cb::treasury::Treasury, arg3: &0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_quote::QuoteParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_fee::MessagingFee>) : vector<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall> {
        let v0 = 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::package::original_package_of_type<0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_302::Uln302>();
        let v1 = 0x2::object::id_address<0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_302::Uln302>(arg1);
        let v2 = 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_quote::packet(0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::param<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_quote::QuoteParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_fee::MessagingFee>(arg3));
        let v3 = 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::new();
        let v4 = 0x1::vector::empty<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v5, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_object(v1));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v5, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_id(0x674fa05c5ce6b616dff646b680f14afe207eafe432b68c4ea59ec417b8c49ba4::endpoint_ptb_builder::message_lib_quote_call_id()));
        let v6 = 0x1::vector::empty<0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32>();
        let v7 = &mut v6;
        0x1::vector::push_back<0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32>(v7, executor_get_fee_call_id());
        0x1::vector::push_back<0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32>(v7, dvn_get_fee_multi_call_id());
        let v8 = 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::add(&mut v3, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::create(v0, 0x1::ascii::string(b"uln_302"), 0x1::ascii::string(b"quote"), v4, 0x1::vector::empty<0x1::type_name::TypeName>(), false, v6));
        let v9 = 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_302::get_effective_executor_config(arg1, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::outbound_packet::sender(v2), 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::outbound_packet::dst_eid(v2));
        0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::append(&mut v3, *get_fee_ptb(get_worker_ptbs(arg0, 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::executor_config::executor(&v9))));
        let v10 = 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_302::get_effective_send_uln_config(arg1, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::outbound_packet::sender(v2), 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::outbound_packet::dst_eid(v2));
        let v11 = 0x1::vector::empty<vector<address>>();
        let v12 = &mut v11;
        0x1::vector::push_back<vector<address>>(v12, *0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_config::required_dvns(&v10));
        0x1::vector::push_back<vector<address>>(v12, *0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_config::optional_dvns(&v10));
        let v13 = 0x1::vector::flatten<address>(v11);
        let v14 = &v13;
        let v15 = 0;
        while (v15 < 0x1::vector::length<address>(v14)) {
            0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::append(&mut v3, *get_fee_ptb(get_worker_ptbs(arg0, *0x1::vector::borrow<address>(v14, v15))));
            v15 = v15 + 1;
        };
        let v16 = 0x1::vector::empty<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>();
        let v17 = &mut v16;
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v17, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_object(v1));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v17, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_object(0x2::object::id_address<0xc8241ec5be82f02e6b0d1bb7fdaed0ba4ae9cc423fe67545fa52466ca80f87cb::treasury::Treasury>(arg2)));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v17, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_id(0x674fa05c5ce6b616dff646b680f14afe207eafe432b68c4ea59ec417b8c49ba4::endpoint_ptb_builder::message_lib_quote_call_id()));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v17, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::to_nested_result_arg(&v8, 0));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v17, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::to_nested_result_arg(&v8, 1));
        0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::add(&mut v3, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::create(v0, 0x1::ascii::string(b"uln_302"), 0x1::ascii::string(b"confirm_quote"), v16, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32>()));
        0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::build(v3)
    }

    public fun build_send_ptb(arg0: &Uln302PtbBuilder, arg1: &0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_302::Uln302, arg2: &0xc8241ec5be82f02e6b0d1bb7fdaed0ba4ae9cc423fe67545fa52466ca80f87cb::treasury::Treasury, arg3: &0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::EndpointV2, arg4: &0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_send::SendParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_send::SendResult>) : vector<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall> {
        let v0 = 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::package::original_package_of_type<0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_302::Uln302>();
        let v1 = 0x2::object::id_address<0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_302::Uln302>(arg1);
        let v2 = 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_quote::packet(0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_send::base(0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::param<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_send::SendParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_send::SendResult>(arg4)));
        let v3 = 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::new();
        let v4 = 0x1::vector::empty<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v5, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_object(v1));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v5, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_id(0x674fa05c5ce6b616dff646b680f14afe207eafe432b68c4ea59ec417b8c49ba4::endpoint_ptb_builder::message_lib_send_call_id()));
        let v6 = 0x1::vector::empty<0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32>();
        let v7 = &mut v6;
        0x1::vector::push_back<0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32>(v7, executor_assign_job_call_id());
        0x1::vector::push_back<0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32>(v7, dvn_assign_job_multi_call_id());
        let v8 = 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::add(&mut v3, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::create(v0, 0x1::ascii::string(b"uln_302"), 0x1::ascii::string(b"send"), v4, 0x1::vector::empty<0x1::type_name::TypeName>(), false, v6));
        let v9 = 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_302::get_effective_executor_config(arg1, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::outbound_packet::sender(v2), 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::outbound_packet::dst_eid(v2));
        0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::append(&mut v3, *get_assign_job_ptb(get_worker_ptbs(arg0, 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::executor_config::executor(&v9))));
        let v10 = 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_302::get_effective_send_uln_config(arg1, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::outbound_packet::sender(v2), 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::outbound_packet::dst_eid(v2));
        let v11 = 0x1::vector::empty<vector<address>>();
        let v12 = &mut v11;
        0x1::vector::push_back<vector<address>>(v12, *0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_config::required_dvns(&v10));
        0x1::vector::push_back<vector<address>>(v12, *0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_config::optional_dvns(&v10));
        let v13 = 0x1::vector::flatten<address>(v11);
        let v14 = &v13;
        let v15 = 0;
        while (v15 < 0x1::vector::length<address>(v14)) {
            0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::append(&mut v3, *get_assign_job_ptb(get_worker_ptbs(arg0, *0x1::vector::borrow<address>(v14, v15))));
            v15 = v15 + 1;
        };
        let v16 = 0x1::vector::empty<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>();
        let v17 = &mut v16;
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v17, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_object(v1));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v17, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_object(0x2::object::id_address<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::EndpointV2>(arg3)));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v17, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_object(0x2::object::id_address<0xc8241ec5be82f02e6b0d1bb7fdaed0ba4ae9cc423fe67545fa52466ca80f87cb::treasury::Treasury>(arg2)));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v17, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_object(0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::get_messaging_channel(arg3, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::outbound_packet::sender(v2))));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v17, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_id(0x674fa05c5ce6b616dff646b680f14afe207eafe432b68c4ea59ec417b8c49ba4::endpoint_ptb_builder::endpoint_send_call_id()));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v17, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_id(0x674fa05c5ce6b616dff646b680f14afe207eafe432b68c4ea59ec417b8c49ba4::endpoint_ptb_builder::message_lib_send_call_id()));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v17, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::to_nested_result_arg(&v8, 0));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v17, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::to_nested_result_arg(&v8, 1));
        0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::add(&mut v3, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::create(v0, 0x1::ascii::string(b"uln_302"), 0x1::ascii::string(b"confirm_send"), v16, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32>()));
        0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::build(v3)
    }

    public fun build_set_config_ptb(arg0: &0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_302::Uln302) : vector<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall> {
        let v0 = 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::new();
        let v1 = 0x1::vector::empty<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v2, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_object(0x2::object::id_address<0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_302::Uln302>(arg0)));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v2, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_id(0x674fa05c5ce6b616dff646b680f14afe207eafe432b68c4ea59ec417b8c49ba4::endpoint_ptb_builder::message_lib_set_config_call_id()));
        0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::add(&mut v0, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::create(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::package::original_package_of_type<0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_302::Uln302>(), 0x1::ascii::string(b"uln_302"), 0x1::ascii::string(b"set_config"), v1, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32>()));
        0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::build(v0)
    }

    public fun dvn_assign_job_multi_call_id() : 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get_with_original_ids<0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::multi_call::MultiCall<0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::dvn_assign_job::AssignJobParam, 0x5d62c9e28bb3af663b8fd746d36293cd642c26acf8836028eebb6b72ba55ccdc::fee_recipient::FeeRecipient>>());
        0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::from_bytes(0x2::hash::keccak256(0x1::ascii::as_bytes(&v0)))
    }

    public fun dvn_get_fee_multi_call_id() : 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get_with_original_ids<0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::multi_call::MultiCall<0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::dvn_get_fee::GetFeeParam, u64>>());
        0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::from_bytes(0x2::hash::keccak256(0x1::ascii::as_bytes(&v0)))
    }

    public fun executor_assign_job_call_id() : 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get_with_original_ids<0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::executor_assign_job::AssignJobParam, 0x5d62c9e28bb3af663b8fd746d36293cd642c26acf8836028eebb6b72ba55ccdc::fee_recipient::FeeRecipient>>());
        0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::from_bytes(0x2::hash::keccak256(0x1::ascii::as_bytes(&v0)))
    }

    public fun executor_get_fee_call_id() : 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get_with_original_ids<0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::executor_get_fee::GetFeeParam, u64>>());
        0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::from_bytes(0x2::hash::keccak256(0x1::ascii::as_bytes(&v0)))
    }

    public fun get_assign_job_ptb(arg0: &WorkerPtbs) : &vector<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall> {
        &arg0.assign_job_ptb
    }

    public fun get_fee_ptb(arg0: &WorkerPtbs) : &vector<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall> {
        &arg0.get_fee_ptb
    }

    public fun get_ptb_builder_info(arg0: &Uln302PtbBuilder, arg1: &0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_302::Uln302, arg2: &0xc8241ec5be82f02e6b0d1bb7fdaed0ba4ae9cc423fe67545fa52466ca80f87cb::treasury::Treasury, arg3: &0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::EndpointV2) : 0x674fa05c5ce6b616dff646b680f14afe207eafe432b68c4ea59ec417b8c49ba4::msglib_ptb_builder_info::MsglibPtbBuilderInfo {
        let v0 = 0x1::ascii::string(b"uln_302_ptb_builder");
        let v1 = 0x2::object::id_address<Uln302PtbBuilder>(arg0);
        let v2 = 0x2::object::id_address<0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_302::Uln302>(arg1);
        let v3 = 0x2::object::id_address<0xc8241ec5be82f02e6b0d1bb7fdaed0ba4ae9cc423fe67545fa52466ca80f87cb::treasury::Treasury>(arg2);
        let v4 = 0x1::vector::empty<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v5, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_object(v1));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v5, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_object(v2));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v5, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_object(v3));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v5, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_id(0x674fa05c5ce6b616dff646b680f14afe207eafe432b68c4ea59ec417b8c49ba4::endpoint_ptb_builder::message_lib_quote_call_id()));
        let v6 = 0x1::vector::empty<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall>();
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall>(&mut v6, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::create(0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::id(&arg0.call_cap), v0, 0x1::ascii::string(b"build_quote_ptb"), v4, 0x1::vector::empty<0x1::type_name::TypeName>(), true, 0x1::vector::empty<0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32>()));
        let v7 = 0x1::vector::empty<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v8, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_object(v1));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v8, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_object(v2));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v8, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_object(v3));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v8, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_object(0x2::object::id_address<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::EndpointV2>(arg3)));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v8, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_id(0x674fa05c5ce6b616dff646b680f14afe207eafe432b68c4ea59ec417b8c49ba4::endpoint_ptb_builder::message_lib_send_call_id()));
        let v9 = 0x1::vector::empty<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall>();
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall>(&mut v9, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::create(0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::id(&arg0.call_cap), v0, 0x1::ascii::string(b"build_send_ptb"), v7, 0x1::vector::empty<0x1::type_name::TypeName>(), true, 0x1::vector::empty<0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32>()));
        0x674fa05c5ce6b616dff646b680f14afe207eafe432b68c4ea59ec417b8c49ba4::msglib_ptb_builder_info::create(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::package::original_package_of_type<0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_302::Uln302>(), 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::id(&arg0.call_cap), v6, v9, build_set_config_ptb(arg1))
    }

    public fun get_worker_ptbs(arg0: &Uln302PtbBuilder, arg1: address) : &WorkerPtbs {
        let v0 = &arg0.worker_ptbs;
        assert!(0x2::table::contains<address, WorkerPtbs>(v0, arg1), 1);
        0x2::table::borrow<address, WorkerPtbs>(v0, arg1)
    }

    fun init(arg0: ULN_302_PTB_BUILDER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Uln302PtbBuilder{
            id          : 0x2::object::new(arg1),
            call_cap    : 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::new_package_cap<ULN_302_PTB_BUILDER>(&arg0, arg1),
            worker_ptbs : 0x2::table::new<address, WorkerPtbs>(arg1),
        };
        0x2::transfer::share_object<Uln302PtbBuilder>(v0);
    }

    public fun is_worker_ptbs_set(arg0: &Uln302PtbBuilder, arg1: address) : bool {
        0x2::table::contains<address, WorkerPtbs>(&arg0.worker_ptbs, arg1)
    }

    public fun set_worker_ptbs(arg0: &mut Uln302PtbBuilder, arg1: 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0x7ced627732424c03899cbcbcf51ac3401eddadda1662dbaa89dc7ef95fda2c04::set_worker_ptb::SetWorkerPtbParam, 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Void>) {
        let v0 = 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::caller<0x7ced627732424c03899cbcbcf51ac3401eddadda1662dbaa89dc7ef95fda2c04::set_worker_ptb::SetWorkerPtbParam, 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Void>(&arg1);
        0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::complete<0x7ced627732424c03899cbcbcf51ac3401eddadda1662dbaa89dc7ef95fda2c04::set_worker_ptb::SetWorkerPtbParam, 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Void>(&mut arg1, &arg0.call_cap, 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::void());
        let (_, v2, _) = 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::destroy<0x7ced627732424c03899cbcbcf51ac3401eddadda1662dbaa89dc7ef95fda2c04::set_worker_ptb::SetWorkerPtbParam, 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Void>(arg1, &arg0.call_cap);
        let (v4, v5) = 0x7ced627732424c03899cbcbcf51ac3401eddadda1662dbaa89dc7ef95fda2c04::set_worker_ptb::unpack(v2);
        let v6 = &mut arg0.worker_ptbs;
        if (0x2::table::contains<address, WorkerPtbs>(v6, v0)) {
            let v7 = WorkerPtbs{
                get_fee_ptb    : v4,
                assign_job_ptb : v5,
            };
            *0x2::table::borrow_mut<address, WorkerPtbs>(v6, v0) = v7;
        } else {
            let v8 = WorkerPtbs{
                get_fee_ptb    : v4,
                assign_job_ptb : v5,
            };
            0x2::table::add<address, WorkerPtbs>(v6, v0, v8);
        };
    }

    // decompiled from Move bytecode v6
}

