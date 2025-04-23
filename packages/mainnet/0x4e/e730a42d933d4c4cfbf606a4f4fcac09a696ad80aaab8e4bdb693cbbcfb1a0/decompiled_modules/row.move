module 0x4ee730a42d933d4c4cfbf606a4f4fcac09a696ad80aaab8e4bdb693cbbcfb1a0::row {
    struct ROW has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROW>(arg0, 6, b"ROW", b"ROOOWW", b"NOOONNO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaylgip6ksbcknf7tmatvamln4xsmlionnp3zu67blmbf4xveepse")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ROW>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

