module 0x62d8ca51e77fccbbc8be88905760a84db752a02fb398da115294cb5aa373d23c::lock {
    struct LockedPosition<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        position: 0xf4c6b9255d67590f3c715137ea0c53ce05578c0979ea3864271f39ebc112aa68::pool::LpPosition<T0, T1>,
        unlock_at_ms: u64,
    }

    struct Locked has copy, drop {
        locker_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        owner: address,
        shares: u64,
        unlock_at_ms: u64,
        timestamp_ms: u64,
    }

    struct FeesClaimed has copy, drop {
        locker_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        fees_a: u64,
        fees_b: u64,
        timestamp_ms: u64,
    }

    struct Redeemed has copy, drop {
        locker_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    public fun borrow_position<T0, T1>(arg0: &LockedPosition<T0, T1>) : &0xf4c6b9255d67590f3c715137ea0c53ce05578c0979ea3864271f39ebc112aa68::pool::LpPosition<T0, T1> {
        &arg0.position
    }

    public fun claim_fees<T0, T1>(arg0: &mut LockedPosition<T0, T1>, arg1: &mut 0xf4c6b9255d67590f3c715137ea0c53ce05578c0979ea3864271f39ebc112aa68::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = 0xf4c6b9255d67590f3c715137ea0c53ce05578c0979ea3864271f39ebc112aa68::pool::claim_lp_fees<T0, T1>(arg1, &mut arg0.position, arg2, arg3);
        let v2 = v1;
        let v3 = v0;
        let v4 = FeesClaimed{
            locker_id    : 0x2::object::id<LockedPosition<T0, T1>>(arg0),
            position_id  : 0x2::object::id<0xf4c6b9255d67590f3c715137ea0c53ce05578c0979ea3864271f39ebc112aa68::pool::LpPosition<T0, T1>>(&arg0.position),
            pool_id      : 0x2::object::id<0xf4c6b9255d67590f3c715137ea0c53ce05578c0979ea3864271f39ebc112aa68::pool::Pool<T0, T1>>(arg1),
            fees_a       : 0x2::coin::value<T0>(&v3),
            fees_b       : 0x2::coin::value<T1>(&v2),
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<FeesClaimed>(v4);
        (v3, v2)
    }

    public fun claim_fees_entry<T0, T1>(arg0: &mut LockedPosition<T0, T1>, arg1: &mut 0xf4c6b9255d67590f3c715137ea0c53ce05578c0979ea3864271f39ebc112aa68::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = claim_fees<T0, T1>(arg0, arg1, arg2, arg3);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::tx_context::sender(arg3);
        if (0x2::coin::value<T0>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, v4);
        } else {
            0x2::coin::destroy_zero<T0>(v3);
        };
        if (0x2::coin::value<T1>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, v4);
        } else {
            0x2::coin::destroy_zero<T1>(v2);
        };
    }

    public fun is_unlocked<T0, T1>(arg0: &LockedPosition<T0, T1>, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.unlock_at_ms
    }

    public fun lock_position<T0, T1>(arg0: 0xf4c6b9255d67590f3c715137ea0c53ce05578c0979ea3864271f39ebc112aa68::pool::LpPosition<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : LockedPosition<T0, T1> {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg1 > v0, 2);
        let v1 = LockedPosition<T0, T1>{
            id           : 0x2::object::new(arg3),
            position     : arg0,
            unlock_at_ms : arg1,
        };
        let v2 = Locked{
            locker_id    : 0x2::object::id<LockedPosition<T0, T1>>(&v1),
            position_id  : 0x2::object::id<0xf4c6b9255d67590f3c715137ea0c53ce05578c0979ea3864271f39ebc112aa68::pool::LpPosition<T0, T1>>(&arg0),
            pool_id      : 0xf4c6b9255d67590f3c715137ea0c53ce05578c0979ea3864271f39ebc112aa68::pool::position_pool_id<T0, T1>(&arg0),
            owner        : 0x2::tx_context::sender(arg3),
            shares       : 0xf4c6b9255d67590f3c715137ea0c53ce05578c0979ea3864271f39ebc112aa68::pool::position_shares<T0, T1>(&arg0),
            unlock_at_ms : arg1,
            timestamp_ms : v0,
        };
        0x2::event::emit<Locked>(v2);
        v1
    }

    public fun lock_position_entry<T0, T1>(arg0: 0xf4c6b9255d67590f3c715137ea0c53ce05578c0979ea3864271f39ebc112aa68::pool::LpPosition<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = lock_position<T0, T1>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<LockedPosition<T0, T1>>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun pool_id<T0, T1>(arg0: &LockedPosition<T0, T1>) : 0x2::object::ID {
        0xf4c6b9255d67590f3c715137ea0c53ce05578c0979ea3864271f39ebc112aa68::pool::position_pool_id<T0, T1>(&arg0.position)
    }

    public fun position_shares<T0, T1>(arg0: &LockedPosition<T0, T1>) : u64 {
        0xf4c6b9255d67590f3c715137ea0c53ce05578c0979ea3864271f39ebc112aa68::pool::position_shares<T0, T1>(&arg0.position)
    }

    public fun read_warning() : vector<u8> {
        b"DARBITEX LP LOCKER is an immutable time-lock satellite for darbitex::pool::LpPosition on Sui. After make_immutable is called the package is permanently immutable - no admin authority, no pause, no upgrade, no early-unlock path. Bugs are unrecoverable. Audit this code yourself before interacting. KNOWN LIMITATIONS: (1) ONE-WAY TIME GATE - unlock_at_ms is set once at lock_position and cannot be extended, shortened, or cancelled by anyone for any reason. There is no admin path to unlock early. The only routes to the underlying LpPosition are redeem after unlock_at_ms or never. (2) CLOCK SOURCE - unlock_at_ms is compared against Sui's shared Clock object timestamp_ms. Lock duration is sensitive to validator clock progression. Standard Sui assumption. (3) WRAPPER TRANSFERABILITY - LockedPosition has key plus store. The wrapper itself is freely transferable via transfer::public_transfer. Transferring the wrapper carries the lock state and the unlock_at deadline; the new owner inherits both the right to claim fees and the right to redeem at unlock_at_ms. Only the inner LpPosition is time-gated, not the wrapper. (4) FEE PROXY - claim_fees calls darbitex::pool::claim_lp_fees and returns Coin<A>, Coin<B> to the caller. Frontends and downstream wrappers are responsible for forwarding fees to the rightful end user. The locker performs no internal fee accounting. (5) POOL DEPENDENCY - claim_fees requires &mut Pool<A,B> matching the wrapped position's pool_id. If the underlying pool is degraded for unrelated reasons, fee claims may fail. redeem does NOT touch the pool and works regardless of pool state once unlock_at_ms is reached - principal recovery is independent of pool liveness. (6) NO RESCUE - lost ownership of the LockedPosition wrapper has no recourse. No admin, no recovery, no pause. The wrapper itself is the only authentication. (7) NO COMPOSITION GUARANTEES - third-party modules that wrap LockedPosition (staking, lending, escrow, marketplace, vesting) provide their own invariants. This module guarantees only that LpPosition cannot exit a LockedPosition before unlock_at_ms. Wrapping a LockedPosition inside an external wrapper is the user's voluntary act and combines the trust assumptions of all layers. (8) SEAL-AT-DEPLOY - the deploy keypair holds UpgradeCap for seconds between Tx 1 (publish) and Tx 2 (make_immutable). After Tx 2 the cap is destroyed and the deploy keypair has zero further authority over the package. (9) AUTHORSHIP AND AUDIT DISCLOSURE - Darbitex LP Locker was built by a solo developer working with Claude (Anthropic AI). All audits performed are AI-based: multi-round Claude self-audit plus external LLM review. NO professional human security audit firm has reviewed this code. Once make_immutable is called the protocol is ownerless and permissionless - no team, no foundation, no legal entity, no responsible party, no support channel. All losses from bugs, exploits, user error, malicious counterparties, or any other cause whatsoever are borne entirely by users. (10) UNKNOWN FUTURE LIMITATIONS - This list reflects only the limitations identified at the time of audit. Future analysis, novel attack vectors, unforeseen interactions with other Sui protocols, framework changes, market dynamics, or regulatory developments may reveal additional weaknesses, risks, or limitations not enumerated here. Because the locker is permanently immutable, newly discovered limitations CANNOT be patched - they become additional risks users continue to bear. Treat the preceding 9 items as a non-exhaustive lower bound on known risks, not a complete enumeration. By interacting with the locker (locking a position, claiming fees, redeeming, transferring the wrapper, or composing with downstream protocols) you confirm that you have read and understood all 10 numbered limitations and accept full responsibility for any and all losses."
    }

    public fun redeem<T0, T1>(arg0: LockedPosition<T0, T1>, arg1: &0x2::clock::Clock) : 0xf4c6b9255d67590f3c715137ea0c53ce05578c0979ea3864271f39ebc112aa68::pool::LpPosition<T0, T1> {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.unlock_at_ms, 1);
        let LockedPosition {
            id           : v1,
            position     : v2,
            unlock_at_ms : _,
        } = arg0;
        let v4 = v2;
        let v5 = v1;
        0x2::object::delete(v5);
        let v6 = Redeemed{
            locker_id    : 0x2::object::uid_to_inner(&v5),
            position_id  : 0x2::object::id<0xf4c6b9255d67590f3c715137ea0c53ce05578c0979ea3864271f39ebc112aa68::pool::LpPosition<T0, T1>>(&v4),
            pool_id      : 0xf4c6b9255d67590f3c715137ea0c53ce05578c0979ea3864271f39ebc112aa68::pool::position_pool_id<T0, T1>(&v4),
            timestamp_ms : v0,
        };
        0x2::event::emit<Redeemed>(v6);
        v4
    }

    public fun redeem_entry<T0, T1>(arg0: LockedPosition<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xf4c6b9255d67590f3c715137ea0c53ce05578c0979ea3864271f39ebc112aa68::pool::LpPosition<T0, T1>>(redeem<T0, T1>(arg0, arg1), 0x2::tx_context::sender(arg2));
    }

    public fun unlock_at_ms<T0, T1>(arg0: &LockedPosition<T0, T1>) : u64 {
        arg0.unlock_at_ms
    }

    // decompiled from Move bytecode v7
}

