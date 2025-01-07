module 0x44e4a9908baed57c5d32ffd246f961534fc5e7387254406cce05f1c1542bb38d::op {
    struct OP has drop {
        dummy_field: bool,
    }

    fun init(arg0: OP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OP>(arg0, 9, b"OP", b"Aragon", b"Ajab sosise", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a1a49f6d-2887-47f8-8c05-893a80241a9f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OP>>(v1);
    }

    // decompiled from Move bytecode v6
}

