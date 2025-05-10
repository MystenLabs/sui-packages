module 0xcb7360e44b3837d744ada52d1fd23438e1931f95e4c8f459284042b88c304811::bulba {
    struct BULBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULBA>(arg0, 6, b"Bulba", b"BULBASUI", b"Bulba relaunch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreighexhib3yjqm3e2d3zmbns4xgjrinsjmo7gb5zv4fekd4fgf36dq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BULBA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

