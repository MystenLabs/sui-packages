module 0xa41ecd6fb930b6b7e6178be57db4fedc2289c293d396f7fd7b4c2b76da5a93cf::lenss {
    struct LENSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LENSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LENSS>(arg0, 6, b"LENSS", b"SUILENSS", b"bitcoin foundor satoshi nakalen suissaman ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_Gigachad_017196db73.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LENSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LENSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

