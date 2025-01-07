module 0x1dc865f02dfbe1536f4d9926f0d4467dd61887b2ae930291b52269ba7aed73e1::skwmw {
    struct SKWMW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKWMW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKWMW>(arg0, 9, b"SKWMW", b"Msejn", b"Zmwmmw", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3f7cc3af-71c3-41c8-b70d-d56b61b47ab1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKWMW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKWMW>>(v1);
    }

    // decompiled from Move bytecode v6
}

