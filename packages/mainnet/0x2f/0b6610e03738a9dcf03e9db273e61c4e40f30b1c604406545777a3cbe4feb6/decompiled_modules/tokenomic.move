module 0xa00d14642a0faa3236f80a990568447a57a51d057ca4dc79f623db5b7334f58d::tokenomic {
    struct TOKENOMIC has drop {
        dummy_field: bool,
    }

    struct TAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TokenomicFundAddedEvent has copy, drop {
        owner: address,
        name: vector<u8>,
        vesting_type: u8,
        tge_ms: u64,
        cliff_ms: u64,
        unlock_percent: u64,
        linear_vesting_duration_ms: u64,
        milestone_times: vector<u64>,
        milestone_percents: vector<u64>,
        vesting_fund_total: u128,
        pie_percent: u128,
    }

    struct TokenomicFundClaimEvent has copy, drop {
        owner: address,
        name: vector<u8>,
        vesting_type: u8,
        tge_ms: u64,
        cliff_ms: u64,
        unlock_percent: u64,
        linear_vesting_duration_ms: u64,
        milestone_times: vector<u64>,
        milestone_percents: vector<u64>,
        last_claim_ms: u64,
        vesting_fund_total: u128,
        vesting_fund_total_released: u128,
        vesting_fund_claimed: u128,
        pie_percent: u128,
    }

    struct TokenomicFundOwnerChangedEvent has copy, drop {
        owner: address,
        name: vector<u8>,
        vesting_type: u8,
        tge_ms: u64,
        cliff_ms: u64,
        unlock_percent: u64,
        linear_vesting_duration_ms: u64,
        milestone_times: vector<u64>,
        milestone_percents: vector<u64>,
        last_claim_ms: u64,
        vesting_fund_total: u128,
        vesting_fund_total_released: u128,
        pie_percent: u128,
        new_owner: address,
    }

    struct TokenomicFund<phantom T0> has store {
        owner: address,
        name: vector<u8>,
        vesting_type: u8,
        tge_ms: u64,
        cliff_ms: u64,
        unlock_percent: u64,
        linear_vesting_duration_ms: u64,
        milestone_times: vector<u64>,
        milestone_percents: vector<u64>,
        last_claim_ms: u64,
        vesting_fund_total: u128,
        vesting_fund: 0x2::coin::Coin<T0>,
        vesting_fund_released: u128,
        pie_percent: u128,
    }

    struct TokenomicPie<phantom T0> has store, key {
        id: 0x2::object::UID,
        tge_ms: u64,
        total_supply: u128,
        total_shares: u128,
        total_shares_percent: u128,
        shares: 0x2::table::Table<address, TokenomicFund<T0>>,
    }

    public fun addFund<T0>(arg0: &TAdminCap, arg1: &mut TokenomicPie<T0>, arg2: address, arg3: vector<u8>, arg4: u8, arg5: u64, arg6: u64, arg7: 0x2::coin::Coin<T0>, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0xa00d14642a0faa3236f80a990568447a57a51d057ca4dc79f623db5b7334f58d::version::Version, arg12: vector<u64>, arg13: vector<u64>, arg14: &mut 0x2::tx_context::TxContext) {
        0xa00d14642a0faa3236f80a990568447a57a51d057ca4dc79f623db5b7334f58d::version::checkVersion(arg11, 1);
        assert!(arg4 >= 1 && arg4 <= 4, 8008);
        assert!(arg5 >= 0x2::clock::timestamp_ms(arg10) && 0x1::vector::length<u8>(&arg3) > 0 && arg8 >= 0 && arg8 <= 10000 && arg6 >= 0, 8003);
        let v0 = (0x2::coin::value<T0>(&arg7) as u128);
        assert!(v0 > 0, 8003);
        if (arg4 == 2 || arg4 == 1) {
            assert!(0x1::vector::length<u64>(&arg12) == 0x1::vector::length<u64>(&arg13) && 0x1::vector::length<u64>(&arg12) >= 0 && arg9 == 0, 8009);
            let v1 = arg8;
            let v2 = 0;
            while (v2 < 0x1::vector::length<u64>(&arg12)) {
                v1 = v1 + *0x1::vector::borrow<u64>(&arg13, v2);
                let v3 = *0x1::vector::borrow<u64>(&arg12, v2);
                assert!(v3 >= arg5 + arg6 && v3 > 0, 8009);
                v2 = v2 + 1;
            };
            assert!(v1 == 10000, 8009);
        } else {
            assert!(0x1::vector::length<u64>(&arg12) == 0 && 0x1::vector::length<u64>(&arg13) == 0 && arg9 > 0 && arg9 < 311040000000, 8009);
        };
        arg1.total_shares = arg1.total_shares + v0;
        arg1.total_shares_percent = arg1.total_shares * (10000 as u128) / arg1.total_supply;
        let v4 = v0 * (10000 as u128) / arg1.total_supply;
        let v5 = TokenomicFund<T0>{
            owner                      : arg2,
            name                       : arg3,
            vesting_type               : arg4,
            tge_ms                     : arg5,
            cliff_ms                   : arg6,
            unlock_percent             : arg8,
            linear_vesting_duration_ms : arg9,
            milestone_times            : arg12,
            milestone_percents         : arg13,
            last_claim_ms              : 0,
            vesting_fund_total         : v0,
            vesting_fund               : arg7,
            vesting_fund_released      : 0,
            pie_percent                : v4,
        };
        0x2::table::add<address, TokenomicFund<T0>>(&mut arg1.shares, arg2, v5);
        let v6 = TokenomicFundAddedEvent{
            owner                      : arg2,
            name                       : arg3,
            vesting_type               : arg4,
            tge_ms                     : arg5,
            cliff_ms                   : arg6,
            unlock_percent             : arg8,
            linear_vesting_duration_ms : arg9,
            milestone_times            : arg12,
            milestone_percents         : arg13,
            vesting_fund_total         : v0,
            pie_percent                : v4,
        };
        0x2::event::emit<TokenomicFundAddedEvent>(v6);
    }

    public fun addFund2<T0>(arg0: &TAdminCap, arg1: &mut TokenomicPie<T0>, arg2: address, arg3: vector<u8>, arg4: u8, arg5: u64, arg6: u64, arg7: 0x2::coin::Coin<T0>, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0xa00d14642a0faa3236f80a990568447a57a51d057ca4dc79f623db5b7334f58d::version::Version, arg12: vector<u64>, arg13: vector<u64>, arg14: &mut 0x2::tx_context::TxContext) {
        0xa00d14642a0faa3236f80a990568447a57a51d057ca4dc79f623db5b7334f58d::version::checkVersion(arg11, 1);
        assert!(arg4 >= 1 && arg4 <= 4, 8008);
        0x2::clock::timestamp_ms(arg10);
        assert!(0x1::vector::length<u8>(&arg3) > 0 && arg8 >= 0 && arg8 <= 10000 && arg6 >= 0, 8003);
        let v0 = (0x2::coin::value<T0>(&arg7) as u128);
        assert!(v0 > 0, 8003);
        if (arg4 == 2 || arg4 == 1) {
            assert!(0x1::vector::length<u64>(&arg12) == 0x1::vector::length<u64>(&arg13) && 0x1::vector::length<u64>(&arg12) >= 0 && arg9 == 0, 8009);
            let v1 = arg8;
            let v2 = 0;
            while (v2 < 0x1::vector::length<u64>(&arg12)) {
                v1 = v1 + *0x1::vector::borrow<u64>(&arg13, v2);
                let v3 = *0x1::vector::borrow<u64>(&arg12, v2);
                assert!(v3 >= arg5 + arg6 && v3 > 0, 8009);
                v2 = v2 + 1;
            };
            assert!(v1 == 10000, 8009);
        } else {
            assert!(0x1::vector::length<u64>(&arg12) == 0 && 0x1::vector::length<u64>(&arg13) == 0 && arg9 > 0 && arg9 < 311040000000, 8009);
        };
        arg1.total_shares = arg1.total_shares + v0;
        arg1.total_shares_percent = arg1.total_shares * (10000 as u128) / arg1.total_supply;
        let v4 = v0 * (10000 as u128) / arg1.total_supply;
        let v5 = TokenomicFund<T0>{
            owner                      : arg2,
            name                       : arg3,
            vesting_type               : arg4,
            tge_ms                     : arg5,
            cliff_ms                   : arg6,
            unlock_percent             : arg8,
            linear_vesting_duration_ms : arg9,
            milestone_times            : arg12,
            milestone_percents         : arg13,
            last_claim_ms              : 0,
            vesting_fund_total         : v0,
            vesting_fund               : arg7,
            vesting_fund_released      : 0,
            pie_percent                : v4,
        };
        0x2::table::add<address, TokenomicFund<T0>>(&mut arg1.shares, arg2, v5);
        let v6 = TokenomicFundAddedEvent{
            owner                      : arg2,
            name                       : arg3,
            vesting_type               : arg4,
            tge_ms                     : arg5,
            cliff_ms                   : arg6,
            unlock_percent             : arg8,
            linear_vesting_duration_ms : arg9,
            milestone_times            : arg12,
            milestone_percents         : arg13,
            vesting_fund_total         : v0,
            pie_percent                : v4,
        };
        0x2::event::emit<TokenomicFundAddedEvent>(v6);
    }

    fun cal_claim_percent<T0>(arg0: &TokenomicFund<T0>, arg1: u64) : u64 {
        let v0 = &arg0.milestone_times;
        let v1 = &arg0.milestone_percents;
        let v2 = arg0.tge_ms;
        let v3 = 0;
        let v4 = v3;
        if (arg0.vesting_type == 2) {
            if (arg1 >= v2 + arg0.cliff_ms) {
                v4 = v3 + arg0.unlock_percent;
                let v5 = 0;
                while (v5 < 0x1::vector::length<u64>(v0)) {
                    if (arg1 >= *0x1::vector::borrow<u64>(v0, v5)) {
                        v4 = v4 + *0x1::vector::borrow<u64>(v1, v5);
                        v5 = v5 + 1;
                    } else {
                        break
                    };
                };
            };
        } else if (arg0.vesting_type == 1) {
            if (arg1 >= v2) {
                v4 = v3 + arg0.unlock_percent;
                if (arg1 >= v2 + arg0.cliff_ms) {
                    let v6 = 0;
                    while (v6 < 0x1::vector::length<u64>(v0)) {
                        if (arg1 >= *0x1::vector::borrow<u64>(v0, v6)) {
                            v4 = v4 + *0x1::vector::borrow<u64>(v1, v6);
                            v6 = v6 + 1;
                        } else {
                            break
                        };
                    };
                };
            };
        } else if (arg0.vesting_type == 3) {
            if (arg1 >= v2) {
                let v7 = v3 + arg0.unlock_percent;
                v4 = v7;
                if (arg1 >= v2 + arg0.cliff_ms) {
                    v4 = v7 + (arg1 - v2 - arg0.cliff_ms) * (10000 - arg0.unlock_percent) / arg0.linear_vesting_duration_ms;
                };
            };
        } else if (arg0.vesting_type == 4) {
            if (arg1 >= v2 + arg0.cliff_ms) {
                v4 = v3 + arg0.unlock_percent + (arg1 - v2 - arg0.cliff_ms) * (10000 - arg0.unlock_percent) / arg0.linear_vesting_duration_ms;
            };
        };
        0x2::math::min(v4, 10000)
    }

    public fun change_admin(arg0: TAdminCap, arg1: address, arg2: &mut 0xa00d14642a0faa3236f80a990568447a57a51d057ca4dc79f623db5b7334f58d::version::Version) {
        0xa00d14642a0faa3236f80a990568447a57a51d057ca4dc79f623db5b7334f58d::version::checkVersion(arg2, 1);
        0x2::transfer::transfer<TAdminCap>(arg0, arg1);
    }

    public fun change_fund_owner<T0>(arg0: &mut TokenomicPie<T0>, arg1: address, arg2: &mut 0xa00d14642a0faa3236f80a990568447a57a51d057ca4dc79f623db5b7334f58d::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xa00d14642a0faa3236f80a990568447a57a51d057ca4dc79f623db5b7334f58d::version::checkVersion(arg2, 1);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, TokenomicFund<T0>>(&arg0.shares, v0) && !0x2::table::contains<address, TokenomicFund<T0>>(&arg0.shares, arg1), 8006);
        let v1 = 0x2::table::borrow_mut<address, TokenomicFund<T0>>(&mut arg0.shares, v0);
        let v2 = v1.owner;
        v1.owner = arg1;
        0x2::table::add<address, TokenomicFund<T0>>(&mut arg0.shares, arg1, 0x2::table::remove<address, TokenomicFund<T0>>(&mut arg0.shares, v0));
        let v3 = 0x2::table::borrow<address, TokenomicFund<T0>>(&mut arg0.shares, v0);
        let v4 = TokenomicFundOwnerChangedEvent{
            owner                       : v2,
            name                        : v3.name,
            vesting_type                : v3.vesting_type,
            tge_ms                      : v3.tge_ms,
            cliff_ms                    : v3.cliff_ms,
            unlock_percent              : v3.unlock_percent,
            linear_vesting_duration_ms  : v3.linear_vesting_duration_ms,
            milestone_times             : v3.milestone_times,
            milestone_percents          : v3.milestone_percents,
            last_claim_ms               : v3.last_claim_ms,
            vesting_fund_total          : v3.vesting_fund_total,
            vesting_fund_total_released : v3.vesting_fund_released,
            pie_percent                 : v3.pie_percent,
            new_owner                   : v3.owner,
        };
        0x2::event::emit<TokenomicFundOwnerChangedEvent>(v4);
    }

    public fun claim<T0>(arg0: &mut TokenomicPie<T0>, arg1: &0x2::clock::Clock, arg2: &0xa00d14642a0faa3236f80a990568447a57a51d057ca4dc79f623db5b7334f58d::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xa00d14642a0faa3236f80a990568447a57a51d057ca4dc79f623db5b7334f58d::version::checkVersion(arg2, 1);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.tge_ms, 8004);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, TokenomicFund<T0>>(&arg0.shares, v1), 8011);
        let v2 = 0x2::table::borrow_mut<address, TokenomicFund<T0>>(&mut arg0.shares, v1);
        assert!(v1 == v2.owner, 8006);
        assert!(v0 >= v2.tge_ms, 8004);
        let v3 = (cal_claim_percent<T0>(v2, v0) as u128);
        assert!(v3 > 0, 8010);
        let v4 = v2.vesting_fund_total * v3 / (10000 as u128) - v2.vesting_fund_released;
        assert!(v4 > 0, 8007);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v2.vesting_fund, (v4 as u64), arg3), v1);
        v2.vesting_fund_released = v2.vesting_fund_released + v4;
        v2.last_claim_ms = v0;
        let v5 = TokenomicFundClaimEvent{
            owner                       : v2.owner,
            name                        : v2.name,
            vesting_type                : v2.vesting_type,
            tge_ms                      : v2.tge_ms,
            cliff_ms                    : v2.cliff_ms,
            unlock_percent              : v2.unlock_percent,
            linear_vesting_duration_ms  : v2.linear_vesting_duration_ms,
            milestone_times             : v2.milestone_times,
            milestone_percents          : v2.milestone_percents,
            last_claim_ms               : v2.last_claim_ms,
            vesting_fund_total          : v2.vesting_fund_total,
            vesting_fund_total_released : v2.vesting_fund_released,
            vesting_fund_claimed        : v4,
            pie_percent                 : v2.pie_percent,
        };
        0x2::event::emit<TokenomicFundClaimEvent>(v5);
    }

    public fun getFundReleased<T0>(arg0: &TokenomicPie<T0>, arg1: address) : u128 {
        0x2::table::borrow<address, TokenomicFund<T0>>(&arg0.shares, arg1).vesting_fund_released
    }

    public fun getFundTotal<T0>(arg0: &TokenomicPie<T0>, arg1: address) : u128 {
        0x2::table::borrow<address, TokenomicFund<T0>>(&arg0.shares, arg1).vesting_fund_total
    }

    public fun getFundUnlockPercent<T0>(arg0: &TokenomicPie<T0>, arg1: address) : u64 {
        0x2::table::borrow<address, TokenomicFund<T0>>(&arg0.shares, arg1).unlock_percent
    }

    public fun getFundVestingAvailable<T0>(arg0: &TokenomicPie<T0>, arg1: address) : u128 {
        (0x2::coin::value<T0>(&0x2::table::borrow<address, TokenomicFund<T0>>(&arg0.shares, arg1).vesting_fund) as u128)
    }

    public fun getPieTgeTimeMs<T0>(arg0: &TokenomicPie<T0>) : u64 {
        arg0.tge_ms
    }

    public fun getPieTotalShare<T0>(arg0: &TokenomicPie<T0>) : u128 {
        arg0.total_shares
    }

    public fun getPieTotalSharePercent<T0>(arg0: &TokenomicPie<T0>) : u128 {
        arg0.total_shares_percent
    }

    public fun getPieTotalSupply<T0>(arg0: &TokenomicPie<T0>) : u128 {
        arg0.total_supply
    }

    fun init(arg0: TOKENOMIC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<TAdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun init_tokenomic<T0>(arg0: &TAdminCap, arg1: u128, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0xa00d14642a0faa3236f80a990568447a57a51d057ca4dc79f623db5b7334f58d::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xa00d14642a0faa3236f80a990568447a57a51d057ca4dc79f623db5b7334f58d::version::checkVersion(arg4, 1);
        assert!(arg2 >= 0x2::clock::timestamp_ms(arg3), 8001);
        assert!(arg1 > 0, 8002);
        let v0 = TokenomicPie<T0>{
            id                   : 0x2::object::new(arg5),
            tge_ms               : arg2,
            total_supply         : arg1,
            total_shares         : 0,
            total_shares_percent : 0,
            shares               : 0x2::table::new<address, TokenomicFund<T0>>(arg5),
        };
        0x2::transfer::share_object<TokenomicPie<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

