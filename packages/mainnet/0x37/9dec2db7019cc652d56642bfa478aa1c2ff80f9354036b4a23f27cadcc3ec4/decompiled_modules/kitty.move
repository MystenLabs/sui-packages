module 0x379dec2db7019cc652d56642bfa478aa1c2ff80f9354036b4a23f27cadcc3ec4::kitty {
    struct KITTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KITTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KITTY>(arg0, 9, b"KITTY", b"Kitty SUI", b"Kitty siuuuu..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c0fadcf7-1563-4086-b7a9-5c58d9ef43e2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KITTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KITTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

