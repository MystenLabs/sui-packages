module 0x297101aac4e2e4b3022fe083549320585e28fb1df6f5d770e26bd7ab65f369a::market {
    struct Level has copy, drop, store {
        index_id: 0x2::object::ID,
        price_per_km2_mist: u64,
        min_area_m2: u64,
        max_area_m2: u64,
    }

    struct MarketInner has store {
        version: u64,
        transfer_cap: 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::TransferCap,
        lifecycle_cap: 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::LifecycleCap,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        price_states: 0x2::table::Table<0x2::object::ID, 0x297101aac4e2e4b3022fe083549320585e28fb1df6f5d770e26bd7ab65f369a::pricing::PriceState>,
        levels: vector<Level>,
    }

    struct Market has key {
        id: 0x2::object::UID,
        paused: bool,
        inner: 0x2::versioned::Versioned,
    }

    struct MarketAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PriceStateUpdated has copy, drop {
        polygon_id: 0x2::object::ID,
        premium_ppm: u64,
    }

    struct MarketPaused has copy, drop {
        dummy_field: bool,
    }

    struct MarketUnpaused has copy, drop {
        dummy_field: bool,
    }

    struct LevelAdded has copy, drop {
        index_id: 0x2::object::ID,
        price_per_km2_mist: u64,
        min_area_m2: u64,
        max_area_m2: u64,
    }

    struct LevelUpdated has copy, drop {
        level_index: u64,
        price_per_km2_mist: u64,
        min_area_m2: u64,
        max_area_m2: u64,
    }

    struct TreasuryWithdrawn has copy, drop {
        recipient: address,
        amount: u64,
    }

    public fun new(arg0: 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::TransferCap, arg1: 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::LifecycleCap, arg2: &mut 0x2::tx_context::TxContext) : Market {
        let v0 = MarketInner{
            version       : 1,
            transfer_cap  : arg0,
            lifecycle_cap : arg1,
            treasury      : 0x2::balance::zero<0x2::sui::SUI>(),
            price_states  : 0x2::table::new<0x2::object::ID, 0x297101aac4e2e4b3022fe083549320585e28fb1df6f5d770e26bd7ab65f369a::pricing::PriceState>(arg2),
            levels        : 0x1::vector::empty<Level>(),
        };
        Market{
            id     : 0x2::object::new(arg2),
            paused : false,
            inner  : 0x2::versioned::create<MarketInner>(1, v0, arg2),
        }
    }

    public fun add_level(arg0: &MarketAdminCap, arg1: &mut Market, arg2: &0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::Index, arg3: u64, arg4: u64, arg5: u64) {
        assert!(arg3 > 0, 3100);
        assert!(arg4 > 0, 3101);
        assert!(arg4 <= arg5, 3101);
        assert!((arg5 as u128) * (arg3 as u128) <= 3764641647695826860204, 3119);
        let v0 = 0x2::object::id<0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::Index>(arg2);
        let v1 = load_inner_mut(arg1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<Level>(&v1.levels)) {
            if (0x1::vector::borrow<Level>(&v1.levels, v2).index_id == v0) {
                abort 3102
            };
            v2 = v2 + 1;
        };
        let v3 = Level{
            index_id           : v0,
            price_per_km2_mist : arg3,
            min_area_m2        : arg4,
            max_area_m2        : arg5,
        };
        0x1::vector::push_back<Level>(&mut v1.levels, v3);
        let v4 = LevelAdded{
            index_id           : v0,
            price_per_km2_mist : arg3,
            min_area_m2        : arg4,
            max_area_m2        : arg5,
        };
        0x2::event::emit<LevelAdded>(v4);
    }

    public fun collect_tax(arg0: &mut Market, arg1: &0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::Index, arg2: 0x2::object::ID, arg3: &0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::Index, arg4: vector<0x2::object::ID>, arg5: vector<u64>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 3115);
        assert!(0x1::vector::length<0x2::object::ID>(&arg4) > 0, 3202);
        let v0 = arg0.paused;
        let v1 = level_rank_for_index_id(arg0, 0x2::object::id<0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::Index>(arg1));
        let v2 = market_uid_mut(arg0);
        0x2::balance::join<0x2::sui::SUI>(treasury_mut(arg0), 0x297101aac4e2e4b3022fe083549320585e28fb1df6f5d770e26bd7ab65f369a::tax::collect_tax(v2, v0, v1, arg1, arg2, arg3, arg4, arg5, arg6));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<MarketAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun init_tax(arg0: &MarketAdminCap, arg1: &mut Market, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x297101aac4e2e4b3022fe083549320585e28fb1df6f5d770e26bd7ab65f369a::tax::init_tax(market_uid_mut(arg1), arg2, arg3);
    }

    public(friend) fun is_market_paused(arg0: &Market) : bool {
        arg0.paused
    }

    public fun is_paused(arg0: &Market) : bool {
        arg0.paused
    }

    fun level_for_index(arg0: &vector<Level>, arg1: 0x2::object::ID) : &Level {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Level>(arg0)) {
            let v1 = 0x1::vector::borrow<Level>(arg0, v0);
            if (v1.index_id == arg1) {
                return v1
            };
            v0 = v0 + 1;
        };
        abort 3105
    }

    public(friend) fun level_for_index_id(arg0: &Market, arg1: 0x2::object::ID) : &Level {
        level_for_index(market_levels(arg0), arg1)
    }

    public(friend) fun level_index_id_at(arg0: &Market, arg1: u64) : 0x2::object::ID {
        0x1::vector::borrow<Level>(&load_inner(arg0).levels, arg1).index_id
    }

    public(friend) fun level_max_area_m2(arg0: &Level) : u64 {
        arg0.max_area_m2
    }

    public(friend) fun level_min_area_m2(arg0: &Level) : u64 {
        arg0.min_area_m2
    }

    public(friend) fun level_price_per_km2_mist(arg0: &Level) : u64 {
        arg0.price_per_km2_mist
    }

    fun level_rank_for_index(arg0: &vector<Level>, arg1: 0x2::object::ID) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Level>(arg0)) {
            if (0x1::vector::borrow<Level>(arg0, v0).index_id == arg1) {
                return v0
            };
            v0 = v0 + 1;
        };
        abort 3105
    }

    public(friend) fun level_rank_for_index_id(arg0: &Market, arg1: 0x2::object::ID) : u64 {
        level_rank_for_index(market_levels(arg0), arg1)
    }

    public(friend) fun lifecycle_cap(arg0: &Market) : &0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::LifecycleCap {
        &load_inner(arg0).lifecycle_cap
    }

    fun load_inner(arg0: &Market) : &MarketInner {
        assert!(0x2::versioned::version(&arg0.inner) >= 1, 3116);
        let v0 = 0x2::versioned::load_value<MarketInner>(&arg0.inner);
        assert!(v0.version == 1, 3116);
        v0
    }

    fun load_inner_mut(arg0: &mut Market) : &mut MarketInner {
        assert!(0x2::versioned::version(&arg0.inner) >= 1, 3116);
        let v0 = 0x2::versioned::load_value_mut<MarketInner>(&mut arg0.inner);
        assert!(v0.version == 1, 3116);
        v0
    }

    public(friend) fun market_levels(arg0: &Market) : &vector<Level> {
        &load_inner(arg0).levels
    }

    public(friend) fun market_uid(arg0: &Market) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun market_uid_mut(arg0: &mut Market) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun pause(arg0: &MarketAdminCap, arg1: &mut Market) {
        arg1.paused = true;
        let v0 = MarketPaused{dummy_field: false};
        0x2::event::emit<MarketPaused>(v0);
    }

    public fun premium_ppm(arg0: &Market, arg1: 0x2::object::ID) : u64 {
        if (0x2::table::contains<0x2::object::ID, 0x297101aac4e2e4b3022fe083549320585e28fb1df6f5d770e26bd7ab65f369a::pricing::PriceState>(&load_inner(arg0).price_states, arg1)) {
            0x297101aac4e2e4b3022fe083549320585e28fb1df6f5d770e26bd7ab65f369a::pricing::premium_ppm(0x2::table::borrow<0x2::object::ID, 0x297101aac4e2e4b3022fe083549320585e28fb1df6f5d770e26bd7ab65f369a::pricing::PriceState>(&load_inner(arg0).price_states, arg1))
        } else {
            0
        }
    }

    public(friend) fun price_states(arg0: &Market) : &0x2::table::Table<0x2::object::ID, 0x297101aac4e2e4b3022fe083549320585e28fb1df6f5d770e26bd7ab65f369a::pricing::PriceState> {
        &load_inner(arg0).price_states
    }

    public(friend) fun price_states_mut(arg0: &mut Market) : &mut 0x2::table::Table<0x2::object::ID, 0x297101aac4e2e4b3022fe083549320585e28fb1df6f5d770e26bd7ab65f369a::pricing::PriceState> {
        &mut load_inner_mut(arg0).price_states
    }

    public fun sale_count(arg0: &Market, arg1: 0x2::object::ID) : u64 {
        if (0x2::table::contains<0x2::object::ID, 0x297101aac4e2e4b3022fe083549320585e28fb1df6f5d770e26bd7ab65f369a::pricing::PriceState>(&load_inner(arg0).price_states, arg1)) {
            0x297101aac4e2e4b3022fe083549320585e28fb1df6f5d770e26bd7ab65f369a::pricing::sale_count(0x2::table::borrow<0x2::object::ID, 0x297101aac4e2e4b3022fe083549320585e28fb1df6f5d770e26bd7ab65f369a::pricing::PriceState>(&load_inner(arg0).price_states, arg1))
        } else {
            0
        }
    }

    public fun set_tax_level_cfg(arg0: &MarketAdminCap, arg1: &mut Market, arg2: u64, arg3: 0x297101aac4e2e4b3022fe083549320585e28fb1df6f5d770e26bd7ab65f369a::tax::TaxLevelCfg) {
        let v0 = 0x1::vector::length<Level>(market_levels(arg1));
        0x297101aac4e2e4b3022fe083549320585e28fb1df6f5d770e26bd7ab65f369a::tax::set_tax_level_cfg(market_uid_mut(arg1), v0, arg2, arg3);
    }

    public fun share(arg0: Market) {
        0x2::transfer::share_object<Market>(arg0);
    }

    public fun swap_caps(arg0: &MarketAdminCap, arg1: &mut Market, arg2: 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::TransferCap, arg3: 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::LifecycleCap, arg4: &mut 0x2::tx_context::TxContext) : (0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::TransferCap, 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::LifecycleCap) {
        let v0 = 0x2::versioned::version(&arg1.inner);
        assert!(v0 == 1, 3116);
        let (v1, v2) = 0x2::versioned::remove_value_for_upgrade<MarketInner>(&mut arg1.inner);
        let MarketInner {
            version       : v3,
            transfer_cap  : v4,
            lifecycle_cap : v5,
            treasury      : v6,
            price_states  : v7,
            levels        : v8,
        } = v1;
        let v9 = MarketInner{
            version       : v3,
            transfer_cap  : arg2,
            lifecycle_cap : arg3,
            treasury      : v6,
            price_states  : v7,
            levels        : v8,
        };
        0x2::versioned::upgrade<MarketInner>(&mut arg1.inner, v0 + 1, v9, v2);
        (v4, v5)
    }

    public fun sweep_expired(arg0: &mut Market, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 3115);
        let v0 = arg0.paused;
        let v1 = market_uid_mut(arg0);
        0x2::balance::join<0x2::sui::SUI>(treasury_mut(arg0), 0x297101aac4e2e4b3022fe083549320585e28fb1df6f5d770e26bd7ab65f369a::tax::sweep_expired(v1, v0, arg1, arg2, arg3, arg4));
    }

    public fun tax_fund_balance(arg0: &Market) : u64 {
        0x297101aac4e2e4b3022fe083549320585e28fb1df6f5d770e26bd7ab65f369a::tax::tax_fund_balance(market_uid(arg0))
    }

    public fun tax_is_initialized(arg0: &Market) : bool {
        0x297101aac4e2e4b3022fe083549320585e28fb1df6f5d770e26bd7ab65f369a::tax::tax_is_initialized(market_uid(arg0))
    }

    public fun tax_self_claimable(arg0: &Market, arg1: 0x2::object::ID) : u64 {
        0x297101aac4e2e4b3022fe083549320585e28fb1df6f5d770e26bd7ab65f369a::tax::tax_self_claimable(market_uid(arg0), arg1)
    }

    public fun tax_version_counter(arg0: &Market, arg1: 0x2::object::ID) : u64 {
        0x297101aac4e2e4b3022fe083549320585e28fb1df6f5d770e26bd7ab65f369a::tax::tax_version_counter(market_uid(arg0), arg1)
    }

    public(friend) fun transfer_cap(arg0: &Market) : &0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::TransferCap {
        &load_inner(arg0).transfer_cap
    }

    public fun treasury_balance(arg0: &Market) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&load_inner(arg0).treasury)
    }

    public(friend) fun treasury_mut(arg0: &mut Market) : &mut 0x2::balance::Balance<0x2::sui::SUI> {
        &mut load_inner_mut(arg0).treasury
    }

    public(friend) fun treasury_value(arg0: &Market) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&load_inner(arg0).treasury)
    }

    public fun unpause(arg0: &MarketAdminCap, arg1: &mut Market) {
        arg1.paused = false;
        let v0 = MarketUnpaused{dummy_field: false};
        0x2::event::emit<MarketUnpaused>(v0);
    }

    public fun update_level(arg0: &MarketAdminCap, arg1: &mut Market, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        assert!(arg3 > 0, 3100);
        assert!(arg4 > 0, 3101);
        assert!(arg4 <= arg5, 3101);
        assert!((arg5 as u128) * (arg3 as u128) <= 3764641647695826860204, 3119);
        let v0 = load_inner_mut(arg1);
        assert!(arg2 < 0x1::vector::length<Level>(&v0.levels), 3105);
        let v1 = 0x1::vector::borrow_mut<Level>(&mut v0.levels, arg2);
        v1.price_per_km2_mist = arg3;
        v1.min_area_m2 = arg4;
        v1.max_area_m2 = arg5;
        let v2 = LevelUpdated{
            level_index        : arg2,
            price_per_km2_mist : arg3,
            min_area_m2        : arg4,
            max_area_m2        : arg5,
        };
        0x2::event::emit<LevelUpdated>(v2);
    }

    public fun withdraw(arg0: &MarketAdminCap, arg1: &mut Market, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = TreasuryWithdrawn{
            recipient : 0x2::tx_context::sender(arg3),
            amount    : arg2,
        };
        0x2::event::emit<TreasuryWithdrawn>(v0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut load_inner_mut(arg1).treasury, arg2), arg3)
    }

    // decompiled from Move bytecode v7
}

