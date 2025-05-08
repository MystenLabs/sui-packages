module 0xae371c199333748eec4ce1244411b9d17d9f0b95320fec21a1e13b40c4a3e1f5::dssd {
    struct DSSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSSD>(arg0, 6, b"DSSD", b"dsdd", b"srsdfrsg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidyqax22ci5it63nng4gcnvk3ocvp7eeou4beoiy7vi34campwyzi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DSSD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

