module 0x8f857b8b29cd5d2133c00a4e3cc1f9a5073dbc2b470905426626d7fb8752f24d::fatty {
    struct FATTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FATTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FATTY>(arg0, 6, b"FATTY", b"Sui Fatty", b"Hello I'M fat boy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000019141_b5ee1c34d5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FATTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FATTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

