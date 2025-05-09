module 0x89eddd29fa4c4ee552a73a6b6c1eaa617407a25b8574710d135390426860dd66::suivee {
    struct SUIVEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIVEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIVEE>(arg0, 6, b"SUIVEE", b"Suivee Pokemon", b"SUIVEE NEVER DIE , relaunch CTO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihgi4hsupftloop6pgxq6f24vmywcnb7hh7fcik6qfzlwprlp42qu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIVEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIVEE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

