module 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault {
    struct VaultInfo<phantom T0> has store {
        config_addr: address,
        vault_debt_share: u64,
        vault_debt_val: u64,
        last_accrue_time: u64,
        reserve_pool: u64,
        decimals: u8,
        coin: 0x2::balance::Balance<T0>,
        magic_coin_supply: 0x2::balance::Supply<MagicCoin<T0>>,
        debt_coin_supply: 0x2::balance::Supply<DebtCoin<T0>>,
        positions: 0x2::table::Table<u64, Position<T0>>,
        next_position_id: u64,
        fair_launch_user_cap: 0xba0311e40e1a18d048a20a0cbd1f5ca50c7b8a3c9b06e9b08f4e76b2489b2830::fair_launch::UserCapability<DebtCoin<T0>>,
    }

    struct MagicCoin<phantom T0> has drop {
        dummy_field: bool,
    }

    struct DebtCoin<phantom T0> has drop {
        dummy_field: bool,
    }

    struct AddCollateralContext<phantom T0> {
        id: u64,
        debt: u64,
        coin_send: 0x2::coin::Coin<T0>,
        health_before: u64,
        worker: address,
        amount: u64,
    }

    struct WorkContext<phantom T0> {
        id: u64,
        debt: u64,
        coin_send: 0x2::coin::Coin<T0>,
        coin_back: 0x2::coin::Coin<T0>,
        health: u64,
        account_addr: address,
    }

    struct KillContext<phantom T0> {
        id: u64,
        debt: u64,
        coin_back: 0x2::coin::Coin<T0>,
        health: u64,
        liquidator_addr: address,
    }

    struct Position<phantom T0> has drop, store {
        worker: address,
        owner: address,
        debt_share: u64,
    }

    struct DepositEvent<phantom T0> has copy, drop {
        account: address,
        amount: u64,
        share: u64,
    }

    struct WithdrawEvent<phantom T0> has copy, drop {
        account: address,
        share: u64,
        amount: u64,
    }

    struct AddDebtEvent<phantom T0> has copy, drop {
        id: u64,
        debt_share: u64,
    }

    struct RemoveDebtEvent<phantom T0> has copy, drop {
        id: u64,
        debt_share: u64,
    }

    struct WorkEvent<phantom T0> has copy, drop {
        id: u64,
        loan: u64,
    }

    struct KillEvent<phantom T0> has copy, drop {
        id: u64,
        killer: address,
        owner: address,
        posVal: u64,
        debt: u64,
        prize: u64,
        left: u64,
    }

    struct AddCollateralEvent<phantom T0> has copy, drop {
        id: u64,
        amount: u64,
        health_before: u64,
        health_after: u64,
    }

    struct PositionOperatorFeature<phantom T0> {
        dummy_field: bool,
    }

    struct VaultCap<phantom T0> has store {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct PositionSignerCap<phantom T0> has store {
        account: address,
    }

    struct PositionSigner<phantom T0> has drop {
        address: address,
    }

    fun accrue<T0>(arg0: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_shared<VaultInfo<T0>>(arg0);
        let v1 = 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault_config::get_reserve_pool_bps(arg0, v0.config_addr);
        let v2 = now_seconds(arg2);
        if (v2 > v0.last_accrue_time) {
            let v3 = pending_interest_inner<T0>(arg0, arg1, arg2);
            let v4 = 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_mut_shared<VaultInfo<T0>>(arg0);
            v4.reserve_pool = v4.reserve_pool + v3 * v1 / 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault_config::get_reserve_pool_bps_scale();
            v4.vault_debt_val = v4.vault_debt_val + v3;
            v4.last_accrue_time = v2;
        };
    }

    public fun acquire_position_operator_cap<T0>(arg0: &AdminCap) : VaultCap<PositionOperatorFeature<T0>> {
        VaultCap<PositionOperatorFeature<T0>>{dummy_field: false}
    }

    fun add_debt<T0>(arg0: u64, arg1: u64, arg2: &mut Position<T0>, arg3: &mut u64, arg4: &mut u64) {
        let v0 = debt_val_to_share<T0>(*arg3, *arg4, arg1);
        arg2.debt_share = arg2.debt_share + v0;
        *arg3 = *arg3 + v0;
        *arg4 = *arg4 + arg1;
        let v1 = AddDebtEvent<T0>{
            id         : arg0,
            debt_share : v0,
        };
        0x2::event::emit<AddDebtEvent<T0>>(v1);
    }

    public fun after_add_collateral<T0>(arg0: &VaultCap<PositionOperatorFeature<T0>>, arg1: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg2: AddCollateralContext<T0>, arg3: bool, arg4: u64, arg5: bool, arg6: bool) {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg1);
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::emergency::assert_no_emergency(0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_emergency_status(arg1));
        let AddCollateralContext {
            id            : v0,
            debt          : v1,
            coin_send     : v2,
            health_before : v3,
            worker        : v4,
            amount        : v5,
        } = arg2;
        0x2::coin::destroy_zero<T0>(v2);
        if (!arg3) {
            assert!(arg5, 17);
        } else {
            assert!(arg6, 18);
        };
        assert!(arg4 > v3, 19);
        assert!((v1 as u128) * (0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault_config::get_kill_factor_scale() as u128) <= (arg4 as u128) * ((0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault_config::get_raw_kill_factor(arg1, 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_mut_shared<VaultInfo<T0>>(arg1).config_addr, v4, v1) - 100) as u128), 20);
        let v6 = AddCollateralEvent<T0>{
            id            : v0,
            amount        : v5,
            health_before : v3,
            health_after  : arg4,
        };
        0x2::event::emit<AddCollateralEvent<T0>>(v6);
    }

    public fun after_kill<T0>(arg0: &VaultCap<PositionOperatorFeature<T0>>, arg1: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg2: &mut 0xba0311e40e1a18d048a20a0cbd1f5ca50c7b8a3c9b06e9b08f4e76b2489b2830::fair_launch::Storage, arg3: &PositionSigner<T0>, arg4: KillContext<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg1);
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::emergency::assert_no_emergency(0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_emergency_status(arg1));
        let v0 = arg3.address;
        let KillContext {
            id              : v1,
            debt            : v2,
            coin_back       : v3,
            health          : v4,
            liquidator_addr : v5,
        } = arg4;
        let v6 = v3;
        let v7 = 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_shared<VaultInfo<T0>>(arg1).config_addr;
        assert!(is_whitelisted_liquidator<T0>(arg1, v7, v5), 21);
        assert!(v5 == v0, 22);
        let v8 = 0x2::coin::value<T0>(&v6);
        let v9 = 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_mut_shared<VaultInfo<T0>>(arg1);
        let v10 = 0x2::table::borrow_mut<u64, Position<T0>>(&mut v9.positions, v1);
        let v11 = 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::mole_math::mul_div(v8, 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault_config::get_kill_bps(arg1, v7), 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault_config::get_kill_bps_scale());
        let v12 = 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::mole_math::mul_div(v8, 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault_config::get_kill_treasury_bps(arg1, v7), 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault_config::get_kill_treasury_bps_scale());
        let v13 = v11 + v12;
        let v14 = v8 - v13;
        if (v11 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v6, v11, arg5), arg3.address);
        };
        if (v12 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v6, v12, arg5), 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault_config::get_treasury_addr(arg1, v7));
        };
        let v15 = 0;
        if (v14 > v2) {
            v15 = v14 - v2;
        };
        if (v15 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v6, v15, arg5), v10.owner);
        };
        if (0x2::coin::value<T0>(&v6) > 0) {
            0x2::balance::join<T0>(&mut v9.coin, 0x2::coin::into_balance<T0>(v6));
        } else {
            0x2::coin::destroy_zero<T0>(v6);
        };
        let v16 = KillEvent<T0>{
            id     : v1,
            killer : v0,
            owner  : v10.owner,
            posVal : v4,
            debt   : v2,
            prize  : v13,
            left   : v15,
        };
        0x2::event::emit<KillEvent<T0>>(v16);
    }

    public fun after_work<T0>(arg0: &VaultCap<PositionOperatorFeature<T0>>, arg1: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg2: &mut 0xba0311e40e1a18d048a20a0cbd1f5ca50c7b8a3c9b06e9b08f4e76b2489b2830::fair_launch::Storage, arg3: &PositionSigner<T0>, arg4: WorkContext<T0>, arg5: u64, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x7a0caf79f7be8324397b6e139c202630149651ed6456c5ff2c79de05a7401fac::mole::MOLE> {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg1);
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::emergency::assert_no_emergency(0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_emergency_status(arg1));
        let WorkContext {
            id           : v0,
            debt         : v1,
            coin_send    : v2,
            coin_back    : v3,
            health       : v4,
            account_addr : v5,
        } = arg4;
        let v6 = v3;
        let v7 = arg3.address;
        assert!(v5 == v7, 22);
        let v8 = 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_mut_shared<VaultInfo<T0>>(arg1);
        let v9 = 0x2::coin::value<T0>(&v6);
        0x2::balance::join<T0>(&mut v8.coin, 0x2::coin::into_balance<T0>(v6));
        let v10 = 0x2::math::min(v1, 0x2::math::min(v9, arg5));
        let v11 = v1 - v10;
        let v12 = v8.config_addr;
        let v13 = if (v11 > 0) {
            assert!(v11 >= 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault_config::get_min_debt_size(arg1, v12), 8);
            assert!((v4 as u128) * (0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault_config::get_work_factor(arg1, v12, 0x2::table::borrow_mut<u64, Position<T0>>(&mut v8.positions, v0).worker, v11, arg6) as u128) >= (v11 as u128) * (0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault_config::get_work_factor_scale() as u128), 9);
            let v14 = 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_mut_shared<VaultInfo<T0>>(arg1);
            let v15 = 0x2::table::borrow_mut<u64, Position<T0>>(&mut v14.positions, v0);
            let v16 = &mut v14.vault_debt_share;
            let v17 = &mut v14.vault_debt_val;
            add_debt<T0>(v0, v11, v15, v16, v17);
            let v18 = &mut v14.debt_coin_supply;
            fair_launch_deposit<T0>(arg2, v18, v15, &v14.fair_launch_user_cap, arg7, arg8)
        } else {
            0x2::coin::zero<0x7a0caf79f7be8324397b6e139c202630149651ed6456c5ff2c79de05a7401fac::mole::MOLE>(arg8)
        };
        if (v9 > v10) {
            let v19 = 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_mut_shared<VaultInfo<T0>>(arg1);
            transfer_coin_from_vault<T0>(v19, v7, v9 - v10, arg8);
        };
        0x2::coin::destroy_zero<T0>(v2);
        v13
    }

    public fun after_worker_direct_external<T0>(arg0: &VaultCap<PositionOperatorFeature<T0>>, arg1: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg2: &mut 0xba0311e40e1a18d048a20a0cbd1f5ca50c7b8a3c9b06e9b08f4e76b2489b2830::fair_launch::Storage, arg3: &PositionSigner<T0>, arg4: WorkContext<T0>, arg5: u64, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0x7a0caf79f7be8324397b6e139c202630149651ed6456c5ff2c79de05a7401fac::mole::MOLE>) {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg1);
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::emergency::assert_no_emergency(0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_emergency_status(arg1));
        let WorkContext {
            id           : v0,
            debt         : v1,
            coin_send    : v2,
            coin_back    : v3,
            health       : v4,
            account_addr : v5,
        } = arg4;
        let v6 = v3;
        assert!(v5 == arg3.address, 22);
        let v7 = 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_mut_shared<VaultInfo<T0>>(arg1);
        let v8 = 0x2::coin::value<T0>(&v6);
        0x2::balance::join<T0>(&mut v7.coin, 0x2::coin::into_balance<T0>(v6));
        let v9 = 0x2::math::min(v1, 0x2::math::min(v8, arg5));
        let v10 = v1 - v9;
        let v11 = v7.config_addr;
        let v12 = if (v10 > 0) {
            assert!(v10 >= 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault_config::get_min_debt_size(arg1, v11), 8);
            assert!((v4 as u128) * (0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault_config::get_work_factor(arg1, v11, 0x2::table::borrow_mut<u64, Position<T0>>(&mut v7.positions, v0).worker, v10, arg6) as u128) >= (v10 as u128) * (0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault_config::get_work_factor_scale() as u128), 9);
            let v13 = 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_mut_shared<VaultInfo<T0>>(arg1);
            let v14 = 0x2::table::borrow_mut<u64, Position<T0>>(&mut v13.positions, v0);
            let v15 = &mut v13.vault_debt_share;
            let v16 = &mut v13.vault_debt_val;
            add_debt<T0>(v0, v10, v14, v15, v16);
            let v17 = &mut v13.debt_coin_supply;
            fair_launch_deposit<T0>(arg2, v17, v14, &v13.fair_launch_user_cap, arg7, arg8)
        } else {
            0x2::coin::zero<0x7a0caf79f7be8324397b6e139c202630149651ed6456c5ff2c79de05a7401fac::mole::MOLE>(arg8)
        };
        let v18 = if (v8 > v9) {
            let v19 = 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_mut_shared<VaultInfo<T0>>(arg1);
            get_coin_from_vault<T0>(v19, v8 - v9, arg8)
        } else {
            0x2::coin::zero<T0>(arg8)
        };
        0x2::coin::destroy_zero<T0>(v2);
        (v18, v12)
    }

    public fun before_add_collateral<T0>(arg0: &VaultCap<PositionOperatorFeature<T0>>, arg1: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg2: &mut 0xba0311e40e1a18d048a20a0cbd1f5ca50c7b8a3c9b06e9b08f4e76b2489b2830::fair_launch::Storage, arg3: &PositionSigner<T0>, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: bool, arg7: u64, arg8: bool, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : AddCollateralContext<T0> {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg1);
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::emergency::assert_no_emergency(0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_emergency_status(arg1));
        let v0 = 0x2::coin::value<T0>(&arg5);
        let v1 = 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_mut_shared<VaultInfo<T0>>(arg1);
        transfer_coin_to_vault<T0>(v1, arg5, v0, arg11);
        accrue<T0>(arg1, v0, arg10);
        assert!(0xba0311e40e1a18d048a20a0cbd1f5ca50c7b8a3c9b06e9b08f4e76b2489b2830::fair_launch::exists_pool<DebtCoin<T0>>(arg2), 12);
        assert!(arg4 != 0, 15);
        let v2 = 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_mut_shared<VaultInfo<T0>>(arg1);
        let v3 = 0x2::table::borrow_mut<u64, Position<T0>>(&mut v2.positions, arg4);
        assert!(v3.owner == arg3.address, 6);
        assert!(arg7 != 0, 16);
        if (!arg6) {
            assert!(arg8, 17);
        } else {
            assert!(arg9, 18);
        };
        AddCollateralContext<T0>{
            id            : arg4,
            debt          : debt_share_to_val(v2.vault_debt_share, v2.vault_debt_val, v3.debt_share),
            coin_send     : 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v2.coin, v0), arg11),
            health_before : arg7,
            worker        : v3.worker,
            amount        : v0,
        }
    }

    public fun before_kill<T0>(arg0: &VaultCap<PositionOperatorFeature<T0>>, arg1: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg2: &mut 0xba0311e40e1a18d048a20a0cbd1f5ca50c7b8a3c9b06e9b08f4e76b2489b2830::fair_launch::Storage, arg3: &PositionSigner<T0>, arg4: u64, arg5: u64, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : KillContext<T0> {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg1);
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::emergency::assert_no_emergency(0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_emergency_status(arg1));
        let v0 = arg3.address;
        assert!(is_whitelisted_liquidator<T0>(arg1, 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_shared<VaultInfo<T0>>(arg1).config_addr, v0), 21);
        accrue<T0>(arg1, 0, arg7);
        assert!(0xba0311e40e1a18d048a20a0cbd1f5ca50c7b8a3c9b06e9b08f4e76b2489b2830::fair_launch::exists_pool<DebtCoin<T0>>(arg2), 12);
        let v1 = 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_mut_shared<VaultInfo<T0>>(arg1);
        let v2 = 0x2::table::borrow_mut<u64, Position<T0>>(&mut v1.positions, arg4);
        assert!(v2.debt_share > 0, 13);
        let v3 = &mut v1.debt_coin_supply;
        let v4 = fair_launch_withdraw<T0>(arg2, v3, v2, &v1.fair_launch_user_cap, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x7a0caf79f7be8324397b6e139c202630149651ed6456c5ff2c79de05a7401fac::mole::MOLE>>(v4, v2.owner);
        let v5 = &mut v1.vault_debt_share;
        let v6 = &mut v1.vault_debt_val;
        let v7 = remove_debt<T0>(arg4, v2, v5, v6);
        assert!((arg5 as u128) * (0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault_config::get_kill_factor(arg1, v1.config_addr, v2.worker, v7, arg6) as u128) < (v7 as u128) * (0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault_config::get_kill_factor_scale() as u128), 14);
        KillContext<T0>{
            id              : arg4,
            debt            : v7,
            coin_back       : 0x2::coin::zero<T0>(arg8),
            health          : arg5,
            liquidator_addr : v0,
        }
    }

    public fun before_work<T0>(arg0: &VaultCap<PositionOperatorFeature<T0>>, arg1: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg2: &mut 0xba0311e40e1a18d048a20a0cbd1f5ca50c7b8a3c9b06e9b08f4e76b2489b2830::fair_launch::Storage, arg3: &PositionSigner<T0>, arg4: u64, arg5: address, arg6: 0x2::coin::Coin<T0>, arg7: u64, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (WorkContext<T0>, 0x2::coin::Coin<0x7a0caf79f7be8324397b6e139c202630149651ed6456c5ff2c79de05a7401fac::mole::MOLE>) {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg1);
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::emergency::assert_no_emergency(0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_emergency_status(arg1));
        let v0 = 0x2::coin::value<T0>(&arg6);
        let v1 = 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_mut_shared<VaultInfo<T0>>(arg1);
        transfer_coin_to_vault<T0>(v1, arg6, v0, arg10);
        accrue<T0>(arg1, v0, arg9);
        assert!(0xba0311e40e1a18d048a20a0cbd1f5ca50c7b8a3c9b06e9b08f4e76b2489b2830::fair_launch::exists_pool<DebtCoin<T0>>(arg2), 12);
        let v2 = arg3.address;
        let v3 = 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_shared<VaultInfo<T0>>(arg1).config_addr;
        let v4 = 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_mut_shared<VaultInfo<T0>>(arg1);
        let v5 = &mut v4.positions;
        let v6 = false;
        if (arg4 == 0) {
            let v7 = v4.next_position_id;
            arg4 = v7;
            v4.next_position_id = v7 + 1;
            let v8 = Position<T0>{
                worker     : arg5,
                owner      : v2,
                debt_share : 0,
            };
            0x2::table::add<u64, Position<T0>>(v5, v7, v8);
        } else {
            assert!(arg4 < v4.next_position_id, 4);
            v6 = true;
        };
        let v9 = WorkEvent<T0>{
            id   : arg4,
            loan : arg7,
        };
        0x2::event::emit<WorkEvent<T0>>(v9);
        let v10 = 0x2::table::borrow_mut<u64, Position<T0>>(v5, arg4);
        let v11 = if (v6) {
            let v12 = &mut v4.debt_coin_supply;
            fair_launch_withdraw<T0>(arg2, v12, v10, &v4.fair_launch_user_cap, arg9, arg10)
        } else {
            0x2::coin::zero<0x7a0caf79f7be8324397b6e139c202630149651ed6456c5ff2c79de05a7401fac::mole::MOLE>(arg10)
        };
        assert!(v10.worker == arg5, 5);
        assert!(v10.owner == v2, 6);
        assert!(0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault_config::is_worker(arg1, v3, arg5), 10);
        assert!(arg7 == 0 || 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault_config::get_accept_debt(arg1, v3, arg5, arg8), 11);
        let v13 = &mut v4.vault_debt_share;
        let v14 = &mut v4.vault_debt_val;
        let v15 = v0 + arg7;
        assert!(0x2::balance::value<T0>(&v4.coin) >= v15, 7);
        let v16 = WorkContext<T0>{
            id           : arg4,
            debt         : remove_debt<T0>(arg4, v10, v13, v14) + arg7,
            coin_send    : 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v4.coin, v15), arg10),
            coin_back    : 0x2::coin::zero<T0>(arg10),
            health       : 0,
            account_addr : v2,
        };
        (v16, v11)
    }

    fun burn_debt_coin<T0>(arg0: &mut 0x2::balance::Supply<DebtCoin<T0>>, arg1: 0x2::coin::Coin<DebtCoin<T0>>) {
        0x2::balance::decrease_supply<DebtCoin<T0>>(arg0, 0x2::coin::into_balance<DebtCoin<T0>>(arg1));
    }

    fun burn_magic_coin<T0>(arg0: &mut VaultInfo<T0>, arg1: 0x2::coin::Coin<MagicCoin<T0>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::decrease_supply<MagicCoin<T0>>(&mut arg0.magic_coin_supply, 0x2::coin::into_balance<MagicCoin<T0>>(0x2::coin::split<MagicCoin<T0>>(&mut arg1, arg2, arg3)));
        if (0x2::coin::value<MagicCoin<T0>>(&arg1) != 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<MagicCoin<T0>>>(arg1, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<MagicCoin<T0>>(arg1);
        };
    }

    fun debt_share_to_val(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg0 == 0) {
            return arg2
        };
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::mole_math::mul_div(arg2, arg1, arg0)
    }

    fun debt_val_to_share<T0>(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg0 == 0) {
            return arg2
        };
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::mole_math::mul_div(arg2, arg0, arg1)
    }

    public entry fun deposit<T0>(arg0: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg0);
        let v0 = 0x2::coin::zero<T0>(arg4);
        0x2::pay::join_vec<T0>(&mut v0, arg1);
        deposit_single<T0>(arg0, v0, arg2, arg3, arg4);
    }

    public entry fun deposit_single<T0>(arg0: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg0);
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::emergency::assert_no_emergency(0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_emergency_status(arg0));
        let v0 = 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_mut_shared<VaultInfo<T0>>(arg0);
        transfer_coin_to_vault<T0>(v0, arg1, arg2, arg4);
        accrue<T0>(arg0, arg2, arg3);
        let v1 = 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_mut_shared<VaultInfo<T0>>(arg0);
        let v2 = total_token_from_vault_info<T0>(v1) - arg2;
        let v3 = if (v2 == 0) {
            arg2
        } else {
            (((arg2 as u128) * (0x2::balance::supply_value<MagicCoin<T0>>(&v1.magic_coin_supply) as u128) / (v2 as u128)) as u64)
        };
        let v4 = 0x2::tx_context::sender(arg4);
        mint_magic_coin<T0>(v1, v4, v3, arg4);
        assert!(0x2::balance::supply_value<MagicCoin<T0>>(&v1.magic_coin_supply) > 0x2::math::pow(10, v1.decimals - 1), 2);
        let v5 = DepositEvent<T0>{
            account : 0x2::tx_context::sender(arg4),
            amount  : arg2,
            share   : v3,
        };
        0x2::event::emit<DepositEvent<T0>>(v5);
    }

    public fun extract_add_collateral_context_coin_send<T0>(arg0: &mut AddCollateralContext<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::split<T0>(&mut arg0.coin_send, 0x2::coin::value<T0>(&arg0.coin_send), arg1)
    }

    public fun extract_work_context_coin_send<T0>(arg0: &mut WorkContext<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::split<T0>(&mut arg0.coin_send, 0x2::coin::value<T0>(&arg0.coin_send), arg1)
    }

    fun fair_launch_deposit<T0>(arg0: &mut 0xba0311e40e1a18d048a20a0cbd1f5ca50c7b8a3c9b06e9b08f4e76b2489b2830::fair_launch::Storage, arg1: &mut 0x2::balance::Supply<DebtCoin<T0>>, arg2: &Position<T0>, arg3: &0xba0311e40e1a18d048a20a0cbd1f5ca50c7b8a3c9b06e9b08f4e76b2489b2830::fair_launch::UserCapability<DebtCoin<T0>>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x7a0caf79f7be8324397b6e139c202630149651ed6456c5ff2c79de05a7401fac::mole::MOLE> {
        let v0 = arg2.debt_share;
        if (v0 > 0) {
            let v1 = mint_debt_coin<T0>(arg1, v0, arg5);
            return 0xba0311e40e1a18d048a20a0cbd1f5ca50c7b8a3c9b06e9b08f4e76b2489b2830::fair_launch::deposit_with_cap<DebtCoin<T0>>(arg0, arg3, arg2.owner, false, v1, arg4, arg5)
        };
        0x2::coin::zero<0x7a0caf79f7be8324397b6e139c202630149651ed6456c5ff2c79de05a7401fac::mole::MOLE>(arg5)
    }

    fun fair_launch_withdraw<T0>(arg0: &mut 0xba0311e40e1a18d048a20a0cbd1f5ca50c7b8a3c9b06e9b08f4e76b2489b2830::fair_launch::Storage, arg1: &mut 0x2::balance::Supply<DebtCoin<T0>>, arg2: &Position<T0>, arg3: &0xba0311e40e1a18d048a20a0cbd1f5ca50c7b8a3c9b06e9b08f4e76b2489b2830::fair_launch::UserCapability<DebtCoin<T0>>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x7a0caf79f7be8324397b6e139c202630149651ed6456c5ff2c79de05a7401fac::mole::MOLE> {
        if (arg2.debt_share > 0) {
            let (v0, v1) = 0xba0311e40e1a18d048a20a0cbd1f5ca50c7b8a3c9b06e9b08f4e76b2489b2830::fair_launch::withdraw_with_cap<DebtCoin<T0>>(arg0, arg3, arg2.owner, false, arg2.debt_share, arg4, arg5);
            burn_debt_coin<T0>(arg1, v0);
            return v1
        };
        0x2::coin::zero<0x7a0caf79f7be8324397b6e139c202630149651ed6456c5ff2c79de05a7401fac::mole::MOLE>(arg5)
    }

    public fun get_add_collateral_context_debt<T0>(arg0: &AddCollateralContext<T0>) : u64 {
        arg0.debt
    }

    fun get_coin_from_vault<T0>(arg0: &mut VaultInfo<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (arg1 > 0) {
            return 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin, arg1), arg2)
        };
        0x2::coin::zero<T0>(arg2)
    }

    public fun get_next_position_id<T0>(arg0: &0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage) : u64 {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg0);
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_shared<VaultInfo<T0>>(arg0).next_position_id
    }

    public fun get_position_signer<T0>(arg0: &0x2::tx_context::TxContext) : PositionSigner<T0> {
        PositionSigner<T0>{address: 0x2::tx_context::sender(arg0)}
    }

    public fun get_position_signer_address<T0>(arg0: &PositionSigner<T0>) : address {
        arg0.address
    }

    public fun get_position_signer_cap<T0>(arg0: &AdminCap, arg1: &0x2::object::UID) : PositionSignerCap<T0> {
        PositionSignerCap<T0>{account: 0x2::object::uid_to_address(arg1)}
    }

    public fun get_position_signer_or_default<T0>(arg0: 0x1::option::Option<PositionSigner<T0>>, arg1: &0x2::tx_context::TxContext) : PositionSigner<T0> {
        if (0x1::option::is_some<PositionSigner<T0>>(&arg0)) {
            0x1::option::extract<PositionSigner<T0>>(&mut arg0)
        } else {
            get_position_signer<T0>(arg1)
        }
    }

    public fun get_position_signer_with_capability<T0>(arg0: &PositionSignerCap<T0>) : PositionSigner<T0> {
        PositionSigner<T0>{address: arg0.account}
    }

    public fun get_reserve_pool<T0>(arg0: &0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage) : u64 {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg0);
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_shared<VaultInfo<T0>>(arg0).reserve_pool
    }

    public fun get_vault_base_coin_balance<T0>(arg0: &0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage) : u64 {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg0);
        0x2::balance::value<T0>(&0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_shared<VaultInfo<T0>>(arg0).coin)
    }

    public fun get_vault_debt_share<T0>(arg0: &0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage) : u64 {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg0);
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_shared<VaultInfo<T0>>(arg0).vault_debt_share
    }

    public fun get_vault_debt_value<T0>(arg0: &0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage) : u64 {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg0);
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_shared<VaultInfo<T0>>(arg0).vault_debt_val
    }

    public fun get_work_context_debt<T0>(arg0: &WorkContext<T0>) : u64 {
        arg0.debt
    }

    public fun get_work_context_id<T0>(arg0: &WorkContext<T0>) : u64 {
        arg0.id
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun initialize<T0>(arg0: &AdminCap, arg1: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &0xba0311e40e1a18d048a20a0cbd1f5ca50c7b8a3c9b06e9b08f4e76b2489b2830::fair_launch::AdminCap, arg4: &mut 0xba0311e40e1a18d048a20a0cbd1f5ca50c7b8a3c9b06e9b08f4e76b2489b2830::fair_launch::Storage, arg5: address, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg1);
        0xba0311e40e1a18d048a20a0cbd1f5ca50c7b8a3c9b06e9b08f4e76b2489b2830::fair_launch::add_pool<MagicCoin<T0>>(arg3, arg4, arg6, false, true, arg8, arg9);
        0xba0311e40e1a18d048a20a0cbd1f5ca50c7b8a3c9b06e9b08f4e76b2489b2830::fair_launch::add_pool<DebtCoin<T0>>(arg3, arg4, arg7, true, false, arg8, arg9);
        let v0 = 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::coder::type_to_package_address<AdminCap>();
        let v1 = MagicCoin<T0>{dummy_field: false};
        let v2 = DebtCoin<T0>{dummy_field: false};
        let v3 = VaultInfo<T0>{
            config_addr          : arg5,
            vault_debt_share     : 0,
            vault_debt_val       : 0,
            last_accrue_time     : now_seconds(arg8),
            reserve_pool         : 0,
            decimals             : 0x2::coin::get_decimals<T0>(arg2),
            coin                 : 0x2::balance::zero<T0>(),
            magic_coin_supply    : 0x2::balance::create_supply<MagicCoin<T0>>(v1),
            debt_coin_supply     : 0x2::balance::create_supply<DebtCoin<T0>>(v2),
            positions            : 0x2::table::new<u64, Position<T0>>(arg9),
            next_position_id     : 1,
            fair_launch_user_cap : 0xba0311e40e1a18d048a20a0cbd1f5ca50c7b8a3c9b06e9b08f4e76b2489b2830::fair_launch::extract_user_cap<DebtCoin<T0>>(arg3, v0, true),
        };
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::add_share<VaultInfo<T0>>(arg1, v3);
        0xba0311e40e1a18d048a20a0cbd1f5ca50c7b8a3c9b06e9b08f4e76b2489b2830::fair_launch::approve_stake_debt_token(arg3, arg4, 0xba0311e40e1a18d048a20a0cbd1f5ca50c7b8a3c9b06e9b08f4e76b2489b2830::fair_launch::get_pid<DebtCoin<T0>>(arg4), v0, true, true, arg9);
    }

    public fun is_vault_initialized<T0>(arg0: &0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage) : bool {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg0);
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::contains_shared<VaultInfo<T0>>(arg0)
    }

    fun is_whitelisted_liquidator<T0>(arg0: &0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg1: address, arg2: address) : bool {
        0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault_config::is_whitelisted_liquidator(arg0, arg1, arg2)
    }

    fun magic_share_to_amount<T0>(arg0: &VaultInfo<T0>, arg1: u64) : u64 {
        (((arg1 as u128) * ((0x2::balance::value<T0>(&arg0.coin) + arg0.vault_debt_val - arg0.reserve_pool) as u128) / (0x2::balance::supply_value<MagicCoin<T0>>(&arg0.magic_coin_supply) as u128)) as u64)
    }

    public fun merge_kill_context_coin_back<T0>(arg0: &mut KillContext<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::join<T0>(&mut arg0.coin_back, arg1);
    }

    public fun merge_work_context_coin_back<T0>(arg0: &mut WorkContext<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::join<T0>(&mut arg0.coin_back, arg1);
    }

    fun mint_debt_coin<T0>(arg0: &mut 0x2::balance::Supply<DebtCoin<T0>>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<DebtCoin<T0>> {
        0x2::coin::from_balance<DebtCoin<T0>>(0x2::balance::increase_supply<DebtCoin<T0>>(arg0, arg1), arg2)
    }

    fun mint_magic_coin<T0>(arg0: &mut VaultInfo<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MagicCoin<T0>>>(0x2::coin::from_balance<MagicCoin<T0>>(0x2::balance::increase_supply<MagicCoin<T0>>(&mut arg0.magic_coin_supply, arg2), arg3), arg1);
    }

    fun now_seconds(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public fun pending_interest<T0>(arg0: &0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg0);
        pending_interest_inner<T0>(arg0, arg1, arg2)
    }

    fun pending_interest_inner<T0>(arg0: &0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_shared<VaultInfo<T0>>(arg0);
        let v1 = v0.last_accrue_time;
        let v2 = v0.vault_debt_val;
        let v3 = now_seconds(arg2);
        if (v3 > v1) {
            return (((0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault_config::get_interest_rate(arg0, v0.config_addr, v2, 0x2::balance::value<T0>(&v0.coin) - arg1) as u128) * (v2 as u128) * ((v3 - v1) as u128) / (0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault_config::get_interest_rate_scale() as u128)) as u64)
        };
        0
    }

    public fun position_debt_share<T0>(arg0: &0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg1: u64) : u64 {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg0);
        let v0 = &0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_shared<VaultInfo<T0>>(arg0).positions;
        if (0x2::table::contains<u64, Position<T0>>(v0, arg1)) {
            return 0x2::table::borrow<u64, Position<T0>>(v0, arg1).debt_share
        };
        0
    }

    public fun position_debt_val<T0>(arg0: &0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg1: u64) : u64 {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg0);
        let v0 = 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_shared<VaultInfo<T0>>(arg0);
        debt_share_to_val(v0.vault_debt_share, v0.vault_debt_val, 0x2::table::borrow<u64, Position<T0>>(&v0.positions, arg1).debt_share)
    }

    public entry fun reduceReserve<T0>(arg0: &AdminCap, arg1: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg2: u64) {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg1);
        let v0 = 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_mut_shared<VaultInfo<T0>>(arg1);
        v0.reserve_pool = v0.reserve_pool - arg2;
    }

    fun remove_debt<T0>(arg0: u64, arg1: &mut Position<T0>, arg2: &mut u64, arg3: &mut u64) : u64 {
        let v0 = arg1.debt_share;
        if (v0 > 0) {
            let v1 = debt_share_to_val(*arg2, *arg3, v0);
            arg1.debt_share = 0;
            *arg2 = *arg2 - v0;
            *arg3 = *arg3 - v1;
            let v2 = RemoveDebtEvent<T0>{
                id         : arg0,
                debt_share : v0,
            };
            0x2::event::emit<RemoveDebtEvent<T0>>(v2);
            return v1
        };
        0
    }

    public entry fun sendback_to_users<T0>(arg0: &AdminCap, arg1: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg1);
        let v0 = 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_mut_shared<VaultInfo<T0>>(arg1);
        let v1 = 0x2::balance::supply_value<MagicCoin<T0>>(&v0.magic_coin_supply);
        let v2 = 0x1::vector::length<address>(&arg2);
        assert!(0x2::balance::supply_value<DebtCoin<T0>>(&v0.debt_coin_supply) == 0, 24);
        let v3 = 0;
        let v4 = 0;
        while (v3 < v2) {
            v4 = v4 + *0x1::vector::borrow<u64>(&arg3, v3);
            v3 = v3 + 1;
        };
        assert!(v4 == v1, 23);
        let v5 = 0;
        while (v5 < v2) {
            let v6 = 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::mole_math::mul_div(*0x1::vector::borrow<u64>(&arg3, v5), 0x2::balance::value<T0>(&v0.coin), v1);
            transfer_coin_from_vault<T0>(v0, *0x1::vector::borrow<address>(&arg2, v5), v6, arg4);
            v5 = v5 + 1;
        };
    }

    public fun set_work_context_health<T0>(arg0: &mut WorkContext<T0>, arg1: u64) {
        arg0.health = arg1;
    }

    public fun total_token<T0>(arg0: &0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage) : u64 {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg0);
        total_token_from_vault_info<T0>(0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_shared<VaultInfo<T0>>(arg0))
    }

    public fun total_token_from_vault_info<T0>(arg0: &VaultInfo<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.coin) + arg0.vault_debt_val - arg0.reserve_pool
    }

    fun transfer_coin_from_vault<T0>(arg0: &mut VaultInfo<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin, arg2), arg3), arg1);
        };
    }

    fun transfer_coin_to_vault<T0>(arg0: &mut VaultInfo<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.coin, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, arg2, arg3)));
        if (0x2::coin::value<T0>(&arg1) != 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<T0>(arg1);
        };
    }

    public entry fun update_config<T0>(arg0: &AdminCap, arg1: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg2: address) {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg1);
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_mut_shared<VaultInfo<T0>>(arg1).config_addr = arg2;
    }

    public entry fun withdraw<T0>(arg0: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg1: vector<0x2::coin::Coin<MagicCoin<T0>>>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg0);
        let v0 = 0x2::coin::zero<MagicCoin<T0>>(arg4);
        0x2::pay::join_vec<MagicCoin<T0>>(&mut v0, arg1);
        withdraw_single<T0>(arg0, v0, arg2, arg3, arg4);
    }

    public entry fun withdraw_reserve<T0>(arg0: &AdminCap, arg1: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg1);
        let v0 = 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_mut_shared<VaultInfo<T0>>(arg1);
        v0.reserve_pool = v0.reserve_pool - arg3;
        transfer_coin_from_vault<T0>(v0, arg2, arg3, arg4);
    }

    public entry fun withdraw_single<T0>(arg0: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg1: 0x2::coin::Coin<MagicCoin<T0>>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg0);
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::emergency::assert_no_emergency(0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_emergency_status(arg0));
        accrue<T0>(arg0, 0, arg3);
        let v0 = 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_mut_shared<VaultInfo<T0>>(arg0);
        let v1 = magic_share_to_amount<T0>(v0, arg2);
        burn_magic_coin<T0>(v0, arg1, arg2, arg4);
        let v2 = 0x2::tx_context::sender(arg4);
        transfer_coin_from_vault<T0>(v0, v2, v1, arg4);
        assert!(0x2::balance::supply_value<MagicCoin<T0>>(&v0.magic_coin_supply) > 0x2::math::pow(10, v0.decimals - 1), 2);
        let v3 = WithdrawEvent<T0>{
            account : 0x2::tx_context::sender(arg4),
            share   : arg2,
            amount  : v1,
        };
        0x2::event::emit<WithdrawEvent<T0>>(v3);
    }

    // decompiled from Move bytecode v6
}

