module 0x16bae374bd87719adb8897b8392fc0d7f57b3ba4ddb8cb097ec442dfdb06517c::maym {
    struct MAYM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAYM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAYM>(arg0, 9, b"MAYM", b"MIE AYAM", b"Mie ayam spesial dengan bakso dan telor. What you expect?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b68835a3-f192-4cbc-8bc1-a1d285d86267.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAYM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAYM>>(v1);
    }

    // decompiled from Move bytecode v6
}

