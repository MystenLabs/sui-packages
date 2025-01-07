module 0x2295b2c0f13e59a5849732cca327446e5d10b3c1f97f7c30cf61a4ef8b941e0a::otter {
    struct OTTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTTER>(arg0, 6, b"Otter", b"Sui Otter", b"Otter on sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Otter_3bf86626a9_d817eaecc3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OTTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

