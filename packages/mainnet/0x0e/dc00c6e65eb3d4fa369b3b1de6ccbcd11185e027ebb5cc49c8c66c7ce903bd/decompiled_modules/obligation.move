module 0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::obligation {
    struct Obligation has store, key {
        id: 0x2::object::UID,
        balances: 0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::balance_bag::BalanceBag,
        debts: 0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::wit_table::WitTable<0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::obligation_debts::ObligationDebts, 0x1::type_name::TypeName, 0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::obligation_debts::Debt>,
        collaterals: 0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::wit_table::WitTable<0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::obligation_collaterals::ObligationCollaterals, 0x1::type_name::TypeName, 0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::obligation_collaterals::Collateral>,
    }

    struct ObligationOwnership has drop {
        dummy_field: bool,
    }

    struct ObligationKey has store, key {
        id: 0x2::object::UID,
        ownership: 0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::ownership::Ownership<ObligationOwnership>,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : (Obligation, ObligationKey) {
        let v0 = Obligation{
            id          : 0x2::object::new(arg0),
            balances    : 0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::balance_bag::new(arg0),
            debts       : 0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::obligation_debts::new(arg0),
            collaterals : 0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::obligation_collaterals::new(arg0),
        };
        let v1 = ObligationOwnership{dummy_field: false};
        let v2 = ObligationKey{
            id        : 0x2::object::new(arg0),
            ownership : 0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::ownership::create_ownership<ObligationOwnership>(v1, 0x2::object::id<Obligation>(&v0), arg0),
        };
        (v0, v2)
    }

    public(friend) fun accrue_interests(arg0: &mut Obligation, arg1: &0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::market::Market) {
        let v0 = debt_types(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v2 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v1);
            0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::obligation_debts::accure_interest(&mut arg0.debts, v2, 0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::market::borrow_index(arg1, v2));
            v1 = v1 + 1;
        };
    }

    public fun assert_key_match(arg0: &Obligation, arg1: &ObligationKey) {
        0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::ownership::assert_owner<ObligationOwnership, Obligation>(&arg1.ownership, arg0);
    }

    public fun balance_bag(arg0: &Obligation) : &0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::balance_bag::BalanceBag {
        &arg0.balances
    }

    public fun collateral(arg0: &Obligation, arg1: 0x1::type_name::TypeName) : u64 {
        0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::obligation_collaterals::collateral(&arg0.collaterals, arg1)
    }

    public fun collateral_types(arg0: &Obligation) : vector<0x1::type_name::TypeName> {
        0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::wit_table::keys<0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::obligation_collaterals::ObligationCollaterals, 0x1::type_name::TypeName, 0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::obligation_collaterals::Collateral>(&arg0.collaterals)
    }

    public fun collaterals(arg0: &Obligation) : &0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::wit_table::WitTable<0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::obligation_collaterals::ObligationCollaterals, 0x1::type_name::TypeName, 0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::obligation_collaterals::Collateral> {
        &arg0.collaterals
    }

    public fun debt(arg0: &Obligation, arg1: 0x1::type_name::TypeName) : (u64, u64) {
        0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::obligation_debts::debt(&arg0.debts, arg1)
    }

    public fun debt_types(arg0: &Obligation) : vector<0x1::type_name::TypeName> {
        0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::wit_table::keys<0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::obligation_debts::ObligationDebts, 0x1::type_name::TypeName, 0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::obligation_debts::Debt>(&arg0.debts)
    }

    public fun debts(arg0: &Obligation) : &0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::wit_table::WitTable<0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::obligation_debts::ObligationDebts, 0x1::type_name::TypeName, 0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::obligation_debts::Debt> {
        &arg0.debts
    }

    public(friend) fun decrease_debt(arg0: &mut Obligation, arg1: 0x1::type_name::TypeName, arg2: u64) {
        0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::obligation_debts::decrease(&mut arg0.debts, arg1, arg2);
    }

    public(friend) fun deposit_collateral<T0>(arg0: &mut Obligation, arg1: 0x2::balance::Balance<T0>) {
        0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::obligation_collaterals::increase(&mut arg0.collaterals, 0x1::type_name::get<T0>(), 0x2::balance::value<T0>(&arg1));
        if (0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::balance_bag::contains<T0>(&arg0.balances) == false) {
            0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::balance_bag::init_balance<T0>(&mut arg0.balances);
        };
        0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::balance_bag::join<T0>(&mut arg0.balances, arg1);
    }

    public(friend) fun increase_debt(arg0: &mut Obligation, arg1: 0x1::type_name::TypeName, arg2: u64) {
        0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::obligation_debts::increase(&mut arg0.debts, arg1, arg2);
    }

    public(friend) fun init_debt(arg0: &mut Obligation, arg1: &0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::market::Market, arg2: 0x1::type_name::TypeName) {
        0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::obligation_debts::init_debt(&mut arg0.debts, arg2, 0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::market::borrow_index(arg1, arg2));
    }

    public fun is_key_match(arg0: &Obligation, arg1: &ObligationKey) : bool {
        0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::ownership::is_owner<ObligationOwnership, Obligation>(&arg1.ownership, arg0)
    }

    public(friend) fun withdraw_collateral<T0>(arg0: &mut Obligation, arg1: u64) : 0x2::balance::Balance<T0> {
        0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::obligation_collaterals::decrease(&mut arg0.collaterals, 0x1::type_name::get<T0>(), arg1);
        0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::balance_bag::split<T0>(&mut arg0.balances, arg1)
    }

    // decompiled from Move bytecode v6
}

