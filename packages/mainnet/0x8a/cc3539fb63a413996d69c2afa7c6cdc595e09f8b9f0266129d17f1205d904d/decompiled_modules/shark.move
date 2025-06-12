module 0x8acc3539fb63a413996d69c2afa7c6cdc595e09f8b9f0266129d17f1205d904d::shark {
    struct SHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARK>(arg0, 6, b"SHARK", b"Shark On Sui", b"$SHARK emerged from the depths of 2025, crafted by a solitary creator who dared to illuminate the darkest corners of the crypto swamp.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicvhy62rady4lgl6vdiqqw7kfb3dsfan3hphw27ywsece3hjlbkue")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHARK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

