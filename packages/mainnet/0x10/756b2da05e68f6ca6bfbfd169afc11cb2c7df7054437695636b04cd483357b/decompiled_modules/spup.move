module 0x10756b2da05e68f6ca6bfbfd169afc11cb2c7df7054437695636b04cd483357b::spup {
    struct SPUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPUP>(arg0, 6, b"SPUP", b"SUI PUPPYS", b"Sui Puppys is a collection of quirky, cartoon-styled dog characters living on the Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreig4svhzkth4xf3qa457wfgwwybexvuqebltnbblasg5zyajtzsc4u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPUP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

