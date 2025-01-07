module 0xb4051f76dae7593d419cb4c9975bdb722be03917d63b9bf5c6001a2d56cf4ef::zm {
    struct ZM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZM>(arg0, 6, b"ZM", b"ZEEK MASK", b"Historic Anime to LIVE ACTION", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3579_232f0eae22.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZM>>(v1);
    }

    // decompiled from Move bytecode v6
}

