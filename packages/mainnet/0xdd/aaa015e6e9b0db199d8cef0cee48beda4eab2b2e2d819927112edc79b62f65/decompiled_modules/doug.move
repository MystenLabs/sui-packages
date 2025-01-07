module 0xddaaa015e6e9b0db199d8cef0cee48beda4eab2b2e2d819927112edc79b62f65::doug {
    struct DOUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOUG>(arg0, 9, b"DOUG", b"DOUGTHEDUCK", b"cool", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_banners/1788231401025761280/1719649722/1500x500")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOUG>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOUG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

