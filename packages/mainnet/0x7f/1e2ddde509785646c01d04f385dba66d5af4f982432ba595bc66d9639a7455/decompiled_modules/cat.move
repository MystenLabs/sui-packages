module 0x7f1e2ddde509785646c01d04f385dba66d5af4f982432ba595bc66d9639a7455::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAT>(arg0, 9, b"CAT2", b"Sui Cat 2", b"Cute Sui Cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/KDZoIR9.md.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<CAT>>(0x2::coin::mint<CAT>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

