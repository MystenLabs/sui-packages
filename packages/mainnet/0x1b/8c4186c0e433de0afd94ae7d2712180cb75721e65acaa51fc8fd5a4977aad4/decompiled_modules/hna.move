module 0x1b8c4186c0e433de0afd94ae7d2712180cb75721e65acaa51fc8fd5a4977aad4::hna {
    struct HNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HNA>(arg0, 9, b"HNA", b"HNNA", b"Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e204910c-632e-4158-bb4f-34cdd7c133e6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HNA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HNA>>(v1);
    }

    // decompiled from Move bytecode v6
}

