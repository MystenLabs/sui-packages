module 0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::tpusd {
    struct TPUSD has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TPUSD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TPUSD>>(0x2::coin::mint<TPUSD>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TPUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TPUSD>(arg0, 6, 0x1::string::utf8(b"tpUSD"), 0x1::string::utf8(b"tpUSD"), 0x1::string::utf8(b"tpUSD is the stablecoin used inside trading pairs of taco protocol"), 0x1::string::utf8(b"https://example.com/my_coin.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TPUSD>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<TPUSD>>(0x2::coin_registry::finalize<TPUSD>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

