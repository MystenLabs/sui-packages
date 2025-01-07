module 0x98b559c34ced6af52e3a04ae90a8cb268c07209e66fe3cfe189b98084866f663::zahid {
    struct ZAHID has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZAHID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZAHID>(arg0, 9, b"ZAHID", b"Anjum", b"This is nice coin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bc9c8e92-7c2c-4016-a0d4-061f2c3f06a8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZAHID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZAHID>>(v1);
    }

    // decompiled from Move bytecode v6
}

