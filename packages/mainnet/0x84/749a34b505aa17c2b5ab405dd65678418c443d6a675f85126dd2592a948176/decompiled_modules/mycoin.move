module 0x84749a34b505aa17c2b5ab405dd65678418c443d6a675f85126dd2592a948176::mycoin {
    struct MYCOIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MYCOIN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MYCOIN>>(0x2::coin::mint<MYCOIN>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun transfer(arg0: 0x2::coin::TreasuryCap<MYCOIN>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYCOIN>>(arg0, arg1);
    }

    public entry fun batchTransfer(arg0: &mut 0x2::coin::Coin<MYCOIN>, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        loop {
            if (v0 == 0x1::vector::length<address>(&arg1)) {
                break
            };
            v0 = v0 + 1;
            0x2::transfer::public_transfer<0x2::coin::Coin<MYCOIN>>(0x2::coin::split<MYCOIN>(arg0, 1000000, arg2), 0x1::vector::pop_back<address>(&mut arg1));
        };
    }

    public entry fun batchTransferCoin<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        loop {
            if (v0 == 0x1::vector::length<address>(&arg1)) {
                break
            };
            v0 = v0 + 1;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, 1000000, arg2), 0x1::vector::pop_back<address>(&mut arg1));
        };
    }

    public fun batchTransferNoEntry(arg0: &mut 0x2::coin::Coin<MYCOIN>, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        loop {
            if (v0 == 0x1::vector::length<address>(&arg1)) {
                break
            };
            v0 = v0 + 1;
            0x2::transfer::public_transfer<0x2::coin::Coin<MYCOIN>>(0x2::coin::split<MYCOIN>(arg0, 1000000, arg2), 0x1::vector::pop_back<address>(&mut arg1));
        };
    }

    fun init(arg0: MYCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYCOIN>(arg0, 6, b"MYCOIN", b"MYCoin", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

