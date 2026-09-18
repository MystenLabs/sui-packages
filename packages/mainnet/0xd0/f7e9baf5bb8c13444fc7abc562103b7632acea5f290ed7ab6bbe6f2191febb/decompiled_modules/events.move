module 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::events {
    struct LogOperate has copy, drop {
        user: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::Holder,
        token: 0x1::type_name::TypeName,
        supply_amount: u64,
        supply_is_negative: bool,
        borrow_amount: u64,
        borrow_is_negative: bool,
        withdraw_to: address,
        borrow_to: address,
        supply_exchange_price: u64,
        borrow_exchange_price: u64,
    }

    struct LogUpdateAuths has copy, drop {
        auths_status: vector<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::AddressBool>,
    }

    struct LogUpdateGuardians has copy, drop {
        guardians_status: vector<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::AddressBool>,
    }

    struct LogUpdateRevenueCollector has copy, drop {
        revenue_collector: address,
    }

    struct LogGlobalPauseChanged has copy, drop {
        action: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::pause::Action,
        on: bool,
        actor: address,
    }

    struct LogUpdateTokenConfigs has copy, drop {
        token: 0x1::type_name::TypeName,
        token_config: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::TokenConfig,
    }

    struct LogUpdateUserSupplyConfigs has copy, drop {
        user: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::Holder,
        token: 0x1::type_name::TypeName,
        user_supply_config: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::UserSupplyConfig,
    }

    struct LogUpdateUserBorrowConfigs has copy, drop {
        user: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::Holder,
        token: 0x1::type_name::TypeName,
        user_borrow_config: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::UserBorrowConfig,
    }

    struct LogPositionPauseChanged has copy, drop {
        user: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::Holder,
        token: 0x1::type_name::TypeName,
        action: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::pause::Action,
        on: bool,
        actor: address,
    }

    struct LogUpdateRateDataV1s has copy, drop {
        token: 0x1::type_name::TypeName,
        rate_data: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::RateDataV1Params,
    }

    struct LogUpdateRateDataV2s has copy, drop {
        token: 0x1::type_name::TypeName,
        rate_data: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::RateDataV2Params,
    }

    struct LogCollectRevenue has copy, drop {
        token: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct LogUpdateExchangePrices has copy, drop {
        token: 0x1::type_name::TypeName,
        supply_exchange_price: u64,
        borrow_exchange_price: u64,
        borrow_rate: u64,
        utilization: u64,
    }

    struct LogUpdateUserWithdrawalLimit has copy, drop {
        user: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::Holder,
        token: 0x1::type_name::TypeName,
        new_limit: u64,
    }

    struct LogMintUserCap has copy, drop {
        user_cap: 0x2::object::ID,
        user: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::Holder,
        token: 0x1::type_name::TypeName,
    }

    struct LogSetUserAuthorization has copy, drop {
        user_cap: 0x2::object::ID,
        user: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::Holder,
        token: 0x1::type_name::TypeName,
        authorized: bool,
    }

    struct LogTokenPauseChanged has copy, drop {
        token: 0x1::type_name::TypeName,
        action: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::pause::Action,
        on: bool,
        actor: address,
    }

    struct LogAddAdmin has copy, drop {
        owner: address,
    }

    struct LogRemoveAdmin has copy, drop {
        owner: address,
    }

    struct LogMigrate has copy, drop {
        old_version: u64,
        new_version: u64,
    }

    struct LogBorrowRateCap has copy, drop {
        token: 0x1::type_name::TypeName,
    }

    public(friend) fun emit_log_add_admin(arg0: address) {
        let v0 = LogAddAdmin{owner: arg0};
        0x2::event::emit<LogAddAdmin>(v0);
    }

    public(friend) fun emit_log_borrow_rate_cap(arg0: 0x1::type_name::TypeName) {
        let v0 = LogBorrowRateCap{token: arg0};
        0x2::event::emit<LogBorrowRateCap>(v0);
    }

    public(friend) fun emit_log_collect_revenue(arg0: 0x1::type_name::TypeName, arg1: u64) {
        let v0 = LogCollectRevenue{
            token  : arg0,
            amount : arg1,
        };
        0x2::event::emit<LogCollectRevenue>(v0);
    }

    public(friend) fun emit_log_global_pause_changed(arg0: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::pause::Action, arg1: bool, arg2: address) {
        let v0 = LogGlobalPauseChanged{
            action : arg0,
            on     : arg1,
            actor  : arg2,
        };
        0x2::event::emit<LogGlobalPauseChanged>(v0);
    }

    public(friend) fun emit_log_migrate(arg0: u64, arg1: u64) {
        let v0 = LogMigrate{
            old_version : arg0,
            new_version : arg1,
        };
        0x2::event::emit<LogMigrate>(v0);
    }

    public(friend) fun emit_log_mint_user_cap(arg0: 0x2::object::ID, arg1: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::Holder, arg2: 0x1::type_name::TypeName) {
        let v0 = LogMintUserCap{
            user_cap : arg0,
            user     : arg1,
            token    : arg2,
        };
        0x2::event::emit<LogMintUserCap>(v0);
    }

    public(friend) fun emit_log_operate(arg0: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::Holder, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: bool, arg4: u64, arg5: bool, arg6: address, arg7: address, arg8: u64, arg9: u64) {
        let v0 = LogOperate{
            user                  : arg0,
            token                 : arg1,
            supply_amount         : arg2,
            supply_is_negative    : arg3,
            borrow_amount         : arg4,
            borrow_is_negative    : arg5,
            withdraw_to           : arg6,
            borrow_to             : arg7,
            supply_exchange_price : arg8,
            borrow_exchange_price : arg9,
        };
        0x2::event::emit<LogOperate>(v0);
    }

    public(friend) fun emit_log_position_pause_changed(arg0: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::Holder, arg1: 0x1::type_name::TypeName, arg2: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::pause::Action, arg3: bool, arg4: address) {
        let v0 = LogPositionPauseChanged{
            user   : arg0,
            token  : arg1,
            action : arg2,
            on     : arg3,
            actor  : arg4,
        };
        0x2::event::emit<LogPositionPauseChanged>(v0);
    }

    public(friend) fun emit_log_remove_admin(arg0: address) {
        let v0 = LogRemoveAdmin{owner: arg0};
        0x2::event::emit<LogRemoveAdmin>(v0);
    }

    public(friend) fun emit_log_set_user_authorization(arg0: 0x2::object::ID, arg1: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::Holder, arg2: 0x1::type_name::TypeName, arg3: bool) {
        let v0 = LogSetUserAuthorization{
            user_cap   : arg0,
            user       : arg1,
            token      : arg2,
            authorized : arg3,
        };
        0x2::event::emit<LogSetUserAuthorization>(v0);
    }

    public(friend) fun emit_log_token_pause_changed(arg0: 0x1::type_name::TypeName, arg1: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::pause::Action, arg2: bool, arg3: address) {
        let v0 = LogTokenPauseChanged{
            token  : arg0,
            action : arg1,
            on     : arg2,
            actor  : arg3,
        };
        0x2::event::emit<LogTokenPauseChanged>(v0);
    }

    public(friend) fun emit_log_update_auths(arg0: vector<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::AddressBool>) {
        let v0 = LogUpdateAuths{auths_status: arg0};
        0x2::event::emit<LogUpdateAuths>(v0);
    }

    public(friend) fun emit_log_update_exchange_prices(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = LogUpdateExchangePrices{
            token                 : arg0,
            supply_exchange_price : arg1,
            borrow_exchange_price : arg2,
            borrow_rate           : arg3,
            utilization           : arg4,
        };
        0x2::event::emit<LogUpdateExchangePrices>(v0);
    }

    public(friend) fun emit_log_update_guardians(arg0: vector<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::AddressBool>) {
        let v0 = LogUpdateGuardians{guardians_status: arg0};
        0x2::event::emit<LogUpdateGuardians>(v0);
    }

    public(friend) fun emit_log_update_rate_data_v1s(arg0: 0x1::type_name::TypeName, arg1: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::RateDataV1Params) {
        let v0 = LogUpdateRateDataV1s{
            token     : arg0,
            rate_data : arg1,
        };
        0x2::event::emit<LogUpdateRateDataV1s>(v0);
    }

    public(friend) fun emit_log_update_rate_data_v2s(arg0: 0x1::type_name::TypeName, arg1: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::RateDataV2Params) {
        let v0 = LogUpdateRateDataV2s{
            token     : arg0,
            rate_data : arg1,
        };
        0x2::event::emit<LogUpdateRateDataV2s>(v0);
    }

    public(friend) fun emit_log_update_revenue_collector(arg0: address) {
        let v0 = LogUpdateRevenueCollector{revenue_collector: arg0};
        0x2::event::emit<LogUpdateRevenueCollector>(v0);
    }

    public(friend) fun emit_log_update_token_configs(arg0: 0x1::type_name::TypeName, arg1: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::TokenConfig) {
        let v0 = LogUpdateTokenConfigs{
            token        : arg0,
            token_config : arg1,
        };
        0x2::event::emit<LogUpdateTokenConfigs>(v0);
    }

    public(friend) fun emit_log_update_user_borrow_configs(arg0: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::Holder, arg1: 0x1::type_name::TypeName, arg2: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::UserBorrowConfig) {
        let v0 = LogUpdateUserBorrowConfigs{
            user               : arg0,
            token              : arg1,
            user_borrow_config : arg2,
        };
        0x2::event::emit<LogUpdateUserBorrowConfigs>(v0);
    }

    public(friend) fun emit_log_update_user_supply_configs(arg0: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::Holder, arg1: 0x1::type_name::TypeName, arg2: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::UserSupplyConfig) {
        let v0 = LogUpdateUserSupplyConfigs{
            user               : arg0,
            token              : arg1,
            user_supply_config : arg2,
        };
        0x2::event::emit<LogUpdateUserSupplyConfigs>(v0);
    }

    public(friend) fun emit_log_update_user_withdrawal_limit(arg0: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::Holder, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = LogUpdateUserWithdrawalLimit{
            user      : arg0,
            token     : arg1,
            new_limit : arg2,
        };
        0x2::event::emit<LogUpdateUserWithdrawalLimit>(v0);
    }

    // decompiled from Move bytecode v7
}

