module 0xf5d863fcc4f851ecc0a7cd903ab0e4e8d0fac8813ce61f1792d3f9516537fc47::ivanka {
    struct IVANKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: IVANKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IVANKA>(arg0, 9, b"IVANKA", b"Official Ivanka Meme", b"IVANKA memes are digital collectibles intended to function as an expression of support for and engagement with the values embodied by the symbol IVANKA. and the associated artwork, and are not intended to be, or to be the subject of, an investment opportunity, investment contract, or security of any type. https://ivankamemespl.xyz is not political and has nothing to do with any political campaign or any political office or governmental agency.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmZs8VMw3vdZSDpK9B4eipPdxP35HzxLpcGBpeC6RCaCaC")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<IVANKA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IVANKA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IVANKA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

