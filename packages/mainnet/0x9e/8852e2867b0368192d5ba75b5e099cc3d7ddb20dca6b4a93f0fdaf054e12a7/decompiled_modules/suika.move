module 0x9e8852e2867b0368192d5ba75b5e099cc3d7ddb20dca6b4a93f0fdaf054e12a7::suika {
    struct SUIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKA>(arg0, 5, b"SUIKA", b"Suika AI", b"SUIKA AI has the potential to revolutionize the gaming industry by significantly improving game play and achieving high scores", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/Jccoev2.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIKA>(&mut v2, 5000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

