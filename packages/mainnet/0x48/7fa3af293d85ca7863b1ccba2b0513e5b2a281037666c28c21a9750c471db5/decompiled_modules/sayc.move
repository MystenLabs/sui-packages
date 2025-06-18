module 0x487fa3af293d85ca7863b1ccba2b0513e5b2a281037666c28c21a9750c471db5::sayc {
    struct SAYC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAYC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAYC>(arg0, 6, b"SAYC", b"Sui Apes Yacht Club", b"Welcome to the Sui  Apes Yacht Club. Only elite members of Sui are able to receive an invite.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiamiq5kjj37xg72b4ydpwulisamqp5zoa5rdkevk3izm4vvs67yam")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAYC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SAYC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

