module 0x9d822b04db25e6c6e75ca9829b20fc911b84677685be312b00ea14db17b66662::nicol {
    struct NICOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NICOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NICOL>(arg0, 9, b"NICOL", b"Nic", b"Token of nicole", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/69641068-b934-440b-9da4-304887cb97f7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NICOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NICOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

