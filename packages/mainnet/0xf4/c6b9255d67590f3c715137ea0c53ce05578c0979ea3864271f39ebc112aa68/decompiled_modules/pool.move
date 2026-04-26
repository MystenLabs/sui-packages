module 0xf4c6b9255d67590f3c715137ea0c53ce05578c0979ea3864271f39ebc112aa68::pool {
    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        balance_a: 0x2::balance::Balance<T0>,
        balance_b: 0x2::balance::Balance<T1>,
        reserve_a: u64,
        reserve_b: u64,
        lp_supply: u64,
        lp_fee_per_share_a: u128,
        lp_fee_per_share_b: u128,
    }

    struct LpPosition<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        shares: u64,
        fee_debt_a: u128,
        fee_debt_b: u128,
    }

    struct FlashReceiptA<phantom T0, phantom T1> {
        pool_id: 0x2::object::ID,
        amount: u64,
        fee: u64,
        k_before: u256,
    }

    struct FlashReceiptB<phantom T0, phantom T1> {
        pool_id: 0x2::object::ID,
        amount: u64,
        fee: u64,
        k_before: u256,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        type_a: 0x1::ascii::String,
        type_b: 0x1::ascii::String,
        creator: address,
        amount_a: u64,
        amount_b: u64,
        initial_lp: u64,
        timestamp_ms: u64,
    }

    struct Swapped has copy, drop {
        pool_id: 0x2::object::ID,
        swapper: address,
        amount_in: u64,
        amount_out: u64,
        a_to_b: bool,
        lp_fee: u64,
        timestamp_ms: u64,
    }

    struct LiquidityAdded has copy, drop {
        pool_id: 0x2::object::ID,
        provider: address,
        position_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
        shares_minted: u64,
        timestamp_ms: u64,
    }

    struct LiquidityRemoved has copy, drop {
        pool_id: 0x2::object::ID,
        provider: address,
        position_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
        fees_a: u64,
        fees_b: u64,
        shares_burned: u64,
        timestamp_ms: u64,
    }

    struct LpFeesClaimed has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        claimer: address,
        fees_a: u64,
        fees_b: u64,
        timestamp_ms: u64,
    }

    struct FlashBorrowed has copy, drop {
        pool_id: 0x2::object::ID,
        borrowed_is_a: bool,
        amount: u64,
        fee: u64,
        timestamp_ms: u64,
    }

    struct FlashRepaid has copy, drop {
        pool_id: 0x2::object::ID,
        borrowed_is_a: bool,
        amount: u64,
        fee: u64,
        timestamp_ms: u64,
    }

    fun accrue_fee<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: bool) : u64 {
        if (arg1 > 0 && arg0.lp_supply > 0) {
            if (arg2) {
                arg0.lp_fee_per_share_a = arg0.lp_fee_per_share_a + (arg1 as u128) * 1000000000000 / (arg0.lp_supply as u128);
            } else {
                arg0.lp_fee_per_share_b = arg0.lp_fee_per_share_b + (arg1 as u128) * 1000000000000 / (arg0.lp_supply as u128);
            };
        };
        arg1
    }

    public fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (LpPosition<T0, T1>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 > 0 && v1 > 0, 1);
        let v2 = (v0 as u256) * (arg0.reserve_b as u256) / (arg0.reserve_a as u256);
        assert!(v2 <= (18446744073709551615 as u256), 2);
        let v3 = (v2 as u64);
        let (v4, v5) = if (v3 <= v1) {
            (v0, v3)
        } else {
            let v6 = (v1 as u256) * (arg0.reserve_a as u256) / (arg0.reserve_b as u256);
            assert!(v6 <= (18446744073709551615 as u256), 2);
            let v7 = (v6 as u64);
            assert!(v7 <= v0, 5);
            (v7, v1)
        };
        assert!(v4 > 0 && v5 > 0, 1);
        let v8 = (((v4 as u256) * (arg0.lp_supply as u256) / (arg0.reserve_a as u256)) as u64);
        let v9 = (((v5 as u256) * (arg0.lp_supply as u256) / (arg0.reserve_b as u256)) as u64);
        let v10 = if (v8 < v9) {
            v8
        } else {
            v9
        };
        assert!(v10 > 0, 1);
        assert!(v10 >= arg3, 3);
        0x2::balance::join<T0>(&mut arg0.balance_a, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, v4, arg5)));
        0x2::balance::join<T1>(&mut arg0.balance_b, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, v5, arg5)));
        arg0.reserve_a = arg0.reserve_a + v4;
        arg0.reserve_b = arg0.reserve_b + v5;
        arg0.lp_supply = arg0.lp_supply + v10;
        let v11 = 0x2::object::id<Pool<T0, T1>>(arg0);
        let v12 = LpPosition<T0, T1>{
            id         : 0x2::object::new(arg5),
            pool_id    : v11,
            shares     : v10,
            fee_debt_a : arg0.lp_fee_per_share_a,
            fee_debt_b : arg0.lp_fee_per_share_b,
        };
        let v13 = LiquidityAdded{
            pool_id       : v11,
            provider      : 0x2::tx_context::sender(arg5),
            position_id   : 0x2::object::id<LpPosition<T0, T1>>(&v12),
            amount_a      : v4,
            amount_b      : v5,
            shares_minted : v10,
            timestamp_ms  : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<LiquidityAdded>(v13);
        (v12, arg1, arg2)
    }

    public fun add_liquidity_entry<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg4) < arg5, 14);
        let (v0, v1, v2) = add_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6);
        let v3 = 0x2::tx_context::sender(arg6);
        0x2::transfer::public_transfer<LpPosition<T0, T1>>(v0, v3);
        maybe_transfer<T0>(v1, v3);
        maybe_transfer<T1>(v2, v3);
    }

    public fun claim_lp_fees<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut LpPosition<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == arg1.pool_id, 6);
        let v0 = pending_from_accumulator(arg0.lp_fee_per_share_a, arg1.fee_debt_a, arg1.shares);
        let v1 = pending_from_accumulator(arg0.lp_fee_per_share_b, arg1.fee_debt_b, arg1.shares);
        arg1.fee_debt_a = arg0.lp_fee_per_share_a;
        arg1.fee_debt_b = arg0.lp_fee_per_share_b;
        let v2 = if (v0 > 0) {
            0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance_a, v0), arg3)
        } else {
            0x2::coin::zero<T0>(arg3)
        };
        let v3 = if (v1 > 0) {
            0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.balance_b, v1), arg3)
        } else {
            0x2::coin::zero<T1>(arg3)
        };
        let v4 = LpFeesClaimed{
            pool_id      : arg1.pool_id,
            position_id  : 0x2::object::id<LpPosition<T0, T1>>(arg1),
            claimer      : 0x2::tx_context::sender(arg3),
            fees_a       : v0,
            fees_b       : v1,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<LpFeesClaimed>(v4);
        (v2, v3)
    }

    public fun claim_lp_fees_entry<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut LpPosition<T0, T1>, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) < arg3, 14);
        let (v0, v1) = claim_lp_fees<T0, T1>(arg0, arg1, arg2, arg4);
        let v2 = 0x2::tx_context::sender(arg4);
        maybe_transfer<T0>(v0, v2);
        maybe_transfer<T1>(v1, v2);
    }

    public fun compute_amount_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg2 as u256) * ((10000 - 5) as u256);
        ((v0 * (arg1 as u256) / ((arg0 as u256) * (10000 as u256) + v0)) as u64)
    }

    public fun compute_flash_fee(arg0: u64) : u64 {
        let v0 = (((arg0 as u256) * (5 as u256) / (10000 as u256)) as u64);
        if (v0 == 0) {
            1
        } else {
            v0
        }
    }

    public(friend) fun create_pool<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, LpPosition<T0, T1>) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0 && v1 > 0, 1);
        let v2 = sqrt((v0 as u128) * (v1 as u128));
        assert!(v2 > (1000 as u128), 2);
        let v3 = (v2 as u64);
        let v4 = v3 - 1000;
        let v5 = Pool<T0, T1>{
            id                 : 0x2::object::new(arg3),
            balance_a          : 0x2::coin::into_balance<T0>(arg0),
            balance_b          : 0x2::coin::into_balance<T1>(arg1),
            reserve_a          : v0,
            reserve_b          : v1,
            lp_supply          : v3,
            lp_fee_per_share_a : 0,
            lp_fee_per_share_b : 0,
        };
        let v6 = 0x2::object::id<Pool<T0, T1>>(&v5);
        let v7 = 0x2::tx_context::sender(arg3);
        let v8 = LpPosition<T0, T1>{
            id         : 0x2::object::new(arg3),
            pool_id    : v6,
            shares     : v4,
            fee_debt_a : 0,
            fee_debt_b : 0,
        };
        let v9 = 0x2::clock::timestamp_ms(arg2);
        let v10 = PoolCreated{
            pool_id      : v6,
            type_a       : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            type_b       : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
            creator      : v7,
            amount_a     : v0,
            amount_b     : v1,
            initial_lp   : v3,
            timestamp_ms : v9,
        };
        0x2::event::emit<PoolCreated>(v10);
        let v11 = LiquidityAdded{
            pool_id       : v6,
            provider      : v7,
            position_id   : 0x2::object::id<LpPosition<T0, T1>>(&v8),
            amount_a      : v0,
            amount_b      : v1,
            shares_minted : v4,
            timestamp_ms  : v9,
        };
        0x2::event::emit<LiquidityAdded>(v11);
        0x2::transfer::share_object<Pool<T0, T1>>(v5);
        (v6, v8)
    }

    public fun fee_per_share<T0, T1>(arg0: &Pool<T0, T1>) : (u128, u128) {
        (arg0.lp_fee_per_share_a, arg0.lp_fee_per_share_b)
    }

    public fun flash_borrow_a<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FlashReceiptA<T0, T1>) {
        assert!(arg1 > 0, 1);
        assert!(arg1 < arg0.reserve_a, 2);
        let v0 = compute_flash_fee(arg1);
        let v1 = 0x2::object::id<Pool<T0, T1>>(arg0);
        let v2 = FlashBorrowed{
            pool_id       : v1,
            borrowed_is_a : true,
            amount        : arg1,
            fee           : v0,
            timestamp_ms  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<FlashBorrowed>(v2);
        let v3 = FlashReceiptA<T0, T1>{
            pool_id  : v1,
            amount   : arg1,
            fee      : v0,
            k_before : (arg0.reserve_a as u256) * (arg0.reserve_b as u256),
        };
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance_a, arg1), arg3), v3)
    }

    public fun flash_borrow_b<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, FlashReceiptB<T0, T1>) {
        assert!(arg1 > 0, 1);
        assert!(arg1 < arg0.reserve_b, 2);
        let v0 = compute_flash_fee(arg1);
        let v1 = 0x2::object::id<Pool<T0, T1>>(arg0);
        let v2 = FlashBorrowed{
            pool_id       : v1,
            borrowed_is_a : false,
            amount        : arg1,
            fee           : v0,
            timestamp_ms  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<FlashBorrowed>(v2);
        let v3 = FlashReceiptB<T0, T1>{
            pool_id  : v1,
            amount   : arg1,
            fee      : v0,
            k_before : (arg0.reserve_a as u256) * (arg0.reserve_b as u256),
        };
        (0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.balance_b, arg1), arg3), v3)
    }

    public fun flash_repay_a<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: FlashReceiptA<T0, T1>, arg3: &0x2::clock::Clock) {
        let FlashReceiptA {
            pool_id  : v0,
            amount   : v1,
            fee      : v2,
            k_before : v3,
        } = arg2;
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == v0, 6);
        assert!(0x2::coin::value<T0>(&arg1) == v1 + v2, 15);
        0x2::balance::join<T0>(&mut arg0.balance_a, 0x2::coin::into_balance<T0>(arg1));
        accrue_fee<T0, T1>(arg0, v2, true);
        assert!((arg0.reserve_a as u256) * (arg0.reserve_b as u256) >= v3, 9);
        let v4 = FlashRepaid{
            pool_id       : v0,
            borrowed_is_a : true,
            amount        : v1,
            fee           : v2,
            timestamp_ms  : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<FlashRepaid>(v4);
    }

    public fun flash_repay_b<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: FlashReceiptB<T0, T1>, arg3: &0x2::clock::Clock) {
        let FlashReceiptB {
            pool_id  : v0,
            amount   : v1,
            fee      : v2,
            k_before : v3,
        } = arg2;
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == v0, 6);
        assert!(0x2::coin::value<T1>(&arg1) == v1 + v2, 15);
        0x2::balance::join<T1>(&mut arg0.balance_b, 0x2::coin::into_balance<T1>(arg1));
        accrue_fee<T0, T1>(arg0, v2, false);
        assert!((arg0.reserve_a as u256) * (arg0.reserve_b as u256) >= v3, 9);
        let v4 = FlashRepaid{
            pool_id       : v0,
            borrowed_is_a : false,
            amount        : v1,
            fee           : v2,
            timestamp_ms  : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<FlashRepaid>(v4);
    }

    public fun lp_supply<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.lp_supply
    }

    fun maybe_transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public fun pending_fees<T0, T1>(arg0: &Pool<T0, T1>, arg1: &LpPosition<T0, T1>) : (u64, u64) {
        (pending_from_accumulator(arg0.lp_fee_per_share_a, arg1.fee_debt_a, arg1.shares), pending_from_accumulator(arg0.lp_fee_per_share_b, arg1.fee_debt_b, arg1.shares))
    }

    fun pending_from_accumulator(arg0: u128, arg1: u128, arg2: u64) : u64 {
        if (arg0 <= arg1) {
            return 0
        };
        ((((arg0 - arg1) as u256) * (arg2 as u256) / (1000000000000 as u256)) as u64)
    }

    public fun position_fee_debt<T0, T1>(arg0: &LpPosition<T0, T1>) : (u128, u128) {
        (arg0.fee_debt_a, arg0.fee_debt_b)
    }

    public fun position_pool_id<T0, T1>(arg0: &LpPosition<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun position_shares<T0, T1>(arg0: &LpPosition<T0, T1>) : u64 {
        arg0.shares
    }

    public fun read_warning() : vector<u8> {
        b"DARBITEX is an immutable xyk AMM on Sui. After destroy_cap is called the package is permanently immutable - no admin authority, no pause, no upgrade, no fee adjustment. Bugs are unrecoverable. Audit this code yourself before interacting. KNOWN LIMITATIONS: (1) PRICE SOURCE - Pool reserves are the only price input. There is no oracle. Spot price is manipulable by sufficiently large swaps relative to depth. Standard xyk AMM property. (2) CAPITAL INEFFICIENCY - V2 full-range liquidity. Lower capital efficiency than V3 CLMM by design. The trade-off is V2 mathematical security plus always-in-range LP (positions never go out of range and never stop earning). (3) LP-AS-NFT - LP positions are Sui objects (LpPosition<A,B>) not Coin<T>. Cannot be used as collateral on Scallop or Suilend. Cannot be routed by Cetus or Aftermath aggregators. Trade-off accepted for per-position fee accounting and claim-without-burn capability. Wallet support varies. (4) FLASH LOAN SAFETY - flash_borrow_a/b returns Coin plus hot-potato receipt that MUST be consumed by flash_repay_a/b in the same TX. Strict repay equality (amount + fee) prevents under or overpay. The k_after >= k_before invariant verified at repay catches any pool manipulation in the borrow window. Reentrancy via Coin<T> is impossible in Sui by framework design. (5) MINIMUM LIQUIDITY - first 1000 LP shares locked at pool creation as anti-cornering protection on the first depositor. Permanently inaccessible. (6) NO TREASURY - 100 percent of swap fee plus flash fee accrue to LP via per-share accumulator. There is no protocol cut, no treasury recipient, no admin fee. (7) CANONICAL PAIR - one pool per (TypeA, TypeB) pair via the factory. The first creator picks the initial reserve ratio. Subsequent depositors take that ratio as truth. Initial creator has price discovery asymmetry until liquidity grows. (8) NO RESCUE - no admin emergency, no pause, no fund recovery. Loss of access to an LpPosition NFT or transfer to a wrong address has no recourse. (9) SEAL-AT-DEPLOY - the deploy keypair holds OriginCap plus UpgradeCap for seconds between Tx 1 (publish) and Tx 2 (destroy_cap). After Tx 2 these are destroyed and the deploy keypair has zero further authority over the package or any pool. (10) AUTHORSHIP AND AUDIT DISCLOSURE - Darbitex was built by a solo developer working with Claude (Anthropic AI). All audits performed are AI-based: multi-round Claude self-audit (R1 and R2) plus external AI review by Gemini, Claude, Grok, and other LLM auditors. NO professional human security audit firm has reviewed this code. Once destroy_cap is called the protocol is ownerless and permissionless - no team, no foundation, no legal entity, no responsible party, no support channel. All losses from bugs, exploits, oracle issues, market manipulation, user error, malicious counterparties, or any other cause whatsoever are borne entirely by users. By interacting with Darbitex (depositing liquidity, swapping, taking flash loans, transferring positions, or any other operation) you confirm that you have read and understood all 11 numbered limitations in this disclosure and accept full responsibility for any and all losses. (11) UNKNOWN FUTURE LIMITATIONS - This list reflects only the limitations identified at the time of audit. Future analysis, novel attack vectors, unforeseen interactions with other Sui protocols, framework changes, market dynamics, or regulatory developments may reveal additional weaknesses, risks, or limitations not enumerated here. Because Darbitex is permanently immutable, newly discovered limitations CANNOT be patched - they become additional risks users continue to bear. Treat the preceding 10 items as a non-exhaustive lower bound on known risks, not a complete enumeration. Users accept all unknown future limitations as a precondition of any interaction with the protocol."
    }

    public fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: LpPosition<T0, T1>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let LpPosition {
            id         : v0,
            pool_id    : v1,
            shares     : v2,
            fee_debt_a : v3,
            fee_debt_b : v4,
        } = arg1;
        let v5 = v0;
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == v1, 6);
        assert!(v2 > 0, 1);
        assert!(arg0.lp_supply >= v2, 7);
        let v6 = pending_from_accumulator(arg0.lp_fee_per_share_a, v3, v2);
        let v7 = pending_from_accumulator(arg0.lp_fee_per_share_b, v4, v2);
        let v8 = (((v2 as u256) * (arg0.reserve_a as u256) / (arg0.lp_supply as u256)) as u64);
        let v9 = (((v2 as u256) * (arg0.reserve_b as u256) / (arg0.lp_supply as u256)) as u64);
        assert!(v8 >= arg2, 3);
        assert!(v9 >= arg3, 3);
        arg0.lp_supply = arg0.lp_supply - v2;
        assert!(arg0.lp_supply >= 1000, 2);
        arg0.reserve_a = arg0.reserve_a - v8;
        arg0.reserve_b = arg0.reserve_b - v9;
        let v10 = LiquidityRemoved{
            pool_id       : v1,
            provider      : 0x2::tx_context::sender(arg5),
            position_id   : 0x2::object::uid_to_inner(&v5),
            amount_a      : v8,
            amount_b      : v9,
            fees_a        : v6,
            fees_b        : v7,
            shares_burned : v2,
            timestamp_ms  : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<LiquidityRemoved>(v10);
        0x2::object::delete(v5);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance_a, v8 + v6), arg5), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.balance_b, v9 + v7), arg5))
    }

    public fun remove_liquidity_entry<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: LpPosition<T0, T1>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg4) < arg5, 14);
        let (v0, v1) = remove_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6);
        let v2 = 0x2::tx_context::sender(arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, v2);
    }

    public fun reserves<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (arg0.reserve_a, arg0.reserve_b)
    }

    public fun sqrt(arg0: u128) : u128 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = (arg0 + 1) / 2;
        while (v0 < arg0) {
            let v1 = arg0 / v0 + v0;
            v0 = v1 / 2;
        };
        arg0
    }

    public fun swap_a_to_b<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = compute_amount_out(arg0.reserve_a, arg0.reserve_b, v0);
        assert!(v1 >= arg2, 3);
        assert!(v1 < arg0.reserve_b, 2);
        let v2 = accrue_fee<T0, T1>(arg0, (((v0 as u256) * (5 as u256) / (10000 as u256)) as u64), true);
        arg0.reserve_a = arg0.reserve_a + v0 - v2;
        arg0.reserve_b = arg0.reserve_b - v1;
        0x2::balance::join<T0>(&mut arg0.balance_a, 0x2::coin::into_balance<T0>(arg1));
        let v3 = Swapped{
            pool_id      : 0x2::object::id<Pool<T0, T1>>(arg0),
            swapper      : 0x2::tx_context::sender(arg4),
            amount_in    : v0,
            amount_out   : v1,
            a_to_b       : true,
            lp_fee       : v2,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<Swapped>(v3);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.balance_b, v1), arg4)
    }

    public fun swap_b_to_a<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = compute_amount_out(arg0.reserve_b, arg0.reserve_a, v0);
        assert!(v1 >= arg2, 3);
        assert!(v1 < arg0.reserve_a, 2);
        let v2 = accrue_fee<T0, T1>(arg0, (((v0 as u256) * (5 as u256) / (10000 as u256)) as u64), false);
        arg0.reserve_b = arg0.reserve_b + v0 - v2;
        arg0.reserve_a = arg0.reserve_a - v1;
        0x2::balance::join<T1>(&mut arg0.balance_b, 0x2::coin::into_balance<T1>(arg1));
        let v3 = Swapped{
            pool_id      : 0x2::object::id<Pool<T0, T1>>(arg0),
            swapper      : 0x2::tx_context::sender(arg4),
            amount_in    : v0,
            amount_out   : v1,
            a_to_b       : false,
            lp_fee       : v2,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<Swapped>(v3);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance_a, v1), arg4)
    }

    // decompiled from Move bytecode v7
}

