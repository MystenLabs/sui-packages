module 0xc253638ffaa8e93e5f6cd04e4662860b87c69090cf09561d67b2e8580a77b845::nogod {
    struct NOGOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOGOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOGOD>(arg0, 9, b"NOGOD", b"NO GOD", b"Atheism", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/22cc2ef4-4810-4a22-a1ab-2b5f167ed015.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOGOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOGOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

