module 0x9f21858318506f5b4993ecdf844f847f43bae650bf356dfcdd61e540d40b5571::sloth {
    struct SLOTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLOTH>(arg0, 9, b"SLOTH", b"Slothana", b"Slothana coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2f68b2b8-11c5-4b78-8c7e-45712b288bfc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOTH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLOTH>>(v1);
    }

    // decompiled from Move bytecode v6
}

