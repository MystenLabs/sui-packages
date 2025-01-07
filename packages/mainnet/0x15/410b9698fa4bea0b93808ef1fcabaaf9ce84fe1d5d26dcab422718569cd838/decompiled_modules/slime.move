module 0x15410b9698fa4bea0b93808ef1fcabaaf9ce84fe1d5d26dcab422718569cd838::slime {
    struct SLIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLIME>(arg0, 6, b"SLIME", b"The first cute formless monster on sui", b"A formless creature that is commonly seen everywhere. It's not hostile to anons and also weak to be a recommendable monster for newbies. It tends to swallow everything in sight. Small monsters that are made of a living gelatinous substance. They're cute and move by bouncing.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_15_14_33_51_62e4b2f14f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLIME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLIME>>(v1);
    }

    // decompiled from Move bytecode v6
}

