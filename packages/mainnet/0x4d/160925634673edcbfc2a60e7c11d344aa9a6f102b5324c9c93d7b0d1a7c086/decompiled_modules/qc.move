module 0x4d160925634673edcbfc2a60e7c11d344aa9a6f102b5324c9c93d7b0d1a7c086::qc {
    struct QC has drop {
        dummy_field: bool,
    }

    fun init(arg0: QC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QC>(arg0, 6, b"QC", b"Quincy Coin", b"One day, as Quincy was taking his daily selfie (because let's be honest, quokkas invented the selfie), a magical lightning bolt struck his smartphone. The screen flickered, glowed, and suddenly displayed a message: \"QuincyCOIN ACTIVATED - TO THE MOON! \"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiejs7jrmdilroxjkvd3bso5vf435rdjde4qq4s43ksn74ipksbxvu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<QC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

