module 0x4300c30fcd540a63992f72086861deecdbdf9d797d116e7186f66d51f32af226::InZPos {
    struct PosDeposit has copy, drop {
        fromAddress: address,
        amount: u64,
        callBackData: 0x1::string::String,
    }

    public entry fun deposit<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::pay::split_and_transfer<T0>(arg0, arg1, @0x16b9a59d043f1490ff0eaddab0e1e5a27b628167773b0a57c70e6f3c29029bd, arg3);
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

