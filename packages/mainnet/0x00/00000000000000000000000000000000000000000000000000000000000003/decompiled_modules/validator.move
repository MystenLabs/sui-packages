module 0x3::validator {
    struct ValidatorMetadata has store {
        sui_address: address,
        protocol_pubkey_bytes: vector<u8>,
        network_pubkey_bytes: vector<u8>,
        worker_pubkey_bytes: vector<u8>,
        proof_of_possession: vector<u8>,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        project_url: 0x2::url::Url,
        net_address: 0x1::string::String,
        p2p_address: 0x1::string::String,
        primary_address: 0x1::string::String,
        worker_address: 0x1::string::String,
        next_epoch_protocol_pubkey_bytes: 0x1::option::Option<vector<u8>>,
        next_epoch_proof_of_possession: 0x1::option::Option<vector<u8>>,
        next_epoch_network_pubkey_bytes: 0x1::option::Option<vector<u8>>,
        next_epoch_worker_pubkey_bytes: 0x1::option::Option<vector<u8>>,
        next_epoch_net_address: 0x1::option::Option<0x1::string::String>,
        next_epoch_p2p_address: 0x1::option::Option<0x1::string::String>,
        next_epoch_primary_address: 0x1::option::Option<0x1::string::String>,
        next_epoch_worker_address: 0x1::option::Option<0x1::string::String>,
        extra_fields: 0x2::bag::Bag,
    }

    struct Validator has store {
        metadata: ValidatorMetadata,
        voting_power: u64,
        operation_cap_id: 0x2::object::ID,
        gas_price: u64,
        staking_pool: 0x3::staking_pool::StakingPool,
        commission_rate: u64,
        next_epoch_stake: u64,
        next_epoch_gas_price: u64,
        next_epoch_commission_rate: u64,
        extra_fields: 0x2::bag::Bag,
    }

    struct StakingRequestEvent has copy, drop {
        pool_id: 0x2::object::ID,
        validator_address: address,
        staker_address: address,
        epoch: u64,
        amount: u64,
    }

    struct UnstakingRequestEvent has copy, drop {
        pool_id: 0x2::object::ID,
        validator_address: address,
        staker_address: address,
        stake_activation_epoch: u64,
        unstaking_epoch: u64,
        principal_amount: u64,
        reward_amount: u64,
    }

    struct ConvertingToFungibleStakedSuiEvent has copy, drop {
        pool_id: 0x2::object::ID,
        stake_activation_epoch: u64,
        staked_sui_principal_amount: u64,
        fungible_staked_sui_amount: u64,
    }

    struct RedeemingFungibleStakedSuiEvent has copy, drop {
        pool_id: 0x2::object::ID,
        fungible_staked_sui_amount: u64,
        sui_amount: u64,
    }

    public(friend) fun new(arg0: address, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<u8>, arg12: vector<u8>, arg13: u64, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) : Validator {
        let v0 = if (0x1::vector::length<u8>(&arg9) <= 256) {
            if (0x1::vector::length<u8>(&arg10) <= 256) {
                if (0x1::vector::length<u8>(&arg11) <= 256) {
                    if (0x1::vector::length<u8>(&arg12) <= 256) {
                        if (0x1::vector::length<u8>(&arg5) <= 256) {
                            if (0x1::vector::length<u8>(&arg6) <= 256) {
                                if (0x1::vector::length<u8>(&arg7) <= 256) {
                                    0x1::vector::length<u8>(&arg8) <= 256
                                } else {
                                    false
                                }
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 9);
        assert!(arg14 <= 2000, 8);
        assert!(arg13 < 100000, 102);
        let v1 = new_metadata(arg0, arg1, arg2, arg3, arg4, 0x1::string::from_ascii(0x1::ascii::string(arg5)), 0x1::string::from_ascii(0x1::ascii::string(arg6)), 0x2::url::new_unsafe_from_bytes(arg7), 0x2::url::new_unsafe_from_bytes(arg8), 0x1::string::from_ascii(0x1::ascii::string(arg9)), 0x1::string::from_ascii(0x1::ascii::string(arg10)), 0x1::string::from_ascii(0x1::ascii::string(arg11)), 0x1::string::from_ascii(0x1::ascii::string(arg12)), 0x2::bag::new(arg15));
        validate_metadata(&v1);
        new_from_metadata(v1, arg13, arg14, arg15)
    }

    public(friend) fun convert_to_fungible_staked_sui(arg0: &mut Validator, arg1: 0x3::staking_pool::StakedSui, arg2: &mut 0x2::tx_context::TxContext) : 0x3::staking_pool::FungibleStakedSui {
        let v0 = 0x3::staking_pool::convert_to_fungible_staked_sui(&mut arg0.staking_pool, arg1, arg2);
        let v1 = ConvertingToFungibleStakedSuiEvent{
            pool_id                     : staking_pool_id(arg0),
            stake_activation_epoch      : 0x3::staking_pool::stake_activation_epoch(&arg1),
            staked_sui_principal_amount : 0x3::staking_pool::staked_sui_amount(&arg1),
            fungible_staked_sui_amount  : 0x3::staking_pool::fungible_staked_sui_value(&v0),
        };
        0x2::event::emit<ConvertingToFungibleStakedSuiEvent>(v1);
        v0
    }

    public fun is_preactive(arg0: &Validator) : bool {
        0x3::staking_pool::is_preactive(&arg0.staking_pool)
    }

    public fun pending_stake_amount(arg0: &Validator) : u64 {
        0x3::staking_pool::pending_stake_amount(&arg0.staking_pool)
    }

    public fun pending_stake_withdraw_amount(arg0: &Validator) : u64 {
        0x3::staking_pool::pending_stake_withdraw_amount(&arg0.staking_pool)
    }

    public fun pool_token_exchange_rate_at_epoch(arg0: &Validator, arg1: u64) : 0x3::staking_pool::PoolTokenExchangeRate {
        0x3::staking_pool::pool_token_exchange_rate_at_epoch(&arg0.staking_pool, arg1)
    }

    public(friend) fun process_pending_stakes_and_withdraws(arg0: &mut Validator, arg1: &0x2::tx_context::TxContext) {
        0x3::staking_pool::process_pending_stakes_and_withdraws(&mut arg0.staking_pool, arg1);
    }

    public(friend) fun redeem_fungible_staked_sui(arg0: &mut Validator, arg1: 0x3::staking_pool::FungibleStakedSui, arg2: &0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x3::staking_pool::redeem_fungible_staked_sui(&mut arg0.staking_pool, arg1, arg2);
        arg0.next_epoch_stake = arg0.next_epoch_stake - 0x2::balance::value<0x2::sui::SUI>(&v0);
        let v1 = RedeemingFungibleStakedSuiEvent{
            pool_id                    : staking_pool_id(arg0),
            fungible_staked_sui_amount : 0x3::staking_pool::fungible_staked_sui_value(&arg1),
            sui_amount                 : 0x2::balance::value<0x2::sui::SUI>(&v0),
        };
        0x2::event::emit<RedeemingFungibleStakedSuiEvent>(v1);
        v0
    }

    public(friend) fun request_add_stake(arg0: &mut Validator, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x3::staking_pool::StakedSui {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 11);
        if (0x3::staking_pool::is_preactive(&arg0.staking_pool)) {
            0x3::staking_pool::process_pending_stake(&mut arg0.staking_pool);
        };
        arg0.next_epoch_stake = arg0.next_epoch_stake + v0;
        let v1 = StakingRequestEvent{
            pool_id           : staking_pool_id(arg0),
            validator_address : arg0.metadata.sui_address,
            staker_address    : arg2,
            epoch             : 0x2::tx_context::epoch(arg3),
            amount            : v0,
        };
        0x2::event::emit<StakingRequestEvent>(v1);
        0x3::staking_pool::request_add_stake(&mut arg0.staking_pool, arg1, 0x2::tx_context::epoch(arg3) + 1, arg3)
    }

    public(friend) fun request_withdraw_stake(arg0: &mut Validator, arg1: 0x3::staking_pool::StakedSui, arg2: &0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x3::staking_pool::staked_sui_amount(&arg1);
        let v1 = 0x3::staking_pool::request_withdraw_stake(&mut arg0.staking_pool, arg1, arg2);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&v1);
        arg0.next_epoch_stake = arg0.next_epoch_stake - v2;
        let v3 = UnstakingRequestEvent{
            pool_id                : staking_pool_id(arg0),
            validator_address      : arg0.metadata.sui_address,
            staker_address         : 0x2::tx_context::sender(arg2),
            stake_activation_epoch : 0x3::staking_pool::stake_activation_epoch(&arg1),
            unstaking_epoch        : 0x2::tx_context::epoch(arg2),
            principal_amount       : v0,
            reward_amount          : v2 - v0,
        };
        0x2::event::emit<UnstakingRequestEvent>(v3);
        v1
    }

    public(friend) fun activate(arg0: &mut Validator, arg1: u64) {
        0x3::staking_pool::activate_staking_pool(&mut arg0.staking_pool, arg1);
    }

    public(friend) fun adjust_stake_and_gas_price(arg0: &mut Validator) {
        arg0.gas_price = arg0.next_epoch_gas_price;
        arg0.commission_rate = arg0.next_epoch_commission_rate;
    }

    public fun commission_rate(arg0: &Validator) : u64 {
        arg0.commission_rate
    }

    public(friend) fun deactivate(arg0: &mut Validator, arg1: u64) {
        0x3::staking_pool::deactivate_staking_pool(&mut arg0.staking_pool, arg1);
    }

    public(friend) fun deposit_stake_rewards(arg0: &mut Validator, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        arg0.next_epoch_stake = arg0.next_epoch_stake + 0x2::balance::value<0x2::sui::SUI>(&arg1);
        0x3::staking_pool::deposit_rewards(&mut arg0.staking_pool, arg1);
    }

    public fun description(arg0: &Validator) : &0x1::string::String {
        &arg0.metadata.description
    }

    public(friend) fun effectuate_staged_metadata(arg0: &mut Validator) {
        let v0 = &mut arg0.metadata.next_epoch_net_address;
        if (0x1::option::is_some<0x1::string::String>(v0)) {
            arg0.metadata.net_address = 0x1::option::extract<0x1::string::String>(v0);
        };
        let v1 = &mut arg0.metadata.next_epoch_p2p_address;
        if (0x1::option::is_some<0x1::string::String>(v1)) {
            arg0.metadata.p2p_address = 0x1::option::extract<0x1::string::String>(v1);
        };
        let v2 = &mut arg0.metadata.next_epoch_primary_address;
        if (0x1::option::is_some<0x1::string::String>(v2)) {
            arg0.metadata.primary_address = 0x1::option::extract<0x1::string::String>(v2);
        };
        let v3 = &mut arg0.metadata.next_epoch_worker_address;
        if (0x1::option::is_some<0x1::string::String>(v3)) {
            arg0.metadata.worker_address = 0x1::option::extract<0x1::string::String>(v3);
        };
        let v4 = &mut arg0.metadata.next_epoch_protocol_pubkey_bytes;
        if (0x1::option::is_some<vector<u8>>(v4)) {
            arg0.metadata.protocol_pubkey_bytes = 0x1::option::extract<vector<u8>>(v4);
            arg0.metadata.proof_of_possession = 0x1::option::extract<vector<u8>>(&mut arg0.metadata.next_epoch_proof_of_possession);
        };
        let v5 = &mut arg0.metadata.next_epoch_network_pubkey_bytes;
        if (0x1::option::is_some<vector<u8>>(v5)) {
            arg0.metadata.network_pubkey_bytes = 0x1::option::extract<vector<u8>>(v5);
        };
        let v6 = &mut arg0.metadata.next_epoch_worker_pubkey_bytes;
        if (0x1::option::is_some<vector<u8>>(v6)) {
            arg0.metadata.worker_pubkey_bytes = 0x1::option::extract<vector<u8>>(v6);
        };
    }

    public fun gas_price(arg0: &Validator) : u64 {
        arg0.gas_price
    }

    public(friend) fun get_staking_pool_ref(arg0: &Validator) : &0x3::staking_pool::StakingPool {
        &arg0.staking_pool
    }

    public fun image_url(arg0: &Validator) : &0x2::url::Url {
        &arg0.metadata.image_url
    }

    public fun is_duplicate(arg0: &Validator, arg1: &Validator) : bool {
        let v0 = &arg0.metadata;
        let v1 = &arg1.metadata;
        if (v0.sui_address == v1.sui_address) {
            true
        } else if (v0.name == v1.name) {
            true
        } else if (v0.net_address == v1.net_address) {
            true
        } else if (v0.p2p_address == v1.p2p_address) {
            true
        } else if (v0.protocol_pubkey_bytes == v1.protocol_pubkey_bytes) {
            true
        } else if (v0.network_pubkey_bytes == v1.network_pubkey_bytes) {
            true
        } else if (v0.network_pubkey_bytes == v1.worker_pubkey_bytes) {
            true
        } else if (v0.worker_pubkey_bytes == v1.worker_pubkey_bytes) {
            true
        } else if (v0.worker_pubkey_bytes == v1.network_pubkey_bytes) {
            true
        } else {
            let v3 = v1.next_epoch_net_address;
            let v4 = v0.next_epoch_net_address;
            let v5 = &v4;
            let v6 = if (0x1::option::is_some<0x1::string::String>(v5)) {
                let v7 = 0x1::option::borrow<0x1::string::String>(v5);
                let v8 = &v3;
                0x1::option::is_some<0x1::string::String>(v8) && v7 == 0x1::option::borrow<0x1::string::String>(v8)
            } else {
                false
            };
            if (v6) {
                true
            } else {
                let v9 = v1.next_epoch_p2p_address;
                let v10 = v0.next_epoch_p2p_address;
                let v11 = &v10;
                let v12 = if (0x1::option::is_some<0x1::string::String>(v11)) {
                    let v13 = 0x1::option::borrow<0x1::string::String>(v11);
                    let v14 = &v9;
                    0x1::option::is_some<0x1::string::String>(v14) && v13 == 0x1::option::borrow<0x1::string::String>(v14)
                } else {
                    false
                };
                if (v12) {
                    true
                } else {
                    let v15 = v1.next_epoch_protocol_pubkey_bytes;
                    let v16 = v0.next_epoch_protocol_pubkey_bytes;
                    let v17 = &v16;
                    let v18 = if (0x1::option::is_some<vector<u8>>(v17)) {
                        let v19 = 0x1::option::borrow<vector<u8>>(v17);
                        let v20 = &v15;
                        0x1::option::is_some<vector<u8>>(v20) && v19 == 0x1::option::borrow<vector<u8>>(v20)
                    } else {
                        false
                    };
                    if (v18) {
                        true
                    } else {
                        let v21 = v1.next_epoch_network_pubkey_bytes;
                        let v22 = v0.next_epoch_network_pubkey_bytes;
                        let v23 = &v22;
                        let v24 = if (0x1::option::is_some<vector<u8>>(v23)) {
                            let v25 = 0x1::option::borrow<vector<u8>>(v23);
                            let v26 = &v21;
                            0x1::option::is_some<vector<u8>>(v26) && v25 == 0x1::option::borrow<vector<u8>>(v26)
                        } else {
                            false
                        };
                        if (v24) {
                            true
                        } else {
                            let v27 = v1.next_epoch_worker_pubkey_bytes;
                            let v28 = v0.next_epoch_network_pubkey_bytes;
                            let v29 = &v28;
                            let v30 = if (0x1::option::is_some<vector<u8>>(v29)) {
                                let v31 = 0x1::option::borrow<vector<u8>>(v29);
                                let v32 = &v27;
                                0x1::option::is_some<vector<u8>>(v32) && v31 == 0x1::option::borrow<vector<u8>>(v32)
                            } else {
                                false
                            };
                            if (v30) {
                                true
                            } else {
                                let v33 = v1.next_epoch_worker_pubkey_bytes;
                                let v34 = v0.next_epoch_worker_pubkey_bytes;
                                let v35 = &v34;
                                let v36 = if (0x1::option::is_some<vector<u8>>(v35)) {
                                    let v37 = 0x1::option::borrow<vector<u8>>(v35);
                                    let v38 = &v33;
                                    0x1::option::is_some<vector<u8>>(v38) && v37 == 0x1::option::borrow<vector<u8>>(v38)
                                } else {
                                    false
                                };
                                if (v36) {
                                    true
                                } else {
                                    let v39 = v1.next_epoch_network_pubkey_bytes;
                                    let v40 = v0.next_epoch_worker_pubkey_bytes;
                                    let v41 = &v40;
                                    let v42 = if (0x1::option::is_some<vector<u8>>(v41)) {
                                        let v43 = 0x1::option::borrow<vector<u8>>(v41);
                                        let v44 = &v39;
                                        0x1::option::is_some<vector<u8>>(v44) && v43 == 0x1::option::borrow<vector<u8>>(v44)
                                    } else {
                                        false
                                    };
                                    if (v42) {
                                        true
                                    } else {
                                        let v45 = &v0.next_epoch_net_address;
                                        let v46 = if (0x1::option::is_some<0x1::string::String>(v45)) {
                                            let v47 = v1.net_address;
                                            0x1::option::borrow<0x1::string::String>(v45) == &v47
                                        } else {
                                            false
                                        };
                                        if (v46) {
                                            true
                                        } else {
                                            let v48 = &v0.next_epoch_p2p_address;
                                            let v49 = if (0x1::option::is_some<0x1::string::String>(v48)) {
                                                let v50 = v1.p2p_address;
                                                0x1::option::borrow<0x1::string::String>(v48) == &v50
                                            } else {
                                                false
                                            };
                                            if (v49) {
                                                true
                                            } else {
                                                let v51 = &v0.next_epoch_protocol_pubkey_bytes;
                                                let v52 = if (0x1::option::is_some<vector<u8>>(v51)) {
                                                    let v53 = v1.protocol_pubkey_bytes;
                                                    0x1::option::borrow<vector<u8>>(v51) == &v53
                                                } else {
                                                    false
                                                };
                                                if (v52) {
                                                    true
                                                } else {
                                                    let v54 = &v0.next_epoch_network_pubkey_bytes;
                                                    let v55 = if (0x1::option::is_some<vector<u8>>(v54)) {
                                                        let v56 = v1.network_pubkey_bytes;
                                                        0x1::option::borrow<vector<u8>>(v54) == &v56
                                                    } else {
                                                        false
                                                    };
                                                    if (v55) {
                                                        true
                                                    } else {
                                                        let v57 = &v0.next_epoch_network_pubkey_bytes;
                                                        let v58 = if (0x1::option::is_some<vector<u8>>(v57)) {
                                                            let v59 = v1.worker_pubkey_bytes;
                                                            0x1::option::borrow<vector<u8>>(v57) == &v59
                                                        } else {
                                                            false
                                                        };
                                                        if (v58) {
                                                            true
                                                        } else {
                                                            let v60 = &v0.next_epoch_worker_pubkey_bytes;
                                                            let v61 = if (0x1::option::is_some<vector<u8>>(v60)) {
                                                                let v62 = v1.worker_pubkey_bytes;
                                                                0x1::option::borrow<vector<u8>>(v60) == &v62
                                                            } else {
                                                                false
                                                            };
                                                            if (v61) {
                                                                true
                                                            } else {
                                                                let v63 = &v0.next_epoch_worker_pubkey_bytes;
                                                                let v64 = if (0x1::option::is_some<vector<u8>>(v63)) {
                                                                    let v65 = v1.network_pubkey_bytes;
                                                                    0x1::option::borrow<vector<u8>>(v63) == &v65
                                                                } else {
                                                                    false
                                                                };
                                                                if (v64) {
                                                                    true
                                                                } else {
                                                                    let v66 = &v1.next_epoch_net_address;
                                                                    let v67 = if (0x1::option::is_some<0x1::string::String>(v66)) {
                                                                        let v68 = v0.net_address;
                                                                        0x1::option::borrow<0x1::string::String>(v66) == &v68
                                                                    } else {
                                                                        false
                                                                    };
                                                                    if (v67) {
                                                                        true
                                                                    } else {
                                                                        let v69 = &v1.next_epoch_p2p_address;
                                                                        let v70 = if (0x1::option::is_some<0x1::string::String>(v69)) {
                                                                            let v71 = v0.p2p_address;
                                                                            0x1::option::borrow<0x1::string::String>(v69) == &v71
                                                                        } else {
                                                                            false
                                                                        };
                                                                        if (v70) {
                                                                            true
                                                                        } else {
                                                                            let v72 = &v1.next_epoch_protocol_pubkey_bytes;
                                                                            let v73 = if (0x1::option::is_some<vector<u8>>(v72)) {
                                                                                let v74 = v0.protocol_pubkey_bytes;
                                                                                0x1::option::borrow<vector<u8>>(v72) == &v74
                                                                            } else {
                                                                                false
                                                                            };
                                                                            if (v73) {
                                                                                true
                                                                            } else {
                                                                                let v75 = &v1.next_epoch_network_pubkey_bytes;
                                                                                let v76 = if (0x1::option::is_some<vector<u8>>(v75)) {
                                                                                    let v77 = v0.network_pubkey_bytes;
                                                                                    0x1::option::borrow<vector<u8>>(v75) == &v77
                                                                                } else {
                                                                                    false
                                                                                };
                                                                                if (v76) {
                                                                                    true
                                                                                } else {
                                                                                    let v78 = &v1.next_epoch_network_pubkey_bytes;
                                                                                    let v79 = if (0x1::option::is_some<vector<u8>>(v78)) {
                                                                                        let v80 = v0.worker_pubkey_bytes;
                                                                                        0x1::option::borrow<vector<u8>>(v78) == &v80
                                                                                    } else {
                                                                                        false
                                                                                    };
                                                                                    if (v79) {
                                                                                        true
                                                                                    } else {
                                                                                        let v81 = &v1.next_epoch_worker_pubkey_bytes;
                                                                                        let v82 = if (0x1::option::is_some<vector<u8>>(v81)) {
                                                                                            let v83 = v0.worker_pubkey_bytes;
                                                                                            0x1::option::borrow<vector<u8>>(v81) == &v83
                                                                                        } else {
                                                                                            false
                                                                                        };
                                                                                        if (v82) {
                                                                                            true
                                                                                        } else {
                                                                                            let v84 = &v1.next_epoch_worker_pubkey_bytes;
                                                                                            if (0x1::option::is_some<vector<u8>>(v84)) {
                                                                                                let v85 = v0.network_pubkey_bytes;
                                                                                                0x1::option::borrow<vector<u8>>(v84) == &v85
                                                                                            } else {
                                                                                                false
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    public fun metadata(arg0: &Validator) : &ValidatorMetadata {
        &arg0.metadata
    }

    public fun name(arg0: &Validator) : &0x1::string::String {
        &arg0.metadata.name
    }

    public fun network_address(arg0: &Validator) : &0x1::string::String {
        &arg0.metadata.net_address
    }

    public fun network_pubkey_bytes(arg0: &Validator) : &vector<u8> {
        &arg0.metadata.network_pubkey_bytes
    }

    fun new_from_metadata(arg0: ValidatorMetadata, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : Validator {
        Validator{
            metadata                   : arg0,
            voting_power               : 0,
            operation_cap_id           : 0x3::validator_cap::new_unverified_validator_operation_cap_and_transfer(arg0.sui_address, arg3),
            gas_price                  : arg1,
            staking_pool               : 0x3::staking_pool::new(arg3),
            commission_rate            : arg2,
            next_epoch_stake           : 0,
            next_epoch_gas_price       : arg1,
            next_epoch_commission_rate : arg2,
            extra_fields               : 0x2::bag::new(arg3),
        }
    }

    public(friend) fun new_metadata(arg0: address, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x2::url::Url, arg8: 0x2::url::Url, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: 0x2::bag::Bag) : ValidatorMetadata {
        ValidatorMetadata{
            sui_address                      : arg0,
            protocol_pubkey_bytes            : arg1,
            network_pubkey_bytes             : arg2,
            worker_pubkey_bytes              : arg3,
            proof_of_possession              : arg4,
            name                             : arg5,
            description                      : arg6,
            image_url                        : arg7,
            project_url                      : arg8,
            net_address                      : arg9,
            p2p_address                      : arg10,
            primary_address                  : arg11,
            worker_address                   : arg12,
            next_epoch_protocol_pubkey_bytes : 0x1::option::none<vector<u8>>(),
            next_epoch_proof_of_possession   : 0x1::option::none<vector<u8>>(),
            next_epoch_network_pubkey_bytes  : 0x1::option::none<vector<u8>>(),
            next_epoch_worker_pubkey_bytes   : 0x1::option::none<vector<u8>>(),
            next_epoch_net_address           : 0x1::option::none<0x1::string::String>(),
            next_epoch_p2p_address           : 0x1::option::none<0x1::string::String>(),
            next_epoch_primary_address       : 0x1::option::none<0x1::string::String>(),
            next_epoch_worker_address        : 0x1::option::none<0x1::string::String>(),
            extra_fields                     : arg13,
        }
    }

    public(friend) fun new_unverified_validator_operation_cap_and_transfer(arg0: &mut Validator, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.metadata.sui_address, 100);
        arg0.operation_cap_id = 0x3::validator_cap::new_unverified_validator_operation_cap_and_transfer(v0, arg1);
    }

    public fun next_epoch_gas_price(arg0: &Validator) : u64 {
        arg0.next_epoch_gas_price
    }

    public fun next_epoch_network_address(arg0: &Validator) : &0x1::option::Option<0x1::string::String> {
        &arg0.metadata.next_epoch_net_address
    }

    public fun next_epoch_network_pubkey_bytes(arg0: &Validator) : &0x1::option::Option<vector<u8>> {
        &arg0.metadata.next_epoch_network_pubkey_bytes
    }

    public fun next_epoch_p2p_address(arg0: &Validator) : &0x1::option::Option<0x1::string::String> {
        &arg0.metadata.next_epoch_p2p_address
    }

    public fun next_epoch_primary_address(arg0: &Validator) : &0x1::option::Option<0x1::string::String> {
        &arg0.metadata.next_epoch_primary_address
    }

    public fun next_epoch_proof_of_possession(arg0: &Validator) : &0x1::option::Option<vector<u8>> {
        &arg0.metadata.next_epoch_proof_of_possession
    }

    public fun next_epoch_protocol_pubkey_bytes(arg0: &Validator) : &0x1::option::Option<vector<u8>> {
        &arg0.metadata.next_epoch_protocol_pubkey_bytes
    }

    public fun next_epoch_worker_address(arg0: &Validator) : &0x1::option::Option<0x1::string::String> {
        &arg0.metadata.next_epoch_worker_address
    }

    public fun next_epoch_worker_pubkey_bytes(arg0: &Validator) : &0x1::option::Option<vector<u8>> {
        &arg0.metadata.next_epoch_worker_pubkey_bytes
    }

    public fun operation_cap_id(arg0: &Validator) : &0x2::object::ID {
        &arg0.operation_cap_id
    }

    public fun p2p_address(arg0: &Validator) : &0x1::string::String {
        &arg0.metadata.p2p_address
    }

    public fun primary_address(arg0: &Validator) : &0x1::string::String {
        &arg0.metadata.primary_address
    }

    public fun project_url(arg0: &Validator) : &0x2::url::Url {
        &arg0.metadata.project_url
    }

    public fun proof_of_possession(arg0: &Validator) : &vector<u8> {
        &arg0.metadata.proof_of_possession
    }

    public fun protocol_pubkey_bytes(arg0: &Validator) : &vector<u8> {
        &arg0.metadata.protocol_pubkey_bytes
    }

    public(friend) fun request_add_stake_at_genesis(arg0: &mut Validator, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg3) == 0, 12);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 11);
        0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(0x3::staking_pool::request_add_stake(&mut arg0.staking_pool, arg1, 0, arg3), arg2);
        0x3::staking_pool::process_pending_stake(&mut arg0.staking_pool);
        arg0.next_epoch_stake = arg0.next_epoch_stake + v0;
    }

    public(friend) fun request_set_commission_rate(arg0: &mut Validator, arg1: u64) {
        assert!(arg1 <= 2000, 8);
        arg0.next_epoch_commission_rate = arg1;
    }

    public(friend) fun request_set_gas_price(arg0: &mut Validator, arg1: 0x3::validator_cap::ValidatorOperationCap, arg2: u64) {
        assert!(arg2 < 100000, 102);
        assert!(*0x3::validator_cap::verified_operation_cap_address(&arg1) == arg0.metadata.sui_address, 101);
        arg0.next_epoch_gas_price = arg2;
    }

    public(friend) fun set_candidate_commission_rate(arg0: &mut Validator, arg1: u64) {
        assert!(is_preactive(arg0), 10);
        assert!(arg1 <= 2000, 8);
        arg0.commission_rate = arg1;
    }

    public(friend) fun set_candidate_gas_price(arg0: &mut Validator, arg1: 0x3::validator_cap::ValidatorOperationCap, arg2: u64) {
        assert!(is_preactive(arg0), 10);
        assert!(arg2 < 100000, 102);
        assert!(*0x3::validator_cap::verified_operation_cap_address(&arg1) == arg0.metadata.sui_address, 101);
        arg0.next_epoch_gas_price = arg2;
        arg0.gas_price = arg2;
    }

    public(friend) fun set_voting_power(arg0: &mut Validator, arg1: u64) {
        arg0.voting_power = arg1;
    }

    public fun stake_amount(arg0: &Validator) : u64 {
        0x3::staking_pool::sui_balance(&arg0.staking_pool)
    }

    public fun staking_pool_id(arg0: &Validator) : 0x2::object::ID {
        0x2::object::id<0x3::staking_pool::StakingPool>(&arg0.staking_pool)
    }

    public fun sui_address(arg0: &Validator) : address {
        arg0.metadata.sui_address
    }

    public fun total_stake(arg0: &Validator) : u64 {
        0x3::staking_pool::sui_balance(&arg0.staking_pool)
    }

    public fun total_stake_amount(arg0: &Validator) : u64 {
        0x3::staking_pool::sui_balance(&arg0.staking_pool)
    }

    public(friend) fun update_candidate_network_address(arg0: &mut Validator, arg1: vector<u8>) {
        assert!(is_preactive(arg0), 10);
        assert!(0x1::vector::length<u8>(&arg1) <= 256, 9);
        arg0.metadata.net_address = 0x1::string::from_ascii(0x1::ascii::string(arg1));
        validate_metadata(&arg0.metadata);
    }

    public(friend) fun update_candidate_network_pubkey(arg0: &mut Validator, arg1: vector<u8>) {
        assert!(is_preactive(arg0), 10);
        arg0.metadata.network_pubkey_bytes = arg1;
        validate_metadata(&arg0.metadata);
    }

    public(friend) fun update_candidate_p2p_address(arg0: &mut Validator, arg1: vector<u8>) {
        assert!(is_preactive(arg0), 10);
        assert!(0x1::vector::length<u8>(&arg1) <= 256, 9);
        arg0.metadata.p2p_address = 0x1::string::from_ascii(0x1::ascii::string(arg1));
        validate_metadata(&arg0.metadata);
    }

    public(friend) fun update_candidate_primary_address(arg0: &mut Validator, arg1: vector<u8>) {
        assert!(is_preactive(arg0), 10);
        assert!(0x1::vector::length<u8>(&arg1) <= 256, 9);
        arg0.metadata.primary_address = 0x1::string::from_ascii(0x1::ascii::string(arg1));
        validate_metadata(&arg0.metadata);
    }

    public(friend) fun update_candidate_protocol_pubkey(arg0: &mut Validator, arg1: vector<u8>, arg2: vector<u8>) {
        assert!(is_preactive(arg0), 10);
        arg0.metadata.protocol_pubkey_bytes = arg1;
        arg0.metadata.proof_of_possession = arg2;
        validate_metadata(&arg0.metadata);
    }

    public(friend) fun update_candidate_worker_address(arg0: &mut Validator, arg1: vector<u8>) {
        assert!(is_preactive(arg0), 10);
        assert!(0x1::vector::length<u8>(&arg1) <= 256, 9);
        arg0.metadata.worker_address = 0x1::string::from_ascii(0x1::ascii::string(arg1));
        validate_metadata(&arg0.metadata);
    }

    public(friend) fun update_candidate_worker_pubkey(arg0: &mut Validator, arg1: vector<u8>) {
        assert!(is_preactive(arg0), 10);
        arg0.metadata.worker_pubkey_bytes = arg1;
        validate_metadata(&arg0.metadata);
    }

    public(friend) fun update_description(arg0: &mut Validator, arg1: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg1) <= 256, 9);
        arg0.metadata.description = 0x1::string::from_ascii(0x1::ascii::string(arg1));
    }

    public(friend) fun update_image_url(arg0: &mut Validator, arg1: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg1) <= 256, 9);
        arg0.metadata.image_url = 0x2::url::new_unsafe_from_bytes(arg1);
    }

    public(friend) fun update_name(arg0: &mut Validator, arg1: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg1) <= 256, 9);
        arg0.metadata.name = 0x1::string::from_ascii(0x1::ascii::string(arg1));
    }

    public(friend) fun update_next_epoch_network_address(arg0: &mut Validator, arg1: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg1) <= 256, 9);
        arg0.metadata.next_epoch_net_address = 0x1::option::some<0x1::string::String>(0x1::string::from_ascii(0x1::ascii::string(arg1)));
        validate_metadata(&arg0.metadata);
    }

    public(friend) fun update_next_epoch_network_pubkey(arg0: &mut Validator, arg1: vector<u8>) {
        arg0.metadata.next_epoch_network_pubkey_bytes = 0x1::option::some<vector<u8>>(arg1);
        validate_metadata(&arg0.metadata);
    }

    public(friend) fun update_next_epoch_p2p_address(arg0: &mut Validator, arg1: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg1) <= 256, 9);
        arg0.metadata.next_epoch_p2p_address = 0x1::option::some<0x1::string::String>(0x1::string::from_ascii(0x1::ascii::string(arg1)));
        validate_metadata(&arg0.metadata);
    }

    public(friend) fun update_next_epoch_primary_address(arg0: &mut Validator, arg1: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg1) <= 256, 9);
        arg0.metadata.next_epoch_primary_address = 0x1::option::some<0x1::string::String>(0x1::string::from_ascii(0x1::ascii::string(arg1)));
        validate_metadata(&arg0.metadata);
    }

    public(friend) fun update_next_epoch_protocol_pubkey(arg0: &mut Validator, arg1: vector<u8>, arg2: vector<u8>) {
        arg0.metadata.next_epoch_protocol_pubkey_bytes = 0x1::option::some<vector<u8>>(arg1);
        arg0.metadata.next_epoch_proof_of_possession = 0x1::option::some<vector<u8>>(arg2);
        validate_metadata(&arg0.metadata);
    }

    public(friend) fun update_next_epoch_worker_address(arg0: &mut Validator, arg1: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg1) <= 256, 9);
        arg0.metadata.next_epoch_worker_address = 0x1::option::some<0x1::string::String>(0x1::string::from_ascii(0x1::ascii::string(arg1)));
        validate_metadata(&arg0.metadata);
    }

    public(friend) fun update_next_epoch_worker_pubkey(arg0: &mut Validator, arg1: vector<u8>) {
        arg0.metadata.next_epoch_worker_pubkey_bytes = 0x1::option::some<vector<u8>>(arg1);
        validate_metadata(&arg0.metadata);
    }

    public(friend) fun update_project_url(arg0: &mut Validator, arg1: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg1) <= 256, 9);
        arg0.metadata.project_url = 0x2::url::new_unsafe_from_bytes(arg1);
    }

    public fun validate_metadata(arg0: &ValidatorMetadata) {
        validate_metadata_bcs(0x1::bcs::to_bytes<ValidatorMetadata>(arg0));
    }

    native public fun validate_metadata_bcs(arg0: vector<u8>);
    public fun voting_power(arg0: &Validator) : u64 {
        arg0.voting_power
    }

    public fun worker_address(arg0: &Validator) : &0x1::string::String {
        &arg0.metadata.worker_address
    }

    public fun worker_pubkey_bytes(arg0: &Validator) : &vector<u8> {
        &arg0.metadata.worker_pubkey_bytes
    }

    // decompiled from Move bytecode v6
}

