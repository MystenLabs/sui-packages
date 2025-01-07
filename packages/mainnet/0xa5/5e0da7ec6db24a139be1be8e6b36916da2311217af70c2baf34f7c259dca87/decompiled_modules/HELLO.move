module 0xa55e0da7ec6db24a139be1be8e6b36916da2311217af70c2baf34f7c259dca87::HELLO {
    struct HELLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELLO>(arg0, 9, b"HELLO", b"HELLO", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HELLO>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HELLO>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<HELLO>>(0x2::coin::mint<HELLO>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

