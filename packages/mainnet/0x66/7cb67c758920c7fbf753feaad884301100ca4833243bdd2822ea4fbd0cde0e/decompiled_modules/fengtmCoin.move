module 0x667cb67c758920c7fbf753feaad884301100ca4833243bdd2822ea4fbd0cde0e::fengtmCoin {
    struct FENGTMCOIN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<FENGTMCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FENGTMCOIN>>(0x2::coin::mint<FENGTMCOIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: FENGTMCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FENGTMCOIN>(arg0, 6, b"FENGTMCOIN", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FENGTMCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FENGTMCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

