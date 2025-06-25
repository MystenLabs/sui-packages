module 0x14d18bdf013ebde3c687f11c7a50986f9d31b759dfc21eff1aa9dd6ac21f2e80::punk {
    struct PUNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUNK>(arg0, 6, b"PUNK", b"skull punk", b"nice looking punk from walrus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_Tela_2025_05_16_a_I_s_15_45_37_0b4c0ad862.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

