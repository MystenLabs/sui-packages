module 0x1a90491d37869b9a2080948af4d2f5bc2ad39c387d75db005d6c2319f68c395f::lucid {
    struct LUCID has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCID>(arg0, 9, b"LUCID", b"Lucid Coin", b"A new token on the SUI blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LUCID>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCID>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUCID>>(v1);
    }

    // decompiled from Move bytecode v6
}

