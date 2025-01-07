module 0xef0ac22ff409d0d31426e0e6bd44b9ee9611c562dc73adaca3822d677b296e2b::trista {
    struct TRISTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRISTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRISTA>(arg0, 9, b"TRISTa", b"Trista", b"Just a trist", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRISTA>(&mut v2, 222222222000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRISTA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRISTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

