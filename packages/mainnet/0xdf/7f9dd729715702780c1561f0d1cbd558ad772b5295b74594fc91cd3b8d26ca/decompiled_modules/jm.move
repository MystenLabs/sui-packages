module 0xdf7f9dd729715702780c1561f0d1cbd558ad772b5295b74594fc91cd3b8d26ca::jm {
    struct JM has drop {
        dummy_field: bool,
    }

    fun init(arg0: JM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JM>(arg0, 9, b"JM", b"JMaster ", b"JMaster is a governance token on the sui blochain which is promoted", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0aa12f33-17a7-4499-98d7-1fc12256199d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JM>>(v1);
    }

    // decompiled from Move bytecode v6
}

