module 0x50b15c3db2b7e90c79929854ed1beaa849acd6a451b4c14f3fb613cfa5025514::pixel {
    struct PIXEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIXEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIXEL>(arg0, 9, b"PIXEL", b"Not Pixel", b"Play https://t.me/notpixel/app?startapp=f5870088276_s628001", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a08b3f01-a561-468a-93a8-528c62804461.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIXEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIXEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

