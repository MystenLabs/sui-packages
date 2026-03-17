module 0x829fb75f449808639cb68da3c00aedd387b4cf1e7be90c125f5b194507dea557::custody {
    struct Vault has key {
        id: 0x2::object::UID,
        version: u64,
        key: 0x2::object::ID,
        bags: 0x2::bag::Bag,
        delegations: 0x2::vec_set::VecSet<address>,
        allowed_coins: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        limiters: 0x2::bag::Bag,
        extra_fields: 0x2::bag::Bag,
    }

    struct VaultKey has store, key {
        id: 0x2::object::UID,
    }

    struct Receipt {
        source_coin_type: 0x1::type_name::TypeName,
        source_amount: u64,
        slippage: u64,
        vault_id: 0x2::object::ID,
    }

    struct DepositEvent has copy, drop, store {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        vault_id: 0x2::object::ID,
    }

    struct WithdrawEvent has copy, drop, store {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        vault_id: 0x2::object::ID,
    }

    struct AddDelegationEvent has copy, drop, store {
        delegation: address,
        vault_id: 0x2::object::ID,
    }

    struct RemoveDelegationEvent has copy, drop, store {
        delegation: address,
        vault_id: 0x2::object::ID,
    }

    struct AllowCoinEvent has copy, drop, store {
        coin_type: 0x1::type_name::TypeName,
        vault_id: 0x2::object::ID,
    }

    struct DisallowCoinEvent has copy, drop, store {
        coin_type: 0x1::type_name::TypeName,
        vault_id: 0x2::object::ID,
    }

    struct VersionUpgradeEvent has copy, drop, store {
        vault_id: 0x2::object::ID,
        new_version: u64,
    }

    struct SwapEvent has copy, drop, store {
        source_coin_type: 0x1::type_name::TypeName,
        source_amount: u64,
        target_coin_type: 0x1::type_name::TypeName,
        purchased_amount: u64,
        min_acceptable_amount: 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::Decimal,
        vault_id: 0x2::object::ID,
    }

    struct CUSTODY has drop {
        dummy_field: bool,
    }

    public fun add_delegation(arg0: &VaultKey, arg1: &mut Vault, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert_ownership(arg0, arg1);
        0x2::vec_set::insert<address>(&mut arg1.delegations, arg2);
        let v0 = AddDelegationEvent{
            delegation : arg2,
            vault_id   : 0x2::object::id<Vault>(arg1),
        };
        0x2::event::emit<AddDelegationEvent>(v0);
    }

    public fun allow_coin<T0>(arg0: &VaultKey, arg1: &mut Vault, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert_ownership(arg0, arg1);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.allowed_coins, 0x1::type_name::with_defining_ids<T0>());
        let v0 = AllowCoinEvent{
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            vault_id  : 0x2::object::id<Vault>(arg1),
        };
        0x2::event::emit<AllowCoinEvent>(v0);
    }

    public(friend) fun assert_delegation(arg0: &Vault, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_set::contains<address>(&arg0.delegations, &v0), 3);
    }

    fun assert_ownership(arg0: &VaultKey, arg1: &Vault) {
        assert!(arg1.key == 0x2::object::id<VaultKey>(arg0), 0);
    }

    fun assert_version(arg0: &Vault) {
        assert!(arg0.version == 1, 7);
    }

    public fun claim_rewards<T0, T1, T2>(arg0: &mut Vault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_delegation(arg0, arg4);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_coins, &v0), 8);
        let v1 = 0x1::type_name::with_defining_ids<T2>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_coins, &v1), 8);
        let v2 = 0x829fb75f449808639cb68da3c00aedd387b4cf1e7be90c125f5b194507dea557::suilend_adapter::claim_rewards<T0, T1, T2>(suilend_account<T0>(arg0), arg1, arg2, arg3, arg4);
        store_coin<T2>(arg0, v2, arg4);
    }

    public fun deposit<T0>(arg0: &VaultKey, arg1: &mut Vault, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert_ownership(arg0, arg1);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 2);
        let v1 = DepositEvent{
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            amount    : v0,
            vault_id  : 0x2::object::id<Vault>(arg1),
        };
        0x2::event::emit<DepositEvent>(v1);
        store_coin<T0>(arg1, arg2, arg3);
    }

    public fun deposit_to_suilend<T0, T1>(arg0: &mut Vault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_delegation(arg0, arg4);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_coins, &v0), 8);
        let v1 = take_coin<T1>(arg0, arg3, arg4);
        0x829fb75f449808639cb68da3c00aedd387b4cf1e7be90c125f5b194507dea557::suilend_adapter::deposit<T0, T1>(suilend_account_mut<T0>(arg0), arg1, v1, arg2, arg4);
    }

    public fun disallow_coin<T0>(arg0: &VaultKey, arg1: &mut Vault, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert_ownership(arg0, arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg1.allowed_coins, &v0);
        let v1 = DisallowCoinEvent{
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            vault_id  : 0x2::object::id<Vault>(arg1),
        };
        0x2::event::emit<DisallowCoinEvent>(v1);
    }

    public fun finish_buying<T0>(arg0: &mut Vault, arg1: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg2: 0x2::coin::Coin<T0>, arg3: Receipt, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_delegation(arg0, arg5);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_coins, &v0), 8);
        let Receipt {
            source_coin_type : v1,
            source_amount    : v2,
            slippage         : v3,
            vault_id         : v4,
        } = arg3;
        assert!(v4 == 0x2::object::id<Vault>(arg0), 7);
        let v5 = 0x1::type_name::with_defining_ids<T0>();
        assert!(v5 != v1, 11);
        let v6 = 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::mul(0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::from(v2), get_price(arg1, v1, arg4));
        let v7 = volume_limiter_mut(arg0);
        0x829fb75f449808639cb68da3c00aedd387b4cf1e7be90c125f5b194507dea557::limiter::record_volume(v7, v6, arg4);
        let v8 = volume_limiter_mut(arg0);
        0x829fb75f449808639cb68da3c00aedd387b4cf1e7be90c125f5b194507dea557::limiter::assert_volume(v8, arg4);
        let v9 = 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::mul(0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::div(v6, get_price(arg1, v5, arg4)), 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::sub(0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::from(1), 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::div(0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::from(v3), 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::from(10000))));
        assert!(0x2::coin::value<T0>(&arg2) >= 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::ceil(v9), 1);
        let v10 = SwapEvent{
            source_coin_type      : v1,
            source_amount         : v2,
            target_coin_type      : v5,
            purchased_amount      : 0x2::coin::value<T0>(&arg2),
            min_acceptable_amount : v9,
            vault_id              : v4,
        };
        0x2::event::emit<SwapEvent>(v10);
        store_coin<T0>(arg0, arg2, arg5);
    }

    fun get_price(arg0: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::Decimal {
        let v0 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::prices(arg0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::price_feed::PriceFeed>(v0, arg1), 5);
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::price_feed::PriceFeed>(v0, arg1);
        let v2 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::price_feed::value(v1);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 == 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::price_feed::last_updated(v1), 6);
        assert!(v2 > 0, 5);
        0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::div(0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::from(v2), 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::pow(0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::from(10), (0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::price_feed::decimals() as u64)))
    }

    fun init(arg0: CUSTODY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultKey{id: 0x2::object::new(arg1)};
        let v1 = Vault{
            id            : 0x2::object::new(arg1),
            version       : 1,
            key           : 0x2::object::id<VaultKey>(&v0),
            bags          : 0x2::bag::new(arg1),
            delegations   : 0x2::vec_set::empty<address>(),
            allowed_coins : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            limiters      : 0x2::bag::new(arg1),
            extra_fields  : 0x2::bag::new(arg1),
        };
        let v2 = &mut v1;
        init_volume_limiter_(v2, arg1);
        0x2::transfer::share_object<Vault>(v1);
        0x2::transfer::public_transfer<VaultKey>(v0, 0x2::tx_context::sender(arg1));
        0x2::package::claim_and_keep<CUSTODY>(arg0, arg1);
    }

    public fun init_suilend_account<T0>(arg0: &VaultKey, arg1: &mut Vault, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert_ownership(arg0, arg1);
        assert!(!0x2::bag::contains<0x829fb75f449808639cb68da3c00aedd387b4cf1e7be90c125f5b194507dea557::suilend_adapter::SUILEND_ACCOUNT_FIELD>(&arg1.extra_fields, 0x829fb75f449808639cb68da3c00aedd387b4cf1e7be90c125f5b194507dea557::suilend_adapter::suilend_account_field()), 10);
        0x2::bag::add<0x829fb75f449808639cb68da3c00aedd387b4cf1e7be90c125f5b194507dea557::suilend_adapter::SUILEND_ACCOUNT_FIELD, 0x829fb75f449808639cb68da3c00aedd387b4cf1e7be90c125f5b194507dea557::suilend_adapter::SuilendAccount<T0>>(&mut arg1.extra_fields, 0x829fb75f449808639cb68da3c00aedd387b4cf1e7be90c125f5b194507dea557::suilend_adapter::suilend_account_field(), 0x829fb75f449808639cb68da3c00aedd387b4cf1e7be90c125f5b194507dea557::suilend_adapter::create_suilend_account<T0>(arg2, arg3));
    }

    fun init_volume_limiter_(arg0: &mut Vault, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::bag::add<0x829fb75f449808639cb68da3c00aedd387b4cf1e7be90c125f5b194507dea557::limiter::VOLUME_LIMITER_FIELD, 0x829fb75f449808639cb68da3c00aedd387b4cf1e7be90c125f5b194507dea557::limiter::VolumeLimiter>(&mut arg0.limiters, 0x829fb75f449808639cb68da3c00aedd387b4cf1e7be90c125f5b194507dea557::limiter::volume_limiter_field(), 0x829fb75f449808639cb68da3c00aedd387b4cf1e7be90c125f5b194507dea557::limiter::create_volume_limiter(arg1));
    }

    public fun remove_delegation(arg0: &VaultKey, arg1: &mut Vault, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert_ownership(arg0, arg1);
        0x2::vec_set::remove<address>(&mut arg1.delegations, &arg2);
        let v0 = RemoveDelegationEvent{
            delegation : arg2,
            vault_id   : 0x2::object::id<Vault>(arg1),
        };
        0x2::event::emit<RemoveDelegationEvent>(v0);
    }

    public fun set_max_volume(arg0: &VaultKey, arg1: &mut Vault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_ownership(arg0, arg1);
        assert_version(arg1);
        0x829fb75f449808639cb68da3c00aedd387b4cf1e7be90c125f5b194507dea557::limiter::set_max_volume(volume_limiter_mut(arg1), 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::from(arg2));
    }

    public fun start_buying<T0>(arg0: &mut Vault, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Receipt) {
        assert_version(arg0);
        assert_delegation(arg0, arg3);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_coins, &v0), 8);
        assert!(10000 * 5 / 100 >= arg2, 9);
        let v1 = take_coin<T0>(arg0, arg1, arg3);
        let v2 = Receipt{
            source_coin_type : 0x1::type_name::with_defining_ids<T0>(),
            source_amount    : arg1,
            slippage         : arg2,
            vault_id         : 0x2::object::id<Vault>(arg0),
        };
        (v1, v2)
    }

    fun store_coin<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) > 0, 2);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.bags, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg0.bags, v0, 0x2::coin::zero<T0>(arg2));
        };
        0x2::coin::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg0.bags, v0), arg1);
    }

    public(friend) fun suilend_account<T0>(arg0: &Vault) : &0x829fb75f449808639cb68da3c00aedd387b4cf1e7be90c125f5b194507dea557::suilend_adapter::SuilendAccount<T0> {
        0x2::bag::borrow<0x829fb75f449808639cb68da3c00aedd387b4cf1e7be90c125f5b194507dea557::suilend_adapter::SUILEND_ACCOUNT_FIELD, 0x829fb75f449808639cb68da3c00aedd387b4cf1e7be90c125f5b194507dea557::suilend_adapter::SuilendAccount<T0>>(&arg0.extra_fields, 0x829fb75f449808639cb68da3c00aedd387b4cf1e7be90c125f5b194507dea557::suilend_adapter::suilend_account_field())
    }

    public(friend) fun suilend_account_mut<T0>(arg0: &mut Vault) : &mut 0x829fb75f449808639cb68da3c00aedd387b4cf1e7be90c125f5b194507dea557::suilend_adapter::SuilendAccount<T0> {
        0x2::bag::borrow_mut<0x829fb75f449808639cb68da3c00aedd387b4cf1e7be90c125f5b194507dea557::suilend_adapter::SUILEND_ACCOUNT_FIELD, 0x829fb75f449808639cb68da3c00aedd387b4cf1e7be90c125f5b194507dea557::suilend_adapter::SuilendAccount<T0>>(&mut arg0.extra_fields, 0x829fb75f449808639cb68da3c00aedd387b4cf1e7be90c125f5b194507dea557::suilend_adapter::suilend_account_field())
    }

    fun take_coin<T0>(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1 > 0, 2);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.bags, v0), 4);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg0.bags, v0);
        assert!(0x2::coin::value<T0>(v1) >= arg1, 1);
        0x2::coin::split<T0>(v1, arg1, arg2)
    }

    public fun upgrade_version(arg0: &VaultKey, arg1: &mut Vault, arg2: &mut 0x2::tx_context::TxContext) {
        assert_ownership(arg0, arg1);
        arg1.version = arg1.version + 1;
        let v0 = VersionUpgradeEvent{
            vault_id    : 0x2::object::id<Vault>(arg1),
            new_version : arg1.version,
        };
        0x2::event::emit<VersionUpgradeEvent>(v0);
    }

    fun volume_limiter_mut(arg0: &mut Vault) : &mut 0x829fb75f449808639cb68da3c00aedd387b4cf1e7be90c125f5b194507dea557::limiter::VolumeLimiter {
        0x2::bag::borrow_mut<0x829fb75f449808639cb68da3c00aedd387b4cf1e7be90c125f5b194507dea557::limiter::VOLUME_LIMITER_FIELD, 0x829fb75f449808639cb68da3c00aedd387b4cf1e7be90c125f5b194507dea557::limiter::VolumeLimiter>(&mut arg0.limiters, 0x829fb75f449808639cb68da3c00aedd387b4cf1e7be90c125f5b194507dea557::limiter::volume_limiter_field())
    }

    public fun withdraw<T0>(arg0: &VaultKey, arg1: &mut Vault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version(arg1);
        assert_ownership(arg0, arg1);
        let v0 = WithdrawEvent{
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            amount    : arg2,
            vault_id  : 0x2::object::id<Vault>(arg1),
        };
        0x2::event::emit<WithdrawEvent>(v0);
        take_coin<T0>(arg1, arg2, arg3)
    }

    public fun withdraw_from_suilend<T0, T1>(arg0: &mut Vault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_delegation(arg0, arg4);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_coins, &v0), 8);
        let v1 = suilend_account_mut<T0>(arg0);
        let v2 = 0x829fb75f449808639cb68da3c00aedd387b4cf1e7be90c125f5b194507dea557::suilend_adapter::withdraw<T0, T1>(v1, arg1, arg3, arg2, arg4);
        store_coin<T1>(arg0, v2, arg4);
    }

    // decompiled from Move bytecode v6
}

