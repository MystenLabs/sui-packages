module 0x5f4d369c313543da7f86f00e11cdb497eabdc5e2246f9eed0129b8af0885bf18::fwog {
    struct FWOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FWOG>(arg0, 6, b"FWOG", b"FWOGGY", b"The first frog on sui chain. Lets the frogs out", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000111207_e46328d3af.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FWOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

