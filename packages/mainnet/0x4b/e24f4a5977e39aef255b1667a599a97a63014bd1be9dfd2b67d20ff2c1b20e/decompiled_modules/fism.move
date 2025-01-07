module 0x4be24f4a5977e39aef255b1667a599a97a63014bd1be9dfd2b67d20ff2c1b20e::fism {
    struct FISM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISM>(arg0, 9, b"FISM", b"Fish Man", b"A Meme for everybody", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2702dc39-590c-4007-b226-09ab1c70f666.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FISM>>(v1);
    }

    // decompiled from Move bytecode v6
}

