module 0x5f15c3404c4100e2a3f30a42defbe56cab10dab01f5076423569ea9407ca5e43::svac {
    struct SVAC has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SVAC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 0);
        assert!(arg1 <= 1000000000000, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SVAC>>(0x2::coin::mint<SVAC>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SVAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SVAC>(arg0, 9, b"SVAC", b"Social Value Activity Coin", b"Social Value Activity Coin (SVAC) - Fixing the way we all live our lives. The genesis version of a token designed to empower a worldwide social economy. Learn more at svac.com", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SVAC>>(0x2::coin::mint<SVAC>(&mut v2, 100000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SVAC>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SVAC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

