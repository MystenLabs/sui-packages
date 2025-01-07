module 0xa15d8bc6a9dbc8cb148904c643fa47e77f1d1c186f9a3fb5f678963a1f50f77d::chops {
    struct CHOPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOPS>(arg0, 6, b"ChoPs", b"Chop SUI", b"The ultimate aim of chop SUI is to carve out a path in the crypto space where all people can realize their true potential regardless of where they started from. Socials will be available on our upcoming CoinMarketCap listing! Watch for them! Only the most bullish need to participate. Thank you!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_output_b00ef2d26b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHOPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

