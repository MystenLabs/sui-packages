module 0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::vault {
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

    struct SessionKeyGranted has copy, drop {
        vault_id: 0x2::object::ID,
        key_id: 0x2::object::ID,
        agent_address: address,
        expiry_epoch: u64,
        allowed_actions: u8,
    }

    public fun active_coin_types(arg0: &PortfolioVault) : vector<0x1::type_name::TypeName> {
        *0x2::vec_set::keys<0x1::type_name::TypeName>(&arg0.active_coin_types)
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
            version             : 0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::version::current(),
        };
        0x2::transfer::share_object<PortfolioVault>(v2);
        let v3 = VaultCreated{
            vault_id : 0x2::object::uid_to_inner(&v0),
            owner    : v1,
        };
        0x2::event::emit<VaultCreated>(v3);
    }

    public fun deposit<T0>(arg0: &mut PortfolioVault, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::version::assert_is_current(arg0.version);
        put_balance_internal<T0>(arg0, 0x2::coin::into_balance<T0>(arg1));
        let v0 = Deposited{
            vault_id  : 0x2::object::id<PortfolioVault>(arg0),
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            amount    : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<Deposited>(v0);
    }

    public fun deposit_back<T0>(arg0: &mut 0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::session::RebalanceProof, arg1: &mut PortfolioVault, arg2: 0x2::coin::Coin<T0>) {
        0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::version::assert_is_current(arg1.version);
        assert!(0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::session::proof_vault_id(arg0) == 0x2::object::id<PortfolioVault>(arg1), 5);
        assert!(0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::session::proof_allowed_actions(arg0) & 0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::session::action_swap() != 0, 6);
        let (v0, _, v2) = 0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::session::proof_find_price(arg0, 0x1::type_name::with_defining_ids<T0>());
        0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::session::proof_add_settled(arg0, 0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::math::mul_floor(0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::math::to_fixed_amount(0x2::coin::value<T0>(&arg2), v2), v0));
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

    public fun extract<T0>(arg0: &mut 0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::session::RebalanceProof, arg1: &mut PortfolioVault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::version::assert_is_current(arg1.version);
        assert!(0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::session::proof_vault_id(arg0) == 0x2::object::id<PortfolioVault>(arg1), 5);
        assert!(0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::session::proof_allowed_actions(arg0) & (0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::session::action_swap() | 0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::session::action_lend()) != 0, 6);
        let (_, v1, v2) = 0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::session::proof_find_price(arg0, 0x1::type_name::with_defining_ids<T0>());
        0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::session::proof_add_debt(arg0, 0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::math::mul_ceil(0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::math::to_fixed_amount(arg2, v2), v1));
        assert!(0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::session::proof_debt_value(arg0) <= 0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::session::proof_notional_ceiling(arg0), 7);
        0x2::coin::from_balance<T0>(take_balance_internal<T0>(arg1, arg2), arg3)
    }

    public fun grant_session_key(arg0: &PortfolioVault, arg1: &mut 0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::policy::PolicyRegistry, arg2: address, arg3: u64, arg4: vector<0x1::type_name::TypeName>, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg9) == arg0.owner_address, 3);
        assert!(arg5 & 0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::session::action_withdraw_to_owner() == 0, 8);
        let v0 = 0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::session::new_session_key(0x2::object::id<PortfolioVault>(arg0), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v1 = 0x2::object::id<0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::session::SessionKey>(&v0);
        0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::policy::record_owner(arg1, v1, arg0.owner_address);
        0x2::transfer::public_transfer<0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::session::SessionKey>(v0, arg2);
        let v2 = SessionKeyGranted{
            vault_id        : 0x2::object::id<PortfolioVault>(arg0),
            key_id          : v1,
            agent_address   : arg2,
            expiry_epoch    : arg3,
            allowed_actions : arg5,
        };
        0x2::event::emit<SessionKeyGranted>(v2);
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

    public(friend) fun put_balance<T0>(arg0: &mut PortfolioVault, arg1: 0x2::balance::Balance<T0>) {
        put_balance_internal<T0>(arg0, arg1);
    }

    fun put_balance_internal<T0>(arg0: &mut PortfolioVault, arg1: 0x2::balance::Balance<T0>) {
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (0x2::bag::contains<BalanceKey<T0>>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1);
        } else {
            0x2::bag::add<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, arg1);
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.active_coin_types, 0x1::type_name::with_defining_ids<T0>());
        };
    }

    public fun receive_bridged_deposit<T0>(arg0: &mut PortfolioVault, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg2: &mut 0x2::tx_context::TxContext) {
        0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::version::assert_is_current(arg0.version);
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1);
        put_balance_internal<T0>(arg0, 0x2::coin::into_balance<T0>(v0));
        let v1 = Deposited{
            vault_id  : 0x2::object::id<PortfolioVault>(arg0),
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            amount    : 0x2::coin::value<T0>(&v0),
        };
        0x2::event::emit<Deposited>(v1);
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

    public(friend) fun version_of(arg0: &PortfolioVault) : u64 {
        arg0.version
    }

    public fun withdraw<T0>(arg0: &mut PortfolioVault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::version::assert_is_current(arg0.version);
        assert!(0x2::tx_context::sender(arg2) == arg0.owner_address, 3);
        let v0 = take_balance_internal<T0>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg2), arg0.owner_address);
        let v1 = Withdrawn{
            vault_id  : 0x2::object::id<PortfolioVault>(arg0),
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            amount    : arg1,
        };
        0x2::event::emit<Withdrawn>(v1);
    }

    // decompiled from Move bytecode v7
}

