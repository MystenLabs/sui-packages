module 0xd92b9e73b64560c6194cd31ae42bfa554a340a51384ce438c4c8df7294785936::skopsui {
    struct SKOPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKOPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKOPSUI>(arg0, 6, b"SKOPSUI", b"SKOP SUI", b"Dexscreener paid.Check here: https://www.skopsui.pro", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_2_2_cd7bb7dfff.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKOPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKOPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

