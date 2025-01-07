module 0x63f2100436bfceb736b299f84f2d3a39ed17bba7b4d957753d3f8c07ec8f46aa::hcat {
    struct HCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HCAT>(arg0, 6, b"Hcat", b"Happy Cat", b"Chinese Zilai Feng", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4103473bfb7c1ac3003cfd46a2249304_4e63294488.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

