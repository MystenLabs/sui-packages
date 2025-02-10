module 0x552179e58ae1fc8a9b6be8360bda97e1c4d6f07621d36c8bbe6ad5c179663dd8::test_primitive_arguments {
    struct ScallopToolsEvent has copy, drop {
        u8_value: u8,
        u16_value: u16,
        u32_value: u32,
        u64_value: u64,
        u128_value: u128,
        address_value: address,
        string: 0x1::string::String,
        vector_u8: vector<u8>,
        vector_u16: vector<u16>,
        vector_u32: vector<u32>,
        vector_u64: vector<u64>,
        vector_u128: vector<u128>,
        vector_string: vector<0x1::string::String>,
        vector_address: vector<address>,
        sender: address,
    }

    public fun test_primitive_args(arg0: u8, arg1: u16, arg2: u32, arg3: u64, arg4: u128, arg5: address, arg6: 0x1::string::String, arg7: vector<u8>, arg8: vector<u16>, arg9: vector<u32>, arg10: vector<u64>, arg11: vector<u128>, arg12: vector<0x1::string::String>, arg13: vector<address>, arg14: &0x2::tx_context::TxContext) {
        let v0 = ScallopToolsEvent{
            u8_value       : arg0,
            u16_value      : arg1,
            u32_value      : arg2,
            u64_value      : arg3,
            u128_value     : arg4,
            address_value  : arg5,
            string         : arg6,
            vector_u8      : arg7,
            vector_u16     : arg8,
            vector_u32     : arg9,
            vector_u64     : arg10,
            vector_u128    : arg11,
            vector_string  : arg12,
            vector_address : arg13,
            sender         : 0x2::tx_context::sender(arg14),
        };
        0x2::event::emit<ScallopToolsEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

