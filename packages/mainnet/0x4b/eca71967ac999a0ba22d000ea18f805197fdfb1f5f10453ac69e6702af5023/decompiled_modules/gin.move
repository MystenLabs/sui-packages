module 0x4beca71967ac999a0ba22d000ea18f805197fdfb1f5f10453ac69e6702af5023::gin {
    struct GIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIN>(arg0, 6, b"GIN", b"SUI Gin", b"A homage to the best japanese gin there is. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suijin_2bc7f3ba7a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

