module 0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::entries {
    public entry fun addMaxAllocations<T0>(arg0: &0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::ManagerCap, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::Pool<T0>, arg4: &mut 0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::addMaxAllocations<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun addMemberInVault(arg0: &0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::Admincap, arg1: address, arg2: &mut 0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::Vault, arg3: &mut 0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::addMemberInVault(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun addWhitelist<T0>(arg0: &0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::ManagerCap, arg1: &mut 0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::Pool<T0>, arg2: vector<address>, arg3: &mut 0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::addWhitelist<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun buy<T0>(arg0: &mut 0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::buy<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun buyByTokenFree<T0>(arg0: &mut 0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::Pool<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: vector<vector<u8>>, arg4: 0x2::coin::Coin<T0>, arg5: &0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::ProviderCap, arg6: &0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::version::Version, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::buyByTokenFree<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun changeMemberInVault(arg0: &0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::Admincap, arg1: address, arg2: &mut 0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::Vault, arg3: &mut 0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::changeMemberInVault(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun changeOperationWallet(arg0: &mut 0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::Operation, arg1: &0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::Vault, arg2: address, arg3: &mut 0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::changeOperationWallet(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun changeStatus<T0>(arg0: &0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::Admincap, arg1: &mut 0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::Pool<T0>, arg2: u8, arg3: &0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::version::Version) {
        0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::changeStatus<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun claimCap<T0: store + key>(arg0: &mut 0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::cap_vault::CapVault<T0>, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::cap_vault::claim_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun configMaxInTurn<T0>(arg0: &0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::Admincap, arg1: &mut 0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::Pool<T0>, arg2: bool, arg3: u128, arg4: &0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::version::Version) {
        0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::configMaxInTurn<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun createPool<T0>(arg0: &0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::Admincap, arg1: vector<u8>, arg2: u128, arg3: u64, arg4: u64, arg5: u128, arg6: bool, arg7: &mut 0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::version::Version, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::createPool<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public entry fun getFundUser<T0>(arg0: &mut 0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::Pool<T0>, arg1: address) {
        0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::getFundUser<T0>(arg0, arg1);
    }

    public entry fun migrateVersion(arg0: &0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::version::VerAdminCap, arg1: &mut 0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::version::Version, arg2: u64) {
        0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::version::migrate(arg0, arg1, arg2);
    }

    public entry fun removeMaxAllocations<T0>(arg0: &0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::ManagerCap, arg1: vector<address>, arg2: &mut 0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::Pool<T0>, arg3: &mut 0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::removeMaxAllocations<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun removeWhitelist<T0>(arg0: &0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::ManagerCap, arg1: &mut 0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::Pool<T0>, arg2: vector<address>, arg3: &mut 0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::removeWhitelist<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun revokeCap<T0: store + key>(arg0: &mut 0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::cap_vault::CapVault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::cap_vault::revoke_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun transferCap<T0: store + key>(arg0: T0, arg1: address, arg2: &mut 0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::cap_vault::CapVault<T0>, arg3: &0x2::tx_context::TxContext) {
        0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::cap_vault::transfer_cap<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun updateDefaultMaxAllocate<T0>(arg0: &0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::Admincap, arg1: &mut 0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::Pool<T0>, arg2: u128, arg3: &0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::version::Version) {
        0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::updateDefaultMaxAllocate<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun updateTargetedRaise<T0>(arg0: &0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::Admincap, arg1: &mut 0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::Pool<T0>, arg2: u128, arg3: &0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::version::Version) {
        0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::updateTargetedRaise<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun updateTime<T0>(arg0: &0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::Admincap, arg1: &mut 0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::Pool<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::version::Version) {
        0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::updateTime<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun updateUseWhitelist<T0>(arg0: &0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::Admincap, arg1: &mut 0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::Pool<T0>, arg2: bool, arg3: &0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::version::Version) {
        0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::updateUseWhitelist<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun withdrawFundAll<T0>(arg0: &0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::TreasureCap, arg1: &mut 0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::Pool<T0>, arg2: &0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::Operation, arg3: &0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::withdrawFundAll<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun withdrawFundAmount<T0>(arg0: &0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::TreasureCap, arg1: &mut 0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::Pool<T0>, arg2: u64, arg3: &0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::Operation, arg4: &0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x64f06fe7ee2082ca5cb7aaa73440d869242b711f986c43d02e3bc92d3cf88933::ido::withdrawFundAmount<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

