module 0x35146bd16b5854ea9b13ad3b6787f71716330b0b1eef65ee828c4168e1815d2e::sfyi {
    struct SFYI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFYI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFYI>(arg0, 9, b"SFYI", b"8e67l", b"dtuyjk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/421376e645b6799e103a2a5e416ad5a6blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SFYI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFYI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

