module 0xd25865f95354c14a9909422142d80c681b966553217d94f88dce17e739bfb6b8::suitc2 {
    struct SUITC2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITC2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITC2>(arg0, 9, b"SUITC2", b"Sui Test Coin2", b"Test coin2 for SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s2.coinmarketcap.com/static/img/coins/64x64/34888.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUITC2>(&mut v2, 2400000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITC2>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITC2>>(v1);
    }

    // decompiled from Move bytecode v6
}

