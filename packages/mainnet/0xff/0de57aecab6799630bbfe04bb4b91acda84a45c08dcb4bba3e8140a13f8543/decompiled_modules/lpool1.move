module 0xff0de57aecab6799630bbfe04bb4b91acda84a45c08dcb4bba3e8140a13f8543::lpool1 {
    struct LPOOL1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LPOOL1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LPOOL1>(arg0, 6, b"LPool1", b"lpl001", b"Lpl test coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Liverpool_1_9fd131183b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LPOOL1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LPOOL1>>(v1);
    }

    // decompiled from Move bytecode v6
}

