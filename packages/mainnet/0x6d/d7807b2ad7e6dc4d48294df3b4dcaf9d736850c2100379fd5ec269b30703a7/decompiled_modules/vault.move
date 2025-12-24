module 0x6dd7807b2ad7e6dc4d48294df3b4dcaf9d736850c2100379fd5ec269b30703a7::vault {
    struct Node_Data has drop, store {
        balance_right: u64,
        change_time: u64,
        previous_value: u128,
    }

    struct Get_sgc<phantom T0> has store, key {
        id: 0x2::object::UID,
        change_time: 0x2::table::Table<address, u64>,
        sgc_weight: u64,
    }

    struct SavingsData<phantom T0> has store, key {
        id: 0x2::object::UID,
        tree_height: u8,
        index: u8,
        time_per_round: u64,
        start_time: u64,
        start_time_day: u64,
        weighting_day: u64,
        weighting_weekly: u64,
        weighting_monthly: u64,
        round_weekly: u64,
        round_monthly: u64,
        lottery_draw_weekly: bool,
        lottery_draw_monthly: bool,
        number_of_draws: u64,
        total_balance: u64,
        internal_node: u64,
        leaf_node: u64,
        savings: 0x2::table::Table<address, u64>,
        adder_node: 0x2::table::Table<address, u64>,
        node_adder: 0x2::table::Table<u64, address>,
        internal_node_data: 0x2::table::Table<u64, Node_Data>,
        leaf_node_data: 0x2::table::Table<u64, Node_Data>,
        null_node: vector<u64>,
        prize_pool_weekly: 0x2::bag::Bag,
        prize_pool_monthly: 0x2::bag::Bag,
        account_cap: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
        version: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Burn_sgc_fee has store, key {
        id: 0x2::object::UID,
        fee: u8,
        start_draw_reward: u64,
        version: u64,
    }

    struct Outcome<phantom T0> has copy, drop {
        win: u64,
        game_type: u64,
        adder: address,
        random: u128,
    }

    fun add_coin_to_bag<T0>(arg0: &mut 0x2::bag::Bag, arg1: 0x2::coin::Coin<T0>) {
        let v0 = key_of<T0>();
        if (0x2::bag::contains<0x1::ascii::String>(arg0, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(arg0, v0), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T0>>(arg0, v0, 0x2::coin::into_balance<T0>(arg1));
        };
    }

    fun add_new_node<T0>(arg0: &mut SavingsData<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: address) {
        0x2::table::add<address, u64>(&mut arg0.adder_node, arg3, arg0.leaf_node);
        0x2::table::add<u64, address>(&mut arg0.node_adder, arg0.leaf_node, arg3);
        let v0 = arg1 / 1000000;
        let v1 = 0x2::clock::timestamp_ms(arg2) / 1000;
        let v2 = Node_Data{
            balance_right  : v0,
            change_time    : v1,
            previous_value : 0,
        };
        0x2::table::add<u64, Node_Data>(&mut arg0.leaf_node_data, arg0.leaf_node, v2);
        let v3 = 1 << arg0.tree_height;
        let v4 = 0x2::table::borrow<u64, Node_Data>(&arg0.leaf_node_data, infer_prev_from_tail_single(v3, arg0.leaf_node));
        let v5 = Node_Data{
            balance_right  : v0 + v4.balance_right,
            change_time    : v1,
            previous_value : calculate_node_weight(v4, v1, arg0.start_time),
        };
        0x2::table::add<u64, Node_Data>(&mut arg0.internal_node_data, arg0.internal_node, v5);
        let v6 = arg0.internal_node / 2;
        modify_parent_node<T0>(v1, v6, arg0, v0, true, 0);
        arg0.leaf_node = arg0.leaf_node + 1;
        arg0.internal_node = arg0.internal_node + 1;
        if (arg0.leaf_node > v3) {
            arg0.tree_height = arg0.tree_height + 1;
        };
    }

    entry fun burn_sgc<T0>(arg0: &mut 0x6dd7807b2ad7e6dc4d48294df3b4dcaf9d736850c2100379fd5ec269b30703a7::sgc::Minter, arg1: &mut Burn_sgc_fee, arg2: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 9);
        let v0 = withdraw_burning_sgc<T0>(arg1, arg3);
        assert!(0x2::coin::value<T0>(&v0) > 0, 5);
        0x6dd7807b2ad7e6dc4d48294df3b4dcaf9d736850c2100379fd5ec269b30703a7::sgc::burn(arg0, 0x6dd7807b2ad7e6dc4d48294df3b4dcaf9d736850c2100379fd5ec269b30703a7::mini_swap::swap<0x2::sui::SUI, 0x6dd7807b2ad7e6dc4d48294df3b4dcaf9d736850c2100379fd5ec269b30703a7::sgc::SGC>(arg2, 0x6dd7807b2ad7e6dc4d48294df3b4dcaf9d736850c2100379fd5ec269b30703a7::mini_swap::swap<T0, 0x2::sui::SUI>(arg2, v0, arg3), arg3));
    }

    entry fun burn_sgc_sui(arg0: &mut 0x6dd7807b2ad7e6dc4d48294df3b4dcaf9d736850c2100379fd5ec269b30703a7::sgc::Minter, arg1: &mut Burn_sgc_fee, arg2: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 9);
        let v0 = withdraw_burning_sgc<0x2::sui::SUI>(arg1, arg3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v0) > 0, 5);
        0x6dd7807b2ad7e6dc4d48294df3b4dcaf9d736850c2100379fd5ec269b30703a7::sgc::burn(arg0, 0x6dd7807b2ad7e6dc4d48294df3b4dcaf9d736850c2100379fd5ec269b30703a7::mini_swap::swap<0x2::sui::SUI, 0x6dd7807b2ad7e6dc4d48294df3b4dcaf9d736850c2100379fd5ec269b30703a7::sgc::SGC>(arg2, v0, arg3));
    }

    fun calculate_node_weight(arg0: &Node_Data, arg1: u64, arg2: u64) : u128 {
        if (arg2 >= arg0.change_time * 1000) {
            (((arg1 - arg2 / 1000) * arg0.balance_right) as u128)
        } else {
            (((arg1 - arg0.change_time) * arg0.balance_right) as u128) + arg0.previous_value
        }
    }

    public entry fun change_fee(arg0: &AdminCap, arg1: &mut Burn_sgc_fee, arg2: u8) {
        assert!(arg2 >= 10, 0);
        arg1.fee = arg2;
    }

    public entry fun change_round<T0>(arg0: &AdminCap, arg1: &mut SavingsData<T0>, arg2: u64, arg3: u64, arg4: u64) {
        arg1.time_per_round = arg2;
        arg1.round_weekly = arg3;
        arg1.round_monthly = arg4;
    }

    public entry fun change_start_draw_reward(arg0: &AdminCap, arg1: &mut Burn_sgc_fee, arg2: u64) {
        arg1.start_draw_reward = arg2;
    }

    public entry fun change_weighting<T0>(arg0: &AdminCap, arg1: &mut SavingsData<T0>, arg2: u64, arg3: u64, arg4: u64) {
        arg1.weighting_day = arg2;
        arg1.weighting_weekly = arg3;
        arg1.weighting_monthly = arg4;
    }

    fun claim_reward<T0, T1>(arg0: &SavingsData<T1>, arg1: vector<0x1::ascii::String>, arg2: vector<address>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::claim_reward_with_account_cap<T0>(arg6, arg3, arg4, arg5, arg1, arg2, &arg0.account_cap), arg7)
    }

    fun claim_reward_all<T0, T1, T2>(arg0: &mut Burn_sgc_fee, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T1>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut SavingsData<T2>, arg6: &0x2::clock::Clock, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = get_rewards_type<T2>(arg5, arg4, arg3, arg6);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x1::vector::length<vector<0x1::ascii::String>>(&v3);
        if (v4 > 0) {
            let v5 = claim_reward<T0, T2>(arg5, *0x1::vector::borrow<vector<0x1::ascii::String>>(&v3, 0), *0x1::vector::borrow<vector<address>>(&v2, 0), arg3, arg4, arg1, arg6, arg8);
            assert!(0x2::coin::value<T0>(&v5) > 0, 10);
            let v6 = 0x2::coin::value<T0>(&v5);
            let v7 = v6 / (arg0.fee as u64);
            let v8 = (v6 - v7) / 100;
            let v9 = 0x2::coin::split<T0>(&mut v5, v7, arg8);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, arg7);
            let v10 = &mut arg5.prize_pool_weekly;
            add_coin_to_bag<T0>(v10, 0x2::coin::split<T0>(&mut v5, v8 * arg5.weighting_weekly, arg8));
            let v11 = &mut arg5.prize_pool_monthly;
            add_coin_to_bag<T0>(v11, 0x2::coin::split<T0>(&mut v5, v8 * arg5.weighting_monthly, arg8));
            deposit_fee<T0>(arg0, v9, arg8);
            let v12 = Outcome<T0>{
                win       : v6,
                game_type : 0,
                adder     : arg7,
                random    : 0,
            };
            0x2::event::emit<Outcome<T0>>(v12);
            if (v4 > 1) {
                let v13 = claim_reward<T1, T2>(arg5, *0x1::vector::borrow<vector<0x1::ascii::String>>(&v3, 1), *0x1::vector::borrow<vector<address>>(&v2, 1), arg3, arg4, arg2, arg6, arg8);
                assert!(0x2::coin::value<T1>(&v13) > 0, 11);
                let v14 = 0x2::coin::value<T1>(&v13);
                let v15 = v14 / (arg0.fee as u64);
                let v16 = (v14 - v15) / 100;
                let v17 = 0x2::coin::split<T1>(&mut v13, v15, arg8);
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v13, arg7);
                let v18 = &mut arg5.prize_pool_weekly;
                add_coin_to_bag<T1>(v18, 0x2::coin::split<T1>(&mut v13, v16 * arg5.weighting_weekly, arg8));
                let v19 = &mut arg5.prize_pool_monthly;
                add_coin_to_bag<T1>(v19, 0x2::coin::split<T1>(&mut v13, v16 * arg5.weighting_monthly, arg8));
                deposit_fee<T1>(arg0, v17, arg8);
                let v20 = Outcome<T1>{
                    win       : v14,
                    game_type : 0,
                    adder     : arg7,
                    random    : 0,
                };
                0x2::event::emit<Outcome<T1>>(v20);
            };
        };
    }

    public entry fun deposit<T0>(arg0: &mut SavingsData<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &mut 0x6dd7807b2ad7e6dc4d48294df3b4dcaf9d736850c2100379fd5ec269b30703a7::sgc::Minter, arg7: &mut 0x6dd7807b2ad7e6dc4d48294df3b4dcaf9d736850c2100379fd5ec269b30703a7::sgc::Halving_cycle, arg8: &mut Get_sgc<T0>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 9);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 >= 1000000, 5);
        get_sgc_coin<T0>(arg6, arg7, arg0, arg8, false, arg9, arg10);
        arg0.total_balance = arg0.total_balance + v0;
        if (0x2::table::contains<address, u64>(&arg0.savings, 0x2::tx_context::sender(arg10))) {
            let v1 = *0x2::table::borrow<address, u64>(&arg0.adder_node, 0x2::tx_context::sender(arg10));
            modify_node_nodes<T0>(v1, arg0, v0, arg9, 0x2::tx_context::sender(arg10));
            let v2 = 0x2::table::borrow_mut<address, u64>(&mut arg0.savings, 0x2::tx_context::sender(arg10));
            *v2 = *v2 + v0;
        } else {
            if (0x1::vector::length<u64>(&arg0.null_node) > 0) {
                use_null_nodes<T0>(arg0, v0, arg9, 0x2::tx_context::sender(arg10));
            } else {
                add_new_node<T0>(arg0, v0, arg9, 0x2::tx_context::sender(arg10));
            };
            0x2::table::add<address, u64>(&mut arg0.savings, 0x2::tx_context::sender(arg10), v0);
        };
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T0>(arg9, arg2, arg3, arg0.index, arg1, arg4, arg5, &arg0.account_cap);
    }

    public entry fun deposit_fee<T0>(arg0: &mut Burn_sgc_fee, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = key_of<T0>();
        if (0x2::dynamic_field::exists_with_type<0x1::ascii::String, 0x2::balance::Balance<T0>>(&arg0.id, v0)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::dynamic_field::add<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, 0x2::coin::into_balance<T0>(arg1));
        };
    }

    public entry fun entry_get_sgc_coin<T0>(arg0: &mut 0x6dd7807b2ad7e6dc4d48294df3b4dcaf9d736850c2100379fd5ec269b30703a7::sgc::Minter, arg1: &mut 0x6dd7807b2ad7e6dc4d48294df3b4dcaf9d736850c2100379fd5ec269b30703a7::sgc::Halving_cycle, arg2: &SavingsData<T0>, arg3: &mut Get_sgc<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.version == 1, 9);
        let v0 = 0x2::clock::timestamp_ms(arg4) / 1000;
        0x6dd7807b2ad7e6dc4d48294df3b4dcaf9d736850c2100379fd5ec269b30703a7::sgc::mint(arg0, arg1, *0x2::table::borrow<address, u64>(&arg2.savings, 0x2::tx_context::sender(arg5)) * (v0 - *0x2::table::borrow<address, u64>(&arg3.change_time, 0x2::tx_context::sender(arg5))) / arg3.sgc_weight, arg5);
        *0x2::table::borrow_mut<address, u64>(&mut arg3.change_time, 0x2::tx_context::sender(arg5)) = v0;
    }

    public fun gas_consume(arg0: u64) {
        let v0 = 0;
        let v1 = 0;
        while (v0 < arg0) {
            v1 = v1 + arg0;
            v0 = v0 + 1;
        };
    }

    fun get_parent_node(arg0: u64, arg1: u64, arg2: u8) : u64 {
        let v0 = 1 << arg2;
        let v1 = v0;
        if (arg1 - 1 <= v0 / 2) {
            v1 = 1 << arg2 - 1;
        };
        loop {
            if (arg0 > v1 / 2) {
                break
            };
            let v2 = tail_from_prev_single(v1, arg0);
            if (v2 < arg1) {
                return v2 - 1
            };
            v1 = v1 / 2;
        };
        arg0 - 1
    }

    public fun get_rewards_type<T0>(arg0: &SavingsData<T0>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg3: &0x2::clock::Clock) : (vector<vector<0x1::ascii::String>>, vector<vector<address>>) {
        let (v0, v1, v2, v3, v4) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::parse_claimable_rewards(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::get_user_claimable_rewards(arg3, arg1, arg2, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.account_cap)));
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let v8 = v1;
        let v9 = v0;
        let v10 = 0x1::vector::empty<vector<0x1::ascii::String>>();
        let v11 = 0x1::vector::empty<vector<address>>();
        while (!0x1::vector::is_empty<u256>(&v7)) {
            0x1::vector::pop_back<0x1::ascii::String>(&mut v8);
            0x1::vector::pop_back<u256>(&mut v6);
            if (0x1::vector::pop_back<u256>(&mut v7) > 0) {
                let v12 = 0x1::vector::empty<0x1::ascii::String>();
                0x1::vector::push_back<0x1::ascii::String>(&mut v12, 0x1::vector::pop_back<0x1::ascii::String>(&mut v9));
                0x1::vector::push_back<vector<0x1::ascii::String>>(&mut v10, v12);
                0x1::vector::push_back<vector<address>>(&mut v11, 0x1::vector::pop_back<vector<address>>(&mut v5));
            };
        };
        (v10, v11)
    }

    fun get_sgc_coin<T0>(arg0: &mut 0x6dd7807b2ad7e6dc4d48294df3b4dcaf9d736850c2100379fd5ec269b30703a7::sgc::Minter, arg1: &mut 0x6dd7807b2ad7e6dc4d48294df3b4dcaf9d736850c2100379fd5ec269b30703a7::sgc::Halving_cycle, arg2: &SavingsData<T0>, arg3: &mut Get_sgc<T0>, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5) / 1000;
        if (arg4) {
            0x6dd7807b2ad7e6dc4d48294df3b4dcaf9d736850c2100379fd5ec269b30703a7::sgc::mint(arg0, arg1, *0x2::table::borrow<address, u64>(&arg2.savings, 0x2::tx_context::sender(arg6)) * (v0 - *0x2::table::borrow<address, u64>(&arg3.change_time, 0x2::tx_context::sender(arg6))) / arg3.sgc_weight, arg6);
            0x2::table::remove<address, u64>(&mut arg3.change_time, 0x2::tx_context::sender(arg6));
        } else if (0x2::table::contains<address, u64>(&arg2.savings, 0x2::tx_context::sender(arg6))) {
            if (*0x2::table::borrow<address, u64>(&arg2.savings, 0x2::tx_context::sender(arg6)) == 0) {
                0x2::table::add<address, u64>(&mut arg3.change_time, 0x2::tx_context::sender(arg6), v0);
            } else {
                0x6dd7807b2ad7e6dc4d48294df3b4dcaf9d736850c2100379fd5ec269b30703a7::sgc::mint(arg0, arg1, *0x2::table::borrow<address, u64>(&arg2.savings, 0x2::tx_context::sender(arg6)) * (v0 - *0x2::table::borrow<address, u64>(&arg3.change_time, 0x2::tx_context::sender(arg6))) / arg3.sgc_weight, arg6);
                *0x2::table::borrow_mut<address, u64>(&mut arg3.change_time, 0x2::tx_context::sender(arg6)) = v0;
            };
        } else {
            0x2::table::add<address, u64>(&mut arg3.change_time, 0x2::tx_context::sender(arg6), v0);
        };
    }

    public fun infer_prev_from_tail_single(arg0: u64, arg1: u64) : u64 {
        let v0 = arg0 / 2;
        assert!(arg1 >= v0 + 1 && arg1 <= arg0, 3);
        seq_value(v0, arg1 - v0)
    }

    public entry fun info<T0>(arg0: &SavingsData<T0>, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) : u64 {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<T0>(arg1, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg2, arg0.index, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.account_cap)) as u64))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Burn_sgc_fee{
            id                : 0x2::object::new(arg0),
            fee               : 20,
            start_draw_reward : 10000000000,
            version           : 1,
        };
        0x2::transfer::public_share_object<Burn_sgc_fee>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun initSavingsData<T0>(arg0: &AdminCap, arg1: u64, arg2: u8, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = SavingsData<T0>{
            id                   : 0x2::object::new(arg5),
            tree_height          : 1,
            index                : arg2,
            time_per_round       : arg1 * 60000,
            start_time           : 0x2::clock::timestamp_ms(arg4),
            start_time_day       : 0x2::clock::timestamp_ms(arg4),
            weighting_day        : 50,
            weighting_weekly     : 30,
            weighting_monthly    : 20,
            round_weekly         : 7,
            round_monthly        : 14,
            lottery_draw_weekly  : false,
            lottery_draw_monthly : false,
            number_of_draws      : 0,
            total_balance        : 0,
            internal_node        : 1,
            leaf_node            : 2,
            savings              : 0x2::table::new<address, u64>(arg5),
            adder_node           : 0x2::table::new<address, u64>(arg5),
            node_adder           : 0x2::table::new<u64, address>(arg5),
            internal_node_data   : 0x2::table::new<u64, Node_Data>(arg5),
            leaf_node_data       : 0x2::table::new<u64, Node_Data>(arg5),
            null_node            : 0x1::vector::empty<u64>(),
            prize_pool_weekly    : 0x2::bag::new(arg5),
            prize_pool_monthly   : 0x2::bag::new(arg5),
            account_cap          : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg5),
            version              : 1,
        };
        0x2::table::add<address, u64>(&mut v0.adder_node, @0x0, 1);
        0x2::table::add<u64, address>(&mut v0.node_adder, 1, @0x0);
        let v1 = Node_Data{
            balance_right  : 0,
            change_time    : 0,
            previous_value : 0,
        };
        0x2::table::add<u64, Node_Data>(&mut v0.leaf_node_data, 1, v1);
        0x2::transfer::public_share_object<SavingsData<T0>>(v0);
        let v2 = Get_sgc<T0>{
            id          : 0x2::object::new(arg5),
            change_time : 0x2::table::new<address, u64>(arg5),
            sgc_weight  : arg3,
        };
        0x2::transfer::public_share_object<Get_sgc<T0>>(v2);
    }

    fun key_of<T0>() : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())
    }

    entry fun lottery<T0, T1, T2>(arg0: &mut 0x6dd7807b2ad7e6dc4d48294df3b4dcaf9d736850c2100379fd5ec269b30703a7::sgc::Minter, arg1: &mut 0x6dd7807b2ad7e6dc4d48294df3b4dcaf9d736850c2100379fd5ec269b30703a7::sgc::Halving_cycle, arg2: &mut Burn_sgc_fee, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T1>, arg5: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg10: &mut SavingsData<T2>, arg11: &0x2::random::Random, arg12: &0x2::clock::Clock, arg13: &mut 0x3::sui_system::SuiSystemState, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg12) > arg10.start_time_day + arg10.time_per_round, 6);
        assert!(arg10.version == 1, 9);
        arg10.number_of_draws = arg10.number_of_draws + 1;
        let v0 = 0x2::random::new_generator(arg11, arg14);
        gas_consume(0x2::random::generate_u64_in_range(&mut v0, 1, 20));
        let v1 = 0x2::random::generate_u128_in_range(&mut v0, 1, calculate_node_weight(0x2::table::borrow<u64, Node_Data>(&arg10.internal_node_data, 1), 0x2::clock::timestamp_ms(arg12) / 1000, arg10.start_time));
        let v2 = *0x2::table::borrow<u64, address>(&arg10.node_adder, lottery_num<T2>(v1, arg10, arg12));
        let v3 = info<T2>(arg10, arg9, arg8);
        let v4 = v3 - arg10.total_balance;
        if (v4 > 0) {
            let v5 = withdr_<T2>(v4, arg10, arg8, arg9, arg7, arg6, arg12, arg5, arg13, arg14);
            let v6 = 0x2::coin::value<T2>(&v5);
            let v7 = v6 / (arg2.fee as u64);
            let v8 = (v6 - v7) / 100;
            let v9 = 0x2::coin::split<T2>(&mut v5, v7, arg14);
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v5, v2);
            let v10 = &mut arg10.prize_pool_weekly;
            add_coin_to_bag<T2>(v10, 0x2::coin::split<T2>(&mut v5, v8 * arg10.weighting_weekly, arg14));
            let v11 = &mut arg10.prize_pool_monthly;
            add_coin_to_bag<T2>(v11, 0x2::coin::split<T2>(&mut v5, v8 * arg10.weighting_monthly, arg14));
            deposit_fee<T2>(arg2, v9, arg14);
        };
        claim_reward_all<T0, T1, T2>(arg2, arg3, arg4, arg6, arg8, arg10, arg12, v2, arg14);
        if (arg10.number_of_draws % arg10.round_weekly == 0) {
            if (!arg10.lottery_draw_weekly) {
                arg10.lottery_draw_weekly = true;
            };
        };
        if (arg10.number_of_draws % arg10.round_monthly == 0) {
            if (!arg10.lottery_draw_monthly) {
                arg10.lottery_draw_monthly = true;
            };
        };
        arg10.start_time_day = 0x2::clock::timestamp_ms(arg12);
        0x6dd7807b2ad7e6dc4d48294df3b4dcaf9d736850c2100379fd5ec269b30703a7::sgc::mint(arg0, arg1, arg2.start_draw_reward, arg14);
        let v12 = Outcome<T2>{
            win       : v4,
            game_type : 1,
            adder     : v2,
            random    : v1,
        };
        0x2::event::emit<Outcome<T2>>(v12);
    }

    entry fun lottery_monthly<T0, T1, T2>(arg0: &mut 0x6dd7807b2ad7e6dc4d48294df3b4dcaf9d736850c2100379fd5ec269b30703a7::sgc::Minter, arg1: &mut 0x6dd7807b2ad7e6dc4d48294df3b4dcaf9d736850c2100379fd5ec269b30703a7::sgc::Halving_cycle, arg2: &Burn_sgc_fee, arg3: &mut SavingsData<T2>, arg4: &0x2::random::Random, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.version == 1, 9);
        assert!(arg3.lottery_draw_monthly, 6);
        let v0 = 0x2::random::new_generator(arg4, arg6);
        gas_consume(0x2::random::generate_u64_in_range(&mut v0, 1, 20));
        let v1 = 0x2::random::generate_u128_in_range(&mut v0, 1, calculate_node_weight(0x2::table::borrow<u64, Node_Data>(&arg3.internal_node_data, 1), 0x2::clock::timestamp_ms(arg5) / 1000, arg3.start_time));
        let v2 = *0x2::table::borrow<u64, address>(&arg3.node_adder, lottery_num<T2>(v1, arg3, arg5));
        let v3 = 0x2::bag::length(&arg3.prize_pool_monthly);
        let v4 = &mut arg3.prize_pool_monthly;
        let v5 = take_all_from_bag<T2>(v4, arg6);
        if (0x2::coin::value<T2>(&v5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v5, v2);
        } else {
            0x2::coin::destroy_zero<T2>(v5);
        };
        if (v3 > 1) {
            let v6 = &mut arg3.prize_pool_monthly;
            let v7 = take_all_from_bag<T0>(v6, arg6);
            if (0x2::coin::value<T0>(&v7) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v7, v2);
            } else {
                0x2::coin::destroy_zero<T0>(v7);
            };
            if (v3 > 2) {
                let v8 = &mut arg3.prize_pool_monthly;
                let v9 = take_all_from_bag<T1>(v8, arg6);
                if (0x2::coin::value<T1>(&v9) > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v9, v2);
                } else {
                    0x2::coin::destroy_zero<T1>(v9);
                };
            };
        };
        assert!(0x2::bag::length(&arg3.prize_pool_monthly) == 0, 13);
        arg3.lottery_draw_monthly = false;
        arg3.start_time = 0x2::clock::timestamp_ms(arg5);
        0x6dd7807b2ad7e6dc4d48294df3b4dcaf9d736850c2100379fd5ec269b30703a7::sgc::mint(arg0, arg1, arg2.start_draw_reward, arg6);
        let v10 = Outcome<T2>{
            win       : 0,
            game_type : 30,
            adder     : v2,
            random    : v1,
        };
        0x2::event::emit<Outcome<T2>>(v10);
    }

    public fun lottery_num<T0>(arg0: u128, arg1: &SavingsData<T0>, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 2;
        let v1 = arg0;
        let v2 = 0x2::clock::timestamp_ms(arg2) / 1000;
        let v3 = 1;
        while (v0 < arg1.internal_node) {
            v3 = v0;
            let v4 = calculate_node_weight(0x2::table::borrow<u64, Node_Data>(&arg1.internal_node_data, v0), v2, arg1.start_time);
            if (v1 > v4) {
                v1 = v1 - v4;
                let v5 = (v0 + 1) * 2;
                v0 = v5;
                if (v5 >= arg1.internal_node) {
                    let v6 = v5 / 2;
                    v3 = v6;
                    if (v6 >= arg1.internal_node) {
                        return (v6 - 1) / 2 + 1
                    } else {
                        continue
                    };
                } else {
                    continue
                };
            };
            v0 = v0 * 2;
        };
        let v7 = v3 + 1;
        let v8 = 1 << arg1.tree_height;
        let v9 = v8;
        if (v7 <= v8 / 2) {
            v9 = 1 << arg1.tree_height - 1;
        };
        let v10 = infer_prev_from_tail_single(v9, v7);
        if (v1 > calculate_node_weight(0x2::table::borrow<u64, Node_Data>(&arg1.leaf_node_data, v10), v2, arg1.start_time)) {
            v7
        } else {
            v10
        }
    }

    entry fun lottery_weekly<T0, T1, T2>(arg0: &mut 0x6dd7807b2ad7e6dc4d48294df3b4dcaf9d736850c2100379fd5ec269b30703a7::sgc::Minter, arg1: &mut 0x6dd7807b2ad7e6dc4d48294df3b4dcaf9d736850c2100379fd5ec269b30703a7::sgc::Halving_cycle, arg2: &Burn_sgc_fee, arg3: &mut SavingsData<T2>, arg4: &0x2::random::Random, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.version == 1, 9);
        assert!(arg3.lottery_draw_weekly, 6);
        let v0 = 0x2::random::new_generator(arg4, arg6);
        gas_consume(0x2::random::generate_u64_in_range(&mut v0, 1, 20));
        let v1 = 0x2::random::generate_u128_in_range(&mut v0, 1, calculate_node_weight(0x2::table::borrow<u64, Node_Data>(&arg3.internal_node_data, 1), 0x2::clock::timestamp_ms(arg5) / 1000, arg3.start_time));
        let v2 = *0x2::table::borrow<u64, address>(&arg3.node_adder, lottery_num<T2>(v1, arg3, arg5));
        let v3 = 0x2::bag::length(&arg3.prize_pool_weekly);
        let v4 = &mut arg3.prize_pool_weekly;
        let v5 = take_all_from_bag<T2>(v4, arg6);
        if (0x2::coin::value<T2>(&v5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v5, v2);
        } else {
            0x2::coin::destroy_zero<T2>(v5);
        };
        if (v3 > 1) {
            let v6 = &mut arg3.prize_pool_weekly;
            let v7 = take_all_from_bag<T0>(v6, arg6);
            if (0x2::coin::value<T0>(&v7) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v7, v2);
            } else {
                0x2::coin::destroy_zero<T0>(v7);
            };
            if (v3 > 2) {
                let v8 = &mut arg3.prize_pool_weekly;
                let v9 = take_all_from_bag<T1>(v8, arg6);
                if (0x2::coin::value<T1>(&v9) > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v9, v2);
                } else {
                    0x2::coin::destroy_zero<T1>(v9);
                };
            };
        };
        assert!(0x2::bag::length(&arg3.prize_pool_weekly) == 0, 12);
        arg3.lottery_draw_weekly = false;
        0x6dd7807b2ad7e6dc4d48294df3b4dcaf9d736850c2100379fd5ec269b30703a7::sgc::mint(arg0, arg1, arg2.start_draw_reward, arg6);
        let v10 = Outcome<T2>{
            win       : 0,
            game_type : 7,
            adder     : v2,
            random    : v1,
        };
        0x2::event::emit<Outcome<T2>>(v10);
    }

    fun modify_node_nodes<T0>(arg0: u64, arg1: &mut SavingsData<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: address) {
        let v0 = arg2 / 1000000;
        let v1 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v2 = 0x2::table::borrow_mut<u64, Node_Data>(&mut arg1.leaf_node_data, arg0);
        v2.previous_value = calculate_node_weight(v2, v1, arg1.start_time);
        v2.change_time = v1;
        v2.balance_right = v2.balance_right + v0;
        let v3 = get_parent_node(arg0, arg1.leaf_node, arg1.tree_height);
        modify_parent_node<T0>(v1, v3, arg1, v0, true, 0);
    }

    fun modify_parent_node<T0>(arg0: u64, arg1: u64, arg2: &mut SavingsData<T0>, arg3: u64, arg4: bool, arg5: u128) {
        while (arg1 > 0) {
            let v0 = 0x2::table::borrow_mut<u64, Node_Data>(&mut arg2.internal_node_data, arg1);
            v0.previous_value = calculate_node_weight(v0, arg0, arg2.start_time);
            v0.change_time = arg0;
            if (arg4) {
                v0.balance_right = v0.balance_right + arg3;
            } else {
                v0.balance_right = v0.balance_right - arg3;
                v0.previous_value = v0.previous_value - arg5;
            };
            arg1 = arg1 / 2;
        };
    }

    public fun seq_pos(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 >= 1 && arg1 <= arg0, 2);
        if (arg0 == 1) {
            1
        } else {
            let v1 = arg0 / 2;
            if (arg1 > v1) {
                2 * (arg1 - v1)
            } else {
                2 * seq_pos(v1, arg1) - 1
            }
        }
    }

    public fun seq_value(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 >= 1 && arg1 <= arg0, 1);
        if (arg0 == 1) {
            1
        } else if (arg1 % 2 == 1) {
            seq_value(arg0 / 2, (arg1 + 1) / 2)
        } else {
            arg0 / 2 + arg1 / 2
        }
    }

    public fun tail_from_prev_single(arg0: u64, arg1: u64) : u64 {
        let v0 = arg0 / 2;
        assert!(arg1 >= 1 && arg1 <= v0, 4);
        v0 + seq_pos(v0, arg1)
    }

    fun take_all_from_bag<T0>(arg0: &mut 0x2::bag::Bag, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>());
        if (0x2::bag::contains<0x1::ascii::String>(arg0, v0)) {
            0x2::coin::from_balance<T0>(0x2::bag::remove<0x1::ascii::String, 0x2::balance::Balance<T0>>(arg0, v0), arg1)
        } else {
            0x2::coin::zero<T0>(arg1)
        }
    }

    entry fun upgrading_packages_migrate<T0>(arg0: &AdminCap, arg1: &mut SavingsData<T0>, arg2: &mut Burn_sgc_fee) {
        arg1.version = 1;
        arg2.version = 1;
    }

    fun use_null_nodes<T0>(arg0: &mut SavingsData<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: address) {
        let v0 = 0x1::vector::pop_back<u64>(&mut arg0.null_node);
        *0x2::table::borrow_mut<u64, address>(&mut arg0.node_adder, v0) = arg3;
        if (0x2::table::contains<address, u64>(&arg0.adder_node, arg3)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.adder_node, arg3) = v0;
        } else {
            0x2::table::add<address, u64>(&mut arg0.adder_node, arg3, v0);
        };
        let v1 = arg1 / 1000000;
        let v2 = 0x2::clock::timestamp_ms(arg2) / 1000;
        let v3 = 0x2::table::borrow_mut<u64, Node_Data>(&mut arg0.leaf_node_data, v0);
        v3.balance_right = v1;
        v3.change_time = v2;
        v3.previous_value = 0;
        let v4 = get_parent_node(v0, arg0.leaf_node, arg0.tree_height);
        modify_parent_node<T0>(v2, v4, arg0, v1, true, 0);
    }

    fun withdr_<T0>(arg0: u64, arg1: &SavingsData<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0x2::clock::Clock, arg7: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap_v2<T0>(arg6, arg7, arg2, arg3, arg1.index, arg0, arg4, arg5, &arg1.account_cap, arg8, arg9), arg9)
    }

    public entry fun withdraw<T0>(arg0: &mut SavingsData<T0>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg5: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &mut 0x6dd7807b2ad7e6dc4d48294df3b4dcaf9d736850c2100379fd5ec269b30703a7::sgc::Minter, arg7: &mut 0x6dd7807b2ad7e6dc4d48294df3b4dcaf9d736850c2100379fd5ec269b30703a7::sgc::Halving_cycle, arg8: &mut Get_sgc<T0>, arg9: &0x2::clock::Clock, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 9);
        let v0 = 0x2::table::borrow<address, u64>(&arg0.savings, 0x2::tx_context::sender(arg11));
        assert!(*v0 > 0, 5);
        get_sgc_coin<T0>(arg6, arg7, arg0, arg8, true, arg9, arg11);
        let v1 = *v0 / 1000000;
        arg0.total_balance = arg0.total_balance - *v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap_v2<T0>(arg9, arg5, arg1, arg2, arg0.index, *v0, arg3, arg4, &arg0.account_cap, arg10, arg11), arg11), 0x2::tx_context::sender(arg11));
        let v2 = 0x2::table::borrow<address, u64>(&arg0.adder_node, 0x2::tx_context::sender(arg11));
        0x1::vector::push_back<u64>(&mut arg0.null_node, *v2);
        let v3 = 0x2::clock::timestamp_ms(arg9) / 1000;
        let v4 = 0x2::table::borrow_mut<u64, Node_Data>(&mut arg0.leaf_node_data, *v2);
        let v5 = calculate_node_weight(v4, v3, arg0.start_time);
        v4.balance_right = 0;
        v4.change_time = 0;
        v4.previous_value = 0;
        let v6 = get_parent_node(*v2, arg0.leaf_node, arg0.tree_height);
        modify_parent_node<T0>(v3, v6, arg0, v1, false, v5);
        0x2::table::remove<address, u64>(&mut arg0.savings, 0x2::tx_context::sender(arg11));
    }

    fun withdraw_burning_sgc<T0>(arg0: &mut Burn_sgc_fee, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = key_of<T0>();
        assert!(0x2::dynamic_field::exists_with_type<0x1::ascii::String, 0x2::balance::Balance<T0>>(&arg0.id, v0), 7);
        let v1 = 0x2::coin::from_balance<T0>(0x2::dynamic_field::remove<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg1);
        assert!(0x2::coin::value<T0>(&v1) > 0, 8);
        v1
    }

    // decompiled from Move bytecode v6
}

