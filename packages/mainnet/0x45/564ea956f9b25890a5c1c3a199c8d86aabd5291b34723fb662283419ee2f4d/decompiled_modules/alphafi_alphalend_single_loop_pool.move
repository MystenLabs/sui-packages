module 0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::alphafi_alphalend_single_loop_pool {
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
        investor_id: 0x2::object::ID,
        max_supply: u64,
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

    struct ALPHAFI_ALPHALEND_SINGLE_LOOP_POOL has drop {
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

    struct LiquidityChangeEvent has copy, drop {
        pool_id: 0x2::object::ID,
        event_type: u8,
        fee_collected: u64,
        amount: u64,
        user_total_x_token_balance: u64,
        x_token_supply: u64,
        tokens_invested: u64,
        sender: address,
    }

    public fun collect_reward_and_swap_bluefin<T0, T1, T2>(arg0: &0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::version::Version, arg1: &mut 0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::alphafi_alphalend_single_loop_investor::Investor<T0>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: bool, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::version::assert_current_version(arg0);
        0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::alphafi_alphalend_single_loop_investor::collect_reward_and_swap_bluefin<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    fun deposit<T0>(arg0: &0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::version::Version, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: 0x1::option::Option<Receipt>, arg3: &mut Pool<T0>, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::alphafi_alphalend_single_loop_investor::Investor<T0>, arg6: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg7: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<Receipt> {
        0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::version::assert_current_version(arg0);
        if (0x1::option::is_some<Receipt>(&arg2) == true) {
            if (0x1::option::borrow<Receipt>(&arg2).owner != 0x2::tx_context::sender(arg9)) {
                0x2::transfer::public_transfer<Receipt>(0x1::option::extract<Receipt>(&mut arg2), 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::get_onhold_receipts_wallet_address(arg6));
                0x1::option::destroy_none<Receipt>(arg2);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg4, 0x2::tx_context::sender(arg9));
                return 0x1::option::none<Receipt>()
            };
        };
        assert!(arg3.paused == false, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::pool_paused());
        assert!(0x2::coin::value<T0>(&arg4) > 0, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::zero_deposit_error());
        update_pool<T0>(arg0, arg3, arg5, arg6, arg7, arg8, arg9);
        internal_deposit<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    fun add_rewards<T0, T1>(arg0: &mut Pool<T0>, arg1: 0x2::balance::Balance<T1>) {
        let v0 = 0x1::type_name::get<T1>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.rewards, v0) == true) {
            let v1 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u256>(&mut arg0.acc_rewards_per_xtoken, &v0);
            *v1 = *v1 + (0x2::balance::value<T1>(&arg1) as u256) * (1000000000000000000000000000000000000 as u256) / (arg0.xTokenSupply as u256);
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.rewards, v0), arg1);
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u256>(&mut arg0.acc_rewards_per_xtoken, v0, (0x2::balance::value<T1>(&arg1) as u256) * (1000000000000000000000000000000000000 as u256) / (arg0.xTokenSupply as u256));
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.rewards, v0, arg1);
        };
    }

    fun assert_receipt<T0>(arg0: &Receipt, arg1: &Pool<T0>) {
        assert!(arg0.pool_id == 0x2::object::uid_to_inner(&arg1.id), 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::invalid_receipt_error());
    }

    public fun create<T0>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::DevCap, arg1: &0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::version::Version, arg2: vector<u8>, arg3: vector<u8>, arg4: 0x2::object::ID, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::version::assert_current_version(arg1);
        let v0 = Pool<T0>{
            id                     : 0x2::object::new(arg6),
            name                   : arg2,
            image_url              : arg3,
            xTokenSupply           : 0,
            tokensInvested         : 0,
            rewards                : 0x2::bag::new(arg6),
            acc_rewards_per_xtoken : 0x2::vec_map::empty<0x1::type_name::TypeName, u256>(),
            deposit_fee            : 0,
            deposit_fee_max_cap    : 100,
            withdrawal_fee         : 0,
            withdraw_fee_max_cap   : 100,
            investor_id            : arg4,
            max_supply             : arg5,
            paused                 : false,
        };
        0x2::transfer::public_share_object<Pool<T0>>(v0);
    }

    fun destroy_receipt_and_transfer_rewards<T0>(arg0: &0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::version::Version, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: Receipt, arg3: 0x1::option::Option<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>, arg4: &mut Pool<T0>, arg5: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Pool<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>, arg6: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.xTokenBalance == 0, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::receipt_not_empty());
        let v0 = &mut arg2;
        let v1 = get_user_rewards_all<T0>(arg0, arg1, v0, arg3, arg4, arg5, arg6, arg7, arg8);
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

    fun exchange_rate<T0>(arg0: &Pool<T0>) : u256 {
        if (arg0.tokensInvested == 0 || arg0.xTokenSupply == 0) {
            (1000000000000000000000000000000000000 as u256)
        } else {
            (arg0.tokensInvested as u256) * (1000000000000000000000000000000000000 as u256) / (arg0.xTokenSupply as u256)
        }
    }

    fun get_pool_rewards_all<T0>(arg0: &mut Pool<T0>, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        get_rewards<T0, 0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>(arg0, arg1, arg2, arg3, arg4);
    }

    fun get_rewards<T0, T1>(arg0: &mut Pool<T0>, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T1>();
        if (arg0.xTokenSupply == 0) {
            if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.rewards, v0) == false) {
                0x2::vec_map::insert<0x1::type_name::TypeName, u256>(&mut arg0.acc_rewards_per_xtoken, v0, 0);
                0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.rewards, v0, 0x2::balance::zero<T1>());
            };
            return
        };
        let v1 = Witness{dummy_field: false};
        let v2 = 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::get_rewards_<T1, Witness>(arg2, arg1, 0x2::object::uid_to_inner(&arg0.id), arg3, v1, arg4);
        add_rewards<T0, T1>(arg0, v2);
    }

    fun get_user_rewards<T0, T1>(arg0: &mut Receipt, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: &mut Pool<T0>, arg3: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        get_rewards<T0, T1>(arg2, arg1, arg3, arg4, arg5);
        let v0 = 0x1::type_name::get<T1>();
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
            let v5 = 0x1::type_name::get<T1>();
            let v6 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.pending_rewards, &v5);
            let v7 = (((*v2 - v3) * (arg0.xTokenBalance as u256) / (1000000000000000000000000000000000000 as u256)) as u64) + *v6;
            *v6 = 0;
            let v8 = RewardEvent{
                coin_type : 0x1::type_name::get<T1>(),
                amount    : v7,
                sender    : 0x2::tx_context::sender(arg5),
            };
            0x2::event::emit<RewardEvent>(v8);
            0x2::balance::split<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg2.rewards, v0), (v7 as u64))
        } else {
            0x2::balance::zero<T1>()
        }
    }

    public fun get_user_rewards_all<T0>(arg0: &0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::version::Version, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: &mut Receipt, arg3: 0x1::option::Option<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>, arg4: &mut Pool<T0>, arg5: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Pool<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>, arg6: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt> {
        0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::version::assert_current_version(arg0);
        stake_all_alpha_to_alpha_pool<T0>(arg0, arg1, arg2, arg3, arg4, arg6, arg5, arg7, arg8)
    }

    fun init(arg0: ALPHAFI_ALPHALEND_SINGLE_LOOP_POOL, arg1: &mut 0x2::tx_context::TxContext) {
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
        let v4 = 0x2::package::claim<ALPHAFI_ALPHALEND_SINGLE_LOOP_POOL>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Receipt>(&v4, v0, v2, arg1);
        0x2::display::update_version<Receipt>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Receipt>>(v5, 0x2::tx_context::sender(arg1));
    }

    fun internal_deposit<T0>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg1: 0x1::option::Option<Receipt>, arg2: &mut Pool<T0>, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::alphafi_alphalend_single_loop_investor::Investor<T0>, arg5: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg6: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<Receipt> {
        get_pool_rewards_all<T0>(arg2, arg0, arg5, arg7, arg8);
        if (0x1::option::is_some<Receipt>(&arg1) == true) {
            assert_receipt<T0>(0x1::option::borrow_mut<Receipt>(&mut arg1), arg2);
        };
        let v0 = 0x2::coin::into_balance<T0>(arg3);
        let v1 = (0x2::balance::value<T0>(&v0) as u128) * (arg2.deposit_fee as u128) / 10000;
        0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::alphafi_alphalend_single_loop_investor::update_free_rewards<T0, T0>(arg4, 0x2::balance::split<T0>(&mut v0, (v1 as u64)));
        0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::alphafi_alphalend_single_loop_investor::deposit<T0>(arg4, arg6, 0x2::coin::from_balance<T0>(v0, arg8), arg7, arg8);
        arg2.tokensInvested = 0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::alphafi_alphalend_single_loop_investor::get_total_invested<T0>(arg4, arg6, arg7);
        assert!(0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::alphafi_alphalend_single_loop_investor::total_supplied_without_debt<T0>(arg4, arg6, arg7) <= arg2.max_supply, 0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::error::max_supply_limit());
        let v2 = ((arg2.tokensInvested - arg2.tokensInvested) as u256) * (1000000000000000000000000000000000000 as u256) / exchange_rate<T0>(arg2);
        assert!(v2 > 0, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::insufficient_deposit_amount());
        arg2.xTokenSupply = arg2.xTokenSupply + (v2 as u64);
        let v3 = if (0x1::option::is_some<Receipt>(&arg1) == true) {
            let v4 = 0x1::option::extract<Receipt>(&mut arg1);
            if (v4.name != 0x1::string::utf8(arg2.name)) {
                v4.name = 0x1::string::utf8(arg2.name);
            };
            let v5 = &mut v4;
            update_user_rewards_all<T0>(v5, arg2);
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
            Receipt{id: 0x2::object::new(arg8), owner: 0x2::tx_context::sender(arg8), name: 0x1::string::utf8(arg2.name), image_url: 0x1::string::utf8(arg2.image_url), pool_id: 0x2::object::uid_to_inner(&arg2.id), xTokenBalance: (v2 as u64), last_acc_reward_per_xtoken: v6, pending_rewards: v7}
        };
        let v11 = v3;
        0x1::option::destroy_none<Receipt>(arg1);
        let v12 = LiquidityChangeEvent{
            pool_id                    : 0x2::object::uid_to_inner(&arg2.id),
            event_type                 : 0,
            fee_collected              : (v1 as u64),
            amount                     : 0x2::balance::value<T0>(&v0),
            user_total_x_token_balance : v11.xTokenBalance,
            x_token_supply             : arg2.xTokenSupply,
            tokens_invested            : arg2.tokensInvested,
            sender                     : 0x2::tx_context::sender(arg8),
        };
        0x2::event::emit<LiquidityChangeEvent>(v12);
        0x1::option::some<Receipt>(v11)
    }

    fun internal_withdraw<T0>(arg0: &0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::version::Version, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: Receipt, arg3: 0x1::option::Option<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>, arg4: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Pool<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>, arg5: &mut Pool<T0>, arg6: u64, arg7: &mut 0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::alphafi_alphalend_single_loop_investor::Investor<T0>, arg8: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg9: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<Receipt>, 0x2::coin::Coin<T0>) {
        get_pool_rewards_all<T0>(arg5, arg1, arg8, arg10, arg11);
        let v0 = &mut arg2;
        update_user_rewards_all<T0>(v0, arg5);
        if (arg2.name != 0x1::string::utf8(arg5.name)) {
            arg2.name = 0x1::string::utf8(arg5.name);
        };
        let v1 = 0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::alphafi_alphalend_single_loop_investor::withdraw_from_alphalend<T0>(arg7, arg9, arg6, arg5.xTokenSupply, arg10, arg11);
        arg5.xTokenSupply = arg5.xTokenSupply - arg6;
        arg2.xTokenBalance = arg2.xTokenBalance - arg6;
        arg5.tokensInvested = 0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::alphafi_alphalend_single_loop_investor::get_total_invested<T0>(arg7, arg9, arg10);
        let v2 = (0x2::balance::value<T0>(&v1) as u128) * (arg5.withdrawal_fee as u128) / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v1, (v2 as u64)), arg11), 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::get_fee_wallet_address(arg8));
        let v3 = LiquidityChangeEvent{
            pool_id                    : 0x2::object::uid_to_inner(&arg5.id),
            event_type                 : 1,
            fee_collected              : (v2 as u64),
            amount                     : 0x2::balance::value<T0>(&v1),
            user_total_x_token_balance : arg2.xTokenBalance,
            x_token_supply             : arg5.xTokenSupply,
            tokens_invested            : arg5.tokensInvested,
            sender                     : 0x2::tx_context::sender(arg11),
        };
        0x2::event::emit<LiquidityChangeEvent>(v3);
        if (arg2.xTokenBalance == 0) {
            destroy_receipt_and_transfer_rewards<T0>(arg0, arg1, arg2, arg3, arg5, arg4, arg8, arg10, arg11);
            (0x1::option::none<Receipt>(), 0x2::coin::from_balance<T0>(v1, arg11))
        } else {
            if (0x1::option::is_some<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>(&arg3) == true) {
                0x2::transfer::public_transfer<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>(0x1::option::extract<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>(&mut arg3), 0x2::tx_context::sender(arg11));
            };
            0x1::option::destroy_none<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>(arg3);
            (0x1::option::some<Receipt>(arg2), 0x2::coin::from_balance<T0>(v1, arg11))
        }
    }

    entry fun set_deposit_fee<T0>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::AdminCap, arg1: &0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::version::Version, arg2: &mut Pool<T0>, arg3: u64) {
        0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::version::assert_current_version(arg1);
        assert!(arg3 <= arg2.deposit_fee_max_cap, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::fee_too_high_error());
        arg2.deposit_fee = arg3;
    }

    entry fun set_name<T0>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::AdminCap, arg1: &0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::version::Version, arg2: &mut Pool<T0>, arg3: vector<u8>) {
        0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::version::assert_current_version(arg1);
        arg2.name = arg3;
    }

    entry fun set_pause<T0>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::EmergencyCap, arg1: &0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::version::Version, arg2: &mut Pool<T0>, arg3: bool) {
        0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::version::assert_current_version(arg1);
        arg2.paused = arg3;
    }

    entry fun set_pool_max_supply_in_mists<T0>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::AdminCap, arg1: &0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::version::Version, arg2: &mut Pool<T0>, arg3: u64) {
        0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::version::assert_current_version(arg1);
        arg2.max_supply = arg3;
    }

    entry fun set_withdrawal_fee<T0>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::AdminCap, arg1: &0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::version::Version, arg2: &mut Pool<T0>, arg3: u64) {
        0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::version::assert_current_version(arg1);
        assert!(arg3 <= arg2.withdraw_fee_max_cap, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::fee_too_high_error());
        arg2.withdrawal_fee = arg3;
    }

    fun stake_all_alpha_to_alpha_pool<T0>(arg0: &0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::version::Version, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: &mut Receipt, arg3: 0x1::option::Option<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>, arg4: &mut Pool<T0>, arg5: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg6: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Pool<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt> {
        0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::version::assert_current_version(arg0);
        let v0 = get_user_rewards<T0, 0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>(arg2, arg1, arg4, arg5, arg7, arg8);
        if (0x2::balance::value<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>(&v0) > 0) {
            0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::deposit<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>(arg1, arg3, arg6, arg5, 0x2::coin::from_balance<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>(v0, arg8), arg7, arg8)
        } else {
            0x2::balance::destroy_zero<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>(v0);
            arg3
        }
    }

    public fun update_pool<T0>(arg0: &0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::version::Version, arg1: &mut Pool<T0>, arg2: &mut 0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::alphafi_alphalend_single_loop_investor::Investor<T0>, arg3: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::version::assert_current_version(arg0);
        assert!(arg1.investor_id == 0x2::object::id<0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::alphafi_alphalend_single_loop_investor::Investor<T0>>(arg2), 20001);
        assert!(!0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::alphafi_alphalend_single_loop_investor::has_unclaimed_rewards<T0>(arg2, arg4, arg5), 15151);
        0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::alphafi_alphalend_single_loop_investor::check_and_set_asset_ltv<T0>(arg2, arg4);
        0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::alphafi_alphalend_single_loop_investor::autocompound<T0>(arg2, arg3, arg4, arg5, arg6);
        0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::alphafi_alphalend_single_loop_investor::update_ratio<T0>(arg2, arg4, arg5);
        arg1.tokensInvested = 0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::alphafi_alphalend_single_loop_investor::get_total_invested<T0>(arg2, arg4, arg5);
    }

    fun update_user_rewards<T0, T1>(arg0: &mut Receipt, arg1: &mut Pool<T0>) {
        let v0 = 0x1::type_name::get<T1>();
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

    fun update_user_rewards_all<T0>(arg0: &mut Receipt, arg1: &mut Pool<T0>) {
        update_user_rewards<T0, 0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>(arg0, arg1);
    }

    public fun user_deposit<T0>(arg0: &0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::version::Version, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: 0x1::option::Option<Receipt>, arg3: &mut Pool<T0>, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::alphafi_alphalend_single_loop_investor::Investor<T0>, arg6: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg7: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::version::assert_current_version(arg0);
        let v0 = deposit<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        if (0x1::option::is_some<Receipt>(&v0) == true) {
            0x2::transfer::public_transfer<Receipt>(0x1::option::extract<Receipt>(&mut v0), 0x2::tx_context::sender(arg9));
        };
        0x1::option::destroy_none<Receipt>(v0);
    }

    public fun user_withdraw<T0>(arg0: &0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::version::Version, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: Receipt, arg3: 0x1::option::Option<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>, arg4: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Pool<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>, arg5: &mut Pool<T0>, arg6: u64, arg7: &mut 0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::alphafi_alphalend_single_loop_investor::Investor<T0>, arg8: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg9: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::version::assert_current_version(arg0);
        let (v0, v1) = withdraw<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        let v2 = v0;
        if (0x1::option::is_some<Receipt>(&v2) == true) {
            0x2::transfer::public_transfer<Receipt>(0x1::option::extract<Receipt>(&mut v2), 0x2::tx_context::sender(arg11));
        };
        0x1::option::destroy_none<Receipt>(v2);
        v1
    }

    fun withdraw<T0>(arg0: &0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::version::Version, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: Receipt, arg3: 0x1::option::Option<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>, arg4: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Pool<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>, arg5: &mut Pool<T0>, arg6: u64, arg7: &mut 0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::alphafi_alphalend_single_loop_investor::Investor<T0>, arg8: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg9: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<Receipt>, 0x2::coin::Coin<T0>) {
        0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::version::assert_current_version(arg0);
        if (arg2.owner != 0x2::tx_context::sender(arg11)) {
            0x2::transfer::public_transfer<Receipt>(arg2, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::get_onhold_receipts_wallet_address(arg8));
            0x2::transfer::public_transfer<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>(0x1::option::extract<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>(&mut arg3), 0x2::tx_context::sender(arg11));
            0x1::option::destroy_none<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>(arg3);
            return (0x1::option::none<Receipt>(), 0x2::coin::zero<T0>(arg11))
        };
        assert!(arg5.paused == false, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::pool_paused());
        assert_receipt<T0>(&arg2, arg5);
        assert!(arg6 > 0, 0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::error::zero_withdraw_error());
        assert!(arg6 <= arg2.xTokenBalance, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::insufficient_balance_error());
        update_pool<T0>(arg0, arg5, arg7, arg8, arg9, arg10, arg11);
        internal_withdraw<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
    }

    // decompiled from Move bytecode v6
}

