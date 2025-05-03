module 0xbfafa877a531cef5c987dc0fc6b2966476367f244f78525ec9e1e4a7a0895318::poor {
    struct POOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOR>(arg0, 9, b"POOR", b"Poorlax", b"Still holding. Still hoping. Still poor.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1746226799440.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POOR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<POOR>>(0x2::coin::mint<POOR>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<POOR>>(v2);
    }

    // decompiled from Move bytecode v6
}

