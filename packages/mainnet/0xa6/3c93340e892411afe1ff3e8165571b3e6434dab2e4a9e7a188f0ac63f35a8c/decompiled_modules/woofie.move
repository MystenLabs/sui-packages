module 0xa63c93340e892411afe1ff3e8165571b3e6434dab2e4a9e7a188f0ac63f35a8c::woofie {
    struct WOOFIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOOFIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOOFIE>(arg0, 6, b"WOOFIE", b"WoofieSui", x"0a574f4f464945202d2046756e6e6965737420646f67206f6e2024535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/asdasd_ba9e68f8f5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOOFIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOOFIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

