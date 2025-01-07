module 0x52d512cbb8daba191049823cf546ccf40ef464e74325e2e13e39ae769cd9fbb5::stli {
    struct STLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STLI>(arg0, 6, b"STLI", b"STLI DRAGON SUI", b"STLI DRAGON PXL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/silly_dragon_trns_6b65490d30.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STLI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STLI>>(v1);
    }

    // decompiled from Move bytecode v6
}

