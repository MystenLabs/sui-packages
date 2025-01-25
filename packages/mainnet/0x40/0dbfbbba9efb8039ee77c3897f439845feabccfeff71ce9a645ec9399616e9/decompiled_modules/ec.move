module 0x400dbfbbba9efb8039ee77c3897f439845feabccfeff71ce9a645ec9399616e9::ec {
    struct EC has drop {
        dummy_field: bool,
    }

    fun init(arg0: EC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EC>(arg0, 9, b"EC", b"OFICE SEC", b"The U.S. Securities and Exchange Commission ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/53fda796-121f-4740-9c0d-b180ec568fb1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EC>>(v1);
    }

    // decompiled from Move bytecode v6
}

