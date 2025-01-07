module 0xb19e0be3445839840ee08d55ecaca8e21df9ad7c266a35a0b784928ef1c0fbd5::fness {
    struct FNESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FNESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FNESS>(arg0, 9, b"FNESS", b"Finessepdc", b"Painters Community Token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/106cd8e7-2e5b-470a-8433-2609c1b1a8eb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FNESS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FNESS>>(v1);
    }

    // decompiled from Move bytecode v6
}

