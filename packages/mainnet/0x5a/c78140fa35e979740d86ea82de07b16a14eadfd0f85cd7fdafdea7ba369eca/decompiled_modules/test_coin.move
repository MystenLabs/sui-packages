module 0x5ac78140fa35e979740d86ea82de07b16a14eadfd0f85cd7fdafdea7ba369eca::test_coin {
    struct TEST_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TEST_COIN>, arg1: 0x2::coin::Coin<TEST_COIN>) {
        0x2::coin::burn<TEST_COIN>(arg0, arg1);
    }

    fun init(arg0: TEST_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_COIN>(arg0, 9, b"sTEST", b"SuiTESTCoin", b"Just a test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://n4eymquh3o3gtmjpzpr5jjikfuwn2n6b6v2lsxliep5c5ag6rcwa.arweave.net/bwmGQofbtmmxL8vj1KUKLSzdN8H1dLldaCP6LoDeiKw"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST_COIN>>(v1);
        0x2::coin::mint_and_transfer<TEST_COIN>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<TEST_COIN>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TEST_COIN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TEST_COIN>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

