module 0xefff19ffe7b3944da9a02711863f14ec40ae53526ff2f5959a7be6fb3da794e8::snowly {
    struct SNOWLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOWLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOWLY>(arg0, 6, b"SNOWLY", b"Snowly", b"Snowly embodies wisdom, vision, and determination. Guiding a journey where focus and community make the impossible possible.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_01_14_17_41_28_removebg_preview_4365035866.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOWLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNOWLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

