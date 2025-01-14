module 0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::entries {
    public entry fun addFunds<T0>(arg0: &0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::ManagerCap, arg1: &mut 0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::ProjectRegistry, arg2: &mut 0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::Pool<T0>, arg3: 0x2::coin::Coin<T0>, arg4: vector<u128>, arg5: vector<address>, arg6: &0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::addFunds<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun addFundsWithReleased<T0>(arg0: &0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::ManagerCap, arg1: &mut 0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::ProjectRegistry, arg2: &mut 0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::Pool<T0>, arg3: 0x2::coin::Coin<T0>, arg4: vector<u128>, arg5: vector<address>, arg6: vector<u128>, arg7: bool, arg8: &0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::addFundsWithReleased<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public entry fun addMemberInVault(arg0: &0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::Admincap, arg1: address, arg2: &mut 0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::Vault, arg3: &mut 0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::addMemberInVault(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun changeMemberInVault(arg0: &0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::Admincap, arg1: address, arg2: &mut 0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::Vault, arg3: &mut 0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::changeMemberInVault(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun changeOperationWallet(arg0: &mut 0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::Operation, arg1: &0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::Vault, arg2: address, arg3: &mut 0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::changeOperationWallet(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun claim<T0>(arg0: &mut 0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::Pool<T0>, arg1: &0x2::clock::Clock, arg2: &0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::claim<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun claimCap<T0: store + key>(arg0: &mut 0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::cap_vault::CapVault<T0>, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::cap_vault::claim_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun createPool<T0>(arg0: &0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::ManagerCap, arg1: &mut 0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::ProjectRegistry, arg2: vector<u8>, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: vector<u64>, arg9: vector<u64>, arg10: u128, arg11: &mut 0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::version::Version, arg12: &mut 0x2::tx_context::TxContext) {
        0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::createPool<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public entry fun disableChangeFund<T0>(arg0: &0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::ManagerCap, arg1: &mut 0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::Pool<T0>, arg2: &0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::disableChangeFund<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun enableChangeFund<T0>(arg0: &0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::Operation, arg1: &mut 0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::Pool<T0>, arg2: &0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::version::Version, arg3: &0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::Vault, arg4: &mut 0x2::tx_context::TxContext) {
        0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::enableChangeFund<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun end<T0>(arg0: &0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::ManagerCap, arg1: &mut 0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::Pool<T0>, arg2: &0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::version::Version) {
        0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::end<T0>(arg0, arg1, arg2);
    }

    public entry fun getFundUser<T0>(arg0: &mut 0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::Pool<T0>, arg1: address) {
        let (_, _, _) = 0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::getFundUser<T0>(arg0, arg1);
    }

    public entry fun migrateVersion(arg0: &0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::version::VerAdminCap, arg1: &mut 0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::version::Version, arg2: u64) {
        0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::version::migrate(arg0, arg1, arg2);
    }

    public entry fun pause<T0>(arg0: &0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::ManagerCap, arg1: &mut 0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::Pool<T0>, arg2: &0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::version::Version) {
        0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::pause<T0>(arg0, arg1, arg2);
    }

    public entry fun removeFunds<T0>(arg0: &0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::ManagerCap, arg1: &mut 0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::ProjectRegistry, arg2: &0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::Operation, arg3: &mut 0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::Pool<T0>, arg4: vector<address>, arg5: &0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::removeFunds<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun revokeCap<T0: store + key>(arg0: &mut 0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::cap_vault::CapVault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::cap_vault::revoke_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun start<T0>(arg0: &0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::ManagerCap, arg1: &mut 0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::Pool<T0>, arg2: &0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::version::Version) {
        0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::start<T0>(arg0, arg1, arg2);
    }

    public entry fun transferCap<T0: store + key>(arg0: T0, arg1: address, arg2: &mut 0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::cap_vault::CapVault<T0>, arg3: &0x2::tx_context::TxContext) {
        0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::cap_vault::transfer_cap<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun updateVestingConfig<T0>(arg0: &0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::Operation, arg1: &mut 0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::Pool<T0>, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u64>, arg8: vector<u64>, arg9: u128, arg10: &0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::version::Version, arg11: &0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::Vault, arg12: &mut 0x2::tx_context::TxContext) {
        0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::updateVestingConfig<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public entry fun withdrawFundAll<T0>(arg0: &0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::TreasureCap, arg1: &0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::Operation, arg2: &mut 0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::Pool<T0>, arg3: &0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::withdrawFundAll<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun withdrawFundAmount<T0>(arg0: &0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::TreasureCap, arg1: &0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::Operation, arg2: &mut 0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::Pool<T0>, arg3: u128, arg4: &0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xbf6d9f45403cb7a23bb5f1ddf7eb6581e0f4a3e512b307058ae29e9fe1c8cab2::vesting::withdrawFundAmount<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

