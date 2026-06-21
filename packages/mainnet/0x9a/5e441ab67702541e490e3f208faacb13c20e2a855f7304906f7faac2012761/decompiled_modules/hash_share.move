module 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::hash_share {
    struct Redemption<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        round_id: u64,
        supply_at_open: u64,
        total_sats: u64,
        outstanding_supply: u64,
        paid_sats: u64,
        balance: 0x2::balance::Balance<T1>,
        deadline_ms: u64,
        is_expired: bool,
    }

    struct HashShareMinted has copy, drop {
        round_id: u64,
        miner: address,
        difficulty: u64,
        cap_id: address,
        miner_units: u64,
        fee_units: u64,
        fee_bps: u64,
    }

    struct RedemptionOpened has copy, drop {
        round_id: u64,
        cap_id: address,
        supply_at_open: u64,
        total_sats: u64,
        deadline_ms: u64,
    }

    struct HashShareRedeemed has copy, drop {
        round_id: u64,
        holder: address,
        burned_units: u64,
        received_sats: u64,
        outstanding_supply: u64,
    }

    struct RedemptionRecycled has copy, drop {
        round_id: u64,
        residual_sats: u64,
        paid_sats: u64,
    }

    public fun bundle_factor() : u64 {
        10000
    }

    public fun mint_share<T0>(arg0: &0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::hash_share_registry::HashShareRegistry, arg1: &mut 0x2::coin::TreasuryCap<T0>, arg2: 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::pool::ShareReceipt, arg3: &mut 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::miner::MinerRoundStats, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::pool::receipt_round_id(&arg2);
        let v1 = 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::pool::receipt_miner(&arg2);
        let v2 = 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::pool::receipt_difficulty(&arg2);
        let v3 = 0x2::object::id_address<0x2::coin::TreasuryCap<T0>>(arg1);
        0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::hash_share_registry::assert_cap_matches_round(arg0, v0, v3);
        0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::miner::record_sold_share(arg3, v1, v2, v0);
        let v4 = v2 / 10000;
        let v5 = 0x2::coin::mint<T0>(arg1, v4, arg4);
        let v6 = 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::hash_share_registry::fee_bps(arg0);
        let v7 = 0x1::option::destroy_some<u64>(0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u64::mul_div(v4, v6, 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::hash_share_registry::bps_denom(), 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::down()));
        if (v7 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v5, v7, arg4), 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::hash_share_registry::fee_recipient(arg0));
        };
        let v8 = HashShareMinted{
            round_id    : v0,
            miner       : v1,
            difficulty  : v2,
            cap_id      : v3,
            miner_units : 0x2::coin::value<T0>(&v5),
            fee_units   : v7,
            fee_bps     : v6,
        };
        0x2::event::emit<HashShareMinted>(v8);
        v5
    }

    public fun mint_share_to<T0>(arg0: &0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::hash_share_registry::HashShareRegistry, arg1: &mut 0x2::coin::TreasuryCap<T0>, arg2: 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::pool::ShareReceipt, arg3: &mut 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::miner::MinerRoundStats, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(mint_share<T0>(arg0, arg1, arg2, arg3, arg5), arg4);
    }

    public fun open_redemption<T0, T1>(arg0: &0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::hash_share_registry::HashShareRegistry, arg1: &0x2::coin::TreasuryCap<T0>, arg2: &mut 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::hashi_vault::HashiVault<T1>, arg3: &0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::pool::RoundHistory, arg4: &mut 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::hashi_pool::BlockDepositRecord, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::pool::round_history_round_id(arg3);
        assert!(0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::hashi_pool::record_round_id(arg4) == v0, 13906835282445139972);
        assert!(0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::hashi_pool::is_confirmed(arg4), 13906835286740238342);
        let v1 = 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::hashi_pool::funded_batch_id(arg4);
        assert!(!0x1::option::is_some<address>(&v1), 13906835295330959378);
        let v2 = 0x2::object::id_address<0x2::coin::TreasuryCap<T0>>(arg1);
        0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::hash_share_registry::assert_cap_matches_round(arg0, v0, v2);
        let v3 = 0x2::coin::total_supply<T0>(arg1);
        assert!(v3 > 0, 13906835321100238858);
        let v4 = 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::hashi_pool::record_amount_sats(arg4);
        assert!(v4 > 0, 13906835333985009672);
        let v5 = Redemption<T0, T1>{
            id                 : 0x2::object::new(arg6),
            round_id           : v0,
            supply_at_open     : v3,
            total_sats         : v4,
            outstanding_supply : v3,
            paid_sats          : 0,
            balance            : 0x2::balance::zero<T1>(),
            deadline_ms        : 0x2::clock::timestamp_ms(arg5) + 2592000000,
            is_expired         : false,
        };
        0x2::balance::join<T1>(&mut v5.balance, 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::hashi_vault::take_exact_hbtc<T1>(arg2, v4));
        0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::hashi_pool::mark_funded(arg4, 0x2::object::uid_to_address(&v5.id));
        let v6 = RedemptionOpened{
            round_id       : v0,
            cap_id         : v2,
            supply_at_open : v3,
            total_sats     : v4,
            deadline_ms    : v5.deadline_ms,
        };
        0x2::event::emit<RedemptionOpened>(v6);
        0x2::transfer::share_object<Redemption<T0, T1>>(v5);
    }

    public fun recycle_expired_redemption<T0, T1>(arg0: &mut Redemption<T0, T1>, arg1: &mut 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::hashi_vault::HashiVault<T1>, arg2: &0x2::clock::Clock) {
        assert!(!arg0.is_expired, 13906835711942656016);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.deadline_ms, 13906835716237492238);
        let v0 = 0x2::balance::value<T1>(&arg0.balance);
        if (v0 > 0) {
            0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::hashi_vault::deposit_hbtc<T1>(arg1, 0x2::balance::split<T1>(&mut arg0.balance, v0));
        };
        arg0.is_expired = true;
        let v1 = RedemptionRecycled{
            round_id      : arg0.round_id,
            residual_sats : v0,
            paid_sats     : arg0.paid_sats,
        };
        0x2::event::emit<RedemptionRecycled>(v1);
    }

    public fun redeem<T0, T1>(arg0: &mut Redemption<T0, T1>, arg1: &mut 0x2::coin::TreasuryCap<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(!arg0.is_expired, 13906835531554029584);
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.deadline_ms, 13906835535848996880);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 13906835548733636620);
        let v1 = 0x1::option::destroy_some<u64>(0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u64::mul_div(v0, arg0.total_sats, arg0.supply_at_open, 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::down()));
        0x2::coin::burn<T0>(arg1, arg2);
        arg0.outstanding_supply = arg0.outstanding_supply - v0;
        arg0.paid_sats = arg0.paid_sats + v1;
        let v2 = HashShareRedeemed{
            round_id           : arg0.round_id,
            holder             : 0x2::tx_context::sender(arg4),
            burned_units       : v0,
            received_sats      : v1,
            outstanding_supply : arg0.outstanding_supply,
        };
        0x2::event::emit<HashShareRedeemed>(v2);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.balance, v1), arg4)
    }

    public fun redemption_balance<T0, T1>(arg0: &Redemption<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.balance)
    }

    public fun redemption_deadline_ms<T0, T1>(arg0: &Redemption<T0, T1>) : u64 {
        arg0.deadline_ms
    }

    public fun redemption_is_expired<T0, T1>(arg0: &Redemption<T0, T1>) : bool {
        arg0.is_expired
    }

    public fun redemption_outstanding_supply<T0, T1>(arg0: &Redemption<T0, T1>) : u64 {
        arg0.outstanding_supply
    }

    public fun redemption_paid_sats<T0, T1>(arg0: &Redemption<T0, T1>) : u64 {
        arg0.paid_sats
    }

    public fun redemption_round_id<T0, T1>(arg0: &Redemption<T0, T1>) : u64 {
        arg0.round_id
    }

    public fun redemption_supply_at_open<T0, T1>(arg0: &Redemption<T0, T1>) : u64 {
        arg0.supply_at_open
    }

    public fun redemption_total_sats<T0, T1>(arg0: &Redemption<T0, T1>) : u64 {
        arg0.total_sats
    }

    // decompiled from Move bytecode v6
}

