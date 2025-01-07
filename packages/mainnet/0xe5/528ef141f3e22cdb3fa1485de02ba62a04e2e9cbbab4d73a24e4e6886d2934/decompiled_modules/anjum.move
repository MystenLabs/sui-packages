module 0xe5528ef141f3e22cdb3fa1485de02ba62a04e2e9cbbab4d73a24e4e6886d2934::anjum {
    struct ANJUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANJUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANJUM>(arg0, 9, b"ANJUM", b"Zahid", b"This is nice coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0f96c69e-82e6-4d84-bf99-2c670a7545be.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANJUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANJUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

