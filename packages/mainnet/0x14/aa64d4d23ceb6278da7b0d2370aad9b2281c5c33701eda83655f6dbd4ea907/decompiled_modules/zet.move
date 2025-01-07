module 0x14aa64d4d23ceb6278da7b0d2370aad9b2281c5c33701eda83655f6dbd4ea907::zet {
    struct ZET has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZET>(arg0, 9, b"ZET", b"Zcoin", b"This token brings power from God", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a9473d94-e3ee-46a3-a31a-9e25a40f63cc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZET>>(v1);
    }

    // decompiled from Move bytecode v6
}

