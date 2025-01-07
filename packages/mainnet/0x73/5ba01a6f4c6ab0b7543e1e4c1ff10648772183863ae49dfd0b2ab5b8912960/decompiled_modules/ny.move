module 0x735ba01a6f4c6ab0b7543e1e4c1ff10648772183863ae49dfd0b2ab5b8912960::ny {
    struct NY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NY>(arg0, 9, b"NY", b"NewYork", b"NewYork city", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NY>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NY>>(v1);
    }

    // decompiled from Move bytecode v6
}

