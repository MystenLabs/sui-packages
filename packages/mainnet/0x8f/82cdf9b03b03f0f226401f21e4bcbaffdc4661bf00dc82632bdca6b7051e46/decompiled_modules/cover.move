module 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::cover {
    struct Cover has store, key {
        id: 0x2::object::UID,
        protocol_id: vector<u8>,
        remaining_capacity: u64,
        expire_at: u64,
        start_at: u64,
    }

    struct CoverVault has key {
        id: 0x2::object::UID,
        next_cover_id: u64,
        covers: 0x2::table::Table<u64, Cover>,
    }

    struct CoverReceipt has store, key {
        id: 0x2::object::UID,
        cover_id: u64,
        protocol_id: vector<u8>,
        amount: u64,
        expire_at: u64,
    }

    struct BuyCoverEvent has copy, drop {
        sender: address,
        cover_id: u64,
        protocol_id: vector<u8>,
        amount: u64,
        premium_amount: u64,
        duration_days: u64,
        expire_at: u64,
    }

    struct ExpireCoverEvent has copy, drop {
        cover_id: u64,
        protocol_id: vector<u8>,
        remaining_capacity: u64,
    }

    public(friend) fun burn_cover_for_claim(arg0: &mut CoverVault, arg1: u64, arg2: u64, arg3: &mut 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::risk_manager::RiskRegistry) {
        if (!0x2::table::contains<u64, Cover>(&arg0.covers, arg1)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_cover_not_found();
        };
        let v0 = 0x2::table::borrow_mut<u64, Cover>(&mut arg0.covers, arg1);
        if (v0.remaining_capacity < arg2) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_covered_amount_exceeded();
        };
        v0.remaining_capacity = v0.remaining_capacity - arg2;
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::risk_manager::update_coverage(arg3, v0.protocol_id, arg2, false);
    }

    public fun buy_cover(arg0: &mut CoverVault, arg1: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::Version, arg2: &mut 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::risk_manager::RiskRegistry, arg3: &mut 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::staking_pool::StakingRegistry, arg4: &mut 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::capital_pool::CapitalPool, arg5: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::config::Config, arg6: 0x1::string::String, arg7: u64, arg8: u64, arg9: 0x2::coin::Coin<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (CoverReceipt, 0x2::coin::Coin<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>) {
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::check_version(arg1);
        let v0 = *0x1::string::as_bytes(&arg6);
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::staking_pool::ensure_active_stake_synced(arg3, arg2, arg5, v0, arg10);
        let (v1, v2, _, v4) = 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::risk_manager::get_protocol_status(arg2, v0);
        let (v5, v6, v7) = 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::risk_manager::get_protocol_premium_state(arg2, v0);
        let v8 = 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::floor(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::mul(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from(v2), 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from_bps(v4)));
        if (v1 + arg7 > v8) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_insufficient_capacity();
        };
        if (v5 == 0 && v6 == 0) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_protocol_premium_not_configured();
        };
        let v9 = 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::math::get_base_price_bps(v6, v7, v5, 0x2::clock::timestamp_ms(arg10) / 1000, 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::config::premium_change_per_day_bps(arg5));
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::risk_manager::update_protocol_bumped_price(arg2, v0, v9 + 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::math::calculate_price_bump_bps(arg7, v8, 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::config::premium_bump_ratio_bps(arg5)), arg10);
        let v10 = 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::math::calculate_premium(arg7, v9, arg8 * 86400);
        let v11 = (((v10 as u128) * (0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::config::protocol_fee_bps(arg5) as u128) / 10000) as u64);
        if (0x2::coin::value<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>(&arg9) < v10 + v11) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_insufficient_payment();
        };
        let v12 = 0x2::coin::into_balance<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>(arg9);
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::capital_pool::add_protocol_fee(arg4, 0x2::balance::split<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>(&mut v12, v11));
        let v13 = 0x2::balance::split<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>(&mut v12, v10);
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::capital_pool::add_reserve(arg4, 0x2::balance::split<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>(&mut v13, v10 / 2));
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::staking_pool::deposit_premium(arg3, arg2, v0, 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::capital_pool::deposit_(arg4, arg5, arg2, v13, arg10));
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::risk_manager::update_coverage(arg2, v0, arg7, true);
        let v14 = 0x2::clock::timestamp_ms(arg10);
        let v15 = v14 + arg8 * 86400 * 1000;
        let v16 = Cover{
            id                 : 0x2::object::new(arg11),
            protocol_id        : v0,
            remaining_capacity : arg7,
            expire_at          : v15,
            start_at           : v14,
        };
        arg0.next_cover_id = arg0.next_cover_id + 1;
        let v17 = arg0.next_cover_id;
        0x2::table::add<u64, Cover>(&mut arg0.covers, v17, v16);
        let v18 = CoverReceipt{
            id          : 0x2::object::new(arg11),
            cover_id    : v17,
            protocol_id : v0,
            amount      : arg7,
            expire_at   : v15,
        };
        let v19 = BuyCoverEvent{
            sender         : 0x2::tx_context::sender(arg11),
            cover_id       : v17,
            protocol_id    : v0,
            amount         : arg7,
            premium_amount : v10,
            duration_days  : arg8,
            expire_at      : v15,
        };
        0x2::event::emit<BuyCoverEvent>(v19);
        (v18, 0x2::coin::from_balance<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>(v12, arg11))
    }

    public fun cover_expire_at(arg0: &Cover) : u64 {
        arg0.expire_at
    }

    public fun cover_protocol_id(arg0: &Cover) : vector<u8> {
        let v0 = &arg0.protocol_id;
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(v0)) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(v0, v2));
            v2 = v2 + 1;
        };
        v1
    }

    public fun cover_receipt_amount(arg0: &CoverReceipt) : u64 {
        arg0.amount
    }

    public fun cover_receipt_cover_id(arg0: &CoverReceipt) : u64 {
        arg0.cover_id
    }

    public fun cover_remaining_capacity(arg0: &Cover) : u64 {
        arg0.remaining_capacity
    }

    public fun cover_start_at(arg0: &Cover) : u64 {
        arg0.start_at
    }

    public fun expire_cover_by_id(arg0: &mut CoverVault, arg1: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::Version, arg2: u64, arg3: &mut 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::risk_manager::RiskRegistry, arg4: &0x2::clock::Clock) {
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::check_version(arg1);
        if (!0x2::table::contains<u64, Cover>(&arg0.covers, arg2)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_cover_not_found();
        };
        if (0x2::clock::timestamp_ms(arg4) >= 0x2::table::borrow<u64, Cover>(&arg0.covers, arg2).expire_at) {
            let Cover {
                id                 : v0,
                protocol_id        : v1,
                remaining_capacity : v2,
                expire_at          : _,
                start_at           : _,
            } = 0x2::table::remove<u64, Cover>(&mut arg0.covers, arg2);
            let v5 = ExpireCoverEvent{
                cover_id           : arg2,
                protocol_id        : v1,
                remaining_capacity : v2,
            };
            0x2::event::emit<ExpireCoverEvent>(v5);
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::risk_manager::update_coverage(arg3, v1, v2, false);
            0x2::object::delete(v0);
        } else {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_cover_not_yet_expired();
        };
    }

    public fun get_cover_protocol_id(arg0: &CoverVault, arg1: u64) : vector<u8> {
        if (!vault_contains_cover(arg0, arg1)) {
            return 0x1::vector::empty<u8>()
        };
        cover_protocol_id(vault_borrow_cover(arg0, arg1))
    }

    public fun get_premium(arg0: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::risk_manager::RiskRegistry, arg1: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::config::Config, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) : u64 {
        let v0 = *0x1::string::as_bytes(&arg2);
        let (_, _, _, _) = 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::risk_manager::get_protocol_status(arg0, v0);
        let (v5, v6, v7) = 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::risk_manager::get_protocol_premium_state(arg0, v0);
        if (v5 == 0 && v6 == 0) {
            return 0
        };
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::math::calculate_premium(arg3, 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::math::get_base_price_bps(v6, v7, v5, 0x2::clock::timestamp_ms(arg5) / 1000, 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::config::premium_change_per_day_bps(arg1)), arg4 * 86400)
    }

    public fun get_premium_with_fee(arg0: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::risk_manager::RiskRegistry, arg1: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::config::Config, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) : u64 {
        let v0 = get_premium(arg0, arg1, arg2, arg3, arg4, arg5);
        v0 + (((v0 as u128) * (0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::config::protocol_fee_bps(arg1) as u128) / 10000) as u64)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CoverVault{
            id            : 0x2::object::new(arg0),
            next_cover_id : 0,
            covers        : 0x2::table::new<u64, Cover>(arg0),
        };
        0x2::transfer::share_object<CoverVault>(v0);
    }

    public fun vault_borrow_cover(arg0: &CoverVault, arg1: u64) : &Cover {
        0x2::table::borrow<u64, Cover>(&arg0.covers, arg1)
    }

    public fun vault_contains_cover(arg0: &CoverVault, arg1: u64) : bool {
        0x2::table::contains<u64, Cover>(&arg0.covers, arg1)
    }

    // decompiled from Move bytecode v6
}

