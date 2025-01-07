module 0xe8c9948e186e1ee6a853ac54fd51ac8d820da50ead70d7a1635e301e023c60c::dododog {
    struct DODODOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DODODOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DODODOG>(arg0, 9, b"DODODOG", b"Super", b"Dog but cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2dc9411c-8145-4eb3-be9e-275a9a84531a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DODODOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DODODOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

