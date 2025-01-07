module 0xb5c6263c1ac619dfa21b141b7d6715227c3acf34f59cae3df657963782c26db::catfish {
    struct CATFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATFISH>(arg0, 6, b"CATFISH", b"CATFISH ON THE BEACH", b"\"Muuuuur on SUI\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_13_21_38_54_68d469a8b4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

