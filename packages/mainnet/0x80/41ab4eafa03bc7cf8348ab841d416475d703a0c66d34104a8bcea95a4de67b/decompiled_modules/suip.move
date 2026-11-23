module 0x8041ab4eafa03bc7cf8348ab841d416475d703a0c66d34104a8bcea95a4de67b::suip {
    struct SUIP has drop {
        dummy_field: bool,
    }

    entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIP>, arg1: 0x2::coin::Coin<SUIP>) {
        0x2::coin::burn<SUIP>(arg0, arg1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIP>>(0x2::coin::mint<SUIP>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SUIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIP>(arg0, 9, b"SUIP", b"SUIP", b"Reward token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/suip.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

