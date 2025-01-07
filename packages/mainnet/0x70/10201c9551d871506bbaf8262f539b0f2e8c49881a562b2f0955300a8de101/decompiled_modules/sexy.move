module 0x7010201c9551d871506bbaf8262f539b0f2e8c49881a562b2f0955300a8de101::sexy {
    struct SEXY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEXY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEXY>(arg0, 9, b"SEXY", b"SEXY ", b"\"Sexy Token is a bold digital asset designed to add excitement and style to crypto. Offering exclusive rewards and community perks, it redefines digital finance with a fresh approach. Join the Sexy Token revolution today!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eb857a6c-4226-4e29-bf17-f919f377174e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEXY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEXY>>(v1);
    }

    // decompiled from Move bytecode v6
}

