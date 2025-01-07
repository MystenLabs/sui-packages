module 0x27b60aed4ec7c19ea8ad9d14d78b57aab1a8f75d983626e5a29e0972adb3057::testairdrop {
    struct TESTAIRDROP has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TESTAIRDROP>, arg1: vector<0x2::coin::Coin<TESTAIRDROP>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<TESTAIRDROP>>(&mut arg1);
        0x2::pay::join_vec<TESTAIRDROP>(&mut v0, arg1);
        0x2::coin::burn<TESTAIRDROP>(arg0, 0x2::coin::split<TESTAIRDROP>(&mut v0, arg2, arg3));
        if (0x2::coin::value<TESTAIRDROP>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<TESTAIRDROP>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<TESTAIRDROP>(v0);
        };
    }

    fun init(arg0: TESTAIRDROP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TESTAIRDROP>(arg0, 9, b"TAIR", b"TESTAIRDROP", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = v1;
        0x2::coin::mint_and_transfer<TESTAIRDROP>(&mut v3, 1000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTAIRDROP>>(v3, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTAIRDROP>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TESTAIRDROP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TESTAIRDROP>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<TESTAIRDROP>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TESTAIRDROP>>(arg0);
    }

    // decompiled from Move bytecode v6
}

