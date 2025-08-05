module 0x3cf6f57940fff141d5ed263428cb1db4201152187ef0f0ffd873d5f6ed5a0afc::vault {
    struct Reward_coin_type<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        adderlis_t: vector<address>,
        adderlis_d: vector<address>,
        strlis_t: vector<0x1::ascii::String>,
        strlis_d: vector<0x1::ascii::String>,
        index: u8,
    }

    struct Node_Data has drop, store {
        balance_right: u64,
        change_time: u64,
        previous_value: u128,
    }

    struct SavingsData<phantom T0> has store, key {
        id: 0x2::object::UID,
        tree_height: u8,
        index: u8,
        time_per_round: u64,
        start_time: u64,
        total_balance: u64,
        internal_node: u64,
        leaf_node: u64,
        savings: 0x2::table::Table<address, u64>,
        adder_node: 0x2::table::Table<address, u64>,
        node_adder: 0x2::table::Table<u64, address>,
        internal_node_data: 0x2::table::Table<u64, Node_Data>,
        leaf_node_data: 0x2::table::Table<u64, Node_Data>,
        null_node: vector<u64>,
        account_cap: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminAddr_fee has store, key {
        id: 0x2::object::UID,
        fee: u8,
        adder: address,
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
        modify_parent_node<T0>(v1, v6, arg0, v0, true);
        arg0.leaf_node = arg0.leaf_node + 1;
        arg0.internal_node = arg0.internal_node + 1;
        if (arg0.leaf_node > v3) {
            arg0.tree_height = arg0.tree_height + 1;
        };
    }

    fun calculate_node_weight(arg0: &Node_Data, arg1: u64, arg2: u64) : u128 {
        if (arg2 > arg0.change_time * 1000) {
            (((arg1 - arg2 / 1000) * arg0.balance_right) as u128)
        } else {
            (((arg1 - arg0.change_time) * arg0.balance_right) as u128) + arg0.previous_value
        }
    }

    public entry fun change_fee(arg0: &AdminCap, arg1: &mut AdminAddr_fee, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 >= 20, 0);
        arg1.fee = arg2;
    }

    public entry fun change_reward_type<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &SavingsData<T4>, arg2: &AdminAddr_fee, arg3: Reward_coin_type<T0, T1>, arg4: vector<address>, arg5: vector<address>, arg6: vector<0x1::ascii::String>, arg7: vector<0x1::ascii::String>, arg8: u8, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.index == arg1.index, 8);
        let v0 = 0x2::clock::timestamp_ms(arg0) / 1000;
        assert!(calculate_node_weight(0x2::table::borrow<u64, Node_Data>(&arg1.leaf_node_data, *0x2::table::borrow<address, u64>(&arg1.adder_node, 0x2::tx_context::sender(arg9))), v0, arg1.start_time) >= calculate_node_weight(0x2::table::borrow<u64, Node_Data>(&arg1.internal_node_data, 1), v0, arg1.start_time) / 100 * 30 || 0x2::tx_context::sender(arg9) == arg2.adder, 7);
        let v1 = Reward_coin_type<T2, T3>{
            id         : 0x2::object::new(arg9),
            adderlis_t : arg4,
            adderlis_d : arg5,
            strlis_t   : arg6,
            strlis_d   : arg7,
            index      : arg8,
        };
        let Reward_coin_type {
            id         : v2,
            adderlis_t : _,
            adderlis_d : _,
            strlis_t   : _,
            strlis_d   : _,
            index      : _,
        } = arg3;
        0x2::object::delete(v2);
        0x2::transfer::public_share_object<Reward_coin_type<T2, T3>>(v1);
    }

    fun check_whether_the_null_node_is_available<T0>(arg0: &mut SavingsData<T0>) : bool {
        0x1::vector::length<u64>(&arg0.null_node) > 0 && (0x2::table::borrow<u64, Node_Data>(&arg0.leaf_node_data, *0x1::vector::borrow<u64>(&arg0.null_node, 0)).change_time * 1000 > arg0.start_time && false || true)
    }

    fun claim_reward<T0, T1>(arg0: &mut SavingsData<T1>, arg1: vector<0x1::ascii::String>, arg2: vector<address>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::claim_reward_with_account_cap<T0>(arg6, arg3, arg4, arg5, arg1, arg2, &arg0.account_cap), arg7)
    }

    fun claim_reward_all<T0, T1, T2>(arg0: &Reward_coin_type<T0, T1>, arg1: &AdminAddr_fee, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T0>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T1>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: &mut SavingsData<T2>, arg7: &0x2::clock::Clock, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        if (0x1::vector::length<address>(&arg0.adderlis_t) > 0) {
            let v0 = claim_reward<T0, T2>(arg6, arg0.strlis_t, arg0.adderlis_t, arg4, arg5, arg2, arg7, arg9);
            if (0x2::coin::value<T0>(&v0) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg8);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v0, 0x2::coin::value<T0>(&v0) / (arg1.fee as u64), arg9), arg1.adder);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg8);
            };
        };
        if (0x1::vector::length<address>(&arg0.adderlis_d) > 0) {
            let v1 = claim_reward<T1, T2>(arg6, arg0.strlis_d, arg0.adderlis_d, arg4, arg5, arg3, arg7, arg9);
            if (0x2::coin::value<T1>(&v1) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, arg8);
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut v1, 0x2::coin::value<T1>(&v1) / (arg1.fee as u64), arg9), arg1.adder);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, arg8);
            };
        };
    }

    public fun claim_rewardaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa<T0, T1>(arg0: &AdminCap, arg1: &mut SavingsData<T1>, arg2: vector<0x1::ascii::String>, arg3: vector<address>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::claim_reward_with_account_cap<T0>(arg7, arg4, arg5, arg6, arg2, arg3, &arg1.account_cap), arg8)
    }

    public entry fun deposit<T0>(arg0: &mut SavingsData<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 >= 1000000, 5);
        arg0.total_balance = arg0.total_balance + v0;
        if (0x2::table::contains<address, u64>(&arg0.savings, 0x2::tx_context::sender(arg7))) {
            if (*0x2::table::borrow<address, u64>(&arg0.savings, 0x2::tx_context::sender(arg7)) == 0) {
                if (0x2::table::contains<address, u64>(&arg0.adder_node, 0x2::tx_context::sender(arg7))) {
                    let v1 = 0x2::table::borrow<address, u64>(&arg0.adder_node, 0x2::tx_context::sender(arg7));
                    let v2 = &mut arg0.null_node;
                    remove_by_value(v2, *v1);
                    modify_node_nodes<T0>(*v1, arg0, v0, arg6, 0x2::tx_context::sender(arg7));
                } else if (check_whether_the_null_node_is_available<T0>(arg0)) {
                    use_null_nodes<T0>(arg0, v0, arg6, 0x2::tx_context::sender(arg7));
                } else {
                    add_new_node<T0>(arg0, v0, arg6, 0x2::tx_context::sender(arg7));
                };
            } else {
                let v3 = *0x2::table::borrow<address, u64>(&arg0.adder_node, 0x2::tx_context::sender(arg7));
                modify_node_nodes<T0>(v3, arg0, v0, arg6, 0x2::tx_context::sender(arg7));
            };
            let v4 = 0x2::table::borrow_mut<address, u64>(&mut arg0.savings, 0x2::tx_context::sender(arg7));
            *v4 = *v4 + v0;
        } else if (check_whether_the_null_node_is_available<T0>(arg0)) {
            use_null_nodes<T0>(arg0, v0, arg6, 0x2::tx_context::sender(arg7));
        } else {
            0x2::table::add<address, u64>(&mut arg0.savings, 0x2::tx_context::sender(arg7), v0);
            add_new_node<T0>(arg0, v0, arg6, 0x2::tx_context::sender(arg7));
        };
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T0>(arg6, arg2, arg3, arg0.index, arg1, arg4, arg5, &arg0.account_cap);
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

    public fun get_version() : u64 {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::version::this_version()
    }

    public fun infer_prev_from_tail_single(arg0: u64, arg1: u64) : u64 {
        let v0 = arg0 / 2;
        assert!(arg1 >= v0 + 1 && arg1 <= arg0, 3);
        seq_value(v0, arg1 - v0)
    }

    public fun info<T0>(arg0: &SavingsData<T0>, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) : u64 {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<T0>(arg1, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg2, arg0.index, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.account_cap)) as u64))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminAddr_fee{
            id    : 0x2::object::new(arg0),
            fee   : 50,
            adder : @0x82242fabebc3e6e331c3d5c6de3d34ff965671b75154ec1cb9e00aa437bbfa44,
        };
        0x2::transfer::public_share_object<AdminAddr_fee>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, @0x82242fabebc3e6e331c3d5c6de3d34ff965671b75154ec1cb9e00aa437bbfa44);
    }

    public entry fun initReward_coin_type<T0, T1>(arg0: &AdminCap, arg1: vector<address>, arg2: vector<address>, arg3: vector<0x1::ascii::String>, arg4: vector<0x1::ascii::String>, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = Reward_coin_type<T0, T1>{
            id         : 0x2::object::new(arg6),
            adderlis_t : arg1,
            adderlis_d : arg2,
            strlis_t   : arg3,
            strlis_d   : arg4,
            index      : arg5,
        };
        0x2::transfer::public_share_object<Reward_coin_type<T0, T1>>(v0);
    }

    public entry fun initSavingsData<T0>(arg0: &AdminCap, arg1: u64, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = SavingsData<T0>{
            id                 : 0x2::object::new(arg4),
            tree_height        : 1,
            index              : arg2,
            time_per_round     : arg1 * 3600000,
            start_time         : 0x2::clock::timestamp_ms(arg3),
            total_balance      : 0,
            internal_node      : 1,
            leaf_node          : 2,
            savings            : 0x2::table::new<address, u64>(arg4),
            adder_node         : 0x2::table::new<address, u64>(arg4),
            node_adder         : 0x2::table::new<u64, address>(arg4),
            internal_node_data : 0x2::table::new<u64, Node_Data>(arg4),
            leaf_node_data     : 0x2::table::new<u64, Node_Data>(arg4),
            null_node          : 0x1::vector::empty<u64>(),
            account_cap        : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg4),
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
    }

    entry fun lottery<T0, T1, T2>(arg0: &Reward_coin_type<T0, T1>, arg1: &AdminAddr_fee, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T0>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T1>, arg4: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg9: &mut SavingsData<T2>, arg10: &0x2::random::Random, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg11) > arg9.start_time + arg9.time_per_round, 6);
        assert!(arg0.index == arg9.index, 8);
        let v0 = 0x2::random::new_generator(arg10, arg12);
        let v1 = *0x2::table::borrow<u64, address>(&arg9.node_adder, lottery_num<T2>(0x2::random::generate_u128_in_range(&mut v0, 1, calculate_node_weight(0x2::table::borrow<u64, Node_Data>(&arg9.internal_node_data, 1), 0x2::clock::timestamp_ms(arg11) / 1000, arg9.start_time)), arg9, arg11));
        let v2 = info<T2>(arg9, arg8, arg7);
        let v3 = v2 - arg9.total_balance;
        let v4 = withdr_<T2>(v3, arg9, arg7, arg8, arg6, arg5, arg11, arg4, arg12);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v4, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::split<T2>(&mut v4, 0x2::coin::value<T2>(&v4) / (arg1.fee as u64), arg12), arg1.adder);
        claim_reward_all<T0, T1, T2>(arg0, arg1, arg2, arg3, arg5, arg7, arg9, arg11, v1, arg12);
        arg9.start_time = 0x2::clock::timestamp_ms(arg11);
    }

    fun lottery_num<T0>(arg0: u128, arg1: &SavingsData<T0>, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 2;
        let v1 = arg0;
        let v2 = 0x2::clock::timestamp_ms(arg2) / 1000;
        while (v0 < arg1.internal_node) {
            let v3 = calculate_node_weight(0x2::table::borrow<u64, Node_Data>(&arg1.internal_node_data, v0), v2, arg1.start_time);
            if (v1 > v3) {
                v1 = v1 - v3;
                let v4 = v0 + 1;
                v0 = v4 * 2;
                continue
            };
            v0 = v0 * 2;
        };
        let v5 = 1 + 1;
        let v6 = 1 << arg1.tree_height;
        let v7 = v6;
        if (arg1.leaf_node - 1 <= v6 / 2) {
            v7 = 1 << arg1.tree_height - 1;
        };
        let v8 = infer_prev_from_tail_single(v7, v5);
        if (v1 > calculate_node_weight(0x2::table::borrow<u64, Node_Data>(&arg1.leaf_node_data, v8), v2, arg1.start_time)) {
            v5
        } else {
            v8
        }
    }

    fun modify_node_nodes<T0>(arg0: u64, arg1: &mut SavingsData<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: address) {
        let v0 = arg2 / 1000000;
        let v1 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v2 = 0x2::table::borrow_mut<u64, Node_Data>(&mut arg1.leaf_node_data, arg0);
        v2.previous_value = calculate_node_weight(v2, v1, arg1.start_time);
        v2.change_time = v1;
        v2.balance_right = v2.balance_right + v0;
        let v3 = get_parent_node(arg0, arg1.leaf_node, arg1.tree_height);
        modify_parent_node<T0>(v1, v3, arg1, v0, true);
    }

    fun modify_parent_node<T0>(arg0: u64, arg1: u64, arg2: &mut SavingsData<T0>, arg3: u64, arg4: bool) {
        while (arg1 > 0) {
            let v0 = 0x2::table::borrow_mut<u64, Node_Data>(&mut arg2.internal_node_data, arg1);
            v0.previous_value = calculate_node_weight(v0, arg0, arg2.start_time);
            v0.change_time = arg0;
            if (arg4) {
                v0.balance_right = v0.balance_right + arg3;
            } else {
                v0.balance_right = v0.balance_right - arg3;
            };
            arg1 = arg1 / 2;
        };
    }

    fun remove_by_value(arg0: &mut vector<u64>, arg1: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg0)) {
            if (*0x1::vector::borrow<u64>(arg0, v0) == arg1) {
                0x1::vector::remove<u64>(arg0, v0);
            };
            v0 = v0 + 1;
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

    fun use_null_nodes<T0>(arg0: &mut SavingsData<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: address) {
        let v0 = *0x1::vector::borrow<u64>(&arg0.null_node, 0);
        let v1 = 0x2::table::borrow_mut<u64, address>(&mut arg0.node_adder, v0);
        0x2::table::remove<address, u64>(&mut arg0.savings, *v1);
        0x2::table::remove<address, u64>(&mut arg0.adder_node, *v1);
        *v1 = arg3;
        0x2::table::add<address, u64>(&mut arg0.adder_node, arg3, v0);
        let v2 = arg1 / 1000000;
        let v3 = 0x2::clock::timestamp_ms(arg2) / 1000;
        let v4 = 0x2::table::borrow_mut<u64, Node_Data>(&mut arg0.leaf_node_data, v0);
        v4.balance_right = v2;
        v4.change_time = v3;
        v4.previous_value = 0;
        let v5 = get_parent_node(v0, arg0.leaf_node, arg0.tree_height);
        modify_parent_node<T0>(v3, v5, arg0, v2, true);
        0x1::vector::remove<u64>(&mut arg0.null_node, 0);
    }

    fun withdr_<T0>(arg0: u64, arg1: &mut SavingsData<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0x2::clock::Clock, arg7: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<T0>(arg6, arg7, arg2, arg3, arg1.index, arg0, arg4, arg5, &arg1.account_cap), arg8)
    }

    public entry fun withdraw<T0>(arg0: &mut SavingsData<T0>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg5: &0x2::clock::Clock, arg6: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow<address, u64>(&mut arg0.savings, 0x2::tx_context::sender(arg7));
        assert!(*v0 > 0, 5);
        let v1 = *v0 / 1000000;
        arg0.total_balance = arg0.total_balance - *v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<T0>(arg5, arg6, arg1, arg2, arg0.index, *v0, arg3, arg4, &arg0.account_cap), arg7), 0x2::tx_context::sender(arg7));
        let v2 = 0x2::table::borrow<address, u64>(&arg0.adder_node, 0x2::tx_context::sender(arg7));
        0x1::vector::push_back<u64>(&mut arg0.null_node, *v2);
        let v3 = 0x2::clock::timestamp_ms(arg5) / 1000;
        let v4 = 0x2::table::borrow_mut<u64, Node_Data>(&mut arg0.leaf_node_data, *v2);
        v4.balance_right = 0;
        v4.change_time = v3;
        v4.previous_value = calculate_node_weight(v4, v3, arg0.start_time);
        let v5 = get_parent_node(*v2, arg0.leaf_node, arg0.tree_height);
        modify_parent_node<T0>(v3, v5, arg0, v1, false);
        *0x2::table::borrow_mut<address, u64>(&mut arg0.savings, 0x2::tx_context::sender(arg7)) = 0;
    }

    public fun withdrawaaaaaaaaaaaaaaaa<T0>(arg0: &AdminCap, arg1: u64, arg2: &mut SavingsData<T0>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &0x2::clock::Clock, arg8: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<T0>(arg7, arg8, arg3, arg4, arg2.index, arg1, arg5, arg6, &arg2.account_cap), arg9)
    }

    // decompiled from Move bytecode v6
}

