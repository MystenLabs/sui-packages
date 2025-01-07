module 0xa32019fb186554e217d63855e205c0226514a2e7fd40e3942e10ac11e1b55bd3::nyan {
    struct NYAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NYAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NYAN>(arg0, 9, b"NYAN", b"Nyan", b"Nyan cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8fa13f03-386c-49f1-bc0b-9c2682b2a448.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NYAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NYAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

