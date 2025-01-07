module 0x4e292dbf2c1691ea5ebe198189a54fe643e634be7502afb579b63ffaf8084241::al {
    struct AL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AL>(arg0, 9, b"AL", b"Qa", b"Qp", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e0208b75-f782-4c25-9909-ccd5372ce98b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AL>>(v1);
    }

    // decompiled from Move bytecode v6
}

