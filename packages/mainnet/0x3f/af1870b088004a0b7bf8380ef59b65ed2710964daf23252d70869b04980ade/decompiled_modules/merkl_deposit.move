module 0x3faf1870b088004a0b7bf8380ef59b65ed2710964daf23252d70869b04980ade::merkl_deposit {
    struct DepositEvent has copy, drop {
        ref: vector<u8>,
        amount: u64,
        from: address,
    }

    public entry fun deposit(arg0: address, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = DepositEvent{
            ref    : arg2,
            amount : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            from   : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<DepositEvent>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0);
    }

    // decompiled from Move bytecode v7
}

