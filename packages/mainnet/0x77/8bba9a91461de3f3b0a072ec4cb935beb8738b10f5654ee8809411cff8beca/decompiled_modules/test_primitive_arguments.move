module 0x778bba9a91461de3f3b0a072ec4cb935beb8738b10f5654ee8809411cff8beca::test_primitive_arguments {
    struct ScallopToolsEvent has copy, drop {
        bool_value: bool,
        u8_value: u8,
        u16_value: u16,
        u32_value: u32,
        u64_value: u64,
        u128_value: u128,
        address_value: address,
        string: 0x1::string::String,
        vector_bool: vector<bool>,
        vector_u8: vector<u8>,
        vector_u16: vector<u16>,
        vector_u32: vector<u32>,
        vector_u64: vector<u64>,
        vector_u128: vector<u128>,
        vector_string: vector<0x1::string::String>,
        vector_address: vector<address>,
        sender: address,
    }

    struct ScallopToolsGenericEvent<T0> has copy, drop {
        value: T0,
        sender: address,
    }

    public fun test_generic_primitive<T0: copy + drop>(arg0: T0, arg1: &0x2::tx_context::TxContext) {
        let v0 = ScallopToolsGenericEvent<T0>{
            value  : arg0,
            sender : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<ScallopToolsGenericEvent<T0>>(v0);
    }

    public fun test_primitive_args(arg0: bool, arg1: u8, arg2: u16, arg3: u32, arg4: u64, arg5: u128, arg6: address, arg7: 0x1::string::String, arg8: vector<bool>, arg9: vector<u8>, arg10: vector<u16>, arg11: vector<u32>, arg12: vector<u64>, arg13: vector<u128>, arg14: vector<0x1::string::String>, arg15: vector<address>, arg16: &0x2::tx_context::TxContext) {
        let v0 = ScallopToolsEvent{
            bool_value     : arg0,
            u8_value       : arg1,
            u16_value      : arg2,
            u32_value      : arg3,
            u64_value      : arg4,
            u128_value     : arg5,
            address_value  : arg6,
            string         : arg7,
            vector_bool    : arg8,
            vector_u8      : arg9,
            vector_u16     : arg10,
            vector_u32     : arg11,
            vector_u64     : arg12,
            vector_u128    : arg13,
            vector_string  : arg14,
            vector_address : arg15,
            sender         : 0x2::tx_context::sender(arg16),
        };
        0x2::event::emit<ScallopToolsEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

