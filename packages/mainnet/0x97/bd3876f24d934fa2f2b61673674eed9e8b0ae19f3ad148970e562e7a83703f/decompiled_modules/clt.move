module 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::clt {
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

    public fun createClt<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: 0x2::coin::CoinMetadata<T0>, arg2: &0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::Version, arg3: &mut 0x2::tx_context::TxContext) : CltAdminCap {
        0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::checkVersion(arg2, 1);
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
        0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::cap_vault::createVault<CltAdminCap>(arg3);
        v0
    }

    public fun depositToken<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut CltVault<T0>, arg3: &mut 0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::archieve::UserArchieve, arg4: &0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::Version, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, DepositProof, u64) {
        0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::checkVersion(arg4, 1);
        0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::archieve::verifySignature(arg0, arg1, &arg2.validator);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::bcs::new(arg1);
        let v2 = 0x2::bcs::peel_u64(&mut v1);
        let v3 = 0x2::bcs::peel_u128(&mut v1);
        assert!(0x2::bcs::peel_address(&mut v1) == v0, 1001);
        assert!(v2 > 0, 1002);
        assert!(0x2::bcs::peel_u64(&mut v1) > 0x2::clock::timestamp_ms(arg5), 1004);
        0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::archieve::verUpdateTokenPegNonce(v3, arg3);
        let v4 = DepositProof{
            owner   : v0,
            balance : v2,
        };
        let v5 = CltDeposited{
            token         : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            owner         : v0,
            nonce         : v3,
            balance       : v2,
            total_deposit : 0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::archieve::increaseTotalDeposit(v2, arg3),
        };
        0x2::event::emit<CltDeposited>(v5);
        (0x2::coin::mint_balance<T0>(treasureMut<T0>(arg2), v2), v4, 0x2::bcs::peel_u64(&mut v1))
    }

    public fun depositTokenForNftIds<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut CltVault<T0>, arg3: &mut 0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::archieve::UserArchieve, arg4: &0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::Version, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, DepositProof, vector<address>, u64) {
        0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::checkVersion(arg4, 1);
        0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::archieve::verifySignature(arg0, arg1, &arg2.validator);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::bcs::new(arg1);
        let v2 = 0x2::bcs::peel_u64(&mut v1);
        let v3 = 0x2::bcs::peel_u128(&mut v1);
        assert!(0x2::bcs::peel_address(&mut v1) == v0, 1001);
        assert!(v2 > 0, 1002);
        assert!(0x2::bcs::peel_u64(&mut v1) > 0x2::clock::timestamp_ms(arg5), 1004);
        0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::archieve::verUpdateTokenPegNonce(v3, arg3);
        let v4 = DepositProof{
            owner   : v0,
            balance : v2,
        };
        let v5 = CltDeposited{
            token         : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            owner         : v0,
            nonce         : v3,
            balance       : v2,
            total_deposit : 0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::archieve::increaseTotalDeposit(v2, arg3),
        };
        0x2::event::emit<CltDeposited>(v5);
        (0x2::coin::mint_balance<T0>(treasureMut<T0>(arg2), v2), v4, 0x2::bcs::peel_vec_address(&mut v1), 0x2::bcs::peel_u64(&mut v1))
    }

    public fun depositTokenForOrder<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut CltVault<T0>, arg3: &mut 0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::archieve::UserArchieve, arg4: &0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::Version, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, DepositProof, u128, u64) {
        0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::checkVersion(arg4, 1);
        0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::archieve::verifySignature(arg0, arg1, &arg2.validator);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::bcs::new(arg1);
        let v2 = 0x2::bcs::peel_u64(&mut v1);
        let v3 = 0x2::bcs::peel_u128(&mut v1);
        assert!(0x2::bcs::peel_address(&mut v1) == v0, 1001);
        assert!(v2 > 0, 1002);
        assert!(0x2::bcs::peel_u64(&mut v1) > 0x2::clock::timestamp_ms(arg5), 1004);
        0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::archieve::verUpdateTokenPegNonce(v3, arg3);
        let v4 = DepositProof{
            owner   : v0,
            balance : v2,
        };
        let v5 = CltDeposited{
            token         : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            owner         : v0,
            nonce         : v3,
            balance       : v2,
            total_deposit : 0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::archieve::increaseTotalDeposit(v2, arg3),
        };
        0x2::event::emit<CltDeposited>(v5);
        (0x2::coin::mint_balance<T0>(treasureMut<T0>(arg2), v2), v4, 0x2::bcs::peel_u128(&mut v1), 0x2::bcs::peel_u64(&mut v1))
    }

    public fun depositTokenForOrderIds<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut CltVault<T0>, arg3: &mut 0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::archieve::UserArchieve, arg4: &0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::Version, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, DepositProof, vector<u128>, u64) {
        0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::checkVersion(arg4, 1);
        0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::archieve::verifySignature(arg0, arg1, &arg2.validator);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::bcs::new(arg1);
        let v2 = 0x2::bcs::peel_u64(&mut v1);
        let v3 = 0x2::bcs::peel_u128(&mut v1);
        assert!(0x2::bcs::peel_address(&mut v1) == v0, 1001);
        assert!(v2 > 0, 1002);
        assert!(0x2::bcs::peel_u64(&mut v1) > 0x2::clock::timestamp_ms(arg5), 1004);
        0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::archieve::verUpdateTokenPegNonce(v3, arg3);
        let v4 = DepositProof{
            owner   : v0,
            balance : v2,
        };
        let v5 = CltDeposited{
            token         : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            owner         : v0,
            nonce         : v3,
            balance       : v2,
            total_deposit : 0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::archieve::increaseTotalDeposit(v2, arg3),
        };
        0x2::event::emit<CltDeposited>(v5);
        (0x2::coin::mint_balance<T0>(treasureMut<T0>(arg2), v2), v4, 0x2::bcs::peel_vec_u128(&mut v1), 0x2::bcs::peel_u64(&mut v1))
    }

    fun init(arg0: CLT, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public fun setValidator<T0>(arg0: &CltAdminCap, arg1: vector<u8>, arg2: &mut CltVault<T0>, arg3: &0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::Version) {
        0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::checkVersion(arg3, 1);
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

