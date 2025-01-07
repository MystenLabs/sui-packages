module 0x548bfebb99ff4f9f0e3713bc2fe46de9bb4044e674e2103f9bf3cd9c3a0c63ea::xc {
    struct XC has drop {
        dummy_field: bool,
    }

    fun init(arg0: XC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XC>(arg0, 9, b"XC", b"HD", b"XVC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6ad44abf-30c0-4c3c-88f7-b79a02560ab4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XC>>(v1);
    }

    // decompiled from Move bytecode v6
}

