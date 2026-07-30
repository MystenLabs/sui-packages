module 0x2d04b4bbd0b9f8b8cb358b5c20f2667b261aaa4a40daf97838d4e6001f56815c::payments {
    struct PaymentsAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PaymentConfig has key {
        id: 0x2::object::UID,
        commission_bps: u64,
        treasury: address,
    }

    struct Money has copy, drop, store {
        amount: u64,
        currency: 0x1::string::String,
    }

    struct AcceptedCoin has drop, store {
        coin_type: 0x1::type_name::TypeName,
        decimals: u8,
        enabled: bool,
    }

    struct CurrencyConfig has store {
        decimals: u8,
        version: u64,
        enabled: bool,
        accepted: vector<AcceptedCoin>,
    }

    struct CurrencyRegistry has key {
        id: 0x2::object::UID,
        configs: 0x2::vec_map::VecMap<0x1::string::String, CurrencyConfig>,
    }

    struct UserVault has key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct SpendingAuthorization has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        payer: address,
        payout: address,
        tier_id: 0x1::option::Option<0x2::object::ID>,
        content_id: 0x1::option::Option<0x2::object::ID>,
        payment_coin_type: 0x1::type_name::TypeName,
        max_amount: Money,
        currency_version: u64,
        expires_at: 0x1::option::Option<u64>,
        status: u8,
        result_object_id: 0x1::option::Option<0x2::object::ID>,
        debit_authorized: 0x2::vec_set::VecSet<address>,
    }

    struct CommissionCollected has copy, drop {
        payer: address,
        treasury: address,
        commission_bps: u64,
        commission_amount: u64,
        gross_price: u64,
        payment_coin_type: vector<u8>,
        kind: u8,
    }

    struct PaymentConfigUpdated has copy, drop {
        commission_bps: u64,
        treasury: address,
    }

    struct CurrencyRegistered has copy, drop {
        currency: 0x1::string::String,
        decimals: u8,
        version: u64,
    }

    struct AcceptedCoinUpdated has copy, drop {
        currency: 0x1::string::String,
        coin_type: 0x1::string::String,
        decimals: u8,
        enabled: bool,
        version: u64,
    }

    struct UserVaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
    }

    struct VaultToppedUp has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        top_up_by: address,
        currency: 0x1::string::String,
        coin_type: 0x1::string::String,
        amount: u64,
        new_balance: u64,
    }

    struct VaultWithdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        coin_type: 0x1::string::String,
        amount: u64,
        new_balance: u64,
    }

    struct SpendingAuthorizationGranted has copy, drop {
        authorization_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        payer: address,
        payout: address,
        tier_id: 0x1::option::Option<0x2::object::ID>,
        content_id: 0x1::option::Option<0x2::object::ID>,
        payment_coin_type: vector<u8>,
        max_amount: u64,
        currency: 0x1::string::String,
        currency_version: u64,
        expires_at: 0x1::option::Option<u64>,
        debit_authorized: vector<address>,
    }

    struct SpendingAuthorizationStatusChanged has copy, drop {
        authorization_id: 0x2::object::ID,
        status: u8,
    }

    struct SubscriptionPurchasedFromVault has copy, drop {
        authorization_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        payer: address,
        tier_id: 0x2::object::ID,
        pass_id: 0x2::object::ID,
        payment_coin_type: vector<u8>,
        price: u64,
        commission_amount: u64,
        gross_amount: u64,
    }

    struct ContentAccessPurchasedFromVault has copy, drop {
        authorization_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        payer: address,
        content_id: 0x2::object::ID,
        pass_id: 0x2::object::ID,
        payment_coin_type: vector<u8>,
        price: u64,
        commission_amount: u64,
        gross_amount: u64,
    }

    fun accepted_coin_decimals<T0>(arg0: &CurrencyConfig) : 0x1::option::Option<u8> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<AcceptedCoin>(&arg0.accepted)) {
            let v1 = 0x1::vector::borrow<AcceptedCoin>(&arg0.accepted, v0);
            if (v1.enabled && v1.coin_type == 0x1::type_name::get<T0>()) {
                return 0x1::option::some<u8>(v1.decimals)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u8>()
    }

    public fun add_accepted_coin<T0>(arg0: &PaymentsAdminCap, arg1: &mut CurrencyRegistry, arg2: 0x1::string::String, arg3: &0x2::coin_registry::Currency<T0>) {
        upsert_accepted_coin<T0>(arg1, arg2, 0x2::coin_registry::decimals<T0>(arg3));
    }

    fun address_set(arg0: vector<address>) : 0x2::vec_set::VecSet<address> {
        let v0 = 0x2::vec_set::empty<address>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0)) {
            let v2 = *0x1::vector::borrow<address>(&arg0, v1);
            if (!0x2::vec_set::contains<address>(&v0, &v2)) {
                0x2::vec_set::insert<address>(&mut v0, v2);
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun assert_accepted_coin<T0>(arg0: &CurrencyRegistry, arg1: &0x1::string::String, arg2: u64) : u8 {
        assert!(0x2::vec_map::contains<0x1::string::String, CurrencyConfig>(&arg0.configs, arg1), 7);
        let v0 = 0x2::vec_map::get<0x1::string::String, CurrencyConfig>(&arg0.configs, arg1);
        assert!(v0.enabled, 7);
        if (arg2 > 0) {
            assert!(v0.version == arg2, 15);
        };
        let v1 = accepted_coin_decimals<T0>(v0);
        assert!(0x1::option::is_some<u8>(&v1), 8);
        0x1::option::destroy_some<u8>(v1)
    }

    fun assert_purchase_executable(arg0: &SpendingAuthorization, arg1: &UserVault, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::vec_set::contains<address>(&arg0.debit_authorized, &v0), 9);
        assert!(arg0.status == 0, 10);
        assert!(arg0.vault_id == 0x2::object::id<UserVault>(arg1), 13);
        if (0x1::option::is_some<u64>(&arg0.expires_at)) {
            assert!(0x2::clock::timestamp_ms(arg2) <= *0x1::option::borrow<u64>(&arg0.expires_at), 11);
        };
    }

    fun assert_within_limit<T0>(arg0: &SpendingAuthorization, arg1: &CurrencyRegistry, arg2: u64) {
        assert!(normalize_charge<T0>(arg1, &arg0.max_amount.currency, arg0.currency_version, arg2) <= arg0.max_amount.amount, 12);
    }

    public fun balance_of<T0>(arg0: &UserVault) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0)) {
            0x2::balance::value<T0>(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.id, v0))
        } else {
            0
        }
    }

    fun borrow_balance_mut<T0>(arg0: &mut UserVault) : &mut 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0), 3);
        0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0)
    }

    public fun cancel_spending_authorization(arg0: &mut SpendingAuthorization, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.payer, 4);
        assert!(arg0.status == 0, 10);
        arg0.status = 2;
        let v0 = SpendingAuthorizationStatusChanged{
            authorization_id : 0x2::object::id<SpendingAuthorization>(arg0),
            status           : 2,
        };
        0x2::event::emit<SpendingAuthorizationStatusChanged>(v0);
    }

    fun charge_currency_decimals<T0>(arg0: &CurrencyRegistry, arg1: &0x1::string::String, arg2: u64) : (u8, u8) {
        assert!(0x2::vec_map::contains<0x1::string::String, CurrencyConfig>(&arg0.configs, arg1), 7);
        let v0 = 0x2::vec_map::get<0x1::string::String, CurrencyConfig>(&arg0.configs, arg1);
        assert!(v0.enabled, 7);
        assert!(v0.version == arg2, 15);
        let v1 = accepted_coin_decimals<T0>(v0);
        assert!(0x1::option::is_some<u8>(&v1), 8);
        (0x1::option::destroy_some<u8>(v1), v0.decimals)
    }

    fun coin_type_bytes<T0>() : vector<u8> {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        *0x1::ascii::as_bytes(&v0)
    }

    fun commission_amount(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 10000) as u64)
    }

    public fun commission_bps(arg0: &PaymentConfig) : u64 {
        arg0.commission_bps
    }

    public fun create_and_top_up_vault<T0>(arg0: &CurrencyRegistry, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_accepted_coin<T0>(arg0, &arg1, 0);
        let v0 = UserVault{
            id    : 0x2::object::new(arg3),
            owner : 0x2::tx_context::sender(arg3),
        };
        let v1 = 0x2::object::id<UserVault>(&v0);
        let v2 = &mut v0;
        let (v3, v4) = deposit_into_vault<T0>(v2, arg2);
        let v5 = UserVaultCreated{
            vault_id : v1,
            owner    : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<UserVaultCreated>(v5);
        let v6 = VaultToppedUp{
            vault_id    : v1,
            owner       : 0x2::tx_context::sender(arg3),
            top_up_by   : 0x2::tx_context::sender(arg3),
            currency    : arg1,
            coin_type   : type_str<T0>(),
            amount      : v3,
            new_balance : v4,
        };
        0x2::event::emit<VaultToppedUp>(v6);
        0x2::transfer::share_object<UserVault>(v0);
        v1
    }

    public fun create_vault(arg0: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = UserVault{
            id    : 0x2::object::new(arg0),
            owner : 0x2::tx_context::sender(arg0),
        };
        let v1 = 0x2::object::id<UserVault>(&v0);
        let v2 = UserVaultCreated{
            vault_id : v1,
            owner    : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<UserVaultCreated>(v2);
        0x2::transfer::share_object<UserVault>(v0);
        v1
    }

    public fun currency_version(arg0: &CurrencyRegistry, arg1: 0x1::string::String) : u64 {
        currency_version_internal(arg0, &arg1)
    }

    fun currency_version_internal(arg0: &CurrencyRegistry, arg1: &0x1::string::String) : u64 {
        assert!(0x2::vec_map::contains<0x1::string::String, CurrencyConfig>(&arg0.configs, arg1), 7);
        let v0 = 0x2::vec_map::get<0x1::string::String, CurrencyConfig>(&arg0.configs, arg1);
        assert!(v0.enabled, 7);
        v0.version
    }

    fun debit_and_take_commission<T0>(arg0: &mut UserVault, arg1: &PaymentConfig, arg2: u64, arg3: u64, arg4: u64, arg5: u8, arg6: address, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = borrow_balance_mut<T0>(arg0);
        assert!(0x2::balance::value<T0>(v0) >= arg2, 3);
        let v1 = 0x2::balance::split<T0>(v0, arg2);
        if (arg3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v1, arg3), arg7), arg1.treasury);
            let v2 = CommissionCollected{
                payer             : arg6,
                treasury          : arg1.treasury,
                commission_bps    : arg1.commission_bps,
                commission_amount : arg3,
                gross_price       : arg4,
                payment_coin_type : coin_type_bytes<T0>(),
                kind              : arg5,
            };
            0x2::event::emit<CommissionCollected>(v2);
        };
        0x2::coin::from_balance<T0>(v1, arg7)
    }

    fun deposit_into_vault<T0>(arg0: &mut UserVault, arg1: 0x2::coin::Coin<T0>) : (u64, u64) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 2);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = if (0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v1)) {
            let v3 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v1);
            0x2::balance::join<T0>(v3, 0x2::coin::into_balance<T0>(arg1));
            0x2::balance::value<T0>(v3)
        } else {
            let v4 = 0x2::coin::into_balance<T0>(arg1);
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v1, v4);
            0x2::balance::value<T0>(&v4)
        };
        (v0, v2)
    }

    public fun disable_accepted_coin<T0>(arg0: &PaymentsAdminCap, arg1: &mut CurrencyRegistry, arg2: 0x1::string::String) {
        assert!(0x2::vec_map::contains<0x1::string::String, CurrencyConfig>(&arg1.configs, &arg2), 7);
        let v0 = 0x2::vec_map::get_mut<0x1::string::String, CurrencyConfig>(&mut arg1.configs, &arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<AcceptedCoin>(&v0.accepted)) {
            let v2 = 0x1::vector::borrow_mut<AcceptedCoin>(&mut v0.accepted, v1);
            if (v2.coin_type == 0x1::type_name::get<T0>()) {
                v2.enabled = false;
                v0.version = v0.version + 1;
                let v3 = AcceptedCoinUpdated{
                    currency  : arg2,
                    coin_type : type_str<T0>(),
                    decimals  : v2.decimals,
                    enabled   : false,
                    version   : v0.version,
                };
                0x2::event::emit<AcceptedCoinUpdated>(v3);
                return
            };
            v1 = v1 + 1;
        };
        abort 8
    }

    fun grant_authorization(arg0: &UserVault, arg1: address, arg2: 0x1::option::Option<0x2::object::ID>, arg3: 0x1::option::Option<0x2::object::ID>, arg4: 0x1::type_name::TypeName, arg5: u64, arg6: 0x1::string::String, arg7: u64, arg8: vector<address>, arg9: 0x1::option::Option<u64>, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::sender(arg10);
        assert!(v0 == arg0.owner, 4);
        assert!(arg1 != v0, 5);
        assert!(0x1::vector::length<address>(&arg8) > 0, 14);
        let v1 = address_set(arg8);
        let v2 = Money{
            amount   : arg5,
            currency : arg6,
        };
        let v3 = SpendingAuthorization{
            id                : 0x2::object::new(arg10),
            vault_id          : 0x2::object::id<UserVault>(arg0),
            payer             : v0,
            payout            : arg1,
            tier_id           : arg2,
            content_id        : arg3,
            payment_coin_type : arg4,
            max_amount        : v2,
            currency_version  : arg7,
            expires_at        : arg9,
            status            : 0,
            result_object_id  : 0x1::option::none<0x2::object::ID>(),
            debit_authorized  : v1,
        };
        let v4 = 0x2::object::id<SpendingAuthorization>(&v3);
        let v5 = 0x1::type_name::into_string(arg4);
        let v6 = SpendingAuthorizationGranted{
            authorization_id  : v4,
            vault_id          : v3.vault_id,
            payer             : v0,
            payout            : arg1,
            tier_id           : v3.tier_id,
            content_id        : v3.content_id,
            payment_coin_type : *0x1::ascii::as_bytes(&v5),
            max_amount        : arg5,
            currency          : v3.max_amount.currency,
            currency_version  : arg7,
            expires_at        : v3.expires_at,
            debit_authorized  : *0x2::vec_set::keys<address>(&v1),
        };
        0x2::event::emit<SpendingAuthorizationGranted>(v6);
        0x2::transfer::share_object<SpendingAuthorization>(v3);
        v4
    }

    public fun grant_content_access_spending_authorization<T0>(arg0: &UserVault, arg1: &CurrencyRegistry, arg2: &PaymentConfig, arg3: &0x33157600c254db6fe6ac219db663cfd1f166a404e6c49354f3ab291fb89c8082::content::Content, arg4: &0x33157600c254db6fe6ac219db663cfd1f166a404e6c49354f3ab291fb89c8082::content::CreatorAccount, arg5: 0x1::string::String, arg6: vector<address>, arg7: 0x1::option::Option<u64>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let (v0, v1) = 0x33157600c254db6fe6ac219db663cfd1f166a404e6c49354f3ab291fb89c8082::content::content_access_purchase_terms<T0>(arg3, arg4);
        let (_, v3) = quote(v0, arg2.commission_bps);
        let v4 = currency_version_internal(arg1, &arg5);
        grant_authorization(arg0, v1, 0x1::option::none<0x2::object::ID>(), 0x1::option::some<0x2::object::ID>(0x2::object::id<0x33157600c254db6fe6ac219db663cfd1f166a404e6c49354f3ab291fb89c8082::content::Content>(arg3)), 0x1::type_name::get<T0>(), normalize_charge<T0>(arg1, &arg5, v4, v3), arg5, v4, arg6, arg7, arg8)
    }

    public fun grant_subscription_spending_authorization<T0>(arg0: &UserVault, arg1: &CurrencyRegistry, arg2: &PaymentConfig, arg3: &0x33157600c254db6fe6ac219db663cfd1f166a404e6c49354f3ab291fb89c8082::content::SubscriptionTier, arg4: &0x33157600c254db6fe6ac219db663cfd1f166a404e6c49354f3ab291fb89c8082::content::CreatorAccount, arg5: 0x1::string::String, arg6: vector<address>, arg7: 0x1::option::Option<u64>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let (v0, _, v2) = 0x33157600c254db6fe6ac219db663cfd1f166a404e6c49354f3ab291fb89c8082::content::subscription_purchase_terms<T0>(arg3, arg4);
        let (_, v4) = subscription_quote(v0, arg2.commission_bps);
        let v5 = currency_version_internal(arg1, &arg5);
        let v6 = if (v4 == 0) {
            let (_, _) = charge_currency_decimals<T0>(arg1, &arg5, v5);
            0
        } else {
            normalize_charge<T0>(arg1, &arg5, v5, v4)
        };
        grant_authorization(arg0, v2, 0x1::option::some<0x2::object::ID>(0x2::object::id<0x33157600c254db6fe6ac219db663cfd1f166a404e6c49354f3ab291fb89c8082::content::SubscriptionTier>(arg3)), 0x1::option::none<0x2::object::ID>(), 0x1::type_name::get<T0>(), v6, arg5, v5, arg6, arg7, arg8)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PaymentsAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<PaymentsAdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = PaymentConfig{
            id             : 0x2::object::new(arg0),
            commission_bps : 0,
            treasury       : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<PaymentConfig>(v1);
        let v2 = CurrencyRegistry{
            id      : 0x2::object::new(arg0),
            configs : 0x2::vec_map::empty<0x1::string::String, CurrencyConfig>(),
        };
        0x2::transfer::share_object<CurrencyRegistry>(v2);
    }

    public fun is_accepted_coin<T0>(arg0: &CurrencyRegistry, arg1: 0x1::string::String) : bool {
        if (!0x2::vec_map::contains<0x1::string::String, CurrencyConfig>(&arg0.configs, &arg1)) {
            return false
        };
        let v0 = 0x2::vec_map::get<0x1::string::String, CurrencyConfig>(&arg0.configs, &arg1);
        if (!v0.enabled) {
            return false
        };
        let v1 = accepted_coin_decimals<T0>(v0);
        0x1::option::is_some<u8>(&v1)
    }

    fun normalize_charge<T0>(arg0: &CurrencyRegistry, arg1: &0x1::string::String, arg2: u64, arg3: u64) : u64 {
        assert!(arg3 > 0, 2);
        let (v0, v1) = charge_currency_decimals<T0>(arg0, arg1, arg2);
        let v2 = to_currency_units(arg3, v0, v1);
        assert!(v2 > 0, 2);
        v2
    }

    fun pow10(arg0: u8) : u64 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun purchase_content_access_from_vault<T0>(arg0: &mut UserVault, arg1: &CurrencyRegistry, arg2: &PaymentConfig, arg3: &mut SpendingAuthorization, arg4: &0x33157600c254db6fe6ac219db663cfd1f166a404e6c49354f3ab291fb89c8082::content::SettlementCap, arg5: &0x33157600c254db6fe6ac219db663cfd1f166a404e6c49354f3ab291fb89c8082::content::Content, arg6: &0x33157600c254db6fe6ac219db663cfd1f166a404e6c49354f3ab291fb89c8082::content::CreatorAccount, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_purchase_executable(arg3, arg0, arg7, arg8);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg3.content_id) && 0x1::option::is_none<0x2::object::ID>(&arg3.tier_id), 19);
        assert!(*0x1::option::borrow<0x2::object::ID>(&arg3.content_id) == 0x2::object::id<0x33157600c254db6fe6ac219db663cfd1f166a404e6c49354f3ab291fb89c8082::content::Content>(arg5), 20);
        assert!(arg3.payment_coin_type == 0x1::type_name::get<T0>(), 21);
        let (v0, v1) = 0x33157600c254db6fe6ac219db663cfd1f166a404e6c49354f3ab291fb89c8082::content::content_access_purchase_terms<T0>(arg5, arg6);
        assert!(v1 == arg3.payout, 20);
        let (v2, v3) = quote(v0, arg2.commission_bps);
        assert_within_limit<T0>(arg3, arg1, v3);
        let v4 = arg3.payer;
        let v5 = debit_and_take_commission<T0>(arg0, arg2, v3, v2, v0, 2, v4, arg8);
        let v6 = 0x33157600c254db6fe6ac219db663cfd1f166a404e6c49354f3ab291fb89c8082::content::settle_content_access_purchase<T0>(arg4, v4, arg5, arg6, v5, arg7, arg8);
        arg3.result_object_id = 0x1::option::some<0x2::object::ID>(v6);
        arg3.status = 1;
        let v7 = ContentAccessPurchasedFromVault{
            authorization_id  : 0x2::object::id<SpendingAuthorization>(arg3),
            vault_id          : arg3.vault_id,
            payer             : v4,
            content_id        : 0x2::object::id<0x33157600c254db6fe6ac219db663cfd1f166a404e6c49354f3ab291fb89c8082::content::Content>(arg5),
            pass_id           : v6,
            payment_coin_type : coin_type_bytes<T0>(),
            price             : v0,
            commission_amount : v2,
            gross_amount      : v3,
        };
        0x2::event::emit<ContentAccessPurchasedFromVault>(v7);
        let v8 = SpendingAuthorizationStatusChanged{
            authorization_id : 0x2::object::id<SpendingAuthorization>(arg3),
            status           : 1,
        };
        0x2::event::emit<SpendingAuthorizationStatusChanged>(v8);
        v6
    }

    public fun purchase_subscription_from_vault<T0>(arg0: &mut UserVault, arg1: &CurrencyRegistry, arg2: &PaymentConfig, arg3: &mut SpendingAuthorization, arg4: &0x33157600c254db6fe6ac219db663cfd1f166a404e6c49354f3ab291fb89c8082::content::SettlementCap, arg5: &mut 0x33157600c254db6fe6ac219db663cfd1f166a404e6c49354f3ab291fb89c8082::content::SubscriptionTier, arg6: &0x33157600c254db6fe6ac219db663cfd1f166a404e6c49354f3ab291fb89c8082::content::CreatorAccount, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_purchase_executable(arg3, arg0, arg7, arg8);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg3.tier_id) && 0x1::option::is_none<0x2::object::ID>(&arg3.content_id), 19);
        assert!(*0x1::option::borrow<0x2::object::ID>(&arg3.tier_id) == 0x2::object::id<0x33157600c254db6fe6ac219db663cfd1f166a404e6c49354f3ab291fb89c8082::content::SubscriptionTier>(arg5), 20);
        assert!(arg3.payment_coin_type == 0x1::type_name::get<T0>(), 21);
        let (v0, _, v2) = 0x33157600c254db6fe6ac219db663cfd1f166a404e6c49354f3ab291fb89c8082::content::subscription_purchase_terms<T0>(arg5, arg6);
        assert!(v2 == arg3.payout, 20);
        let (v3, v4) = subscription_quote(v0, arg2.commission_bps);
        let v5 = arg3.payer;
        let v6 = if (v4 == 0) {
            0x2::coin::zero<T0>(arg8)
        } else {
            assert_within_limit<T0>(arg3, arg1, v4);
            debit_and_take_commission<T0>(arg0, arg2, v4, v3, v0, 1, v5, arg8)
        };
        let v7 = 0x33157600c254db6fe6ac219db663cfd1f166a404e6c49354f3ab291fb89c8082::content::settle_subscription_purchase<T0>(arg4, v5, arg5, arg6, v6, v3, arg7, arg8);
        arg3.result_object_id = 0x1::option::some<0x2::object::ID>(v7);
        arg3.status = 1;
        let v8 = SubscriptionPurchasedFromVault{
            authorization_id  : 0x2::object::id<SpendingAuthorization>(arg3),
            vault_id          : arg3.vault_id,
            payer             : v5,
            tier_id           : 0x2::object::id<0x33157600c254db6fe6ac219db663cfd1f166a404e6c49354f3ab291fb89c8082::content::SubscriptionTier>(arg5),
            pass_id           : v7,
            payment_coin_type : coin_type_bytes<T0>(),
            price             : v0,
            commission_amount : v3,
            gross_amount      : v4,
        };
        0x2::event::emit<SubscriptionPurchasedFromVault>(v8);
        let v9 = SpendingAuthorizationStatusChanged{
            authorization_id : 0x2::object::id<SpendingAuthorization>(arg3),
            status           : 1,
        };
        0x2::event::emit<SpendingAuthorizationStatusChanged>(v9);
        v7
    }

    fun quote(arg0: u64, arg1: u64) : (u64, u64) {
        let v0 = commission_amount(arg0, arg1);
        let v1 = (arg0 as u128) + (v0 as u128);
        assert!(v1 <= 18446744073709551615, 18);
        (v0, (v1 as u64))
    }

    public fun register_currency(arg0: &PaymentsAdminCap, arg1: &mut CurrencyRegistry, arg2: 0x1::string::String, arg3: u8) {
        assert!(!0x2::vec_map::contains<0x1::string::String, CurrencyConfig>(&arg1.configs, &arg2), 6);
        assert!(arg3 <= 18, 16);
        let v0 = CurrencyConfig{
            decimals : arg3,
            version  : 1,
            enabled  : true,
            accepted : 0x1::vector::empty<AcceptedCoin>(),
        };
        0x2::vec_map::insert<0x1::string::String, CurrencyConfig>(&mut arg1.configs, arg2, v0);
        let v1 = CurrencyRegistered{
            currency : arg2,
            decimals : arg3,
            version  : 1,
        };
        0x2::event::emit<CurrencyRegistered>(v1);
    }

    public fun set_commission(arg0: &PaymentsAdminCap, arg1: &mut PaymentConfig, arg2: u64) {
        assert!(arg2 <= 2000, 1);
        arg1.commission_bps = arg2;
        let v0 = PaymentConfigUpdated{
            commission_bps : arg2,
            treasury       : arg1.treasury,
        };
        0x2::event::emit<PaymentConfigUpdated>(v0);
    }

    public fun set_treasury(arg0: &PaymentsAdminCap, arg1: &mut PaymentConfig, arg2: address) {
        arg1.treasury = arg2;
        let v0 = PaymentConfigUpdated{
            commission_bps : arg1.commission_bps,
            treasury       : arg2,
        };
        0x2::event::emit<PaymentConfigUpdated>(v0);
    }

    fun subscription_quote(arg0: u64, arg1: u64) : (u64, u64) {
        (commission_amount(arg0, arg1), arg0)
    }

    fun to_currency_units(arg0: u64, arg1: u8, arg2: u8) : u64 {
        if (arg2 >= arg1) {
            let v1 = (arg0 as u128) * (pow10(arg2 - arg1) as u128);
            assert!(v1 <= 18446744073709551615, 18);
            (v1 as u64)
        } else {
            let v2 = pow10(arg1 - arg2);
            assert!(arg0 % v2 == 0, 17);
            arg0 / v2
        }
    }

    public fun top_up_vault<T0>(arg0: &mut UserVault, arg1: &CurrencyRegistry, arg2: 0x1::string::String, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert_accepted_coin<T0>(arg1, &arg2, 0);
        let (v0, v1) = deposit_into_vault<T0>(arg0, arg3);
        let v2 = VaultToppedUp{
            vault_id    : 0x2::object::id<UserVault>(arg0),
            owner       : arg0.owner,
            top_up_by   : 0x2::tx_context::sender(arg4),
            currency    : arg2,
            coin_type   : type_str<T0>(),
            amount      : v0,
            new_balance : v1,
        };
        0x2::event::emit<VaultToppedUp>(v2);
    }

    public fun treasury(arg0: &PaymentConfig) : address {
        arg0.treasury
    }

    fun type_str<T0>() : 0x1::string::String {
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    fun upsert_accepted_coin<T0>(arg0: &mut CurrencyRegistry, arg1: 0x1::string::String, arg2: u8) {
        assert!(0x2::vec_map::contains<0x1::string::String, CurrencyConfig>(&arg0.configs, &arg1), 7);
        let v0 = 0x2::vec_map::get_mut<0x1::string::String, CurrencyConfig>(&mut arg0.configs, &arg1);
        assert!(v0.enabled, 7);
        assert!(arg2 <= 18, 16);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = 0;
        let v3 = false;
        while (v2 < 0x1::vector::length<AcceptedCoin>(&v0.accepted)) {
            let v4 = 0x1::vector::borrow_mut<AcceptedCoin>(&mut v0.accepted, v2);
            if (v4.coin_type == v1) {
                v4.decimals = arg2;
                v4.enabled = true;
                v3 = true;
                break
            };
            v2 = v2 + 1;
        };
        if (!v3) {
            let v5 = AcceptedCoin{
                coin_type : v1,
                decimals  : arg2,
                enabled   : true,
            };
            0x1::vector::push_back<AcceptedCoin>(&mut v0.accepted, v5);
        };
        v0.version = v0.version + 1;
        let v6 = AcceptedCoinUpdated{
            currency  : arg1,
            coin_type : type_str<T0>(),
            decimals  : arg2,
            enabled   : true,
            version   : v0.version,
        };
        0x2::event::emit<AcceptedCoinUpdated>(v6);
    }

    public fun vault_owner(arg0: &UserVault) : address {
        arg0.owner
    }

    public fun withdraw_from_vault<T0>(arg0: &mut UserVault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 4);
        assert!(arg1 > 0, 2);
        let v0 = arg0.owner;
        let v1 = borrow_balance_mut<T0>(arg0);
        assert!(0x2::balance::value<T0>(v1) >= arg1, 3);
        let v2 = 0x2::balance::split<T0>(v1, arg1);
        let v3 = VaultWithdrawn{
            vault_id    : 0x2::object::id<UserVault>(arg0),
            owner       : arg0.owner,
            coin_type   : type_str<T0>(),
            amount      : arg1,
            new_balance : 0x2::balance::value<T0>(v1),
        };
        0x2::event::emit<VaultWithdrawn>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg2), v0);
    }

    // decompiled from Move bytecode v7
}

