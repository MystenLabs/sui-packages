module 0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::entries {
    public entry fun addFunds<T0>(arg0: &0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::ManagerCap, arg1: &mut 0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::ProjectRegistry, arg2: &mut 0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::Pool<T0>, arg3: 0x2::coin::Coin<T0>, arg4: vector<u128>, arg5: vector<address>, arg6: &0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::addFunds<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun addFundsWithReleased<T0>(arg0: &0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::ManagerCap, arg1: &mut 0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::ProjectRegistry, arg2: &mut 0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::Pool<T0>, arg3: 0x2::coin::Coin<T0>, arg4: vector<u128>, arg5: vector<address>, arg6: vector<u128>, arg7: bool, arg8: &0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::addFundsWithReleased<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public entry fun addMemberInVault(arg0: &0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::Admincap, arg1: address, arg2: &mut 0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::Vault, arg3: &mut 0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::addMemberInVault(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun changeMemberInVault(arg0: &0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::Admincap, arg1: address, arg2: &mut 0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::Vault, arg3: &mut 0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::changeMemberInVault(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun changeOperationWallet(arg0: &mut 0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::Operation, arg1: &0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::Vault, arg2: address, arg3: &mut 0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::changeOperationWallet(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun claim<T0>(arg0: &mut 0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::Pool<T0>, arg1: &0x2::clock::Clock, arg2: &0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::claim<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun claimCap<T0: store + key>(arg0: &mut 0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::cap_vault::CapVault<T0>, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::cap_vault::claim_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun createPool<T0>(arg0: &0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::ManagerCap, arg1: &mut 0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::ProjectRegistry, arg2: vector<u8>, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: vector<u64>, arg9: vector<u64>, arg10: u128, arg11: &mut 0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::Version, arg12: &mut 0x2::tx_context::TxContext) {
        0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::createPool<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public entry fun disableChangeFund<T0>(arg0: &0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::ManagerCap, arg1: &mut 0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::Pool<T0>, arg2: &0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::disableChangeFund<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun enableChangeFund<T0>(arg0: &0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::Operation, arg1: &mut 0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::Pool<T0>, arg2: &0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::Version, arg3: &0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::Vault, arg4: &mut 0x2::tx_context::TxContext) {
        0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::enableChangeFund<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun end<T0>(arg0: &0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::ManagerCap, arg1: &mut 0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::Pool<T0>, arg2: &0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::Version) {
        0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::end<T0>(arg0, arg1, arg2);
    }

    public entry fun getFundUser<T0>(arg0: &mut 0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::Pool<T0>, arg1: address) {
        let (_, _, _) = 0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::getFundUser<T0>(arg0, arg1);
    }

    public entry fun migrateVersion(arg0: &0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::VerAdminCap, arg1: &mut 0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::Version, arg2: u64) {
        0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::migrate(arg0, arg1, arg2);
    }

    public entry fun pause<T0>(arg0: &0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::ManagerCap, arg1: &mut 0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::Pool<T0>, arg2: &0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::Version) {
        0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::pause<T0>(arg0, arg1, arg2);
    }

    public entry fun removeFunds<T0>(arg0: &0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::ManagerCap, arg1: &mut 0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::ProjectRegistry, arg2: &0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::Operation, arg3: &mut 0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::Pool<T0>, arg4: vector<address>, arg5: &0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::removeFunds<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun revokeCap<T0: store + key>(arg0: &mut 0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::cap_vault::CapVault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::cap_vault::revoke_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun start<T0>(arg0: &0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::ManagerCap, arg1: &mut 0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::Pool<T0>, arg2: &0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::Version) {
        0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::start<T0>(arg0, arg1, arg2);
    }

    public entry fun transferCap<T0: store + key>(arg0: T0, arg1: address, arg2: &mut 0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::cap_vault::CapVault<T0>, arg3: &0x2::tx_context::TxContext) {
        0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::cap_vault::transfer_cap<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun updateVestingConfig<T0>(arg0: &0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::Operation, arg1: &mut 0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::Pool<T0>, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u64>, arg8: vector<u64>, arg9: u128, arg10: &0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::Version, arg11: &0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::Vault, arg12: &mut 0x2::tx_context::TxContext) {
        0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::updateVestingConfig<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public entry fun withdrawFundAll<T0>(arg0: &0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::TreasureCap, arg1: &0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::Operation, arg2: &mut 0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::Pool<T0>, arg3: &0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::withdrawFundAll<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun withdrawFundAmount<T0>(arg0: &0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::TreasureCap, arg1: &0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::Operation, arg2: &mut 0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::Pool<T0>, arg3: u128, arg4: &0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting::withdrawFundAmount<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

