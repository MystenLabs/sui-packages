module 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation {
    struct Obligation has store, key {
        id: 0x2::object::UID,
        balances: 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::balance_bag::BalanceBag,
        debts: 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::WitTable<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_debts::ObligationDebts, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_debts::Debt>,
        collaterals: 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::WitTable<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_collaterals::ObligationCollaterals, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_collaterals::Collateral>,
        rewards_point: u64,
        lock_key: 0x1::option::Option<0x1::type_name::TypeName>,
        borrow_locked: bool,
        repay_locked: bool,
        deposit_collateral_locked: bool,
        withdraw_collateral_locked: bool,
        liquidate_locked: bool,
    }

    struct ObligationOwnership has drop {
        dummy_field: bool,
    }

    struct ObligationKey has store, key {
        id: 0x2::object::UID,
        ownership: 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ownership::Ownership<ObligationOwnership>,
    }

    struct ObligationRewardsPointRedeemed has copy, drop {
        obligation: 0x2::object::ID,
        witness: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct ObligationLocked has copy, drop {
        obligation: 0x2::object::ID,
        witness: 0x1::type_name::TypeName,
        borrow_locked: bool,
        repay_locked: bool,
        deposit_collateral_locked: bool,
        withdraw_collateral_locked: bool,
        liquidate_locked: bool,
    }

    struct ObligationUnlocked has copy, drop {
        obligation: 0x2::object::ID,
        witness: 0x1::type_name::TypeName,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : (Obligation, ObligationKey) {
        let v0 = Obligation{
            id                         : 0x2::object::new(arg0),
            balances                   : 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::balance_bag::new(arg0),
            debts                      : 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_debts::new(arg0),
            collaterals                : 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_collaterals::new(arg0),
            rewards_point              : 0,
            lock_key                   : 0x1::option::none<0x1::type_name::TypeName>(),
            borrow_locked              : false,
            repay_locked               : false,
            deposit_collateral_locked  : false,
            withdraw_collateral_locked : false,
            liquidate_locked           : false,
        };
        let v1 = ObligationOwnership{dummy_field: false};
        let v2 = ObligationKey{
            id        : 0x2::object::new(arg0),
            ownership : 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ownership::create_ownership<ObligationOwnership>(v1, 0x2::object::id<Obligation>(&v0), arg0),
        };
        (v0, v2)
    }

    public fun balance_bag(arg0: &Obligation) : &0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::balance_bag::BalanceBag {
        &arg0.balances
    }

    public(friend) fun accrue_interests_and_rewards(arg0: &mut Obligation, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market) {
        let v0 = debt_types(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v2 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v1);
            arg0.rewards_point = arg0.rewards_point + 0x1::fixed_point32::multiply_u64(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_debts::accrue_interest(&mut arg0.debts, v2, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::borrow_index(arg1, v2)), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::incentive_rewards::reward_factor(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::reward_factor(arg1, v2)));
            v1 = v1 + 1;
        };
    }

    public fun assert_key_match(arg0: &Obligation, arg1: &ObligationKey) {
        0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ownership::assert_owner<ObligationOwnership, Obligation>(&arg1.ownership, arg0);
    }

    public fun borrow_locked(arg0: &Obligation) : bool {
        arg0.borrow_locked
    }

    public fun collateral(arg0: &Obligation, arg1: 0x1::type_name::TypeName) : u64 {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_collaterals::collateral(&arg0.collaterals, arg1)
    }

    public fun collateral_types(arg0: &Obligation) : vector<0x1::type_name::TypeName> {
        0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::keys<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_collaterals::ObligationCollaterals, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_collaterals::Collateral>(&arg0.collaterals)
    }

    public fun collaterals(arg0: &Obligation) : &0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::WitTable<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_collaterals::ObligationCollaterals, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_collaterals::Collateral> {
        &arg0.collaterals
    }

    public fun debt(arg0: &Obligation, arg1: 0x1::type_name::TypeName) : (u64, u64) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_debts::debt(&arg0.debts, arg1)
    }

    public fun debt_types(arg0: &Obligation) : vector<0x1::type_name::TypeName> {
        0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::keys<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_debts::ObligationDebts, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_debts::Debt>(&arg0.debts)
    }

    public fun debts(arg0: &Obligation) : &0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::WitTable<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_debts::ObligationDebts, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_debts::Debt> {
        &arg0.debts
    }

    public(friend) fun decrease_debt(arg0: &mut Obligation, arg1: 0x1::type_name::TypeName, arg2: u64) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_debts::decrease(&mut arg0.debts, arg1, arg2);
    }

    public(friend) fun deposit_collateral<T0>(arg0: &mut Obligation, arg1: 0x2::balance::Balance<T0>) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_collaterals::increase(&mut arg0.collaterals, 0x1::type_name::get<T0>(), 0x2::balance::value<T0>(&arg1));
        if (0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::balance_bag::contains<T0>(&arg0.balances) == false) {
            0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::balance_bag::init_balance<T0>(&mut arg0.balances);
        };
        0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::balance_bag::join<T0>(&mut arg0.balances, arg1);
    }

    public fun deposit_collateral_locked(arg0: &Obligation) : bool {
        arg0.deposit_collateral_locked
    }

    public fun has_coin_x_as_collateral(arg0: &Obligation, arg1: 0x1::type_name::TypeName) : bool {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_collaterals::has_coin_x_as_collateral(&arg0.collaterals, arg1)
    }

    public fun has_coin_x_as_debt(arg0: &Obligation, arg1: 0x1::type_name::TypeName) : bool {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_debts::has_coin_x_as_debt(&arg0.debts, arg1)
    }

    public(friend) fun increase_debt(arg0: &mut Obligation, arg1: 0x1::type_name::TypeName, arg2: u64) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_debts::increase(&mut arg0.debts, arg1, arg2);
    }

    public(friend) fun init_debt(arg0: &mut Obligation, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: 0x1::type_name::TypeName) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_debts::init_debt(&mut arg0.debts, arg2, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::borrow_index(arg1, arg2));
    }

    public fun is_key_match(arg0: &Obligation, arg1: &ObligationKey) : bool {
        0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ownership::is_owner<ObligationOwnership, Obligation>(&arg1.ownership, arg0)
    }

    public fun liquidate_locked(arg0: &Obligation) : bool {
        arg0.liquidate_locked
    }

    public fun lock<T0: drop>(arg0: &mut Obligation, arg1: &ObligationKey, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_access::ObligationAccessStore, arg3: bool, arg4: bool, arg5: bool, arg6: bool, arg7: bool, arg8: T0) {
        assert_key_match(arg0, arg1);
        set_lock<T0>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v0 = ObligationLocked{
            obligation                 : 0x2::object::id<Obligation>(arg0),
            witness                    : 0x1::type_name::get<T0>(),
            borrow_locked              : arg0.borrow_locked,
            repay_locked               : arg0.repay_locked,
            deposit_collateral_locked  : arg0.deposit_collateral_locked,
            withdraw_collateral_locked : arg0.withdraw_collateral_locked,
            liquidate_locked           : arg0.liquidate_locked,
        };
        0x2::event::emit<ObligationLocked>(v0);
    }

    public fun lock_key(arg0: &Obligation) : 0x1::option::Option<0x1::type_name::TypeName> {
        arg0.lock_key
    }

    public fun obligation_key_uid(arg0: &ObligationKey, arg1: 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::witness::Witness<ObligationKey>) : &0x2::object::UID {
        &arg0.id
    }

    public fun obligation_key_uid_mut_delegated(arg0: &mut ObligationKey, arg1: 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::witness::Witness<ObligationKey>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun obligation_uid(arg0: &Obligation, arg1: 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::witness::Witness<Obligation>) : &0x2::object::UID {
        &arg0.id
    }

    public fun obligation_uid_mut_delegated(arg0: &mut Obligation, arg1: 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::witness::Witness<Obligation>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun redeem_rewards_point<T0: drop>(arg0: &mut Obligation, arg1: &ObligationKey, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_access::ObligationAccessStore, arg3: T0, arg4: u64) {
        assert_key_match(arg0, arg1);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_access::assert_reward_key_in_store<T0>(arg2, arg3);
        arg0.rewards_point = arg0.rewards_point - arg4;
        let v0 = ObligationRewardsPointRedeemed{
            obligation : 0x2::object::id<Obligation>(arg0),
            witness    : 0x1::type_name::get<T0>(),
            amount     : arg4,
        };
        0x2::event::emit<ObligationRewardsPointRedeemed>(v0);
    }

    public fun repay_locked(arg0: &Obligation) : bool {
        arg0.repay_locked
    }

    public fun rewards_point(arg0: &Obligation) : u64 {
        arg0.rewards_point
    }

    public(friend) fun set_lock<T0: drop>(arg0: &mut Obligation, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_access::ObligationAccessStore, arg2: bool, arg3: bool, arg4: bool, arg5: bool, arg6: bool, arg7: T0) {
        assert!(0x1::option::is_none<0x1::type_name::TypeName>(&arg0.lock_key), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::error::obligation_already_locked());
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_access::assert_lock_key_in_store<T0>(arg1, arg7);
        arg0.lock_key = 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::get<T0>());
        arg0.borrow_locked = arg2;
        arg0.repay_locked = arg3;
        arg0.withdraw_collateral_locked = arg5;
        arg0.deposit_collateral_locked = arg4;
        arg0.liquidate_locked = arg6;
    }

    public(friend) fun set_unlock<T0: drop>(arg0: &mut Obligation, arg1: T0) {
        assert!(*0x1::option::borrow<0x1::type_name::TypeName>(&arg0.lock_key) == 0x1::type_name::get<T0>(), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::error::obligation_unlock_with_wrong_key());
        arg0.lock_key = 0x1::option::none<0x1::type_name::TypeName>();
        arg0.borrow_locked = false;
        arg0.repay_locked = false;
        arg0.withdraw_collateral_locked = false;
        arg0.deposit_collateral_locked = false;
        arg0.liquidate_locked = false;
    }

    public fun unlock<T0: drop>(arg0: &mut Obligation, arg1: &ObligationKey, arg2: T0) {
        assert_key_match(arg0, arg1);
        set_unlock<T0>(arg0, arg2);
        let v0 = ObligationUnlocked{
            obligation : 0x2::object::id<Obligation>(arg0),
            witness    : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<ObligationUnlocked>(v0);
    }

    public(friend) fun withdraw_collateral<T0>(arg0: &mut Obligation, arg1: u64) : 0x2::balance::Balance<T0> {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_collaterals::decrease(&mut arg0.collaterals, 0x1::type_name::get<T0>(), arg1);
        0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::balance_bag::split<T0>(&mut arg0.balances, arg1)
    }

    public fun withdraw_collateral_locked(arg0: &Obligation) : bool {
        arg0.withdraw_collateral_locked
    }

    // decompiled from Move bytecode v6
}

