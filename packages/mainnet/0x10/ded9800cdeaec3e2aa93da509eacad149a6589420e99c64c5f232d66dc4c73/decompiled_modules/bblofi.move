module 0x10ded9800cdeaec3e2aa93da509eacad149a6589420e99c64c5f232d66dc4c73::bblofi {
    struct BBLOFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBLOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBLOFI>(arg0, 6, b"BBLOFI", b"Baby Lofi", b"Meet Baby Lofi the adorable sensation from the Sui network A direct offspring of the Lofi coin which has already reached more than 300 million in market cap.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibsfzr4nip3ppuoi2jwaoku6vydlin3zavihjhgvnadxx7ikm5mr4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBLOFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BBLOFI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

