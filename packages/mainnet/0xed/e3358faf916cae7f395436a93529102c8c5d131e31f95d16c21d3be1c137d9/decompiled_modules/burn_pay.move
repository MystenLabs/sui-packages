module 0xede3358faf916cae7f395436a93529102c8c5d131e31f95d16c21d3be1c137d9::burn_pay {
    struct BurnPaid has copy, drop {
        payer: address,
        action: vector<u8>,
        amount: u64,
    }

    public fun pay(arg0: &mut 0xede3358faf916cae7f395436a93529102c8c5d131e31f95d16c21d3be1c137d9::xer::XerTreasury, arg1: vector<u8>, arg2: 0x2::coin::Coin<0xede3358faf916cae7f395436a93529102c8c5d131e31f95d16c21d3be1c137d9::xer::XER>, arg3: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0xede3358faf916cae7f395436a93529102c8c5d131e31f95d16c21d3be1c137d9::xer::burn(arg0, arg2);
        let v1 = BurnPaid{
            payer  : 0x2::tx_context::sender(arg3),
            action : arg1,
            amount : v0,
        };
        0x2::event::emit<BurnPaid>(v1);
        v0
    }

    // decompiled from Move bytecode v7
}

