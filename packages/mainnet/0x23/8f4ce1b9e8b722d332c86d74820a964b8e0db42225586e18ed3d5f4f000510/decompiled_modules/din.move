module 0x238f4ce1b9e8b722d332c86d74820a964b8e0db42225586e18ed3d5f4f000510::din {
    struct DIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIN>(arg0, 6, b"Din", b"DinDin", b"The DINDIN project, which leads the new trend of Sui-based meme projects, will change the paradigm of memes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibqojugwlswsc4qu4hqydejy4qje7rqwwmrqtfrtrjtxmo6dordnm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

