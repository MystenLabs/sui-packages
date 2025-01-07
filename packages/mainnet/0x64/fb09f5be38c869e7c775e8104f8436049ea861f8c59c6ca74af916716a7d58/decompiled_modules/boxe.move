module 0x64fb09f5be38c869e7c775e8104f8436049ea861f8c59c6ca74af916716a7d58::boxe {
    struct BOXE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOXE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOXE>(arg0, 6, b"BOXE", b"BOXE SUI", b"BOT SNIPER ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_01_08_53_28_8034881f0c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOXE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOXE>>(v1);
    }

    // decompiled from Move bytecode v6
}

