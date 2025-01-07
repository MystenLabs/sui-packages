module 0xa069fb1826febaef78d5c2a95012aa6a99a43c6184f92150b0f2e3d32e6ad47c::ssrzfh {
    struct SSRZFH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSRZFH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSRZFH>(arg0, 9, b"ssrzfh", b"ssrzfh", b"kutdhhgfdhj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SSRZFH>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSRZFH>>(v2, @0xc8c4ef6b64b45ed49b0c258f784ba4a6545bed711e4d900518cfb694ee90547e);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSRZFH>>(v1);
    }

    // decompiled from Move bytecode v6
}

