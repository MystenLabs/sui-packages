module 0x1faadc8d29e8cc8b6c29b2d8858027da42d3e4d1dcb6be96c6db4f6e2f7e046b::bgoat {
    struct BGOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BGOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BGOAT>(arg0, 6, b"BGOAT", b"BABY GOAT", b"BABY GOAR SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a1115b94d4354709ad6b314926f8f4ed_fbac8b6724.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BGOAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BGOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

