module 0xaf2f8ad6382c0706e0ed17ce4d68bec8ccd858ec3741bcfd2b5d38234409df07::vault_hedgeswap_integration {
    struct IntegrationRegistry has key {
        id: 0x2::object::UID,
        hedgeswap_whitelist_address: address,
        hedgeswap_module_address: address,
        total_delegations: u64,
        total_delegated_value: u64,
        admin: address,
    }

    struct VaultDelegationTracker has key {
        id: 0x2::object::UID,
        loan_vault_id: 0x2::object::ID,
        borrower: address,
        hedgeswap_vault_id: 0x1::option::Option<0x2::object::ID>,
        delegated_amount: u64,
        passive_amount: u64,
        total_collateral: u64,
        delegation_timestamp: u64,
        is_active: bool,
        accumulated_yield: u64,
    }

    struct DelegationInitiated has copy, drop {
        loan_vault_id: 0x2::object::ID,
        borrower: address,
        hedgeswap_vault_id: 0x2::object::ID,
        delegated_amount: u64,
        passive_amount: u64,
        timestamp: u64,
    }

    struct DelegationCompleted has copy, drop {
        loan_vault_id: 0x2::object::ID,
        borrower: address,
        returned_amount: u64,
        yield_earned: u64,
        timestamp: u64,
    }

    struct YieldClaimed has copy, drop {
        loan_vault_id: 0x2::object::ID,
        borrower: address,
        yield_amount: u64,
        timestamp: u64,
    }

    public entry fun complete_delegation(arg0: &mut IntegrationRegistry, arg1: &mut VaultDelegationTracker, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1.borrower, 1);
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        arg1.hedgeswap_vault_id = 0x1::option::some<0x2::object::ID>(arg2);
        arg1.delegation_timestamp = v0;
        arg1.is_active = true;
        arg0.total_delegations = arg0.total_delegations + 1;
        arg0.total_delegated_value = arg0.total_delegated_value + arg1.delegated_amount;
        let v1 = DelegationInitiated{
            loan_vault_id      : arg1.loan_vault_id,
            borrower           : arg1.borrower,
            hedgeswap_vault_id : arg2,
            delegated_amount   : arg1.delegated_amount,
            passive_amount     : arg1.passive_amount,
            timestamp          : v0,
        };
        0x2::event::emit<DelegationInitiated>(v1);
    }

    public entry fun complete_undelegation(arg0: &mut IntegrationRegistry, arg1: &mut VaultDelegationTracker, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg1.borrower, 1);
        arg1.is_active = false;
        arg1.accumulated_yield = arg1.accumulated_yield + arg3;
        arg1.passive_amount = arg1.passive_amount + arg2;
        arg1.delegated_amount = 0;
        arg1.hedgeswap_vault_id = 0x1::option::none<0x2::object::ID>();
        arg0.total_delegated_value = arg0.total_delegated_value - arg2;
        let v0 = DelegationCompleted{
            loan_vault_id   : arg1.loan_vault_id,
            borrower        : arg1.borrower,
            returned_amount : arg2,
            yield_earned    : arg3,
            timestamp       : 0x2::clock::timestamp_ms(arg4) / 1000,
        };
        0x2::event::emit<DelegationCompleted>(v0);
    }

    public entry fun configure_hedgeswap_addresses(arg0: &mut IntegrationRegistry, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 1);
        arg0.hedgeswap_whitelist_address = arg1;
        arg0.hedgeswap_module_address = arg2;
    }

    public fun extract_collateral_for_delegation(arg0: &mut VaultDelegationTracker, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0x2::tx_context::sender(arg2) == arg0.borrower, 1);
        assert!(!arg0.is_active, 3);
        assert!(arg1 > 0, 6);
        assert!(arg0.passive_amount - arg1 >= arg0.total_collateral * 20 / 100, 7);
        assert!(arg1 <= arg0.passive_amount, 2);
        arg0.delegated_amount = arg1;
        arg0.passive_amount = arg0.passive_amount - arg1;
        arg1
    }

    public fun get_accumulated_yield(arg0: &VaultDelegationTracker) : u64 {
        arg0.accumulated_yield
    }

    public fun get_delegated_amount(arg0: &VaultDelegationTracker) : u64 {
        arg0.delegated_amount
    }

    public fun get_delegation_info(arg0: &VaultDelegationTracker) : (0x1::option::Option<0x2::object::ID>, u64, u64, u64, bool, u64) {
        (arg0.hedgeswap_vault_id, arg0.delegated_amount, arg0.passive_amount, arg0.total_collateral, arg0.is_active, arg0.accumulated_yield)
    }

    public fun get_hedgeswap_config(arg0: &IntegrationRegistry) : (address, address, u64, u64) {
        (arg0.hedgeswap_whitelist_address, arg0.hedgeswap_module_address, arg0.total_delegations, arg0.total_delegated_value)
    }

    public fun get_passive_amount(arg0: &VaultDelegationTracker) : u64 {
        arg0.passive_amount
    }

    public fun get_total_collateral(arg0: &VaultDelegationTracker) : u64 {
        arg0.total_collateral
    }

    public entry fun harvest_yield(arg0: &mut VaultDelegationTracker, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.borrower, 1);
        assert!(arg0.is_active, 4);
        arg0.accumulated_yield = arg0.accumulated_yield + arg1;
        let v0 = YieldClaimed{
            loan_vault_id : arg0.loan_vault_id,
            borrower      : arg0.borrower,
            yield_amount  : arg1,
            timestamp     : 0x2::clock::timestamp_ms(arg2) / 1000,
        };
        0x2::event::emit<YieldClaimed>(v0);
    }

    public fun has_active_delegation(arg0: &VaultDelegationTracker) : bool {
        arg0.is_active
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = IntegrationRegistry{
            id                          : 0x2::object::new(arg0),
            hedgeswap_whitelist_address : @0x0,
            hedgeswap_module_address    : @0x0,
            total_delegations           : 0,
            total_delegated_value       : 0,
            admin                       : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<IntegrationRegistry>(v0);
    }

    public fun initialize_delegation_tracker(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : VaultDelegationTracker {
        VaultDelegationTracker{
            id                   : 0x2::object::new(arg3),
            loan_vault_id        : arg0,
            borrower             : arg1,
            hedgeswap_vault_id   : 0x1::option::none<0x2::object::ID>(),
            delegated_amount     : 0,
            passive_amount       : arg2,
            total_collateral     : arg2,
            delegation_timestamp : 0,
            is_active            : false,
            accumulated_yield    : 0,
        }
    }

    public fun initiate_undelegation(arg0: &mut IntegrationRegistry, arg1: &mut VaultDelegationTracker, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, u64) {
        assert!(0x2::tx_context::sender(arg3) == arg1.borrower, 1);
        assert!(arg1.is_active, 4);
        (*0x1::option::borrow<0x2::object::ID>(&arg1.hedgeswap_vault_id), arg1.delegated_amount)
    }

    // decompiled from Move bytecode v6
}

