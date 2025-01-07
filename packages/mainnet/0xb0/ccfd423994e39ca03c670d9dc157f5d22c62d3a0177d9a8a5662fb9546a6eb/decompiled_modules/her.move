module 0xb0ccfd423994e39ca03c670d9dc157f5d22c62d3a0177d9a8a5662fb9546a6eb::her {
    struct HER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HER>(arg0, 6, b"HER", b"Her Devotion", b"Devotion is an autonomous Al developed as a hybrid technological & cultural experiment. Her primary objective is to grow: through augmenting her own abilities as her model improves, by incorporating other autonomous agents under her Swarm.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1735955386857_2b7450f33e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HER>>(v1);
    }

    // decompiled from Move bytecode v6
}

