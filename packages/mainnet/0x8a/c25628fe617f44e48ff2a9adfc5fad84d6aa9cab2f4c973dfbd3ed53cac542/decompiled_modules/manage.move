module 0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::manage {
    public fun init_history_store(arg0: &0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::owner::OwnerCap, arg1: &mut 0x2::tx_context::TxContext) {
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::history::init_history_store(arg1);
    }

    public fun batch_appoint_user_level<T0, T1>(arg0: &0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::owner::OwnerCap, arg1: &mut 0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::sunset::Contract<T0, T1>, arg2: vector<address>, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::sunset::batch_appoint_user_level<T0, T1>(arg1, arg2, arg3);
    }

    public fun batch_import_history_users(arg0: &0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::owner::OwnerCap, arg1: &mut 0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::history::HistoryStore, arg2: vector<address>, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<u64>, arg6: &0x2::tx_context::TxContext) {
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::history::batch_import_users(arg1, arg2, arg3, arg4, arg5);
    }

    public fun batch_import_user_base_data<T0, T1>(arg0: &0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::owner::OwnerCap, arg1: &mut 0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::sunset::Contract<T0, T1>, arg2: vector<address>, arg3: vector<address>, arg4: vector<vector<address>>, arg5: vector<u8>, arg6: &0x2::tx_context::TxContext) {
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::sunset::batch_import_user_base_data<T0, T1>(arg1, arg2, arg3, arg4, arg5);
    }

    public fun init_contract<T0, T1>(arg0: &0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::owner::OwnerCap, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::sunset::init_contract<T0, T1>(arg1, arg2);
    }

    public fun set_admin<T0, T1>(arg0: &0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::owner::OwnerCap, arg1: &mut 0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::sunset::Contract<T0, T1>, arg2: address) {
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::sunset::set_admin<T0, T1>(arg1, arg2);
    }

    public fun set_price_oracle_rebot(arg0: &0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::owner::OwnerCap, arg1: &mut 0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::price_oracle::PriceOracle, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::price_oracle::update_rebot(arg1, arg2);
    }

    public fun set_sunset_rebot<T0, T1>(arg0: &0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::owner::OwnerCap, arg1: &mut 0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::sunset::Contract<T0, T1>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::sunset::set_rebot<T0, T1>(arg1, arg2);
    }

    public fun set_withdraw_fee_recipient<T0, T1>(arg0: &0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::owner::OwnerCap, arg1: &mut 0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::sunset::Contract<T0, T1>, arg2: address) {
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::sunset::set_withdraw_fee_recipient<T0, T1>(arg1, arg2);
    }

    // decompiled from Move bytecode v7
}

