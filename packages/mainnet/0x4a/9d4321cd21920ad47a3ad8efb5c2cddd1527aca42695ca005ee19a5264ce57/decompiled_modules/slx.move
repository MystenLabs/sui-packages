module 0x8ad3212f307a477cbf282b81b93da5de637adc6e223a998223a6266f9d7a8abc::slx {
    struct SLX has drop {
        dummy_field: bool,
    }

    public entry fun batch_airdrop(arg0: 0x2::coin::Coin<SLX>, arg1: vector<address>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SLX>>(0x2::coin::split<SLX>(&mut arg0, arg2, arg3), *0x1::vector::borrow<address>(&arg1, v0));
            v0 = v0 + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<SLX>>(arg0, 0x2::tx_context::sender(arg3));
    }

    fun init(arg0: SLX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLX>(arg0, 9, b"SLX", b"SLX", b"SLX Token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SLX>>(0x2::coin::mint<SLX>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SLX>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLX>>(v1);
    }

    // decompiled from Move bytecode v7
}

