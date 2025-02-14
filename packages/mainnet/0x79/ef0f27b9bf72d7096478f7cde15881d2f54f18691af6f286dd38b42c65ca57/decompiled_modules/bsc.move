module 0x79ef0f27b9bf72d7096478f7cde15881d2f54f18691af6f286dd38b42c65ca57::bsc {
    struct BSC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSC>(arg0, 9, b"BSC", b"Broccoli", b"Broccoli's story", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a6f8b3b8-0390-49b8-9f42-8e4ba6ecc510.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BSC>>(v1);
    }

    // decompiled from Move bytecode v6
}

