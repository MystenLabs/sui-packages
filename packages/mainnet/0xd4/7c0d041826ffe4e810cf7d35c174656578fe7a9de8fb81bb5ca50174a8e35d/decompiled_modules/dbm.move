module 0xd47c0d041826ffe4e810cf7d35c174656578fe7a9de8fb81bb5ca50174a8e35d::dbm {
    struct DBM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DBM>(arg0, 6, b"DBM", b"Don't buy MeMe", b"memes are for smart people only", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7bd937da_9c62_4e76_96c7_3aa62a7eb522_c896b21cf2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DBM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DBM>>(v1);
    }

    // decompiled from Move bytecode v6
}

