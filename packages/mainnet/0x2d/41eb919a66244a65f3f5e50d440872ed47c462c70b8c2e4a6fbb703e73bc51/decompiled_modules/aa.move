module 0x2d41eb919a66244a65f3f5e50d440872ed47c462c70b8c2e4a6fbb703e73bc51::aa {
    struct AA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AA>(arg0, 6, b"AA", b"fadsfas", b"fasdfdsafa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreid4qx5s3tifu3us2r4mwii6kiehigvmumugwij6yvghjowz5n4knm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

