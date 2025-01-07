module 0xf2328db55b3219b1fa66b091438a1c301a5def01001984ed8adc4bf28b15f4d8::juvia {
    struct JUVIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUVIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUVIA>(arg0, 6, b"JUVIA", b"Juvia Lockser", x"496d204a75766961204c6f636b73657220746865205761746572204d6167652066726f6d20746865204b696e67646f6d206f662046696f7265210a0a57656c636f6d6520746f206d7920416476656e747572657320696e2053756921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/JUVIA_500_x_500_px_73e8d3b5c0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUVIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUVIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

