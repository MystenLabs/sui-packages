module 0x39d2d469a31457d82031fd59297f17b3810f7abf46e405b8074649a4f9d7bbed::meeseeks {
    struct MEESEEKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEESEEKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEESEEKS>(arg0, 9, b"MEESEEKS", b"Mr Meeseeks on Sui", b"Mr. Meeseeks exhibits a friendly, cheerful, and helpful demeanor; willing to assist the one who brought him into existence, however possible. Ideally.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/J7kUhOX.png")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<MEESEEKS>(&mut v2, 100000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEESEEKS>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEESEEKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

