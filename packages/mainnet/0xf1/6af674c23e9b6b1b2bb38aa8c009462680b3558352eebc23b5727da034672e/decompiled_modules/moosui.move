module 0xf16af674c23e9b6b1b2bb38aa8c009462680b3558352eebc23b5727da034672e::moosui {
    struct MOOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOSUI>(arg0, 6, b"MOOSUI", b"MOODENG SUI", b"Moo Deng (born 10 July 2024) is a pygmy hippopotamus living in Khao Kheow Open Zoo in Si Racha, Chonburi, Thailand.[1][2] She gained notability at two months of age in September 2024 as a popular Internet meme after images of her went viral online.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Moo_deng_74db54dddc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

