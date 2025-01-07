module 0xddd97640e86ca7dd4185e052b2a62856408907ba7d0eebbfeeb2225bb627b144::suimese {
    struct SUIMESE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMESE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMESE>(arg0, 6, b"SUIMESE", b"Suimese", b"The face of Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f51cf0d4_163f_44ad_bbd8_fa371f14b78e_59f6fc881d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMESE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMESE>>(v1);
    }

    // decompiled from Move bytecode v6
}

