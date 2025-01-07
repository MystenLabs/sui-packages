module 0xb8823d2a1beee10bce6a067ba40ac6997de8ebe0095a01616847f11c826555c0::vtus {
    struct VTUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: VTUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VTUS>(arg0, 9, b"VTUS", b"Sentus", b"What the fuck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d0fdc258-8101-4044-adc4-42188dd18ac3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VTUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VTUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

