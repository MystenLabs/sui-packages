module 0xf13cf8d46dd33a4b44898971c148b9123b521e69b953346fa008dd5cd1c0461f::wtffa {
    struct WTFFA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTFFA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTFFA>(arg0, 6, b"WTFFA", b"WTFF MAN", b"WTFF MAN what are u doin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeieay4e2tmjqys63advy4coab5qhxjezw24pe7z6izc4vdaq5jcyfu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WTFFA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WTFFA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

