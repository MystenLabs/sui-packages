module 0x973717040ff267c3e3a2fbadf42e1f0147ed2ad5aa73d7e6941cf2be2a082c08::bemindful {
    struct BEMINDFUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEMINDFUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEMINDFUL>(arg0, 6, b"BEMINDFUL", b"Very Demure,Mindful", x"596f752073656520686f77204920646f206d616b6520757020666f7220776f726b3f20566572792044656d757265212056657279204d696e6466756c212053656520686f772049206c6f6f6b20766572792070726573656e7461626c653f204f6e6c792061206c6974746c652063686920636869206f7574206e6f742063686f2063686f2e200a0a4966207468697320746f6b656e20676f65732075702c2049276c6c2062652076657279207265737065637466756c20627920646f6e6174696e67206d6f6e74686c792120566572792044656d757265205665727920437574657379212056657279204d696e6466756c21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732685141692.21")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEMINDFUL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEMINDFUL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

