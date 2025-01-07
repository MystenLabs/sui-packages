module 0xb63750db1b6beb5186f7d6a358bb075b4da30c6d37c8313b99f3fa3d586acc0d::pew {
    struct PEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEW>(arg0, 6, b"PEW", b"aaaPEW", b"It's all game, don't expect anything", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/324_20a31b4709.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

