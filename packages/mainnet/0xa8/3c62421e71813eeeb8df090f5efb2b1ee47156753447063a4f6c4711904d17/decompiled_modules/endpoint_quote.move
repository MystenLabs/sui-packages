module 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_quote {
    struct QuoteParam has copy, drop, store {
        dst_eid: u32,
        receiver: 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32,
        message: vector<u8>,
        options: vector<u8>,
        pay_in_zro: bool,
    }

    public fun create_param(arg0: u32, arg1: 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32, arg2: vector<u8>, arg3: vector<u8>, arg4: bool) : QuoteParam {
        QuoteParam{
            dst_eid    : arg0,
            receiver   : arg1,
            message    : arg2,
            options    : arg3,
            pay_in_zro : arg4,
        }
    }

    public fun dst_eid(arg0: &QuoteParam) : u32 {
        arg0.dst_eid
    }

    public fun message(arg0: &QuoteParam) : &vector<u8> {
        &arg0.message
    }

    public fun options(arg0: &QuoteParam) : &vector<u8> {
        &arg0.options
    }

    public fun pay_in_zro(arg0: &QuoteParam) : bool {
        arg0.pay_in_zro
    }

    public fun receiver(arg0: &QuoteParam) : 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32 {
        arg0.receiver
    }

    // decompiled from Move bytecode v6
}

