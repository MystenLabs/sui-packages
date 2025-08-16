module 0xc8d1ea1276735bdcdd6a9e09f2302e44469d2afbb172e0065b174412520dadbb::wals2 {
    struct WALS2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALS2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALS2>(arg0, 9, b"WALS2", b"Walrus S2", b"Celebrating Walrus Season 2 for next week", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WALS2>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALS2>>(v2, @0xdf102285fd7a9fd8292f46f7632757d6ee5f175f67d2c4b70cafd2e2e04b3d56);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WALS2>>(v1);
    }

    // decompiled from Move bytecode v6
}

