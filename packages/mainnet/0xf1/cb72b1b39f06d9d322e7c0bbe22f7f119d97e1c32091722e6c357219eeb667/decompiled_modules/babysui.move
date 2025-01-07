module 0xf1cb72b1b39f06d9d322e7c0bbe22f7f119d97e1c32091722e6c357219eeb667::babysui {
    struct BABYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYSUI>(arg0, 9, b"BABYSUI", b"Baby SUI", b"Buy BabySUI and prepare to fly in the sky. Ready to fly in the sky. HODL BabySUI. There is a surprise. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/10c99798-57bf-49bc-9dea-9872ae1fd381.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

