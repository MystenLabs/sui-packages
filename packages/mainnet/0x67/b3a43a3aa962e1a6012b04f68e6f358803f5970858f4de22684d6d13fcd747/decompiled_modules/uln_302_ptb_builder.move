module 0x67b3a43a3aa962e1a6012b04f68e6f358803f5970858f4de22684d6d13fcd747::uln_302_ptb_builder {
    struct ULN_302_PTB_BUILDER has drop {
        dummy_field: bool,
    }

    struct Uln302PtbBuilder has key {
        id: 0x2::object::UID,
        call_cap: 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::CallCap,
        worker_ptbs: 0x2::table::Table<address, WorkerPtbs>,
    }

    struct WorkerPtbs has copy, drop, store {
        get_fee_ptb: vector<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::MoveCall>,
        assign_job_ptb: vector<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::MoveCall>,
    }

    public fun build_quote_ptb(arg0: &Uln302PtbBuilder, arg1: &0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_302::Uln302, arg2: &0xcb8bc76ad2dde43cb83fe4f27a702df0874e99c047317251ee878893c17c83c5::treasury::Treasury, arg3: &0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_quote::QuoteParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee::MessagingFee>) : vector<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::MoveCall> {
        let v0 = 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::package::original_package_of_type<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_302::Uln302>();
        let v1 = 0x2::object::id_address<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_302::Uln302>(arg1);
        let v2 = 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_quote::packet(0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::param<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_quote::QuoteParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee::MessagingFee>(arg3));
        let v3 = 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::new();
        let v4 = 0x1::vector::empty<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>();
        let v5 = &mut v4;
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v5, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_object(v1));
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v5, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_id(0x387af0542c79874a52c3e8812390c0fd02a8e947ce54aea8d80481ac2b5b3acb::endpoint_ptb_builder::message_lib_quote_call_id()));
        let v6 = 0x1::vector::empty<0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32>();
        let v7 = &mut v6;
        0x1::vector::push_back<0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32>(v7, executor_get_fee_call_id());
        0x1::vector::push_back<0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32>(v7, dvn_get_fee_multi_call_id());
        let v8 = 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::add(&mut v3, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::create(v0, 0x1::ascii::string(b"uln_302"), 0x1::ascii::string(b"quote"), v4, 0x1::vector::empty<0x1::type_name::TypeName>(), false, v6));
        let v9 = 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_302::get_effective_executor_config(arg1, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::outbound_packet::sender(v2), 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::outbound_packet::dst_eid(v2));
        0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::append(&mut v3, *get_fee_ptb(get_worker_ptbs(arg0, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_config::executor(&v9))));
        let v10 = 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_302::get_effective_send_uln_config(arg1, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::outbound_packet::sender(v2), 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::outbound_packet::dst_eid(v2));
        let v11 = 0x1::vector::empty<vector<address>>();
        let v12 = &mut v11;
        0x1::vector::push_back<vector<address>>(v12, *0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_config::required_dvns(&v10));
        0x1::vector::push_back<vector<address>>(v12, *0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_config::optional_dvns(&v10));
        let v13 = 0x1::vector::flatten<address>(v11);
        let v14 = &v13;
        let v15 = 0;
        while (v15 < 0x1::vector::length<address>(v14)) {
            0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::append(&mut v3, *get_fee_ptb(get_worker_ptbs(arg0, *0x1::vector::borrow<address>(v14, v15))));
            v15 = v15 + 1;
        };
        let v16 = 0x1::vector::empty<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>();
        let v17 = &mut v16;
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v17, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_object(v1));
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v17, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_object(0x2::object::id_address<0xcb8bc76ad2dde43cb83fe4f27a702df0874e99c047317251ee878893c17c83c5::treasury::Treasury>(arg2)));
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v17, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_id(0x387af0542c79874a52c3e8812390c0fd02a8e947ce54aea8d80481ac2b5b3acb::endpoint_ptb_builder::message_lib_quote_call_id()));
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v17, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::to_nested_result_arg(&v8, 0));
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v17, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::to_nested_result_arg(&v8, 1));
        0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::add(&mut v3, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::create(v0, 0x1::ascii::string(b"uln_302"), 0x1::ascii::string(b"confirm_quote"), v16, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32>()));
        0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::build(v3)
    }

    public fun build_send_ptb(arg0: &Uln302PtbBuilder, arg1: &0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_302::Uln302, arg2: &0xcb8bc76ad2dde43cb83fe4f27a702df0874e99c047317251ee878893c17c83c5::treasury::Treasury, arg3: &0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::EndpointV2, arg4: &0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendResult>) : vector<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::MoveCall> {
        let v0 = 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::package::original_package_of_type<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_302::Uln302>();
        let v1 = 0x2::object::id_address<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_302::Uln302>(arg1);
        let v2 = 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_quote::packet(0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::base(0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::param<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendResult>(arg4)));
        let v3 = 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::new();
        let v4 = 0x1::vector::empty<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>();
        let v5 = &mut v4;
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v5, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_object(v1));
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v5, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_id(0x387af0542c79874a52c3e8812390c0fd02a8e947ce54aea8d80481ac2b5b3acb::endpoint_ptb_builder::message_lib_send_call_id()));
        let v6 = 0x1::vector::empty<0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32>();
        let v7 = &mut v6;
        0x1::vector::push_back<0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32>(v7, executor_assign_job_call_id());
        0x1::vector::push_back<0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32>(v7, dvn_assign_job_multi_call_id());
        let v8 = 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::add(&mut v3, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::create(v0, 0x1::ascii::string(b"uln_302"), 0x1::ascii::string(b"send"), v4, 0x1::vector::empty<0x1::type_name::TypeName>(), false, v6));
        let v9 = 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_302::get_effective_executor_config(arg1, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::outbound_packet::sender(v2), 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::outbound_packet::dst_eid(v2));
        0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::append(&mut v3, *get_assign_job_ptb(get_worker_ptbs(arg0, 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_config::executor(&v9))));
        let v10 = 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_302::get_effective_send_uln_config(arg1, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::outbound_packet::sender(v2), 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::outbound_packet::dst_eid(v2));
        let v11 = 0x1::vector::empty<vector<address>>();
        let v12 = &mut v11;
        0x1::vector::push_back<vector<address>>(v12, *0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_config::required_dvns(&v10));
        0x1::vector::push_back<vector<address>>(v12, *0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_config::optional_dvns(&v10));
        let v13 = 0x1::vector::flatten<address>(v11);
        let v14 = &v13;
        let v15 = 0;
        while (v15 < 0x1::vector::length<address>(v14)) {
            0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::append(&mut v3, *get_assign_job_ptb(get_worker_ptbs(arg0, *0x1::vector::borrow<address>(v14, v15))));
            v15 = v15 + 1;
        };
        let v16 = 0x1::vector::empty<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>();
        let v17 = &mut v16;
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v17, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_object(v1));
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v17, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_object(0x2::object::id_address<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::EndpointV2>(arg3)));
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v17, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_object(0x2::object::id_address<0xcb8bc76ad2dde43cb83fe4f27a702df0874e99c047317251ee878893c17c83c5::treasury::Treasury>(arg2)));
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v17, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_object(0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::get_messaging_channel(arg3, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::outbound_packet::sender(v2))));
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v17, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_id(0x387af0542c79874a52c3e8812390c0fd02a8e947ce54aea8d80481ac2b5b3acb::endpoint_ptb_builder::endpoint_send_call_id()));
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v17, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_id(0x387af0542c79874a52c3e8812390c0fd02a8e947ce54aea8d80481ac2b5b3acb::endpoint_ptb_builder::message_lib_send_call_id()));
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v17, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::to_nested_result_arg(&v8, 0));
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v17, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::to_nested_result_arg(&v8, 1));
        0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::add(&mut v3, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::create(v0, 0x1::ascii::string(b"uln_302"), 0x1::ascii::string(b"confirm_send"), v16, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32>()));
        0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::build(v3)
    }

    public fun build_set_config_ptb(arg0: &0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_302::Uln302) : vector<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::MoveCall> {
        let v0 = 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::new();
        let v1 = 0x1::vector::empty<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>();
        let v2 = &mut v1;
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v2, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_object(0x2::object::id_address<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_302::Uln302>(arg0)));
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v2, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_id(0x387af0542c79874a52c3e8812390c0fd02a8e947ce54aea8d80481ac2b5b3acb::endpoint_ptb_builder::message_lib_set_config_call_id()));
        0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::add(&mut v0, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::create(0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::package::original_package_of_type<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_302::Uln302>(), 0x1::ascii::string(b"uln_302"), 0x1::ascii::string(b"set_config"), v1, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32>()));
        0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::build(v0)
    }

    public fun dvn_assign_job_multi_call_id() : 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get_with_original_ids<0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::multi_call::MultiCall<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_assign_job::AssignJobParam, 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::fee_recipient::FeeRecipient>>());
        0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::from_bytes(0x2::hash::keccak256(0x1::ascii::as_bytes(&v0)))
    }

    public fun dvn_get_fee_multi_call_id() : 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get_with_original_ids<0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::multi_call::MultiCall<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::dvn_get_fee::GetFeeParam, u64>>());
        0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::from_bytes(0x2::hash::keccak256(0x1::ascii::as_bytes(&v0)))
    }

    public fun executor_assign_job_call_id() : 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get_with_original_ids<0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_assign_job::AssignJobParam, 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::fee_recipient::FeeRecipient>>());
        0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::from_bytes(0x2::hash::keccak256(0x1::ascii::as_bytes(&v0)))
    }

    public fun executor_get_fee_call_id() : 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get_with_original_ids<0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_get_fee::GetFeeParam, u64>>());
        0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::from_bytes(0x2::hash::keccak256(0x1::ascii::as_bytes(&v0)))
    }

    public fun get_assign_job_ptb(arg0: &WorkerPtbs) : &vector<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::MoveCall> {
        &arg0.assign_job_ptb
    }

    public fun get_fee_ptb(arg0: &WorkerPtbs) : &vector<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::MoveCall> {
        &arg0.get_fee_ptb
    }

    public fun get_ptb_builder_info(arg0: &Uln302PtbBuilder, arg1: &0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_302::Uln302, arg2: &0xcb8bc76ad2dde43cb83fe4f27a702df0874e99c047317251ee878893c17c83c5::treasury::Treasury, arg3: &0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::EndpointV2) : 0x387af0542c79874a52c3e8812390c0fd02a8e947ce54aea8d80481ac2b5b3acb::msglib_ptb_builder_info::MsglibPtbBuilderInfo {
        let v0 = 0x1::ascii::string(b"uln_302_ptb_builder");
        let v1 = 0x2::object::id_address<Uln302PtbBuilder>(arg0);
        let v2 = 0x2::object::id_address<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_302::Uln302>(arg1);
        let v3 = 0x2::object::id_address<0xcb8bc76ad2dde43cb83fe4f27a702df0874e99c047317251ee878893c17c83c5::treasury::Treasury>(arg2);
        let v4 = 0x1::vector::empty<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>();
        let v5 = &mut v4;
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v5, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_object(v1));
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v5, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_object(v2));
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v5, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_object(v3));
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v5, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_id(0x387af0542c79874a52c3e8812390c0fd02a8e947ce54aea8d80481ac2b5b3acb::endpoint_ptb_builder::message_lib_quote_call_id()));
        let v6 = 0x1::vector::empty<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::MoveCall>();
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::MoveCall>(&mut v6, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::create(0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::id(&arg0.call_cap), v0, 0x1::ascii::string(b"build_quote_ptb"), v4, 0x1::vector::empty<0x1::type_name::TypeName>(), true, 0x1::vector::empty<0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32>()));
        let v7 = 0x1::vector::empty<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>();
        let v8 = &mut v7;
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v8, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_object(v1));
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v8, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_object(v2));
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v8, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_object(v3));
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v8, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_object(0x2::object::id_address<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::EndpointV2>(arg3)));
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v8, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_id(0x387af0542c79874a52c3e8812390c0fd02a8e947ce54aea8d80481ac2b5b3acb::endpoint_ptb_builder::message_lib_send_call_id()));
        let v9 = 0x1::vector::empty<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::MoveCall>();
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::MoveCall>(&mut v9, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::create(0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::id(&arg0.call_cap), v0, 0x1::ascii::string(b"build_send_ptb"), v7, 0x1::vector::empty<0x1::type_name::TypeName>(), true, 0x1::vector::empty<0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32>()));
        0x387af0542c79874a52c3e8812390c0fd02a8e947ce54aea8d80481ac2b5b3acb::msglib_ptb_builder_info::create(0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::package::original_package_of_type<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_302::Uln302>(), 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::id(&arg0.call_cap), v6, v9, build_set_config_ptb(arg1))
    }

    public fun get_worker_ptbs(arg0: &Uln302PtbBuilder, arg1: address) : &WorkerPtbs {
        let v0 = &arg0.worker_ptbs;
        assert!(0x2::table::contains<address, WorkerPtbs>(v0, arg1), 1);
        0x2::table::borrow<address, WorkerPtbs>(v0, arg1)
    }

    fun init(arg0: ULN_302_PTB_BUILDER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Uln302PtbBuilder{
            id          : 0x2::object::new(arg1),
            call_cap    : 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::new_package_cap<ULN_302_PTB_BUILDER>(&arg0, arg1),
            worker_ptbs : 0x2::table::new<address, WorkerPtbs>(arg1),
        };
        0x2::transfer::share_object<Uln302PtbBuilder>(v0);
    }

    public fun is_worker_ptbs_set(arg0: &Uln302PtbBuilder, arg1: address) : bool {
        0x2::table::contains<address, WorkerPtbs>(&arg0.worker_ptbs, arg1)
    }

    public fun set_worker_ptbs(arg0: &mut Uln302PtbBuilder, arg1: 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xea847a7eee0e55f52a121829cc6ede9603649a39290e6d46566e9206d5e9761f::set_worker_ptb::SetWorkerPtbParam, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Void>) {
        let v0 = 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::caller<0xea847a7eee0e55f52a121829cc6ede9603649a39290e6d46566e9206d5e9761f::set_worker_ptb::SetWorkerPtbParam, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Void>(&arg1);
        let (v1, v2) = 0xea847a7eee0e55f52a121829cc6ede9603649a39290e6d46566e9206d5e9761f::set_worker_ptb::unpack(0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::complete_and_destroy<0xea847a7eee0e55f52a121829cc6ede9603649a39290e6d46566e9206d5e9761f::set_worker_ptb::SetWorkerPtbParam>(arg1, &arg0.call_cap));
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

