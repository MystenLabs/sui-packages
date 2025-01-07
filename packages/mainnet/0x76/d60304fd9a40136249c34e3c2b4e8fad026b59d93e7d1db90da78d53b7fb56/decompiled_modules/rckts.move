module 0x76d60304fd9a40136249c34e3c2b4e8fad026b59d93e7d1db90da78d53b7fb56::rckts {
    struct RCKTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RCKTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RCKTS>(arg0, 9, b"RCKTS", b"Racket Bul", b"rocket vn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4a58acc9-fe10-44f8-9b01-07bdd913a479.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RCKTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RCKTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

