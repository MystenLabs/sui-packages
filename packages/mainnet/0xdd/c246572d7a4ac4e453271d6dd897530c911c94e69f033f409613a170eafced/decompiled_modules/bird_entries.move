module 0xddc246572d7a4ac4e453271d6dd897530c911c94e69f033f409613a170eafced::bird_entries {
    public entry fun action(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xddc246572d7a4ac4e453271d6dd897530c911c94e69f033f409613a170eafced::bird::BirdStore, arg3: &mut 0xddc246572d7a4ac4e453271d6dd897530c911c94e69f033f409613a170eafced::bird::BirdArchieve, arg4: &0x2::clock::Clock, arg5: &0xddc246572d7a4ac4e453271d6dd897530c911c94e69f033f409613a170eafced::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xddc246572d7a4ac4e453271d6dd897530c911c94e69f033f409613a170eafced::bird::action(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun claimReward<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xddc246572d7a4ac4e453271d6dd897530c911c94e69f033f409613a170eafced::bird::RewardPool<T0>, arg3: &mut 0xddc246572d7a4ac4e453271d6dd897530c911c94e69f033f409613a170eafced::bird::BirdStore, arg4: &mut 0xddc246572d7a4ac4e453271d6dd897530c911c94e69f033f409613a170eafced::bird::BirdArchieve, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xddc246572d7a4ac4e453271d6dd897530c911c94e69f033f409613a170eafced::bird::claimReward<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun claim_admin(arg0: &mut 0xddc246572d7a4ac4e453271d6dd897530c911c94e69f033f409613a170eafced::bird::TransporterVault, arg1: &0xddc246572d7a4ac4e453271d6dd897530c911c94e69f033f409613a170eafced::version::Version, arg2: &0x2::tx_context::TxContext) {
        0xddc246572d7a4ac4e453271d6dd897530c911c94e69f033f409613a170eafced::bird::claim_admin(arg0, arg1, arg2);
    }

    fun claim_treasure(arg0: &mut 0xddc246572d7a4ac4e453271d6dd897530c911c94e69f033f409613a170eafced::bird::TransporterVault, arg1: &0xddc246572d7a4ac4e453271d6dd897530c911c94e69f033f409613a170eafced::version::Version, arg2: &0x2::tx_context::TxContext) {
        0xddc246572d7a4ac4e453271d6dd897530c911c94e69f033f409613a170eafced::bird::claim_treasure(arg0, arg1, arg2);
    }

    public fun configRewardPool<T0>(arg0: &0xddc246572d7a4ac4e453271d6dd897530c911c94e69f033f409613a170eafced::bird::BirdAdminCap, arg1: &mut 0xddc246572d7a4ac4e453271d6dd897530c911c94e69f033f409613a170eafced::bird::RewardPool<T0>, arg2: bool, arg3: u64) {
        0xddc246572d7a4ac4e453271d6dd897530c911c94e69f033f409613a170eafced::bird::configRewardPool<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun createRewardPool<T0>(arg0: &0xddc246572d7a4ac4e453271d6dd897530c911c94e69f033f409613a170eafced::bird::BirdAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        0xddc246572d7a4ac4e453271d6dd897530c911c94e69f033f409613a170eafced::bird::createRewardPool<T0>(arg0, arg1);
    }

    public fun depositReward<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0xddc246572d7a4ac4e453271d6dd897530c911c94e69f033f409613a170eafced::bird::RewardPool<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0xddc246572d7a4ac4e453271d6dd897530c911c94e69f033f409613a170eafced::bird::depositReward<T0>(arg0, arg1, arg2, arg3);
    }

    public fun emergencyRewardWithdraw<T0>(arg0: &0xddc246572d7a4ac4e453271d6dd897530c911c94e69f033f409613a170eafced::bird::RewardTreasureCap, arg1: &mut 0xddc246572d7a4ac4e453271d6dd897530c911c94e69f033f409613a170eafced::bird::RewardPool<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xddc246572d7a4ac4e453271d6dd897530c911c94e69f033f409613a170eafced::bird::emergencyRewardWithdraw<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun register(arg0: &mut 0xddc246572d7a4ac4e453271d6dd897530c911c94e69f033f409613a170eafced::bird::BirdReg, arg1: &0x2::clock::Clock, arg2: &0xddc246572d7a4ac4e453271d6dd897530c911c94e69f033f409613a170eafced::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xddc246572d7a4ac4e453271d6dd897530c911c94e69f033f409613a170eafced::bird::register(arg0, arg1, arg2, arg3);
    }

    public entry fun revoke_admin(arg0: &mut 0xddc246572d7a4ac4e453271d6dd897530c911c94e69f033f409613a170eafced::bird::TransporterVault, arg1: &0xddc246572d7a4ac4e453271d6dd897530c911c94e69f033f409613a170eafced::version::Version, arg2: &0x2::tx_context::TxContext) {
        0xddc246572d7a4ac4e453271d6dd897530c911c94e69f033f409613a170eafced::bird::revoke_admin(arg0, arg1, arg2);
    }

    public entry fun revoke_treasure(arg0: &mut 0xddc246572d7a4ac4e453271d6dd897530c911c94e69f033f409613a170eafced::bird::TransporterVault, arg1: &0xddc246572d7a4ac4e453271d6dd897530c911c94e69f033f409613a170eafced::version::Version, arg2: &0x2::tx_context::TxContext) {
        0xddc246572d7a4ac4e453271d6dd897530c911c94e69f033f409613a170eafced::bird::revoke_treasure(arg0, arg1, arg2);
    }

    public entry fun transfer_admin(arg0: 0xddc246572d7a4ac4e453271d6dd897530c911c94e69f033f409613a170eafced::bird::BirdAdminCap, arg1: address, arg2: &mut 0xddc246572d7a4ac4e453271d6dd897530c911c94e69f033f409613a170eafced::bird::TransporterVault, arg3: &0xddc246572d7a4ac4e453271d6dd897530c911c94e69f033f409613a170eafced::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xddc246572d7a4ac4e453271d6dd897530c911c94e69f033f409613a170eafced::bird::transfer_admin(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun transfer_treasure(arg0: 0xddc246572d7a4ac4e453271d6dd897530c911c94e69f033f409613a170eafced::bird::RewardTreasureCap, arg1: address, arg2: &mut 0xddc246572d7a4ac4e453271d6dd897530c911c94e69f033f409613a170eafced::bird::TransporterVault, arg3: &0xddc246572d7a4ac4e453271d6dd897530c911c94e69f033f409613a170eafced::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xddc246572d7a4ac4e453271d6dd897530c911c94e69f033f409613a170eafced::bird::transfer_treasure(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun set_validator(arg0: &0xddc246572d7a4ac4e453271d6dd897530c911c94e69f033f409613a170eafced::bird::BirdAdminCap, arg1: vector<u8>, arg2: &mut 0xddc246572d7a4ac4e453271d6dd897530c911c94e69f033f409613a170eafced::bird::BirdStore, arg3: &mut 0xddc246572d7a4ac4e453271d6dd897530c911c94e69f033f409613a170eafced::version::Version) {
        0xddc246572d7a4ac4e453271d6dd897530c911c94e69f033f409613a170eafced::bird::update_validator(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

