module 0x30fe92063eaf1fcff7281a9f4a34f03485e5a3af382dc1f11fd0a7830e1f70d2::xxx {
    struct XXX has drop {
        dummy_field: bool,
    }

    fun init(arg0: XXX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XXX>(arg0, 9, b"XXX", b"XXX", b"XXX Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<XXX>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XXX>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XXX>>(v1);
    }

    // decompiled from Move bytecode v6
}

