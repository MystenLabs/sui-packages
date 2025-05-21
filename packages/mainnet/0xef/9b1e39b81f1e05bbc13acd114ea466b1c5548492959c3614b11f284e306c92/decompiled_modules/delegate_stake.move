module 0xef9b1e39b81f1e05bbc13acd114ea466b1c5548492959c3614b11f284e306c92::delegate_stake {
    public entry fun stake_to_validator(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x3::sui_system::request_add_stake(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

