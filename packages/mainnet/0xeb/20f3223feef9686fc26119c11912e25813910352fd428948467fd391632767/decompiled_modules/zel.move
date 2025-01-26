module 0xeb20f3223feef9686fc26119c11912e25813910352fd428948467fd391632767::zel {
    struct ZEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZEL>(arg0, 9, b"ZEL", b"Zelenskyy ", b"President Zelensky's new token, in support of Ukraine", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/04972297-9540-4c84-8c15-49f813953ec2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

