module 0x55a3cc35b252e9faf48dd4374c226f370c17a7f20c46f36568af3a204cf2fa03::funm {
    struct FUNM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUNM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUNM>(arg0, 6, b"FUNM", b"FUNFUNM", b"efwef", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/HJ_d0abde653b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUNM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUNM>>(v1);
    }

    // decompiled from Move bytecode v6
}

