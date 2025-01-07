module 0x1b561d8acd4420cd28a7131f6b973df1a3942edd901e3b64b841c5a8cfdf7afe::jokowi {
    struct JOKOWI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOKOWI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOKOWI>(arg0, 9, b"JOKOWI", b"JOKOWI ", b"JOKO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3e600f64-c516-450a-8d77-3d1173f428c9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOKOWI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOKOWI>>(v1);
    }

    // decompiled from Move bytecode v6
}

