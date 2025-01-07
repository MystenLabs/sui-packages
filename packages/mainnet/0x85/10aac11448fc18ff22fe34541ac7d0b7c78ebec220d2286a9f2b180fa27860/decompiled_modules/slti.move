module 0x8510aac11448fc18ff22fe34541ac7d0b7c78ebec220d2286a9f2b180fa27860::slti {
    struct SLTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLTI>(arg0, 9, b"SLTI", b"SLIT", b"coin silit bojo nyebai", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/48d37433-e094-4961-93bd-4efe5502c314.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLTI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLTI>>(v1);
    }

    // decompiled from Move bytecode v6
}

