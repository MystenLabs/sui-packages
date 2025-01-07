module 0x6aeb5571d21c3917fc329f35dc03342eab6e72639e2d8883a39620f3dff33d34::dragon {
    struct DRAGON has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAGON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAGON>(arg0, 1, b"DRAGON", b"DRAGON", b"DRAGO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DRAGON>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAGON>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRAGON>>(v1);
    }

    // decompiled from Move bytecode v6
}

