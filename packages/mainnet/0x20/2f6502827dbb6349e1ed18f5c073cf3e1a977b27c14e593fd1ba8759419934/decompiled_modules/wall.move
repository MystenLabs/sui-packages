module 0x202f6502827dbb6349e1ed18f5c073cf3e1a977b27c14e593fd1ba8759419934::wall {
    struct WALL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALL>(arg0, 6, b"WALL", b"WALLSTREET", b"Rob the law abiding citizens", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bull_3a23561f16.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WALL>>(v1);
    }

    // decompiled from Move bytecode v6
}

