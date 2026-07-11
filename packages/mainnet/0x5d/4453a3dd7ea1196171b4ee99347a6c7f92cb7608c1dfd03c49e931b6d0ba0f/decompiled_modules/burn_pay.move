module 0x5d4453a3dd7ea1196171b4ee99347a6c7f92cb7608c1dfd03c49e931b6d0ba0f::burn_pay {
    struct BurnPaid has copy, drop {
        payer: address,
        action: vector<u8>,
        amount: u64,
    }

    public fun pay(arg0: &mut 0x5d4453a3dd7ea1196171b4ee99347a6c7f92cb7608c1dfd03c49e931b6d0ba0f::xer::XerTreasury, arg1: vector<u8>, arg2: 0x2::coin::Coin<0x5d4453a3dd7ea1196171b4ee99347a6c7f92cb7608c1dfd03c49e931b6d0ba0f::xer::XER>, arg3: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x5d4453a3dd7ea1196171b4ee99347a6c7f92cb7608c1dfd03c49e931b6d0ba0f::xer::burn(arg0, arg2);
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

