module 0x49115e9c326f94f21987e1aa82e8e5526d31ca34908d10d334422e67843b49a7::staker {
    struct STAKER has drop {
        dummy_field: bool,
    }

    struct Staker has store {
        admin: 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::AdminCap<STAKER>,
        liquid_staking_info: 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<STAKER>,
        lst_balance: 0x2::balance::Balance<STAKER>,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        liabilities: u64,
    }

    public(friend) fun claim_fees(arg0: &mut Staker, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::refresh<STAKER>(&mut arg0.liquid_staking_info, arg1, arg2);
        let v0 = total_sui_supply(arg0);
        let v1 = if (v0 > arg0.liabilities + 1000000000) {
            v0 - arg0.liabilities - 1000000000
        } else {
            0
        };
        if (v1 > 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance)) {
            let v2 = v1 - 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance);
            unstake_n_sui(arg0, arg1, v2, arg2);
        };
        assert!(total_sui_supply(arg0) >= arg0.liabilities, 1);
        0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, v1)
    }

    public(friend) fun create_staker(arg0: 0x2::coin::TreasuryCap<STAKER>, arg1: &mut 0x2::tx_context::TxContext) : Staker {
        assert!(0x2::coin::total_supply<STAKER>(&arg0) == 0, 0);
        let (v0, v1) = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::create_lst<STAKER>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::fees::to_fee_config(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::fees::new_builder(arg1)), arg0, arg1);
        Staker{
            admin               : v0,
            liquid_staking_info : v1,
            lst_balance         : 0x2::balance::zero<STAKER>(),
            sui_balance         : 0x2::balance::zero<0x2::sui::SUI>(),
            liabilities         : 0,
        }
    }

    public(friend) fun deposit(arg0: &mut Staker, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        arg0.liabilities = arg0.liabilities + 0x2::balance::value<0x2::sui::SUI>(&arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, arg1);
    }

    fun init(arg0: STAKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STAKER>(arg0, 9, b"SprungSui", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STAKER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STAKER>>(v0, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun liabilities(arg0: &Staker) : u64 {
        arg0.liabilities
    }

    public(friend) fun liquid_staking_info(arg0: &Staker) : &0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<STAKER> {
        &arg0.liquid_staking_info
    }

    public(friend) fun lst_balance(arg0: &Staker) : &0x2::balance::Balance<STAKER> {
        &arg0.lst_balance
    }

    public(friend) fun rebalance(arg0: &mut Staker, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::tx_context::TxContext) {
        0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::refresh<STAKER>(&mut arg0.liquid_staking_info, arg1, arg2);
        if (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) < 1000000) {
            return
        };
        0x2::balance::join<STAKER>(&mut arg0.lst_balance, 0x2::coin::into_balance<STAKER>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::mint<STAKER>(&mut arg0.liquid_staking_info, arg1, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.sui_balance), arg2), arg2)));
        0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::increase_validator_stake<STAKER>(&mut arg0.liquid_staking_info, &arg0.admin, arg1, @0xce8e537664ba5d1d5a6a857b17bd142097138706281882be6805e17065ecde89, 18446744073709551615, arg2);
    }

    public(friend) fun sui_balance(arg0: &Staker) : &0x2::balance::Balance<0x2::sui::SUI> {
        &arg0.sui_balance
    }

    public(friend) fun total_sui_supply(arg0: &Staker) : u64 {
        0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::total_sui_supply<STAKER>(&arg0.liquid_staking_info) + 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance)
    }

    fun unstake_n_sui(arg0: &mut Staker, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg2 == 0) {
            return
        };
        let v0 = (0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::total_sui_supply<STAKER>(&arg0.liquid_staking_info) as u128);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<STAKER>(&mut arg0.liquid_staking_info, 0x2::coin::from_balance<STAKER>(0x2::balance::split<STAKER>(&mut arg0.lst_balance, ((((arg2 as u128) * (0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::total_lst_supply<STAKER>(&arg0.liquid_staking_info) as u128) + v0 - 1) / v0) as u64)), arg3), arg1, arg3)));
    }

    public(friend) fun withdraw(arg0: &mut Staker, arg1: u64, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::refresh<STAKER>(&mut arg0.liquid_staking_info, arg2, arg3);
        if (arg1 > 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance)) {
            let v0 = arg1 - 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance);
            unstake_n_sui(arg0, arg2, v0, arg3);
        };
        let v1 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, arg1);
        arg0.liabilities = arg0.liabilities - 0x2::balance::value<0x2::sui::SUI>(&v1);
        v1
    }

    // decompiled from Move bytecode v6
}

