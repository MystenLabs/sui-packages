module 0x4de814e2fd618a06a57a56f321d66816cf89d9fd0598bc8004342c0802745b0f::suiegg {
    struct SUIEGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIEGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIEGG>(arg0, 9, b"SUIEGG", b"SUIEGG", b"SUIEGG tokenn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIEGG>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIEGG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIEGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

