module 0xe28a9798b6f6941a9813e7e92841e6a14a8e27c6205d499a310e71de59c6f878::zut {
    struct ZUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZUT>(arg0, 6, b"ZUT", b"Zustand", b"Test token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/4c3d7330-d89f-11ef-8165-f761f2caed44")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZUT>>(v1);
        0x2::coin::mint_and_transfer<ZUT>(&mut v2, 1100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZUT>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

