module 0xb62e31e20fb029b3f6182f7a985dd94749f29791da24cefcbc7b8d9782a80551::zyn {
    struct ZYN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZYN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZYN>(arg0, 6, b"ZYN", b"Zynmasui", b"Zynmas is the ultimate crypto meme coin that merges the festive spirit of Christmas with the legendary vibes of \"Zyn,\" creating a playful yet innovative digital asset. Inspired by the joy of giving and the magic of the holiday season, Zynmas embraces a Christmas narrative where every transaction feels like unwrapping a gift. It's a coin that spreads cheer while rewarding its holders with festive surprises and community-driven rewards.   Have a very Merry Zynmas!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241209_145909_572_021d289cbb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZYN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZYN>>(v1);
    }

    // decompiled from Move bytecode v6
}

