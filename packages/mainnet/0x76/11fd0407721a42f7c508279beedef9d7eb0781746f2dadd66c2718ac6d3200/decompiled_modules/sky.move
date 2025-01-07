module 0x7611fd0407721a42f7c508279beedef9d7eb0781746f2dadd66c2718ac6d3200::sky {
    struct SKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKY>(arg0, 6, b"SKY", b"SKYpurr", b"sky the purr cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20240920_WA_0005_12ef884dbd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

