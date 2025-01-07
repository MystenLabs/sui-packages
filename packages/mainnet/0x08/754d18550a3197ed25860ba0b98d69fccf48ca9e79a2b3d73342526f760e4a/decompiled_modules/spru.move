module 0x8754d18550a3197ed25860ba0b98d69fccf48ca9e79a2b3d73342526f760e4a::spru {
    struct SPRU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPRU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPRU>(arg0, 6, b"SPRU", b"SPRURDOSUI", x"4c656473206d6167652068697a746f7279203a44440a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/spurdo_4fad1c1898.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPRU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPRU>>(v1);
    }

    // decompiled from Move bytecode v6
}

