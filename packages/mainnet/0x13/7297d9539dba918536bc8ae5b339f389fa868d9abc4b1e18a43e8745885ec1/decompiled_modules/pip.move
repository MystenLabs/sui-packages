module 0x137297d9539dba918536bc8ae5b339f389fa868d9abc4b1e18a43e8745885ec1::pip {
    struct PIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIP>(arg0, 6, b"PIP", b"PUG IN POOL", b"Send to DEX send to MOON! Website coming soon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5766_ed389fcfd3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

