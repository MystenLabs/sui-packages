module 0x77947f96662a49e7b61d7934c16ac148acd07ed057884dd5dcabc04d8f44a046::WILLY {
    struct WILLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WILLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WILLY>(arg0, 9, b"WILLY", b"WILLY", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WILLY>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WILLY>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<WILLY>>(0x2::coin::mint<WILLY>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

