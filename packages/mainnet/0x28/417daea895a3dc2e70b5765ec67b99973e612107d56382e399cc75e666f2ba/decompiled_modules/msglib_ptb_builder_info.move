module 0x28417daea895a3dc2e70b5765ec67b99973e612107d56382e399cc75e666f2ba::msglib_ptb_builder_info {
    struct MsglibPtbBuilderInfo has copy, drop, store {
        message_lib: address,
        ptb_builder: address,
        quote_ptb: vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>,
        send_ptb: vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>,
        set_config_ptb: vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>,
    }

    public fun create(arg0: address, arg1: address, arg2: vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>, arg3: vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>, arg4: vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>) : MsglibPtbBuilderInfo {
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

    public fun quote_ptb(arg0: &MsglibPtbBuilderInfo) : &vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall> {
        &arg0.quote_ptb
    }

    public fun send_ptb(arg0: &MsglibPtbBuilderInfo) : &vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall> {
        &arg0.send_ptb
    }

    public fun set_config_ptb(arg0: &MsglibPtbBuilderInfo) : &vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall> {
        &arg0.set_config_ptb
    }

    // decompiled from Move bytecode v6
}

