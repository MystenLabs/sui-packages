module 0x39102ac3a098316434ace7bbb4c413f7bd697e8cdcecf2e858f1958662ac77cb::cool {
    struct COOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOL>(arg0, 9, b"COOL", b"GIA", b"The world is for digital currency So invest wisely Together! Because \"GIA\" will be a part of it!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8348f90e-af10-4a22-9cea-1b3442e1dfd6-1000504028.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

