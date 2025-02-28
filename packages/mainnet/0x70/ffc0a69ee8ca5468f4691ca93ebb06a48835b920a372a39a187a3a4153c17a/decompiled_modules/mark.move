module 0x70ffc0a69ee8ca5468f4691ca93ebb06a48835b920a372a39a187a3a4153c17a::mark {
    struct MARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARK>(arg0, 9, b"MARK", b"MarkCoin", b"A test token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MARK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

