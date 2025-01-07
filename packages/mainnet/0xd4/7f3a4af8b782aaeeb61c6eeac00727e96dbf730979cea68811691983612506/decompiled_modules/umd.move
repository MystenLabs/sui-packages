module 0xd47f3a4af8b782aaeeb61c6eeac00727e96dbf730979cea68811691983612506::umd {
    struct UMD has drop {
        dummy_field: bool,
    }

    fun init(arg0: UMD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UMD>(arg0, 6, b"UMD", b"Unidentified Mysterious Dev", b"Is Mysterious Dev a dog? A cat? No one knows! But the mystery grows, and the hunt for Mysterious Devcontinues. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_18_at_22_15_09_46efb7e32d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UMD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UMD>>(v1);
    }

    // decompiled from Move bytecode v6
}

