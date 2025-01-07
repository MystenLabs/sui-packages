module 0x1e758567ecfcbe3a8393823f95238b8edd6689b4b2da9ef65bb12885d927bb68::schizo {
    struct SCHIZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCHIZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCHIZO>(arg0, 6, b"Schizo", b"Schizophrenia", b"Trenches are maddening. Join your Schizo brothers!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9_Bf_D_Pqka_400x400_2fa5794a91.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCHIZO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCHIZO>>(v1);
    }

    // decompiled from Move bytecode v6
}

