module 0x5c8864c3f8d0eb1c3cc05afd3ff7f9c477a5f3dae64944b1437e50205baf4352::bubu {
    struct BUBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBU>(arg0, 6, b"BUBU", b"SuiBubu", b"Born Unhinged, Built Unbreakable", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifxf6nmjkrt2bsgquesssvihusepd7jkhruuvu2m6bcjpsszzloxy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BUBU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

