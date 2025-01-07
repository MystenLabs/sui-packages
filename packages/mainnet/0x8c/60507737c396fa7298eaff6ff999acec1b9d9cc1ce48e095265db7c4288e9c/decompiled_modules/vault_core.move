module 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core {
    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        operator: address,
        developer: address,
    }

    struct DepositPauseUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        is_paused: bool,
    }

    struct SlippageToleranceUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        new_tolerance: u64,
    }

    struct OperatorUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        new_operator: address,
    }

    struct DeveloperUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        new_developer: address,
    }

    struct SharesUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        user: address,
        shares_change: u64,
        is_deposit: bool,
        shortfall: u64,
    }

    struct VaultConfig has copy, drop, store {
        vault_weight: u64,
        is_deposit_paused: bool,
        operator: address,
        developer: address,
        slippage_tolerance: u64,
        min_deposit_value: u64,
        max_deposit_value: u64,
    }

    struct SharesRecord has drop, store {
        vault_shares: u64,
        actual_shares: u64,
        direct_shares: u64,
        indirect_shares: u64,
        platform_shares: u64,
    }

    struct Vault has store, key {
        id: 0x2::object::UID,
        shares_supply: u64,
        user_shares: 0x2::linked_table::LinkedTable<address, SharesRecord>,
        vault_user_id: 0x2::object::ID,
        vault_profit_id: 0x2::object::ID,
        dex_manager_id: 0x2::object::ID,
        config: VaultConfig,
        data: 0x2::linked_table::LinkedTable<address, 0x2::vec_map::VecMap<u64, u64>>,
    }

    public(friend) fun assert_vault_operator(arg0: &Vault, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(&arg0.config.operator == &v0, 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::errors::unauthorized());
    }

    public(friend) fun create_vault(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = VaultConfig{
            vault_weight       : arg3,
            is_deposit_paused  : false,
            operator           : v0,
            developer          : v0,
            slippage_tolerance : 500,
            min_deposit_value  : 1000000,
            max_deposit_value  : 3000000000000,
        };
        let v2 = Vault{
            id              : 0x2::object::new(arg4),
            shares_supply   : 0,
            user_shares     : 0x2::linked_table::new<address, SharesRecord>(arg4),
            vault_user_id   : arg0,
            vault_profit_id : arg1,
            dex_manager_id  : arg2,
            config          : v1,
            data            : 0x2::linked_table::new<address, 0x2::vec_map::VecMap<u64, u64>>(arg4),
        };
        let v3 = 0x2::object::uid_to_inner(&v2.id);
        let v4 = VaultCreated{
            vault_id  : v3,
            operator  : v0,
            developer : v0,
        };
        0x2::event::emit<VaultCreated>(v4);
        0x2::transfer::share_object<Vault>(v2);
        v3
    }

    public(friend) fun deposit_pause(arg0: &mut Vault) {
        arg0.config.is_deposit_paused = true;
        let v0 = DepositPauseUpdated{
            vault_id  : 0x2::object::uid_to_inner(&arg0.id),
            is_paused : true,
        };
        0x2::event::emit<DepositPauseUpdated>(v0);
    }

    public(friend) fun fix_shares(arg0: &mut Vault) : bool {
        if (!0x2::linked_table::contains<address, SharesRecord>(&arg0.user_shares, @0x2012)) {
            let v0 = SharesRecord{
                vault_shares    : 0,
                actual_shares   : 0,
                direct_shares   : 0,
                indirect_shares : 0,
                platform_shares : 0,
            };
            0x2::linked_table::push_back<address, SharesRecord>(&mut arg0.user_shares, @0x2012, v0);
        };
        let v1 = 0;
        let v2 = 0x2::linked_table::front<address, SharesRecord>(&arg0.user_shares);
        while (0x1::option::is_some<address>(v2)) {
            let v3 = *0x1::option::borrow<address>(v2);
            v1 = v1 + 0x2::linked_table::borrow<address, SharesRecord>(&arg0.user_shares, v3).vault_shares;
            v2 = 0x2::linked_table::next<address, SharesRecord>(&arg0.user_shares, v3);
        };
        if (v1 != arg0.shares_supply) {
            let v4 = 0x2::linked_table::borrow_mut<address, SharesRecord>(&mut arg0.user_shares, @0x2012);
            let v5 = if (v1 > arg0.shares_supply) {
                v1 - arg0.shares_supply
            } else {
                arg0.shares_supply - v1
            };
            if (v1 > arg0.shares_supply) {
                if (v5 * 100 > arg0.shares_supply) {
                    return false
                };
                arg0.shares_supply = v1;
            } else {
                v4.vault_shares = v4.vault_shares + v5;
                v4.actual_shares = v4.actual_shares + v5;
            };
            let v6 = SharesUpdated{
                vault_id      : 0x2::object::uid_to_inner(&arg0.id),
                user          : @0x2012,
                shares_change : v5,
                is_deposit    : v1 < arg0.shares_supply,
                shortfall     : v5,
            };
            0x2::event::emit<SharesUpdated>(v6);
        };
        true
    }

    public entry fun get_data(arg0: &Vault, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2::vec_map::VecMap<u64, u64> {
        if (0x2::linked_table::contains<address, 0x2::vec_map::VecMap<u64, u64>>(&arg0.data, arg1)) {
            *0x2::linked_table::borrow<address, 0x2::vec_map::VecMap<u64, u64>>(&arg0.data, arg1)
        } else {
            0x2::vec_map::empty<u64, u64>()
        }
    }

    public fun get_deposit_range(arg0: &Vault) : (u64, u64) {
        (arg0.config.min_deposit_value, arg0.config.max_deposit_value)
    }

    public fun get_is_deposit_paused(arg0: &Vault) : bool {
        arg0.config.is_deposit_paused
    }

    public fun get_slippage_tolerance(arg0: &Vault) : u64 {
        arg0.config.slippage_tolerance
    }

    public entry fun get_user_shares(arg0: &Vault, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, u64) {
        user_shares(arg0, arg1)
    }

    public fun get_vault_weight(arg0: &Vault) : u64 {
        arg0.config.vault_weight
    }

    public fun is_developer(arg0: &Vault, arg1: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::tx_context::sender(arg1);
        &arg0.config.developer == &v0
    }

    public(friend) fun recover_shares(arg0: &0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::AdminCap, arg1: &mut Vault, arg2: &0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::VaultUser, arg3: address, arg4: address, arg5: &0x2::clock::Clock) {
        0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::assert_lost_user(arg2, arg3, arg5);
        if (0x2::linked_table::contains<address, SharesRecord>(&arg1.user_shares, arg3)) {
            let (v0, v1, v2, v3, v4) = user_shares(arg1, arg3);
            let v5 = 0x2::linked_table::borrow_mut<address, SharesRecord>(&mut arg1.user_shares, arg4);
            v5.vault_shares = v5.vault_shares + v0;
            v5.actual_shares = v5.actual_shares + v1;
            v5.direct_shares = v5.direct_shares + v2;
            v5.indirect_shares = v5.indirect_shares + v3;
            v5.platform_shares = v5.platform_shares + v4;
            let v6 = 0x2::linked_table::borrow_mut<address, SharesRecord>(&mut arg1.user_shares, arg3);
            v6.vault_shares = 0;
            v6.actual_shares = 0;
            v6.direct_shares = 0;
            v6.indirect_shares = 0;
            v6.platform_shares = 0;
        };
    }

    public fun relactive_ids(arg0: &Vault) : (0x2::object::ID, 0x2::object::ID, 0x2::object::ID) {
        (arg0.vault_user_id, arg0.vault_profit_id, arg0.dex_manager_id)
    }

    public entry fun set_developer(arg0: &mut Vault, arg1: &0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::VaultUser, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::assert_vault_admin(arg1, arg3);
        arg0.config.developer = arg2;
        let v0 = DeveloperUpdated{
            vault_id      : 0x2::object::uid_to_inner(&arg0.id),
            new_developer : arg2,
        };
        0x2::event::emit<DeveloperUpdated>(v0);
    }

    public entry fun set_operator(arg0: &mut Vault, arg1: &0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::VaultUser, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::assert_vault_admin(arg1, arg3);
        arg0.config.operator = arg2;
        let v0 = OperatorUpdated{
            vault_id     : 0x2::object::uid_to_inner(&arg0.id),
            new_operator : arg2,
        };
        0x2::event::emit<OperatorUpdated>(v0);
    }

    public(friend) fun shares_supply(arg0: &Vault) : u64 {
        arg0.shares_supply
    }

    public entry fun update_data_by_key(arg0: &mut Vault, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_vault_operator(arg0, arg4);
        if (!0x2::linked_table::contains<address, 0x2::vec_map::VecMap<u64, u64>>(&arg0.data, arg1)) {
            let v0 = 0x2::vec_map::empty<u64, u64>();
            0x2::vec_map::insert<u64, u64>(&mut v0, arg2, arg3);
            0x2::linked_table::push_back<address, 0x2::vec_map::VecMap<u64, u64>>(&mut arg0.data, arg1, v0);
            return
        };
        let v1 = 0x2::linked_table::borrow_mut<address, 0x2::vec_map::VecMap<u64, u64>>(&mut arg0.data, arg1);
        if (arg3 == 18446744073709551615) {
            let (_, _) = 0x2::vec_map::remove<u64, u64>(v1, &arg2);
        } else if (0x2::vec_map::contains<u64, u64>(v1, &arg2)) {
            *0x2::vec_map::get_mut<u64, u64>(v1, &arg2) = arg3;
        } else {
            0x2::vec_map::insert<u64, u64>(v1, arg2, arg3);
        };
    }

    public entry fun update_deposit_pause(arg0: &mut Vault, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert_vault_operator(arg0, arg2);
        arg0.config.is_deposit_paused = arg1;
        let v0 = DepositPauseUpdated{
            vault_id  : 0x2::object::uid_to_inner(&arg0.id),
            is_paused : arg1,
        };
        0x2::event::emit<DepositPauseUpdated>(v0);
    }

    public entry fun update_deposit_range(arg0: &mut Vault, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_vault_operator(arg0, arg3);
        assert!(arg1 <= arg0.config.max_deposit_value && arg2 >= arg0.config.min_deposit_value, 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::errors::invalid_amount());
        arg0.config.min_deposit_value = arg1;
        arg0.config.max_deposit_value = arg2;
    }

    public entry fun update_slippage_tolerance(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_vault_operator(arg0, arg2);
        assert!(arg1 <= 5000, 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::errors::invalid_slippage());
        arg0.config.slippage_tolerance = arg1;
        let v0 = SlippageToleranceUpdated{
            vault_id      : 0x2::object::uid_to_inner(&arg0.id),
            new_tolerance : arg1,
        };
        0x2::event::emit<SlippageToleranceUpdated>(v0);
    }

    public(friend) fun update_vault_shares(arg0: &mut Vault, arg1: &0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::VaultUser, arg2: address, arg3: u64, arg4: bool, arg5: u64) : (u64, u64, u64, u64) {
        assert!(arg3 > 0, 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::errors::insufficient_share());
        if (arg4) {
            arg0.shares_supply = arg0.shares_supply + arg3;
        } else {
            assert!(arg0.shares_supply >= arg3, 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::errors::insufficient_share());
            arg0.shares_supply = arg0.shares_supply - arg3;
        };
        if (!0x2::linked_table::contains<address, SharesRecord>(&arg0.user_shares, arg2)) {
            let v0 = SharesRecord{
                vault_shares    : 0,
                actual_shares   : 0,
                direct_shares   : 0,
                indirect_shares : 0,
                platform_shares : 0,
            };
            0x2::linked_table::push_back<address, SharesRecord>(&mut arg0.user_shares, arg2, v0);
        };
        let v1 = 0x2::linked_table::borrow_mut<address, SharesRecord>(&mut arg0.user_shares, arg2);
        let (v2, v3, v4) = 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::get_user_level_data(arg1, arg2);
        let v5 = 1000;
        let v6 = (((arg3 as u128) * (v2 as u128) / v5) as u64);
        let v7 = v6;
        let v8 = (((arg3 as u128) * (v3 as u128) / v5) as u64);
        let v9 = v8;
        let v10 = (((arg3 as u128) * (v4 as u128) / v5) as u64);
        let v11 = v10;
        let v12 = arg3 - v6 - v8 - v10;
        let v13 = v12;
        let v14 = 0;
        if (arg4) {
            v1.vault_shares = v1.vault_shares + arg3;
            v1.actual_shares = v1.actual_shares + v6;
            v1.direct_shares = v1.direct_shares + v8;
            v1.indirect_shares = v1.indirect_shares + v10;
            v1.platform_shares = v1.platform_shares + v12;
        } else {
            let v15 = if (arg3 > v1.vault_shares) {
                v1.vault_shares
            } else {
                arg3
            };
            v14 = arg3 - v15;
            let v16 = (v15 as u128) * v5 / (v1.vault_shares as u128);
            let v17 = (((v1.actual_shares as u128) * v16 / v5) as u64);
            v7 = v17;
            let v18 = (((v1.direct_shares as u128) * v16 / v5) as u64);
            v9 = v18;
            let v19 = (((v1.indirect_shares as u128) * v16 / v5) as u64);
            v11 = v19;
            let v20 = (((v1.platform_shares as u128) * v16 / v5) as u64);
            v13 = v20;
            v1.vault_shares = v1.vault_shares - v15;
            v1.actual_shares = v1.actual_shares - v17;
            v1.direct_shares = v1.direct_shares - v18;
            v1.indirect_shares = v1.indirect_shares - v19;
            v1.platform_shares = v1.platform_shares - v20;
        };
        if (v1.vault_shares == 0) {
            0x2::linked_table::remove<address, SharesRecord>(&mut arg0.user_shares, arg2);
        };
        let v21 = SharesUpdated{
            vault_id      : 0x2::object::id<Vault>(arg0),
            user          : arg2,
            shares_change : arg3,
            is_deposit    : arg4,
            shortfall     : v14,
        };
        0x2::event::emit<SharesUpdated>(v21);
        (v7, v9, v11, v13)
    }

    public(friend) fun user_shares(arg0: &Vault, arg1: address) : (u64, u64, u64, u64, u64) {
        if (0x2::linked_table::contains<address, SharesRecord>(&arg0.user_shares, arg1)) {
            let v5 = 0x2::linked_table::borrow<address, SharesRecord>(&arg0.user_shares, arg1);
            (v5.vault_shares, v5.actual_shares, v5.direct_shares, v5.indirect_shares, v5.platform_shares)
        } else {
            (0, 0, 0, 0, 0)
        }
    }

    // decompiled from Move bytecode v6
}

