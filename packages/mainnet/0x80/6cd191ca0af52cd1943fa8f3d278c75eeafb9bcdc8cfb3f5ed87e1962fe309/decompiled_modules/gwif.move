module 0x806cd191ca0af52cd1943fa8f3d278c75eeafb9bcdc8cfb3f5ed87e1962fe309::gwif {
    struct GWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: GWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GWIF>(arg0, 6, b"GWIF", b"GirlWifHat", b"No social until we fill the curve #BOOM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000149294_89799c07a8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

