module 0xb5f1addfb35a38ebd1e82160120d1bfb5e3f4e4aa4f3b50c7013dd8625d06f3a::TRA {
    struct TRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRA>(arg0, 6, b"TRA", b"tralalelo tralala ", b"tralalero tralala, porco dio e porco Allah", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/Qma2HnhEY7U3uXuAvTxtnZq5gtJC9Nf7tLqFgGNkz6vwEf")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

