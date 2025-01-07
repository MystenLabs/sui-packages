module 0x8633974c6ff67e35da01f4082670ec91cc9018fcb4ec6b36dde53fd69e829c83::suifloki {
    struct SUIFLOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFLOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SUIFLOKI>(arg0, 9, b"SuiFloki", b"SUIFLOKI", b"SuiFloki, bringing floki fans to SUIIIIIIII!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https:&#x2F;&#x2F;i.imgur.com&#x2F;8Mgehzl.png")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SUIFLOKI>(&mut v3, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SUIFLOKI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIFLOKI>>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIFLOKI>>(v2);
    }

    // decompiled from Move bytecode v6
}

