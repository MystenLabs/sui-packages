module 0x6cc919aacd07177830a8b6068b8281fb3502a6591e1505e01f6fd7279fbd835a::GRAI {
    struct GRAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRAI>(arg0, 9, b"GRAI", b"GRAI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRAI>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GRAI>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<GRAI>>(0x2::coin::mint<GRAI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

