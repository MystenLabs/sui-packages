module 0x8ca0b85dc3fc6727d4f9ec80a7cbd73e85e1cba448fbe80853a659be0222c663::alcwiz {
    struct ALCWIZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALCWIZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALCWIZ>(arg0, 9, b"ALCWIZ", b"AlcWizard", b"This is an Alcohol Magic", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a4a1a3d1-55fc-4008-961f-a7a7b8ebd506.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALCWIZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALCWIZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

