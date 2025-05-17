module 0xebaf85d996f9c6727da9f1b6b9eb6c9ffadf9a794150d7c1f152c8b76d4a5354::emo {
    struct EMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMO>(arg0, 6, b"EMO", b"Emogla", b"emogla sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiffshbob3n3hxnxccsxfj5za4sai2ji2ftyamjy7lx57wyltbrtta")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EMO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

