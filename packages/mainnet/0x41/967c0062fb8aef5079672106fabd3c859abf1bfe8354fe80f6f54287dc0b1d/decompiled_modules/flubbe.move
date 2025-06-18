module 0x41967c0062fb8aef5079672106fabd3c859abf1bfe8354fe80f6f54287dc0b1d::flubbe {
    struct FLUBBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLUBBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLUBBE>(arg0, 6, b"FLUBBE", b"Fly Bubble", b"Fly Bubble Paragliding", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiheho5ix7ab74hpudgqvog5ok57nkrbjd2clx7kmxzepmmlusqii4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLUBBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FLUBBE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

