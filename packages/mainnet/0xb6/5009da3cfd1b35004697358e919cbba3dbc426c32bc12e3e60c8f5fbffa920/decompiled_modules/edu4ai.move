module 0xb65009da3cfd1b35004697358e919cbba3dbc426c32bc12e3e60c8f5fbffa920::edu4ai {
    struct EDU4AI has drop {
        dummy_field: bool,
    }

    fun init(arg0: EDU4AI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EDU4AI>(arg0, 6, b"EDU4AI", b"Edu4AI", b"Welcome to EDU4I - Firts AI on Sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000028678_7cff42748e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EDU4AI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EDU4AI>>(v1);
    }

    // decompiled from Move bytecode v6
}

