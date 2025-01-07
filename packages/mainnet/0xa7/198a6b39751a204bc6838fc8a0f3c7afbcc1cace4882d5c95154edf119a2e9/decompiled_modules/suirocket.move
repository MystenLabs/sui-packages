module 0xa7198a6b39751a204bc6838fc8a0f3c7afbcc1cace4882d5c95154edf119a2e9::suirocket {
    struct SUIROCKET has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIROCKET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIROCKET>(arg0, 6, b"Suirocket", b"Sui rocket", b"Suiii rocket", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000906496_2cf3eb65a6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIROCKET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIROCKET>>(v1);
    }

    // decompiled from Move bytecode v6
}

