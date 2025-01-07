module 0xf597ec9249292f0e344ff1b0b9759c85ea2e2635983e82bc29c0d172fbcd1b88::thira {
    struct THIRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: THIRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THIRA>(arg0, 9, b"THIRA", b"Thiramaala", b"Ocean waves", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cd9c7400-9846-44a0-b04c-8ff4a496e657.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THIRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THIRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

