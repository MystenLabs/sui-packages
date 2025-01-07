module 0x3a3d4f0ed382049b34f6d556a110f2f12bee9210fbba3cbe44917f187fb4b21d::srx {
    struct SRX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRX>(arg0, 6, b"SRX", b"SUIREX", b"rawwwrrrrrrrrrrrrrrrrrrrr", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/71aa154ce48518da913f35e7c8b215a0_3e1e82960c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRX>>(v1);
    }

    // decompiled from Move bytecode v6
}

