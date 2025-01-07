module 0x706e831493c0ba350cef33dd5c31f9d639eba0b60e32069939f1682d1b58c53f::saya {
    struct SAYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAYA>(arg0, 9, b"SAYA", b"Sayabang", b"saya bang", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d4e99316-4c16-4413-886f-3b4456e4e8f4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAYA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAYA>>(v1);
    }

    // decompiled from Move bytecode v6
}

