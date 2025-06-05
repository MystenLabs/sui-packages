module 0x18cc499d8d19776fae2065ab35fc7e40852b97438f55f6ff5dac4a98c57068c5::pechu {
    struct PECHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PECHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PECHU>(arg0, 6, b"PECHU", b"Pepechu", b"Shit, we caught a meme!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihb4kyqxueiyv3gcxdweozchea2pqfv3tm2ydrf4vx3z4ara7fyna")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PECHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PECHU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

