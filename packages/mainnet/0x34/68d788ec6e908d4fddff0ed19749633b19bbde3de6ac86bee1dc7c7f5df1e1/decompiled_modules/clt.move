module 0x3468d788ec6e908d4fddff0ed19749633b19bbde3de6ac86bee1dc7c7f5df1e1::clt {
    struct CLT has drop {
        dummy_field: bool,
    }

    struct CltAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct CltWithdrawn has copy, drop {
        token: 0x1::ascii::String,
        owner: address,
        nonce: u128,
        balance: u64,
    }

    struct CltDeposited has copy, drop {
        token: 0x1::ascii::String,
        owner: address,
        nonce: u128,
        balance: u64,
        total_deposit: u64,
    }

    struct CltVault<phantom T0> has store, key {
        id: 0x2::object::UID,
        owner: 0x2::object::ID,
        treasureCap: 0x2::coin::TreasuryCap<T0>,
        metadata: 0x2::coin::CoinMetadata<T0>,
        validator: 0x1::option::Option<vector<u8>>,
        burn_nonce: u128,
    }

    struct DepositProof {
        owner: address,
        balance: u64,
    }

    public fun createClt<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: 0x2::coin::CoinMetadata<T0>, arg2: &0x3468d788ec6e908d4fddff0ed19749633b19bbde3de6ac86bee1dc7c7f5df1e1::version::Version, arg3: &mut 0x2::tx_context::TxContext) : CltAdminCap {
        0x3468d788ec6e908d4fddff0ed19749633b19bbde3de6ac86bee1dc7c7f5df1e1::version::checkVersion(arg2, 1);
        let v0 = CltAdminCap{id: 0x2::object::new(arg3)};
        let v1 = CltVault<T0>{
            id          : 0x2::object::new(arg3),
            owner       : 0x2::object::id<CltAdminCap>(&v0),
            treasureCap : arg0,
            metadata    : arg1,
            validator   : 0x1::option::none<vector<u8>>(),
            burn_nonce  : 0,
        };
        0x2::transfer::public_share_object<CltVault<T0>>(v1);
        0xf44ef9b87dd2bbeff1905dc35f41f607bf43e0811f1753b874a0e0f4c0ec705c::cap_vault::createVault<CltAdminCap>(arg3);
        v0
    }

    public fun depositToken<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut CltVault<T0>, arg3: &mut 0xf44ef9b87dd2bbeff1905dc35f41f607bf43e0811f1753b874a0e0f4c0ec705c::archieve::UserArchieve, arg4: &0x3468d788ec6e908d4fddff0ed19749633b19bbde3de6ac86bee1dc7c7f5df1e1::version::Version, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, DepositProof) {
        0x3468d788ec6e908d4fddff0ed19749633b19bbde3de6ac86bee1dc7c7f5df1e1::version::checkVersion(arg4, 1);
        0xf44ef9b87dd2bbeff1905dc35f41f607bf43e0811f1753b874a0e0f4c0ec705c::archieve::verifySignature(arg0, arg1, &arg2.validator);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::bcs::new(arg1);
        let v2 = 0x2::bcs::peel_u64(&mut v1);
        let v3 = 0x2::bcs::peel_u128(&mut v1);
        assert!(0x2::bcs::peel_address(&mut v1) == v0, 1001);
        assert!(v2 > 0, 1002);
        assert!(0x2::bcs::peel_u64(&mut v1) > 0x2::clock::timestamp_ms(arg5), 1004);
        0xf44ef9b87dd2bbeff1905dc35f41f607bf43e0811f1753b874a0e0f4c0ec705c::archieve::verUpdateTokenPegNonce(v3, arg3);
        let v4 = DepositProof{
            owner   : v0,
            balance : v2,
        };
        let v5 = CltDeposited{
            token         : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            owner         : v0,
            nonce         : v3,
            balance       : v2,
            total_deposit : 0xf44ef9b87dd2bbeff1905dc35f41f607bf43e0811f1753b874a0e0f4c0ec705c::archieve::increaseTotalDeposit(v2, arg3),
        };
        0x2::event::emit<CltDeposited>(v5);
        (0x2::coin::mint_balance<T0>(treasureMut<T0>(arg2), v2), v4)
    }

    public fun depositTokenForOrder<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: &mut CltVault<T0>, arg4: &mut 0xf44ef9b87dd2bbeff1905dc35f41f607bf43e0811f1753b874a0e0f4c0ec705c::archieve::UserArchieve, arg5: &0x3468d788ec6e908d4fddff0ed19749633b19bbde3de6ac86bee1dc7c7f5df1e1::version::Version, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, DepositProof, u128) {
        0x3468d788ec6e908d4fddff0ed19749633b19bbde3de6ac86bee1dc7c7f5df1e1::version::checkVersion(arg5, 1);
        0xf44ef9b87dd2bbeff1905dc35f41f607bf43e0811f1753b874a0e0f4c0ec705c::archieve::verifySignature(arg0, arg1, &arg3.validator);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::bcs::new(arg1);
        let v2 = 0x2::bcs::peel_u64(&mut v1);
        let v3 = 0x2::bcs::peel_u128(&mut v1);
        assert!(arg2 == 0x2::bcs::peel_u64(&mut v1), 1007);
        assert!(0x2::bcs::peel_address(&mut v1) == v0, 1001);
        assert!(v2 > 0, 1002);
        assert!(0x2::bcs::peel_u64(&mut v1) > 0x2::clock::timestamp_ms(arg6), 1004);
        0xf44ef9b87dd2bbeff1905dc35f41f607bf43e0811f1753b874a0e0f4c0ec705c::archieve::verUpdateTokenPegNonce(v3, arg4);
        let v4 = DepositProof{
            owner   : v0,
            balance : v2,
        };
        let v5 = CltDeposited{
            token         : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            owner         : v0,
            nonce         : v3,
            balance       : v2,
            total_deposit : 0xf44ef9b87dd2bbeff1905dc35f41f607bf43e0811f1753b874a0e0f4c0ec705c::archieve::increaseTotalDeposit(v2, arg4),
        };
        0x2::event::emit<CltDeposited>(v5);
        (0x2::coin::mint_balance<T0>(treasureMut<T0>(arg3), v2), v4, 0x2::bcs::peel_u128(&mut v1))
    }

    fun init(arg0: CLT, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public fun setValidator<T0>(arg0: &CltAdminCap, arg1: vector<u8>, arg2: &mut CltVault<T0>, arg3: &0x3468d788ec6e908d4fddff0ed19749633b19bbde3de6ac86bee1dc7c7f5df1e1::version::Version) {
        0x3468d788ec6e908d4fddff0ed19749633b19bbde3de6ac86bee1dc7c7f5df1e1::version::checkVersion(arg3, 1);
        assert!(arg2.owner == 0x2::object::id<CltAdminCap>(arg0), 1001);
        0x1::option::swap_or_fill<vector<u8>>(&mut arg2.validator, arg1);
    }

    fun treasureMut<T0>(arg0: &mut CltVault<T0>) : &mut 0x2::coin::TreasuryCap<T0> {
        &mut arg0.treasureCap
    }

    public fun verifyDepositProof<T0>(arg0: &0x2::balance::Balance<T0>, arg1: DepositProof) {
        assert!(0x2::balance::value<T0>(arg0) == arg1.balance, 1003);
        let DepositProof {
            owner   : _,
            balance : _,
        } = arg1;
    }

    public(friend) fun withdrawTo<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut CltVault<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<T0>(&mut arg2.treasureCap, 0x2::coin::from_balance<T0>(arg0, arg3));
        arg2.burn_nonce = arg2.burn_nonce + 1;
        let v0 = CltWithdrawn{
            token   : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            owner   : arg1,
            nonce   : arg2.burn_nonce,
            balance : 0x2::balance::value<T0>(&arg0),
        };
        0x2::event::emit<CltWithdrawn>(v0);
    }

    // decompiled from Move bytecode v6
}

