module 0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::manage {
    public fun adminSetTeamCount<T0>(arg0: &0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::owner::OwnerCap, arg1: &mut 0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::sunset::Contract<T0>, arg2: u8, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::sunset::set_team_count<T0>(arg1, arg2, arg3);
    }

    public fun batch_import_stake_orders<T0>(arg0: &0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::owner::OwnerCap, arg1: &mut 0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::sunset::Contract<T0>, arg2: vector<address>, arg3: vector<u64>, arg4: vector<u8>, arg5: vector<u64>, arg6: vector<u64>, arg7: vector<u64>, arg8: vector<u64>, arg9: &0x2::tx_context::TxContext) {
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::sunset::batch_import_stake_orders<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun batch_import_user_base_data<T0>(arg0: &0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::owner::OwnerCap, arg1: &mut 0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::sunset::Contract<T0>, arg2: vector<address>, arg3: vector<address>, arg4: vector<vector<address>>, arg5: vector<u8>, arg6: &0x2::tx_context::TxContext) {
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::sunset::batch_import_user_base_data<T0>(arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun history_batch_import(arg0: &0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::owner::OwnerCap, arg1: &mut 0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::history::HistoryStore, arg2: vector<address>, arg3: vector<u64>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::history::batch_import_users(arg1, arg2, arg3, arg4);
    }

    public fun history_set_robot(arg0: &0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::owner::OwnerCap, arg1: &mut 0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::history::HistoryStore, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::history::set_robot(arg1, arg2);
    }

    public fun init_contract<T0>(arg0: &0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::owner::OwnerCap, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::sunset::init_contract<T0>(arg1, arg2);
    }

    public fun levelDividendInitLevelData(arg0: &0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::owner::OwnerCap, arg1: &mut 0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::level_dividend::LevelDividend, arg2: vector<address>, arg3: vector<address>, arg4: vector<address>, arg5: vector<address>, arg6: vector<address>, arg7: vector<address>, arg8: &mut 0x2::tx_context::TxContext) {
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::level_dividend::init_level_data(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun lottery_create_default<T0>(arg0: &0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::owner::OwnerCap, arg1: &mut 0x2::tx_context::TxContext) {
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::lottery::create_default<T0>(1000000000, 10000, arg1);
    }

    public fun lottery_set_admin<T0>(arg0: &0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::owner::OwnerCap, arg1: &mut 0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::lottery::Lottery<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::lottery::set_admin<T0>(arg1, arg2);
    }

    public fun lottery_set_prize_weights_bps<T0>(arg0: &0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::owner::OwnerCap, arg1: &mut 0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::lottery::Lottery<T0>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::lottery::admin_set_prize_weights_bps<T0>(arg1, arg2);
    }

    public fun lottery_upgrade_version<T0>(arg0: &0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::owner::OwnerCap, arg1: &mut 0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::lottery::Lottery<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::lottery::upgrade_version<T0>(arg1);
    }

    public fun sunsetSetAdmin<T0>(arg0: &0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::owner::OwnerCap, arg1: &mut 0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::sunset::Contract<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::sunset::set_admin<T0>(arg1, arg2);
    }

    public fun sunsetSetInvitees<T0>(arg0: &0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::owner::OwnerCap, arg1: &mut 0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::sunset::Contract<T0>, arg2: address, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::sunset::set_invitees<T0>(arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

