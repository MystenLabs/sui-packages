module 0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting_entries {
    public entry fun acceptAdmin(arg0: &mut 0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::AdminCapVault, arg1: &mut 0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::acceptAdmin(arg0, arg1, arg2);
    }

    public entry fun addFund<T0>(arg0: &0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::AdminCap, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::Project<T0>, arg4: &mut 0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::ProjectRegistry, arg5: &0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::version::Version) {
        0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::addFund<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun addFundAfterRemoved<T0>(arg0: &0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::AdminCap, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u128, arg4: u128, arg5: &mut 0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::Project<T0>, arg6: &mut 0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::ProjectRegistry, arg7: &0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::version::Version) {
        0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::addFundAfterRemoved<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun addFunds<T0>(arg0: &0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::AdminCap, arg1: vector<address>, arg2: vector<u64>, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::Project<T0>, arg5: &mut 0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::ProjectRegistry, arg6: &0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::addFunds<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun claim<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::Project<T0>, arg2: &0x2::clock::Clock, arg3: &0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::version::Version, arg4: &mut 0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::ProjectRegistry, arg5: &mut 0x2::tx_context::TxContext) {
        0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::claim<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun createProject<T0>(arg0: &0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::AdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: u128, arg4: u64, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: vector<u64>, arg10: vector<u64>, arg11: &0x2::clock::Clock, arg12: &mut 0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::version::Version, arg13: u64, arg14: &mut 0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::ProjectRegistry, arg15: &mut 0x2::tx_context::TxContext) {
        0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::createProject<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
    }

    public entry fun pauseProject<T0>(arg0: &0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::AdminCap, arg1: &mut 0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::Project<T0>, arg2: bool) {
        0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::pauseProject<T0>(arg0, arg1, arg2);
    }

    public entry fun removeFund<T0>(arg0: &0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::AdminCap, arg1: address, arg2: &mut 0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::Project<T0>, arg3: &mut 0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::ProjectRegistry, arg4: &0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::removeFund<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun removeFund2<T0>(arg0: &0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::AdminCap, arg1: address, arg2: address, arg3: &mut 0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::Project<T0>, arg4: &mut 0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::ProjectRegistry, arg5: &0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::removeFund2<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun removeFunds<T0>(arg0: &0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::AdminCap, arg1: vector<address>, arg2: &mut 0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::Project<T0>, arg3: &mut 0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::ProjectRegistry, arg4: &0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::removeFunds<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun removeFunds2<T0>(arg0: &0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::AdminCap, arg1: vector<address>, arg2: address, arg3: &mut 0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::Project<T0>, arg4: &mut 0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::ProjectRegistry, arg5: &0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::removeFunds2<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun revokeAdmin(arg0: &mut 0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::AdminCapVault, arg1: &mut 0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::revokeAdmin(arg0, arg1, arg2);
    }

    public entry fun setDeprecated<T0>(arg0: &0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::AdminCap, arg1: &mut 0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::Project<T0>, arg2: bool) {
        0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::setDeprecated<T0>(arg0, arg1, arg2);
    }

    public entry fun setProjectFee<T0>(arg0: &0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::AdminCap, arg1: &mut 0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::Project<T0>, arg2: u64) {
        0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::setProjectFee<T0>(arg0, arg1, arg2);
    }

    public entry fun transferAdmin(arg0: 0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::AdminCap, arg1: address, arg2: &mut 0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::AdminCapVault, arg3: &mut 0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::transferAdmin(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun withdrawFee<T0>(arg0: &0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::AdminCap, arg1: address, arg2: &mut 0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::Project<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting::withdrawFee<T0>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

