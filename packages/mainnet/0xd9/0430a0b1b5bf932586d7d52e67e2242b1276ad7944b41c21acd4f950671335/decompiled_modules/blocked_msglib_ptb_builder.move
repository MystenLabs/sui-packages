module 0xd90430a0b1b5bf932586d7d52e67e2242b1276ad7944b41c21acd4f950671335::blocked_msglib_ptb_builder {
    struct BLOCKED_MSGLIB_PTB_BUILDER has drop {
        dummy_field: bool,
    }

    struct BlockedMsglibPtbBuilder has key {
        id: 0x2::object::UID,
        call_cap: 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::CallCap,
    }

    public fun build_quote_ptb(arg0: &0x9f6107b708d7650b1484ae10cb98340af343f46bd63793ea91c2379bab9a7abb::blocked_message_lib::BlockedMessageLib) : vector<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::MoveCall> {
        let v0 = 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::new();
        let v1 = 0x1::vector::empty<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>();
        let v2 = &mut v1;
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v2, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_object(0x2::object::id_address<0x9f6107b708d7650b1484ae10cb98340af343f46bd63793ea91c2379bab9a7abb::blocked_message_lib::BlockedMessageLib>(arg0)));
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v2, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_id(0x387af0542c79874a52c3e8812390c0fd02a8e947ce54aea8d80481ac2b5b3acb::endpoint_ptb_builder::message_lib_quote_call_id()));
        0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::add(&mut v0, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::create(0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::package::original_package_of_type<0x9f6107b708d7650b1484ae10cb98340af343f46bd63793ea91c2379bab9a7abb::blocked_message_lib::BlockedMessageLib>(), 0x1::ascii::string(b"blocked_message_lib"), 0x1::ascii::string(b"quote"), v1, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32>()));
        0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::build(v0)
    }

    public fun build_send_ptb(arg0: &0x9f6107b708d7650b1484ae10cb98340af343f46bd63793ea91c2379bab9a7abb::blocked_message_lib::BlockedMessageLib) : vector<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::MoveCall> {
        let v0 = 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::new();
        let v1 = 0x1::vector::empty<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>();
        let v2 = &mut v1;
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v2, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_object(0x2::object::id_address<0x9f6107b708d7650b1484ae10cb98340af343f46bd63793ea91c2379bab9a7abb::blocked_message_lib::BlockedMessageLib>(arg0)));
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v2, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_id(0x387af0542c79874a52c3e8812390c0fd02a8e947ce54aea8d80481ac2b5b3acb::endpoint_ptb_builder::message_lib_send_call_id()));
        0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::add(&mut v0, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::create(0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::package::original_package_of_type<0x9f6107b708d7650b1484ae10cb98340af343f46bd63793ea91c2379bab9a7abb::blocked_message_lib::BlockedMessageLib>(), 0x1::ascii::string(b"blocked_message_lib"), 0x1::ascii::string(b"send"), v1, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32>()));
        0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::build(v0)
    }

    public fun build_set_config_ptb(arg0: &0x9f6107b708d7650b1484ae10cb98340af343f46bd63793ea91c2379bab9a7abb::blocked_message_lib::BlockedMessageLib) : vector<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::MoveCall> {
        let v0 = 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::new();
        let v1 = 0x1::vector::empty<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>();
        let v2 = &mut v1;
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v2, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_object(0x2::object::id_address<0x9f6107b708d7650b1484ae10cb98340af343f46bd63793ea91c2379bab9a7abb::blocked_message_lib::BlockedMessageLib>(arg0)));
        0x1::vector::push_back<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::Argument>(v2, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::argument::create_id(0x387af0542c79874a52c3e8812390c0fd02a8e947ce54aea8d80481ac2b5b3acb::endpoint_ptb_builder::message_lib_set_config_call_id()));
        0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::add(&mut v0, 0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::create(0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::package::original_package_of_type<0x9f6107b708d7650b1484ae10cb98340af343f46bd63793ea91c2379bab9a7abb::blocked_message_lib::BlockedMessageLib>(), 0x1::ascii::string(b"blocked_message_lib"), 0x1::ascii::string(b"set_config"), v1, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32>()));
        0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_calls_builder::build(v0)
    }

    public fun get_ptb_builder_info(arg0: &BlockedMsglibPtbBuilder, arg1: &0x9f6107b708d7650b1484ae10cb98340af343f46bd63793ea91c2379bab9a7abb::blocked_message_lib::BlockedMessageLib) : 0x387af0542c79874a52c3e8812390c0fd02a8e947ce54aea8d80481ac2b5b3acb::msglib_ptb_builder_info::MsglibPtbBuilderInfo {
        0x387af0542c79874a52c3e8812390c0fd02a8e947ce54aea8d80481ac2b5b3acb::msglib_ptb_builder_info::create(0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::package::original_package_of_type<0x9f6107b708d7650b1484ae10cb98340af343f46bd63793ea91c2379bab9a7abb::blocked_message_lib::BlockedMessageLib>(), 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::id(&arg0.call_cap), build_quote_ptb(arg1), build_send_ptb(arg1), build_set_config_ptb(arg1))
    }

    fun init(arg0: BLOCKED_MSGLIB_PTB_BUILDER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BlockedMsglibPtbBuilder{
            id       : 0x2::object::new(arg1),
            call_cap : 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::new_package_cap<BLOCKED_MSGLIB_PTB_BUILDER>(&arg0, arg1),
        };
        0x2::transfer::share_object<BlockedMsglibPtbBuilder>(v0);
    }

    // decompiled from Move bytecode v6
}

