module 0xf080a64dbe96e5be6df42a639108b930212f55b94d4781bd633f1c552d9631f0::dogs0001 {
    struct DOGS0001 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGS0001, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGS0001>(arg0, 9, b"DOGS0001", b"DOGS", b"The design of the DOGS was inspired by the mascot Spotty, which was created by TON founder Pavel Durov for the Telegram community, and embodies the unique spirit and culture of the Telegram community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4d578955-2d41-432f-87b9-a7d03db9aa0c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGS0001>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGS0001>>(v1);
    }

    // decompiled from Move bytecode v6
}

