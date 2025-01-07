module 0x6e2ad1a9145986f2fbd8711bad52913ea7ffa873b19b2268ec287ead60032c5e::torba {
    struct TORBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TORBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TORBA>(arg0, 9, b"TORBA", b"torba", b"REAL torba", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fc3077cb-f202-4939-83d2-eed4c1b535e6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TORBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TORBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

