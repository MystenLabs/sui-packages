module 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::xbird {
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

    struct BirdPegVault<phantom T0> has store, key {
        id: 0x2::object::UID,
        treasureCap: 0x2::coin::TreasuryCap<T0>,
    }

    struct ValidatorVault has store, key {
        id: 0x2::object::UID,
        validator: 0x1::option::Option<vector<u8>>,
    }

    public(friend) fun borrowMutTreasure<T0>(arg0: &mut BirdPegVault<T0>) : &mut 0x2::coin::TreasuryCap<T0> {
        &mut arg0.treasureCap
    }

    public(friend) fun borrowTreasure(arg0: &BirdPegVault<XBIRD>) : &0x2::coin::TreasuryCap<XBIRD> {
        &arg0.treasureCap
    }

    fun createPegToken<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 6, b"XBIRD", b"XBIRD", b"managed version of XBIRD", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    public fun depositToken(arg0: vector<u8>, arg1: vector<u8>, arg2: &ValidatorVault, arg3: &mut BirdPegVault<XBIRD>, arg4: &mut 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::archieve::UserArchieve, arg5: &0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version::checkVersion(arg5, 1);
        0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::archieve::verifySignature(arg0, arg1, &arg2.validator);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::bcs::new(arg1);
        let v2 = 0x2::bcs::peel_u64(&mut v1);
        let v3 = 0x2::bcs::peel_u128(&mut v1);
        assert!(0x2::bcs::peel_address(&mut v1) == v0, 1001);
        assert!(v2 > 0, 1002);
        0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::archieve::verUpdateTokenPegNonce(v3, arg4);
        let v4 = borrowMutTreasure<XBIRD>(arg3);
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<XBIRD>(borrowMutTreasure<XBIRD>(arg3), 0x2::token::transfer<XBIRD>(0x2::token::mint<XBIRD>(v4, v2, arg6), v0, arg6), arg6);
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
        let v1 = BirdPegVault<XBIRD>{
            id          : 0x2::object::new(arg1),
            treasureCap : v0,
        };
        0x2::transfer::public_share_object<BirdPegVault<XBIRD>>(v1);
        let v2 = ValidatorVault{
            id        : 0x2::object::new(arg1),
            validator : 0x1::option::none<vector<u8>>(),
        };
        0x2::transfer::public_share_object<ValidatorVault>(v2);
        let v3 = BAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<BAdminCap>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun setValidator(arg0: &BAdminCap, arg1: vector<u8>, arg2: &mut ValidatorVault, arg3: &0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version::Version) {
        0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version::checkVersion(arg3, 1);
        0x1::option::swap_or_fill<vector<u8>>(&mut arg2.validator, arg1);
    }

    public fun withdrawToken(arg0: &mut BirdPegVault<XBIRD>, arg1: &mut 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::archieve::UserArchieve, arg2: 0x2::token::Token<XBIRD>, arg3: &0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version::checkVersion(arg3, 1);
        let v0 = WithdrawToken{
            owner  : 0x2::tx_context::sender(arg4),
            amount : 0x2::token::value<XBIRD>(&arg2),
            type   : 0x1::type_name::get<XBIRD>(),
            nonce  : 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::archieve::increaseGetTokenDepegNonce(arg1),
        };
        0x2::event::emit<WithdrawToken>(v0);
        0x2::token::burn<XBIRD>(borrowMutTreasure<XBIRD>(arg0), arg2);
    }

    // decompiled from Move bytecode v6
}

