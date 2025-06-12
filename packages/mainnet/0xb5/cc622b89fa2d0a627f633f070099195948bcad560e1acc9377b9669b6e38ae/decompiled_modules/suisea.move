module 0xb5cc622b89fa2d0a627f633f070099195948bcad560e1acc9377b9669b6e38ae::suisea {
    struct SUISEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISEA>(arg0, 6, b"SUISEA", b"UNDER THE SUI SEA", b"Dive deep into the meme wave! UNDER THE SUI SEA is the latest meme sensation on the Sui blockchain, bringing fun, excitement, and moonshot potential to the crypto community. With a unique oceanic theme, $SUISEA is designed to create waves of laughter and profits", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreid5yuzlhhr4ic7x4vrvj367q4uho73y6t4nyo5hfy72pveg3dkvkm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUISEA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

