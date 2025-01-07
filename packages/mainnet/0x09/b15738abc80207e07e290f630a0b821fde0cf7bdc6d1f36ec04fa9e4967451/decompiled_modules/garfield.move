module 0x9b15738abc80207e07e290f630a0b821fde0cf7bdc6d1f36ec04fa9e4967451::garfield {
    struct GARFIELD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GARFIELD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GARFIELD>(arg0, 6, b"Garfield", b"GarFieldCat", b"Cats cute!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_fotor_bg_remover_2024092191053_bba24720bd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GARFIELD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GARFIELD>>(v1);
    }

    // decompiled from Move bytecode v6
}

