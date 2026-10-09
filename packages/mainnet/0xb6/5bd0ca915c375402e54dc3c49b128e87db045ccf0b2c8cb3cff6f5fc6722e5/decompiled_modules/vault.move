module 0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::vault {
    struct AllocationTarget has copy, drop, store {
        asset_type: 0x1::type_name::TypeName,
        target_bps: u64,
    }

    struct BalanceKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct PortfolioVault has key {
        id: 0x2::object::UID,
        owner_address: address,
        target_allocations: vector<AllocationTarget>,
        rebalance_threshold: u64,
        balances: 0x2::bag::Bag,
        active_coin_types: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        obligation_cap: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>,
        lending_market_id: 0x2::object::ID,
        version: u64,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
    }

    struct Deposited has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct Withdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct EmergencyWithdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct LendPositionReleased has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        obligation_id: 0x2::object::ID,
    }

    struct LendPositionInitialized has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        obligation_id: 0x2::object::ID,
        lending_market_id: 0x2::object::ID,
    }

    struct SessionKeyGranted has copy, drop {
        vault_id: 0x2::object::ID,
        key_id: 0x2::object::ID,
        agent_address: address,
        expiry_epoch: u64,
        allowed_actions: u8,
    }

    public fun extract<T0>(arg0: &mut 0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::session::RebalanceProof, arg1: &mut PortfolioVault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::version::assert_is_current(arg1.version);
        assert!(0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::session::proof_vault_id(arg0) == 0x2::object::id<PortfolioVault>(arg1), 5);
        assert!(0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::session::proof_allowed_actions(arg0) & (0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::session::action_swap() | 0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::session::action_lend()) != 0, 6);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let (_, v2, v3) = 0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::session::proof_find_price(arg0, v0);
        0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::session::proof_add_debt(arg0, 0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::math::mul_ceil(0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::math::to_fixed_amount(arg2, v3), v2));
        0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::session::proof_record_extracted(arg0, v0, arg2);
        assert!(0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::session::proof_debt_value(arg0) <= 0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::session::proof_notional_ceiling(arg0), 7);
        0x2::coin::from_balance<T0>(take_balance_internal<T0>(arg1, arg2), arg3)
    }

    public(friend) fun version_of(arg0: &PortfolioVault) : u64 {
        arg0.version
    }

    public fun active_coin_types(arg0: &PortfolioVault) : vector<0x1::type_name::TypeName> {
        *0x2::vec_set::keys<0x1::type_name::TypeName>(&arg0.active_coin_types)
    }

    public(friend) fun assert_holds_obligation_cap(arg0: &PortfolioVault) {
        if (0x1::option::is_some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(&arg0.obligation_cap)) {
            return
        } else {
            assert!(lend_position_ever_initialized(arg0), 19);
            abort 18
        };
    }

    public(friend) fun assert_lend_position_initialized(arg0: &PortfolioVault) {
        assert!(lend_position_ever_initialized(arg0), 19);
    }

    fun assert_may_add_type<T0>(arg0: &PortfolioVault, arg1: &0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::policy::PolicyRegistry, arg2: address) {
        let v0 = BalanceKey<T0>{dummy_field: false};
        let v1 = if (0x2::bag::contains<BalanceKey<T0>>(&arg0.balances, v0)) {
            true
        } else if (arg2 == arg0.owner_address) {
            true
        } else {
            0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::policy::is_priced_token(arg1, 0x1::type_name::with_defining_ids<T0>())
        };
        assert!(v1, 17);
    }

    public fun balance_of<T0>(arg0: &PortfolioVault) : u64 {
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (0x2::bag::contains<BalanceKey<T0>>(&arg0.balances, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&arg0.balances, v0))
        } else {
            0
        }
    }

    public(friend) fun borrow_obligation_cap(arg0: &PortfolioVault) : &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL> {
        assert_holds_obligation_cap(arg0);
        0x1::option::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(&arg0.obligation_cap)
    }

    public fun create_vault(arg0: vector<AllocationTarget>, arg1: u64, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(sum_bps(&arg0) == 10000, 1);
        assert!(arg1 <= 10000, 2);
        let v0 = 0x2::object::new(arg3);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = PortfolioVault{
            id                  : v0,
            owner_address       : v1,
            target_allocations  : arg0,
            rebalance_threshold : arg1,
            balances            : 0x2::bag::new(arg3),
            active_coin_types   : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            obligation_cap      : 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg2, arg3)),
            lending_market_id   : 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(arg2),
            version             : 0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::version::current(),
        };
        0x2::transfer::share_object<PortfolioVault>(v2);
        let v3 = VaultCreated{
            vault_id : 0x2::object::uid_to_inner(&v0),
            owner    : v1,
        };
        0x2::event::emit<VaultCreated>(v3);
    }

    public fun create_vault_unlent(arg0: vector<AllocationTarget>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(sum_bps(&arg0) == 10000, 1);
        assert!(arg1 <= 10000, 2);
        let v0 = 0x2::object::new(arg2);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = PortfolioVault{
            id                  : v0,
            owner_address       : v1,
            target_allocations  : arg0,
            rebalance_threshold : arg1,
            balances            : 0x2::bag::new(arg2),
            active_coin_types   : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            obligation_cap      : 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(),
            lending_market_id   : unlent_market_sentinel(),
            version             : 0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::version::current(),
        };
        0x2::transfer::share_object<PortfolioVault>(v2);
        let v3 = VaultCreated{
            vault_id : 0x2::object::uid_to_inner(&v0),
            owner    : v1,
        };
        0x2::event::emit<VaultCreated>(v3);
    }

    public fun deposit<T0>(arg0: &mut PortfolioVault, arg1: &0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::policy::PolicyRegistry, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::version::assert_is_current(arg0.version);
        0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::version::assert_is_current(0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::policy::version_of(arg1));
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 16);
        assert_may_add_type<T0>(arg0, arg1, 0x2::tx_context::sender(arg3));
        put_balance_internal<T0>(arg0, 0x2::coin::into_balance<T0>(arg2));
        let v1 = Deposited{
            vault_id  : 0x2::object::id<PortfolioVault>(arg0),
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            amount    : v0,
        };
        0x2::event::emit<Deposited>(v1);
    }

    public fun deposit_back<T0>(arg0: &mut 0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::session::RebalanceProof, arg1: &mut PortfolioVault, arg2: 0x2::coin::Coin<T0>) {
        0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::version::assert_is_current(arg1.version);
        assert!(0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::session::proof_vault_id(arg0) == 0x2::object::id<PortfolioVault>(arg1), 5);
        assert!(0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::session::proof_allowed_actions(arg0) & 0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::session::action_swap() != 0, 6);
        let (v0, _, v2) = 0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::session::proof_find_price(arg0, 0x1::type_name::with_defining_ids<T0>());
        let v3 = 0x2::coin::value<T0>(&arg2);
        assert!(v3 > 0, 16);
        0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::session::proof_add_settled(arg0, 0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::math::mul_floor(0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::math::to_fixed_amount(v3, v2), v0));
        put_balance_internal<T0>(arg1, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun emergency_withdraw_all<T0>(arg0: &mut PortfolioVault, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner_address, 3);
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (0x2::bag::contains<BalanceKey<T0>>(&arg0.balances, v0)) {
            let v1 = 0x2::bag::remove<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0);
            let v2 = 0x2::balance::value<T0>(&v1);
            if (v2 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg1), arg0.owner_address);
            } else {
                0x2::balance::destroy_zero<T0>(v1);
            };
            let v3 = 0x1::type_name::with_defining_ids<T0>();
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.active_coin_types, &v3);
            let v4 = EmergencyWithdrawn{
                vault_id  : 0x2::object::id<PortfolioVault>(arg0),
                coin_type : 0x1::type_name::with_defining_ids<T0>(),
                amount    : v2,
            };
            0x2::event::emit<EmergencyWithdrawn>(v4);
        };
    }

    public fun grant_session_key(arg0: &PortfolioVault, arg1: &mut 0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::policy::PolicyRegistry, arg2: address, arg3: u64, arg4: vector<0x1::type_name::TypeName>, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg10) == arg0.owner_address, 3);
        assert!(arg5 & 0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::session::action_withdraw_to_owner() == 0, 8);
        assert!(arg3 > 0x2::tx_context::epoch(arg10), 9);
        assert!(!0x1::vector::is_empty<0x1::type_name::TypeName>(&arg4), 12);
        assert!(arg5 != 0 && arg5 & (0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::session::action_swap() | 0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::session::action_lend()) == arg5, 13);
        assert!(arg6 > 0 && arg8 >= arg6, 11);
        assert!(arg7 > 0, 10);
        assert!(arg9 > 0 && arg9 <= 0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::session::max_slippage_bps_ceiling_limit(), 14);
        let v0 = 0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::session::new_session_key(0x2::object::id<PortfolioVault>(arg0), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let v1 = 0x2::object::id<0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::session::SessionKey>(&v0);
        0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::policy::record_owner(arg1, v1, arg0.owner_address);
        0x2::transfer::public_transfer<0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::session::SessionKey>(v0, arg2);
        let v2 = SessionKeyGranted{
            vault_id        : 0x2::object::id<PortfolioVault>(arg0),
            key_id          : v1,
            agent_address   : arg2,
            expiry_epoch    : arg3,
            allowed_actions : arg5,
        };
        0x2::event::emit<SessionKeyGranted>(v2);
    }

    public fun holds_obligation_cap(arg0: &PortfolioVault) : bool {
        0x1::option::is_some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(&arg0.obligation_cap)
    }

    public fun init_lend_position(arg0: &mut PortfolioVault, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: &mut 0x2::tx_context::TxContext) {
        0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::version::assert_is_current(arg0.version);
        assert!(0x2::tx_context::sender(arg2) == arg0.owner_address, 3);
        assert!(!lend_position_ever_initialized(arg0), 20);
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg1, arg2);
        let v1 = 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(arg1);
        0x1::option::fill<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(&mut arg0.obligation_cap, v0);
        arg0.lending_market_id = v1;
        let v2 = LendPositionInitialized{
            vault_id          : 0x2::object::id<PortfolioVault>(arg0),
            owner             : arg0.owner_address,
            obligation_id     : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(&v0),
            lending_market_id : v1,
        };
        0x2::event::emit<LendPositionInitialized>(v2);
    }

    public fun lend_position_ever_initialized(arg0: &PortfolioVault) : bool {
        arg0.lending_market_id != unlent_market_sentinel()
    }

    public fun lending_market_id(arg0: &PortfolioVault) : 0x2::object::ID {
        arg0.lending_market_id
    }

    public fun new_allocation_target(arg0: 0x1::type_name::TypeName, arg1: u64) : AllocationTarget {
        AllocationTarget{
            asset_type : arg0,
            target_bps : arg1,
        }
    }

    public fun owner_address(arg0: &PortfolioVault) : address {
        arg0.owner_address
    }

    fun prune_if_empty<T0>(arg0: &mut PortfolioVault) {
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (0x2::bag::contains<BalanceKey<T0>>(&arg0.balances, v0)) {
            if (0x2::balance::value<T0>(0x2::bag::borrow<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&arg0.balances, v0)) == 0) {
                0x2::balance::destroy_zero<T0>(0x2::bag::remove<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0));
                let v1 = 0x1::type_name::with_defining_ids<T0>();
                0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.active_coin_types, &v1);
            };
        };
    }

    public(friend) fun put_balance<T0>(arg0: &mut PortfolioVault, arg1: 0x2::balance::Balance<T0>) {
        put_balance_internal<T0>(arg0, arg1);
    }

    fun put_balance_internal<T0>(arg0: &mut PortfolioVault, arg1: 0x2::balance::Balance<T0>) {
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (0x2::bag::contains<BalanceKey<T0>>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1);
        } else {
            assert!(0x2::vec_set::length<0x1::type_name::TypeName>(&arg0.active_coin_types) < 16, 15);
            0x2::bag::add<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, arg1);
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.active_coin_types, 0x1::type_name::with_defining_ids<T0>());
        };
    }

    public fun receive_accumulated_deposit<T0>(arg0: &mut PortfolioVault, arg1: &0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::policy::PolicyRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::version::assert_is_current(arg0.version);
        0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::version::assert_is_current(0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::policy::version_of(arg1));
        if (arg2 == 0) {
            return
        };
        assert_may_add_type<T0>(arg0, arg1, 0x2::tx_context::sender(arg3));
        let v0 = 0x2::balance::redeem_funds<T0>(0x2::balance::withdraw_funds_from_object<T0>(&mut arg0.id, arg2));
        put_balance_internal<T0>(arg0, v0);
        let v1 = Deposited{
            vault_id  : 0x2::object::id<PortfolioVault>(arg0),
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            amount    : arg2,
        };
        0x2::event::emit<Deposited>(v1);
    }

    public fun receive_bridged_deposit<T0>(arg0: &mut PortfolioVault, arg1: &0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::policy::PolicyRegistry, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg3: &0x2::tx_context::TxContext) {
        0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::version::assert_is_current(arg0.version);
        0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::version::assert_is_current(0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::policy::version_of(arg1));
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg2);
        let v1 = 0x2::coin::value<T0>(&v0);
        if (v1 == 0) {
            0x2::coin::destroy_zero<T0>(v0);
            return
        };
        assert_may_add_type<T0>(arg0, arg1, 0x2::tx_context::sender(arg3));
        put_balance_internal<T0>(arg0, 0x2::coin::into_balance<T0>(v0));
        let v2 = Deposited{
            vault_id  : 0x2::object::id<PortfolioVault>(arg0),
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            amount    : v1,
        };
        0x2::event::emit<Deposited>(v2);
    }

    public fun receive_to_owner<T0>(arg0: &mut PortfolioVault, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner_address, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1), arg0.owner_address);
    }

    public fun release_lend_position(arg0: &mut PortfolioVault, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner_address, 3);
        assert!(0x1::option::is_some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(&arg0.obligation_cap), 18);
        let v0 = 0x1::option::extract<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(&mut arg0.obligation_cap);
        let v1 = arg0.owner_address;
        0x2::transfer::public_transfer<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(v0, v1);
        let v2 = LendPositionReleased{
            vault_id      : 0x2::object::id<PortfolioVault>(arg0),
            owner         : v1,
            obligation_id : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(&v0),
        };
        0x2::event::emit<LendPositionReleased>(v2);
    }

    fun sum_bps(arg0: &vector<AllocationTarget>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<AllocationTarget>(arg0)) {
            v0 = v0 + 0x1::vector::borrow<AllocationTarget>(arg0, v1).target_bps;
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun take_balance<T0>(arg0: &mut PortfolioVault, arg1: u64) : 0x2::balance::Balance<T0> {
        take_balance_internal<T0>(arg0, arg1)
    }

    fun take_balance_internal<T0>(arg0: &mut PortfolioVault, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = BalanceKey<T0>{dummy_field: false};
        assert!(0x2::bag::contains<BalanceKey<T0>>(&arg0.balances, v0), 4);
        let v1 = 0x2::bag::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg1, 4);
        0x2::balance::split<T0>(v1, arg1)
    }

    fun unlent_market_sentinel() : 0x2::object::ID {
        0x2::object::id_from_address(@0x0)
    }

    public fun withdraw<T0>(arg0: &mut PortfolioVault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::version::assert_is_current(arg0.version);
        assert!(0x2::tx_context::sender(arg2) == arg0.owner_address, 3);
        let v0 = take_balance_internal<T0>(arg0, arg1);
        let v1 = 0x2::object::id<PortfolioVault>(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg2), arg0.owner_address);
        prune_if_empty<T0>(arg0);
        let v2 = Withdrawn{
            vault_id  : v1,
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            amount    : arg1,
        };
        0x2::event::emit<Withdrawn>(v2);
    }

    // decompiled from Move bytecode v7
}

