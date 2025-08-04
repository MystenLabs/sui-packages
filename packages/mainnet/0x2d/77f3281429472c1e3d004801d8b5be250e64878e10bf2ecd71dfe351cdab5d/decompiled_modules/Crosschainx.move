module 0x2d77f3281429472c1e3d004801d8b5be250e64878e10bf2ecd71dfe351cdab5d::Crosschainx {
    struct SwapEvent has copy, drop {
        fromToken: 0x1::string::String,
        fromAmount: u64,
        toToken: 0x1::string::String,
        minReturnAmount: 0x1::string::String,
        destination: 0x1::string::String,
        source: 0x1::string::String,
    }

    public entry fun swap<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, @0x7c606de8d04558dddeebd6e867e7fdb247ec50b16141f644ddd270ba9c44f280);
        let v0 = SwapEvent{
            fromToken       : arg2,
            fromAmount      : arg1,
            toToken         : arg3,
            minReturnAmount : arg4,
            destination     : arg5,
            source          : arg6,
        };
        0x2::event::emit<SwapEvent>(v0);
    }

    public entry fun withdraw<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x7c606de8d04558dddeebd6e867e7fdb247ec50b16141f644ddd270ba9c44f280, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

