module 0xfaadc52e3b09d6ab379230787a55189c92332d38fb4ed6373b17ac49171112f::mukui {
    struct MUKUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUKUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUKUI>(arg0, 6, b"MUKUI", b"Mudskipper Sui", b"Welcome to mudskipper", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_03_14_02_57_feee4cae41.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUKUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUKUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

