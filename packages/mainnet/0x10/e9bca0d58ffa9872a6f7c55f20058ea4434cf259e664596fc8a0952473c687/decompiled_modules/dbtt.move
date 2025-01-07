module 0x10e9bca0d58ffa9872a6f7c55f20058ea4434cf259e664596fc8a0952473c687::dbtt {
    struct DBTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DBTT>(arg0, 6, b"DBTT", b"DON'T BUY THIS TOKEN", b"DON'T BUY THIS SH*T! DON'T BUY THIS SH*T! DON'T BUY THIS SH*T! DON'T BUY THIS SH*T! DON'T BUY THIS SH*T! DON'T BUY THIS SH*T! DON'T BUY THIS SH*T! DON'T BUY THIS SH*T! DON'T BUY THIS SH*T! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dbtt_2e1136860b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DBTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DBTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

