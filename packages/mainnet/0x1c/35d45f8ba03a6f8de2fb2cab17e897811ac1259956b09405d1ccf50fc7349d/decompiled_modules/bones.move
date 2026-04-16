module 0x1c35d45f8ba03a6f8de2fb2cab17e897811ac1259956b09405d1ccf50fc7349d::bones {
    struct BONES has drop {
        dummy_field: bool,
    }

    struct BonesTreasury has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<BONES>,
    }

    public fun total_supply(arg0: &BonesTreasury) : u64 {
        0x2::coin::total_supply<BONES>(&arg0.treasury_cap)
    }

    fun init(arg0: BONES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONES>(arg0, 0, b"BONES", b"Skelsui BONES", b"Closed-loop loyalty token for Skelsui staking rewards", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        let (v3, v4) = 0x2::token::new_policy<BONES>(&v2, arg1);
        0x2::token::share_policy<BONES>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BONES>>(v1);
        let v5 = BonesTreasury{
            id           : 0x2::object::new(arg1),
            treasury_cap : v2,
        };
        0x2::transfer::share_object<BonesTreasury>(v5);
        0x2::transfer::public_transfer<0x2::token::TokenPolicyCap<BONES>>(v4, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun mint_to_recipient(arg0: &mut BonesTreasury, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg1 == 0) {
            return
        };
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<BONES>(&mut arg0.treasury_cap, 0x2::token::transfer<BONES>(0x2::token::mint<BONES>(&mut arg0.treasury_cap, arg1, arg3), arg2, arg3), arg3);
    }

    public fun spend_exact(arg0: &mut BonesTreasury, arg1: 0x2::token::Token<BONES>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::token::value<BONES>(&arg1);
        assert!(v0 >= arg2, 0);
        if (v0 > arg2) {
            0x2::token::keep<BONES>(0x2::token::split<BONES>(&mut arg1, v0 - arg2, arg3), arg3);
        };
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<BONES>(&mut arg0.treasury_cap, 0x2::token::spend<BONES>(arg1, arg3), arg3);
    }

    // decompiled from Move bytecode v7
}

