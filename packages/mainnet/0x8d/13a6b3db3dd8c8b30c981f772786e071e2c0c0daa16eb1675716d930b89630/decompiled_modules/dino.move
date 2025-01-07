module 0x8d13a6b3db3dd8c8b30c981f772786e071e2c0c0daa16eb1675716d930b89630::dino {
    struct DINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DINO>(arg0, 6, b"DINO", b"DINOONSUI", x"4f6e65206f66207468652066697273742062696767657374206d656d65636f696e73206f6e2053756920f09fa69657524141414141414141414141414141414141414141482120f09fa6960a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731092236396.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DINO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DINO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

