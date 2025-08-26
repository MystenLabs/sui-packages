module 0xe4ee6413abcbcaf7a7dfdc2beecc38d44008bfe0d3b294ea3d2a6c2f863256d6::payments {
    struct PaymentMade<phantom T0> has copy, drop {
        amount: u64,
        recipient: address,
        invoice_id: vector<u8>,
    }

    public fun make_payment<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: address, arg3: vector<u8>) {
        assert!(0x2::coin::value<T0>(&arg0) == arg1, 0);
        let v0 = PaymentMade<T0>{
            amount     : arg1,
            recipient  : arg2,
            invoice_id : arg3,
        };
        0x2::event::emit<PaymentMade<T0>>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg2);
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

