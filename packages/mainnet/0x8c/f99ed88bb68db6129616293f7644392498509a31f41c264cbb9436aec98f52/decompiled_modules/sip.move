module 0x8cf99ed88bb68db6129616293f7644392498509a31f41c264cbb9436aec98f52::sip {
    struct SIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIP>(arg0, 9, b"SIP", b"SuiP", b"Cat on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a045614e-eb62-4516-99d0-6d9e58e83c4d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

