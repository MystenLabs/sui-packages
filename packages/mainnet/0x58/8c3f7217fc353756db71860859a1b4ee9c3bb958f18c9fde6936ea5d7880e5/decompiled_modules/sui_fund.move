module 0x588c3f7217fc353756db71860859a1b4ee9c3bb958f18c9fde6936ea5d7880e5::sui_fund {
    struct SUI_FUND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_FUND, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 831 || 0x2::tx_context::epoch(arg1) == 832, 1);
        let (v0, v1) = 0x2::coin::create_currency<SUI_FUND>(arg0, 9, b"SuiF", b"Sui Fund", b"SuiF the crypto backed, rwa fund on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.filebase.io/ipfs/Qma5zHn44JAJRY5SjuWXBLhVA88gct2xt53uWAGfu6yBkQ"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI_FUND>(&mut v2, 10000000000000000, @0x55120a0ece1eff44f12cf292f99f054f5858f2f8e4d3255f33f92ce4defa267f, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_FUND>>(v2, @0x55120a0ece1eff44f12cf292f99f054f5858f2f8e4d3255f33f92ce4defa267f);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUI_FUND>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

