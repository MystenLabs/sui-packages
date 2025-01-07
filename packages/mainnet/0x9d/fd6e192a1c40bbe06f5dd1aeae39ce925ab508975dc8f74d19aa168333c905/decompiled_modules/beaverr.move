module 0x9dfd6e192a1c40bbe06f5dd1aeae39ce925ab508975dc8f74d19aa168333c905::beaverr {
    struct BEAVERR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEAVERR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEAVERR>(arg0, 6, b"BEAVERR", b"BEAVSUI", b"hello, i am beaverr. i am just passing through", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/500x500_24_766117eb17_1_542bf5d19e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEAVERR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEAVERR>>(v1);
    }

    // decompiled from Move bytecode v6
}

