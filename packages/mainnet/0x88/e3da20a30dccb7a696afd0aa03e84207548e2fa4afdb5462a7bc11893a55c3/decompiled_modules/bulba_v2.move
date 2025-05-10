module 0x88e3da20a30dccb7a696afd0aa03e84207548e2fa4afdb5462a7bc11893a55c3::bulba_v2 {
    struct BULBA_V2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULBA_V2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULBA_V2>(arg0, 6, b"BULBA V2", b"BULBASUI V2", b"V2 Launch don't fade 8%", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreighexhib3yjqm3e2d3zmbns4xgjrinsjmo7gb5zv4fekd4fgf36dq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULBA_V2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BULBA_V2>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

