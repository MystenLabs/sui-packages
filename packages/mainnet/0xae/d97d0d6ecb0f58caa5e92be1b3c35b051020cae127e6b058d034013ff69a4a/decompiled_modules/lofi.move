module 0xaed97d0d6ecb0f58caa5e92be1b3c35b051020cae127e6b058d034013ff69a4a::lofi {
    struct LOFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LOFI>(arg0, 6, b"LOFI", b"Lofi Music by SuiAI", b"Created by the French music producer Dimitri, LoFi  girls is a 24/7 livestream of girl studying in her room.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2101_0aaf248645.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LOFI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOFI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

