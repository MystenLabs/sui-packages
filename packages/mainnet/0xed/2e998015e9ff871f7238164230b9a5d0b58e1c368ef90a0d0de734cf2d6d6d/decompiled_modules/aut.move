module 0xed2e998015e9ff871f7238164230b9a5d0b58e1c368ef90a0d0de734cf2d6d6d::aut {
    struct AUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AUT>(arg0, 8, b"AUT", b"AUTISM", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s2.coinmarketcap.com/static/img/coins/64x64/25263.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AUT>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AUT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

