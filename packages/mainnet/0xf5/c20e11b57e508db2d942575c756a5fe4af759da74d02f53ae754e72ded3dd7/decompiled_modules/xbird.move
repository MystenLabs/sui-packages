module 0xf5c20e11b57e508db2d942575c756a5fe4af759da74d02f53ae754e72ded3dd7::xbird {
    struct XBIRD has drop {
        dummy_field: bool,
    }

    struct BAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct WithdrawToken has copy, drop {
        owner: address,
        amount: u64,
        type: 0x1::type_name::TypeName,
        nonce: u128,
    }

    struct TokenDeposit has copy, drop {
        owner: address,
        amount: u64,
        type: 0x1::type_name::TypeName,
        nonce: u128,
    }

    struct BirdPegVault has store, key {
        id: 0x2::object::UID,
        treasureCap: 0x2::coin::TreasuryCap<XBIRD>,
        validator: 0x1::option::Option<vector<u8>>,
    }

    struct PegTokenReq has copy, store {
        owner: address,
        amount: u64,
        nonce: u128,
    }

    public(friend) fun borrowMutTreasure(arg0: &mut BirdPegVault) : &mut 0x2::coin::TreasuryCap<XBIRD> {
        &mut arg0.treasureCap
    }

    public(friend) fun borrowTreasure(arg0: &BirdPegVault) : &0x2::coin::TreasuryCap<XBIRD> {
        &arg0.treasureCap
    }

    fun createPegToken<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 6, b"XBIRD", b"XBIRD", b"managed version of XBIRD", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    public fun depositToken(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut BirdPegVault, arg3: &mut 0xf5c20e11b57e508db2d942575c756a5fe4af759da74d02f53ae754e72ded3dd7::archieve::UserArchieve, arg4: &0xf5c20e11b57e508db2d942575c756a5fe4af759da74d02f53ae754e72ded3dd7::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xf5c20e11b57e508db2d942575c756a5fe4af759da74d02f53ae754e72ded3dd7::archieve::verifySignature(arg0, arg1, &mut arg2.validator);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::bcs::new(arg1);
        let v2 = 0x2::bcs::peel_u64(&mut v1);
        let v3 = 0x2::bcs::peel_u128(&mut v1);
        assert!(0x2::bcs::peel_address(&mut v1) == v0, 2003);
        assert!(v2 > 0, 2004);
        0xf5c20e11b57e508db2d942575c756a5fe4af759da74d02f53ae754e72ded3dd7::archieve::verUpdateTokenPegNonce(v3, arg3);
        let v4 = borrowMutTreasure(arg2);
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<XBIRD>(borrowMutTreasure(arg2), 0x2::token::transfer<XBIRD>(0x2::token::mint<XBIRD>(v4, v2, arg5), v0, arg5), arg5);
        let v9 = TokenDeposit{
            owner  : v0,
            amount : v2,
            type   : 0x1::type_name::get<XBIRD>(),
            nonce  : v3,
        };
        0x2::event::emit<TokenDeposit>(v9);
    }

    fun init(arg0: XBIRD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = createPegToken<XBIRD>(arg0, arg1);
        let v1 = BirdPegVault{
            id          : 0x2::object::new(arg1),
            treasureCap : v0,
            validator   : 0x1::option::none<vector<u8>>(),
        };
        0x2::transfer::public_share_object<BirdPegVault>(v1);
        let v2 = BAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<BAdminCap>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun setValidator(arg0: &BAdminCap, arg1: vector<u8>, arg2: &mut BirdPegVault, arg3: &0xf5c20e11b57e508db2d942575c756a5fe4af759da74d02f53ae754e72ded3dd7::version::Version) {
        0x1::option::swap_or_fill<vector<u8>>(&mut arg2.validator, arg1);
    }

    public fun withdrawToken(arg0: &mut BirdPegVault, arg1: &mut 0xf5c20e11b57e508db2d942575c756a5fe4af759da74d02f53ae754e72ded3dd7::archieve::UserArchieve, arg2: 0x2::token::Token<XBIRD>, arg3: &0xf5c20e11b57e508db2d942575c756a5fe4af759da74d02f53ae754e72ded3dd7::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = WithdrawToken{
            owner  : 0x2::tx_context::sender(arg4),
            amount : 0x2::token::value<XBIRD>(&arg2),
            type   : 0x1::type_name::get<XBIRD>(),
            nonce  : 0xf5c20e11b57e508db2d942575c756a5fe4af759da74d02f53ae754e72ded3dd7::archieve::increaseGetTokenDepegNonce(arg1),
        };
        0x2::event::emit<WithdrawToken>(v0);
        0x2::token::burn<XBIRD>(borrowMutTreasure(arg0), arg2);
    }

    // decompiled from Move bytecode v6
}

