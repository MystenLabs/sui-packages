module 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::hashi_rewards {
    struct HashiRewardRegistry has key {
        id: 0x2::object::UID,
        total_batches: u64,
        total_sats_distributed: u128,
        total_sats_expired: u128,
    }

    struct HashiRewardBatch<phantom T0> has key {
        id: 0x2::object::UID,
        round_id: u64,
        total_sats: u64,
        claimed_sats: u64,
        balance: 0x2::balance::Balance<T0>,
        status: u8,
        created_at_ms: u64,
        funded_at_ms: 0x1::option::Option<u64>,
        claim_deadline_ms: u64,
        completed_at_ms: 0x1::option::Option<u64>,
    }

    struct HashiBatchCreated has copy, drop {
        batch_id: address,
        round_id: u64,
        total_sats: u64,
    }

    struct HashiBatchFunded has copy, drop {
        batch_id: address,
        round_id: u64,
        total_sats: u64,
        claim_deadline_ms: u64,
    }

    struct HashiRewardClaimed has copy, drop {
        batch_id: address,
        round_id: u64,
        miner: address,
        amount_sats: u64,
    }

    struct HashiBatchCompleted has copy, drop {
        batch_id: address,
        round_id: u64,
        total_sats: u64,
    }

    struct HashiBatchExpired has copy, drop {
        batch_id: address,
        round_id: u64,
        reclaimed_sats: u64,
        claimed_sats: u64,
    }

    public fun claim_reward<T0>(arg0: &mut HashiRewardRegistry, arg1: &mut HashiRewardBatch<T0>, arg2: 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::pool::MinerWorkRecord, arg3: &0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::pool::RoundHistory, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 1, 13906835359754616837);
        assert!(0x2::clock::timestamp_ms(arg4) < arg1.claim_deadline_ms, 13906835364049715207);
        let (v0, v1, v2) = 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::pool::consume_work_record(arg2);
        assert!(v0 == arg1.round_id, 13906835381229846539);
        assert!(v0 == 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::pool::round_history_round_id(arg3), 13906835385524813835);
        assert!(v1 == 0x2::tx_context::sender(arg5), 13906835389820043279);
        let v3 = 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::pool::round_history_total_work(arg3);
        assert!(v3 > 0, 13906835415589715981);
        let v4 = (0x1::option::destroy_some<u128>(0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u128::mul_div(v2, (arg1.total_sats as u128), v3, 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::down())) as u64);
        arg1.claimed_sats = arg1.claimed_sats + v4;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, v4), arg5), v1);
        let v5 = HashiRewardClaimed{
            batch_id    : 0x2::object::uid_to_address(&arg1.id),
            round_id    : arg1.round_id,
            miner       : v1,
            amount_sats : v4,
        };
        0x2::event::emit<HashiRewardClaimed>(v5);
        if (0x2::balance::value<T0>(&arg1.balance) == 0) {
            arg1.status = 2;
            arg1.completed_at_ms = 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg4));
            arg0.total_sats_distributed = arg0.total_sats_distributed + (arg1.claimed_sats as u128);
            let v6 = HashiBatchCompleted{
                batch_id   : 0x2::object::uid_to_address(&arg1.id),
                round_id   : arg1.round_id,
                total_sats : arg1.total_sats,
            };
            0x2::event::emit<HashiBatchCompleted>(v6);
        };
    }

    public fun get_batch_balance<T0>(arg0: &HashiRewardBatch<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun get_batch_claimed_sats<T0>(arg0: &HashiRewardBatch<T0>) : u64 {
        arg0.claimed_sats
    }

    public fun get_batch_round_id<T0>(arg0: &HashiRewardBatch<T0>) : u64 {
        arg0.round_id
    }

    public fun get_batch_status<T0>(arg0: &HashiRewardBatch<T0>) : u8 {
        arg0.status
    }

    public fun get_batch_total_sats<T0>(arg0: &HashiRewardBatch<T0>) : u64 {
        arg0.total_sats
    }

    public fun get_claim_deadline<T0>(arg0: &HashiRewardBatch<T0>) : u64 {
        arg0.claim_deadline_ms
    }

    public fun get_registry_stats(arg0: &HashiRewardRegistry) : (u64, u128, u128) {
        (arg0.total_batches, arg0.total_sats_distributed, arg0.total_sats_expired)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = HashiRewardRegistry{
            id                     : 0x2::object::new(arg0),
            total_batches          : 0,
            total_sats_distributed : 0,
            total_sats_expired     : 0,
        };
        0x2::transfer::share_object<HashiRewardRegistry>(v0);
    }

    public fun open_and_fund_round_batch<T0>(arg0: &mut HashiRewardRegistry, arg1: &mut 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::hashi_vault::HashiVault<T0>, arg2: &0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::pool::RoundHistory, arg3: &mut 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::hashi_pool::BlockDepositRecord, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::hashi_pool::record_round_id(arg3) == 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::pool::round_history_round_id(arg2), 13906834925963313163);
        assert!(0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::hashi_pool::is_confirmed(arg3), 13906834934553640977);
        let v0 = 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::hashi_pool::record_amount_sats(arg3);
        assert!(v0 > 0, 13906834947438673939);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::pool::round_history_round_id(arg2);
        let v3 = HashiRewardBatch<T0>{
            id                : 0x2::object::new(arg5),
            round_id          : v2,
            total_sats        : v0,
            claimed_sats      : 0,
            balance           : 0x2::balance::zero<T0>(),
            status            : 1,
            created_at_ms     : v1,
            funded_at_ms      : 0x1::option::some<u64>(v1),
            claim_deadline_ms : v1 + 2592000000,
            completed_at_ms   : 0x1::option::none<u64>(),
        };
        0x2::balance::join<T0>(&mut v3.balance, 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::hashi_vault::take_exact_hbtc<T0>(arg1, v0));
        arg0.total_batches = arg0.total_batches + 1;
        let v4 = 0x2::object::uid_to_address(&v3.id);
        0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::hashi_pool::mark_funded(arg3, v4);
        let v5 = HashiBatchCreated{
            batch_id   : v4,
            round_id   : v2,
            total_sats : v0,
        };
        0x2::event::emit<HashiBatchCreated>(v5);
        let v6 = HashiBatchFunded{
            batch_id          : v4,
            round_id          : v2,
            total_sats        : v0,
            claim_deadline_ms : v3.claim_deadline_ms,
        };
        0x2::event::emit<HashiBatchFunded>(v6);
        0x2::transfer::share_object<HashiRewardBatch<T0>>(v3);
    }

    public fun recycle_expired_to_vault<T0>(arg0: &mut HashiRewardRegistry, arg1: &mut HashiRewardBatch<T0>, arg2: &mut 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::hashi_vault::HashiVault<T0>, arg3: &0x2::clock::Clock) {
        assert!(arg1.status == 1, 13906835187955924997);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg1.claim_deadline_ms, 13906835192251154441);
        let v0 = 0x2::balance::value<T0>(&arg1.balance);
        let v1 = arg1.claimed_sats;
        if (v0 > 0) {
            0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::hashi_vault::deposit_hbtc<T0>(arg2, 0x2::balance::split<T0>(&mut arg1.balance, v0));
        };
        arg1.status = 3;
        arg0.total_sats_distributed = arg0.total_sats_distributed + (v1 as u128);
        arg0.total_sats_expired = arg0.total_sats_expired + (v0 as u128);
        let v2 = HashiBatchExpired{
            batch_id       : 0x2::object::uid_to_address(&arg1.id),
            round_id       : arg1.round_id,
            reclaimed_sats : v0,
            claimed_sats   : v1,
        };
        0x2::event::emit<HashiBatchExpired>(v2);
    }

    public fun status_completed() : u8 {
        2
    }

    public fun status_expired() : u8 {
        3
    }

    public fun status_funded() : u8 {
        1
    }

    public fun status_pending() : u8 {
        0
    }

    // decompiled from Move bytecode v6
}

