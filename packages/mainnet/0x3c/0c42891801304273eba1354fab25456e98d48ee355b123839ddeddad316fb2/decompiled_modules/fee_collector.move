module 0x3c0c42891801304273eba1354fab25456e98d48ee355b123839ddeddad316fb2::fee_collector {
    struct FeeCollected has copy, drop {
        payer: address,
        fee_amount: u64,
        storage_amount: u64,
    }

    public fun collect_fee<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 0);
        let v1 = v0 * 1000 / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, v1, arg1), @0x7dca7cbd2a2e7ef9d0967d7b66e64459e8708e46fc39a26236352a1c2bc3291b);
        let v2 = FeeCollected{
            payer          : 0x2::tx_context::sender(arg1),
            fee_amount     : v1,
            storage_amount : v0 - v1,
        };
        0x2::event::emit<FeeCollected>(v2);
        arg0
    }

    public fun fee_bps() : u64 {
        1000
    }

    public fun fee_recipient() : address {
        @0x7dca7cbd2a2e7ef9d0967d7b66e64459e8708e46fc39a26236352a1c2bc3291b
    }

    public fun gross_amount(arg0: u64) : u64 {
        (arg0 * 10000 + 10000 - 1000 - 1) / (10000 - 1000)
    }

    // decompiled from Move bytecode v6
}

