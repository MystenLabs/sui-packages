module 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::storage {
    struct StakedSuiStorage has store, key {
        id: 0x2::object::UID,
        idle_liquidity: 0x2::balance::Balance<0x2::sui::SUI>,
        pool_ids: vector<0x2::object::ID>,
        pre_activated_stake: 0x2::table::Table<0x2::object::ID, 0x3::staking_pool::StakedSui>,
        stake: 0x2::table::Table<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>,
    }

    public(friend) fun destroy_empty(arg0: StakedSuiStorage) {
        assert!(0x1::vector::is_empty<0x2::object::ID>(&arg0.pool_ids) && 0x2::balance::value<0x2::sui::SUI>(&arg0.idle_liquidity) == 0, 13835058587858108417);
        let StakedSuiStorage {
            id                  : v0,
            idle_liquidity      : v1,
            pool_ids            : _,
            pre_activated_stake : v3,
            stake               : v4,
        } = arg0;
        0x2::table::destroy_empty<0x2::object::ID, 0x3::staking_pool::StakedSui>(v3);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
        0x2::table::destroy_empty<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(v4);
        0x2::object::delete(v0);
    }

    public(friend) fun join(arg0: &mut StakedSuiStorage, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x3::staking_pool::StakedSui, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3::staking_pool::pool_id(&arg2);
        if (!0x1::vector::contains<0x2::object::ID>(&arg0.pool_ids, &v0)) {
            0x1::vector::push_back<0x2::object::ID>(&mut arg0.pool_ids, v0);
        };
        let v1 = 0x2::tx_context::epoch(arg3);
        let v2 = 0x3::staking_pool::stake_activation_epoch(&arg2);
        if (!0x2::table::contains<0x2::object::ID, 0x3::staking_pool::StakedSui>(&arg0.pre_activated_stake, v0)) {
            if (v1 < v2) {
                0x2::table::add<0x2::object::ID, 0x3::staking_pool::StakedSui>(&mut arg0.pre_activated_stake, v0, arg2);
            } else if (0x2::table::contains<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(&arg0.stake, v0)) {
                0x3::staking_pool::join_fungible_staked_sui(0x2::table::borrow_mut<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(&mut arg0.stake, v0), 0x3::sui_system::convert_to_fungible_staked_sui(arg1, arg2, arg3));
            } else {
                0x2::table::add<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(&mut arg0.stake, v0, 0x3::sui_system::convert_to_fungible_staked_sui(arg1, arg2, arg3));
            };
            return
        };
        let v3 = 0x3::staking_pool::stake_activation_epoch(0x2::table::borrow<0x2::object::ID, 0x3::staking_pool::StakedSui>(&arg0.pre_activated_stake, v0));
        if (v1 < 0x1::u64::min(v2, v3)) {
            0x3::staking_pool::join_staked_sui(0x2::table::borrow_mut<0x2::object::ID, 0x3::staking_pool::StakedSui>(&mut arg0.pre_activated_stake, v0), arg2);
        } else if (0x1::u64::max(v1, v3) < v2) {
            if (0x2::table::contains<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(&arg0.stake, v0)) {
                0x3::staking_pool::join_fungible_staked_sui(0x2::table::borrow_mut<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(&mut arg0.stake, v0), 0x3::sui_system::convert_to_fungible_staked_sui(arg1, 0x2::table::remove<0x2::object::ID, 0x3::staking_pool::StakedSui>(&mut arg0.pre_activated_stake, v0), arg3));
            } else {
                0x2::table::add<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(&mut arg0.stake, v0, 0x3::sui_system::convert_to_fungible_staked_sui(arg1, 0x2::table::remove<0x2::object::ID, 0x3::staking_pool::StakedSui>(&mut arg0.pre_activated_stake, v0), arg3));
            };
            0x2::table::add<0x2::object::ID, 0x3::staking_pool::StakedSui>(&mut arg0.pre_activated_stake, v0, arg2);
        } else if (v2 <= v1 && v1 < v3) {
            if (0x2::table::contains<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(&arg0.stake, v0)) {
                0x3::staking_pool::join_fungible_staked_sui(0x2::table::borrow_mut<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(&mut arg0.stake, v0), 0x3::sui_system::convert_to_fungible_staked_sui(arg1, arg2, arg3));
            } else {
                0x2::table::add<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(&mut arg0.stake, v0, 0x3::sui_system::convert_to_fungible_staked_sui(arg1, arg2, arg3));
            };
        } else if (v2 == v3) {
            0x3::staking_pool::join_staked_sui(&mut arg2, 0x2::table::remove<0x2::object::ID, 0x3::staking_pool::StakedSui>(&mut arg0.pre_activated_stake, v0));
            if (0x2::table::contains<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(&arg0.stake, v0)) {
                0x3::staking_pool::join_fungible_staked_sui(0x2::table::borrow_mut<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(&mut arg0.stake, v0), 0x3::sui_system::convert_to_fungible_staked_sui(arg1, arg2, arg3));
            } else {
                0x2::table::add<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(&mut arg0.stake, v0, 0x3::sui_system::convert_to_fungible_staked_sui(arg1, arg2, arg3));
            };
        } else {
            if (0x2::table::contains<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(&arg0.stake, v0)) {
                0x3::staking_pool::join_fungible_staked_sui(0x2::table::borrow_mut<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(&mut arg0.stake, v0), 0x3::sui_system::convert_to_fungible_staked_sui(arg1, 0x2::table::remove<0x2::object::ID, 0x3::staking_pool::StakedSui>(&mut arg0.pre_activated_stake, v0), arg3));
            } else {
                0x2::table::add<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(&mut arg0.stake, v0, 0x3::sui_system::convert_to_fungible_staked_sui(arg1, 0x2::table::remove<0x2::object::ID, 0x3::staking_pool::StakedSui>(&mut arg0.pre_activated_stake, v0), arg3));
            };
            if (0x2::table::contains<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(&arg0.stake, v0)) {
                0x3::staking_pool::join_fungible_staked_sui(0x2::table::borrow_mut<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(&mut arg0.stake, v0), 0x3::sui_system::convert_to_fungible_staked_sui(arg1, arg2, arg3));
            } else {
                0x2::table::add<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(&mut arg0.stake, v0, 0x3::sui_system::convert_to_fungible_staked_sui(arg1, arg2, arg3));
            };
        };
    }

    public(friend) fun split(arg0: &mut StakedSuiStorage, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.idle_liquidity, 0x1::u64::min(arg2, 0x2::balance::value<0x2::sui::SUI>(&arg0.idle_liquidity)));
        let v1 = arg2 - 0x2::balance::value<0x2::sui::SUI>(&v0);
        let v2 = v1;
        if (v1 == 0) {
            return v0
        };
        let v3 = arg0.pool_ids;
        0x1::vector::reverse<0x2::object::ID>(&mut v3);
        let v4 = 0x2::tx_context::epoch(arg3);
        0x1::vector::reverse<0x2::object::ID>(&mut v3);
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x2::object::ID>(&v3)) {
            if (!(v2 > 0)) {
                break
            };
            let v6 = 0x1::vector::pop_back<0x2::object::ID>(&mut v3);
            let v7 = 0x2::balance::zero<0x2::sui::SUI>();
            let v8 = v2;
            let v9 = v2 > 0 && 0x2::table::contains<0x2::object::ID, 0x3::staking_pool::StakedSui>(&arg0.pre_activated_stake, v6);
            let v10;
            let v11;
            let v12;
            let v13;
            let v14;
            let v15;
            if (v9) {
                let v16 = 0x2::table::borrow<0x2::object::ID, 0x3::staking_pool::StakedSui>(&arg0.pre_activated_stake, v6);
                v14 = 0x3::staking_pool::staked_sui_amount(v16);
                let v17 = 0x3::staking_pool::pool_id(v16);
                v15 = 0x3::staking_pool::stake_activation_epoch(v16);
                let v18 = 0x3::sui_system::pool_exchange_rates(arg1, &v17);
                while (v15 > 0) {
                    if (0x2::table::contains<u64, 0x3::staking_pool::PoolTokenExchangeRate>(v18, v15)) {
                        let v19 = 0x2::table::borrow<u64, 0x3::staking_pool::PoolTokenExchangeRate>(v18, v15);
                        let v20 = 0x3::staking_pool::pool_token_amount(v19);
                        let v21 = 0x3::staking_pool::sui_amount(v19);
                        while (v4 > 0) {
                            if (0x2::table::contains<u64, 0x3::staking_pool::PoolTokenExchangeRate>(v18, v4)) {
                                let v22 = 0x2::table::borrow<u64, 0x3::staking_pool::PoolTokenExchangeRate>(v18, v4);
                                let v23 = 0x3::staking_pool::pool_token_amount(v22);
                                let v24 = 0x3::staking_pool::sui_amount(v22);
                                let v25 = if (v24 == 0 || v23 == 0) {
                                    v2
                                } else {
                                    (((v23 as u128) * (v2 as u128) / (v24 as u128)) as u64)
                                };
                                if (v21 == 0 || v20 == 0) {
                                    v10 = v25;
                                } else {
                                    v10 = (((v21 as u128) * (v25 as u128) / (v20 as u128)) as u64);
                                };
                                if (v14 <= v10) {
                                    if (!0x2::table::contains<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(&arg0.stake, v6)) {
                                        let v26 = &arg0.pool_ids;
                                        v13 = 0;
                                        while (v13 < 0x1::vector::length<0x2::object::ID>(v26)) {
                                            if (*0x1::vector::borrow<0x2::object::ID>(v26, v13) == v6) {
                                                v11 = 0x1::option::some<u64>(v13);
                                                /* label 40 */
                                                0x1::vector::remove<0x2::object::ID>(&mut arg0.pool_ids, 0x1::option::extract<u64>(&mut v11));
                                                /* goto 41 */
                                            } else {
                                                /* goto 76 */
                                            };
                                        };
                                    };
                                    /* label 41 */
                                    v12 = 0x3::sui_system::request_withdraw_stake_non_entry(arg1, 0x2::table::remove<0x2::object::ID, 0x3::staking_pool::StakedSui>(&mut arg0.pre_activated_stake, v6), arg3);
                                    /* label 42 */
                                    0x2::balance::join<0x2::sui::SUI>(&mut v7, v12);
                                    v8 = v2 - 0x2::balance::value<0x2::sui::SUI>(&v7);
                                    /* goto 43 */
                                } else {
                                    /* goto 78 */
                                };
                            } else {
                                /* goto 112 */
                            };
                        };
                    } else {
                        /* goto 114 */
                    };
                };
            };
            /* label 43 */
            let v27 = v8 > 0 && 0x2::table::contains<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(&arg0.stake, v6);
            let v28;
            let v29;
            let v30;
            let v31;
            if (v27) {
                let v32 = 0x3::sui_system::pool_exchange_rates(arg1, &v6);
                while (v4 > 0) {
                    if (0x2::table::contains<u64, 0x3::staking_pool::PoolTokenExchangeRate>(v32, v4)) {
                        let v33 = 0x2::table::borrow<u64, 0x3::staking_pool::PoolTokenExchangeRate>(v32, v4);
                        v29 = 0x3::staking_pool::pool_token_amount(v33);
                        v28 = 0x3::staking_pool::sui_amount(v33);
                        /* label 52 */
                        let v34 = if (v28 == 0 || v29 == 0) {
                            v8
                        } else {
                            (((v29 as u128) * (v8 as u128) / (v28 as u128)) as u64)
                        };
                        let v35 = 0x2::table::borrow_mut<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(&mut arg0.stake, v6);
                        let v36 = if (v34 < 0x3::staking_pool::fungible_staked_sui_value(v35)) {
                            0x3::staking_pool::split_fungible_staked_sui(v35, v34, arg3)
                        } else {
                            if (!0x2::table::contains<0x2::object::ID, 0x3::staking_pool::StakedSui>(&arg0.pre_activated_stake, v6)) {
                                let v37 = &arg0.pool_ids;
                                v31 = 0;
                                while (v31 < 0x1::vector::length<0x2::object::ID>(v37)) {
                                    if (*0x1::vector::borrow<0x2::object::ID>(v37, v31) == v6) {
                                        v30 = 0x1::option::some<u64>(v31);
                                        /* label 68 */
                                        0x1::vector::remove<0x2::object::ID>(&mut arg0.pool_ids, 0x1::option::extract<u64>(&mut v30));
                                        /* goto 69 */
                                    } else {
                                        /* goto 72 */
                                    };
                                };
                            };
                            /* label 69 */
                            0x2::table::remove<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(&mut arg0.stake, v6)
                        };
                        0x2::balance::join<0x2::sui::SUI>(&mut v7, 0x3::sui_system::redeem_fungible_staked_sui(arg1, v36, arg3));
                        /* goto 71 */
                    } else {
                        /* goto 74 */
                    };
                };
            };
            /* label 71 */
            0x2::balance::join<0x2::sui::SUI>(&mut v0, v7);
            v2 = arg2 - 0x2::balance::value<0x2::sui::SUI>(&v0);
            v5 = v5 + 1;
            continue;
            /* label 72 */
            v31 = v31 + 1;
            /* goto 63 */
            continue;
            v30 = 0x1::option::none<u64>();
            /* goto 68 */
            /* label 74 */
            v4 = v4 - 1;
            /* goto 48 */
            continue;
            v29 = 0;
            v28 = 0;
            /* goto 52 */
            /* label 76 */
            v13 = v13 + 1;
            /* goto 35 */
            continue;
            v11 = 0x1::option::none<u64>();
            /* goto 40 */
            /* label 78 */
            if (1000000000 <= v10 && v10 <= v14 - 1000000000) {
                let v38 = if (v15 <= v4) {
                    let v39 = 0x2::table::remove<0x2::object::ID, 0x3::staking_pool::StakedSui>(&mut arg0.pre_activated_stake, v6);
                    if (0x2::table::contains<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(&arg0.stake, v6)) {
                        0x3::staking_pool::join_fungible_staked_sui(0x2::table::borrow_mut<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(&mut arg0.stake, v6), 0x3::sui_system::convert_to_fungible_staked_sui(arg1, v39, arg3));
                    } else {
                        0x2::table::add<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(&mut arg0.stake, v6, 0x3::sui_system::convert_to_fungible_staked_sui(arg1, v39, arg3));
                    };
                    0x3::staking_pool::split(&mut v39, v10, arg3)
                } else {
                    0x3::staking_pool::split(0x2::table::borrow_mut<0x2::object::ID, 0x3::staking_pool::StakedSui>(&mut arg0.pre_activated_stake, v6), v10, arg3)
                };
                v12 = 0x3::sui_system::request_withdraw_stake_non_entry(arg1, v38, arg3);
                /* goto 42 */
            } else {
                let v40;
                let v41;
                let v42 = if (v15 <= v4) {
                    if (0x2::table::contains<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(&arg0.stake, v6)) {
                        0x3::staking_pool::join_fungible_staked_sui(0x2::table::borrow_mut<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(&mut arg0.stake, v6), 0x3::sui_system::convert_to_fungible_staked_sui(arg1, 0x2::table::remove<0x2::object::ID, 0x3::staking_pool::StakedSui>(&mut arg0.pre_activated_stake, v6), arg3));
                    } else {
                        0x2::table::add<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(&mut arg0.stake, v6, 0x3::sui_system::convert_to_fungible_staked_sui(arg1, 0x2::table::remove<0x2::object::ID, 0x3::staking_pool::StakedSui>(&mut arg0.pre_activated_stake, v6), arg3));
                    };
                    0x2::balance::zero<0x2::sui::SUI>()
                } else if (1000000000 > v10 && v10 <= v14 - 1000000000) {
                    let v43 = 0x3::sui_system::request_withdraw_stake_non_entry(arg1, 0x3::staking_pool::split(0x2::table::borrow_mut<0x2::object::ID, 0x3::staking_pool::StakedSui>(&mut arg0.pre_activated_stake, v6), 1000000000, arg3), arg3);
                    0x2::balance::join<0x2::sui::SUI>(&mut arg0.idle_liquidity, 0x2::balance::split<0x2::sui::SUI>(&mut v43, 0x2::balance::value<0x2::sui::SUI>(&v43) - v2));
                    v43
                } else {
                    if (!0x2::table::contains<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(&arg0.stake, v6)) {
                        let v44 = &arg0.pool_ids;
                        v41 = 0;
                        while (v41 < 0x1::vector::length<0x2::object::ID>(v44)) {
                            if (*0x1::vector::borrow<0x2::object::ID>(v44, v41) == v6) {
                                v40 = 0x1::option::some<u64>(v41);
                                /* label 106 */
                                0x1::vector::remove<0x2::object::ID>(&mut arg0.pool_ids, 0x1::option::extract<u64>(&mut v40));
                                /* goto 107 */
                            } else {
                                /* goto 110 */
                            };
                        };
                    };
                    /* label 107 */
                    let v45 = 0x3::sui_system::request_withdraw_stake_non_entry(arg1, 0x2::table::remove<0x2::object::ID, 0x3::staking_pool::StakedSui>(&mut arg0.pre_activated_stake, v6), arg3);
                    0x2::balance::join<0x2::sui::SUI>(&mut arg0.idle_liquidity, 0x2::balance::split<0x2::sui::SUI>(&mut v45, 0x2::balance::value<0x2::sui::SUI>(&v45) - v2));
                    v45
                };
                v12 = v42;
                /* goto 42 */
                /* label 110 */
                v41 = v41 + 1;
                /* goto 101 */
                continue;
                v40 = 0x1::option::none<u64>();
                /* goto 106 */
            };
        };
        assert!(v2 <= 2 * 0x1::vector::length<0x2::object::ID>(&v3), 13835341282605662211);
        v0
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : StakedSuiStorage {
        StakedSuiStorage{
            id                  : 0x2::object::new(arg0),
            idle_liquidity      : 0x2::balance::zero<0x2::sui::SUI>(),
            pool_ids            : 0x1::vector::empty<0x2::object::ID>(),
            pre_activated_stake : 0x2::table::new<0x2::object::ID, 0x3::staking_pool::StakedSui>(arg0),
            stake               : 0x2::table::new<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(arg0),
        }
    }

    public(friend) fun convert_staked_sui_to_fungible_staked_sui_for_pool_id(arg0: &mut StakedSuiStorage, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::table::contains<0x2::object::ID, 0x3::staking_pool::StakedSui>(&arg0.pre_activated_stake, arg2)) {
            if (0x3::staking_pool::stake_activation_epoch(0x2::table::borrow<0x2::object::ID, 0x3::staking_pool::StakedSui>(&arg0.pre_activated_stake, arg2)) <= 0x2::tx_context::epoch(arg3)) {
                if (0x2::table::contains<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(&arg0.stake, arg2)) {
                    0x3::staking_pool::join_fungible_staked_sui(0x2::table::borrow_mut<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(&mut arg0.stake, arg2), 0x3::sui_system::convert_to_fungible_staked_sui(arg1, 0x2::table::remove<0x2::object::ID, 0x3::staking_pool::StakedSui>(&mut arg0.pre_activated_stake, arg2), arg3));
                } else {
                    0x2::table::add<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(&mut arg0.stake, arg2, 0x3::sui_system::convert_to_fungible_staked_sui(arg1, 0x2::table::remove<0x2::object::ID, 0x3::staking_pool::StakedSui>(&mut arg0.pre_activated_stake, arg2), arg3));
                };
            };
        };
    }

    public(friend) fun idle_liquidity(arg0: &StakedSuiStorage) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.idle_liquidity)
    }

    public(friend) fun pool_ids(arg0: &StakedSuiStorage) : vector<0x2::object::ID> {
        arg0.pool_ids
    }

    public(friend) fun rebalance_stake(arg0: &mut StakedSuiStorage, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg2) == 0x1::vector::length<0x2::object::ID>(&arg0.pool_ids), 13835904430127841287);
        let v0 = total_active_liquidity_per_pool_id(arg0, arg1, arg3);
        let v1 = 0;
        0x1::vector::reverse<u64>(&mut v0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&v0)) {
            v1 = v1 + 0x1::vector::pop_back<u64>(&mut v0);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<u64>(v0);
        let v3 = 0;
        0x1::vector::reverse<u64>(&mut arg2);
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(&arg2)) {
            v3 = v3 + 0x1::vector::pop_back<u64>(&mut arg2);
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<u64>(arg2);
        assert!(v3 <= v1 + 0x2::balance::value<0x2::sui::SUI>(&arg0.idle_liquidity), 13835341527418798083);
        let v5 = 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.idle_liquidity);
        let v6 = 0x1::vector::length<0x2::object::ID>(&arg0.pool_ids);
        let v7 = 0x2::tx_context::epoch(arg3);
        let v8 = &arg0.pool_ids;
        let v9 = vector[];
        let v10 = 0;
        while (v10 < 0x1::vector::length<0x2::object::ID>(v8)) {
            0x1::vector::push_back<address>(&mut v9, 0x3::sui_system::validator_address_by_pool_id(arg1, 0x1::vector::borrow<0x2::object::ID>(v8, v10)));
            v10 = v10 + 1;
        };
        let v11 = arg0.pool_ids;
        let v12 = 0;
        while (v12 < v6) {
            let v13 = *0x1::vector::borrow<u64>(&v0, v12);
            let v14 = *0x1::vector::borrow<u64>(&arg2, v12);
            let v15 = *0x1::vector::borrow<0x2::object::ID>(&v11, v12);
            let v16;
            let v17;
            let v18;
            let v19;
            let v20;
            let v21;
            let v22;
            let v23;
            let v24;
            let v25;
            let v26;
            let v27;
            let v28;
            let v29;
            if (v14 < v13) {
                let v30 = 0x2::balance::zero<0x2::sui::SUI>();
                v26 = v13 - v14;
                let v31 = v26;
                if (v26 > 0 && 0x2::table::contains<0x2::object::ID, 0x3::staking_pool::StakedSui>(&arg0.pre_activated_stake, v15)) {
                    let v32 = 0x2::table::borrow<0x2::object::ID, 0x3::staking_pool::StakedSui>(&arg0.pre_activated_stake, v15);
                    v27 = 0x3::staking_pool::staked_sui_amount(v32);
                    let v33 = 0x3::staking_pool::pool_id(v32);
                    v28 = 0x3::staking_pool::stake_activation_epoch(v32);
                    let v34 = 0x3::sui_system::pool_exchange_rates(arg1, &v33);
                    while (v28 > 0) {
                        if (0x2::table::contains<u64, 0x3::staking_pool::PoolTokenExchangeRate>(v34, v28)) {
                            let v35 = 0x2::table::borrow<u64, 0x3::staking_pool::PoolTokenExchangeRate>(v34, v28);
                            let v36 = 0x3::staking_pool::pool_token_amount(v35);
                            let v37 = 0x3::staking_pool::sui_amount(v35);
                            while (v7 > 0) {
                                if (0x2::table::contains<u64, 0x3::staking_pool::PoolTokenExchangeRate>(v34, v7)) {
                                    let v38 = 0x2::table::borrow<u64, 0x3::staking_pool::PoolTokenExchangeRate>(v34, v7);
                                    let v39 = 0x3::staking_pool::pool_token_amount(v38);
                                    let v40 = 0x3::staking_pool::sui_amount(v38);
                                    let v41 = if (v40 == 0 || v39 == 0) {
                                        v26
                                    } else {
                                        (((v39 as u128) * (v26 as u128) / (v40 as u128)) as u64)
                                    };
                                    if (v37 == 0 || v36 == 0) {
                                        v17 = v41;
                                    } else {
                                        v17 = (((v37 as u128) * (v41 as u128) / (v36 as u128)) as u64);
                                    };
                                    if (v27 <= v17) {
                                        if (!0x2::table::contains<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(&arg0.stake, v15)) {
                                            let v42 = &arg0.pool_ids;
                                            v24 = 0;
                                            while (v24 < 0x1::vector::length<0x2::object::ID>(v42)) {
                                                if (*0x1::vector::borrow<0x2::object::ID>(v42, v24) == v15) {
                                                    v18 = 0x1::option::some<u64>(v24);
                                                    /* label 50 */
                                                    0x1::vector::remove<0x2::object::ID>(&mut arg0.pool_ids, 0x1::option::extract<u64>(&mut v18));
                                                    /* goto 51 */
                                                } else {
                                                    /* goto 87 */
                                                };
                                            };
                                        };
                                        /* label 51 */
                                        v16 = 0x3::sui_system::request_withdraw_stake_non_entry(arg1, 0x2::table::remove<0x2::object::ID, 0x3::staking_pool::StakedSui>(&mut arg0.pre_activated_stake, v15), arg3);
                                        /* label 52 */
                                        0x2::balance::join<0x2::sui::SUI>(&mut v30, v16);
                                        v31 = v13 - v14 - 0x2::balance::value<0x2::sui::SUI>(&v30);
                                        /* goto 53 */
                                    } else {
                                        /* goto 89 */
                                    };
                                } else {
                                    /* goto 123 */
                                };
                            };
                        } else {
                            /* goto 125 */
                        };
                    };
                };
                /* label 53 */
                if (v31 > 0 && 0x2::table::contains<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(&arg0.stake, v15)) {
                    let v43 = 0x3::sui_system::pool_exchange_rates(arg1, &v15);
                    while (v7 > 0) {
                        if (0x2::table::contains<u64, 0x3::staking_pool::PoolTokenExchangeRate>(v43, v7)) {
                            let v44 = 0x2::table::borrow<u64, 0x3::staking_pool::PoolTokenExchangeRate>(v43, v7);
                            v20 = 0x3::staking_pool::pool_token_amount(v44);
                            v19 = 0x3::staking_pool::sui_amount(v44);
                            /* label 62 */
                            if (v19 == 0 || v20 == 0) {
                                v21 = v31;
                            } else {
                                v21 = (((v20 as u128) * (v31 as u128) / (v19 as u128)) as u64);
                            };
                            v29 = 0x2::table::borrow_mut<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(&mut arg0.stake, v15);
                            if (v21 < 0x3::staking_pool::fungible_staked_sui_value(v29)) {
                                /* goto 84 */
                            } else {
                                if (!0x2::table::contains<0x2::object::ID, 0x3::staking_pool::StakedSui>(&arg0.pre_activated_stake, v15)) {
                                    let v45 = &arg0.pool_ids;
                                    v25 = 0;
                                    while (v25 < 0x1::vector::length<0x2::object::ID>(v45)) {
                                        if (*0x1::vector::borrow<0x2::object::ID>(v45, v25) == v15) {
                                            v22 = 0x1::option::some<u64>(v25);
                                            /* label 77 */
                                            0x1::vector::remove<0x2::object::ID>(&mut arg0.pool_ids, 0x1::option::extract<u64>(&mut v22));
                                            /* goto 78 */
                                        } else {
                                            /* goto 82 */
                                        };
                                    };
                                };
                                /* label 78 */
                                v23 = 0x2::table::remove<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(&mut arg0.stake, v15);
                                /* label 79 */
                                0x2::balance::join<0x2::sui::SUI>(&mut v30, 0x3::sui_system::redeem_fungible_staked_sui(arg1, v23, arg3));
                                /* goto 80 */
                            };
                        } else {
                            /* goto 85 */
                        };
                    };
                };
                /* label 80 */
                0x2::balance::join<0x2::sui::SUI>(&mut v5, v30);
            };
            v12 = v12 + 1;
            continue;
            /* label 82 */
            v25 = v25 + 1;
            /* goto 72 */
            continue;
            v22 = 0x1::option::none<u64>();
            /* goto 77 */
            /* label 84 */
            v23 = 0x3::staking_pool::split_fungible_staked_sui(v29, v21, arg3);
            /* goto 79 */
            /* label 85 */
            v7 = v7 - 1;
            /* goto 58 */
            continue;
            v20 = 0;
            v19 = 0;
            /* goto 62 */
            /* label 87 */
            v24 = v24 + 1;
            /* goto 45 */
            continue;
            v18 = 0x1::option::none<u64>();
            /* goto 50 */
            /* label 89 */
            if (1000000000 <= v17 && v17 <= v27 - 1000000000) {
                let v46 = if (v28 <= v7) {
                    let v47 = 0x2::table::remove<0x2::object::ID, 0x3::staking_pool::StakedSui>(&mut arg0.pre_activated_stake, v15);
                    if (0x2::table::contains<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(&arg0.stake, v15)) {
                        0x3::staking_pool::join_fungible_staked_sui(0x2::table::borrow_mut<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(&mut arg0.stake, v15), 0x3::sui_system::convert_to_fungible_staked_sui(arg1, v47, arg3));
                    } else {
                        0x2::table::add<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(&mut arg0.stake, v15, 0x3::sui_system::convert_to_fungible_staked_sui(arg1, v47, arg3));
                    };
                    0x3::staking_pool::split(&mut v47, v17, arg3)
                } else {
                    0x3::staking_pool::split(0x2::table::borrow_mut<0x2::object::ID, 0x3::staking_pool::StakedSui>(&mut arg0.pre_activated_stake, v15), v17, arg3)
                };
                v16 = 0x3::sui_system::request_withdraw_stake_non_entry(arg1, v46, arg3);
                /* goto 52 */
            } else {
                let v48;
                let v49;
                let v50 = if (v28 <= v7) {
                    if (0x2::table::contains<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(&arg0.stake, v15)) {
                        0x3::staking_pool::join_fungible_staked_sui(0x2::table::borrow_mut<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(&mut arg0.stake, v15), 0x3::sui_system::convert_to_fungible_staked_sui(arg1, 0x2::table::remove<0x2::object::ID, 0x3::staking_pool::StakedSui>(&mut arg0.pre_activated_stake, v15), arg3));
                    } else {
                        0x2::table::add<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(&mut arg0.stake, v15, 0x3::sui_system::convert_to_fungible_staked_sui(arg1, 0x2::table::remove<0x2::object::ID, 0x3::staking_pool::StakedSui>(&mut arg0.pre_activated_stake, v15), arg3));
                    };
                    0x2::balance::zero<0x2::sui::SUI>()
                } else if (1000000000 > v17 && v17 <= v27 - 1000000000) {
                    let v51 = 0x3::sui_system::request_withdraw_stake_non_entry(arg1, 0x3::staking_pool::split(0x2::table::borrow_mut<0x2::object::ID, 0x3::staking_pool::StakedSui>(&mut arg0.pre_activated_stake, v15), 1000000000, arg3), arg3);
                    0x2::balance::join<0x2::sui::SUI>(&mut arg0.idle_liquidity, 0x2::balance::split<0x2::sui::SUI>(&mut v51, 0x2::balance::value<0x2::sui::SUI>(&v51) - v26));
                    v51
                } else {
                    if (!0x2::table::contains<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(&arg0.stake, v15)) {
                        let v52 = &arg0.pool_ids;
                        v49 = 0;
                        while (v49 < 0x1::vector::length<0x2::object::ID>(v52)) {
                            if (*0x1::vector::borrow<0x2::object::ID>(v52, v49) == v15) {
                                v48 = 0x1::option::some<u64>(v49);
                                /* label 117 */
                                0x1::vector::remove<0x2::object::ID>(&mut arg0.pool_ids, 0x1::option::extract<u64>(&mut v48));
                                /* goto 118 */
                            } else {
                                /* goto 121 */
                            };
                        };
                    };
                    /* label 118 */
                    let v53 = 0x3::sui_system::request_withdraw_stake_non_entry(arg1, 0x2::table::remove<0x2::object::ID, 0x3::staking_pool::StakedSui>(&mut arg0.pre_activated_stake, v15), arg3);
                    0x2::balance::join<0x2::sui::SUI>(&mut arg0.idle_liquidity, 0x2::balance::split<0x2::sui::SUI>(&mut v53, 0x2::balance::value<0x2::sui::SUI>(&v53) - v26));
                    v53
                };
                v16 = v50;
                /* goto 52 */
                /* label 121 */
                v49 = v49 + 1;
                /* goto 112 */
                continue;
                v48 = 0x1::option::none<u64>();
                /* goto 117 */
            };
        };
        let v54 = 0x2::coin::from_balance<0x2::sui::SUI>(v5, arg3);
        let v55 = 0;
        while (v55 < v6) {
            let v56 = *0x1::vector::borrow<u64>(&v0, v55);
            let v57 = *0x1::vector::borrow<u64>(&arg2, v55);
            if (v57 > v56) {
                let v58 = 0x3::sui_system::request_add_stake_non_entry(arg1, 0x2::coin::split<0x2::sui::SUI>(&mut v54, v57 - v56, arg3), *0x1::vector::borrow<address>(&v9, v55), arg3);
                join(arg0, arg1, v58, arg3);
            };
            v55 = v55 + 1;
        };
        if (0x2::coin::value<0x2::sui::SUI>(&v54) > 0) {
            0x2::coin::put<0x2::sui::SUI>(&mut arg0.idle_liquidity, v54);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v54);
        };
    }

    public(friend) fun set_pool_ids_order(arg0: &mut StakedSuiStorage, arg1: vector<0x2::object::ID>) {
        let v0 = &arg0.pool_ids;
        let v1 = &arg1;
        let v2 = 0x1::vector::length<0x2::object::ID>(v1);
        assert!(0x1::vector::length<0x2::object::ID>(v0) == v2, 13835625433347129349);
        let v3 = 0x1::vector::empty<0x2::object::ID>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x2::object::ID>(v1)) {
            let v5 = 0x1::vector::borrow<0x2::object::ID>(v1, v4);
            if (!0x1::vector::contains<0x2::object::ID>(&v3, v5)) {
                0x1::vector::push_back<0x2::object::ID>(&mut v3, *v5);
            };
            v4 = v4 + 1;
        };
        assert!(0x1::vector::length<0x2::object::ID>(&v3) == v2, 13835625450526998533);
        let v6 = &v3;
        let v7 = 0;
        while (v7 < 0x1::vector::length<0x2::object::ID>(v6)) {
            assert!(0x1::vector::contains<0x2::object::ID>(v0, 0x1::vector::borrow<0x2::object::ID>(v6, v7)), 13835625463411900421);
            v7 = v7 + 1;
        };
        arg0.pool_ids = arg1;
    }

    public(friend) fun size(arg0: &StakedSuiStorage) : u64 {
        0x1::vector::length<0x2::object::ID>(&arg0.pool_ids)
    }

    public(friend) fun stake_idle_liquidity(arg0: &mut StakedSuiStorage, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(1000000000 <= arg3, 13836186313126576137);
        assert!(arg3 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.idle_liquidity), 13835341901080952835);
        let v0 = 0x3::sui_system::request_add_stake_non_entry(arg1, 0x2::coin::take<0x2::sui::SUI>(&mut arg0.idle_liquidity, arg3, arg4), arg2, arg4);
        join(arg0, arg1, v0, arg4);
    }

    public(friend) fun total_active_liquidity(arg0: &StakedSuiStorage, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0;
        let v1 = arg0.pool_ids;
        0x1::vector::reverse<0x2::object::ID>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&v1)) {
            let v3 = 0x1::vector::pop_back<0x2::object::ID>(&mut v1);
            let v4 = 0x2::tx_context::epoch(arg2);
            let v5 = 0x3::sui_system::pool_exchange_rates(arg1, &v3);
            let v6;
            let v7;
            while (v4 > 0) {
                if (0x2::table::contains<u64, 0x3::staking_pool::PoolTokenExchangeRate>(v5, v4)) {
                    let v8 = 0x2::table::borrow<u64, 0x3::staking_pool::PoolTokenExchangeRate>(v5, v4);
                    v6 = 0x3::staking_pool::pool_token_amount(v8);
                    v7 = 0x3::staking_pool::sui_amount(v8);
                    /* label 7 */
                    let v9;
                    let v10;
                    let v11;
                    let v12;
                    let v13 = if (!0x2::table::contains<0x2::object::ID, 0x3::staking_pool::StakedSui>(&arg0.pre_activated_stake, v3)) {
                        0
                    } else {
                        v12 = 0x2::table::borrow<0x2::object::ID, 0x3::staking_pool::StakedSui>(&arg0.pre_activated_stake, v3);
                        v11 = 0x3::staking_pool::stake_activation_epoch(v12);
                        let v13;
                        if (v4 < v11) {
                            /* goto 47 */
                        } else {
                            while (v11 > 0) {
                                if (0x2::table::contains<u64, 0x3::staking_pool::PoolTokenExchangeRate>(v5, v11)) {
                                    let v14 = 0x2::table::borrow<u64, 0x3::staking_pool::PoolTokenExchangeRate>(v5, v11);
                                    v10 = 0x3::staking_pool::pool_token_amount(v14);
                                    v9 = 0x3::staking_pool::sui_amount(v14);
                                    /* label 17 */
                                    let v15 = if (0x2::tx_context::epoch(arg2) < 0x3::staking_pool::stake_activation_epoch(v12)) {
                                        0
                                    } else {
                                        let v16 = if (v9 == 0 || v10 == 0) {
                                            0x3::staking_pool::staked_sui_amount(v12)
                                        } else {
                                            (((v10 as u128) * (0x3::staking_pool::staked_sui_amount(v12) as u128) / (v9 as u128)) as u64)
                                        };
                                        if (v7 == 0 || v6 == 0) {
                                            v16
                                        } else {
                                            (((v7 as u128) * (v16 as u128) / (v6 as u128)) as u64)
                                        }
                                    };
                                    v13 = v15;
                                    /* goto 34 */
                                } else {
                                    /* goto 45 */
                                };
                            };
                        };
                        v13
                    };
                    /* label 34 */
                    let v17 = if (0x2::table::contains<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(&arg0.stake, v3)) {
                        let v18 = 0x2::table::borrow<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(&arg0.stake, v3);
                        if (v7 == 0 || v6 == 0) {
                            0x3::staking_pool::fungible_staked_sui_value(v18)
                        } else {
                            (((v7 as u128) * (0x3::staking_pool::fungible_staked_sui_value(v18) as u128) / (v6 as u128)) as u64)
                        }
                    } else {
                        0
                    };
                    v0 = v0 + v13 + v17;
                    v2 = v2 + 1;
                    /* goto 1 */
                    continue;
                    /* label 45 */
                    v11 = v11 - 1;
                    /* goto 13 */
                    continue;
                    v10 = 0;
                    v9 = 0;
                    /* goto 17 */
                    /* label 47 */
                    v13 = 0x3::staking_pool::staked_sui_amount(v12);
                    /* goto 34 */
                };
                v4 = v4 - 1;
            };
            v6 = 0;
            v7 = 0;
            /* goto 7 */
        };
        0x1::vector::destroy_empty<0x2::object::ID>(v1);
        0x2::balance::value<0x2::sui::SUI>(&arg0.idle_liquidity) + v0
    }

    public(friend) fun total_active_liquidity_per_pool_id(arg0: &StakedSuiStorage, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &0x2::tx_context::TxContext) : vector<u64> {
        let v0 = vector[];
        let v1 = arg0.pool_ids;
        0x1::vector::reverse<0x2::object::ID>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&v1)) {
            let v3 = 0x1::vector::pop_back<0x2::object::ID>(&mut v1);
            let v4 = 0x2::tx_context::epoch(arg2);
            let v5 = 0x3::sui_system::pool_exchange_rates(arg1, &v3);
            let v6;
            let v7;
            while (v4 > 0) {
                if (0x2::table::contains<u64, 0x3::staking_pool::PoolTokenExchangeRate>(v5, v4)) {
                    let v8 = 0x2::table::borrow<u64, 0x3::staking_pool::PoolTokenExchangeRate>(v5, v4);
                    v7 = 0x3::staking_pool::pool_token_amount(v8);
                    v6 = 0x3::staking_pool::sui_amount(v8);
                    /* label 7 */
                    let v9;
                    let v10;
                    let v11;
                    let v12;
                    let v13 = if (!0x2::table::contains<0x2::object::ID, 0x3::staking_pool::StakedSui>(&arg0.pre_activated_stake, v3)) {
                        0
                    } else {
                        v12 = 0x2::table::borrow<0x2::object::ID, 0x3::staking_pool::StakedSui>(&arg0.pre_activated_stake, v3);
                        v11 = 0x3::staking_pool::stake_activation_epoch(v12);
                        let v13;
                        if (v4 < v11) {
                            /* goto 47 */
                        } else {
                            while (v11 > 0) {
                                if (0x2::table::contains<u64, 0x3::staking_pool::PoolTokenExchangeRate>(v5, v11)) {
                                    let v14 = 0x2::table::borrow<u64, 0x3::staking_pool::PoolTokenExchangeRate>(v5, v11);
                                    v10 = 0x3::staking_pool::pool_token_amount(v14);
                                    v9 = 0x3::staking_pool::sui_amount(v14);
                                    /* label 17 */
                                    let v15 = if (0x2::tx_context::epoch(arg2) < 0x3::staking_pool::stake_activation_epoch(v12)) {
                                        0
                                    } else {
                                        let v16 = if (v9 == 0 || v10 == 0) {
                                            0x3::staking_pool::staked_sui_amount(v12)
                                        } else {
                                            (((v10 as u128) * (0x3::staking_pool::staked_sui_amount(v12) as u128) / (v9 as u128)) as u64)
                                        };
                                        if (v6 == 0 || v7 == 0) {
                                            v16
                                        } else {
                                            (((v6 as u128) * (v16 as u128) / (v7 as u128)) as u64)
                                        }
                                    };
                                    v13 = v15;
                                    /* goto 34 */
                                } else {
                                    /* goto 45 */
                                };
                            };
                        };
                        v13
                    };
                    /* label 34 */
                    let v17 = if (0x2::table::contains<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(&arg0.stake, v3)) {
                        let v18 = 0x2::table::borrow<0x2::object::ID, 0x3::staking_pool::FungibleStakedSui>(&arg0.stake, v3);
                        if (v6 == 0 || v7 == 0) {
                            0x3::staking_pool::fungible_staked_sui_value(v18)
                        } else {
                            (((v6 as u128) * (0x3::staking_pool::fungible_staked_sui_value(v18) as u128) / (v7 as u128)) as u64)
                        }
                    } else {
                        0
                    };
                    0x1::vector::push_back<u64>(&mut v0, v13 + v17);
                    v2 = v2 + 1;
                    /* goto 1 */
                    continue;
                    /* label 45 */
                    v11 = v11 - 1;
                    /* goto 13 */
                    continue;
                    v10 = 0;
                    v9 = 0;
                    /* goto 17 */
                    /* label 47 */
                    v13 = 0x3::staking_pool::staked_sui_amount(v12);
                    /* goto 34 */
                };
                v4 = v4 - 1;
            };
            v7 = 0;
            v6 = 0;
            /* goto 7 */
        };
        0x1::vector::destroy_empty<0x2::object::ID>(v1);
        v0
    }

    // decompiled from Move bytecode v6
}

