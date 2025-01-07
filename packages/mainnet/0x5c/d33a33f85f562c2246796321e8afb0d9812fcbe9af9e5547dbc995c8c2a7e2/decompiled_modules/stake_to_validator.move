module 0x5cd33a33f85f562c2246796321e8afb0d9812fcbe9af9e5547dbc995c8c2a7e2::stake_to_validator {
    public(friend) fun stake(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x3::staking_pool::StakedSui {
        0x3::sui_system::request_add_stake_non_entry(arg0, arg1, arg2, arg3)
    }

    public(friend) fun withdraw(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: 0x3::staking_pool::StakedSui, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::from_balance<0x2::sui::SUI>(0x3::sui_system::request_withdraw_stake_non_entry(arg0, arg1, arg2), arg2)
    }

    // decompiled from Move bytecode v6
}

