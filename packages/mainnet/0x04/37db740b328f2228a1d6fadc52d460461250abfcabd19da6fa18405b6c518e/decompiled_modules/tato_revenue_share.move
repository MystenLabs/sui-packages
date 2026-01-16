module 0x92ad7e9eb483ba31772e76baf02e8634b5ebffbf58a93367ebf838d8c51fe780::tato_revenue_share {
    struct WeekDistribution has copy, drop, store {
        merkle_root: vector<u8>,
        total_amount: u64,
        claimed_amount: u64,
        claim_start_ts: u64,
        claim_deadline_ts: u64,
        total_eligible_users: u64,
        claimed_users_count: u64,
        swept: bool,
    }

    struct ClaimKey has copy, drop, store {
        week_id: u64,
        user: address,
    }

    struct WeekWithClaimStatus has copy, drop {
        week_id: u64,
        week_distribution: WeekDistribution,
        has_claimed: bool,
    }

    struct RevenueDistributor has key {
        id: 0x2::object::UID,
        tato_balance: 0x2::balance::Balance<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>,
        treasury_address: address,
        weeks: 0x2::table::Table<u64, WeekDistribution>,
        claims: 0x2::table::Table<ClaimKey, bool>,
        version: u64,
        paused: bool,
    }

    struct WeekPublished has copy, drop {
        week_id: u64,
        merkle_root: vector<u8>,
        total_amount: u64,
        total_eligible_users: u64,
        claim_start_ts: u64,
        claim_deadline_ts: u64,
    }

    struct RewardsClaimed has copy, drop {
        week_id: u64,
        user: address,
        amount: u64,
        timestamp: u64,
    }

    struct ExpiredSwept has copy, drop {
        week_id: u64,
        swept_amount: u64,
        timestamp: u64,
    }

    struct TatoDeposited has copy, drop {
        depositor: address,
        amount: u64,
    }

    fun append_u64(arg0: &mut vector<u8>, arg1: u64) {
        0x1::vector::push_back<u8>(arg0, ((arg1 >> 56 & 255) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 >> 48 & 255) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 >> 40 & 255) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 >> 32 & 255) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 >> 24 & 255) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 >> 16 & 255) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 >> 8 & 255) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 & 255) as u8));
    }

    fun check_not_paused(arg0: &RevenueDistributor) {
        assert!(!arg0.paused, 2);
    }

    fun check_version(arg0: &RevenueDistributor) {
        assert!(arg0.version == 1, 1);
    }

    public entry fun claim_rewards(arg0: &mut RevenueDistributor, arg1: u64, arg2: u64, arg3: vector<vector<u8>>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::table::contains<u64, WeekDistribution>(&arg0.weeks, arg1), 11);
        let v1 = 0x2::table::borrow_mut<u64, WeekDistribution>(&mut arg0.weeks, arg1);
        let v2 = 0x2::clock::timestamp_ms(arg4);
        assert!(v2 >= v1.claim_start_ts, 23);
        assert!(v2 <= v1.claim_deadline_ts, 12);
        let v3 = ClaimKey{
            week_id : arg1,
            user    : v0,
        };
        assert!(!0x2::table::contains<ClaimKey, bool>(&arg0.claims, v3), 13);
        assert!(verify_merkle_proof(v1.merkle_root, arg1, v0, arg2, arg3), 14);
        let v4 = v1.claimed_amount + arg2;
        assert!(v4 <= v1.total_amount, 15);
        assert!(0x2::balance::value<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>(&arg0.tato_balance) >= arg2, 15);
        v1.claimed_amount = v4;
        v1.claimed_users_count = v1.claimed_users_count + 1;
        0x2::table::add<ClaimKey, bool>(&mut arg0.claims, v3, true);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>>(0x2::coin::from_balance<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>(0x2::balance::split<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>(&mut arg0.tato_balance, arg2), arg5), v0);
        let v5 = RewardsClaimed{
            week_id   : arg1,
            user      : v0,
            amount    : arg2,
            timestamp : v2,
        };
        0x2::event::emit<RewardsClaimed>(v5);
    }

    fun compare_bytes(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = 0x1::vector::length<u8>(arg1);
        let v2 = if (v0 < v1) {
            v0
        } else {
            v1
        };
        let v3 = 0;
        while (v3 < v2) {
            let v4 = *0x1::vector::borrow<u8>(arg0, v3);
            let v5 = *0x1::vector::borrow<u8>(arg1, v3);
            if (v4 < v5) {
                return true
            };
            if (v4 > v5) {
                return false
            };
            v3 = v3 + 1;
        };
        v0 < v1
    }

    fun construct_leaf(arg0: u64, arg1: address, arg2: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        append_u64(v1, arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg1));
        let v2 = &mut v0;
        append_u64(v2, arg2);
        0x2::hash::blake2b256(&v0)
    }

    public entry fun deposit_tato(arg0: &mut RevenueDistributor, arg1: 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>, arg2: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        0x2::balance::join<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>(&mut arg0.tato_balance, 0x2::coin::into_balance<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>(arg1));
        let v0 = TatoDeposited{
            depositor : 0x2::tx_context::sender(arg2),
            amount    : 0x2::coin::value<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>(&arg1),
        };
        0x2::event::emit<TatoDeposited>(v0);
    }

    public fun get_claim_progress(arg0: &RevenueDistributor, arg1: u64) : (u64, u64) {
        assert!(0x2::table::contains<u64, WeekDistribution>(&arg0.weeks, arg1), 11);
        let v0 = 0x2::table::borrow<u64, WeekDistribution>(&arg0.weeks, arg1);
        (v0.claimed_users_count, v0.total_eligible_users)
    }

    public fun get_week_details(arg0: &RevenueDistributor, arg1: u64) : WeekDistribution {
        assert!(0x2::table::contains<u64, WeekDistribution>(&arg0.weeks, arg1), 11);
        *0x2::table::borrow<u64, WeekDistribution>(&arg0.weeks, arg1)
    }

    public fun get_weeks_range(arg0: &RevenueDistributor, arg1: address, arg2: u64, arg3: u64) : vector<WeekWithClaimStatus> {
        let v0 = 0x1::vector::empty<WeekWithClaimStatus>();
        while (arg2 <= arg3) {
            if (0x2::table::contains<u64, WeekDistribution>(&arg0.weeks, arg2)) {
                let v1 = ClaimKey{
                    week_id : arg2,
                    user    : arg1,
                };
                let v2 = WeekWithClaimStatus{
                    week_id           : arg2,
                    week_distribution : *0x2::table::borrow<u64, WeekDistribution>(&arg0.weeks, arg2),
                    has_claimed       : 0x2::table::contains<ClaimKey, bool>(&arg0.claims, v1),
                };
                0x1::vector::push_back<WeekWithClaimStatus>(&mut v0, v2);
            };
            arg2 = arg2 + 1;
        };
        v0
    }

    public fun has_claimed(arg0: &RevenueDistributor, arg1: u64, arg2: address) : bool {
        let v0 = ClaimKey{
            week_id : arg1,
            user    : arg2,
        };
        0x2::table::contains<ClaimKey, bool>(&arg0.claims, v0)
    }

    fun hash_pair(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        if (compare_bytes(&arg0, &arg1)) {
            0x1::vector::append<u8>(&mut v0, arg0);
            0x1::vector::append<u8>(&mut v0, arg1);
        } else {
            0x1::vector::append<u8>(&mut v0, arg1);
            0x1::vector::append<u8>(&mut v0, arg0);
        };
        0x2::hash::blake2b256(&v0)
    }

    public entry fun initialize_revenue_share(arg0: &0x92ad7e9eb483ba31772e76baf02e8634b5ebffbf58a93367ebf838d8c51fe780::tato_staking::TatoStakingAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = RevenueDistributor{
            id               : 0x2::object::new(arg1),
            tato_balance     : 0x2::balance::zero<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>(),
            treasury_address : @0xc32dc61769d71f05b336961158d0de74ffc2cc56043ff54b415ac8f08d883460,
            weeks            : 0x2::table::new<u64, WeekDistribution>(arg1),
            claims           : 0x2::table::new<ClaimKey, bool>(arg1),
            version          : 1,
            paused           : false,
        };
        0x2::transfer::share_object<RevenueDistributor>(v0);
    }

    public entry fun publish_week(arg0: &0x92ad7e9eb483ba31772e76baf02e8634b5ebffbf58a93367ebf838d8c51fe780::tato_staking::TatoStakingAdminCap, arg1: &mut RevenueDistributor, arg2: u64, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) {
        check_version(arg1);
        assert!(!0x2::table::contains<u64, WeekDistribution>(&arg1.weeks, arg2), 10);
        assert!(arg6 >= 0x2::clock::timestamp_ms(arg8), 22);
        assert!(arg7 > arg6, 18);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 20);
        assert!(arg4 > 0, 21);
        assert!(0x2::balance::value<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>(&arg1.tato_balance) >= arg4, 15);
        let v0 = WeekDistribution{
            merkle_root          : arg3,
            total_amount         : arg4,
            claimed_amount       : 0,
            claim_start_ts       : arg6,
            claim_deadline_ts    : arg7,
            total_eligible_users : arg5,
            claimed_users_count  : 0,
            swept                : false,
        };
        0x2::table::add<u64, WeekDistribution>(&mut arg1.weeks, arg2, v0);
        let v1 = WeekPublished{
            week_id              : arg2,
            merkle_root          : arg3,
            total_amount         : arg4,
            total_eligible_users : arg5,
            claim_start_ts       : arg6,
            claim_deadline_ts    : arg7,
        };
        0x2::event::emit<WeekPublished>(v1);
    }

    public entry fun set_paused(arg0: &0x92ad7e9eb483ba31772e76baf02e8634b5ebffbf58a93367ebf838d8c51fe780::tato_staking::TatoStakingAdminCap, arg1: &mut RevenueDistributor, arg2: bool) {
        arg1.paused = arg2;
    }

    public entry fun sweep_expired(arg0: &0x92ad7e9eb483ba31772e76baf02e8634b5ebffbf58a93367ebf838d8c51fe780::tato_staking::TatoStakingAdminCap, arg1: &mut RevenueDistributor, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        check_version(arg1);
        assert!(0x2::table::contains<u64, WeekDistribution>(&arg1.weeks, arg2), 11);
        let v0 = 0x2::table::borrow_mut<u64, WeekDistribution>(&mut arg1.weeks, arg2);
        assert!(!v0.swept, 19);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v1 > v0.claim_deadline_ts, 16);
        let v2 = v0.total_amount - v0.claimed_amount;
        assert!(v2 > 0, 17);
        assert!(0x2::balance::value<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>(&arg1.tato_balance) >= v2, 15);
        v0.swept = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>>(0x2::coin::from_balance<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>(0x2::balance::split<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>(&mut arg1.tato_balance, v2), arg4), @0x0);
        let v3 = ExpiredSwept{
            week_id      : arg2,
            swept_amount : v2,
            timestamp    : v1,
        };
        0x2::event::emit<ExpiredSwept>(v3);
    }

    public fun test_compute_leaf_hash(arg0: u64, arg1: address, arg2: u64) : vector<u8> {
        construct_leaf(arg0, arg1, arg2)
    }

    public entry fun upgrade_version(arg0: &0x92ad7e9eb483ba31772e76baf02e8634b5ebffbf58a93367ebf838d8c51fe780::tato_staking::TatoStakingAdminCap, arg1: &mut RevenueDistributor) {
        assert!(arg1.version < 1, 1);
        arg1.version = 1;
    }

    fun verify_merkle_proof(arg0: vector<u8>, arg1: u64, arg2: address, arg3: u64, arg4: vector<vector<u8>>) : bool {
        let v0 = construct_leaf(arg1, arg2, arg3);
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg4)) {
            v0 = hash_pair(v0, *0x1::vector::borrow<vector<u8>>(&arg4, v1));
            v1 = v1 + 1;
        };
        v0 == arg0
    }

    // decompiled from Move bytecode v6
}

