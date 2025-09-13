module 0xf432552fe032201f9614efc6a992f2e225891af5233ceb9d4399f8142ab0bd41::simple_msglib_ptb_builder {
    struct SIMPLE_MSGLIB_PTB_BUILDER has drop {
        dummy_field: bool,
    }

    struct SimpleMsglibPtbBuilder has key {
        id: 0x2::object::UID,
        call_cap: 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::CallCap,
    }

    public fun build_quote_ptb(arg0: &0xe7abf8f9a807d14c91f04dcb4ee3dd3c40559fbd7e54ae3408349ea9a36394e4::simple_message_lib::SimpleMessageLib) : vector<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall> {
        let v0 = 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::new();
        let v1 = 0x1::vector::empty<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v2, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_object(0x2::object::id_address<0xe7abf8f9a807d14c91f04dcb4ee3dd3c40559fbd7e54ae3408349ea9a36394e4::simple_message_lib::SimpleMessageLib>(arg0)));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v2, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_id(0x674fa05c5ce6b616dff646b680f14afe207eafe432b68c4ea59ec417b8c49ba4::endpoint_ptb_builder::message_lib_quote_call_id()));
        0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::add(&mut v0, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::create(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::package::package_of_type<0xe7abf8f9a807d14c91f04dcb4ee3dd3c40559fbd7e54ae3408349ea9a36394e4::simple_message_lib::SimpleMessageLib>(), 0x1::ascii::string(b"simple_message_lib"), 0x1::ascii::string(b"quote"), v1, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32>()));
        0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::build(v0)
    }

    public fun build_send_ptb(arg0: &0xe7abf8f9a807d14c91f04dcb4ee3dd3c40559fbd7e54ae3408349ea9a36394e4::simple_message_lib::SimpleMessageLib, arg1: &0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::EndpointV2, arg2: &0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_send::SendParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_receipt::MessagingReceipt>) : vector<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall> {
        let v0 = 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::new();
        let v1 = 0x1::vector::empty<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v2, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_object(0x2::object::id_address<0xe7abf8f9a807d14c91f04dcb4ee3dd3c40559fbd7e54ae3408349ea9a36394e4::simple_message_lib::SimpleMessageLib>(arg0)));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v2, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_object(0x2::object::id_address<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::EndpointV2>(arg1)));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v2, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_object(0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::get_messaging_channel(arg1, 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::caller<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_send::SendParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_receipt::MessagingReceipt>(arg2))));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v2, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_id(0x674fa05c5ce6b616dff646b680f14afe207eafe432b68c4ea59ec417b8c49ba4::endpoint_ptb_builder::endpoint_send_call_id()));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v2, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_id(0x674fa05c5ce6b616dff646b680f14afe207eafe432b68c4ea59ec417b8c49ba4::endpoint_ptb_builder::message_lib_send_call_id()));
        0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::add(&mut v0, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::create(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::package::package_of_type<0xe7abf8f9a807d14c91f04dcb4ee3dd3c40559fbd7e54ae3408349ea9a36394e4::simple_message_lib::SimpleMessageLib>(), 0x1::ascii::string(b"simple_message_lib"), 0x1::ascii::string(b"send"), v1, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32>()));
        0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::build(v0)
    }

    public fun build_set_config_ptb(arg0: &0xe7abf8f9a807d14c91f04dcb4ee3dd3c40559fbd7e54ae3408349ea9a36394e4::simple_message_lib::SimpleMessageLib) : vector<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall> {
        let v0 = 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::new();
        let v1 = 0x1::vector::empty<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v2, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_object(0x2::object::id_address<0xe7abf8f9a807d14c91f04dcb4ee3dd3c40559fbd7e54ae3408349ea9a36394e4::simple_message_lib::SimpleMessageLib>(arg0)));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v2, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_id(0x674fa05c5ce6b616dff646b680f14afe207eafe432b68c4ea59ec417b8c49ba4::endpoint_ptb_builder::message_lib_set_config_call_id()));
        0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::add(&mut v0, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::create(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::package::package_of_type<0xe7abf8f9a807d14c91f04dcb4ee3dd3c40559fbd7e54ae3408349ea9a36394e4::simple_message_lib::SimpleMessageLib>(), 0x1::ascii::string(b"simple_message_lib"), 0x1::ascii::string(b"set_config"), v1, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32>()));
        0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::build(v0)
    }

    public fun get_ptb_builder_info(arg0: &SimpleMsglibPtbBuilder, arg1: &0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::EndpointV2, arg2: &0xe7abf8f9a807d14c91f04dcb4ee3dd3c40559fbd7e54ae3408349ea9a36394e4::simple_message_lib::SimpleMessageLib) : 0x674fa05c5ce6b616dff646b680f14afe207eafe432b68c4ea59ec417b8c49ba4::msglib_ptb_builder_info::MsglibPtbBuilderInfo {
        let v0 = 0x1::vector::empty<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v1, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_object(0x2::object::id_address<0xe7abf8f9a807d14c91f04dcb4ee3dd3c40559fbd7e54ae3408349ea9a36394e4::simple_message_lib::SimpleMessageLib>(arg2)));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v1, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_object(0x2::object::id_address<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::EndpointV2>(arg1)));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v1, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_id(0x674fa05c5ce6b616dff646b680f14afe207eafe432b68c4ea59ec417b8c49ba4::endpoint_ptb_builder::endpoint_send_call_id()));
        let v2 = 0x1::vector::empty<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall>();
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall>(&mut v2, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::create(0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::id(&arg0.call_cap), 0x1::ascii::string(b"simple_msglib_ptb_builder"), 0x1::ascii::string(b"build_send_ptb"), v0, 0x1::vector::empty<0x1::type_name::TypeName>(), true, 0x1::vector::empty<0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32>()));
        0x674fa05c5ce6b616dff646b680f14afe207eafe432b68c4ea59ec417b8c49ba4::msglib_ptb_builder_info::create(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::package::original_package_of_type<0xe7abf8f9a807d14c91f04dcb4ee3dd3c40559fbd7e54ae3408349ea9a36394e4::simple_message_lib::SimpleMessageLib>(), 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::id(&arg0.call_cap), build_quote_ptb(arg2), v2, build_set_config_ptb(arg2))
    }

    fun init(arg0: SIMPLE_MSGLIB_PTB_BUILDER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SimpleMsglibPtbBuilder{
            id       : 0x2::object::new(arg1),
            call_cap : 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::new_package_cap<SIMPLE_MSGLIB_PTB_BUILDER>(&arg0, arg1),
        };
        0x2::transfer::share_object<SimpleMsglibPtbBuilder>(v0);
    }

    // decompiled from Move bytecode v6
}

