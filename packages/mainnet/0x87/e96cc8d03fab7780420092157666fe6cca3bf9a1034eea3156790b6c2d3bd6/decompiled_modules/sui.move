module 0x87e96cc8d03fab7780420092157666fe6cca3bf9a1034eea3156790b6c2d3bd6::sui {
    struct SUI has drop {
        dummy_field: bool,
    }

    struct TreasuryAccess has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<SUI>,
    }

    fun init(arg0: SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI>(arg0, 0, b"SUI", b"Sui", b"The native token for the Sui Protocol.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://imagedelivery.net/cBNDGgkrsEA-b_ixIp9SkQ/sui-coin.svg/public")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI>(&mut v2, 5000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI>>(v1);
        let v3 = TreasuryAccess{
            id           : 0x2::object::new(arg1),
            treasury_cap : v2,
        };
        0x2::transfer::share_object<TreasuryAccess>(v3);
    }

    // decompiled from Move bytecode v6
}

