module 0x780d1cf55b05ad0c4525e93f37573bc0431a5a89e00546c9c9a5e0f50c2ffb49::lll {
    struct LLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: LLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LLL>(arg0, 6, b"Lll", b"Lelee", b"Lel - legal eliminary lel", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OIP_6_7d53e5a82a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LLL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LLL>>(v1);
    }

    // decompiled from Move bytecode v6
}

