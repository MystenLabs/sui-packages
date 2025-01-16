module 0x239e32ffe53a013977d5ae1948172eb0c6c73bea3154d567353e64e2bc8c1415::trump {
    struct TRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP>(arg0, 9, b"TRUMP", b"Donald J. Trump", x"2057656c636f6d65204261636b2c20507265736964656e74205472756d7021200a416d657269636120697320726561647920617320446f6e616c64204a2e205472756d702072657475726e7320617320746865203437746820507265736964656e7421204c657473204d616b6520416d657269636120477265617420416761696e414741494e2120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQdfX1P4UMiNYY6ojsnqecMy5DgusmAc6fkyXGJUHx7NS")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRUMP>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

