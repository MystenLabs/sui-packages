module 0x94328ca37078136b1e3ac70213096ed1200648a649145a6dadd61e929ffdbccb::aaaablue {
    struct AAAABLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAABLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAABLUE>(arg0, 6, b"AAAABLUE", b"AAA BLUECAT", b"AAAA BLUEEEEE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gambar_Whats_App_2024_10_09_pukul_14_31_58_3845e4ad_592cd0f049.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAABLUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAABLUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

