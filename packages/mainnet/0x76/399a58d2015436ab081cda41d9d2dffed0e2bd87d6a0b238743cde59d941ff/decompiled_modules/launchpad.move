module 0x76399a58d2015436ab081cda41d9d2dffed0e2bd87d6a0b238743cde59d941ff::launchpad {
    struct InitCap has key {
        id: 0x2::object::UID,
    }

    struct AdapterCap has key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        collateral: 0x1::option::Option<0x1::type_name::TypeName>,
        unit: u64,
        platform: address,
        adapter: 0x1::option::Option<0x1::type_name::TypeName>,
    }

    struct Vault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        founder: address,
        tax_ppm: u64,
        backing: 0x2::balance::Balance<T1>,
        cap: 0x2::coin::TreasuryCap<T0>,
        pool_tokens: 0x2::balance::Balance<T0>,
        pool_dollars: 0x2::balance::Balance<T1>,
        virtual_dollars: u64,
        opened_ms: u64,
        shield_ms: u64,
        shield_ppm: u64,
        target: 0x1::option::Option<0x1::type_name::TypeName>,
    }

    struct TargetKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Converted<phantom T0, phantom T1> {
        bal: 0x2::balance::Balance<T1>,
        dollars_in: u64,
    }

    struct Launched has copy, drop {
        vault: 0x2::object::ID,
        token: 0x1::type_name::TypeName,
        founder: address,
        supply: u64,
        collateral: u64,
        first_buy: u64,
        tax_ppm: u64,
    }

    struct Traded has copy, drop {
        vault: 0x2::object::ID,
        trader: address,
        buy: bool,
        dollars: u64,
        tokens: u64,
        fee: u64,
        tax: u64,
    }

    struct Redeemed has copy, drop {
        vault: 0x2::object::ID,
        holder: address,
        burned: u64,
        payout: u64,
    }

    struct Funded has copy, drop {
        vault: 0x2::object::ID,
        from: address,
        amount: u64,
    }

    public fun backing<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.backing)
    }

    public fun buy<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &Config, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        buy_inner<T0, T1>(arg0, arg2, arg3, false, arg1, arg4, arg5)
    }

    fun buy_inner<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: bool, arg4: &Config, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 6);
        let v1 = ((0x2::balance::value<T1>(&arg0.pool_dollars) + arg0.virtual_dollars) as u128);
        let v2 = 0x2::coin::into_balance<T1>(arg1);
        let (v3, v4, v5, v6) = if (arg3) {
            (v2, 0, 0, 0)
        } else {
            let v7 = mul_ppm(v0, snipe_ppm_at((0x2::clock::timestamp_ms(arg5) - arg0.opened_ms) / 1000));
            0x2::balance::join<T1>(&mut arg0.pool_dollars, 0x2::balance::split<T1>(&mut v2, v7));
            let (v8, v9, v10) = route<T0, T1>(arg0, arg4, 0, v2, arg6);
            (v8, v9, v10, v7)
        };
        let v11 = v3;
        let v12 = 0x2::balance::value<T1>(&v11);
        let v13 = (((0x2::balance::value<T0>(&arg0.pool_tokens) as u128) * (v12 as u128) / (v1 + (v12 as u128))) as u64);
        assert!(v13 >= arg2 && v13 > 0, 11);
        0x2::balance::join<T1>(&mut arg0.pool_dollars, v11);
        let v14 = Traded{
            vault   : 0x2::object::id<Vault<T0, T1>>(arg0),
            trader  : 0x2::tx_context::sender(arg6),
            buy     : true,
            dollars : v0,
            tokens  : v13,
            fee     : v4 + v6,
            tax     : v5,
        };
        0x2::event::emit<Traded>(v14);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.pool_tokens, v13), arg6)
    }

    public fun circulating<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::coin::total_supply<T0>(&arg0.cap) - 0x2::balance::value<T0>(&arg0.pool_tokens)
    }

    public fun converted<T0, T1, T2: drop>(arg0: &Config, arg1: T2, arg2: 0x2::coin::Coin<T1>, arg3: u64) : Converted<T0, T1> {
        assert!(0x1::option::is_some<0x1::type_name::TypeName>(&arg0.adapter) && *0x1::option::borrow<0x1::type_name::TypeName>(&arg0.adapter) == 0x1::type_name::with_defining_ids<T2>(), 16);
        Converted<T0, T1>{
            bal        : 0x2::coin::into_balance<T1>(arg2),
            dollars_in : arg3,
        }
    }

    public fun floor_price<T0, T1>(arg0: &Vault<T0, T1>) : u256 {
        let v0 = circulating<T0, T1>(arg0);
        if (v0 == 0) {
            return 0
        };
        (0x2::balance::value<T1>(&arg0.backing) as u256) * 1000000000000000000000000000000000000 / (v0 as u256)
    }

    public fun founder<T0, T1>(arg0: &Vault<T0, T1>) : address {
        arg0.founder
    }

    public fun fund<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 6);
        0x2::balance::join<T1>(&mut arg0.backing, 0x2::coin::into_balance<T1>(arg1));
        let v1 = Funded{
            vault  : 0x2::object::id<Vault<T0, T1>>(arg0),
            from   : 0x2::tx_context::sender(arg2),
            amount : v0,
        };
        0x2::event::emit<Funded>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = InitCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<InitCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = AdapterCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdapterCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = Config{
            id         : 0x2::object::new(arg0),
            collateral : 0x1::option::none<0x1::type_name::TypeName>(),
            unit       : 0,
            platform   : @0x0,
            adapter    : 0x1::option::none<0x1::type_name::TypeName>(),
        };
        0x2::transfer::share_object<Config>(v2);
    }

    public fun initialize<T0>(arg0: InitCap, arg1: &mut Config, arg2: u8, arg3: address) {
        let InitCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        let v1 = 1;
        let v2 = 0;
        while (v2 < arg2) {
            v1 = v1 * 10;
            v2 = v2 + 1;
        };
        arg1.collateral = 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<T0>());
        arg1.unit = v1;
        arg1.platform = arg3;
    }

    public fun launch<T0, T1>(arg0: &Config, arg1: 0x2::coin::TreasuryCap<T0>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x1::option::is_some<0x1::type_name::TypeName>(&arg0.collateral), 3);
        assert!(*0x1::option::borrow<0x1::type_name::TypeName>(&arg0.collateral) == 0x1::type_name::with_defining_ids<T1>(), 7);
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 8);
        assert!(arg2 > 0, 5);
        let v0 = arg0.unit;
        let v1 = 0x2::coin::value<T1>(&arg3);
        let v2 = 0x2::coin::value<T1>(&arg4);
        assert!(v1 >= 20 * v0, 4);
        assert!(v2 >= 100 * v0 && v2 <= 500 * v0, 9);
        assert!(arg5 >= 10000 && arg5 <= 50000, 10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg4, mul_ppm(v2, 20000), arg8), arg0.platform);
        let v3 = Vault<T0, T1>{
            id              : 0x2::object::new(arg8),
            founder         : 0x2::tx_context::sender(arg8),
            tax_ppm         : arg5,
            backing         : 0x2::coin::into_balance<T1>(arg3),
            cap             : arg1,
            pool_tokens     : 0x2::coin::mint_balance<T0>(&mut arg1, arg2),
            pool_dollars    : 0x2::balance::zero<T1>(),
            virtual_dollars : 3500 * v0,
            opened_ms       : 0x2::clock::timestamp_ms(arg7),
            shield_ms       : 0,
            shield_ppm      : 0,
            target          : 0x1::option::none<0x1::type_name::TypeName>(),
        };
        let v4 = Launched{
            vault      : 0x2::object::id<Vault<T0, T1>>(&v3),
            token      : 0x1::type_name::with_defining_ids<T0>(),
            founder    : 0x2::tx_context::sender(arg8),
            supply     : arg2,
            collateral : v1,
            first_buy  : v2,
            tax_ppm    : arg5,
        };
        0x2::event::emit<Launched>(v4);
        let v5 = &mut v3;
        0x2::transfer::share_object<Vault<T0, T1>>(v3);
        buy_inner<T0, T1>(v5, arg4, arg6, true, arg0, arg7, arg8)
    }

    public fun launch_backed<T0, T1, T2>(arg0: &Config, arg1: 0x2::coin::TreasuryCap<T0>, arg2: u64, arg3: Converted<T1, T2>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let Converted {
            bal        : v0,
            dollars_in : v1,
        } = arg3;
        let v2 = v0;
        assert!(0x1::option::is_some<0x1::type_name::TypeName>(&arg0.collateral), 3);
        assert!(*0x1::option::borrow<0x1::type_name::TypeName>(&arg0.collateral) == 0x1::type_name::with_defining_ids<T1>(), 7);
        assert!(0x1::type_name::with_defining_ids<T2>() != 0x1::type_name::with_defining_ids<T1>(), 15);
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 8);
        assert!(arg2 > 0, 5);
        let v3 = arg0.unit;
        let v4 = 0x2::coin::value<T1>(&arg4);
        assert!(v1 >= 20 * v3 && 0x2::balance::value<T2>(&v2) > 0, 4);
        assert!(v4 >= 100 * v3 && v4 <= 500 * v3, 9);
        assert!(arg5 >= 10000 && arg5 <= 50000, 10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg4, mul_ppm(v4, 20000), arg8), arg0.platform);
        let v5 = Vault<T0, T1>{
            id              : 0x2::object::new(arg8),
            founder         : 0x2::tx_context::sender(arg8),
            tax_ppm         : arg5,
            backing         : 0x2::balance::zero<T1>(),
            cap             : arg1,
            pool_tokens     : 0x2::coin::mint_balance<T0>(&mut arg1, arg2),
            pool_dollars    : 0x2::balance::zero<T1>(),
            virtual_dollars : 3500 * v3,
            opened_ms       : 0x2::clock::timestamp_ms(arg7),
            shield_ms       : 0,
            shield_ppm      : 0,
            target          : 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<T2>()),
        };
        let v6 = TargetKey{dummy_field: false};
        0x2::dynamic_field::add<TargetKey, 0x2::balance::Balance<T2>>(&mut v5.id, v6, v2);
        let v7 = Launched{
            vault      : 0x2::object::id<Vault<T0, T1>>(&v5),
            token      : 0x1::type_name::with_defining_ids<T0>(),
            founder    : 0x2::tx_context::sender(arg8),
            supply     : arg2,
            collateral : v1,
            first_buy  : v4,
            tax_ppm    : arg5,
        };
        0x2::event::emit<Launched>(v7);
        let v8 = &mut v5;
        0x2::transfer::share_object<Vault<T0, T1>>(v5);
        buy_inner<T0, T1>(v8, arg4, arg6, true, arg0, arg7, arg8)
    }

    fun mul_ppm(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (1000000 as u128)) as u64)
    }

    public fun pool_dollars<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.pool_dollars)
    }

    public fun pool_tokens<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.pool_tokens)
    }

    public fun redeem<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x1::option::is_none<0x1::type_name::TypeName>(&arg0.target), 13);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 6);
        let v1 = circulating<T0, T1>(arg0);
        assert!(v0 <= v1, 12);
        let v2 = (((0x2::balance::value<T1>(&arg0.backing) as u128) * (v0 as u128) / (v1 as u128)) as u64);
        0x2::coin::burn<T0>(&mut arg0.cap, arg1);
        let v3 = Redeemed{
            vault  : 0x2::object::id<Vault<T0, T1>>(arg0),
            holder : 0x2::tx_context::sender(arg2),
            burned : v0,
            payout : v2,
        };
        0x2::event::emit<Redeemed>(v3);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.backing, v2), arg2)
    }

    public fun redeem_backed<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        assert!(0x1::option::is_some<0x1::type_name::TypeName>(&arg0.target) && *0x1::option::borrow<0x1::type_name::TypeName>(&arg0.target) == 0x1::type_name::with_defining_ids<T2>(), 14);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 6);
        let v1 = circulating<T0, T1>(arg0);
        assert!(v0 <= v1, 12);
        let v2 = (((0x2::balance::value<T1>(&arg0.backing) as u128) * (v0 as u128) / (v1 as u128)) as u64);
        let v3 = TargetKey{dummy_field: false};
        let v4 = 0x2::dynamic_field::borrow_mut<TargetKey, 0x2::balance::Balance<T2>>(&mut arg0.id, v3);
        let v5 = 0x2::coin::from_balance<T2>(0x2::balance::split<T2>(v4, (((0x2::balance::value<T2>(v4) as u128) * (v0 as u128) / (v1 as u128)) as u64)), arg2);
        0x2::coin::burn<T0>(&mut arg0.cap, arg1);
        let v6 = Redeemed{
            vault  : 0x2::object::id<Vault<T0, T1>>(arg0),
            holder : 0x2::tx_context::sender(arg2),
            burned : v0,
            payout : v2,
        };
        0x2::event::emit<Redeemed>(v6);
        (0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.backing, v2), arg2), v5)
    }

    public fun register_adapter<T0: drop>(arg0: AdapterCap, arg1: &mut Config) {
        let AdapterCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        arg1.adapter = 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<T0>());
    }

    fun route<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &Config, arg2: u64, arg3: 0x2::balance::Balance<T1>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, u64, u64) {
        let v0 = 0x2::balance::value<T1>(&arg3);
        let v1 = mul_ppm(v0, 3000);
        let v2 = mul_ppm(v0, 10000);
        let v3 = mul_ppm(v0, 7000);
        let v4 = mul_ppm(v0, arg0.tax_ppm + arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg3, v1), arg4), arg0.founder);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg3, v2), arg4), arg1.platform);
        0x2::balance::join<T1>(&mut arg0.pool_dollars, 0x2::balance::split<T1>(&mut arg3, v3));
        0x2::balance::join<T1>(&mut arg0.backing, 0x2::balance::split<T1>(&mut arg3, v4));
        (arg3, v1 + v2 + v3, v4)
    }

    public fun sell<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &Config, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 6);
        let v1 = circulating<T0, T1>(arg0);
        let v2 = if (v1 == 0) {
            0
        } else {
            (((v0 as u128) * (1000000 as u128) / (v1 as u128)) as u64)
        };
        let v3 = 0x2::clock::timestamp_ms(arg4);
        let v4 = if (arg0.shield_ms == v3) {
            arg0.shield_ppm + v2
        } else {
            v2
        };
        arg0.shield_ms = v3;
        arg0.shield_ppm = v4;
        let v5 = if (v4 <= 5000) {
            0
        } else {
            v4 - 5000
        };
        let v6 = v5;
        if (v5 > 30000) {
            v6 = 30000;
        };
        let v7 = 0x2::balance::value<T1>(&arg0.pool_dollars);
        let v8 = ((((v7 + arg0.virtual_dollars) as u128) * (v0 as u128) / ((0x2::balance::value<T0>(&arg0.pool_tokens) as u128) + (v0 as u128))) as u64);
        let v9 = v8;
        if (v8 > v7) {
            v9 = v7;
        };
        0x2::balance::join<T0>(&mut arg0.pool_tokens, 0x2::coin::into_balance<T0>(arg2));
        let v10 = 0x2::balance::split<T1>(&mut arg0.pool_dollars, v9);
        let (v11, v12, v13) = route<T0, T1>(arg0, arg1, v6, v10, arg5);
        let v14 = v11;
        let v15 = 0x2::balance::value<T1>(&v14);
        assert!(v15 >= arg3, 11);
        let v16 = Traded{
            vault   : 0x2::object::id<Vault<T0, T1>>(arg0),
            trader  : 0x2::tx_context::sender(arg5),
            buy     : false,
            dollars : v15,
            tokens  : v0,
            fee     : v12,
            tax     : v13,
        };
        0x2::event::emit<Traded>(v16);
        0x2::coin::from_balance<T1>(v14, arg5)
    }

    public fun snipe_ppm_at(arg0: u64) : u64 {
        if (arg0 >= 5) {
            0
        } else {
            990000 >> ((2 * arg0) as u8)
        }
    }

    public fun supply<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::coin::total_supply<T0>(&arg0.cap)
    }

    public fun target_backing<T0, T1, T2>(arg0: &Vault<T0, T1>) : u64 {
        assert!(0x1::option::is_some<0x1::type_name::TypeName>(&arg0.target) && *0x1::option::borrow<0x1::type_name::TypeName>(&arg0.target) == 0x1::type_name::with_defining_ids<T2>(), 14);
        let v0 = TargetKey{dummy_field: false};
        0x2::balance::value<T2>(0x2::dynamic_field::borrow<TargetKey, 0x2::balance::Balance<T2>>(&arg0.id, v0))
    }

    public fun virtual_dollars<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.virtual_dollars
    }

    // decompiled from Move bytecode v7
}

