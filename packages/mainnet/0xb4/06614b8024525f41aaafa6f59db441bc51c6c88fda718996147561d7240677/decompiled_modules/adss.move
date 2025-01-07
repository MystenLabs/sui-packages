module 0xb406614b8024525f41aaafa6f59db441bc51c6c88fda718996147561d7240677::adss {
    struct ADSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADSS>(arg0, 6, b"ADSS", b"asdas", b"sda", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/WX_20221106_194015_2x_393527909c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

