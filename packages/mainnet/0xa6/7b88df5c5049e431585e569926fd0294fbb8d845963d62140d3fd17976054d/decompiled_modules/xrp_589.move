module 0xa67b88df5c5049e431585e569926fd0294fbb8d845963d62140d3fd17976054d::xrp_589 {
    struct XRP_589 has drop {
        dummy_field: bool,
    }

    fun init(arg0: XRP_589, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XRP_589>(arg0, 9, b"XRP_589", b"XRP589$", b"To the moon and beyond! SuiXRP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8be16bd2-9eb2-4045-b1ca-18ae9fe50639.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XRP_589>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XRP_589>>(v1);
    }

    // decompiled from Move bytecode v6
}

