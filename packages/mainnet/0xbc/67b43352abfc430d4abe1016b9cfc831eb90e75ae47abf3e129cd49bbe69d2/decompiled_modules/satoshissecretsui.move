module 0xbc67b43352abfc430d4abe1016b9cfc831eb90e75ae47abf3e129cd49bbe69d2::satoshissecretsui {
    struct SATOSHISSECRETSUI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SATOSHISSECRETSUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SATOSHISSECRETSUI>>(0x2::coin::mint<SATOSHISSECRETSUI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SATOSHISSECRETSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATOSHISSECRETSUI>(arg0, 9, b"SATOSHIS SECRET SUI", b"SATOSHI", b"Satoshi secret in SUI", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SATOSHISSECRETSUI>>(0x2::coin::mint<SATOSHISSECRETSUI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATOSHISSECRETSUI>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SATOSHISSECRETSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

