module 0xdb92678fb928fdbe5f9dbf56a87c95d0ddb1d55b16544c21fc38930145bfdbd0::barronmeme {
    struct BARRONMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARRONMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARRONMEME>(arg0, 9, b"BARRONMEME", b"Barron", b"Barron meme for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8adb5f54-0647-4494-bafc-1c4be50d0deb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARRONMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BARRONMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

