module 0x53880e7ce0fa8da5d5e8b8796fe3e588014dc00e8ebe825b9909c24adbe7d3fa::dolphy {
    struct DOLPHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLPHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLPHY>(arg0, 6, b"DOLPHY", b"Dolphy", b"The birth of DolphyCoin was marked by enthusiasm and creativity. Its creators envisioned a cryptocurrency that would embody Dolphy's essence. playful yet resi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000055781_47ccc30cab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLPHY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLPHY>>(v1);
    }

    // decompiled from Move bytecode v6
}

