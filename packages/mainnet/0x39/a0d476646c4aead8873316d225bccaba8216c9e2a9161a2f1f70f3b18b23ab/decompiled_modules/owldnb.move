module 0x39a0d476646c4aead8873316d225bccaba8216c9e2a9161a2f1f70f3b18b23ab::owldnb {
    struct OWLDNB has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWLDNB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWLDNB>(arg0, 9, b"OWLDNB", b"kendb", b"gebsb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6e15f372-7df7-4ed7-8fea-0a86d08491b1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWLDNB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OWLDNB>>(v1);
    }

    // decompiled from Move bytecode v6
}

