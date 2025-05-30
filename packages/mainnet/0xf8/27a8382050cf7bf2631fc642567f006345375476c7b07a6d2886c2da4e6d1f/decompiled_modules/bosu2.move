module 0xf827a8382050cf7bf2631fc642567f006345375476c7b07a6d2886c2da4e6d1f::bosu2 {
    struct BOSU2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOSU2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOSU2>(arg0, 6, b"BOSU2", b"Final Bosu 2", b"aka BOSU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib54zte7wqazcayjndmsbvg4k6y3zdjxm6mckjnqvftnfjhuqpdie")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOSU2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOSU2>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

