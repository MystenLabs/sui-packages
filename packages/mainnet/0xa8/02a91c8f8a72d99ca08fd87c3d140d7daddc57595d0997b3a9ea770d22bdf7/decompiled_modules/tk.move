module 0xa802a91c8f8a72d99ca08fd87c3d140d7daddc57595d0997b3a9ea770d22bdf7::tk {
    struct TK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TK>(arg0, 6, b"TK", b"Nahid ", b"Hard work ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/7qot6a_73ae0c16bf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TK>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TK>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

