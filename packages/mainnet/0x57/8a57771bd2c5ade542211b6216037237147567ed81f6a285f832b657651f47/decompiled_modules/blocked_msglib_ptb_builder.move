module 0x578a57771bd2c5ade542211b6216037237147567ed81f6a285f832b657651f47::blocked_msglib_ptb_builder {
    struct BLOCKED_MSGLIB_PTB_BUILDER has drop {
        dummy_field: bool,
    }

    struct BlockedMsglibPtbBuilder has key {
        id: 0x2::object::UID,
        call_cap: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap,
    }

    public fun build_quote_ptb(arg0: &0x54bb7dd5dc12abfaf82616f245e9d4f0e3f737b48699371d17556eaaf874eda1::blocked_message_lib::BlockedMessageLib) : vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall> {
        let v0 = 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::new();
        let v1 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>();
        let v2 = &mut v1;
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v2, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0x54bb7dd5dc12abfaf82616f245e9d4f0e3f737b48699371d17556eaaf874eda1::blocked_message_lib::BlockedMessageLib>(arg0)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v2, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_id(0x28417daea895a3dc2e70b5765ec67b99973e612107d56382e399cc75e666f2ba::endpoint_ptb_builder::message_lib_quote_call_id()));
        0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::add(&mut v0, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::create(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::package::original_package_of_type<0x54bb7dd5dc12abfaf82616f245e9d4f0e3f737b48699371d17556eaaf874eda1::blocked_message_lib::BlockedMessageLib>(), 0x1::ascii::string(b"blocked_message_lib"), 0x1::ascii::string(b"quote"), v1, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>()));
        0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::build(v0)
    }

    public fun build_send_ptb(arg0: &0x54bb7dd5dc12abfaf82616f245e9d4f0e3f737b48699371d17556eaaf874eda1::blocked_message_lib::BlockedMessageLib) : vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall> {
        let v0 = 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::new();
        let v1 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>();
        let v2 = &mut v1;
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v2, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0x54bb7dd5dc12abfaf82616f245e9d4f0e3f737b48699371d17556eaaf874eda1::blocked_message_lib::BlockedMessageLib>(arg0)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v2, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_id(0x28417daea895a3dc2e70b5765ec67b99973e612107d56382e399cc75e666f2ba::endpoint_ptb_builder::message_lib_send_call_id()));
        0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::add(&mut v0, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::create(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::package::original_package_of_type<0x54bb7dd5dc12abfaf82616f245e9d4f0e3f737b48699371d17556eaaf874eda1::blocked_message_lib::BlockedMessageLib>(), 0x1::ascii::string(b"blocked_message_lib"), 0x1::ascii::string(b"send"), v1, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>()));
        0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::build(v0)
    }

    public fun build_set_config_ptb(arg0: &0x54bb7dd5dc12abfaf82616f245e9d4f0e3f737b48699371d17556eaaf874eda1::blocked_message_lib::BlockedMessageLib) : vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall> {
        let v0 = 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::new();
        let v1 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>();
        let v2 = &mut v1;
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v2, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0x54bb7dd5dc12abfaf82616f245e9d4f0e3f737b48699371d17556eaaf874eda1::blocked_message_lib::BlockedMessageLib>(arg0)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v2, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_id(0x28417daea895a3dc2e70b5765ec67b99973e612107d56382e399cc75e666f2ba::endpoint_ptb_builder::message_lib_set_config_call_id()));
        0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::add(&mut v0, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::create(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::package::original_package_of_type<0x54bb7dd5dc12abfaf82616f245e9d4f0e3f737b48699371d17556eaaf874eda1::blocked_message_lib::BlockedMessageLib>(), 0x1::ascii::string(b"blocked_message_lib"), 0x1::ascii::string(b"set_config"), v1, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>()));
        0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::build(v0)
    }

    public fun get_ptb_builder_info(arg0: &BlockedMsglibPtbBuilder, arg1: &0x54bb7dd5dc12abfaf82616f245e9d4f0e3f737b48699371d17556eaaf874eda1::blocked_message_lib::BlockedMessageLib) : 0x28417daea895a3dc2e70b5765ec67b99973e612107d56382e399cc75e666f2ba::msglib_ptb_builder_info::MsglibPtbBuilderInfo {
        0x28417daea895a3dc2e70b5765ec67b99973e612107d56382e399cc75e666f2ba::msglib_ptb_builder_info::create(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::package::original_package_of_type<0x54bb7dd5dc12abfaf82616f245e9d4f0e3f737b48699371d17556eaaf874eda1::blocked_message_lib::BlockedMessageLib>(), 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::id(&arg0.call_cap), build_quote_ptb(arg1), build_send_ptb(arg1), build_set_config_ptb(arg1))
    }

    fun init(arg0: BLOCKED_MSGLIB_PTB_BUILDER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BlockedMsglibPtbBuilder{
            id       : 0x2::object::new(arg1),
            call_cap : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::new_package_cap<BLOCKED_MSGLIB_PTB_BUILDER>(&arg0, arg1),
        };
        0x2::transfer::share_object<BlockedMsglibPtbBuilder>(v0);
    }

    // decompiled from Move bytecode v6
}

