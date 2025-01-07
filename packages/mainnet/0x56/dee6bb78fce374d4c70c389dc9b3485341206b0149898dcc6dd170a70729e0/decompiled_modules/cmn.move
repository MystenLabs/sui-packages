module 0x56dee6bb78fce374d4c70c389dc9b3485341206b0149898dcc6dd170a70729e0::cmn {
    struct CMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CMN>(arg0, 9, b"CMN", b"CRIMON ", b"Join and enjoy the fun ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8bb7adb8-eb0a-45a2-8a79-fcf5564b522b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CMN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CMN>>(v1);
    }

    // decompiled from Move bytecode v6
}

