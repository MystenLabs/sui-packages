module 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::treasury {
    struct FeeVault<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        buyback: 0x2::balance::Balance<0x2::sui::SUI>,
        last_buyback_ms: u64,
        total_deposited: u64,
        total_swept: u64,
        total_buyback_mist: u64,
        total_coin_bought: u64,
    }

    struct BuybackCap has store, key {
        id: 0x2::object::UID,
    }

    struct BuybackReceipt<phantom T0> {
        vault_id: 0x2::object::ID,
        sui_amount: u64,
        min_out: u64,
    }

    struct FeesDeposited has copy, drop {
        vault_id: 0x2::object::ID,
        source: 0x1::type_name::TypeName,
        amount: u64,
        to_treasury: u64,
        to_buyback: u64,
    }

    struct TreasurySwept has copy, drop {
        vault_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
    }

    struct BuybackExecuted has copy, drop {
        vault_id: 0x2::object::ID,
        sui_in: u64,
        coin_out: u64,
        min_out: u64,
        to_pool: u64,
        to_burn: u64,
    }

    struct BuybackCapIssued has copy, drop {
        cap_id: 0x2::object::ID,
    }

    struct BuybackCapRevoked has copy, drop {
        cap_id: 0x2::object::ID,
    }

    public(friend) fun new<T0>(arg0: &mut 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::EconomyRegistry) : FeeVault<T0> {
        FeeVault<T0>{
            id                 : 0x2::derived_object::claim<0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::InstanceKey<T0>>(0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::uid_mut(arg0), 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::instance_key<T0>(0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::kind_fee_vault())),
            version            : 1,
            treasury           : 0x2::balance::zero<0x2::sui::SUI>(),
            buyback            : 0x2::balance::zero<0x2::sui::SUI>(),
            last_buyback_ms    : 0,
            total_deposited    : 0,
            total_swept        : 0,
            total_buyback_mist : 0,
            total_coin_bought  : 0,
        }
    }

    fun assert_version<T0>(arg0: &FeeVault<T0>) {
        assert!(arg0.version == 1, 13906835767776247809);
    }

    public fun begin_buyback<T0>(arg0: &mut FeeVault<T0>, arg1: &BuybackCap, arg2: &0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::EconomyConfig<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, BuybackReceipt<T0>) {
        assert_version<T0>(arg0);
        0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::assert_version<T0>(arg2);
        assert!(0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::buyback_cap_id<T0>(arg2) == 0x1::option::some<0x2::object::ID>(0x2::object::id<BuybackCap>(arg1)), 13906835076286644227);
        0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::assert_not_paused<T0>(arg2);
        let v0 = 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::buyback_limits<T0>(arg2);
        assert!(0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::min_rate(&v0) > 0, 13906835089173119003);
        assert!(arg3 > 0, 13906835093466644485);
        assert!(arg3 <= 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::max_buyback_mist(&v0), 13906835097761742855);
        assert!(arg3 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.buyback), 13906835102056841225);
        assert!(arg4 > 0, 13906835106352070669);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        assert!(arg0.total_buyback_mist == 0 || v1 >= arg0.last_buyback_ms + 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::min_interval_ms(&v0), 13906835123531808779);
        arg0.last_buyback_ms = v1;
        arg0.total_buyback_mist = arg0.total_buyback_mist + arg3;
        let v2 = BuybackReceipt<T0>{
            vault_id   : 0x2::object::id<FeeVault<T0>>(arg0),
            sui_amount : arg3,
            min_out    : arg4,
        };
        (0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.buyback, arg3), arg6), v2)
    }

    public fun buyback_value<T0>(arg0: &FeeVault<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.buyback)
    }

    public fun deposit<T0, T1: drop>(arg0: &mut FeeVault<T0>, arg1: &0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::EconomyConfig<T0>, arg2: T1, arg3: 0x2::balance::Balance<0x2::sui::SUI>) {
        assert_version<T0>(arg0);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg3);
        assert!(v0 > 0, 13906834857243443205);
        let v1 = 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::fee_split<T0>(arg1);
        let v2 = 0x1::u64::mul_div(v0, 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::treasury_bps(&v1), 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::bps());
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, 0x2::balance::split<0x2::sui::SUI>(&mut arg3, v2));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.buyback, arg3);
        arg0.total_deposited = arg0.total_deposited + v0;
        let v3 = FeesDeposited{
            vault_id    : 0x2::object::id<FeeVault<T0>>(arg0),
            source      : 0x1::type_name::with_defining_ids<T1>(),
            amount      : v0,
            to_treasury : v2,
            to_buyback  : 0x2::balance::value<0x2::sui::SUI>(&arg3),
        };
        0x2::event::emit<FeesDeposited>(v3);
    }

    public fun end_buyback<T0>(arg0: &mut FeeVault<T0>, arg1: &mut 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::rewards::RewardsPool<T0>, arg2: &mut 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::burn::BurnVault<T0>, arg3: &0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::EconomyConfig<T0>, arg4: BuybackReceipt<T0>, arg5: 0x2::coin::Coin<T0>) {
        assert_version<T0>(arg0);
        0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::assert_version<T0>(arg3);
        0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::rewards::assert_version<T0>(arg1);
        let BuybackReceipt {
            vault_id   : v0,
            sui_amount : v1,
            min_out    : v2,
        } = arg4;
        assert!(v0 == 0x2::object::id<FeeVault<T0>>(arg0), 13906835265266253843);
        let v3 = 0x2::coin::value<T0>(&arg5);
        assert!(v3 >= v2, 13906835273855926287);
        let v4 = 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::buyback_limits<T0>(arg3);
        assert!((v3 as u128) * (1000000000 as u128) >= (v1 as u128) * (0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::min_rate(&v4) as u128), 13906835295330893841);
        assert!(0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::rewards::rate_fills<T0>(arg1) == 0 || (v3 as u256) * (0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::rewards::rate_scale() as u256) * (10000 as u256) >= (v1 as u256) * (0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::rewards::rate_ema<T0>(arg1) as u256) * ((10000 - 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::rate_band_bps(&v4)) as u256), 13906835325396451357);
        let v5 = 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::fee_split<T0>(arg3);
        let v6 = 0x2::coin::into_balance<T0>(arg5);
        let v7 = 0x1::u64::mul_div(v3, 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::pool_bps(&v5), 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::pool_bps(&v5) + 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::burn_bps(&v5));
        0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::rewards::join<T0>(arg1, 0x2::balance::split<T0>(&mut v6, v7), 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::rewards::source_buyback());
        0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::burn::burn_balance<T0>(arg2, v6, 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::burn::source_buyback());
        0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::rewards::record_buyback_rate<T0>(arg1, arg3, v1, v3);
        arg0.total_coin_bought = arg0.total_coin_bought + v3;
        let v8 = BuybackExecuted{
            vault_id : v0,
            sui_in   : v1,
            coin_out : v3,
            min_out  : v2,
            to_pool  : v7,
            to_burn  : v3 - v7,
        };
        0x2::event::emit<BuybackExecuted>(v8);
    }

    public fun issue_buyback_cap<T0>(arg0: &mut 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::EconomyConfig<T0>, arg1: &0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::EconomyAdminCap, arg2: &mut 0x2::tx_context::TxContext) : BuybackCap {
        0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::assert_version<T0>(arg0);
        let v0 = 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::buyback_cap_id<T0>(arg0);
        if (0x1::option::is_some<0x2::object::ID>(&v0)) {
            let v1 = BuybackCapRevoked{cap_id: 0x1::option::destroy_some<0x2::object::ID>(v0)};
            0x2::event::emit<BuybackCapRevoked>(v1);
        } else {
            0x1::option::destroy_none<0x2::object::ID>(v0);
        };
        let v2 = BuybackCap{id: 0x2::object::new(arg2)};
        let v3 = 0x2::object::id<BuybackCap>(&v2);
        0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::set_buyback_cap_id<T0>(arg0, 0x1::option::some<0x2::object::ID>(v3));
        let v4 = BuybackCapIssued{cap_id: v3};
        0x2::event::emit<BuybackCapIssued>(v4);
        v2
    }

    public fun last_buyback_ms<T0>(arg0: &FeeVault<T0>) : u64 {
        arg0.last_buyback_ms
    }

    public fun migrate<T0>(arg0: &mut FeeVault<T0>, arg1: &0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::EconomyAdminCap) {
        assert!(arg0.version < 1, 13906835544439521305);
        arg0.version = 1;
    }

    public fun receipt_amount<T0>(arg0: &BuybackReceipt<T0>) : u64 {
        arg0.sui_amount
    }

    public fun receipt_min_out<T0>(arg0: &BuybackReceipt<T0>) : u64 {
        arg0.min_out
    }

    public fun revoke_buyback_cap<T0>(arg0: &mut 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::EconomyConfig<T0>, arg1: &0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::EconomyAdminCap) {
        0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::assert_version<T0>(arg0);
        let v0 = 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::buyback_cap_id<T0>(arg0);
        assert!(0x1::option::is_some<0x2::object::ID>(&v0), 13906835510079651863);
        0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::set_buyback_cap_id<T0>(arg0, 0x1::option::none<0x2::object::ID>());
        let v1 = BuybackCapRevoked{cap_id: 0x1::option::destroy_some<0x2::object::ID>(v0)};
        0x2::event::emit<BuybackCapRevoked>(v1);
    }

    public(friend) fun share<T0>(arg0: FeeVault<T0>) {
        0x2::transfer::share_object<FeeVault<T0>>(arg0);
    }

    public fun sweep_treasury<T0>(arg0: &mut FeeVault<T0>, arg1: &0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::EconomyConfig<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.treasury);
        assert!(v0 > 0, 13906834968913641493);
        let v1 = 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::treasury_recipient<T0>(arg1);
        arg0.total_swept = arg0.total_swept + v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.treasury), arg2), v1);
        let v2 = TreasurySwept{
            vault_id  : 0x2::object::id<FeeVault<T0>>(arg0),
            recipient : v1,
            amount    : v0,
        };
        0x2::event::emit<TreasurySwept>(v2);
    }

    public fun total_buyback_mist<T0>(arg0: &FeeVault<T0>) : u64 {
        arg0.total_buyback_mist
    }

    public fun total_coin_bought<T0>(arg0: &FeeVault<T0>) : u64 {
        arg0.total_coin_bought
    }

    public fun total_deposited<T0>(arg0: &FeeVault<T0>) : u64 {
        arg0.total_deposited
    }

    public fun total_swept<T0>(arg0: &FeeVault<T0>) : u64 {
        arg0.total_swept
    }

    public fun treasury_value<T0>(arg0: &FeeVault<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.treasury)
    }

    public fun version<T0>(arg0: &FeeVault<T0>) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

