module 0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::deposit {
    struct BridgeDeposit has store {
        typs: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        fees: 0x2::bag::Bag,
        balances: 0x2::bag::Bag,
    }

    public(friend) fun deposit<T0>(arg0: &mut BridgeDeposit, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(create_balance_if_not_exist<T0>(arg0, false), arg1);
    }

    public(friend) fun all_deposit_keys(arg0: &BridgeDeposit) : vector<0x1::type_name::TypeName> {
        *0x2::vec_set::keys<0x1::type_name::TypeName>(&arg0.typs)
    }

    public(friend) fun claim<T0>(arg0: &mut BridgeDeposit, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = create_balance_if_not_exist<T0>(arg0, false);
        assert!(0x2::balance::value<T0>(v0) >= arg1, 1);
        0x2::balance::split<T0>(v0, arg1)
    }

    public(friend) fun claim_fee<T0>(arg0: &mut BridgeDeposit, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = create_balance_if_not_exist<T0>(arg0, true);
        assert!(0x2::balance::value<T0>(v0) >= arg1, 1);
        0x2::balance::split<T0>(v0, arg1)
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : BridgeDeposit {
        BridgeDeposit{
            typs     : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            fees     : 0x2::bag::new(arg0),
            balances : 0x2::bag::new(arg0),
        }
    }

    fun create_balance_if_not_exist<T0>(arg0: &mut BridgeDeposit, arg1: bool) : &mut 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.typs, &v0)) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.typs, v0);
        };
        if (arg1) {
            if (!is_fee_exist<T0>(arg0)) {
                0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fees, v0, 0x2::balance::zero<T0>());
            };
            0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fees, v0)
        } else {
            if (!is_balance_exist<T0>(arg0)) {
                0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, 0x2::balance::zero<T0>());
            };
            0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0)
        }
    }

    public(friend) fun deposit_balance<T0>(arg0: &BridgeDeposit) : u64 {
        if (is_balance_exist<T0>(arg0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, 0x1::type_name::get<T0>()))
        } else {
            0
        }
    }

    public(friend) fun deposit_fee<T0>(arg0: &mut BridgeDeposit, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(create_balance_if_not_exist<T0>(arg0, true), arg1);
    }

    public(friend) fun deposit_fee_balance<T0>(arg0: &BridgeDeposit) : u64 {
        if (is_fee_exist<T0>(arg0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.fees, 0x1::type_name::get<T0>()))
        } else {
            0
        }
    }

    fun is_balance_exist<T0>(arg0: &BridgeDeposit) : bool {
        0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, 0x1::type_name::get<T0>())
    }

    fun is_fee_exist<T0>(arg0: &BridgeDeposit) : bool {
        0x2::bag::contains<0x1::type_name::TypeName>(&arg0.fees, 0x1::type_name::get<T0>())
    }

    // decompiled from Move bytecode v6
}

