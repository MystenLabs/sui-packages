module 0xb73b3ce53dce10a70c0331d232591ba05c84d66c719a74cf83edfc4134a52d0f::pivy_stealth {
    struct PaymentEvent<phantom T0> has copy, drop, store {
        stealth_owner: address,
        payer: address,
        amount: u64,
        label: vector<u8>,
        eph_pubkey: vector<u8>,
        payload: vector<u8>,
        note: vector<u8>,
    }

    struct WithdrawEvent<phantom T0> has copy, drop, store {
        stealth_owner: address,
        amount: u64,
        destination: address,
    }

    public entry fun pay<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 0);
        assert!(0x1::vector::length<u8>(&arg5) <= 121, 2);
        assert!(0x1::vector::length<u8>(&arg3) <= 256, 2);
        assert!(0x1::vector::length<u8>(&arg6) <= 256, 2);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
        0x2::pay::join_vec<T0>(&mut v0, arg0);
        assert!(0x2::coin::value<T0>(&v0) >= arg1, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v0, arg1, arg7), arg2);
        if (0x2::coin::value<T0>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg7));
        } else {
            0x2::coin::destroy_zero<T0>(v0);
        };
        let v1 = PaymentEvent<T0>{
            stealth_owner : arg2,
            payer         : 0x2::tx_context::sender(arg7),
            amount        : arg1,
            label         : arg3,
            eph_pubkey    : arg4,
            payload       : arg5,
            note          : arg6,
        };
        0x2::event::emit<PaymentEvent<T0>>(v1);
    }

    public entry fun announce<T0>(arg0: u64, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 > 0, 0);
        assert!(0x1::vector::length<u8>(&arg4) <= 121, 2);
        assert!(0x1::vector::length<u8>(&arg2) <= 256, 2);
        assert!(0x1::vector::length<u8>(&arg5) <= 256, 2);
        let v0 = PaymentEvent<T0>{
            stealth_owner : arg1,
            payer         : 0x2::tx_context::sender(arg6),
            amount        : arg0,
            label         : arg2,
            eph_pubkey    : arg3,
            payload       : arg4,
            note          : arg5,
        };
        0x2::event::emit<PaymentEvent<T0>>(v0);
    }

    public entry fun announce_withdraw<T0>(arg0: u64, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 > 0, 0);
        let v0 = WithdrawEvent<T0>{
            stealth_owner : 0x2::tx_context::sender(arg2),
            amount        : arg0,
            destination   : arg1,
        };
        0x2::event::emit<WithdrawEvent<T0>>(v0);
    }

    public entry fun withdraw<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 0);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
        0x2::pay::join_vec<T0>(&mut v0, arg0);
        assert!(0x2::coin::value<T0>(&v0) >= arg1, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v0, arg1, arg3), arg2);
        if (0x2::coin::value<T0>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<T0>(v0);
        };
        let v1 = WithdrawEvent<T0>{
            stealth_owner : 0x2::tx_context::sender(arg3),
            amount        : arg1,
            destination   : arg2,
        };
        0x2::event::emit<WithdrawEvent<T0>>(v1);
    }

    // decompiled from Move bytecode v6
}

