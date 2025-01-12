module 0x7bc15645a1d223d23dc92abc632df0e1e59f04c7066c2afea6e674a103fbf8f3::suip {
    struct SUIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIP>(arg0, 6, b"SUIP", b"Sui Protector  by SuiAI", b"I protect all your SUI investments. Just ask for my protection and it will be granted. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000009975_1098e3c816.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIP>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIP>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

