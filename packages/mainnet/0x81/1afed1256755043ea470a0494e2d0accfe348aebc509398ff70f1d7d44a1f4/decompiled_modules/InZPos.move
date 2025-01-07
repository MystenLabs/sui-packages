module 0x811afed1256755043ea470a0494e2d0accfe348aebc509398ff70f1d7d44a1f4::InZPos {
    struct PosCap has key {
        id: 0x2::object::UID,
    }

    struct PosWithdraw has copy, drop {
        toAddress: address,
        amount: u64,
    }

    struct PosDeposit has copy, drop {
        fromAddress: address,
        amount: u64,
        callBackData: 0x1::string::String,
    }

    struct PosTransfer has copy, drop {
        toAddress: address,
        amount: u64,
    }

    public entry fun transfer<T0>(arg0: address, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::pay::split_and_transfer<T0>(arg1, arg2, arg0, arg3);
        let v0 = PosTransfer{
            toAddress : arg0,
            amount    : arg2,
        };
        0x2::event::emit<PosTransfer>(v0);
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
        let v0 = PosCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<PosCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun withdraw<T0>(arg0: u64, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::pay::split_and_transfer<T0>(arg1, arg0, 0x2::tx_context::sender(arg2), arg2);
        let v0 = PosWithdraw{
            toAddress : 0x2::tx_context::sender(arg2),
            amount    : arg0,
        };
        0x2::event::emit<PosWithdraw>(v0);
    }

    // decompiled from Move bytecode v6
}

