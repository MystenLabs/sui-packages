module 0xba557037446a5b114205c868db114957945dd21df9770796fea2b558fc4a20fd::simple_msglib_ptb_builder {
    struct SIMPLE_MSGLIB_PTB_BUILDER has drop {
        dummy_field: bool,
    }

    struct SimpleMsglibPtbBuilder has key {
        id: 0x2::object::UID,
        call_cap: 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::CallCap,
    }

    public fun build_quote_ptb(arg0: &0x83651370065f70112b20007137c7235a2a243055d9f59cb5e162c00c4a1680a7::simple_message_lib::SimpleMessageLib) : vector<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::MoveCall> {
        let v0 = 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::new();
        let v1 = 0x1::vector::empty<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>();
        let v2 = &mut v1;
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v2, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_object(0x2::object::id_address<0x83651370065f70112b20007137c7235a2a243055d9f59cb5e162c00c4a1680a7::simple_message_lib::SimpleMessageLib>(arg0)));
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v2, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_id(0x387af0542c79874a52c3e8812390c0fd02a8e947ce54aea8d80481ac2b5b3acb::endpoint_ptb_builder::message_lib_quote_call_id()));
        0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::add(&mut v0, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::create(0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::package::package_of_type<0x83651370065f70112b20007137c7235a2a243055d9f59cb5e162c00c4a1680a7::simple_message_lib::SimpleMessageLib>(), 0x1::ascii::string(b"simple_message_lib"), 0x1::ascii::string(b"quote"), v1, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32>()));
        0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::build(v0)
    }

    public fun build_send_ptb(arg0: &0x83651370065f70112b20007137c7235a2a243055d9f59cb5e162c00c4a1680a7::simple_message_lib::SimpleMessageLib, arg1: &0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::EndpointV2, arg2: &0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_receipt::MessagingReceipt>) : vector<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::MoveCall> {
        let v0 = 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::new();
        let v1 = 0x1::vector::empty<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>();
        let v2 = &mut v1;
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v2, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_object(0x2::object::id_address<0x83651370065f70112b20007137c7235a2a243055d9f59cb5e162c00c4a1680a7::simple_message_lib::SimpleMessageLib>(arg0)));
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v2, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_object(0x2::object::id_address<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::EndpointV2>(arg1)));
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v2, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_object(0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::get_messaging_channel(arg1, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::caller<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_receipt::MessagingReceipt>(arg2))));
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v2, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_id(0x387af0542c79874a52c3e8812390c0fd02a8e947ce54aea8d80481ac2b5b3acb::endpoint_ptb_builder::endpoint_send_call_id()));
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v2, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_id(0x387af0542c79874a52c3e8812390c0fd02a8e947ce54aea8d80481ac2b5b3acb::endpoint_ptb_builder::message_lib_send_call_id()));
        0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::add(&mut v0, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::create(0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::package::package_of_type<0x83651370065f70112b20007137c7235a2a243055d9f59cb5e162c00c4a1680a7::simple_message_lib::SimpleMessageLib>(), 0x1::ascii::string(b"simple_message_lib"), 0x1::ascii::string(b"send"), v1, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32>()));
        0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::build(v0)
    }

    public fun build_set_config_ptb(arg0: &0x83651370065f70112b20007137c7235a2a243055d9f59cb5e162c00c4a1680a7::simple_message_lib::SimpleMessageLib) : vector<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::MoveCall> {
        let v0 = 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::new();
        let v1 = 0x1::vector::empty<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>();
        let v2 = &mut v1;
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v2, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_object(0x2::object::id_address<0x83651370065f70112b20007137c7235a2a243055d9f59cb5e162c00c4a1680a7::simple_message_lib::SimpleMessageLib>(arg0)));
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v2, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_id(0x387af0542c79874a52c3e8812390c0fd02a8e947ce54aea8d80481ac2b5b3acb::endpoint_ptb_builder::message_lib_set_config_call_id()));
        0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::add(&mut v0, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::create(0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::package::package_of_type<0x83651370065f70112b20007137c7235a2a243055d9f59cb5e162c00c4a1680a7::simple_message_lib::SimpleMessageLib>(), 0x1::ascii::string(b"simple_message_lib"), 0x1::ascii::string(b"set_config"), v1, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32>()));
        0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::build(v0)
    }

    public fun get_ptb_builder_info(arg0: &SimpleMsglibPtbBuilder, arg1: &0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::EndpointV2, arg2: &0x83651370065f70112b20007137c7235a2a243055d9f59cb5e162c00c4a1680a7::simple_message_lib::SimpleMessageLib) : 0x387af0542c79874a52c3e8812390c0fd02a8e947ce54aea8d80481ac2b5b3acb::msglib_ptb_builder_info::MsglibPtbBuilderInfo {
        let v0 = 0x1::vector::empty<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>();
        let v1 = &mut v0;
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v1, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_object(0x2::object::id_address<0x83651370065f70112b20007137c7235a2a243055d9f59cb5e162c00c4a1680a7::simple_message_lib::SimpleMessageLib>(arg2)));
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v1, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_object(0x2::object::id_address<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::EndpointV2>(arg1)));
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v1, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_id(0x387af0542c79874a52c3e8812390c0fd02a8e947ce54aea8d80481ac2b5b3acb::endpoint_ptb_builder::endpoint_send_call_id()));
        let v2 = 0x1::vector::empty<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::MoveCall>();
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::MoveCall>(&mut v2, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::create(0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::id(&arg0.call_cap), 0x1::ascii::string(b"simple_msglib_ptb_builder"), 0x1::ascii::string(b"build_send_ptb"), v0, 0x1::vector::empty<0x1::type_name::TypeName>(), true, 0x1::vector::empty<0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32>()));
        0x387af0542c79874a52c3e8812390c0fd02a8e947ce54aea8d80481ac2b5b3acb::msglib_ptb_builder_info::create(0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::package::original_package_of_type<0x83651370065f70112b20007137c7235a2a243055d9f59cb5e162c00c4a1680a7::simple_message_lib::SimpleMessageLib>(), 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::id(&arg0.call_cap), build_quote_ptb(arg2), v2, build_set_config_ptb(arg2))
    }

    fun init(arg0: SIMPLE_MSGLIB_PTB_BUILDER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SimpleMsglibPtbBuilder{
            id       : 0x2::object::new(arg1),
            call_cap : 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::new_package_cap<SIMPLE_MSGLIB_PTB_BUILDER>(&arg0, arg1),
        };
        0x2::transfer::share_object<SimpleMsglibPtbBuilder>(v0);
    }

    // decompiled from Move bytecode v6
}

