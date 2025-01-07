module 0xbcad7860f2087a0675d9bf37f8b168e233806b48507e7363340663cbc8f52ee8::snowball {
    struct SNOWBALL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOWBALL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOWBALL>(arg0, 6, b"SNOWBALL", b"Snowball X Official Mascot", b"Meet $SNOWBALL. X OFFICIAL MASCOT on Sui Blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sj_KA_Mb_ED_400x400_fb0fdb9cd3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOWBALL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNOWBALL>>(v1);
    }

    // decompiled from Move bytecode v6
}

