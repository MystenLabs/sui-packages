module 0x21ff1dab2e88188c80d5a4da8238cd07db165c138175554c7d2a29fa8e101baf::ugo {
    struct UGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: UGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UGO>(arg0, 9, b"UGO", b"Ugo Coin", b"Ugo coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<UGO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UGO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

