module 0xb4e9ceb5c7ec37743ecac3f43df400b14dce708fd48fc6976781889508581051::bigbang {
    struct BIGBANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIGBANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIGBANG>(arg0, 6, b"BigBang", b"BigBangSui", b"\"The Biggest Bang After the Big Bang: Our Coin!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tengriiii_3b112f9a06.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIGBANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIGBANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

