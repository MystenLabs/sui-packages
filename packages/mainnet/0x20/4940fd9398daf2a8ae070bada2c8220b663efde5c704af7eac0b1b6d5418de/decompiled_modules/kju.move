module 0x204940fd9398daf2a8ae070bada2c8220b663efde5c704af7eac0b1b6d5418de::kju {
    struct KJU has drop {
        dummy_field: bool,
    }

    fun init(arg0: KJU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KJU>(arg0, 6, b"KJU", b"teszter", b"molik", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibtxte65kvqbydlpifx2uid2ps2m5ssl3jcl6kfc7mfdibqe5bnxi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KJU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KJU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

