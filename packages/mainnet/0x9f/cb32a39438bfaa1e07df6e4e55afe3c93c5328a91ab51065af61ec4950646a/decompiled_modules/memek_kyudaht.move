module 0x9fcb32a39438bfaa1e07df6e4e55afe3c93c5328a91ab51065af61ec4950646a::memek_kyudaht {
    struct MEMEK_KYUDAHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEK_KYUDAHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEK_KYUDAHT>(arg0, 6, b"MEMEKKYUDAHT", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEK_KYUDAHT>>(v1);
        0x2::coin::mint_and_transfer<MEMEK_KYUDAHT>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEK_KYUDAHT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

