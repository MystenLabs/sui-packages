module 0xb87017d4f7e23a2b57294c4ae0aea318249d29536537c4eed47bcd44d544f175::ukr {
    struct UKR has drop {
        dummy_field: bool,
    }

    fun init(arg0: UKR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UKR>(arg0, 9, b"UKR", b"Victory ", b"UKRAINE fan's mem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7ecbe3f5-e6ec-4888-ba63-74c3dede2bc1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UKR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UKR>>(v1);
    }

    // decompiled from Move bytecode v6
}

