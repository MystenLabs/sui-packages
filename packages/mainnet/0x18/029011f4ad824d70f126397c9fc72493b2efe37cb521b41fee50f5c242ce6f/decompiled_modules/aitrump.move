module 0x18029011f4ad824d70f126397c9fc72493b2efe37cb521b41fee50f5c242ce6f::aitrump {
    struct AITRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AITRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AITRUMP>(arg0, 9, b"AITRUMP", b"AI TRUMP", b"AI TRUMP MAKE CRYPTO GREAT AGAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/20ac268b-3566-4a83-8932-78b0c7e30716.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AITRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AITRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

