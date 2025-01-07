module 0xc92c354f223c5658b7d128429228d10cb5f0b34250b5bac26f6980caa650e09::sgsd {
    struct SGSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGSD>(arg0, 9, b"SGSD", b"W", b"HDFH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c7755e47-9ce7-4bad-bca4-2ebd3d90ed94.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SGSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

