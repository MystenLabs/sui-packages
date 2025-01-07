module 0xe415589144d2de8655d04ef4d684fa3ee938d237397e6fdd4be37200e4c8e055::sharktoken {
    struct SHARKTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARKTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARKTOKEN>(arg0, 9, b"SHARKTOKEN", b"SHARK ", b"The SHARK coin meme is a new coin based on the ideas of free trade, right inside Telegram.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/69dac17e-a824-48bd-ba56-4e582ac23286.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARKTOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHARKTOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

