module 0xe93ede8e1ccf6dad251d99c458c01af9b7452a1b9d607e3617e68edb86278617::gsui {
    struct GSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GSUI>(arg0, 6, b"GSUI", b"GAME SUISTOP", b"No socials, the currency that SUI needs. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Black_and_White_Letter_MD_Logo_Instagram_Post_88cb400439.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

