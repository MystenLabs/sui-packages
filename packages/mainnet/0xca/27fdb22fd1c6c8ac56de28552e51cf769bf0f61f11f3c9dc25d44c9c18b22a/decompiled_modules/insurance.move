module 0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::insurance {
    struct InsuranceAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct InsurancePool has key {
        id: 0x2::object::UID,
        pool_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        total_policies: u64,
        total_claims_paid: u64,
    }

    struct Policy has store, key {
        id: 0x2::object::UID,
        holder: address,
        premium_paid: u64,
        coverage: u64,
        expires_at: u64,
        claimed: bool,
    }

    struct PolicyCreated has copy, drop {
        policy_id: address,
        holder: address,
        premium: u64,
        coverage: u64,
        expires_at: u64,
    }

    struct ClaimApproved has copy, drop {
        policy_id: address,
        holder: address,
        payout: u64,
    }

    entry fun approve_claim(arg0: &InsuranceAdminCap, arg1: &mut InsurancePool, arg2: &mut Policy, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg2.claimed, 1);
        assert!(0x2::clock::timestamp_ms(arg4) <= arg2.expires_at, 1);
        assert!(arg3 <= arg2.coverage, 2);
        arg2.claimed = true;
        arg1.total_claims_paid = arg1.total_claims_paid + arg3;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.pool_balance, arg3), arg5), arg2.holder);
        let v0 = ClaimApproved{
            policy_id : 0x2::object::uid_to_address(&arg2.id),
            holder    : arg2.holder,
            payout    : arg3,
        };
        0x2::event::emit<ClaimApproved>(v0);
    }

    entry fun create_policy(arg0: &mut InsurancePool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x2::clock::timestamp_ms(arg3) + 2592000000;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pool_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.total_policies = arg0.total_policies + 1;
        let v3 = Policy{
            id           : 0x2::object::new(arg4),
            holder       : v1,
            premium_paid : v0,
            coverage     : arg2,
            expires_at   : v2,
            claimed      : false,
        };
        let v4 = PolicyCreated{
            policy_id  : 0x2::object::uid_to_address(&v3.id),
            holder     : v1,
            premium    : v0,
            coverage   : arg2,
            expires_at : v2,
        };
        0x2::event::emit<PolicyCreated>(v4);
        0x2::transfer::transfer<Policy>(v3, v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = InsuranceAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<InsuranceAdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = InsurancePool{
            id                : 0x2::object::new(arg0),
            pool_balance      : 0x2::balance::zero<0x2::sui::SUI>(),
            total_policies    : 0,
            total_claims_paid : 0,
        };
        0x2::transfer::share_object<InsurancePool>(v1);
    }

    public fun policy_claimed(arg0: &Policy) : bool {
        arg0.claimed
    }

    public fun policy_coverage(arg0: &Policy) : u64 {
        arg0.coverage
    }

    public fun pool_balance(arg0: &InsurancePool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.pool_balance)
    }

    // decompiled from Move bytecode v6
}

