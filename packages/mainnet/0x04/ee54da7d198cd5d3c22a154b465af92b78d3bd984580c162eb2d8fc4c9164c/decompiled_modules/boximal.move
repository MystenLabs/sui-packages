module 0x4ee54da7d198cd5d3c22a154b465af92b78d3bd984580c162eb2d8fc4c9164c::boximal {
    struct BOXIMAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOXIMAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOXIMAL>(arg0, 6, b"BOXIMAL", b"Boximal on Sui", b"Boximal is a meme token featuring a unique collection of box-shaped animals! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/boxel_397a72defa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOXIMAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOXIMAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

