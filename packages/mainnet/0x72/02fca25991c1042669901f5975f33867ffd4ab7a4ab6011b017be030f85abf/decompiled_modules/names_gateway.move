module 0x7202fca25991c1042669901f5975f33867ffd4ab7a4ab6011b017be030f85abf::names_gateway {
    struct GatewayAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct KeeperCap has store, key {
        id: 0x2::object::UID,
    }

    struct Gateway has key {
        id: 0x2::object::UID,
        sui_float: 0x2::balance::Balance<0x2::sui::SUI>,
        max_sui_fee: u64,
        paused: bool,
        names_sold: u64,
        tokens: vector<0x1::type_name::TypeName>,
        keepers: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct TokenKey has copy, drop, store {
        t: 0x1::type_name::TypeName,
    }

    struct TokenConfig<phantom T0> has store {
        fee_base: u64,
        min_fee_base: u64,
        max_fee_base: u64,
        max_step_bps: u64,
        enabled: bool,
        collected: 0x2::balance::Balance<T0>,
        names_sold: u64,
        total_collected: u64,
        fee_updated_ms: u64,
    }

    struct NamePaidInToken has copy, drop {
        payer: address,
        name: 0x1::string::String,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        sui_fee: u64,
    }

    struct TokenAdded has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        fee_base: u64,
    }

    struct TokenRemoved has copy, drop {
        coin_type: 0x1::type_name::TypeName,
    }

    struct TokenFeeUpdated has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        old_fee_base: u64,
        new_fee_base: u64,
        by_keeper: bool,
    }

    struct TokenBoundsUpdated has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        min_fee_base: u64,
        max_fee_base: u64,
        max_step_bps: u64,
    }

    struct TokenEnabledUpdated has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        enabled: bool,
    }

    struct TokenLocked has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        beneficiary: address,
        unlock_ms: u64,
    }

    struct FloatFunded has copy, drop {
        funder: address,
        amount: u64,
        new_total: u64,
    }

    struct FloatWithdrawn has copy, drop {
        amount: u64,
        new_total: u64,
    }

    struct MaxSuiFeeUpdated has copy, drop {
        max_sui_fee: u64,
    }

    struct PausedUpdated has copy, drop {
        paused: bool,
    }

    struct KeeperMinted has copy, drop {
        keeper: 0x2::object::ID,
        to: address,
    }

    struct KeeperRevoked has copy, drop {
        keeper: 0x2::object::ID,
    }

    public fun add_token<T0>(arg0: &GatewayAdminCap, arg1: &mut Gateway, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = TokenKey{t: v0};
        assert!(!0x2::dynamic_field::exists<TokenKey>(&arg1.id, v1), 7);
        assert_fee(arg2);
        assert_bounds(arg2, arg3, arg4, arg5);
        let v2 = TokenKey{t: v0};
        let v3 = TokenConfig<T0>{
            fee_base        : arg2,
            min_fee_base    : arg3,
            max_fee_base    : arg4,
            max_step_bps    : arg5,
            enabled         : true,
            collected       : 0x2::balance::zero<T0>(),
            names_sold      : 0,
            total_collected : 0,
            fee_updated_ms  : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::dynamic_field::add<TokenKey, TokenConfig<T0>>(&mut arg1.id, v2, v3);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.tokens, v0);
        let v4 = TokenAdded{
            coin_type : v0,
            fee_base  : arg2,
        };
        0x2::event::emit<TokenAdded>(v4);
    }

    fun assert_bounds(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert!(arg1 <= arg0 && arg0 <= arg2, 8);
        assert!(arg3 <= 5000, 8);
    }

    fun assert_fee(arg0: u64) {
        assert!(arg0 > 0, 4);
        assert!(arg0 <= 700000000000000000, 15);
    }

    fun config<T0>(arg0: &Gateway) : &TokenConfig<T0> {
        let v0 = TokenKey{t: 0x1::type_name::with_defining_ids<T0>()};
        assert!(0x2::dynamic_field::exists<TokenKey>(&arg0.id, v0), 0);
        0x2::dynamic_field::borrow<TokenKey, TokenConfig<T0>>(&arg0.id, v0)
    }

    fun config_mut<T0>(arg0: &mut Gateway, arg1: 0x1::type_name::TypeName) : &mut TokenConfig<T0> {
        let v0 = TokenKey{t: arg1};
        assert!(0x2::dynamic_field::exists<TokenKey>(&arg0.id, v0), 0);
        0x2::dynamic_field::borrow_mut<TokenKey, TokenConfig<T0>>(&mut arg0.id, v0)
    }

    public fun fund(arg0: &mut Gateway, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_float, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = FloatFunded{
            funder    : 0x2::tx_context::sender(arg2),
            amount    : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            new_total : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_float),
        };
        0x2::event::emit<FloatFunded>(v0);
    }

    public fun has_token<T0>(arg0: &Gateway) : bool {
        let v0 = TokenKey{t: 0x1::type_name::with_defining_ids<T0>()};
        0x2::dynamic_field::exists<TokenKey>(&arg0.id, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Gateway{
            id          : 0x2::object::new(arg0),
            sui_float   : 0x2::balance::zero<0x2::sui::SUI>(),
            max_sui_fee : 15000000000,
            paused      : false,
            names_sold  : 0,
            tokens      : 0x1::vector::empty<0x1::type_name::TypeName>(),
            keepers     : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<Gateway>(v0);
        let v1 = GatewayAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<GatewayAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_keeper(arg0: &Gateway, arg1: &KeeperCap) : bool {
        let v0 = 0x2::object::id<KeeperCap>(arg1);
        0x2::vec_set::contains<0x2::object::ID>(&arg0.keepers, &v0)
    }

    public fun is_paused(arg0: &Gateway) : bool {
        arg0.paused
    }

    public fun keeper_set_fee<T0>(arg0: &KeeperCap, arg1: &mut Gateway, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::object::id<KeeperCap>(arg0);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg1.keepers, &v0), 16);
        assert_fee(arg2);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        let v3 = config_mut<T0>(arg1, v2);
        assert!(v1 >= v3.fee_updated_ms + 21600000, 17);
        assert!(arg2 >= v3.min_fee_base && arg2 <= v3.max_fee_base, 9);
        let v4 = v3.fee_base;
        let v5 = if (arg2 > v4) {
            arg2 - v4
        } else {
            v4 - arg2
        };
        assert!(v5 <= (((v4 as u128) * (v3.max_step_bps as u128) / 10000) as u64), 10);
        v3.fee_base = arg2;
        v3.fee_updated_ms = v1;
        let v6 = TokenFeeUpdated{
            coin_type    : v2,
            old_fee_base : v4,
            new_fee_base : arg2,
            by_keeper    : true,
        };
        0x2::event::emit<TokenFeeUpdated>(v6);
    }

    public fun lock_collected<T0>(arg0: &GatewayAdminCap, arg1: &mut Gateway, arg2: &mut 0x848cb7edf8b5f7650b3188dec459394472c8ccf206a031497bf55fe40c165da2::vesting::Treasury, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: address, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 >= 31536000000, 14);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = config_mut<T0>(arg1, v0);
        let v2 = 0x2::balance::value<T0>(&v1.collected);
        assert!(v2 > 0, 13);
        let v3 = 0x2::clock::timestamp_ms(arg6) + arg5;
        0x848cb7edf8b5f7650b3188dec459394472c8ccf206a031497bf55fe40c165da2::vesting::create_vault<T0>(arg2, arg3, 0x2::coin::take<T0>(&mut v1.collected, v2, arg7), arg4, v3, 10000, v3, v3, arg6, arg7);
        let v4 = TokenLocked{
            coin_type   : v0,
            amount      : v2,
            beneficiary : arg4,
            unlock_ms   : v3,
        };
        0x2::event::emit<TokenLocked>(v4);
    }

    public fun max_sui_fee(arg0: &Gateway) : u64 {
        arg0.max_sui_fee
    }

    public fun min_keeper_interval_ms() : u64 {
        21600000
    }

    public fun min_lock_ms() : u64 {
        31536000000
    }

    public fun mint_keeper(arg0: &GatewayAdminCap, arg1: &mut Gateway, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = KeeperCap{id: 0x2::object::new(arg3)};
        let v1 = 0x2::object::id<KeeperCap>(&v0);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.keepers, v1);
        0x2::transfer::public_transfer<KeeperCap>(v0, arg2);
        let v2 = KeeperMinted{
            keeper : v1,
            to     : arg2,
        };
        0x2::event::emit<KeeperMinted>(v2);
    }

    public fun names_sold(arg0: &Gateway) : u64 {
        arg0.names_sold
    }

    public fun quote<T0>(arg0: &Gateway, arg1: u64) : u64 {
        0x5dd1fb9f784129f0815c8e54ed917ad698401c0900ebeb1525f37fac98a94dda::walrus_names::registration_fee(config<T0>(arg0).fee_base, arg1)
    }

    public fun register_with_token<T0>(arg0: &mut Gateway, arg1: &mut 0x5dd1fb9f784129f0815c8e54ed917ad698401c0900ebeb1525f37fac98a94dda::walrus_names::Registry, arg2: &mut 0x5dd1fb9f784129f0815c8e54ed917ad698401c0900ebeb1525f37fac98a94dda::walrus_names::WalNamesTreasury, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(!0x5dd1fb9f784129f0815c8e54ed917ad698401c0900ebeb1525f37fac98a94dda::walrus_names::is_whitelisted(arg2, v0), 12);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = 0x1::vector::length<u8>(0x1::string::as_bytes(&arg3));
        let v3 = 0x5dd1fb9f784129f0815c8e54ed917ad698401c0900ebeb1525f37fac98a94dda::walrus_names::registration_fee(0x5dd1fb9f784129f0815c8e54ed917ad698401c0900ebeb1525f37fac98a94dda::walrus_names::fee_base(arg2), v2);
        assert!(v3 <= arg0.max_sui_fee, 5);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_float) >= v3, 3);
        let v4 = 0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_float, v3, arg6);
        let v5 = config_mut<T0>(arg0, v1);
        assert!(v5.enabled, 1);
        let v6 = 0x5dd1fb9f784129f0815c8e54ed917ad698401c0900ebeb1525f37fac98a94dda::walrus_names::registration_fee(v5.fee_base, v2);
        assert!(0x2::coin::value<T0>(&arg5) >= v6, 2);
        0x2::balance::join<T0>(&mut v5.collected, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg5, v6, arg6)));
        v5.names_sold = v5.names_sold + 1;
        v5.total_collected = v5.total_collected + v6;
        if (0x2::coin::value<T0>(&arg5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg5, v0);
        } else {
            0x2::coin::destroy_zero<T0>(arg5);
        };
        0x5dd1fb9f784129f0815c8e54ed917ad698401c0900ebeb1525f37fac98a94dda::walrus_names::register(arg1, arg2, arg3, arg4, v4, arg6);
        arg0.names_sold = arg0.names_sold + 1;
        let v7 = NamePaidInToken{
            payer     : v0,
            name      : arg3,
            coin_type : v1,
            amount    : v6,
            sui_fee   : v3,
        };
        0x2::event::emit<NamePaidInToken>(v7);
    }

    public fun remove_token<T0>(arg0: &GatewayAdminCap, arg1: &mut Gateway) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = TokenKey{t: v0};
        assert!(0x2::dynamic_field::exists<TokenKey>(&arg1.id, v1), 0);
        let v2 = TokenKey{t: v0};
        let TokenConfig {
            fee_base        : _,
            min_fee_base    : _,
            max_fee_base    : _,
            max_step_bps    : _,
            enabled         : _,
            collected       : v8,
            names_sold      : _,
            total_collected : _,
            fee_updated_ms  : _,
        } = 0x2::dynamic_field::remove<TokenKey, TokenConfig<T0>>(&mut arg1.id, v2);
        let v12 = v8;
        assert!(0x2::balance::value<T0>(&v12) == 0, 11);
        0x2::balance::destroy_zero<T0>(v12);
        let (v13, v14) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg1.tokens, &v0);
        if (v13) {
            0x1::vector::remove<0x1::type_name::TypeName>(&mut arg1.tokens, v14);
        };
        let v15 = TokenRemoved{coin_type: v0};
        0x2::event::emit<TokenRemoved>(v15);
    }

    public fun revoke_keeper(arg0: &GatewayAdminCap, arg1: &mut Gateway, arg2: 0x2::object::ID) {
        if (0x2::vec_set::contains<0x2::object::ID>(&arg1.keepers, &arg2)) {
            0x2::vec_set::remove<0x2::object::ID>(&mut arg1.keepers, &arg2);
        };
        let v0 = KeeperRevoked{keeper: arg2};
        0x2::event::emit<KeeperRevoked>(v0);
    }

    public fun set_max_sui_fee(arg0: &GatewayAdminCap, arg1: &mut Gateway, arg2: u64) {
        arg1.max_sui_fee = arg2;
        let v0 = MaxSuiFeeUpdated{max_sui_fee: arg2};
        0x2::event::emit<MaxSuiFeeUpdated>(v0);
    }

    public fun set_paused(arg0: &GatewayAdminCap, arg1: &mut Gateway, arg2: bool) {
        arg1.paused = arg2;
        let v0 = PausedUpdated{paused: arg2};
        0x2::event::emit<PausedUpdated>(v0);
    }

    public fun set_token_bounds<T0>(arg0: &GatewayAdminCap, arg1: &mut Gateway, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = config_mut<T0>(arg1, v0);
        assert_bounds(v1.fee_base, arg2, arg3, arg4);
        v1.min_fee_base = arg2;
        v1.max_fee_base = arg3;
        v1.max_step_bps = arg4;
        let v2 = TokenBoundsUpdated{
            coin_type    : v0,
            min_fee_base : arg2,
            max_fee_base : arg3,
            max_step_bps : arg4,
        };
        0x2::event::emit<TokenBoundsUpdated>(v2);
    }

    public fun set_token_enabled<T0>(arg0: &GatewayAdminCap, arg1: &mut Gateway, arg2: bool) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        config_mut<T0>(arg1, v0).enabled = arg2;
        let v1 = TokenEnabledUpdated{
            coin_type : v0,
            enabled   : arg2,
        };
        0x2::event::emit<TokenEnabledUpdated>(v1);
    }

    public fun set_token_fee<T0>(arg0: &GatewayAdminCap, arg1: &mut Gateway, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_fee(arg2);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = config_mut<T0>(arg1, v0);
        v1.fee_base = arg2;
        if (arg2 < v1.min_fee_base) {
            v1.min_fee_base = arg2;
        };
        if (arg2 > v1.max_fee_base) {
            v1.max_fee_base = arg2;
        };
        v1.fee_updated_ms = 0x2::clock::timestamp_ms(arg3);
        let v2 = TokenFeeUpdated{
            coin_type    : v0,
            old_fee_base : v1.fee_base,
            new_fee_base : arg2,
            by_keeper    : false,
        };
        0x2::event::emit<TokenFeeUpdated>(v2);
    }

    public fun sui_float(arg0: &Gateway) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_float)
    }

    public fun token_bounds<T0>(arg0: &Gateway) : (u64, u64, u64) {
        let v0 = config<T0>(arg0);
        (v0.min_fee_base, v0.max_fee_base, v0.max_step_bps)
    }

    public fun token_collected<T0>(arg0: &Gateway) : u64 {
        0x2::balance::value<T0>(&config<T0>(arg0).collected)
    }

    public fun token_enabled<T0>(arg0: &Gateway) : bool {
        config<T0>(arg0).enabled
    }

    public fun token_fee_base<T0>(arg0: &Gateway) : u64 {
        config<T0>(arg0).fee_base
    }

    public fun token_fee_updated_ms<T0>(arg0: &Gateway) : u64 {
        config<T0>(arg0).fee_updated_ms
    }

    public fun token_names_sold<T0>(arg0: &Gateway) : u64 {
        config<T0>(arg0).names_sold
    }

    public fun token_total_collected<T0>(arg0: &Gateway) : u64 {
        config<T0>(arg0).total_collected
    }

    public fun tokens(arg0: &Gateway) : &vector<0x1::type_name::TypeName> {
        &arg0.tokens
    }

    public fun withdraw_sui(arg0: &GatewayAdminCap, arg1: &mut Gateway, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.sui_float, arg2, arg3), 0x2::tx_context::sender(arg3));
        let v0 = FloatWithdrawn{
            amount    : arg2,
            new_total : 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_float),
        };
        0x2::event::emit<FloatWithdrawn>(v0);
    }

    // decompiled from Move bytecode v7
}

