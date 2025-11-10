module 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::staker {
    struct Staker<phantom T0> has store {
        admin: 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::AdminCap<T0>,
        liquid_staking_info: 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>,
        lst_balance: 0x2::balance::Balance<T0>,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        liabilities: u64,
    }

    public(friend) fun total_sui_supply<T0>(arg0: &Staker<T0>) : u64 {
        0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::total_sui_supply<T0>(&arg0.liquid_staking_info) + 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance)
    }

    public(friend) fun claim_fees<T0: drop>(arg0: &mut Staker<T0>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::refresh<T0>(&mut arg0.liquid_staking_info, arg1, arg2);
        let v0 = total_sui_supply<T0>(arg0);
        let v1 = if (v0 > arg0.liabilities + 1000000000) {
            v0 - arg0.liabilities - 1000000000
        } else {
            0
        };
        if (v1 > 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance)) {
            let v2 = v1 - 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance);
            unstake_n_sui<T0>(arg0, arg1, v2, arg2);
        };
        assert!(total_sui_supply<T0>(arg0) >= arg0.liabilities, 1);
        0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, v1)
    }

    public(friend) fun create_staker<T0: drop>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::tx_context::TxContext) : Staker<T0> {
        assert!(0x2::coin::total_supply<T0>(&arg0) == 0, 0);
        let (v0, v1) = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::create_lst<T0>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::fees::to_fee_config(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::fees::new_builder(arg1)), arg0, arg1);
        Staker<T0>{
            admin               : v0,
            liquid_staking_info : v1,
            lst_balance         : 0x2::balance::zero<T0>(),
            sui_balance         : 0x2::balance::zero<0x2::sui::SUI>(),
            liabilities         : 0,
        }
    }

    public(friend) fun deposit<T0>(arg0: &mut Staker<T0>, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        arg0.liabilities = arg0.liabilities + 0x2::balance::value<0x2::sui::SUI>(&arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, arg1);
    }

    public(friend) fun liabilities<T0>(arg0: &Staker<T0>) : u64 {
        arg0.liabilities
    }

    public(friend) fun liquid_staking_info<T0>(arg0: &Staker<T0>) : &0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0> {
        &arg0.liquid_staking_info
    }

    public(friend) fun lst_balance<T0>(arg0: &Staker<T0>) : &0x2::balance::Balance<T0> {
        &arg0.lst_balance
    }

    public(friend) fun rebalance<T0: drop>(arg0: &mut Staker<T0>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::tx_context::TxContext) {
        0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::refresh<T0>(&mut arg0.liquid_staking_info, arg1, arg2);
        if (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) < 1000000) {
            return
        };
        0x2::balance::join<T0>(&mut arg0.lst_balance, 0x2::coin::into_balance<T0>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::mint<T0>(&mut arg0.liquid_staking_info, arg1, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.sui_balance), arg2), arg2)));
        0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::increase_validator_stake<T0>(&mut arg0.liquid_staking_info, &arg0.admin, arg1, @0xce8e537664ba5d1d5a6a857b17bd142097138706281882be6805e17065ecde89, 18446744073709551615, arg2);
    }

    public(friend) fun sui_balance<T0>(arg0: &Staker<T0>) : &0x2::balance::Balance<0x2::sui::SUI> {
        &arg0.sui_balance
    }

    fun unstake_n_sui<T0: drop>(arg0: &mut Staker<T0>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg2 == 0) {
            return
        };
        let v0 = (0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::total_sui_supply<T0>(&arg0.liquid_staking_info) as u128);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T0>(&mut arg0.liquid_staking_info, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.lst_balance, ((((arg2 as u128) * (0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::total_lst_supply<T0>(&arg0.liquid_staking_info) as u128) + v0 - 1) / v0) as u64)), arg3), arg1, arg3)));
    }

    public(friend) fun withdraw<T0: drop>(arg0: &mut Staker<T0>, arg1: u64, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::refresh<T0>(&mut arg0.liquid_staking_info, arg2, arg3);
        if (arg1 > 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance)) {
            let v0 = arg1 - 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance);
            unstake_n_sui<T0>(arg0, arg2, v0, arg3);
        };
        let v1 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, arg1);
        arg0.liabilities = arg0.liabilities - 0x2::balance::value<0x2::sui::SUI>(&v1);
        v1
    }

    // decompiled from Move bytecode v6
}

