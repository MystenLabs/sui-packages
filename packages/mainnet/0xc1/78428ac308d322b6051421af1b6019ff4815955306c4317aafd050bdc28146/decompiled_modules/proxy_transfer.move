module 0xc178428ac308d322b6051421af1b6019ff4815955306c4317aafd050bdc28146::proxy_transfer {
    struct ProxyTransferEvent<phantom T0> has copy, drop {
        sender: address,
        recipient: address,
        amount: u64,
    }

    public fun proxy_transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 != @0x0, 2);
        assert!(arg1 > 0, 1);
        assert!(0x2::coin::value<T0>(&arg0) == arg1, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg2);
        let v0 = ProxyTransferEvent<T0>{
            sender    : 0x2::tx_context::sender(arg3),
            recipient : arg2,
            amount    : arg1,
        };
        0x2::event::emit<ProxyTransferEvent<T0>>(v0);
    }

    // decompiled from Move bytecode v7
}

