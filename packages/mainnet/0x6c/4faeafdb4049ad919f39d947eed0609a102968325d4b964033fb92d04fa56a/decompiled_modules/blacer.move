module 0x6c4faeafdb4049ad919f39d947eed0609a102968325d4b964033fb92d04fa56a::blacer {
    struct BLACER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLACER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLACER>(arg0, 6, b"BLACER", b"Sem Blacer", b"Sem Blacer, da cofonder of Mysten Lobs, chef tecnologi offizzer of Sui Netwerk, fonder of Move", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logoo_f8ad8b8787.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLACER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLACER>>(v1);
    }

    // decompiled from Move bytecode v6
}

