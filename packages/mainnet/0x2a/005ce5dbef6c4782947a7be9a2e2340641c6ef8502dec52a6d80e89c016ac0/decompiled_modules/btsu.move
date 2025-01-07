module 0x2a005ce5dbef6c4782947a7be9a2e2340641c6ef8502dec52a6d80e89c016ac0::btsu {
    struct BTSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTSU>(arg0, 6, b"BTSU", b"Bubble tea", b"Bubble tea Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_1_ce39866264.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

