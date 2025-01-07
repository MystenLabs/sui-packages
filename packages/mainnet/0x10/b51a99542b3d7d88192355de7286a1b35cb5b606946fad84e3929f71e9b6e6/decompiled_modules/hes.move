module 0x10b51a99542b3d7d88192355de7286a1b35cb5b606946fad84e3929f71e9b6e6::hes {
    struct HES has drop {
        dummy_field: bool,
    }

    fun init(arg0: HES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HES>(arg0, 9, b"HES", b"Henshinnnn", b"Henshinnn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/57090e0e-71d7-4c26-be1d-083e97ca6bb8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HES>>(v1);
    }

    // decompiled from Move bytecode v6
}

