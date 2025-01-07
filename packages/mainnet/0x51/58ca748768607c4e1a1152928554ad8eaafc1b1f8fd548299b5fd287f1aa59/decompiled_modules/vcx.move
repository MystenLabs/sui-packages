module 0x5158ca748768607c4e1a1152928554ad8eaafc1b1f8fd548299b5fd287f1aa59::vcx {
    struct VCX has drop {
        dummy_field: bool,
    }

    fun init(arg0: VCX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VCX>(arg0, 9, b"VCX", b"XCV", b"FD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6d950c4a-69b8-4c6f-a181-633924019230.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VCX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VCX>>(v1);
    }

    // decompiled from Move bytecode v6
}

