module 0x8e02d3b1fb8cea0589a4e92370a1e16ebf97d9ca52da931bc81bc623fffab8a1::derpy {
    struct DERPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DERPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DERPY>(arg0, 6, b"DERPY", b"Derpy", b"Only Derps allowed.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_7e3c6c4e96.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DERPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DERPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

