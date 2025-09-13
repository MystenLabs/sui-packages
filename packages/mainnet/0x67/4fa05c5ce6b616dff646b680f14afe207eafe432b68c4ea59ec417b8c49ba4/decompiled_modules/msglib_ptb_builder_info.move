module 0x674fa05c5ce6b616dff646b680f14afe207eafe432b68c4ea59ec417b8c49ba4::msglib_ptb_builder_info {
    struct MsglibPtbBuilderInfo has copy, drop, store {
        message_lib: address,
        ptb_builder: address,
        quote_ptb: vector<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall>,
        send_ptb: vector<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall>,
        set_config_ptb: vector<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall>,
    }

    public fun create(arg0: address, arg1: address, arg2: vector<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall>, arg3: vector<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall>, arg4: vector<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall>) : MsglibPtbBuilderInfo {
        MsglibPtbBuilderInfo{
            message_lib    : arg0,
            ptb_builder    : arg1,
            quote_ptb      : arg2,
            send_ptb       : arg3,
            set_config_ptb : arg4,
        }
    }

    public fun message_lib(arg0: &MsglibPtbBuilderInfo) : address {
        arg0.message_lib
    }

    public fun ptb_builder(arg0: &MsglibPtbBuilderInfo) : address {
        arg0.ptb_builder
    }

    public fun quote_ptb(arg0: &MsglibPtbBuilderInfo) : &vector<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall> {
        &arg0.quote_ptb
    }

    public fun send_ptb(arg0: &MsglibPtbBuilderInfo) : &vector<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall> {
        &arg0.send_ptb
    }

    public fun set_config_ptb(arg0: &MsglibPtbBuilderInfo) : &vector<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall> {
        &arg0.set_config_ptb
    }

    // decompiled from Move bytecode v6
}

