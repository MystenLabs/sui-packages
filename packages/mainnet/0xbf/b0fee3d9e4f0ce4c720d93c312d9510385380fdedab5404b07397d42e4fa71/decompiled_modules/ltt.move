module 0xbfb0fee3d9e4f0ce4c720d93c312d9510385380fdedab5404b07397d42e4fa71::ltt {
    struct LTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LTT>(arg0, 9, b"LTT", b"Large Token", b"a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LTT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LTT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

