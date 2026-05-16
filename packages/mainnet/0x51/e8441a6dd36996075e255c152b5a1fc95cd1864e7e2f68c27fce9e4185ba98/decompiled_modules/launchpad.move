module 0x51e8441a6dd36996075e255c152b5a1fc95cd1864e7e2f68c27fce9e4185ba98::launchpad {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LaunchpadConfig has key {
        id: 0x2::object::UID,
        treasury_address: address,
        lp_burner_address: address,
        paused_global: bool,
        threshold: u64,
    }

    struct BondingPool<phantom T0> has key {
        id: 0x2::object::UID,
        creator: address,
        name: 0x1::string::String,
        symbol: 0x1::ascii::String,
        icon_url: 0x1::option::Option<0x2::url::Url>,
        description: 0x1::string::String,
        socials: vector<0x1::string::String>,
        real_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        real_tokens: 0x2::balance::Balance<T0>,
        cetus_reserve: 0x2::balance::Balance<T0>,
        fees_accrued: 0x2::balance::Balance<0x2::sui::SUI>,
        total_boosts: u64,
        paused: bool,
        graduated: bool,
        threshold: u64,
        virtual_sui: u64,
    }

    struct TokenCreated has copy, drop {
        pool_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        creator: address,
        name: 0x1::string::String,
        symbol: 0x1::ascii::String,
        description: 0x1::string::String,
        socials: vector<0x1::string::String>,
        initial_buy_sui: u64,
        initial_buy_tokens: u64,
    }

    struct Trade has copy, drop {
        pool_id: 0x2::object::ID,
        trader: address,
        is_buy: bool,
        sui_amount: u64,
        token_amount: u64,
        protocol_fee: u64,
        creator_fee: u64,
        real_sui_after: u64,
        real_tokens_after: u64,
    }

    struct Graduated has copy, drop {
        pool_id: 0x2::object::ID,
        treasury_received: u64,
        sui_to_lp: u64,
        tokens_to_lp: u64,
    }

    struct Boosted has copy, drop {
        pool_id: 0x2::object::ID,
        pack: u8,
        boosts_added: u64,
        sui_paid: u64,
        payer: address,
    }

    struct FeesClaimed has copy, drop {
        pool_id: 0x2::object::ID,
        creator: address,
        amount: u64,
    }

    struct FeesDeposited has copy, drop {
        pool_id: 0x2::object::ID,
        sui_total: u64,
        treasury_share: u64,
        creator_share: u64,
    }

    struct PausedToggled has copy, drop {
        pool_id_or_global: 0x1::option::Option<0x2::object::ID>,
        paused: bool,
    }

    struct TreasuryUpdated has copy, drop {
        new_treasury: address,
    }

    struct LpBurnerUpdated has copy, drop {
        new_lp_burner: address,
    }

    struct ThresholdUpdated has copy, drop {
        old_threshold: u64,
        new_threshold: u64,
    }

    struct CreatorRotated has copy, drop {
        pool_id: 0x2::object::ID,
        old_creator: address,
        new_creator: address,
    }

    struct CommentPosted has copy, drop {
        poster: address,
        pool_id: address,
        body_hash: vector<u8>,
        fee: u64,
    }

    struct ProfileUpdated has copy, drop {
        wallet: address,
        commitment: vector<u8>,
        fee: u64,
    }

    public fun boost<T0>(arg0: &LaunchpadConfig, arg1: &mut BondingPool<T0>, arg2: u8, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused_global, 2);
        assert!(!arg1.paused, 1);
        let v0 = vector[10, 30, 50, 100, 500];
        assert!((arg2 as u64) < 0x1::vector::length<u64>(&v0), 8);
        let v1 = vector[1990000000, 4990000000, 7990000000, 14990000000, 71990000000];
        let v2 = *0x1::vector::borrow<u64>(&v1, (arg2 as u64));
        let v3 = vector[10, 30, 50, 100, 500];
        let v4 = *0x1::vector::borrow<u64>(&v3, (arg2 as u64));
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v2, 9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v2, arg4), arg0.treasury_address);
        if (0x2::coin::value<0x2::sui::SUI>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, 0x2::tx_context::sender(arg4));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        };
        arg1.total_boosts = arg1.total_boosts + v4;
        let v5 = Boosted{
            pool_id      : 0x2::object::id<BondingPool<T0>>(arg1),
            pack         : arg2,
            boosts_added : v4,
            sui_paid     : v2,
            payer        : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<Boosted>(v5);
    }

    public fun boost_amount(arg0: u8) : u64 {
        let v0 = vector[10, 30, 50, 100, 500];
        assert!((arg0 as u64) < 0x1::vector::length<u64>(&v0), 8);
        let v1 = vector[10, 30, 50, 100, 500];
        *0x1::vector::borrow<u64>(&v1, (arg0 as u64))
    }

    public fun boost_price(arg0: u8) : u64 {
        let v0 = vector[10, 30, 50, 100, 500];
        assert!((arg0 as u64) < 0x1::vector::length<u64>(&v0), 8);
        let v1 = vector[1990000000, 4990000000, 7990000000, 14990000000, 71990000000];
        *0x1::vector::borrow<u64>(&v1, (arg0 as u64))
    }

    public fun buy<T0>(arg0: &LaunchpadConfig, arg1: &mut BondingPool<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = buy_internal<T0>(arg0, arg1, arg2, arg3, arg4);
        0x2::coin::take<T0>(&mut arg1.real_tokens, v0, arg4)
    }

    fun buy_internal<T0>(arg0: &LaunchpadConfig, arg1: &mut BondingPool<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(!arg0.paused_global, 2);
        assert!(!arg1.paused, 1);
        assert!(!arg1.graduated, 3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) > 0, 6);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v1 = v0;
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg1.real_sui);
        let v3 = arg1.threshold;
        assert!(v2 < v3, 4);
        let v4 = v3 - v2;
        if (mul_div(v0, 10000 - 150, 10000) > v4) {
            let v5 = ceil_mul_div(v4, 10000, 10000 - 150);
            let v6 = v0 - v5;
            if (v6 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v6, arg4), 0x2::tx_context::sender(arg4));
            };
            v1 = v5;
        };
        let v7 = mul_div(v1, 100, 10000);
        let v8 = mul_div(v1, 50, 10000);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v7, arg4), arg0.treasury_address);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.fees_accrued, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v8, arg4)));
        let v9 = 0x2::balance::value<T0>(&arg1.real_tokens);
        let v10 = curve_buy_tokens_out(arg1.virtual_sui, v2, v9, v1 - v7 - v8);
        let v11 = v10;
        assert!(v10 > 0, 6);
        if (v10 > v9) {
            v11 = v9;
        };
        assert!(v11 >= arg3, 5);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.real_sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v12 = Trade{
            pool_id           : 0x2::object::id<BondingPool<T0>>(arg1),
            trader            : 0x2::tx_context::sender(arg4),
            is_buy            : true,
            sui_amount        : v1,
            token_amount      : v11,
            protocol_fee      : v7,
            creator_fee       : v8,
            real_sui_after    : 0x2::balance::value<0x2::sui::SUI>(&arg1.real_sui),
            real_tokens_after : 0x2::balance::value<T0>(&arg1.real_tokens) - v11,
        };
        0x2::event::emit<Trade>(v12);
        v11
    }

    fun ceil_mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128);
        if (v0 % (arg2 as u128) > 0) {
            ((v0 / (arg2 as u128) + 1) as u64)
        } else {
            ((v0 / (arg2 as u128)) as u64)
        }
    }

    public fun claim_fees<T0>(arg0: &mut BondingPool<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 7);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.fees_accrued);
        assert!(v0 > 0, 6);
        let v1 = FeesClaimed{
            pool_id : 0x2::object::id<BondingPool<T0>>(arg0),
            creator : arg0.creator,
            amount  : v0,
        };
        0x2::event::emit<FeesClaimed>(v1);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.fees_accrued, v0), arg1)
    }

    public fun comment_fee() : u64 {
        100000000
    }

    public fun config_threshold(arg0: &LaunchpadConfig) : u64 {
        arg0.threshold
    }

    public fun create_token<T0>(arg0: &LaunchpadConfig, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x2::coin::CoinMetadata<T0>, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<0x1::string::String>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::get_decimals<T0>(&arg2) == 9, 20);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(arg2);
        create_token_internal<T0>(arg0, arg1, arg3, 0x2::coin::get_symbol<T0>(&arg2), 0x2::coin::get_icon_url<T0>(&arg2), arg4, arg5, arg6, arg7, arg8);
    }

    fun create_token_internal<T0>(arg0: &LaunchpadConfig, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x1::string::String, arg3: 0x1::ascii::String, arg4: 0x1::option::Option<0x2::url::Url>, arg5: 0x1::string::String, arg6: vector<0x1::string::String>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused_global, 2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg7) >= 1000000000, 0);
        assert!(0x1::string::length(&arg2) <= 64, 12);
        assert!(0x1::string::length(&arg5) <= 512, 13);
        assert!(0x1::vector::length<0x1::string::String>(&arg6) <= 5, 14);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg6)) {
            assert!(0x1::string::length(0x1::vector::borrow<0x1::string::String>(&arg6, v0)) <= 256, 15);
            v0 = v0 + 1;
        };
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 19);
        let v1 = 0x2::coin::mint<T0>(&mut arg1, 1000000000000000000, arg9);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T0>>(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg7, 1000000000, arg9), arg0.treasury_address);
        if (0x2::coin::value<0x2::sui::SUI>(&arg7) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg7, 0x2::tx_context::sender(arg9));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg7);
        };
        let v2 = arg0.threshold;
        let v3 = BondingPool<T0>{
            id            : 0x2::object::new(arg9),
            creator       : 0x2::tx_context::sender(arg9),
            name          : arg2,
            symbol        : arg3,
            icon_url      : arg4,
            description   : arg5,
            socials       : arg6,
            real_sui      : 0x2::balance::zero<0x2::sui::SUI>(),
            real_tokens   : 0x2::coin::into_balance<T0>(v1),
            cetus_reserve : 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v1, 200000000000000000, arg9)),
            fees_accrued  : 0x2::balance::zero<0x2::sui::SUI>(),
            total_boosts  : 0,
            paused        : false,
            graduated     : false,
            threshold     : v2,
            virtual_sui   : v2 * 3 / 8,
        };
        let (v4, v5) = if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&arg8)) {
            let v6 = 0x1::option::extract<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg8);
            let v7 = &mut v3;
            let v8 = buy_internal<T0>(arg0, v7, v6, 0, arg9);
            if (v8 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v3.real_tokens, v8, arg9), 0x2::tx_context::sender(arg9));
            };
            (0x2::coin::value<0x2::sui::SUI>(&v6), v8)
        } else {
            (0, 0)
        };
        0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(arg8);
        let v9 = TokenCreated{
            pool_id            : 0x2::object::id<BondingPool<T0>>(&v3),
            coin_type          : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            creator            : 0x2::tx_context::sender(arg9),
            name               : v3.name,
            symbol             : v3.symbol,
            description        : v3.description,
            socials            : v3.socials,
            initial_buy_sui    : v4,
            initial_buy_tokens : v5,
        };
        0x2::event::emit<TokenCreated>(v9);
        0x2::transfer::share_object<BondingPool<T0>>(v3);
    }

    public fun creator<T0>(arg0: &BondingPool<T0>) : address {
        arg0.creator
    }

    public fun creator_fee_bps() : u64 {
        50
    }

    fun curve_buy_tokens_out(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = (arg0 as u128) + (arg1 as u128);
        let v1 = (1100000000000000000 as u128) - (800000000000000000 as u128) - (arg2 as u128);
        ((v1 - v0 * v1 / (v0 + (arg3 as u128))) as u64)
    }

    fun curve_sell_sui_out(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = (arg0 as u128) + (arg1 as u128);
        let v1 = (1100000000000000000 as u128) - (800000000000000000 as u128) - (arg2 as u128);
        ((v0 - v0 * v1 / (v1 + (arg3 as u128))) as u64)
    }

    public fun cut_bps() : u64 {
        1000
    }

    public fun deposit_fees<T0>(arg0: &LaunchpadConfig, arg1: &mut BondingPool<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.lp_burner_address, 11);
        assert!(arg1.graduated, 4);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 6);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        let v2 = mul_div(v0, 8000, 10000);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v1, v2), arg3), arg0.treasury_address);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.fees_accrued, v1);
        let v3 = FeesDeposited{
            pool_id        : 0x2::object::id<BondingPool<T0>>(arg1),
            sui_total      : v0,
            treasury_share : v2,
            creator_share  : 0x2::balance::value<0x2::sui::SUI>(&v1),
        };
        0x2::event::emit<FeesDeposited>(v3);
    }

    public fun fees_pending<T0>(arg0: &BondingPool<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.fees_accrued)
    }

    public fun global_paused(arg0: &LaunchpadConfig) : bool {
        arg0.paused_global
    }

    public fun grad_fee_protocol_bps() : u64 {
        8000
    }

    public fun graduate<T0>(arg0: &AdminCap, arg1: &LaunchpadConfig, arg2: &mut BondingPool<T0>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(!arg1.paused_global, 2);
        assert!(!arg2.graduated, 3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg2.real_sui) > 0, 10);
        assert!(0x2::tx_context::sender(arg3) == arg1.lp_burner_address, 11);
        let v0 = mul_div(0x2::balance::value<0x2::sui::SUI>(&arg2.real_sui), 1000, 10000);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg2.real_sui, v0), arg3), arg1.treasury_address);
        };
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg2.real_sui);
        let v2 = 0x2::balance::value<T0>(&arg2.cetus_reserve);
        assert!(v1 > 0 && v2 > 0, 10);
        arg2.graduated = true;
        let v3 = Graduated{
            pool_id           : 0x2::object::id<BondingPool<T0>>(arg2),
            treasury_received : v0,
            sui_to_lp         : v1,
            tokens_to_lp      : v2,
        };
        0x2::event::emit<Graduated>(v3);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.cetus_reserve, v2), arg3), 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg2.real_sui, v1), arg3))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = LaunchpadConfig{
            id                : 0x2::object::new(arg0),
            treasury_address  : 0x2::tx_context::sender(arg0),
            lp_burner_address : 0x2::tx_context::sender(arg0),
            paused_global     : false,
            threshold         : 3000000000000,
        };
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<LaunchpadConfig>(v1);
    }

    public fun is_graduated<T0>(arg0: &BondingPool<T0>) : bool {
        arg0.graduated
    }

    public fun launch_fee() : u64 {
        1000000000
    }

    public fun lp_burner_address(arg0: &LaunchpadConfig) : address {
        arg0.lp_burner_address
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun num_boost_packs() : u64 {
        let v0 = vector[10, 30, 50, 100, 500];
        0x1::vector::length<u64>(&v0)
    }

    public fun post_comment(arg0: &LaunchpadConfig, arg1: address, arg2: vector<u8>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused_global, 2);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 18);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= 100000000, 16);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, 100000000, arg4), arg0.treasury_address);
        if (0x2::coin::value<0x2::sui::SUI>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, 0x2::tx_context::sender(arg4));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        };
        let v0 = CommentPosted{
            poster    : 0x2::tx_context::sender(arg4),
            pool_id   : arg1,
            body_hash : arg2,
            fee       : 100000000,
        };
        0x2::event::emit<CommentPosted>(v0);
    }

    public fun preview_buy<T0>(arg0: &BondingPool<T0>, arg1: u64) : u64 {
        let v0 = curve_buy_tokens_out(arg0.virtual_sui, 0x2::balance::value<0x2::sui::SUI>(&arg0.real_sui), 0x2::balance::value<T0>(&arg0.real_tokens), mul_div(arg1, 10000 - 150, 10000));
        let v1 = v0;
        let v2 = 0x2::balance::value<T0>(&arg0.real_tokens);
        if (v0 > v2) {
            v1 = v2;
        };
        v1
    }

    public fun preview_sell<T0>(arg0: &BondingPool<T0>, arg1: u64) : u64 {
        mul_div(curve_sell_sui_out(arg0.virtual_sui, 0x2::balance::value<0x2::sui::SUI>(&arg0.real_sui), 0x2::balance::value<T0>(&arg0.real_tokens), arg1), 10000 - 150, 10000)
    }

    public fun profile_fee() : u64 {
        100000000
    }

    public fun protocol_fee_bps() : u64 {
        100
    }

    public fun real_sui<T0>(arg0: &BondingPool<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.real_sui)
    }

    public fun real_tokens<T0>(arg0: &BondingPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.real_tokens)
    }

    public fun rotate_creator<T0>(arg0: &AdminCap, arg1: &mut BondingPool<T0>, arg2: address) {
        assert!(arg2 != @0x0, 21);
        arg1.creator = arg2;
        let v0 = CreatorRotated{
            pool_id     : 0x2::object::id<BondingPool<T0>>(arg1),
            old_creator : arg1.creator,
            new_creator : arg2,
        };
        0x2::event::emit<CreatorRotated>(v0);
    }

    public fun sell<T0>(arg0: &LaunchpadConfig, arg1: &mut BondingPool<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(!arg0.paused_global, 2);
        assert!(!arg1.paused, 1);
        assert!(!arg1.graduated, 3);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 6);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg1.real_sui);
        assert!(v1 > 0, 10);
        let v2 = curve_sell_sui_out(arg1.virtual_sui, v1, 0x2::balance::value<T0>(&arg1.real_tokens), v0);
        let v3 = v2;
        assert!(v2 > 0, 6);
        if (v2 > v1) {
            v3 = v1;
        };
        let v4 = mul_div(v3, 100, 10000);
        let v5 = mul_div(v3, 50, 10000);
        let v6 = v3 - v4 - v5;
        assert!(v6 >= arg3, 5);
        0x2::balance::join<T0>(&mut arg1.real_tokens, 0x2::coin::into_balance<T0>(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.real_sui, v4), arg4), arg0.treasury_address);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.fees_accrued, 0x2::balance::split<0x2::sui::SUI>(&mut arg1.real_sui, v5));
        let v7 = Trade{
            pool_id           : 0x2::object::id<BondingPool<T0>>(arg1),
            trader            : 0x2::tx_context::sender(arg4),
            is_buy            : false,
            sui_amount        : v3,
            token_amount      : v0,
            protocol_fee      : v4,
            creator_fee       : v5,
            real_sui_after    : 0x2::balance::value<0x2::sui::SUI>(&arg1.real_sui),
            real_tokens_after : 0x2::balance::value<T0>(&arg1.real_tokens),
        };
        0x2::event::emit<Trade>(v7);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.real_sui, v6), arg4)
    }

    public fun set_global_pause(arg0: &AdminCap, arg1: &mut LaunchpadConfig, arg2: bool) {
        arg1.paused_global = arg2;
        let v0 = PausedToggled{
            pool_id_or_global : 0x1::option::none<0x2::object::ID>(),
            paused            : arg2,
        };
        0x2::event::emit<PausedToggled>(v0);
    }

    public fun set_lp_burner(arg0: &AdminCap, arg1: &mut LaunchpadConfig, arg2: address) {
        assert!(arg2 != @0x0, 21);
        arg1.lp_burner_address = arg2;
        let v0 = LpBurnerUpdated{new_lp_burner: arg2};
        0x2::event::emit<LpBurnerUpdated>(v0);
    }

    public fun set_pool_pause<T0>(arg0: &AdminCap, arg1: &mut BondingPool<T0>, arg2: bool) {
        arg1.paused = arg2;
        let v0 = PausedToggled{
            pool_id_or_global : 0x1::option::some<0x2::object::ID>(0x2::object::id<BondingPool<T0>>(arg1)),
            paused            : arg2,
        };
        0x2::event::emit<PausedToggled>(v0);
    }

    public fun set_threshold(arg0: &AdminCap, arg1: &mut LaunchpadConfig, arg2: u64) {
        assert!(arg2 >= 8, 6);
        assert!(arg2 <= 1000000 * 1000000000, 6);
        arg1.threshold = arg2;
        let v0 = ThresholdUpdated{
            old_threshold : arg1.threshold,
            new_threshold : arg2,
        };
        0x2::event::emit<ThresholdUpdated>(v0);
    }

    public fun set_treasury(arg0: &AdminCap, arg1: &mut LaunchpadConfig, arg2: address) {
        assert!(arg2 != @0x0, 21);
        arg1.treasury_address = arg2;
        let v0 = TreasuryUpdated{new_treasury: arg2};
        0x2::event::emit<TreasuryUpdated>(v0);
    }

    public fun threshold<T0>(arg0: &BondingPool<T0>) : u64 {
        arg0.threshold
    }

    public fun tokens_for_curve() : u64 {
        800000000000000000
    }

    public fun tokens_for_lp() : u64 {
        200000000000000000
    }

    public fun total_boosts<T0>(arg0: &BondingPool<T0>) : u64 {
        arg0.total_boosts
    }

    public fun total_fee_bps() : u64 {
        150
    }

    public fun total_supply_const() : u64 {
        1000000000000000000
    }

    public fun treasury_address(arg0: &LaunchpadConfig) : address {
        arg0.treasury_address
    }

    public fun update_profile(arg0: &LaunchpadConfig, arg1: vector<u8>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused_global, 2);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 18);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= 100000000, 17);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, 100000000, arg3), arg0.treasury_address);
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        let v0 = ProfileUpdated{
            wallet     : 0x2::tx_context::sender(arg3),
            commitment : arg1,
            fee        : 100000000,
        };
        0x2::event::emit<ProfileUpdated>(v0);
    }

    public fun virtual_sui<T0>(arg0: &BondingPool<T0>) : u64 {
        arg0.virtual_sui
    }

    // decompiled from Move bytecode v7
}

