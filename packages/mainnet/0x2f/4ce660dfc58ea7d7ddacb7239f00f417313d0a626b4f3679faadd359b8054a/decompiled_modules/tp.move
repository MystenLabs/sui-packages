module 0x2f4ce660dfc58ea7d7ddacb7239f00f417313d0a626b4f3679faadd359b8054a::tp {
    struct TP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TP>(arg0, 9, b"TP", b"Tpain", b"The coin Tpain has a vision and objective of relieving pain caused by the bola Ahmed Tinubu regime. Who is the current president of Nigeria.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f8013b90-9b21-4013-bd86-4268b20ac340.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TP>>(v1);
    }

    // decompiled from Move bytecode v6
}

