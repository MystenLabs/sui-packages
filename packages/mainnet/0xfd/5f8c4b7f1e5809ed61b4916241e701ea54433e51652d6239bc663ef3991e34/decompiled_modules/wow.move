module 0xfd5f8c4b7f1e5809ed61b4916241e701ea54433e51652d6239bc663ef3991e34::wow {
    struct WOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOW>(arg0, 6, b"wow", b"woow", b"woww", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WOW>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOW>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

