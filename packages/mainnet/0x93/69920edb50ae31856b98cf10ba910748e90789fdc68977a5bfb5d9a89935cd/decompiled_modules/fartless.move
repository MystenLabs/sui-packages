module 0x9369920edb50ae31856b98cf10ba910748e90789fdc68977a5bfb5d9a89935cd::fartless {
    struct FARTLESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTLESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FARTLESS>(arg0, 6, b"FARTLESS", b"FARTLESS COIN", b"FARTLESS isn't just a coin; it's a movement. A movement away from stinky gas fees and messy chart dumps. We are the clean, efficient, and silent force of the degen world. This coin is for entertainment purposes only and is not financial advice.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifm3mbtmq5ju2ki3a3gwm4aumvdbdcn7rwdb7jf3hvigf4rv2mome")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARTLESS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FARTLESS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

