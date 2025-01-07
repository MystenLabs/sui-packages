module 0xb1f676d27ad9714a6d8f18d6efdff18ad76dade1e1883237dda93f23d9d76ed7::gta {
    struct GTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GTA>(arg0, 6, b"GTA", b"Sui Andreas", b"Ah shit, here we go again...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fighting_51_f975931b0f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

