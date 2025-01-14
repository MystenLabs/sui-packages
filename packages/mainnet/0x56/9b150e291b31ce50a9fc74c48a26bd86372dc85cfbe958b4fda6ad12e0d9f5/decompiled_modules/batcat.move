module 0x569b150e291b31ce50a9fc74c48a26bd86372dc85cfbe958b4fda6ad12e0d9f5::batcat {
    struct BATCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BATCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BATCAT>(arg0, 6, b"BATCAT", b"Batcat", b"Not all heroes wear whiskers. It's a cute Sui cat meme we all deserve.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736830670414.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BATCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BATCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

