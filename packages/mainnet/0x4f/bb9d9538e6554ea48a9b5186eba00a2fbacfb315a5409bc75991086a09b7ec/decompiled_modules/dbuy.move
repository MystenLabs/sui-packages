module 0x4fbb9d9538e6554ea48a9b5186eba00a2fbacfb315a5409bc75991086a09b7ec::dbuy {
    struct DBUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DBUY>(arg0, 6, b"DBUY", b"Don't Buy", b"A meme token for the rebellious at heart! You know you shouldn't buy... but will you?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logodbuy_4f040aecbf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DBUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DBUY>>(v1);
    }

    // decompiled from Move bytecode v6
}

