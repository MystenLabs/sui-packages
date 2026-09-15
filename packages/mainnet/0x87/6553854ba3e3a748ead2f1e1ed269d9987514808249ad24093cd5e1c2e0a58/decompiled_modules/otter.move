module 0x876553854ba3e3a748ead2f1e1ed269d9987514808249ad24093cd5e1c2e0a58::otter {
    struct OTTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTTER>(arg0, 6, b"OTTER", b"OTTER", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aggregator.walrus-testnet.walrus.space/v1/blobs/S5u29xlymtKpeSHkOsXo8eO8iR7s2J7AZhtVGqztsGs")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<OTTER>>(0x2::coin::mint<OTTER>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTTER>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OTTER>>(v1);
    }

    // decompiled from Move bytecode v7
}

