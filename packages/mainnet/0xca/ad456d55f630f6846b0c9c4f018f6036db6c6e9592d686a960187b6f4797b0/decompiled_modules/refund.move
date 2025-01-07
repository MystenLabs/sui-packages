module 0xcaad456d55f630f6846b0c9c4f018f6036db6c6e9592d686a960187b6f4797b0::refund {
    struct REFUND has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<REFUND>, arg1: 0x2::coin::Coin<REFUND>) {
        0x2::coin::burn<REFUND>(arg0, arg1);
    }

    public entry fun custom_burn(arg0: &mut 0x2::coin::TreasuryCap<REFUND>, arg1: &mut 0x2::coin::Coin<REFUND>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<REFUND>(arg0, 0x2::coin::split<REFUND>(arg1, arg2, arg3));
    }

    fun init(arg0: REFUND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REFUND>(arg0, 6, b"RFD", b"RFD", b"REFUND on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://s2.coinmarketcap.com/static/img/coins/64x64/25754.png"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<REFUND>(&mut v2, 500000000000000000, @0xffed1e3a3b44c55d8a1300bf9ad7abb11825d45e66ab4bcadb5f7b5f4bce7d3a, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REFUND>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REFUND>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

