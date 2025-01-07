module 0x9839bea5f781996315fb499573828e3302c0accdd0ae51e8c88a27dfd5d88b2d::stb {
    struct STB has drop {
        dummy_field: bool,
    }

    fun init(arg0: STB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STB>(arg0, 6, b"STB", b"Sui The Best", b"Another crypto banger sui is making waves. Sui the Best! Socials and website coming crypto OG team! Sui the Best!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5749_0b4c5f05b1.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STB>>(v1);
    }

    // decompiled from Move bytecode v6
}

