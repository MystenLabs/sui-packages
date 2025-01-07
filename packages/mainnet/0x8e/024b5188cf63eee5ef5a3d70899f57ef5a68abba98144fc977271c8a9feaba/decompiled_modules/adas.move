module 0x8e024b5188cf63eee5ef5a3d70899f57ef5a68abba98144fc977271c8a9feaba::adas {
    struct ADAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADAS>(arg0, 6, b"Adas", b"adas", b"adadadasjabfakjfa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_13_at_20_53_53_ac3823446b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

