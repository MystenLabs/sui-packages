module 0xc41eb962decde130361b02ad64288dc47403dc2d230fcda85d90c349deb17b13::dogmem {
    struct DOGMEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGMEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGMEM>(arg0, 9, b"DOGMEM", b"Dogmem", b"Dogmem most viral meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9b206a03-3852-4d28-8fbb-cff1921c5c1c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGMEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGMEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

