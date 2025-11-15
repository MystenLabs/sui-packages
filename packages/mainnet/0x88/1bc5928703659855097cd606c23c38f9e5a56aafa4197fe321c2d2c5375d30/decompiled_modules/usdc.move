module 0x881bc5928703659855097cd606c23c38f9e5a56aafa4197fe321c2d2c5375d30::usdc {
    struct USDC has drop {
        dummy_field: bool,
    }

    struct TransferEvent has copy, drop {
        from: address,
        to: address,
        amount: u64,
        fee_amount: u64,
        net_amount: u64,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<USDC>, arg1: 0x2::coin::Coin<USDC>) {
        0x2::coin::burn<USDC>(arg0, arg1);
    }

    fun init(arg0: USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDC>(arg0, 6, b"USDC", b"USD Coin", b"SuiTips USDC - Tipping Token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDC>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<USDC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<USDC>(arg0, arg1, arg2, arg3);
    }

    public fun transfer_no_fee(arg0: 0x2::coin::Coin<USDC>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<USDC>>(arg0, arg1);
    }

    public fun transfer_with_fee(arg0: 0x2::coin::Coin<USDC>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<USDC>(&arg0);
        let v1 = v0 * 150 / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<USDC>>(0x2::coin::split<USDC>(&mut arg0, v1, arg2), @0x242524d0967f2a7b6d8302e64472bb14be1f2d6d5550451ae0e52c13ee7a9c52);
        0x2::transfer::public_transfer<0x2::coin::Coin<USDC>>(arg0, arg1);
        let v2 = TransferEvent{
            from       : 0x2::tx_context::sender(arg2),
            to         : arg1,
            amount     : v0,
            fee_amount : v1,
            net_amount : v0 - v1,
        };
        0x2::event::emit<TransferEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

