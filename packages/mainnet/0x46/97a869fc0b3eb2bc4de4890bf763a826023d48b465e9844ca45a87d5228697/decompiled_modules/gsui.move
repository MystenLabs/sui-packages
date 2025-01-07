module 0x4697a869fc0b3eb2bc4de4890bf763a826023d48b465e9844ca45a87d5228697::gsui {
    struct GSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GSUI>(arg0, 6, b"GSUI", b"GAME SUISTOP", b"No socials, the currency that SUI needs. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Black_and_White_Letter_MD_Logo_Instagram_Post_3930572ce6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

