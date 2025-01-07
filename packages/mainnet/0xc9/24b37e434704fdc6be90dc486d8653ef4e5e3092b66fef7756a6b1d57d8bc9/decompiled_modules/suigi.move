module 0xc924b37e434704fdc6be90dc486d8653ef4e5e3092b66fef7756a6b1d57d8bc9::suigi {
    struct SUIGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGI>(arg0, 6, b"Suigi", b"SuigiMangione", b"Deny Defend Depose", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733824067319.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIGI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

