module 0x6e443d41a723da977f1267dba5ccdcd4f2add667fd20ba8c41d4061af5f759fd::CATS {
    struct CATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATS>(arg0, 9, b"CATS", b"CATS", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATS>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CATS>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<CATS>>(0x2::coin::mint<CATS>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

