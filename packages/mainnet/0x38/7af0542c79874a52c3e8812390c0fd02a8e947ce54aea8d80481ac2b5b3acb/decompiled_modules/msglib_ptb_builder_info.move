module 0x387af0542c79874a52c3e8812390c0fd02a8e947ce54aea8d80481ac2b5b3acb::msglib_ptb_builder_info {
    struct MsglibPtbBuilderInfo has copy, drop, store {
        message_lib: address,
        ptb_builder: address,
        quote_ptb: vector<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::MoveCall>,
        send_ptb: vector<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::MoveCall>,
        set_config_ptb: vector<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::MoveCall>,
    }

    public fun create(arg0: address, arg1: address, arg2: vector<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::MoveCall>, arg3: vector<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::MoveCall>, arg4: vector<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::MoveCall>) : MsglibPtbBuilderInfo {
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

    public fun quote_ptb(arg0: &MsglibPtbBuilderInfo) : &vector<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::MoveCall> {
        &arg0.quote_ptb
    }

    public fun send_ptb(arg0: &MsglibPtbBuilderInfo) : &vector<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::MoveCall> {
        &arg0.send_ptb
    }

    public fun set_config_ptb(arg0: &MsglibPtbBuilderInfo) : &vector<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::MoveCall> {
        &arg0.set_config_ptb
    }

    // decompiled from Move bytecode v6
}

