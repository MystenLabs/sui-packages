module 0xb55048f1a85714bed6901eafb79e2f2896bd5ae3af8af2c8c3b4acd73cfd0b60::suiturbo {
    struct SUITURBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITURBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITURBO>(arg0, 6, b"SuiTurbo", b"Sui Turbo", b"Turbo charged!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/h_Zh_HSLCR_400x400_afc29fccdb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITURBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITURBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

