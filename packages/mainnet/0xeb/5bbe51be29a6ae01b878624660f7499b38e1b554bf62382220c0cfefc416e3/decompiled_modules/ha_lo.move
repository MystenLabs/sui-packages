module 0xeb5bbe51be29a6ae01b878624660f7499b38e1b554bf62382220c0cfefc416e3::ha_lo {
    struct HA_LO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HA_LO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HA_LO>(arg0, 9, b"HA_LO", b"pro", b"bdkdkdk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9246adda-a926-4114-89d8-8ee1f27f35d4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HA_LO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HA_LO>>(v1);
    }

    // decompiled from Move bytecode v6
}

