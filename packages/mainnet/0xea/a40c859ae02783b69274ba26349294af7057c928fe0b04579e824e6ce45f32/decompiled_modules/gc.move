module 0xeaa40c859ae02783b69274ba26349294af7057c928fe0b04579e824e6ce45f32::gc {
    struct GC has drop {
        dummy_field: bool,
    }

    fun init(arg0: GC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GC>(arg0, 9, b"GC", b"GETTING CLOSE", b"WOWOWOewewew", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GC>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GC>>(v2, @0xde54a2563797ee480fa49320d104051a158973abef8d516e8f9b5701636a2ca7);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GC>>(v1);
    }

    // decompiled from Move bytecode v6
}

