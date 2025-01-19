module 0xdecdae1a2d3527a46a083dea0dd67668b6e1bd332c6e106fa8eca05616647375::iruv {
    struct IRUV has drop {
        dummy_field: bool,
    }

    fun init(arg0: IRUV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IRUV>(arg0, 6, b"IRUV", b"infrared ultraviole", b"Online ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000017852_09f3451a6b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IRUV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IRUV>>(v1);
    }

    // decompiled from Move bytecode v6
}

