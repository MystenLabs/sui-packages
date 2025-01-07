module 0x38f8a576f2246dbcefae80d0c5c7d300ee022f19444ad3fd69040cee3c93ee80::iphone17pr {
    struct IPHONE17PR has drop {
        dummy_field: bool,
    }

    fun init(arg0: IPHONE17PR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IPHONE17PR>(arg0, 9, b"IPHONE17PR", b"Apple", b"This is famous brand ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/54a814af-b479-4814-976c-7c3eb85e8745.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IPHONE17PR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IPHONE17PR>>(v1);
    }

    // decompiled from Move bytecode v6
}

