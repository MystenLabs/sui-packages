module 0xc2d81f636d2c9849c044d8fe4fe356ce7b88e0f2c41f1fac7454879ae0f651e0::fckfun {
    struct FCKFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCKFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<FCKFUN>(arg0, 9, b"FUCKHOP", b"FCKFUN", b"Fuck this piece of bullshit platform hop.ag", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https:&#x2F;&#x2F;m.media-amazon.com&#x2F;images&#x2F;I&#x2F;51CnJCgKAHL.jpg")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<FCKFUN>(&mut v3, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<FCKFUN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FCKFUN>>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FCKFUN>>(v2);
    }

    // decompiled from Move bytecode v6
}

