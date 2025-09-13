module 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_send {
    struct SendParam {
        dst_eid: u32,
        receiver: 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32,
        message: vector<u8>,
        options: vector<u8>,
        native_token: 0x2::coin::Coin<0x2::sui::SUI>,
        zro_token: 0x1::option::Option<0x2::coin::Coin<0x30675609f2d9bf3fbd6ae9f3720a9769146a1d1421dfe92506fa63f2670c1627::zro::ZRO>>,
        refund_address: 0x1::option::Option<address>,
    }

    public fun create_param(arg0: u32, arg1: 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32, arg2: vector<u8>, arg3: vector<u8>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: 0x1::option::Option<0x2::coin::Coin<0x30675609f2d9bf3fbd6ae9f3720a9769146a1d1421dfe92506fa63f2670c1627::zro::ZRO>>, arg6: 0x1::option::Option<address>) : SendParam {
        SendParam{
            dst_eid        : arg0,
            receiver       : arg1,
            message        : arg2,
            options        : arg3,
            native_token   : arg4,
            zro_token      : arg5,
            refund_address : arg6,
        }
    }

    public fun destroy(arg0: SendParam) : (0x2::coin::Coin<0x2::sui::SUI>, 0x1::option::Option<0x2::coin::Coin<0x30675609f2d9bf3fbd6ae9f3720a9769146a1d1421dfe92506fa63f2670c1627::zro::ZRO>>) {
        let SendParam {
            dst_eid        : _,
            receiver       : _,
            message        : _,
            options        : _,
            native_token   : v4,
            zro_token      : v5,
            refund_address : _,
        } = arg0;
        (v4, v5)
    }

    public fun dst_eid(arg0: &SendParam) : u32 {
        arg0.dst_eid
    }

    public fun message(arg0: &SendParam) : &vector<u8> {
        &arg0.message
    }

    public fun native_token(arg0: &SendParam) : &0x2::coin::Coin<0x2::sui::SUI> {
        &arg0.native_token
    }

    public fun native_token_mut(arg0: &mut SendParam) : &mut 0x2::coin::Coin<0x2::sui::SUI> {
        &mut arg0.native_token
    }

    public fun options(arg0: &SendParam) : &vector<u8> {
        &arg0.options
    }

    public fun pay_in_zro(arg0: &SendParam) : bool {
        0x1::option::is_some<0x2::coin::Coin<0x30675609f2d9bf3fbd6ae9f3720a9769146a1d1421dfe92506fa63f2670c1627::zro::ZRO>>(&arg0.zro_token)
    }

    public fun receiver(arg0: &SendParam) : 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32 {
        arg0.receiver
    }

    public fun refund_address(arg0: &SendParam) : 0x1::option::Option<address> {
        arg0.refund_address
    }

    public fun zro_token(arg0: &SendParam) : &0x1::option::Option<0x2::coin::Coin<0x30675609f2d9bf3fbd6ae9f3720a9769146a1d1421dfe92506fa63f2670c1627::zro::ZRO>> {
        &arg0.zro_token
    }

    public fun zro_token_mut(arg0: &mut SendParam) : &mut 0x1::option::Option<0x2::coin::Coin<0x30675609f2d9bf3fbd6ae9f3720a9769146a1d1421dfe92506fa63f2670c1627::zro::ZRO>> {
        &mut arg0.zro_token
    }

    // decompiled from Move bytecode v6
}

