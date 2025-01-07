module 0x3c73a11165b58b8df768d148c73bffcda993bab619c75366f07d529ea1ba5e59::craw {
    struct CRAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRAW>(arg0, 6, b"CRAW", b"Crawfish", b"mmm crawzaddy, let's have a boil! MEME token on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/t9_GCJ_4r_U_400x400_9e9d630570.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRAW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRAW>>(v1);
    }

    // decompiled from Move bytecode v6
}

