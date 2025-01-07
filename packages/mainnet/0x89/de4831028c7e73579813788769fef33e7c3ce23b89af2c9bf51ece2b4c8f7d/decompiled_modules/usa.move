module 0x89de4831028c7e73579813788769fef33e7c3ce23b89af2c9bf51ece2b4c8f7d::usa {
    struct USA has drop {
        dummy_field: bool,
    }

    fun init(arg0: USA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USA>(arg0, 9, b"USA", b"USA", b"USA Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<USA>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USA>>(v1);
    }

    // decompiled from Move bytecode v6
}

