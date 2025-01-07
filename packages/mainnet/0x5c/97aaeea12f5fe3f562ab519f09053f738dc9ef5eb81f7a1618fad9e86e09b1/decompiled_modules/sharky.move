module 0x5c97aaeea12f5fe3f562ab519f09053f738dc9ef5eb81f7a1618fad9e86e09b1::sharky {
    struct SHARKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARKY>(arg0, 9, b"SHARKY", b"Sui Sharky", b"it's a cute sharky?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.dribbble.com/userupload/9118146/file/original-e3e24900a7d83b3cd11305faa584c3e2.png?resize=752x")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHARKY>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARKY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHARKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

