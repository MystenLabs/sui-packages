module 0x3292469aceff06347834107ecd70382d65f351a23c3597ad2ddc1a3eaa016f82::qkc {
    struct QKC has drop {
        dummy_field: bool,
    }

    fun init(arg0: QKC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QKC>(arg0, 6, b"QKC", b"QUOKCOIN", b"One day, as Quincy was taking his daily selfie (because let's be honest, quokkas invented the selfie), a magical lightning bolt struck his smartphone. The screen flickered, glowed, and suddenly displayed a message: \"QUOKCOIN ACTIVATED - TO THE MOON! \"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiejs7jrmdilroxjkvd3bso5vf435rdjde4qq4s43ksn74ipksbxvu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QKC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<QKC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

