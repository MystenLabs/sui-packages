module 0xca1eb5238f847d225e35ca6facc776c631756423e0891a8ac73774488549f6a6::wop {
    struct WOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOP>(arg0, 9, b"WOP", b"Pow", b"Test 123", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b33008fe-6427-45e3-b6a4-62c41fe76ec9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

