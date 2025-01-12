module 0x3a155cdbc41f30bf466059677cbd1cac209f1258e11ffd20b39197e2f3e86d31::koulkou {
    struct KOULKOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOULKOU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<KOULKOU>(arg0, 6, b"KOULKOU", b"koulkou by SuiAI", b"greek man", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/d5kl02u_48f10450_f502_4a4a_b513_c574606f2df3_a44b954aaf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KOULKOU>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOULKOU>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

