module 0x5df89082dc2d270cb7212c9b2eb9f364e33f805bfe712bf5499048c7b8944e36::dora {
    struct DORA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DORA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DORA>(arg0, 6, b"DORA", b"Doraemon", b"Dorraemon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreicq7cm4l2ppxkq45nlmjhem37z243dj7c3o4oda7ab6h3uamzit7y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DORA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DORA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

