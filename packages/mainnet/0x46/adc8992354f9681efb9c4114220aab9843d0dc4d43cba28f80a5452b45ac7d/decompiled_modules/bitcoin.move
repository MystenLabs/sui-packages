module 0x46adc8992354f9681efb9c4114220aab9843d0dc4d43cba28f80a5452b45ac7d::bitcoin {
    struct BITCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITCOIN>(arg0, 9, b"BITCOIN", b"Bitcoin", b"Bitcoin is an innovative payment network and a new kind of money. Find all you need to know and get started with Bitcoin on bitcoin.org.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/39e50b10-d61f-426f-981c-be2cd825519c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BITCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

