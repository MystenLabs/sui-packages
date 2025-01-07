module 0x5d9dbee706a7e7592036e86c09a364abd075cd0ac94ccf63781c6ae559d9b425::pyd {
    struct PYD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PYD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PYD>(arg0, 9, b"PYD", b"Peyvand ", b"Go to moon ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6f00e3f0-9f24-4512-8beb-419d0360a536.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PYD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PYD>>(v1);
    }

    // decompiled from Move bytecode v6
}

