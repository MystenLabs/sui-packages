module 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault {
    struct CuratorCap has store, key {
        id: 0x2::object::UID,
        vault: 0x2::object::ID,
    }

    struct AllocatorCap has store, key {
        id: 0x2::object::UID,
        vault: 0x2::object::ID,
        budget_per_day: u64,
        day_start_ms: u64,
        used_today: u64,
        expires_ms: u64,
    }

    struct GuardianCap has store, key {
        id: 0x2::object::UID,
        vault: 0x2::object::ID,
        generation: u64,
    }

    struct Fees has copy, drop, store {
        perf_bps: u64,
        mgmt_bps: u64,
        entry_bps: u64,
        exit_bps: u64,
    }

    struct AdapterConfig has copy, drop, store {
        enabled: bool,
        cap_abs: u64,
        cap_rel_bps: u64,
        max_slippage_bps: u64,
        max_gain_bps_per_day: u64,
    }

    struct Adapter has store {
        kind: 0x1::type_name::TypeName,
        config: AdapterConfig,
        value: u64,
        last_report_ms: u64,
        impaired: bool,
    }

    struct PendingAdapter has copy, drop, store {
        kind: 0x1::type_name::TypeName,
        config: AdapterConfig,
        eta_ms: u64,
    }

    struct Vault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        version: u64,
        shares: 0x2::coin::TreasuryCap<T1>,
        dead_shares: 0x2::balance::Balance<T1>,
        idle: 0x2::balance::Balance<T0>,
        claim_pool: 0x2::balance::Balance<T0>,
        adapters: vector<Adapter>,
        queued_total: u64,
        funded_total: u64,
        owing_since_ms: u64,
        force_after_ms: u64,
        epoch: u64,
        fees: Fees,
        fee_recipient: address,
        hwm_price: u128,
        mgmt_last_ms: u64,
        tvl_cap: u64,
        timelock_ms: u64,
        pending_fees: 0x1::option::Option<Fees>,
        pending_fees_eta_ms: u64,
        pending_timelock: 0x1::option::Option<u64>,
        pending_timelock_eta_ms: u64,
        pending_adapters: vector<PendingAdapter>,
        allocators: 0x2::vec_set::VecSet<0x2::object::ID>,
        guardian_generation: u64,
        moving: bool,
        bond: 0x2::balance::Balance<T1>,
        bond_trigger_bps: u64,
        unbond_amount: u64,
        unbond_eta_ms: u64,
        paused: bool,
        derisk: bool,
    }

    struct WithdrawTicket has store, key {
        id: 0x2::object::UID,
        vault: 0x2::object::ID,
        amount: u64,
        cum_end: u64,
    }

    struct NavSession {
        vault: 0x2::object::ID,
        version: u64,
        epoch: u64,
        reported: vector<bool>,
        values: vector<u64>,
    }

    struct Nav {
        vault: 0x2::object::ID,
        version: u64,
        epoch: u64,
        value: u64,
        deferred: u64,
    }

    struct Allocation {
        vault: 0x2::object::ID,
        version: u64,
        slot: u64,
        amount: u64,
        allocator: 0x2::object::ID,
    }

    struct Deallocation {
        vault: 0x2::object::ID,
        version: u64,
        slot: u64,
        amount: u64,
        allocator: 0x1::option::Option<0x2::object::ID>,
    }

    struct VaultCreated has copy, drop {
        vault: 0x2::object::ID,
        curator_cap: 0x2::object::ID,
    }

    struct Valued has copy, drop {
        vault: 0x2::object::ID,
        nav: u64,
        supply: u64,
        price: u128,
        deferred_gain: u64,
    }

    struct Deposited has copy, drop {
        vault: 0x2::object::ID,
        user: address,
        amount: u64,
        shares: u64,
    }

    struct WithdrawQueued has copy, drop {
        vault: 0x2::object::ID,
        user: address,
        shares: u64,
        amount: u64,
        cum_end: u64,
    }

    struct QueueFunded has copy, drop {
        vault: 0x2::object::ID,
        amount: u64,
        funded_total: u64,
    }

    struct TicketClaimed has copy, drop {
        vault: 0x2::object::ID,
        amount: u64,
        cum_end: u64,
    }

    struct Allocated has copy, drop {
        vault: 0x2::object::ID,
        adapter: 0x1::type_name::TypeName,
        amount: u64,
        value_added: u64,
        allocator: 0x2::object::ID,
        memo: vector<u8>,
    }

    struct ForcedDeallocation has copy, drop {
        vault: 0x2::object::ID,
        adapter: 0x1::type_name::TypeName,
        amount: u64,
        starved_ms: u64,
    }

    struct Deallocated has copy, drop {
        vault: 0x2::object::ID,
        adapter: 0x1::type_name::TypeName,
        amount: u64,
        received: u64,
        allocator: 0x1::option::Option<0x2::object::ID>,
        memo: vector<u8>,
    }

    struct FeesMinted has copy, drop {
        vault: 0x2::object::ID,
        perf_shares: u64,
        mgmt_shares: u64,
    }

    struct BondBurned has copy, drop {
        vault: 0x2::object::ID,
        shares: u64,
        price_before: u128,
        price_after: u128,
    }

    struct LossReported has copy, drop {
        vault: 0x2::object::ID,
        adapter: 0x1::type_name::TypeName,
        before: u64,
        after: u64,
    }

    struct ChangeQueued has copy, drop {
        vault: 0x2::object::ID,
        what: vector<u8>,
        eta_ms: u64,
    }

    struct ChangeApplied has copy, drop {
        vault: 0x2::object::ID,
        what: vector<u8>,
    }

    struct AdapterImpaired has copy, drop {
        vault: 0x2::object::ID,
        adapter: 0x1::type_name::TypeName,
        written_off: u64,
    }

    struct ImpairedRecovered has copy, drop {
        vault: 0x2::object::ID,
        adapter: 0x1::type_name::TypeName,
        amount: u64,
        memo: vector<u8>,
    }

    fun absorb_with_bond<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64) : u64 {
        let v0 = 0x2::balance::value<T1>(&arg0.bond);
        if (v0 == 0) {
            return arg1
        };
        let v1 = 0x2::coin::total_supply<T1>(&arg0.shares);
        let v2 = price_of(arg1, v1);
        let v3 = arg0.hwm_price * ((10000 - arg0.bond_trigger_bps) as u128) / (10000 as u128);
        if (v2 >= v3 || v3 == 0) {
            return arg1
        };
        let v4 = (((arg1 as u128) * 1000000000 / v3) as u64);
        let v5 = if (v1 > v4) {
            v1 - v4
        } else {
            0
        };
        let v6 = min(v5, v0);
        if (v6 == 0) {
            return arg1
        };
        0x2::balance::decrease_supply<T1>(0x2::coin::supply_mut<T1>(&mut arg0.shares), 0x2::balance::split<T1>(&mut arg0.bond, v6));
        let v7 = BondBurned{
            vault        : 0x2::object::id<Vault<T0, T1>>(arg0),
            shares       : v6,
            price_before : v2,
            price_after  : price_of(arg1, 0x2::coin::total_supply<T1>(&arg0.shares)),
        };
        0x2::event::emit<BondBurned>(v7);
        arg1
    }

    public fun adapter_count<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x1::vector::length<Adapter>(&arg0.adapters)
    }

    public fun adapter_value<T0, T1, T2>(arg0: &Vault<T0, T1>) : u64 {
        let v0 = 0x1::type_name::with_original_ids<T2>();
        let v1 = find_slot<T0, T1>(arg0, &v0);
        assert!(0x1::option::is_some<u64>(&v1), 7);
        0x1::vector::borrow<Adapter>(&arg0.adapters, *0x1::option::borrow<u64>(&v1)).value
    }

    public fun allocate<T0, T1, T2: drop>(arg0: &mut Vault<T0, T1>, arg1: &mut AllocatorCap, arg2: T2, arg3: u64, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, Allocation) {
        assert_live<T0, T1>(arg0);
        assert!(!arg0.derisk, 28);
        assert!(!arg0.moving, 31);
        spend_budget<T0, T1>(arg0, arg1, arg3, arg4);
        let v0 = slot_of<T0, T1, T2>(arg0);
        assert!(0x1::vector::borrow<Adapter>(&arg0.adapters, v0).config.enabled, 9);
        assert!(0x2::balance::value<T0>(&arg0.idle) >= arg0.queued_total - arg0.funded_total + arg3, 24);
        arg0.epoch = arg0.epoch + 1;
        arg0.moving = true;
        let v1 = Allocation{
            vault     : 0x2::object::id<Vault<T0, T1>>(arg0),
            version   : 1,
            slot      : v0,
            amount    : arg3,
            allocator : 0x2::object::id<AllocatorCap>(arg1),
        };
        (0x2::balance::split<T0>(&mut arg0.idle, arg3), v1)
    }

    public fun allocator_cap_vault(arg0: &AllocatorCap) : 0x2::object::ID {
        arg0.vault
    }

    fun apply_adapter_config<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x1::type_name::TypeName, arg2: AdapterConfig, arg3: u64) {
        let v0 = find_slot<T0, T1>(arg0, &arg1);
        if (0x1::option::is_some<u64>(&v0)) {
            let v1 = *0x1::option::borrow<u64>(&v0);
            if (0x1::vector::borrow<Adapter>(&arg0.adapters, v1).impaired) {
                arg2.enabled = false;
            };
            0x1::vector::borrow_mut<Adapter>(&mut arg0.adapters, v1).config = arg2;
        } else {
            assert!(0x1::vector::length<Adapter>(&arg0.adapters) < 16, 26);
            let v2 = Adapter{
                kind           : arg1,
                config         : arg2,
                value          : 0,
                last_report_ms : arg3,
                impaired       : false,
            };
            0x1::vector::push_back<Adapter>(&mut arg0.adapters, v2);
            arg0.epoch = arg0.epoch + 1;
        };
    }

    fun assert_curator<T0, T1>(arg0: &Vault<T0, T1>, arg1: &CuratorCap) {
        assert_version<T0, T1>(arg0);
        assert!(arg1.vault == 0x2::object::id<Vault<T0, T1>>(arg0), 3);
    }

    fun assert_live<T0, T1>(arg0: &Vault<T0, T1>) {
        assert!(!arg0.paused, 1);
        assert_version<T0, T1>(arg0);
    }

    fun assert_version<T0, T1>(arg0: &Vault<T0, T1>) {
        assert!(arg0.version == 1, 23);
    }

    public fun bond_value<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.bond)
    }

    fun bump_hwm<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u128, arg2: u128) {
        if (arg2 == 0 || arg1 <= arg2) {
            return
        };
        arg0.hwm_price = (arg0.hwm_price * arg1 + arg2 - 1) / arg2;
    }

    public fun cancel_pending_adapters<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &CuratorCap) {
        assert_curator<T0, T1>(arg0, arg1);
        arg0.pending_adapters = 0x1::vector::empty<PendingAdapter>();
    }

    fun check_config(arg0: &AdapterConfig) {
        assert!(arg0.cap_rel_bps <= 10000, 15);
        assert!(arg0.max_slippage_bps <= 500, 15);
        assert!(arg0.max_gain_bps_per_day <= 10000, 15);
    }

    fun check_fees(arg0: &Fees) {
        assert!(arg0.perf_bps <= 3000, 15);
        assert!(arg0.mgmt_bps <= 500, 15);
        assert!(arg0.entry_bps <= 200, 15);
        assert!(arg0.exit_bps <= 200, 15);
    }

    fun check_witness<T0>() {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(!0x1::type_name::is_primitive(&v0), 32);
        let v1 = 0x1::type_name::address_string(&v0);
        assert!(v1 != 0x2::address::to_ascii_string(@0x1), 32);
        assert!(v1 != 0x2::address::to_ascii_string(@0x2), 32);
        assert!(v1 != 0x2::address::to_ascii_string(@0x3), 32);
        assert!(v0 != 0x1::type_name::with_original_ids<Fees>(), 32);
        assert!(v0 != 0x1::type_name::with_original_ids<AdapterConfig>(), 32);
    }

    public fun claim<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: WithdrawTicket, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version<T0, T1>(arg0);
        let WithdrawTicket {
            id      : v0,
            vault   : v1,
            amount  : v2,
            cum_end : v3,
        } = arg1;
        assert!(v1 == 0x2::object::id<Vault<T0, T1>>(arg0), 3);
        assert!(arg0.funded_total >= v3, 18);
        0x2::object::delete(v0);
        let v4 = TicketClaimed{
            vault   : v1,
            amount  : v2,
            cum_end : v3,
        };
        0x2::event::emit<TicketClaimed>(v4);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.claim_pool, v2), arg2)
    }

    public fun claim_pool_value<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.claim_pool)
    }

    public fun confirm_allocation<T0, T1, T2: drop>(arg0: &mut Vault<T0, T1>, arg1: Allocation, arg2: T2, arg3: u64, arg4: vector<u8>) {
        let Allocation {
            vault     : v0,
            version   : v1,
            slot      : v2,
            amount    : v3,
            allocator : v4,
        } = arg1;
        assert_version<T0, T1>(arg0);
        assert!(v1 == 1, 23);
        assert!(v0 == 0x2::object::id<Vault<T0, T1>>(arg0), 3);
        assert!(v2 == slot_of<T0, T1, T2>(arg0), 7);
        let v5 = 0x1::vector::borrow<Adapter>(&arg0.adapters, v2).config;
        assert!((arg3 as u128) * (10000 as u128) >= (v3 as u128) * ((10000 - v5.max_slippage_bps) as u128), 11);
        let v6 = 0x1::vector::borrow<Adapter>(&arg0.adapters, v2).value + min(arg3, v3);
        0x1::vector::borrow_mut<Adapter>(&mut arg0.adapters, v2).value = v6;
        arg0.moving = false;
        arg0.epoch = arg0.epoch + 1;
        assert!(v6 <= v5.cap_abs, 10);
        assert!((v6 as u128) * (10000 as u128) <= (nav_from_books<T0, T1>(arg0) as u128) * (v5.cap_rel_bps as u128), 10);
        let v7 = Allocated{
            vault       : v0,
            adapter     : 0x1::vector::borrow<Adapter>(&arg0.adapters, v2).kind,
            amount      : v3,
            value_added : arg3,
            allocator   : v4,
            memo        : arg4,
        };
        0x2::event::emit<Allocated>(v7);
    }

    public fun create<T0, T1>(arg0: 0x2::coin::TreasuryCap<T1>, arg1: Fees, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : CuratorCap {
        assert!(0x2::coin::total_supply<T1>(&arg0) == 0, 22);
        check_fees(&arg1);
        assert!(arg4 <= 2592000000, 15);
        assert!(arg5 <= 2000, 15);
        let v0 = Vault<T0, T1>{
            id                      : 0x2::object::new(arg7),
            version                 : 1,
            shares                  : arg0,
            dead_shares             : 0x2::balance::zero<T1>(),
            idle                    : 0x2::balance::zero<T0>(),
            claim_pool              : 0x2::balance::zero<T0>(),
            adapters                : 0x1::vector::empty<Adapter>(),
            queued_total            : 0,
            funded_total            : 0,
            owing_since_ms          : 0x2::clock::timestamp_ms(arg6),
            force_after_ms          : 604800000,
            epoch                   : 0,
            fees                    : arg1,
            fee_recipient           : arg2,
            hwm_price               : 1000000000,
            mgmt_last_ms            : 0x2::clock::timestamp_ms(arg6),
            tvl_cap                 : arg3,
            timelock_ms             : arg4,
            pending_fees            : 0x1::option::none<Fees>(),
            pending_fees_eta_ms     : 0,
            pending_timelock        : 0x1::option::none<u64>(),
            pending_timelock_eta_ms : 0,
            pending_adapters        : 0x1::vector::empty<PendingAdapter>(),
            allocators              : 0x2::vec_set::empty<0x2::object::ID>(),
            guardian_generation     : 0,
            moving                  : false,
            bond                    : 0x2::balance::zero<T1>(),
            bond_trigger_bps        : arg5,
            unbond_amount           : 0,
            unbond_eta_ms           : 0,
            paused                  : false,
            derisk                  : false,
        };
        let v1 = CuratorCap{
            id    : 0x2::object::new(arg7),
            vault : 0x2::object::id<Vault<T0, T1>>(&v0),
        };
        let v2 = VaultCreated{
            vault       : 0x2::object::id<Vault<T0, T1>>(&v0),
            curator_cap : 0x2::object::id<CuratorCap>(&v1),
        };
        0x2::event::emit<VaultCreated>(v2);
        0x2::transfer::share_object<Vault<T0, T1>>(v0);
        v1
    }

    fun crystallize_fees<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::coin::total_supply<T1>(&arg0.shares);
        let v1 = if (arg2 > arg0.mgmt_last_ms) {
            arg2 - arg0.mgmt_last_ms
        } else {
            0
        };
        arg0.mgmt_last_ms = arg2;
        if (v0 == 0 || arg1 == 0) {
            return arg1
        };
        let v2 = mul_div_u128((arg1 as u128), (arg0.fees.mgmt_bps as u128) * (v1 as u128), (10000 as u128) * 31536000000);
        let v3 = 0;
        if (v2 > 0 && v2 < (arg1 as u128)) {
            v3 = ((v2 * (v0 as u128) / ((arg1 as u128) - v2)) as u64);
        };
        let v4 = v0 + v3;
        let v5 = price_of(arg1, v4);
        let v6 = 0;
        if (v5 > arg0.hwm_price && arg0.fees.perf_bps > 0) {
            let v7 = (v5 - arg0.hwm_price) * (v4 as u128) / 1000000000 * (arg0.fees.perf_bps as u128) / (10000 as u128);
            if (v7 > 0 && v7 < (arg1 as u128)) {
                v6 = ((v7 * (v4 as u128) / ((arg1 as u128) - v7)) as u64);
            };
        };
        let v8 = v3 + v6;
        if (v8 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::mint<T1>(&mut arg0.shares, v8, arg3), arg0.fee_recipient);
            let v9 = FeesMinted{
                vault       : 0x2::object::id<Vault<T0, T1>>(arg0),
                perf_shares : v6,
                mgmt_shares : v3,
            };
            0x2::event::emit<FeesMinted>(v9);
        };
        let v10 = price_of(arg1, 0x2::coin::total_supply<T1>(&arg0.shares));
        if (v10 > arg0.hwm_price) {
            arg0.hwm_price = v10;
        };
        arg1
    }

    public fun curator_cap_vault(arg0: &CuratorCap) : 0x2::object::ID {
        arg0.vault
    }

    public fun deallocate<T0, T1, T2: drop>(arg0: &mut Vault<T0, T1>, arg1: &mut AllocatorCap, arg2: T2, arg3: u64, arg4: &0x2::clock::Clock) : Deallocation {
        assert_version<T0, T1>(arg0);
        assert!(!arg0.moving, 31);
        spend_budget<T0, T1>(arg0, arg1, arg3, arg4);
        let v0 = slot_of<T0, T1, T2>(arg0);
        assert!(arg3 > 0 && arg3 <= 0x1::vector::borrow<Adapter>(&arg0.adapters, v0).value, 15);
        arg0.epoch = arg0.epoch + 1;
        arg0.moving = true;
        Deallocation{
            vault     : 0x2::object::id<Vault<T0, T1>>(arg0),
            version   : 1,
            slot      : v0,
            amount    : arg3,
            allocator : 0x1::option::some<0x2::object::ID>(0x2::object::id<AllocatorCap>(arg1)),
        }
    }

    public fun deallocation_amount(arg0: &Deallocation) : u64 {
        arg0.amount
    }

    public fun deposit<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: Nav, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_live<T0, T1>(arg0);
        assert!(!has_impaired<T0, T1>(arg0), 33);
        let (v0, v1) = use_nav<T0, T1>(arg0, arg1);
        let v2 = v0 + v1;
        let v3 = 0x2::coin::value<T0>(&arg2);
        assert!(v3 > 0, 2);
        assert!((v2 as u128) + (v3 as u128) <= (arg0.tvl_cap as u128), 19);
        let v4 = 0x2::coin::total_supply<T1>(&arg0.shares);
        let v5 = if (v4 == 0) {
            assert!(v3 >= 1000 * 1000, 20);
            0x2::balance::join<T1>(&mut arg0.dead_shares, 0x2::coin::mint_balance<T1>(&mut arg0.shares, 1000));
            v3 - 1000
        } else {
            assert!(v2 > 0, 21);
            let v6 = v3 - mul_div(v3, 10000 - arg0.fees.entry_bps, 10000);
            if (v6 > 0) {
                bump_hwm<T0, T1>(arg0, (v2 as u128) + (v3 as u128), (v2 as u128) + ((v3 - v6) as u128));
            };
            mul_div(v3 - v6, v4, v2)
        };
        assert!(v5 > 0, 2);
        0x2::balance::join<T0>(&mut arg0.idle, 0x2::coin::into_balance<T0>(arg2));
        fund_queue<T0, T1>(arg0, 0x2::clock::timestamp_ms(arg3));
        let v7 = Deposited{
            vault  : 0x2::object::id<Vault<T0, T1>>(arg0),
            user   : 0x2::tx_context::sender(arg4),
            amount : v3,
            shares : v5,
        };
        0x2::event::emit<Deposited>(v7);
        0x2::coin::mint<T1>(&mut arg0.shares, v5, arg4)
    }

    public fun discard_nav(arg0: Nav) {
        let Nav {
            vault    : _,
            version  : _,
            epoch    : _,
            value    : _,
            deferred : _,
        } = arg0;
    }

    public fun epoch<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.epoch
    }

    public fun execute_fees<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2::clock::Clock) {
        assert_version<T0, T1>(arg0);
        assert!(0x1::option::is_some<Fees>(&arg0.pending_fees), 17);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.pending_fees_eta_ms, 16);
        arg0.fees = 0x1::option::extract<Fees>(&mut arg0.pending_fees);
        let v0 = ChangeApplied{
            vault : 0x2::object::id<Vault<T0, T1>>(arg0),
            what  : b"fees",
        };
        0x2::event::emit<ChangeApplied>(v0);
    }

    public fun execute_pending_adapters<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2::clock::Clock) {
        assert_version<T0, T1>(arg0);
        assert!(!arg0.moving, 31);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<PendingAdapter>(&arg0.pending_adapters)) {
            if (0x1::vector::borrow<PendingAdapter>(&arg0.pending_adapters, v1).eta_ms <= v0) {
                let v2 = 0x1::vector::swap_remove<PendingAdapter>(&mut arg0.pending_adapters, v1);
                apply_adapter_config<T0, T1>(arg0, v2.kind, v2.config, v0);
                continue
            };
            v1 = v1 + 1;
        };
    }

    public fun execute_timelock<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2::clock::Clock) {
        assert_version<T0, T1>(arg0);
        assert!(0x1::option::is_some<u64>(&arg0.pending_timelock), 17);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.pending_timelock_eta_ms, 16);
        arg0.timelock_ms = 0x1::option::extract<u64>(&mut arg0.pending_timelock);
    }

    fun find_slot<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x1::type_name::TypeName) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Adapter>(&arg0.adapters)) {
            if (&0x1::vector::borrow<Adapter>(&arg0.adapters, v0).kind == arg1) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    public fun finish_valuation<T0, T1>(arg0: NavSession, arg1: &mut Vault<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : Nav {
        let NavSession {
            vault    : v0,
            version  : v1,
            epoch    : v2,
            reported : v3,
            values   : v4,
        } = arg0;
        let v5 = v4;
        let v6 = v3;
        assert_version<T0, T1>(arg1);
        assert!(v1 == 1, 23);
        assert!(v0 == 0x2::object::id<Vault<T0, T1>>(arg1), 3);
        assert!(v2 == arg1.epoch, 4);
        assert!(!arg1.moving, 31);
        let v7 = 0x2::clock::timestamp_ms(arg2);
        let v8 = 0;
        let v9 = false;
        let v10 = 0;
        while (v10 < 0x1::vector::length<Adapter>(&arg1.adapters)) {
            assert!(*0x1::vector::borrow<bool>(&v6, v10), 5);
            let v11 = 0x1::vector::borrow_mut<Adapter>(&mut arg1.adapters, v10);
            if (v11.config.enabled || v11.value > 0) {
                let v12 = *0x1::vector::borrow<u64>(&v5, v10);
                let v13 = if (v12 < v11.value) {
                    let v14 = LossReported{
                        vault   : v0,
                        adapter : v11.kind,
                        before  : v11.value,
                        after   : v12,
                    };
                    0x2::event::emit<LossReported>(v14);
                    if (((v11.value - v12) as u128) * (10000 as u128) > (v11.value as u128) * (50 as u128)) {
                        v9 = true;
                    };
                    v12
                } else {
                    let v15 = if (v7 > v11.last_report_ms) {
                        v7 - v11.last_report_ms
                    } else {
                        0
                    };
                    let v16 = (v11.value as u128) + mul_div_u128((v11.value as u128), (v11.config.max_gain_bps_per_day as u128) * (v15 as u128), (10000 as u128) * (86400000 as u128));
                    if ((v12 as u128) > v16) {
                        v8 = v8 + (((v12 as u128) - v16) as u64);
                        (v16 as u64)
                    } else {
                        v12
                    }
                };
                v11.value = v13;
                v11.last_report_ms = v7;
            };
            v10 = v10 + 1;
        };
        if (v9) {
            arg1.derisk = true;
        };
        let v17 = nav_from_books<T0, T1>(arg1);
        let v18 = crystallize_fees<T0, T1>(arg1, v17, v7, arg3);
        let v19 = absorb_with_bond<T0, T1>(arg1, v18);
        let v20 = 0x2::coin::total_supply<T1>(&arg1.shares);
        let v21 = Valued{
            vault         : v0,
            nav           : v19,
            supply        : v20,
            price         : price_of(v19, v20),
            deferred_gain : v8,
        };
        0x2::event::emit<Valued>(v21);
        Nav{
            vault    : v0,
            version  : 1,
            epoch    : arg1.epoch,
            value    : v19,
            deferred : v8,
        }
    }

    public fun force_deallocate<T0, T1, T2: drop>(arg0: &mut Vault<T0, T1>, arg1: T2, arg2: u64, arg3: &0x2::clock::Clock) : Deallocation {
        assert_version<T0, T1>(arg0);
        assert!(!arg0.moving, 31);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = arg0.queued_total - arg0.funded_total;
        assert!(v1 > 0x2::balance::value<T0>(&arg0.idle), 30);
        assert!(v0 >= arg0.owing_since_ms + arg0.force_after_ms, 30);
        let v2 = slot_of<T0, T1, T2>(arg0);
        let v3 = min(min(arg2, v1 - 0x2::balance::value<T0>(&arg0.idle)), 0x1::vector::borrow<Adapter>(&arg0.adapters, v2).value);
        assert!(v3 > 0, 2);
        arg0.epoch = arg0.epoch + 1;
        arg0.moving = true;
        let v4 = ForcedDeallocation{
            vault      : 0x2::object::id<Vault<T0, T1>>(arg0),
            adapter    : 0x1::vector::borrow<Adapter>(&arg0.adapters, v2).kind,
            amount     : v3,
            starved_ms : v0 - arg0.owing_since_ms,
        };
        0x2::event::emit<ForcedDeallocation>(v4);
        Deallocation{
            vault     : 0x2::object::id<Vault<T0, T1>>(arg0),
            version   : 1,
            slot      : v2,
            amount    : v3,
            allocator : 0x1::option::none<0x2::object::ID>(),
        }
    }

    public fun forceable<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = arg0.queued_total - arg0.funded_total;
        if (v0 <= 0x2::balance::value<T0>(&arg0.idle) || 0x2::clock::timestamp_ms(arg1) < arg0.owing_since_ms + arg0.force_after_ms) {
            0
        } else {
            v0 - 0x2::balance::value<T0>(&arg0.idle)
        }
    }

    fun fund_queue<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64) {
        let v0 = min(arg0.queued_total - arg0.funded_total, 0x2::balance::value<T0>(&arg0.idle));
        if (v0 > 0) {
            0x2::balance::join<T0>(&mut arg0.claim_pool, 0x2::balance::split<T0>(&mut arg0.idle, v0));
            arg0.funded_total = arg0.funded_total + v0;
            let v1 = QueueFunded{
                vault        : 0x2::object::id<Vault<T0, T1>>(arg0),
                amount       : v0,
                funded_total : arg0.funded_total,
            };
            0x2::event::emit<QueueFunded>(v1);
        };
        if (arg0.queued_total == arg0.funded_total) {
            arg0.owing_since_ms = arg1;
        };
    }

    public fun funded_total<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.funded_total
    }

    public fun guardian_pause<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &GuardianCap) {
        assert_version<T0, T1>(arg0);
        assert!(arg1.vault == 0x2::object::id<Vault<T0, T1>>(arg0), 3);
        assert!(arg1.generation == arg0.guardian_generation, 14);
        arg0.paused = true;
        arg0.derisk = true;
    }

    fun has_impaired<T0, T1>(arg0: &Vault<T0, T1>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Adapter>(&arg0.adapters)) {
            if (0x1::vector::borrow<Adapter>(&arg0.adapters, v0).impaired) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun hwm_price<T0, T1>(arg0: &Vault<T0, T1>) : u128 {
        arg0.hwm_price
    }

    public fun idle_value<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.idle)
    }

    public fun impair_adapter<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &CuratorCap, arg2: &0x2::clock::Clock) {
        assert_curator<T0, T1>(arg0, arg1);
        assert!(!arg0.moving, 31);
        let v0 = slot_of<T0, T1, T2>(arg0);
        assert!(0x2::clock::timestamp_ms(arg2) >= 0x1::vector::borrow<Adapter>(&arg0.adapters, v0).last_report_ms + 21600000, 16);
        let v1 = 0x2::object::id<Vault<T0, T1>>(arg0);
        let v2 = 0x1::vector::borrow_mut<Adapter>(&mut arg0.adapters, v0);
        let v3 = v2.value;
        if (v3 > 0) {
            let v4 = LossReported{
                vault   : v1,
                adapter : v2.kind,
                before  : v3,
                after   : 0,
            };
            0x2::event::emit<LossReported>(v4);
        };
        v2.value = 0;
        v2.impaired = true;
        v2.config.enabled = false;
        v2.last_report_ms = 0x2::clock::timestamp_ms(arg2);
        arg0.derisk = true;
        arg0.epoch = arg0.epoch + 1;
        let v5 = AdapterImpaired{
            vault       : v1,
            adapter     : v2.kind,
            written_off : v3,
        };
        0x2::event::emit<AdapterImpaired>(v5);
    }

    public fun is_derisk<T0, T1>(arg0: &Vault<T0, T1>) : bool {
        arg0.derisk
    }

    public fun is_impaired<T0, T1, T2>(arg0: &Vault<T0, T1>) : bool {
        let v0 = 0x1::type_name::with_original_ids<T2>();
        let v1 = find_slot<T0, T1>(arg0, &v0);
        assert!(0x1::option::is_some<u64>(&v1), 7);
        0x1::vector::borrow<Adapter>(&arg0.adapters, *0x1::option::borrow<u64>(&v1)).impaired
    }

    public fun is_live_allocator<T0, T1>(arg0: &Vault<T0, T1>, arg1: &AllocatorCap, arg2: &0x2::clock::Clock) : bool {
        if (arg1.vault == 0x2::object::id<Vault<T0, T1>>(arg0)) {
            let v1 = 0x2::object::id<AllocatorCap>(arg1);
            if (0x2::vec_set::contains<0x2::object::ID>(&arg0.allocators, &v1)) {
                arg1.expires_ms == 0 || 0x2::clock::timestamp_ms(arg2) < arg1.expires_ms
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun is_moving<T0, T1>(arg0: &Vault<T0, T1>) : bool {
        arg0.moving
    }

    public fun is_paused<T0, T1>(arg0: &Vault<T0, T1>) : bool {
        arg0.paused
    }

    public fun is_ticket_funded<T0, T1>(arg0: &Vault<T0, T1>, arg1: &WithdrawTicket) : bool {
        arg1.vault == 0x2::object::id<Vault<T0, T1>>(arg0) && arg0.funded_total >= arg1.cum_end
    }

    public fun migrate<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &CuratorCap) {
        assert!(arg1.vault == 0x2::object::id<Vault<T0, T1>>(arg0), 3);
        assert!(arg0.version < 1, 23);
        arg0.version = 1;
    }

    fun min(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    fun mul_div_u128(arg0: u128, arg1: u128, arg2: u128) : u128 {
        arg0 * arg1 / arg2
    }

    public fun nav_deferred(arg0: &Nav) : u64 {
        arg0.deferred
    }

    fun nav_from_books<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        let v0 = (0x2::balance::value<T0>(&arg0.idle) as u128);
        let v1 = 0;
        while (v1 < 0x1::vector::length<Adapter>(&arg0.adapters)) {
            v0 = v0 + (0x1::vector::borrow<Adapter>(&arg0.adapters, v1).value as u128);
            v1 = v1 + 1;
        };
        let v2 = ((arg0.queued_total - arg0.funded_total) as u128);
        if (v2 >= v0) {
            0
        } else {
            ((v0 - v2) as u64)
        }
    }

    public fun nav_value(arg0: &Nav) : u64 {
        arg0.value
    }

    public fun new_adapter_config(arg0: bool, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : AdapterConfig {
        let v0 = AdapterConfig{
            enabled              : arg0,
            cap_abs              : arg1,
            cap_rel_bps          : arg2,
            max_slippage_bps     : arg3,
            max_gain_bps_per_day : arg4,
        };
        check_config(&v0);
        v0
    }

    public fun new_allocator<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &CuratorCap, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : AllocatorCap {
        assert_curator<T0, T1>(arg0, arg1);
        let v0 = AllocatorCap{
            id             : 0x2::object::new(arg5),
            vault          : 0x2::object::id<Vault<T0, T1>>(arg0),
            budget_per_day : arg2,
            day_start_ms   : 0x2::clock::timestamp_ms(arg4),
            used_today     : 0,
            expires_ms     : arg3,
        };
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.allocators, 0x2::object::id<AllocatorCap>(&v0));
        v0
    }

    public fun new_fees(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : Fees {
        let v0 = Fees{
            perf_bps  : arg0,
            mgmt_bps  : arg1,
            entry_bps : arg2,
            exit_bps  : arg3,
        };
        check_fees(&v0);
        v0
    }

    public fun new_guardian<T0, T1>(arg0: &Vault<T0, T1>, arg1: &CuratorCap, arg2: &mut 0x2::tx_context::TxContext) : GuardianCap {
        assert_curator<T0, T1>(arg0, arg1);
        GuardianCap{
            id         : 0x2::object::new(arg2),
            vault      : 0x2::object::id<Vault<T0, T1>>(arg0),
            generation : arg0.guardian_generation,
        }
    }

    public fun post_bond<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &CuratorCap, arg2: 0x2::coin::Coin<T1>) {
        assert_curator<T0, T1>(arg0, arg1);
        0x2::balance::join<T1>(&mut arg0.bond, 0x2::coin::into_balance<T1>(arg2));
    }

    fun price_of(arg0: u64, arg1: u64) : u128 {
        if (arg1 == 0) {
            1000000000
        } else {
            (arg0 as u128) * 1000000000 / (arg1 as u128)
        }
    }

    public fun propose_adapter<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &CuratorCap, arg2: AdapterConfig, arg3: &0x2::clock::Clock) {
        assert_curator<T0, T1>(arg0, arg1);
        check_config(&arg2);
        check_witness<T2>();
        let v0 = 0x1::type_name::with_original_ids<T2>();
        let v1 = find_slot<T0, T1>(arg0, &v0);
        assert!(0x1::option::is_none<u64>(&v1), 8);
        let v2 = 0x2::clock::timestamp_ms(arg3) + arg0.timelock_ms;
        let v3 = PendingAdapter{
            kind   : v0,
            config : arg2,
            eta_ms : v2,
        };
        0x1::vector::push_back<PendingAdapter>(&mut arg0.pending_adapters, v3);
        let v4 = ChangeQueued{
            vault  : 0x2::object::id<Vault<T0, T1>>(arg0),
            what   : b"adapter",
            eta_ms : v2,
        };
        0x2::event::emit<ChangeQueued>(v4);
    }

    public fun recover_impaired<T0, T1, T2: drop>(arg0: &mut Vault<T0, T1>, arg1: T2, arg2: 0x2::balance::Balance<T0>, arg3: vector<u8>, arg4: &0x2::clock::Clock) {
        assert_version<T0, T1>(arg0);
        assert!(!arg0.moving, 31);
        let v0 = slot_of<T0, T1, T2>(arg0);
        assert!(0x1::vector::borrow<Adapter>(&arg0.adapters, v0).impaired, 34);
        let v1 = 0x1::vector::borrow<Adapter>(&arg0.adapters, v0).kind;
        0x2::balance::join<T0>(&mut arg0.idle, arg2);
        arg0.epoch = arg0.epoch + 1;
        fund_queue<T0, T1>(arg0, 0x2::clock::timestamp_ms(arg4));
        let v2 = ImpairedRecovered{
            vault   : 0x2::object::id<Vault<T0, T1>>(arg0),
            adapter : v1,
            amount  : 0x2::balance::value<T0>(&arg2),
            memo    : arg3,
        };
        0x2::event::emit<ImpairedRecovered>(v2);
    }

    fun reduces_risk(arg0: &AdapterConfig, arg1: &AdapterConfig) : bool {
        if (!arg1.enabled || arg0.enabled) {
            if (arg1.cap_abs <= arg0.cap_abs) {
                if (arg1.cap_rel_bps <= arg0.cap_rel_bps) {
                    if (arg1.max_slippage_bps <= arg0.max_slippage_bps) {
                        arg1.max_gain_bps_per_day <= arg0.max_gain_bps_per_day
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun remove_adapter<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &CuratorCap) {
        assert_curator<T0, T1>(arg0, arg1);
        assert!(!arg0.moving, 31);
        let v0 = 0x1::type_name::with_original_ids<T2>();
        let v1 = find_slot<T0, T1>(arg0, &v0);
        assert!(0x1::option::is_some<u64>(&v1), 7);
        let v2 = *0x1::option::borrow<u64>(&v1);
        assert!(0x1::vector::borrow<Adapter>(&arg0.adapters, v2).value == 0 && !0x1::vector::borrow<Adapter>(&arg0.adapters, v2).config.enabled, 29);
        let Adapter {
            kind           : _,
            config         : _,
            value          : _,
            last_report_ms : _,
            impaired       : _,
        } = 0x1::vector::remove<Adapter>(&mut arg0.adapters, v2);
        arg0.epoch = arg0.epoch + 1;
    }

    public fun report<T0, T1, T2: drop>(arg0: &mut NavSession, arg1: &Vault<T0, T1>, arg2: T2, arg3: u64) {
        assert_version<T0, T1>(arg1);
        assert!(arg0.version == 1, 23);
        assert!(arg0.vault == 0x2::object::id<Vault<T0, T1>>(arg1), 3);
        let v0 = slot_of<T0, T1, T2>(arg1);
        if (0x1::vector::borrow<Adapter>(&arg1.adapters, v0).impaired) {
            return
        };
        assert!(!*0x1::vector::borrow<bool>(&arg0.reported, v0), 6);
        *0x1::vector::borrow_mut<bool>(&mut arg0.reported, v0) = true;
        *0x1::vector::borrow_mut<u64>(&mut arg0.values, v0) = arg3;
    }

    public fun request_unbond<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &CuratorCap, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_curator<T0, T1>(arg0, arg1);
        assert!(arg2 > 0 && arg2 <= 0x2::balance::value<T1>(&arg0.bond), 27);
        arg0.unbond_amount = arg2;
        let v0 = if (arg0.timelock_ms > 604800000) {
            arg0.timelock_ms
        } else {
            604800000
        };
        arg0.unbond_eta_ms = 0x2::clock::timestamp_ms(arg3) + v0;
    }

    public fun request_withdraw<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: Nav, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : WithdrawTicket {
        assert_version<T0, T1>(arg0);
        let (v0, _) = use_nav<T0, T1>(arg0, arg1);
        let v2 = 0x2::coin::value<T1>(&arg2);
        assert!(v2 > 0, 2);
        let v3 = mul_div(v2, v0, 0x2::coin::total_supply<T1>(&arg0.shares));
        let v4 = mul_div(v3, 10000 - arg0.fees.exit_bps, 10000);
        assert!(v4 > 0, 2);
        assert!(v4 >= arg3, 25);
        if (v4 < v3 && v0 > v3) {
            bump_hwm<T0, T1>(arg0, ((v0 - v4) as u128), ((v0 - v3) as u128));
        };
        0x2::coin::burn<T1>(&mut arg0.shares, arg2);
        arg0.queued_total = arg0.queued_total + v4;
        let v5 = arg0.queued_total;
        let v6 = WithdrawQueued{
            vault   : 0x2::object::id<Vault<T0, T1>>(arg0),
            user    : 0x2::tx_context::sender(arg5),
            shares  : v2,
            amount  : v4,
            cum_end : v5,
        };
        0x2::event::emit<WithdrawQueued>(v6);
        if (arg0.queued_total == arg0.funded_total) {
            arg0.owing_since_ms = 0x2::clock::timestamp_ms(arg4);
        };
        fund_queue<T0, T1>(arg0, 0x2::clock::timestamp_ms(arg4));
        WithdrawTicket{
            id      : 0x2::object::new(arg5),
            vault   : 0x2::object::id<Vault<T0, T1>>(arg0),
            amount  : v4,
            cum_end : v5,
        }
    }

    public fun revoke_allocator<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &CuratorCap, arg2: 0x2::object::ID) {
        assert_curator<T0, T1>(arg0, arg1);
        if (0x2::vec_set::contains<0x2::object::ID>(&arg0.allocators, &arg2)) {
            0x2::vec_set::remove<0x2::object::ID>(&mut arg0.allocators, &arg2);
        };
    }

    public fun revoke_guardians<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &CuratorCap) {
        assert_curator<T0, T1>(arg0, arg1);
        arg0.guardian_generation = arg0.guardian_generation + 1;
    }

    public fun set_adapter_config<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &CuratorCap, arg2: AdapterConfig, arg3: &0x2::clock::Clock) {
        assert_curator<T0, T1>(arg0, arg1);
        check_config(&arg2);
        let v0 = 0x1::type_name::with_original_ids<T2>();
        let v1 = find_slot<T0, T1>(arg0, &v0);
        assert!(0x1::option::is_some<u64>(&v1), 7);
        let v2 = 0x1::vector::borrow<Adapter>(&arg0.adapters, *0x1::option::borrow<u64>(&v1)).config;
        if (reduces_risk(&v2, &arg2)) {
            apply_adapter_config<T0, T1>(arg0, v0, arg2, 0x2::clock::timestamp_ms(arg3));
            let v3 = ChangeApplied{
                vault : 0x2::object::id<Vault<T0, T1>>(arg0),
                what  : b"adapter",
            };
            0x2::event::emit<ChangeApplied>(v3);
        } else {
            let v4 = 0x2::clock::timestamp_ms(arg3) + arg0.timelock_ms;
            let v5 = PendingAdapter{
                kind   : v0,
                config : arg2,
                eta_ms : v4,
            };
            0x1::vector::push_back<PendingAdapter>(&mut arg0.pending_adapters, v5);
            let v6 = ChangeQueued{
                vault  : 0x2::object::id<Vault<T0, T1>>(arg0),
                what   : b"adapter",
                eta_ms : v4,
            };
            0x2::event::emit<ChangeQueued>(v6);
        };
    }

    public fun set_fee_recipient<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &CuratorCap, arg2: address) {
        assert_curator<T0, T1>(arg0, arg1);
        arg0.fee_recipient = arg2;
    }

    public fun set_fees<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &CuratorCap, arg2: Fees, arg3: &0x2::clock::Clock) {
        assert_curator<T0, T1>(arg0, arg1);
        check_fees(&arg2);
        let v0 = arg0.fees;
        let v1 = if (arg2.perf_bps <= v0.perf_bps) {
            if (arg2.mgmt_bps <= v0.mgmt_bps) {
                if (arg2.entry_bps <= v0.entry_bps) {
                    arg2.exit_bps <= v0.exit_bps
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        if (v1) {
            arg0.fees = arg2;
            arg0.pending_fees = 0x1::option::none<Fees>();
            let v2 = ChangeApplied{
                vault : 0x2::object::id<Vault<T0, T1>>(arg0),
                what  : b"fees",
            };
            0x2::event::emit<ChangeApplied>(v2);
        } else {
            arg0.pending_fees = 0x1::option::some<Fees>(arg2);
            arg0.pending_fees_eta_ms = 0x2::clock::timestamp_ms(arg3) + arg0.timelock_ms;
            let v3 = ChangeQueued{
                vault  : 0x2::object::id<Vault<T0, T1>>(arg0),
                what   : b"fees",
                eta_ms : arg0.pending_fees_eta_ms,
            };
            0x2::event::emit<ChangeQueued>(v3);
        };
    }

    public fun set_force_after<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &CuratorCap, arg2: u64) {
        assert_curator<T0, T1>(arg0, arg1);
        assert!(arg2 <= 604800000, 15);
        arg0.force_after_ms = arg2;
    }

    public fun set_paused<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &CuratorCap, arg2: bool, arg3: bool) {
        assert_curator<T0, T1>(arg0, arg1);
        arg0.paused = arg2;
        arg0.derisk = arg3;
    }

    public fun set_timelock<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &CuratorCap, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_curator<T0, T1>(arg0, arg1);
        assert!(arg2 <= 2592000000, 15);
        if (arg2 >= arg0.timelock_ms) {
            arg0.timelock_ms = arg2;
            let v0 = ChangeApplied{
                vault : 0x2::object::id<Vault<T0, T1>>(arg0),
                what  : b"timelock",
            };
            0x2::event::emit<ChangeApplied>(v0);
        } else {
            arg0.pending_timelock = 0x1::option::some<u64>(arg2);
            arg0.pending_timelock_eta_ms = 0x2::clock::timestamp_ms(arg3) + arg0.timelock_ms;
            let v1 = ChangeQueued{
                vault  : 0x2::object::id<Vault<T0, T1>>(arg0),
                what   : b"timelock",
                eta_ms : arg0.pending_timelock_eta_ms,
            };
            0x2::event::emit<ChangeQueued>(v1);
        };
    }

    public fun set_tvl_cap<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &CuratorCap, arg2: u64) {
        assert_curator<T0, T1>(arg0, arg1);
        arg0.tvl_cap = arg2;
    }

    public fun settle_deallocation<T0, T1, T2: drop>(arg0: &mut Vault<T0, T1>, arg1: Deallocation, arg2: T2, arg3: 0x2::balance::Balance<T0>, arg4: vector<u8>, arg5: &0x2::clock::Clock) {
        let Deallocation {
            vault     : v0,
            version   : v1,
            slot      : v2,
            amount    : v3,
            allocator : v4,
        } = arg1;
        assert_version<T0, T1>(arg0);
        assert!(v1 == 1, 23);
        assert!(v0 == 0x2::object::id<Vault<T0, T1>>(arg0), 3);
        assert!(v2 == slot_of<T0, T1, T2>(arg0), 7);
        let v5 = 0x2::balance::value<T0>(&arg3);
        let v6 = 0x1::vector::borrow_mut<Adapter>(&mut arg0.adapters, v2);
        assert!((v5 as u128) * (10000 as u128) >= (v3 as u128) * ((10000 - v6.config.max_slippage_bps) as u128), 11);
        v6.value = v6.value - v3;
        0x2::balance::join<T0>(&mut arg0.idle, arg3);
        arg0.moving = false;
        arg0.epoch = arg0.epoch + 1;
        fund_queue<T0, T1>(arg0, 0x2::clock::timestamp_ms(arg5));
        let v7 = Deallocated{
            vault     : v0,
            adapter   : v6.kind,
            amount    : v3,
            received  : v5,
            allocator : v4,
            memo      : arg4,
        };
        0x2::event::emit<Deallocated>(v7);
    }

    fun slot_of<T0, T1, T2>(arg0: &Vault<T0, T1>) : u64 {
        let v0 = 0x1::type_name::with_original_ids<T2>();
        let v1 = find_slot<T0, T1>(arg0, &v0);
        assert!(0x1::option::is_some<u64>(&v1), 7);
        *0x1::option::borrow<u64>(&v1)
    }

    fun spend_budget<T0, T1>(arg0: &Vault<T0, T1>, arg1: &mut AllocatorCap, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_version<T0, T1>(arg0);
        assert!(arg1.vault == 0x2::object::id<Vault<T0, T1>>(arg0), 3);
        let v0 = 0x2::object::id<AllocatorCap>(arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allocators, &v0), 14);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg1.expires_ms == 0 || v1 < arg1.expires_ms, 13);
        if (v1 >= arg1.day_start_ms + 86400000) {
            arg1.day_start_ms = v1;
            arg1.used_today = 0;
        };
        assert!(arg1.used_today + arg2 <= arg1.budget_per_day, 12);
        arg1.used_today = arg1.used_today + arg2;
    }

    public fun start_valuation<T0, T1>(arg0: &Vault<T0, T1>) : NavSession {
        assert_version<T0, T1>(arg0);
        assert!(!arg0.moving, 31);
        let v0 = vector[];
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<Adapter>(&arg0.adapters)) {
            let v3 = 0x1::vector::borrow<Adapter>(&arg0.adapters, v2);
            let v4 = !v3.config.enabled && v3.value == 0;
            0x1::vector::push_back<bool>(&mut v0, v4);
            0x1::vector::push_back<u64>(&mut v1, 0);
            v2 = v2 + 1;
        };
        NavSession{
            vault    : 0x2::object::id<Vault<T0, T1>>(arg0),
            version  : 1,
            epoch    : arg0.epoch,
            reported : v0,
            values   : v1,
        }
    }

    public fun ticket_ahead<T0, T1>(arg0: &Vault<T0, T1>, arg1: &WithdrawTicket) : u64 {
        if (arg0.funded_total >= arg1.cum_end) {
            0
        } else {
            arg1.cum_end - arg0.funded_total
        }
    }

    public fun ticket_amount(arg0: &WithdrawTicket) : u64 {
        arg0.amount
    }

    public fun ticket_cum_end(arg0: &WithdrawTicket) : u64 {
        arg0.cum_end
    }

    public fun ticket_vault(arg0: &WithdrawTicket) : 0x2::object::ID {
        arg0.vault
    }

    public fun timelock_ms<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.timelock_ms
    }

    public fun total_shares<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::coin::total_supply<T1>(&arg0.shares)
    }

    public fun unfunded<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.queued_total - arg0.funded_total
    }

    fun use_nav<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: Nav) : (u64, u64) {
        let Nav {
            vault    : v0,
            version  : v1,
            epoch    : v2,
            value    : v3,
            deferred : v4,
        } = arg1;
        assert!(v1 == 1, 23);
        assert!(v0 == 0x2::object::id<Vault<T0, T1>>(arg0), 3);
        assert!(v2 == arg0.epoch, 4);
        assert!(!arg0.moving, 31);
        arg0.epoch = arg0.epoch + 1;
        (v3, v4)
    }

    public fun version<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.version
    }

    public fun withdraw_bond<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &CuratorCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_curator<T0, T1>(arg0, arg1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg0.unbond_amount > 0 && v0 >= arg0.unbond_eta_ms, 27);
        assert!(v0 <= arg0.unbond_eta_ms + 172800000, 27);
        arg0.unbond_amount = 0;
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.bond, min(arg0.unbond_amount, 0x2::balance::value<T1>(&arg0.bond))), arg3)
    }

    // decompiled from Move bytecode v7
}

