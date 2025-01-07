module 0xab4cca0b1f520a8ffb37a276669e4fe231a5e0677a2e28e49c133cc00bc67f40::deleted {
    struct DELETED has drop {
        dummy_field: bool,
    }

    fun init(arg0: DELETED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DELETED>(arg0, 6, b"DELETED", b"DELETED ACCOUNT", b"123456 deleted", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3640a5fe598c887fcb2bf67b72dabe89_f14f01ef2c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DELETED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DELETED>>(v1);
    }

    // decompiled from Move bytecode v6
}

