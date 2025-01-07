module 0x3d42a96485ae2142d4ea6c9b93824477ed464a8feb8c45c962f0a0a7e2aa1501::dragon {
    struct DRAGON has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAGON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAGON>(arg0, 6, b"DRAGON", b"SUIDRAGON", b"We are the first dragon on sui! Lets hold for the glory! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dsui_8fad0eec34.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAGON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRAGON>>(v1);
    }

    // decompiled from Move bytecode v6
}

