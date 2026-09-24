module 0x7a9c6723c778901a59752ad693c302d5882d8666d94e6aa2c4388fd1cad16aea::airdrop {
    struct AirdropSentEvent<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
    }

    public fun send<T0>(arg0: 0x2::object::ID, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = AirdropSentEvent<T0>{
            pool_id   : arg0,
            recipient : arg1,
            amount    : 0x2::coin::value<T0>(&arg2),
        };
        0x2::event::emit<AirdropSentEvent<T0>>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, arg1);
    }

    // decompiled from Move bytecode v7
}

