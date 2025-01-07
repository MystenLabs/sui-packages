module 0xa77c1b4d209fabfdd9d64d06d8426f747df865369469c1ca8e638e35fc1f2933::InZPos {
    struct PosDeposit has copy, drop {
        fromAddress: address,
        amount: u64,
        callBackData: 0x1::string::String,
    }

    public entry fun deposit<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::pay::split_and_transfer<T0>(arg0, arg1, @0x8e3bf9747b347171144908be0dc9e5d17a6d21e469ff34a0b42623d443b2e295, arg3);
        let v0 = PosDeposit{
            fromAddress  : 0x2::tx_context::sender(arg3),
            amount       : arg1,
            callBackData : arg2,
        };
        0x2::event::emit<PosDeposit>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

