module 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_set_config {
    struct SetConfigParam has copy, drop, store {
        oapp: address,
        eid: u32,
        config_type: u32,
        config: vector<u8>,
    }

    public fun config(arg0: &SetConfigParam) : &vector<u8> {
        &arg0.config
    }

    public fun config_type(arg0: &SetConfigParam) : u32 {
        arg0.config_type
    }

    public(friend) fun create_param(arg0: address, arg1: u32, arg2: u32, arg3: vector<u8>) : SetConfigParam {
        SetConfigParam{
            oapp        : arg0,
            eid         : arg1,
            config_type : arg2,
            config      : arg3,
        }
    }

    public fun eid(arg0: &SetConfigParam) : u32 {
        arg0.eid
    }

    public fun oapp(arg0: &SetConfigParam) : address {
        arg0.oapp
    }

    // decompiled from Move bytecode v6
}

