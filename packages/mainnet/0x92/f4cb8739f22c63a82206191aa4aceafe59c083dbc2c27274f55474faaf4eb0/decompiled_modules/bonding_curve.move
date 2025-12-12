module 0x92f4cb8739f22c63a82206191aa4aceafe59c083dbc2c27274f55474faaf4eb0::bonding_curve {
    struct LaunchpadConfig has key {
        id: 0x2::object::UID,
        project_wallet: address,
        total_tokens_created: u64,
        total_volume: u128,
        total_fees_collected: u128,
        is_paused: bool,
    }

    struct CurveParams has copy, drop, store {
        curve_type: u8,
        base_price: u128,
        slope: u128,
        exponent: u128,
        inflection_point: u128,
        max_price: u128,
        custom_points_x: vector<u128>,
        custom_points_y: vector<u128>,
    }

    struct BondingPool<phantom T0> has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        sui_reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        virtual_sui_reserve: u128,
        current_supply: u128,
        max_supply: u128,
        curve_params: CurveParams,
        graduation_mcap: u64,
        status: u8,
        creator: address,
        holder_count: u64,
        created_at: u64,
        graduated_at: 0x1::option::Option<u64>,
        total_volume: u128,
        total_trades: u64,
        dex_pool_id: 0x1::option::Option<address>,
    }

    struct ReferralRegistry has key {
        id: 0x2::object::UID,
        referrals: 0x2::table::Table<address, address>,
        earnings: 0x2::table::Table<address, u128>,
        total_distributed: u128,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct FeeConfig has key {
        id: 0x2::object::UID,
        creation_fee: u64,
        total_trading_fee_bps: u64,
        pool_fee_bps: u64,
        project_fee_bps: u64,
        project_wallet_percent: u64,
        creator_percent: u64,
        referrer_percent: u64,
        default_graduation_mcap: u64,
    }

    struct Blacklist has key {
        id: 0x2::object::UID,
        addresses: 0x2::table::Table<address, bool>,
        banned_referrers: 0x2::table::Table<address, bool>,
    }

    struct AdminRegistry has key {
        id: 0x2::object::UID,
        admins: 0x2::table::Table<0x2::object::ID, address>,
        admin_count: u64,
        max_admins: u64,
    }

    struct TokenCreated has copy, drop {
        pool_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        curve_type: u8,
        timestamp: u64,
    }

    struct TokenBought has copy, drop {
        pool_id: 0x2::object::ID,
        buyer: address,
        sui_amount: u64,
        tokens_received: u64,
        new_price: u128,
        referrer: 0x1::option::Option<address>,
        timestamp: u64,
    }

    struct TokenSold has copy, drop {
        pool_id: 0x2::object::ID,
        seller: address,
        tokens_amount: u64,
        sui_received: u64,
        new_price: u128,
        timestamp: u64,
    }

    struct FeesDistributed has copy, drop {
        pool_id: 0x2::object::ID,
        pool_fee: u64,
        project_fee: u64,
        creator_fee: u64,
        referrer_fee: u64,
        timestamp: u64,
    }

    struct TokenGraduated has copy, drop {
        pool_id: 0x2::object::ID,
        final_mcap: u128,
        total_holders: u64,
        liquidity_migrated: u64,
        timestamp: u64,
    }

    struct ReferrerRegistered has copy, drop {
        pool_id: 0x2::object::ID,
        trader: address,
        referrer: address,
        timestamp: u64,
    }

    struct FeesUpdated has copy, drop {
        creation_fee: u64,
        total_trading_fee_bps: u64,
        pool_fee_bps: u64,
        project_fee_bps: u64,
        timestamp: u64,
    }

    struct FeeDistributionUpdated has copy, drop {
        project_wallet_percent: u64,
        creator_percent: u64,
        referrer_percent: u64,
        timestamp: u64,
    }

    struct AddressBlacklisted has copy, drop {
        address: address,
        is_blacklisted: bool,
        timestamp: u64,
    }

    struct ReferrerBanned has copy, drop {
        referrer: address,
        is_banned: bool,
        timestamp: u64,
    }

    struct PoolMetadataUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct PoolOwnershipTransferred has copy, drop {
        pool_id: 0x2::object::ID,
        old_creator: address,
        new_creator: address,
        timestamp: u64,
    }

    struct EmergencyWithdraw has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
        recipient: address,
        timestamp: u64,
    }

    struct AdminCapCreated has copy, drop {
        admin_cap_id: 0x2::object::ID,
        recipient: address,
        timestamp: u64,
    }

    struct AdminCapRevoked has copy, drop {
        admin_cap_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct GraduationCancelled has copy, drop {
        pool_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct PoolMigrated has copy, drop {
        pool_id: 0x2::object::ID,
        dex_pool_id: address,
        sui_migrated: u64,
        tokens_minted: u64,
        timestamp: u64,
    }

    public entry fun ban_referrer(arg0: &AdminCap, arg1: &mut Blacklist, arg2: address, arg3: &0x2::clock::Clock) {
        if (!0x2::table::contains<address, bool>(&arg1.banned_referrers, arg2)) {
            0x2::table::add<address, bool>(&mut arg1.banned_referrers, arg2, true);
        } else {
            *0x2::table::borrow_mut<address, bool>(&mut arg1.banned_referrers, arg2) = true;
        };
        let v0 = ReferrerBanned{
            referrer  : arg2,
            is_banned : true,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ReferrerBanned>(v0);
    }

    public entry fun blacklist_address(arg0: &AdminCap, arg1: &mut Blacklist, arg2: address, arg3: &0x2::clock::Clock) {
        if (!0x2::table::contains<address, bool>(&arg1.addresses, arg2)) {
            0x2::table::add<address, bool>(&mut arg1.addresses, arg2, true);
        } else {
            *0x2::table::borrow_mut<address, bool>(&mut arg1.addresses, arg2) = true;
        };
        let v0 = AddressBlacklisted{
            address        : arg2,
            is_blacklisted : true,
            timestamp      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<AddressBlacklisted>(v0);
    }

    public entry fun buy<T0>(arg0: &mut LaunchpadConfig, arg1: &FeeConfig, arg2: &Blacklist, arg3: &mut BondingPool<T0>, arg4: &mut ReferralRegistry, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        buy_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x1::option::none<address>(), arg7, arg8);
    }

    fun buy_internal<T0>(arg0: &mut LaunchpadConfig, arg1: &FeeConfig, arg2: &Blacklist, arg3: &mut BondingPool<T0>, arg4: &mut ReferralRegistry, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: 0x1::option::Option<address>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.status == 0, 2);
        assert!(!arg0.is_paused, 2);
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(!is_blacklisted(arg2, v0), 7);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg5);
        assert!(v1 > 0, 6);
        let v2 = 0x2::clock::timestamp_ms(arg8);
        let v3 = 0x2::object::id<BondingPool<T0>>(arg3);
        let v4 = calculate_fee_dynamic(v1, arg1.total_trading_fee_bps);
        let v5 = calculate_fee_dynamic(v1, arg1.project_fee_bps);
        let v6 = calculate_tokens_for_sui<T0>(arg3, ((v1 - v4) as u128));
        assert!((v6 as u64) >= arg6, 4);
        assert!(arg3.current_supply + v6 <= arg3.max_supply, 13);
        let v7 = 0x2::coin::into_balance<0x2::sui::SUI>(arg5);
        0x2::balance::join<0x2::sui::SUI>(&mut arg3.sui_reserve, 0x2::balance::split<0x2::sui::SUI>(&mut v7, calculate_fee_dynamic(v1, arg1.pool_fee_bps)));
        let (v8, v9) = get_or_register_referrer_with_config(arg4, arg2, arg1, v0, arg7, v3, v5, v2);
        let v10 = &mut v7;
        distribute_project_fees_dynamic<T0>(arg0, arg1, arg3, arg4, v10, v5, v8, v9, v2, arg9);
        0x2::balance::join<0x2::sui::SUI>(&mut arg3.sui_reserve, v7);
        let v11 = 0x2::coin::mint<T0>(&mut arg3.treasury_cap, (v6 as u64), arg9);
        arg3.current_supply = arg3.current_supply + v6;
        arg3.total_volume = arg3.total_volume + (v1 as u128);
        arg3.total_trades = arg3.total_trades + 1;
        arg0.total_volume = arg0.total_volume + (v1 as u128);
        arg0.total_fees_collected = arg0.total_fees_collected + (v4 as u128);
        let v12 = TokenBought{
            pool_id         : v3,
            buyer           : v0,
            sui_amount      : v1,
            tokens_received : (v6 as u64),
            new_price       : calculate_current_price<T0>(arg3),
            referrer        : v8,
            timestamp       : v2,
        };
        0x2::event::emit<TokenBought>(v12);
        check_graduation<T0>(arg3, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v11, v0);
    }

    public entry fun buy_with_referrer<T0>(arg0: &mut LaunchpadConfig, arg1: &FeeConfig, arg2: &Blacklist, arg3: &mut BondingPool<T0>, arg4: &mut ReferralRegistry, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: address, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 != 0x2::tx_context::sender(arg9), 10);
        buy_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x1::option::some<address>(arg7), arg8, arg9);
    }

    public fun calculate_current_price<T0>(arg0: &BondingPool<T0>) : u128 {
        let v0 = &arg0.curve_params;
        if (v0.curve_type == 0) {
            calculate_linear_price(arg0.current_supply, v0)
        } else if (v0.curve_type == 1) {
            calculate_exponential_price(arg0.current_supply, v0)
        } else if (v0.curve_type == 2) {
            calculate_sigmoid_price(arg0.current_supply, v0)
        } else {
            calculate_custom_price(arg0.current_supply, v0)
        }
    }

    fun calculate_custom_price(arg0: u128, arg1: &CurveParams) : u128 {
        let v0 = &arg1.custom_points_x;
        let v1 = &arg1.custom_points_y;
        let v2 = 0x1::vector::length<u128>(v0);
        if (v2 == 0) {
            return arg1.base_price
        };
        let v3 = 0;
        while (v3 < v2 - 1) {
            let v4 = *0x1::vector::borrow<u128>(v0, v3);
            let v5 = *0x1::vector::borrow<u128>(v0, v3 + 1);
            if (arg0 >= v4 && arg0 < v5) {
                let v6 = *0x1::vector::borrow<u128>(v1, v3);
                let v7 = *0x1::vector::borrow<u128>(v1, v3 + 1);
                let v8 = if (v7 >= v6) {
                    v7 - v6
                } else {
                    0
                };
                return v6 + safe_mul_div(v8, arg0 - v4, v5 - v4)
            };
            v3 = v3 + 1;
        };
        *0x1::vector::borrow<u128>(v1, v2 - 1)
    }

    fun calculate_exponential_price(arg0: u128, arg1: &CurveParams) : u128 {
        let v0 = safe_mul_div(arg1.exponent, arg0, 1000000000000000000);
        safe_mul_div(arg1.base_price, 1000000000000000000 + v0 + safe_mul_div(v0, v0, 1000000000000000000), 1000000000000000000)
    }

    fun calculate_fee(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 10000) as u64)
    }

    fun calculate_fee_dynamic(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 10000) as u64)
    }

    fun calculate_linear_price(arg0: u128, arg1: &CurveParams) : u128 {
        arg1.base_price + safe_mul_div(arg0, arg1.slope, 1000000000000000000)
    }

    fun calculate_sigmoid_price(arg0: u128, arg1: &CurveParams) : u128 {
        let v0 = arg1.base_price;
        let v1 = arg1.max_price;
        let v2 = arg1.inflection_point;
        if (v1 <= v0) {
            return v0
        };
        let v3 = if (arg0 >= v2) {
            safe_mul_div(arg0 - v2, arg1.slope, 1000000000000000000)
        } else {
            0
        };
        v0 + safe_mul_div(v1 - v0, safe_mul_div(v3, 1000000000000000000, 1000000000000000000 + v3), 1000000000000000000)
    }

    public fun calculate_sui_for_tokens<T0>(arg0: &BondingPool<T0>, arg1: u128) : u128 {
        safe_mul_div(arg1, calculate_current_price<T0>(arg0), 1000000000000000000)
    }

    public fun calculate_tokens_for_sui<T0>(arg0: &BondingPool<T0>, arg1: u128) : u128 {
        let v0 = calculate_current_price<T0>(arg0);
        if (v0 == 0) {
            return 0
        };
        safe_mul_div(arg1, 1000000000000000000, v0)
    }

    public entry fun cancel_graduation<T0>(arg0: &AdminCap, arg1: &mut BondingPool<T0>, arg2: &0x2::clock::Clock) {
        assert!(arg1.status == 1, 2);
        arg1.status = 0;
        arg1.graduated_at = 0x1::option::none<u64>();
        let v0 = GraduationCancelled{
            pool_id   : 0x2::object::id<BondingPool<T0>>(arg1),
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<GraduationCancelled>(v0);
    }

    fun check_graduation<T0>(arg0: &mut BondingPool<T0>, arg1: &0x2::clock::Clock) {
        if (arg0.status != 0) {
            return
        };
        if ((safe_mul_div(arg0.current_supply, calculate_current_price<T0>(arg0), 1000000000000000000) as u64) >= arg0.graduation_mcap) {
            graduate_internal<T0>(arg0, arg1);
        };
    }

    public entry fun create_admin_cap(arg0: &AdminCap, arg1: &mut AdminRegistry, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.admin_count < arg1.max_admins, 9);
        let v0 = AdminCap{id: 0x2::object::new(arg4)};
        let v1 = 0x2::object::id<AdminCap>(&v0);
        0x2::table::add<0x2::object::ID, address>(&mut arg1.admins, v1, arg2);
        arg1.admin_count = arg1.admin_count + 1;
        let v2 = AdminCapCreated{
            admin_cap_id : v1,
            recipient    : arg2,
            timestamp    : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<AdminCapCreated>(v2);
        0x2::transfer::transfer<AdminCap>(v0, arg2);
    }

    public entry fun create_token_exponential<T0: drop>(arg0: &mut LaunchpadConfig, arg1: &FeeConfig, arg2: T0, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u8, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: 0x2::coin::Coin<0x2::sui::SUI>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg12) >= arg1.creation_fee, 1);
        let v0 = CurveParams{
            curve_type       : 1,
            base_price       : (arg8 as u128),
            slope            : 0,
            exponent         : (arg9 as u128),
            inflection_point : 0,
            max_price        : 0,
            custom_points_x  : 0x1::vector::empty<u128>(),
            custom_points_y  : 0x1::vector::empty<u128>(),
        };
        create_token_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, v0, arg10, arg11, arg12, arg13, arg14);
    }

    fun create_token_internal<T0: drop>(arg0: &mut LaunchpadConfig, arg1: &FeeConfig, arg2: T0, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u8, arg8: CurveParams, arg9: u64, arg10: u64, arg11: 0x2::coin::Coin<0x2::sui::SUI>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg13);
        let v1 = 0x2::clock::timestamp_ms(arg12);
        let (v2, v3) = 0x2::coin::create_currency<T0>(arg2, arg7, arg4, arg3, arg5, 0x1::option::none<0x2::url::Url>(), arg13);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg11, arg1.creation_fee, arg13), arg0.project_wallet);
        if (0x2::coin::value<0x2::sui::SUI>(&arg11) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg11, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg11);
        };
        let v4 = if (arg10 > 0) {
            arg10
        } else {
            arg1.default_graduation_mcap
        };
        let v5 = BondingPool<T0>{
            id                  : 0x2::object::new(arg13),
            name                : 0x1::string::utf8(arg3),
            symbol              : 0x1::string::utf8(arg4),
            description         : 0x1::string::utf8(arg5),
            image_url           : 0x1::string::utf8(arg6),
            treasury_cap        : v2,
            sui_reserve         : 0x2::balance::zero<0x2::sui::SUI>(),
            virtual_sui_reserve : (arg9 as u128),
            current_supply      : 0,
            max_supply          : 1000000000000000000,
            curve_params        : arg8,
            graduation_mcap     : v4,
            status              : 0,
            creator             : v0,
            holder_count        : 0,
            created_at          : v1,
            graduated_at        : 0x1::option::none<u64>(),
            total_volume        : 0,
            total_trades        : 0,
            dex_pool_id         : 0x1::option::none<address>(),
        };
        arg0.total_tokens_created = arg0.total_tokens_created + 1;
        let v6 = TokenCreated{
            pool_id    : 0x2::object::id<BondingPool<T0>>(&v5),
            creator    : v0,
            name       : 0x1::string::utf8(arg3),
            symbol     : 0x1::string::utf8(arg4),
            curve_type : arg8.curve_type,
            timestamp  : v1,
        };
        0x2::event::emit<TokenCreated>(v6);
        0x2::transfer::share_object<BondingPool<T0>>(v5);
    }

    public entry fun create_token_linear<T0: drop>(arg0: &mut LaunchpadConfig, arg1: &FeeConfig, arg2: T0, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u8, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: 0x2::coin::Coin<0x2::sui::SUI>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg12) >= arg1.creation_fee, 1);
        let v0 = CurveParams{
            curve_type       : 0,
            base_price       : (arg8 as u128),
            slope            : (arg9 as u128),
            exponent         : 0,
            inflection_point : 0,
            max_price        : 0,
            custom_points_x  : 0x1::vector::empty<u128>(),
            custom_points_y  : 0x1::vector::empty<u128>(),
        };
        create_token_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, v0, arg10, arg11, arg12, arg13, arg14);
    }

    public entry fun create_token_sigmoid<T0: drop>(arg0: &mut LaunchpadConfig, arg1: &FeeConfig, arg2: T0, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u8, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: 0x2::coin::Coin<0x2::sui::SUI>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg14) >= arg1.creation_fee, 1);
        let v0 = CurveParams{
            curve_type       : 2,
            base_price       : (arg8 as u128),
            slope            : (arg11 as u128),
            exponent         : 0,
            inflection_point : (arg10 as u128),
            max_price        : (arg9 as u128),
            custom_points_x  : 0x1::vector::empty<u128>(),
            custom_points_y  : 0x1::vector::empty<u128>(),
        };
        create_token_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, v0, arg12, arg13, arg14, arg15, arg16);
    }

    fun distribute_project_fees_dynamic<T0>(arg0: &LaunchpadConfig, arg1: &FeeConfig, arg2: &BondingPool<T0>, arg3: &mut ReferralRegistry, arg4: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg5: u64, arg6: 0x1::option::Option<address>, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = arg5 * arg1.creator_percent / 100;
        let v1 = if (0x1::option::is_none<address>(&arg6)) {
            arg5 * arg1.project_wallet_percent / 100 + arg7
        } else {
            arg5 * arg1.project_wallet_percent / 100
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(arg4, v1), arg9), arg0.project_wallet);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(arg4, v0), arg9), arg2.creator);
        let v2 = if (0x1::option::is_some<address>(&arg6)) {
            let v3 = *0x1::option::borrow<address>(&arg6);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(arg4, arg7), arg9), v3);
            if (0x2::table::contains<address, u128>(&arg3.earnings, v3)) {
                let v4 = 0x2::table::borrow_mut<address, u128>(&mut arg3.earnings, v3);
                *v4 = *v4 + (arg7 as u128);
            } else {
                0x2::table::add<address, u128>(&mut arg3.earnings, v3, (arg7 as u128));
            };
            arg3.total_distributed = arg3.total_distributed + (arg7 as u128);
            arg7
        } else {
            0
        };
        let v5 = FeesDistributed{
            pool_id      : 0x2::object::id<BondingPool<T0>>(arg2),
            pool_fee     : 0,
            project_fee  : v1,
            creator_fee  : v0,
            referrer_fee : v2,
            timestamp    : arg8,
        };
        0x2::event::emit<FeesDistributed>(v5);
    }

    fun distribute_project_fees_sell_dynamic<T0>(arg0: &LaunchpadConfig, arg1: &FeeConfig, arg2: &BondingPool<T0>, arg3: &mut ReferralRegistry, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: 0x1::option::Option<address>, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = arg5 * arg1.creator_percent / 100;
        let v1 = if (0x1::option::is_none<address>(&arg6)) {
            arg5 * arg1.project_wallet_percent / 100 + arg7
        } else {
            arg5 * arg1.project_wallet_percent / 100
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg4, v1, arg9), arg0.project_wallet);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg4, v0, arg9), arg2.creator);
        let v2 = if (0x1::option::is_some<address>(&arg6)) {
            let v3 = *0x1::option::borrow<address>(&arg6);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg4, arg7, arg9), v3);
            if (0x2::table::contains<address, u128>(&arg3.earnings, v3)) {
                let v4 = 0x2::table::borrow_mut<address, u128>(&mut arg3.earnings, v3);
                *v4 = *v4 + (arg7 as u128);
            } else {
                0x2::table::add<address, u128>(&mut arg3.earnings, v3, (arg7 as u128));
            };
            arg3.total_distributed = arg3.total_distributed + (arg7 as u128);
            arg7
        } else {
            0
        };
        let v5 = FeesDistributed{
            pool_id      : 0x2::object::id<BondingPool<T0>>(arg2),
            pool_fee     : 0,
            project_fee  : v1,
            creator_fee  : v0,
            referrer_fee : v2,
            timestamp    : arg8,
        };
        0x2::event::emit<FeesDistributed>(v5);
    }

    public entry fun emergency_withdraw<T0>(arg0: &AdminCap, arg1: &LaunchpadConfig, arg2: &mut BondingPool<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 <= 0x2::balance::value<0x2::sui::SUI>(&arg2.sui_reserve), 3);
        arg2.status = 2;
        let v0 = EmergencyWithdraw{
            pool_id   : 0x2::object::id<BondingPool<T0>>(arg2),
            amount    : arg3,
            recipient : arg1.project_wallet,
            timestamp : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<EmergencyWithdraw>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg2.sui_reserve, arg3, arg5), arg1.project_wallet);
    }

    public fun estimate_buy<T0>(arg0: &BondingPool<T0>, arg1: u64) : (u64, u64, u64) {
        let v0 = calculate_fee(arg1, 200);
        let v1 = arg1 - v0;
        ((calculate_tokens_for_sui<T0>(arg0, (v1 as u128)) as u64), v0, v1)
    }

    public fun estimate_sell<T0>(arg0: &BondingPool<T0>, arg1: u64) : (u64, u64) {
        let v0 = calculate_sui_for_tokens<T0>(arg0, (arg1 as u128));
        let v1 = calculate_fee((v0 as u64), 200);
        ((v0 as u64) - v1, v1)
    }

    public(friend) fun extract_sui_for_migration<T0>(arg0: &mut BondingPool<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.status == 1, 15);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve) >= arg1, 3);
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_reserve, arg1, arg2)
    }

    public entry fun force_graduate<T0>(arg0: &AdminCap, arg1: &mut BondingPool<T0>, arg2: &0x2::clock::Clock) {
        assert!(arg1.status == 0, 8);
        graduate_internal<T0>(arg1, arg2);
    }

    public fun get_admin_registry_info(arg0: &AdminRegistry) : (u64, u64) {
        (arg0.admin_count, arg0.max_admins)
    }

    public fun get_config_info(arg0: &LaunchpadConfig) : (address, u64, u128, u128, bool) {
        (arg0.project_wallet, arg0.total_tokens_created, arg0.total_volume, arg0.total_fees_collected, arg0.is_paused)
    }

    public fun get_dex_pool_id<T0>(arg0: &BondingPool<T0>) : 0x1::option::Option<address> {
        arg0.dex_pool_id
    }

    public fun get_fee_config(arg0: &FeeConfig) : (u64, u64, u64, u64, u64, u64, u64, u64) {
        (arg0.creation_fee, arg0.total_trading_fee_bps, arg0.pool_fee_bps, arg0.project_fee_bps, arg0.project_wallet_percent, arg0.creator_percent, arg0.referrer_percent, arg0.default_graduation_mcap)
    }

    fun get_or_register_referrer_with_config(arg0: &mut ReferralRegistry, arg1: &Blacklist, arg2: &FeeConfig, arg3: address, arg4: 0x1::option::Option<address>, arg5: 0x2::object::ID, arg6: u64, arg7: u64) : (0x1::option::Option<address>, u64) {
        if (0x2::table::contains<address, address>(&arg0.referrals, arg3)) {
            let v0 = *0x2::table::borrow<address, address>(&arg0.referrals, arg3);
            if (is_referrer_banned(arg1, v0)) {
                return (0x1::option::none<address>(), 0)
            };
            return (0x1::option::some<address>(v0), arg6 * arg2.referrer_percent / 100)
        };
        if (0x1::option::is_some<address>(&arg4)) {
            let v1 = *0x1::option::borrow<address>(&arg4);
            if (is_referrer_banned(arg1, v1)) {
                return (0x1::option::none<address>(), 0)
            };
            0x2::table::add<address, address>(&mut arg0.referrals, arg3, v1);
            let v2 = ReferrerRegistered{
                pool_id   : arg5,
                trader    : arg3,
                referrer  : v1,
                timestamp : arg7,
            };
            0x2::event::emit<ReferrerRegistered>(v2);
            return (0x1::option::some<address>(v1), arg6 * arg2.referrer_percent / 100)
        };
        (0x1::option::none<address>(), 0)
    }

    public fun get_pool_creator<T0>(arg0: &BondingPool<T0>) : address {
        arg0.creator
    }

    public fun get_pool_full_info<T0>(arg0: &BondingPool<T0>) : (0x1::string::String, 0x1::string::String, u128, u128, u64, u8, address, u64, 0x1::option::Option<address>) {
        (arg0.name, arg0.symbol, arg0.current_supply, calculate_current_price<T0>(arg0), 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve), arg0.status, arg0.creator, arg0.holder_count, arg0.dex_pool_id)
    }

    public fun get_pool_info<T0>(arg0: &BondingPool<T0>) : (0x1::string::String, 0x1::string::String, u128, u128, u64, u8, address, u64) {
        (arg0.name, arg0.symbol, arg0.current_supply, calculate_current_price<T0>(arg0), 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve), arg0.status, arg0.creator, arg0.holder_count)
    }

    public fun get_pool_migration_info<T0>(arg0: &BondingPool<T0>) : (u128, u128, u64, u8, address, 0x1::option::Option<address>) {
        (arg0.current_supply, calculate_current_price<T0>(arg0), 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve), arg0.status, arg0.creator, arg0.dex_pool_id)
    }

    public fun get_pool_status<T0>(arg0: &BondingPool<T0>) : u8 {
        arg0.status
    }

    public fun get_project_wallet(arg0: &LaunchpadConfig) : address {
        arg0.project_wallet
    }

    public fun get_referrer_earnings(arg0: &ReferralRegistry, arg1: address) : u128 {
        if (0x2::table::contains<address, u128>(&arg0.earnings, arg1)) {
            *0x2::table::borrow<address, u128>(&arg0.earnings, arg1)
        } else {
            0
        }
    }

    public fun get_sui_reserve<T0>(arg0: &BondingPool<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve)
    }

    public fun get_trader_referrer(arg0: &ReferralRegistry, arg1: address) : 0x1::option::Option<address> {
        if (0x2::table::contains<address, address>(&arg0.referrals, arg1)) {
            0x1::option::some<address>(*0x2::table::borrow<address, address>(&arg0.referrals, arg1))
        } else {
            0x1::option::none<address>()
        }
    }

    public(friend) fun get_treasury_cap_mut<T0>(arg0: &mut BondingPool<T0>) : &mut 0x2::coin::TreasuryCap<T0> {
        &mut arg0.treasury_cap
    }

    fun graduate_internal<T0>(arg0: &mut BondingPool<T0>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        arg0.status = 1;
        arg0.graduated_at = 0x1::option::some<u64>(v0);
        let v1 = TokenGraduated{
            pool_id            : 0x2::object::id<BondingPool<T0>>(arg0),
            final_mcap         : safe_mul_div(arg0.current_supply, calculate_current_price<T0>(arg0), 1000000000000000000),
            total_holders      : arg0.holder_count,
            liquidity_migrated : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve),
            timestamp          : v0,
        };
        0x2::event::emit<TokenGraduated>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = LaunchpadConfig{
            id                   : 0x2::object::new(arg0),
            project_wallet       : v0,
            total_tokens_created : 0,
            total_volume         : 0,
            total_fees_collected : 0,
            is_paused            : false,
        };
        let v2 = FeeConfig{
            id                      : 0x2::object::new(arg0),
            creation_fee            : 2000000000,
            total_trading_fee_bps   : 200,
            pool_fee_bps            : 100,
            project_fee_bps         : 100,
            project_wallet_percent  : 50,
            creator_percent         : 30,
            referrer_percent        : 20,
            default_graduation_mcap : 10000000000000,
        };
        let v3 = Blacklist{
            id               : 0x2::object::new(arg0),
            addresses        : 0x2::table::new<address, bool>(arg0),
            banned_referrers : 0x2::table::new<address, bool>(arg0),
        };
        let v4 = ReferralRegistry{
            id                : 0x2::object::new(arg0),
            referrals         : 0x2::table::new<address, address>(arg0),
            earnings          : 0x2::table::new<address, u128>(arg0),
            total_distributed : 0,
        };
        let v5 = AdminCap{id: 0x2::object::new(arg0)};
        let v6 = AdminRegistry{
            id          : 0x2::object::new(arg0),
            admins      : 0x2::table::new<0x2::object::ID, address>(arg0),
            admin_count : 1,
            max_admins  : 10,
        };
        0x2::table::add<0x2::object::ID, address>(&mut v6.admins, 0x2::object::id<AdminCap>(&v5), v0);
        0x2::transfer::share_object<LaunchpadConfig>(v1);
        0x2::transfer::share_object<FeeConfig>(v2);
        0x2::transfer::share_object<Blacklist>(v3);
        0x2::transfer::share_object<ReferralRegistry>(v4);
        0x2::transfer::share_object<AdminRegistry>(v6);
        0x2::transfer::transfer<AdminCap>(v5, v0);
    }

    public fun is_admin_registered(arg0: &AdminRegistry, arg1: &AdminCap) : bool {
        0x2::table::contains<0x2::object::ID, address>(&arg0.admins, 0x2::object::id<AdminCap>(arg1))
    }

    public fun is_blacklisted(arg0: &Blacklist, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.addresses, arg1) && *0x2::table::borrow<address, bool>(&arg0.addresses, arg1)
    }

    public fun is_migrated<T0>(arg0: &BondingPool<T0>) : bool {
        arg0.status == 3
    }

    public fun is_referrer_banned(arg0: &Blacklist, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.banned_referrers, arg1) && *0x2::table::borrow<address, bool>(&arg0.banned_referrers, arg1)
    }

    public(friend) fun mark_pool_as_migrated<T0>(arg0: &mut BondingPool<T0>, arg1: address, arg2: &0x2::clock::Clock) {
        assert!(arg0.status == 1, 15);
        arg0.status = 3;
        arg0.dex_pool_id = 0x1::option::some<address>(arg1);
        let v0 = PoolMigrated{
            pool_id       : 0x2::object::id<BondingPool<T0>>(arg0),
            dex_pool_id   : arg1,
            sui_migrated  : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve),
            tokens_minted : 0,
            timestamp     : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PoolMigrated>(v0);
    }

    public(friend) fun mint_tokens_for_migration<T0>(arg0: &mut BondingPool<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.status == 1, 15);
        arg0.current_supply = arg0.current_supply + (arg1 as u128);
        0x2::coin::mint<T0>(&mut arg0.treasury_cap, arg1, arg2)
    }

    public entry fun pause_pool<T0>(arg0: &AdminCap, arg1: &mut BondingPool<T0>) {
        arg1.status = 2;
    }

    public entry fun remove_referrer(arg0: &AdminCap, arg1: &mut ReferralRegistry, arg2: address) {
        if (0x2::table::contains<address, address>(&arg1.referrals, arg2)) {
            0x2::table::remove<address, address>(&mut arg1.referrals, arg2);
        };
    }

    public(friend) fun return_sui_to_pool<T0>(arg0: &mut BondingPool<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public entry fun revoke_admin_cap(arg0: AdminCap, arg1: &mut AdminRegistry, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::object::id<AdminCap>(&arg0);
        if (0x2::table::contains<0x2::object::ID, address>(&arg1.admins, v0)) {
            0x2::table::remove<0x2::object::ID, address>(&mut arg1.admins, v0);
            arg1.admin_count = arg1.admin_count - 1;
        };
        let v1 = AdminCapRevoked{
            admin_cap_id : v0,
            timestamp    : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<AdminCapRevoked>(v1);
        let AdminCap { id: v2 } = arg0;
        0x2::object::delete(v2);
    }

    fun safe_mul_div(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 > 0, 12);
        let v0 = (arg0 as u256) * (arg1 as u256) / (arg2 as u256);
        assert!(v0 <= 340282366920938463463374607431768211455, 11);
        (v0 as u128)
    }

    public entry fun sell<T0>(arg0: &mut LaunchpadConfig, arg1: &FeeConfig, arg2: &Blacklist, arg3: &mut BondingPool<T0>, arg4: &mut ReferralRegistry, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.status == 0, 2);
        assert!(!arg0.is_paused, 2);
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(!is_blacklisted(arg2, v0), 7);
        let v1 = 0x2::coin::value<T0>(&arg5);
        assert!(v1 > 0, 6);
        let v2 = 0x2::clock::timestamp_ms(arg7);
        let v3 = calculate_sui_for_tokens<T0>(arg3, (v1 as u128));
        let v4 = calculate_fee_dynamic((v3 as u64), arg1.total_trading_fee_bps);
        calculate_fee_dynamic((v3 as u64), arg1.pool_fee_bps);
        let v5 = calculate_fee_dynamic((v3 as u64), arg1.project_fee_bps);
        let v6 = (v3 as u64) - v4;
        assert!(v6 >= arg6, 4);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg3.sui_reserve) >= (v3 as u64), 3);
        0x2::coin::burn<T0>(&mut arg3.treasury_cap, arg5);
        arg3.current_supply = arg3.current_supply - (v1 as u128);
        let v7 = if (0x2::table::contains<address, address>(&arg4.referrals, v0)) {
            let v8 = *0x2::table::borrow<address, address>(&arg4.referrals, v0);
            if (!is_referrer_banned(arg2, v8)) {
                0x1::option::some<address>(v8)
            } else {
                0x1::option::none<address>()
            }
        } else {
            0x1::option::none<address>()
        };
        let v9 = v7;
        let v10 = if (0x1::option::is_some<address>(&v9)) {
            v5 * arg1.referrer_percent / 100
        } else {
            0
        };
        let v11 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg3.sui_reserve, v5), arg8);
        let v12 = &mut v11;
        distribute_project_fees_sell_dynamic<T0>(arg0, arg1, arg3, arg4, v12, v5, v9, v10, v2, arg8);
        if (0x2::coin::value<0x2::sui::SUI>(&v11) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v11, arg0.project_wallet);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v11);
        };
        arg3.total_volume = arg3.total_volume + (v3 as u128);
        arg3.total_trades = arg3.total_trades + 1;
        arg0.total_volume = arg0.total_volume + (v3 as u128);
        arg0.total_fees_collected = arg0.total_fees_collected + (v4 as u128);
        let v13 = TokenSold{
            pool_id       : 0x2::object::id<BondingPool<T0>>(arg3),
            seller        : v0,
            tokens_amount : v1,
            sui_received  : v6,
            new_price     : calculate_current_price<T0>(arg3),
            timestamp     : v2,
        };
        0x2::event::emit<TokenSold>(v13);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg3.sui_reserve, v6, arg8), v0);
    }

    public entry fun set_max_admins(arg0: &AdminCap, arg1: &mut AdminRegistry, arg2: u64) {
        assert!(arg2 >= arg1.admin_count, 9);
        arg1.max_admins = arg2;
    }

    public entry fun set_max_supply<T0>(arg0: &AdminCap, arg1: &mut BondingPool<T0>, arg2: u128) {
        assert!(arg2 >= arg1.current_supply, 9);
        arg1.max_supply = arg2;
    }

    public entry fun set_paused(arg0: &AdminCap, arg1: &mut LaunchpadConfig, arg2: bool) {
        arg1.is_paused = arg2;
    }

    public entry fun transfer_pool_ownership<T0>(arg0: &AdminCap, arg1: &mut BondingPool<T0>, arg2: address, arg3: &0x2::clock::Clock) {
        arg1.creator = arg2;
        let v0 = PoolOwnershipTransferred{
            pool_id     : 0x2::object::id<BondingPool<T0>>(arg1),
            old_creator : arg1.creator,
            new_creator : arg2,
            timestamp   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<PoolOwnershipTransferred>(v0);
    }

    public entry fun unban_referrer(arg0: &AdminCap, arg1: &mut Blacklist, arg2: address, arg3: &0x2::clock::Clock) {
        if (0x2::table::contains<address, bool>(&arg1.banned_referrers, arg2)) {
            *0x2::table::borrow_mut<address, bool>(&mut arg1.banned_referrers, arg2) = false;
        };
        let v0 = ReferrerBanned{
            referrer  : arg2,
            is_banned : false,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ReferrerBanned>(v0);
    }

    public entry fun unpause_pool<T0>(arg0: &AdminCap, arg1: &mut BondingPool<T0>) {
        assert!(arg1.status == 2, 2);
        arg1.status = 0;
    }

    public entry fun update_creation_fee(arg0: &AdminCap, arg1: &mut FeeConfig, arg2: u64, arg3: &0x2::clock::Clock) {
        arg1.creation_fee = arg2;
        let v0 = FeesUpdated{
            creation_fee          : arg2,
            total_trading_fee_bps : arg1.total_trading_fee_bps,
            pool_fee_bps          : arg1.pool_fee_bps,
            project_fee_bps       : arg1.project_fee_bps,
            timestamp             : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<FeesUpdated>(v0);
    }

    public entry fun update_default_graduation_mcap(arg0: &AdminCap, arg1: &mut FeeConfig, arg2: u64) {
        assert!(arg2 > 0, 9);
        arg1.default_graduation_mcap = arg2;
    }

    public entry fun update_fee_distribution(arg0: &AdminCap, arg1: &mut FeeConfig, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        assert!(arg2 + arg3 + arg4 == 100, 9);
        arg1.project_wallet_percent = arg2;
        arg1.creator_percent = arg3;
        arg1.referrer_percent = arg4;
        let v0 = FeeDistributionUpdated{
            project_wallet_percent : arg2,
            creator_percent        : arg3,
            referrer_percent       : arg4,
            timestamp              : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<FeeDistributionUpdated>(v0);
    }

    public entry fun update_pool_graduation_mcap<T0>(arg0: &AdminCap, arg1: &mut BondingPool<T0>, arg2: u64) {
        assert!(arg2 > 0, 9);
        assert!(arg1.status == 0, 8);
        arg1.graduation_mcap = arg2;
    }

    public entry fun update_pool_metadata<T0>(arg0: &AdminCap, arg1: &mut BondingPool<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock) {
        arg1.name = 0x1::string::utf8(arg2);
        arg1.description = 0x1::string::utf8(arg3);
        arg1.image_url = 0x1::string::utf8(arg4);
        let v0 = PoolMetadataUpdated{
            pool_id   : 0x2::object::id<BondingPool<T0>>(arg1),
            timestamp : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<PoolMetadataUpdated>(v0);
    }

    public entry fun update_project_wallet(arg0: &AdminCap, arg1: &mut LaunchpadConfig, arg2: address) {
        arg1.project_wallet = arg2;
    }

    public entry fun update_trading_fees(arg0: &AdminCap, arg1: &mut FeeConfig, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        assert!(arg3 + arg4 == arg2, 9);
        assert!(arg2 <= 1000, 9);
        arg1.total_trading_fee_bps = arg2;
        arg1.pool_fee_bps = arg3;
        arg1.project_fee_bps = arg4;
        let v0 = FeesUpdated{
            creation_fee          : arg1.creation_fee,
            total_trading_fee_bps : arg2,
            pool_fee_bps          : arg3,
            project_fee_bps       : arg4,
            timestamp             : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<FeesUpdated>(v0);
    }

    public entry fun whitelist_address(arg0: &AdminCap, arg1: &mut Blacklist, arg2: address, arg3: &0x2::clock::Clock) {
        if (0x2::table::contains<address, bool>(&arg1.addresses, arg2)) {
            *0x2::table::borrow_mut<address, bool>(&mut arg1.addresses, arg2) = false;
        };
        let v0 = AddressBlacklisted{
            address        : arg2,
            is_blacklisted : false,
            timestamp      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<AddressBlacklisted>(v0);
    }

    // decompiled from Move bytecode v6
}

