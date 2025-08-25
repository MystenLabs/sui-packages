module 0xe15c8732d92b7ceb6cd89c16284b8279ae21d548170592d0f89615679ccabfbb::sfdf {
    struct SFDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFDF>(arg0, 9, b"sfdf", b"nobuy", b"fdsgsfdgwdfgfg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SFDF>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFDF>>(v2, @0x634e9a333eded754ee081fb1cf19cf6516029545890a3fcffb7521bc1fb6b57d);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFDF>>(v1);
    }

    // decompiled from Move bytecode v6
}

