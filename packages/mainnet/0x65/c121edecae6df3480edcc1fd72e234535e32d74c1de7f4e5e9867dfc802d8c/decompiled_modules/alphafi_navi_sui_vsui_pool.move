module 0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::alphafi_navi_sui_vsui_pool {
    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: vector<u8>,
        image_url: vector<u8>,
        xTokenSupply: u64,
        tokensInvested: u64,
        rewards: 0x2::bag::Bag,
        acc_rewards_per_xtoken: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u256>,
        deposit_fee: u64,
        deposit_fee_max_cap: u64,
        withdrawal_fee: u64,
        withdraw_fee_max_cap: u64,
        paused: bool,
    }

    struct Receipt has store, key {
        id: 0x2::object::UID,
        owner: address,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        pool_id: 0x2::object::ID,
        xTokenBalance: u64,
        last_acc_reward_per_xtoken: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u256>,
        pending_rewards: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    struct ALPHAFI_NAVI_SUI_VSUI_POOL has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct RewardEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        sender: address,
    }

    struct LiquidityChangeNewNewEvent has copy, drop {
        pool_id: 0x2::object::ID,
        event_type: u8,
        fee_collected: u64,
        amount: u64,
        user_total_x_token_balance: u64,
        x_token_supply: u64,
        tokens_invested: u64,
        sender: address,
    }

    fun add_rewards<T0>(arg0: &mut Pool<0x2::sui::SUI>, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.rewards, v0) == true) {
            let v1 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u256>(&mut arg0.acc_rewards_per_xtoken, &v0);
            *v1 = *v1 + (0x2::balance::value<T0>(&arg1) as u256) * (1000000000000000000000000000000000000 as u256) / (arg0.xTokenSupply as u256);
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.rewards, v0), arg1);
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u256>(&mut arg0.acc_rewards_per_xtoken, v0, (0x2::balance::value<T0>(&arg1) as u256) * (1000000000000000000000000000000000000 as u256) / (arg0.xTokenSupply as u256));
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.rewards, v0, arg1);
        };
    }

    fun assert_receipt<T0>(arg0: &Receipt, arg1: &Pool<T0>) {
        assert!(arg0.pool_id == 0x2::object::uid_to_inner(&arg1.id), 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::invalid_receipt_error());
    }

    public fun create(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::DevCap, arg1: &0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::version::Version, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::version::assert_current_version(arg1);
        let v0 = Pool<0x2::sui::SUI>{
            id                     : 0x2::object::new(arg4),
            name                   : arg2,
            image_url              : arg3,
            xTokenSupply           : 0,
            tokensInvested         : 0,
            rewards                : 0x2::bag::new(arg4),
            acc_rewards_per_xtoken : 0x2::vec_map::empty<0x1::type_name::TypeName, u256>(),
            deposit_fee            : 0,
            deposit_fee_max_cap    : 100,
            withdrawal_fee         : 0,
            withdraw_fee_max_cap   : 100,
            paused                 : false,
        };
        0x2::transfer::public_share_object<Pool<0x2::sui::SUI>>(v0);
    }

    public fun deposit<T0>(arg0: &0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::version::Version, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: 0x1::option::Option<Receipt>, arg3: &mut Pool<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::alphafi_navi_sui_vsui_investor::Investor<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg6: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg7: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T0>, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg15: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg16: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg17: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>, arg18: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg19: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg20: &mut 0x3::sui_system::SuiSystemState, arg21: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>, arg22: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg23: &0x2::clock::Clock, arg24: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<Receipt> {
        0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::version::assert_current_version(arg0);
        if (0x1::option::is_some<Receipt>(&arg2) == true) {
            if (0x1::option::borrow<Receipt>(&arg2).owner != 0x2::tx_context::sender(arg24)) {
                0x2::transfer::public_transfer<Receipt>(0x1::option::extract<Receipt>(&mut arg2), 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::get_onhold_receipts_wallet_address(arg6));
                0x1::option::destroy_none<Receipt>(arg2);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, 0x2::tx_context::sender(arg24));
                return 0x1::option::none<Receipt>()
            };
        };
        assert!(arg3.paused == false, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::pool_paused());
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) > 0, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::zero_deposit_error());
        update_pool<T0>(arg0, arg3, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24);
        internal_deposit(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg17, arg15, arg18, arg19, arg20, arg23, arg24)
    }

    fun destroy_receipt_and_transfer_rewards(arg0: &0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::version::Version, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: Receipt, arg3: 0x1::option::Option<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>, arg4: &mut Pool<0x2::sui::SUI>, arg5: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Pool<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>, arg6: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.xTokenBalance == 0, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::receipt_not_empty());
        let v0 = &mut arg2;
        let v1 = get_user_rewards_all(arg0, arg1, v0, arg3, arg4, arg5, arg6, arg7, arg8);
        let Receipt {
            id                         : v2,
            owner                      : _,
            name                       : _,
            image_url                  : _,
            pool_id                    : _,
            xTokenBalance              : _,
            last_acc_reward_per_xtoken : v8,
            pending_rewards            : _,
        } = arg2;
        let v10 = v8;
        0x2::object::delete(v2);
        let v11 = 0;
        while (v11 < 0x2::vec_map::size<0x1::type_name::TypeName, u256>(&v10)) {
            let (_, _) = 0x2::vec_map::pop<0x1::type_name::TypeName, u256>(&mut v10);
            v11 = v11 + 1;
        };
        0x2::vec_map::destroy_empty<0x1::type_name::TypeName, u256>(v10);
        if (0x1::option::is_some<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>(&v1) == true) {
            0x2::transfer::public_transfer<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>(0x1::option::extract<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>(&mut v1), 0x2::tx_context::sender(arg8));
        };
        0x1::option::destroy_none<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>(v1);
    }

    fun exchange_rate(arg0: &Pool<0x2::sui::SUI>) : u256 {
        if (arg0.tokensInvested == 0 || arg0.xTokenSupply == 0) {
            (1000000000000000000000000000000000000 as u256)
        } else {
            (arg0.tokensInvested as u256) * (1000000000000000000000000000000000000 as u256) / (arg0.xTokenSupply as u256)
        }
    }

    fun get_pool_rewards_all(arg0: &mut Pool<0x2::sui::SUI>, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        get_rewards<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>(arg0, arg1, arg2, arg3, arg4);
    }

    fun get_rewards<T0>(arg0: &mut Pool<0x2::sui::SUI>, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        if (arg0.xTokenSupply == 0) {
            if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.rewards, v0) == false) {
                0x2::vec_map::insert<0x1::type_name::TypeName, u256>(&mut arg0.acc_rewards_per_xtoken, v0, 0);
                0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.rewards, v0, 0x2::balance::zero<T0>());
            };
            return
        };
        let v1 = Witness{dummy_field: false};
        let v2 = 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::get_rewards_<T0, Witness>(arg2, arg1, 0x2::object::uid_to_inner(&arg0.id), arg3, v1, arg4);
        add_rewards<T0>(arg0, v2);
    }

    fun get_user_rewards<T0>(arg0: &mut Receipt, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: &mut Pool<0x2::sui::SUI>, arg3: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        get_rewards<T0>(arg2, arg1, arg3, arg4, arg5);
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg2.rewards, v0) == true) {
            let v2 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u256>(&mut arg2.acc_rewards_per_xtoken, &v0);
            let v3 = if (0x2::vec_map::contains<0x1::type_name::TypeName, u256>(&arg0.last_acc_reward_per_xtoken, &v0) == true) {
                let v4 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u256>(&mut arg0.last_acc_reward_per_xtoken, &v0);
                *v4 = *v2;
                *v4
            } else {
                0x2::vec_map::insert<0x1::type_name::TypeName, u256>(&mut arg0.last_acc_reward_per_xtoken, v0, *v2);
                0
            };
            let v5 = 0x1::type_name::get<T0>();
            let v6 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.pending_rewards, &v5);
            let v7 = (((*v2 - v3) * (arg0.xTokenBalance as u256) / (1000000000000000000000000000000000000 as u256)) as u64) + *v6;
            *v6 = 0;
            let v8 = RewardEvent{
                coin_type : 0x1::type_name::get<T0>(),
                amount    : v7,
                sender    : 0x2::tx_context::sender(arg5),
            };
            0x2::event::emit<RewardEvent>(v8);
            0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg2.rewards, v0), (v7 as u64))
        } else {
            0x2::balance::zero<T0>()
        }
    }

    public fun get_user_rewards_all(arg0: &0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::version::Version, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: &mut Receipt, arg3: 0x1::option::Option<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>, arg4: &mut Pool<0x2::sui::SUI>, arg5: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Pool<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>, arg6: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt> {
        0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::version::assert_current_version(arg0);
        stake_all_alpha_to_alpha_pool(arg0, arg1, arg2, arg3, arg4, arg6, arg5, arg7, arg8)
    }

    fun init(arg0: ALPHAFI_NAVI_SUI_VSUI_POOL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"AlphaFi Liquidity Position"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"AlphaFi"));
        let v4 = 0x2::package::claim<ALPHAFI_NAVI_SUI_VSUI_POOL>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Receipt>(&v4, v0, v2, arg1);
        0x2::display::update_version<Receipt>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Receipt>>(v5, 0x2::tx_context::sender(arg1));
    }

    fun internal_deposit(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg1: 0x1::option::Option<Receipt>, arg2: &mut Pool<0x2::sui::SUI>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::alphafi_navi_sui_vsui_investor::Investor<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg5: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg6: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg12: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>, arg13: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg14: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg15: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg16: &mut 0x3::sui_system::SuiSystemState, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<Receipt> {
        get_pool_rewards_all(arg2, arg0, arg5, arg17, arg18);
        if (0x1::option::is_some<Receipt>(&arg1) == true) {
            assert_receipt<0x2::sui::SUI>(0x1::option::borrow_mut<Receipt>(&mut arg1), arg2);
        };
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg3);
        let v1 = (0x2::balance::value<0x2::sui::SUI>(&v0) as u128) * (arg2.deposit_fee as u128) / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v0, (v1 as u64)), arg18), 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::get_fee_wallet_address(arg5));
        0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::alphafi_navi_sui_vsui_investor::deposit_sui(arg4, arg17, arg6, arg7, arg8, arg9, 0x2::coin::from_balance<0x2::sui::SUI>(v0, arg18), arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg18);
        arg2.tokensInvested = 0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::alphafi_navi_sui_vsui_investor::get_total_invested(arg4, arg7, arg17);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg2.id, b"max_supply") == true, 0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::error::max_supply_not_set());
        assert!(0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::alphafi_navi_sui_vsui_investor::total_supplied_without_debt(arg4, arg17, arg7, arg14, arg15) <= *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg2.id, b"max_supply"), 0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::error::max_supply_limit());
        let v2 = ((arg2.tokensInvested - arg2.tokensInvested) as u256) * (1000000000000000000000000000000000000 as u256) / exchange_rate(arg2);
        assert!(v2 > 0, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::insufficient_deposit_amount());
        arg2.xTokenSupply = arg2.xTokenSupply + (v2 as u64);
        let v3 = if (0x1::option::is_some<Receipt>(&arg1) == true) {
            let v4 = 0x1::option::extract<Receipt>(&mut arg1);
            let v5 = &mut v4;
            update_user_rewards_all(v5, arg2);
            v4.xTokenBalance = v4.xTokenBalance + (v2 as u64);
            v4
        } else {
            let v6 = 0x2::vec_map::empty<0x1::type_name::TypeName, u256>();
            let v7 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
            let v8 = 0;
            while (v8 < 0x2::vec_map::size<0x1::type_name::TypeName, u256>(&arg2.acc_rewards_per_xtoken)) {
                let (v9, v10) = 0x2::vec_map::get_entry_by_idx_mut<0x1::type_name::TypeName, u256>(&mut arg2.acc_rewards_per_xtoken, v8);
                0x2::vec_map::insert<0x1::type_name::TypeName, u256>(&mut v6, *v9, *v10);
                0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v7, *v9, 0);
                v8 = v8 + 1;
            };
            Receipt{id: 0x2::object::new(arg18), owner: 0x2::tx_context::sender(arg18), name: 0x1::string::utf8(arg2.name), image_url: 0x1::string::utf8(arg2.image_url), pool_id: 0x2::object::uid_to_inner(&arg2.id), xTokenBalance: (v2 as u64), last_acc_reward_per_xtoken: v6, pending_rewards: v7}
        };
        let v11 = v3;
        0x1::option::destroy_none<Receipt>(arg1);
        let v12 = LiquidityChangeNewNewEvent{
            pool_id                    : 0x2::object::uid_to_inner(&arg2.id),
            event_type                 : 0,
            fee_collected              : (v1 as u64),
            amount                     : 0x2::balance::value<0x2::sui::SUI>(&v0),
            user_total_x_token_balance : v11.xTokenBalance,
            x_token_supply             : arg2.xTokenSupply,
            tokens_invested            : arg2.tokensInvested,
            sender                     : 0x2::tx_context::sender(arg18),
        };
        0x2::event::emit<LiquidityChangeNewNewEvent>(v12);
        0x1::option::some<Receipt>(v11)
    }

    fun internal_withdraw(arg0: &0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::version::Version, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: Receipt, arg3: 0x1::option::Option<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>, arg4: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Pool<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>, arg5: &mut Pool<0x2::sui::SUI>, arg6: u64, arg7: &mut 0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::alphafi_navi_sui_vsui_investor::Investor<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg8: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg9: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg16: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg17: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>, arg18: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg19: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>, arg20: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg21: &0x2::clock::Clock, arg22: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<Receipt>, 0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>) {
        get_pool_rewards_all(arg5, arg1, arg8, arg21, arg22);
        let v0 = &mut arg2;
        update_user_rewards_all(v0, arg5);
        let v1 = 0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::alphafi_navi_sui_vsui_investor::withdraw_from_navi(arg7, arg21, arg9, arg10, arg11, arg12, arg6, arg5.xTokenSupply, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg22);
        arg5.xTokenSupply = arg5.xTokenSupply - arg6;
        arg2.xTokenBalance = arg2.xTokenBalance - arg6;
        arg5.tokensInvested = 0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::alphafi_navi_sui_vsui_investor::get_total_invested(arg7, arg10, arg21);
        let v2 = (0x2::balance::value<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&v1) as u128) * (arg5.withdrawal_fee as u128) / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>>(0x2::coin::from_balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(0x2::balance::split<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&mut v1, (v2 as u64)), arg22), 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::get_fee_wallet_address(arg8));
        let v3 = LiquidityChangeNewNewEvent{
            pool_id                    : 0x2::object::uid_to_inner(&arg5.id),
            event_type                 : 1,
            fee_collected              : (v2 as u64),
            amount                     : 0x2::balance::value<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&v1),
            user_total_x_token_balance : arg2.xTokenBalance,
            x_token_supply             : arg5.xTokenSupply,
            tokens_invested            : arg5.tokensInvested,
            sender                     : 0x2::tx_context::sender(arg22),
        };
        0x2::event::emit<LiquidityChangeNewNewEvent>(v3);
        if (arg2.xTokenBalance == 0) {
            destroy_receipt_and_transfer_rewards(arg0, arg1, arg2, arg3, arg5, arg4, arg8, arg21, arg22);
            (0x1::option::none<Receipt>(), 0x2::coin::from_balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(v1, arg22))
        } else {
            if (0x1::option::is_some<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>(&arg3) == true) {
                0x2::transfer::public_transfer<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>(0x1::option::extract<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>(&mut arg3), 0x2::tx_context::sender(arg22));
            };
            0x1::option::destroy_none<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>(arg3);
            (0x1::option::some<Receipt>(arg2), 0x2::coin::from_balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(v1, arg22))
        }
    }

    entry fun set_deposit_fee(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::AdminCap, arg1: &0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::version::Version, arg2: &mut Pool<0x2::sui::SUI>, arg3: u64) {
        0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::version::assert_current_version(arg1);
        assert!(arg3 <= arg2.deposit_fee_max_cap, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::fee_too_high_error());
        arg2.deposit_fee = arg3;
    }

    entry fun set_pause(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::EmergencyCap, arg1: &0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::version::Version, arg2: &mut Pool<0x2::sui::SUI>, arg3: bool) {
        0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::version::assert_current_version(arg1);
        arg2.paused = arg3;
    }

    entry fun set_pool_max_supply_in_mists(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::AdminCap, arg1: &0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::version::Version, arg2: &mut Pool<0x2::sui::SUI>, arg3: u64) {
        0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::version::assert_current_version(arg1);
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg2.id, b"max_supply") == true) {
            *0x2::dynamic_field::borrow_mut<vector<u8>, u64>(&mut arg2.id, b"max_supply") = arg3;
        } else {
            0x2::dynamic_field::add<vector<u8>, u64>(&mut arg2.id, b"max_supply", arg3);
        };
    }

    entry fun set_withdrawal_fee(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::AdminCap, arg1: &0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::version::Version, arg2: &mut Pool<0x2::sui::SUI>, arg3: u64) {
        0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::version::assert_current_version(arg1);
        assert!(arg3 <= arg2.withdraw_fee_max_cap, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::fee_too_high_error());
        arg2.withdrawal_fee = arg3;
    }

    fun stake_all_alpha_to_alpha_pool(arg0: &0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::version::Version, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: &mut Receipt, arg3: 0x1::option::Option<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>, arg4: &mut Pool<0x2::sui::SUI>, arg5: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg6: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Pool<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt> {
        0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::version::assert_current_version(arg0);
        let v0 = get_user_rewards<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>(arg2, arg1, arg4, arg5, arg7, arg8);
        if (0x2::balance::value<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>(&v0) > 0) {
            0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::deposit<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>(arg1, arg3, arg6, arg5, 0x2::coin::from_balance<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>(v0, arg8), arg7, arg8)
        } else {
            0x2::balance::destroy_zero<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>(v0);
            arg3
        }
    }

    public fun update_pool<T0>(arg0: &0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::version::Version, arg1: &mut Pool<0x2::sui::SUI>, arg2: &mut 0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::alphafi_navi_sui_vsui_investor::Investor<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg3: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg4: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T0>, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg12: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg13: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg14: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>, arg15: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg16: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg17: &mut 0x3::sui_system::SuiSystemState, arg18: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>, arg19: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) {
        0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::version::assert_current_version(arg0);
        0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::alphafi_navi_sui_vsui_investor::check_and_set_asset_ltv(arg2, arg20, arg4, arg5, arg6, arg7, arg8, arg9, arg15, arg16, arg17, arg14, arg12, arg18, arg19, arg21);
        0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::alphafi_navi_sui_vsui_investor::autocompound<T0>(arg2, arg3, arg20, arg4, arg5, arg6, arg8, arg9, arg10, arg11, arg15, arg16, arg17, arg13, arg14, arg12, arg21);
        0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::alphafi_navi_sui_vsui_investor::fix_ratio(arg2, arg20, arg4, arg5, arg6, arg7, arg8, arg9, arg15, arg16, arg17, arg14, arg12, arg18, arg19, arg21);
        0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::alphafi_navi_sui_vsui_investor::check_price_and_fix_health(arg2, arg20, arg4, arg5, arg6, arg7, arg8, arg9, arg15, arg16, arg17, arg14, arg12, arg18, arg19, arg21);
        arg1.tokensInvested = 0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::alphafi_navi_sui_vsui_investor::get_total_invested(arg2, arg5, arg20);
    }

    fun update_user_rewards<T0>(arg0: &mut Receipt, arg1: &mut Pool<0x2::sui::SUI>) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg1.rewards, v0) == true) {
            let v1 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u256>(&mut arg1.acc_rewards_per_xtoken, &v0);
            let v2 = if (0x2::vec_map::contains<0x1::type_name::TypeName, u256>(&arg0.last_acc_reward_per_xtoken, &v0) == true) {
                let v3 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u256>(&mut arg0.last_acc_reward_per_xtoken, &v0);
                *v3 = *v1;
                *v3
            } else {
                0x2::vec_map::insert<0x1::type_name::TypeName, u256>(&mut arg0.last_acc_reward_per_xtoken, v0, *v1);
                0
            };
            if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.pending_rewards, &v0) == true) {
                let v4 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.pending_rewards, &v0);
                *v4 = *v4 + (((*v1 - v2) * (arg0.xTokenBalance as u256) / (1000000000000000000000000000000000000 as u256)) as u64);
            } else {
                0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.pending_rewards, v0, (((*v1 - v2) * (arg0.xTokenBalance as u256) / (1000000000000000000000000000000000000 as u256)) as u64));
            };
        };
    }

    fun update_user_rewards_all(arg0: &mut Receipt, arg1: &mut Pool<0x2::sui::SUI>) {
        update_user_rewards<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>(arg0, arg1);
    }

    public fun user_deposit<T0>(arg0: &0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::version::Version, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: 0x1::option::Option<Receipt>, arg3: &mut Pool<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::alphafi_navi_sui_vsui_investor::Investor<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg6: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg7: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T0>, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg15: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg16: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg17: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>, arg18: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg19: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg20: &mut 0x3::sui_system::SuiSystemState, arg21: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>, arg22: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg23: &0x2::clock::Clock, arg24: &mut 0x2::tx_context::TxContext) {
        0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::version::assert_current_version(arg0);
        let v0 = deposit<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24);
        if (0x1::option::is_some<Receipt>(&v0) == true) {
            0x2::transfer::public_transfer<Receipt>(0x1::option::extract<Receipt>(&mut v0), 0x2::tx_context::sender(arg24));
        };
        0x1::option::destroy_none<Receipt>(v0);
    }

    public fun user_withdraw<T0>(arg0: &0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::version::Version, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: Receipt, arg3: 0x1::option::Option<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>, arg4: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Pool<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>, arg5: &mut Pool<0x2::sui::SUI>, arg6: u64, arg7: &mut 0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::alphafi_navi_sui_vsui_investor::Investor<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg8: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg9: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T0>, arg16: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg17: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg18: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg19: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>, arg20: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg21: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg22: &mut 0x3::sui_system::SuiSystemState, arg23: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>, arg24: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg25: &0x2::clock::Clock, arg26: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT> {
        0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::version::assert_current_version(arg0);
        let (v0, v1) = withdraw<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg26);
        let v2 = v0;
        if (0x1::option::is_some<Receipt>(&v2) == true) {
            0x2::transfer::public_transfer<Receipt>(0x1::option::extract<Receipt>(&mut v2), 0x2::tx_context::sender(arg26));
        };
        0x1::option::destroy_none<Receipt>(v2);
        v1
    }

    public fun withdraw<T0>(arg0: &0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::version::Version, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: Receipt, arg3: 0x1::option::Option<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>, arg4: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Pool<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>, arg5: &mut Pool<0x2::sui::SUI>, arg6: u64, arg7: &mut 0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::alphafi_navi_sui_vsui_investor::Investor<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg8: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg9: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T0>, arg16: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg17: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg18: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg19: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>, arg20: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg21: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg22: &mut 0x3::sui_system::SuiSystemState, arg23: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>, arg24: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg25: &0x2::clock::Clock, arg26: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<Receipt>, 0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>) {
        0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::version::assert_current_version(arg0);
        if (arg2.owner != 0x2::tx_context::sender(arg26)) {
            0x2::transfer::public_transfer<Receipt>(arg2, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::get_onhold_receipts_wallet_address(arg8));
            0x2::transfer::public_transfer<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>(0x1::option::extract<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>(&mut arg3), 0x2::tx_context::sender(arg26));
            0x1::option::destroy_none<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>(arg3);
            return (0x1::option::none<Receipt>(), 0x2::coin::zero<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg26))
        };
        assert!(arg5.paused == false, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::pool_paused());
        assert_receipt<0x2::sui::SUI>(&arg2, arg5);
        assert!(arg6 > 0, 0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::error::zero_withdraw_error());
        assert!(arg6 <= arg2.xTokenBalance, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::insufficient_balance_error());
        update_pool<T0>(arg0, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg26);
        internal_withdraw(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg20, arg21, arg19, arg17, arg23, arg24, arg25, arg26)
    }

    // decompiled from Move bytecode v6
}

