module 0x197ead6c5bc4b5a1a5e3732400fba4f32ce704cbfa812cedf164e368812b5710::ang {
    struct ANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANG>(arg0, 9, b"ANG", b"Angel", b"The kind angel has good gifts for you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3e8e454a-0b6e-411e-b64c-a2ff0d917e17.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

