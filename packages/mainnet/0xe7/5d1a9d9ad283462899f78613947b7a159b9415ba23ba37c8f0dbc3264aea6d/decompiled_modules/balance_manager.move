module 0xe75d1a9d9ad283462899f78613947b7a159b9415ba23ba37c8f0dbc3264aea6d::balance_manager {
    struct BalanceManager has store, key {
        id: 0x2::object::UID,
        owner: address,
        balances: 0x2::bag::Bag,
        allow_listed: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct BalanceManagerEvent has copy, drop {
        balance_manager_id: 0x2::object::ID,
        owner: address,
    }

    struct BalanceEvent has copy, drop {
        balance_manager_id: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        deposit: bool,
    }

    struct BalanceKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct ReferralKey has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    struct TradeCap has store, key {
        id: 0x2::object::UID,
        balance_manager_id: 0x2::object::ID,
    }

    struct DepositCap has store, key {
        id: 0x2::object::UID,
        balance_manager_id: 0x2::object::ID,
    }

    struct WithdrawCap has store, key {
        id: 0x2::object::UID,
        balance_manager_id: 0x2::object::ID,
    }

    struct DeepBookReferral has store, key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct DeepBookPoolReferral has store, key {
        id: 0x2::object::UID,
        owner: address,
        pool_id: 0x2::object::ID,
    }

    struct DeepBookReferralCreatedEvent has copy, drop {
        referral_id: 0x2::object::ID,
        owner: address,
    }

    struct DeepBookReferralSetEvent has copy, drop {
        referral_id: 0x2::object::ID,
        balance_manager_id: 0x2::object::ID,
    }

    struct TradeProof has drop {
        balance_manager_id: 0x2::object::ID,
        trader: address,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : BalanceManager {
        let v0 = 0x2::object::new(arg0);
        let v1 = BalanceManagerEvent{
            balance_manager_id : 0x2::object::uid_to_inner(&v0),
            owner              : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<BalanceManagerEvent>(v1);
        BalanceManager{
            id           : v0,
            owner        : 0x2::tx_context::sender(arg0),
            balances     : 0x2::bag::new(arg0),
            allow_listed : 0x2::vec_set::empty<0x2::object::ID>(),
        }
    }

    public fun balance<T0>(arg0: &BalanceManager) : u64 {
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (!0x2::bag::contains<BalanceKey<T0>>(&arg0.balances, v0)) {
            0
        } else {
            0x2::balance::value<T0>(0x2::bag::borrow<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&arg0.balances, v0))
        }
    }

    public(friend) fun delete(arg0: BalanceManager) {
        let BalanceManager {
            id           : v0,
            owner        : _,
            balances     : v2,
            allow_listed : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::bag::destroy_empty(v2);
    }

    public fun id(arg0: &BalanceManager) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun assert_referral_owner(arg0: &DeepBookPoolReferral, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 6);
    }

    public fun balance_manager_referral_owner(arg0: &DeepBookPoolReferral) : address {
        arg0.owner
    }

    public fun balance_manager_referral_pool_id(arg0: &DeepBookPoolReferral) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun deposit<T0>(arg0: &mut BalanceManager, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        emit_balance_event(arg0, 0x1::type_name::with_defining_ids<T0>(), 0x2::coin::value<T0>(&arg1), true);
        let v0 = generate_proof_as_owner(arg0, arg2);
        deposit_with_proof<T0>(arg0, &v0, 0x2::coin::into_balance<T0>(arg1));
    }

    public(friend) fun deposit_permissionless<T0>(arg0: &mut BalanceManager, arg1: 0x2::balance::Balance<T0>) {
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (0x2::bag::contains<BalanceKey<T0>>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1);
        } else {
            0x2::bag::add<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, arg1);
        };
    }

    public fun deposit_with_cap<T0>(arg0: &mut BalanceManager, arg1: &DepositCap, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        emit_balance_event(arg0, 0x1::type_name::with_defining_ids<T0>(), 0x2::coin::value<T0>(&arg2), true);
        let v0 = generate_proof_as_depositor(arg0, arg1, arg3);
        deposit_with_proof<T0>(arg0, &v0, 0x2::coin::into_balance<T0>(arg2));
    }

    public(friend) fun deposit_with_proof<T0>(arg0: &mut BalanceManager, arg1: &TradeProof, arg2: 0x2::balance::Balance<T0>) {
        validate_proof(arg0, arg1);
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (0x2::bag::contains<BalanceKey<T0>>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg2);
        } else {
            0x2::bag::add<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, arg2);
        };
    }

    public(friend) fun emit_balance_event(arg0: &BalanceManager, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: bool) {
        let v0 = BalanceEvent{
            balance_manager_id : id(arg0),
            asset              : arg1,
            amount             : arg2,
            deposit            : arg3,
        };
        0x2::event::emit<BalanceEvent>(v0);
    }

    public(friend) fun generate_proof_as_depositor(arg0: &BalanceManager, arg1: &DepositCap, arg2: &0x2::tx_context::TxContext) : TradeProof {
        validate_deposit_cap(arg0, arg1);
        TradeProof{
            balance_manager_id : 0x2::object::id<BalanceManager>(arg0),
            trader             : 0x2::tx_context::sender(arg2),
        }
    }

    public fun generate_proof_as_owner(arg0: &mut BalanceManager, arg1: &0x2::tx_context::TxContext) : TradeProof {
        validate_owner(arg0, arg1);
        TradeProof{
            balance_manager_id : 0x2::object::id<BalanceManager>(arg0),
            trader             : 0x2::tx_context::sender(arg1),
        }
    }

    public fun generate_proof_as_trader(arg0: &mut BalanceManager, arg1: &TradeCap, arg2: &0x2::tx_context::TxContext) : TradeProof {
        validate_trader(arg0, arg1);
        TradeProof{
            balance_manager_id : 0x2::object::id<BalanceManager>(arg0),
            trader             : 0x2::tx_context::sender(arg2),
        }
    }

    public(friend) fun generate_proof_as_withdrawer(arg0: &BalanceManager, arg1: &WithdrawCap, arg2: &0x2::tx_context::TxContext) : TradeProof {
        validate_withdraw_cap(arg0, arg1);
        TradeProof{
            balance_manager_id : 0x2::object::id<BalanceManager>(arg0),
            trader             : 0x2::tx_context::sender(arg2),
        }
    }

    public fun get_balance_manager_referral_id(arg0: &BalanceManager, arg1: 0x2::object::ID) : 0x1::option::Option<0x2::object::ID> {
        let v0 = ReferralKey{pos0: arg1};
        if (!0x2::dynamic_field::exists_<ReferralKey>(&arg0.id, v0)) {
            return 0x1::option::none<0x2::object::ID>()
        };
        0x1::option::some<0x2::object::ID>(*0x2::dynamic_field::borrow<ReferralKey, 0x2::object::ID>(&arg0.id, v0))
    }

    public fun get_referral_id(arg0: &BalanceManager) : 0x1::option::Option<0x2::object::ID> {
        abort 13906835853675593727
    }

    public fun mint_deposit_cap(arg0: &mut BalanceManager, arg1: &mut 0x2::tx_context::TxContext) : DepositCap {
        validate_owner(arg0, arg1);
        mint_deposit_cap_internal(arg0, arg1)
    }

    fun mint_deposit_cap_internal(arg0: &mut BalanceManager, arg1: &mut 0x2::tx_context::TxContext) : DepositCap {
        assert!(0x2::vec_set::length<0x2::object::ID>(&arg0.allow_listed) < 1000, 4);
        let v0 = 0x2::object::new(arg1);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.allow_listed, 0x2::object::uid_to_inner(&v0));
        DepositCap{
            id                 : v0,
            balance_manager_id : 0x2::object::id<BalanceManager>(arg0),
        }
    }

    public(friend) fun mint_referral(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = DeepBookPoolReferral{
            id      : v0,
            owner   : 0x2::tx_context::sender(arg1),
            pool_id : arg0,
        };
        let v3 = DeepBookReferralCreatedEvent{
            referral_id : v1,
            owner       : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<DeepBookReferralCreatedEvent>(v3);
        0x2::transfer::share_object<DeepBookPoolReferral>(v2);
        v1
    }

    public fun mint_trade_cap(arg0: &mut BalanceManager, arg1: &mut 0x2::tx_context::TxContext) : TradeCap {
        validate_owner(arg0, arg1);
        mint_trade_cap_internal(arg0, arg1)
    }

    fun mint_trade_cap_internal(arg0: &mut BalanceManager, arg1: &mut 0x2::tx_context::TxContext) : TradeCap {
        assert!(0x2::vec_set::length<0x2::object::ID>(&arg0.allow_listed) < 1000, 4);
        let v0 = 0x2::object::new(arg1);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.allow_listed, 0x2::object::uid_to_inner(&v0));
        TradeCap{
            id                 : v0,
            balance_manager_id : 0x2::object::id<BalanceManager>(arg0),
        }
    }

    public fun mint_withdraw_cap(arg0: &mut BalanceManager, arg1: &mut 0x2::tx_context::TxContext) : WithdrawCap {
        validate_owner(arg0, arg1);
        mint_withdraw_cap_internal(arg0, arg1)
    }

    fun mint_withdraw_cap_internal(arg0: &mut BalanceManager, arg1: &mut 0x2::tx_context::TxContext) : WithdrawCap {
        assert!(0x2::vec_set::length<0x2::object::ID>(&arg0.allow_listed) < 1000, 4);
        let v0 = 0x2::object::new(arg1);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.allow_listed, 0x2::object::uid_to_inner(&v0));
        WithdrawCap{
            id                 : v0,
            balance_manager_id : 0x2::object::id<BalanceManager>(arg0),
        }
    }

    public fun new_with_custom_owner(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : BalanceManager {
        let v0 = 0x2::object::new(arg1);
        let v1 = BalanceManagerEvent{
            balance_manager_id : 0x2::object::uid_to_inner(&v0),
            owner              : arg0,
        };
        0x2::event::emit<BalanceManagerEvent>(v1);
        BalanceManager{
            id           : v0,
            owner        : arg0,
            balances     : 0x2::bag::new(arg1),
            allow_listed : 0x2::vec_set::empty<0x2::object::ID>(),
        }
    }

    public fun new_with_custom_owner_and_caps(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : (BalanceManager, DepositCap, WithdrawCap, TradeCap) {
        abort 1337
    }

    public fun new_with_custom_owner_caps<T0: drop>(arg0: &0xe75d1a9d9ad283462899f78613947b7a159b9415ba23ba37c8f0dbc3264aea6d::registry::Registry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : (BalanceManager, DepositCap, WithdrawCap, TradeCap) {
        0xe75d1a9d9ad283462899f78613947b7a159b9415ba23ba37c8f0dbc3264aea6d::registry::assert_app_is_authorized<T0>(arg0);
        let v0 = new_with_custom_owner(arg1, arg2);
        let v1 = &mut v0;
        let v2 = mint_deposit_cap_internal(v1, arg2);
        let v3 = &mut v0;
        let v4 = mint_withdraw_cap_internal(v3, arg2);
        let v5 = &mut v0;
        (v0, v2, v4, mint_trade_cap_internal(v5, arg2))
    }

    public fun new_with_owner(arg0: &mut 0x2::tx_context::TxContext, arg1: address) : BalanceManager {
        abort 1337
    }

    public fun owner(arg0: &BalanceManager) : address {
        arg0.owner
    }

    public fun referral_owner(arg0: &DeepBookReferral) : address {
        abort 13906835995409514495
    }

    public fun register_balance_manager(arg0: &BalanceManager, arg1: &mut 0xe75d1a9d9ad283462899f78613947b7a159b9415ba23ba37c8f0dbc3264aea6d::registry::Registry, arg2: &mut 0x2::tx_context::TxContext) {
        validate_owner(arg0, arg2);
        0xe75d1a9d9ad283462899f78613947b7a159b9415ba23ba37c8f0dbc3264aea6d::registry::add_balance_manager(arg1, owner(arg0), id(arg0));
    }

    public fun register_manager(arg0: &BalanceManager, arg1: &mut 0xe75d1a9d9ad283462899f78613947b7a159b9415ba23ba37c8f0dbc3264aea6d::registry::Registry) {
        abort 1337
    }

    public fun revoke_trade_cap(arg0: &mut BalanceManager, arg1: &0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        validate_owner(arg0, arg2);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allow_listed, arg1), 5);
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.allow_listed, arg1);
    }

    public fun set_balance_manager_referral(arg0: &mut BalanceManager, arg1: &DeepBookPoolReferral, arg2: &TradeCap) {
        validate_trader(arg0, arg2);
        let v0 = ReferralKey{pos0: arg1.pool_id};
        0x2::dynamic_field::remove_if_exists<ReferralKey, 0x2::object::ID>(&mut arg0.id, v0);
        let v1 = ReferralKey{pos0: arg1.pool_id};
        0x2::dynamic_field::add<ReferralKey, 0x2::object::ID>(&mut arg0.id, v1, 0x2::object::uid_to_inner(&arg1.id));
        let v2 = DeepBookReferralSetEvent{
            referral_id        : 0x2::object::uid_to_inner(&arg1.id),
            balance_manager_id : 0x2::object::uid_to_inner(&arg0.id),
        };
        0x2::event::emit<DeepBookReferralSetEvent>(v2);
    }

    public fun set_referral(arg0: &mut BalanceManager, arg1: &DeepBookReferral, arg2: &TradeCap) {
        abort 13906834947437494271
    }

    public(friend) fun trader(arg0: &TradeProof) : address {
        arg0.trader
    }

    public fun unset_balance_manager_referral(arg0: &mut BalanceManager, arg1: 0x2::object::ID, arg2: &TradeCap) {
        validate_trader(arg0, arg2);
        let v0 = ReferralKey{pos0: arg1};
        0x2::dynamic_field::remove_if_exists<ReferralKey, 0x2::object::ID>(&mut arg0.id, v0);
        let v1 = DeepBookReferralSetEvent{
            referral_id        : 0x2::object::id_from_address(@0x0),
            balance_manager_id : 0x2::object::uid_to_inner(&arg0.id),
        };
        0x2::event::emit<DeepBookReferralSetEvent>(v1);
    }

    public fun unset_referral(arg0: &mut BalanceManager, arg1: &TradeCap) {
        abort 13906835033336840191
    }

    fun validate_deposit_cap(arg0: &BalanceManager, arg1: &DepositCap) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allow_listed, 0x2::object::borrow_id<DepositCap>(arg1)), 1);
    }

    fun validate_owner(arg0: &BalanceManager, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == owner(arg0), 0);
    }

    public fun validate_proof(arg0: &BalanceManager, arg1: &TradeProof) {
        assert!(0x2::object::id<BalanceManager>(arg0) == arg1.balance_manager_id, 2);
    }

    fun validate_trader(arg0: &BalanceManager, arg1: &TradeCap) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allow_listed, 0x2::object::borrow_id<TradeCap>(arg1)), 1);
    }

    fun validate_withdraw_cap(arg0: &BalanceManager, arg1: &WithdrawCap) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allow_listed, 0x2::object::borrow_id<WithdrawCap>(arg1)), 1);
    }

    public fun withdraw<T0>(arg0: &mut BalanceManager, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = generate_proof_as_owner(arg0, arg2);
        let v1 = withdraw_with_proof<T0>(arg0, &v0, arg1, false);
        let v2 = 0x2::coin::from_balance<T0>(v1, arg2);
        emit_balance_event(arg0, 0x1::type_name::with_defining_ids<T0>(), 0x2::coin::value<T0>(&v2), false);
        v2
    }

    public fun withdraw_all<T0>(arg0: &mut BalanceManager, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = generate_proof_as_owner(arg0, arg1);
        let v1 = withdraw_with_proof<T0>(arg0, &v0, 0, true);
        let v2 = 0x2::coin::from_balance<T0>(v1, arg1);
        emit_balance_event(arg0, 0x1::type_name::with_defining_ids<T0>(), 0x2::coin::value<T0>(&v2), false);
        v2
    }

    public fun withdraw_with_cap<T0>(arg0: &mut BalanceManager, arg1: &WithdrawCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = generate_proof_as_withdrawer(arg0, arg1, arg3);
        let v1 = withdraw_with_proof<T0>(arg0, &v0, arg2, false);
        let v2 = 0x2::coin::from_balance<T0>(v1, arg3);
        emit_balance_event(arg0, 0x1::type_name::with_defining_ids<T0>(), 0x2::coin::value<T0>(&v2), false);
        v2
    }

    public(friend) fun withdraw_with_proof<T0>(arg0: &mut BalanceManager, arg1: &TradeProof, arg2: u64, arg3: bool) : 0x2::balance::Balance<T0> {
        validate_proof(arg0, arg1);
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (!0x2::bag::contains<BalanceKey<T0>>(&arg0.balances, v0)) {
            0x2::bag::add<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, 0x2::balance::zero<T0>());
        };
        if (arg3) {
            0x2::bag::remove<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0)
        } else {
            let v2 = 0x2::bag::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0);
            let v3 = 0x2::balance::value<T0>(v2);
            assert!(v3 >= arg2, 3);
            if (arg2 == v3) {
                0x2::bag::remove<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0)
            } else {
                0x2::balance::split<T0>(v2, arg2)
            }
        }
    }

    // decompiled from Move bytecode v6
}

