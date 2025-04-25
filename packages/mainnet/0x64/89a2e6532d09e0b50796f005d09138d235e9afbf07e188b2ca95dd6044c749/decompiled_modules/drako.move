module 0x6489a2e6532d09e0b50796f005d09138d235e9afbf07e188b2ca95dd6044c749::drako {
    struct DRAKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAKO>(arg0, 6, b"Drako", b"Drako Sui", b"https://t.me/drakosui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6107_ec2c50e02c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRAKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

