module 0x1607790a7f57de3761b6e3c921361156b3f4cd384b96350d86c73c24385caaa8::snover {
    struct SNOVER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOVER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOVER>(arg0, 6, b"SNOVER", b"SnoverOnSui", b"Will SNOVER make history? Let's witness!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiggwkcsyyr2jwhsvticjuq2byqbnkiyu3qeraqp5x6qkbzwumknfm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOVER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SNOVER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

