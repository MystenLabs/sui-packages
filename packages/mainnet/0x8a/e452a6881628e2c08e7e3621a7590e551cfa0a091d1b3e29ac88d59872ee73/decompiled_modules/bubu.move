module 0x8ae452a6881628e2c08e7e3621a7590e551cfa0a091d1b3e29ac88d59872ee73::bubu {
    struct BUBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBU>(arg0, 6, b"BUBU", b"LABUBU", b"labubu pay sui taxes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih7hiooadpu47geszazeoyqi3oneugdvqaosdptusfrgxusjqtydq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BUBU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

