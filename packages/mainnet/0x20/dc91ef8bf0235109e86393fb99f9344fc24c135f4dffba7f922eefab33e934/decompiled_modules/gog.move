module 0x20dc91ef8bf0235109e86393fb99f9344fc24c135f4dffba7f922eefab33e934::gog {
    struct GOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOG>(arg0, 9, b"GOG", b"Googe", b"The most recent example is a ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4f01a6b0-b8ff-4afa-9b31-a1dffc85c5a9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

