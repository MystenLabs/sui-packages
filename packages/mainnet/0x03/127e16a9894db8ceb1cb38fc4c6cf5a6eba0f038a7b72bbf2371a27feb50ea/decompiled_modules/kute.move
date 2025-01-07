module 0x3127e16a9894db8ceb1cb38fc4c6cf5a6eba0f038a7b72bbf2371a27feb50ea::kute {
    struct KUTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUTE>(arg0, 9, b"KUTE", b"Haha", b"Dhk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/add4b73e-7e8b-4924-a403-d659f6da7e90.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUTE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KUTE>>(v1);
    }

    // decompiled from Move bytecode v6
}

