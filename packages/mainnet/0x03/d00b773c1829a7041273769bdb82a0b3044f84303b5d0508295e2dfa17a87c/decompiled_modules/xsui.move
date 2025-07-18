module 0x3d00b773c1829a7041273769bdb82a0b3044f84303b5d0508295e2dfa17a87c::xsui {
    struct XSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: XSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XSUI>(arg0, 9, b"xSUI", b"xSui", b"xSUI is a tokenized version of staked SUI. When users stake SUI via Momentum Finance, they receive xSUI in return, a liquid token that continuously accrues staking rewards while remaining usable across DeFi protocols.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://icons.llamao.fi/icons/protocols/xsui")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<XSUI>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

