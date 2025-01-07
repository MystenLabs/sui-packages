module 0xbae9635e57ea40883f3fb13e69529deb76d5b9a1c98b575130019ce4f6fa28d8::patience {
    struct PATIENCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PATIENCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PATIENCE>(arg0, 6, b"PATIENCE", b"PatienceOnSui", x"5468652050726f6f66206f662050617469656e636520436f696e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241009_030729_f998d9d79a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PATIENCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PATIENCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

