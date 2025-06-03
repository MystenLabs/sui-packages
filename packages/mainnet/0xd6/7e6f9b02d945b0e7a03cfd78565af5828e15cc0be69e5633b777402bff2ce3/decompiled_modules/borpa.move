module 0xd67e6f9b02d945b0e7a03cfd78565af5828e15cc0be69e5633b777402bff2ce3::borpa {
    struct BORPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BORPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BORPA>(arg0, 6, b"BORPA", b"Borpa meme", b"FUCK YOU ALL DEV RUGGER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibixuzm7wj4bdu7crtz4xn64qbbhftplgghd53brg7acz5xh7rcry")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BORPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BORPA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

