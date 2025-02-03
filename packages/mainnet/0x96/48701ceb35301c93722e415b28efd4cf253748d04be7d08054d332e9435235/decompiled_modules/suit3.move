module 0x9648701ceb35301c93722e415b28efd4cf253748d04be7d08054d332e9435235::suit3 {
    struct SUIT3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIT3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIT3>(arg0, 9, b"SUIT3", b"Sui Test Coin3.2", b"Test coin3.2 for SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s2.coinmarketcap.com/static/img/coins/64x64/30109.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIT3>(&mut v2, 2000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIT3>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIT3>>(v1);
    }

    // decompiled from Move bytecode v6
}

