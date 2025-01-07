module 0x531772df92c7ffa0f8f7c0957a70a24a0099fc7e19dce1c907f82a37206f6030::vndmm {
    struct VNDMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: VNDMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VNDMM>(arg0, 9, b"VNDMM", x"564ec4904d4d", x"4d656d6520636f696e20616e6820656d20c490c3b46e67204cc3a06f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6dbc57fd-9f3e-4e7c-b332-759a381a09e1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VNDMM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VNDMM>>(v1);
    }

    // decompiled from Move bytecode v6
}

