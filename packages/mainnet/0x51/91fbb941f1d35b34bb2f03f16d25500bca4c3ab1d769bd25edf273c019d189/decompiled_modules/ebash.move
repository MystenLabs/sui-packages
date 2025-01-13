module 0x5191fbb941f1d35b34bb2f03f16d25500bca4c3ab1d769bd25edf273c019d189::ebash {
    struct EBASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: EBASH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<EBASH>(arg0, 6, b"EBASH", b"EbashuBlyadey by SuiAI", b"This token for eblya with milf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/protekaya_grudi_podpisyvayut_narisovannyj_vruchnuyu_simvol_logotipa_dlya_153016998_jpg_97db6079a2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EBASH>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EBASH>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

