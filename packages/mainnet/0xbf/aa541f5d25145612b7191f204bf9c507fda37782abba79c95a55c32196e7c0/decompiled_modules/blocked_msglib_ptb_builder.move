module 0xbfaa541f5d25145612b7191f204bf9c507fda37782abba79c95a55c32196e7c0::blocked_msglib_ptb_builder {
    struct BLOCKED_MSGLIB_PTB_BUILDER has drop {
        dummy_field: bool,
    }

    struct BlockedMsglibPtbBuilder has key {
        id: 0x2::object::UID,
        call_cap: 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::CallCap,
    }

    public fun build_quote_ptb(arg0: &0xcc7b3b92261f2bf5484c534e52df550903afa98984641096d507a58013848665::blocked_message_lib::BlockedMessageLib) : vector<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall> {
        let v0 = 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::new();
        let v1 = 0x1::vector::empty<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v2, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_object(0x2::object::id_address<0xcc7b3b92261f2bf5484c534e52df550903afa98984641096d507a58013848665::blocked_message_lib::BlockedMessageLib>(arg0)));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v2, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_id(0x674fa05c5ce6b616dff646b680f14afe207eafe432b68c4ea59ec417b8c49ba4::endpoint_ptb_builder::message_lib_quote_call_id()));
        0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::add(&mut v0, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::create(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::package::original_package_of_type<0xcc7b3b92261f2bf5484c534e52df550903afa98984641096d507a58013848665::blocked_message_lib::BlockedMessageLib>(), 0x1::ascii::string(b"blocked_message_lib"), 0x1::ascii::string(b"quote"), v1, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32>()));
        0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::build(v0)
    }

    public fun build_send_ptb(arg0: &0xcc7b3b92261f2bf5484c534e52df550903afa98984641096d507a58013848665::blocked_message_lib::BlockedMessageLib) : vector<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall> {
        let v0 = 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::new();
        let v1 = 0x1::vector::empty<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v2, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_object(0x2::object::id_address<0xcc7b3b92261f2bf5484c534e52df550903afa98984641096d507a58013848665::blocked_message_lib::BlockedMessageLib>(arg0)));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v2, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_id(0x674fa05c5ce6b616dff646b680f14afe207eafe432b68c4ea59ec417b8c49ba4::endpoint_ptb_builder::message_lib_send_call_id()));
        0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::add(&mut v0, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::create(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::package::original_package_of_type<0xcc7b3b92261f2bf5484c534e52df550903afa98984641096d507a58013848665::blocked_message_lib::BlockedMessageLib>(), 0x1::ascii::string(b"blocked_message_lib"), 0x1::ascii::string(b"send"), v1, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32>()));
        0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::build(v0)
    }

    public fun build_set_config_ptb(arg0: &0xcc7b3b92261f2bf5484c534e52df550903afa98984641096d507a58013848665::blocked_message_lib::BlockedMessageLib) : vector<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall> {
        let v0 = 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::new();
        let v1 = 0x1::vector::empty<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v2, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_object(0x2::object::id_address<0xcc7b3b92261f2bf5484c534e52df550903afa98984641096d507a58013848665::blocked_message_lib::BlockedMessageLib>(arg0)));
        0x1::vector::push_back<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::Argument>(v2, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::argument::create_id(0x674fa05c5ce6b616dff646b680f14afe207eafe432b68c4ea59ec417b8c49ba4::endpoint_ptb_builder::message_lib_set_config_call_id()));
        0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::add(&mut v0, 0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::create(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::package::original_package_of_type<0xcc7b3b92261f2bf5484c534e52df550903afa98984641096d507a58013848665::blocked_message_lib::BlockedMessageLib>(), 0x1::ascii::string(b"blocked_message_lib"), 0x1::ascii::string(b"set_config"), v1, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32>()));
        0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_calls_builder::build(v0)
    }

    public fun get_ptb_builder_info(arg0: &BlockedMsglibPtbBuilder, arg1: &0xcc7b3b92261f2bf5484c534e52df550903afa98984641096d507a58013848665::blocked_message_lib::BlockedMessageLib) : 0x674fa05c5ce6b616dff646b680f14afe207eafe432b68c4ea59ec417b8c49ba4::msglib_ptb_builder_info::MsglibPtbBuilderInfo {
        0x674fa05c5ce6b616dff646b680f14afe207eafe432b68c4ea59ec417b8c49ba4::msglib_ptb_builder_info::create(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::package::original_package_of_type<0xcc7b3b92261f2bf5484c534e52df550903afa98984641096d507a58013848665::blocked_message_lib::BlockedMessageLib>(), 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::id(&arg0.call_cap), build_quote_ptb(arg1), build_send_ptb(arg1), build_set_config_ptb(arg1))
    }

    fun init(arg0: BLOCKED_MSGLIB_PTB_BUILDER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BlockedMsglibPtbBuilder{
            id       : 0x2::object::new(arg1),
            call_cap : 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::new_package_cap<BLOCKED_MSGLIB_PTB_BUILDER>(&arg0, arg1),
        };
        0x2::transfer::share_object<BlockedMsglibPtbBuilder>(v0);
    }

    // decompiled from Move bytecode v6
}

