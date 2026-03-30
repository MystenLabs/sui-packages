module 0x8a71874f3037bb658ca3faf1bdd1e6068e164d5fa24724733cbe3c919a56986::implements {
    struct Vault has store {
        account_cap: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
        pool_index: u8,
    }

    struct StakeOrder has copy, drop, store {
        id: u64,
        start_time: u64,
        amount: u64,
        status: u8,
        redeem_amount: u64,
    }

    struct UserInfo has store {
        orders: vector<StakeOrder>,
    }

    struct Global<phantom T0> has key {
        id: 0x2::object::UID,
        admin: address,
        vault: Vault,
        cumulative_staked: u64,
        cumulative_redeemed: u64,
        cumulative_admin_deposited: u64,
        cumulative_admin_withdrawn: u64,
        has_paused: bool,
        users: 0x2::table::Table<address, UserInfo>,
        next_order_id: u64,
    }

    public fun admin_deposit<T0>(arg0: &mut Global<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == arg0.admin, 1);
        arg0.cumulative_admin_deposited = arg0.cumulative_admin_deposited + 0x2::coin::value<T0>(&arg1);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T0>(arg6, arg2, arg3, arg0.vault.pool_index, arg1, arg4, arg5, &arg0.vault.account_cap);
    }

    public fun admin_withdraw<T0>(arg0: &mut Global<T0>, arg1: u64, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0x2::clock::Clock, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg9) == arg0.admin, 1);
        arg0.cumulative_admin_withdrawn = arg0.cumulative_admin_withdrawn + arg1;
        0x2::coin::from_balance<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap_v2<T0>(arg6, arg8, arg2, arg3, arg0.vault.pool_index, arg1, arg4, arg5, &arg0.vault.account_cap, arg7, arg9), arg9)
    }

    public fun calc_compound(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128);
        let v1 = 0;
        while (v1 < arg1) {
            let v2 = v0 * 1001;
            v0 = v2 / 1000;
            v1 = v1 + 1;
        };
        (v0 as u64)
    }

    public fun create_and_share<T0>(arg0: u8, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0xed32c207b585e6861bb7b75ee3ea491d61e0e8c9034d3b1fab24aafc994c61ca, 1);
        let v0 = Vault{
            account_cap : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg1),
            pool_index  : arg0,
        };
        let v1 = Global<T0>{
            id                         : 0x2::object::new(arg1),
            admin                      : 0x2::tx_context::sender(arg1),
            vault                      : v0,
            cumulative_staked          : 0,
            cumulative_redeemed        : 0,
            cumulative_admin_deposited : 0,
            cumulative_admin_withdrawn : 0,
            has_paused                 : false,
            users                      : 0x2::table::new<address, UserInfo>(arg1),
            next_order_id              : 0,
        };
        0x2::transfer::share_object<Global<T0>>(v1);
    }

    public fun cumulative_admin_deposited<T0>(arg0: &Global<T0>) : u64 {
        arg0.cumulative_admin_deposited
    }

    public fun cumulative_admin_withdrawn<T0>(arg0: &Global<T0>) : u64 {
        arg0.cumulative_admin_withdrawn
    }

    public fun cumulative_redeemed<T0>(arg0: &Global<T0>) : u64 {
        arg0.cumulative_redeemed
    }

    public fun cumulative_staked<T0>(arg0: &Global<T0>) : u64 {
        arg0.cumulative_staked
    }

    public fun current_amount(arg0: u64, arg1: u64, arg2: u64) : u64 {
        calc_compound(arg1, (arg2 - arg0) / 86400000)
    }

    fun find_order_idx(arg0: &vector<StakeOrder>, arg1: u64) : u64 {
        let v0 = 0x1::vector::length<StakeOrder>(arg0);
        let v1 = 0;
        while (v1 < v0) {
            if (0x1::vector::borrow<StakeOrder>(arg0, v1).id == arg1) {
                return v1
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_active_orders<T0>(arg0: &Global<T0>, arg1: address) : vector<StakeOrder> {
        if (!0x2::table::contains<address, UserInfo>(&arg0.users, arg1)) {
            return 0x1::vector::empty<StakeOrder>()
        };
        let v0 = 0x2::table::borrow<address, UserInfo>(&arg0.users, arg1);
        let v1 = 0x1::vector::empty<StakeOrder>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<StakeOrder>(&v0.orders)) {
            let v3 = 0x1::vector::borrow<StakeOrder>(&v0.orders, v2);
            if (v3.status == 0) {
                0x1::vector::push_back<StakeOrder>(&mut v1, *v3);
            };
            v2 = v2 + 1;
        };
        v1
    }

    public fun get_id<T0>(arg0: &Global<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_redeemed_orders<T0>(arg0: &Global<T0>, arg1: address) : vector<StakeOrder> {
        if (!0x2::table::contains<address, UserInfo>(&arg0.users, arg1)) {
            return 0x1::vector::empty<StakeOrder>()
        };
        let v0 = 0x2::table::borrow<address, UserInfo>(&arg0.users, arg1);
        let v1 = 0x1::vector::empty<StakeOrder>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<StakeOrder>(&v0.orders)) {
            let v3 = 0x1::vector::borrow<StakeOrder>(&v0.orders, v2);
            if (v3.status == 1) {
                0x1::vector::push_back<StakeOrder>(&mut v1, *v3);
            };
            v2 = v2 + 1;
        };
        v1
    }

    public fun navi_pool_balance<T0>(arg0: &Global<T0>, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) : u64 {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<T0>(arg1, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg2, arg0.vault.pool_index, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.vault.account_cap)) as u64))
    }

    public fun set_emergency<T0>(arg0: &mut Global<T0>, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.has_paused = arg1;
    }

    public fun stake<T0>(arg0: &mut Global<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(!arg0.has_paused, 3);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 0);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = arg0.next_order_id;
        arg0.next_order_id = v2 + 1;
        if (!0x2::table::contains<address, UserInfo>(&arg0.users, v1)) {
            let v3 = UserInfo{orders: 0x1::vector::empty<StakeOrder>()};
            0x2::table::add<address, UserInfo>(&mut arg0.users, v1, v3);
        };
        let v4 = StakeOrder{
            id            : v2,
            start_time    : 0x2::clock::timestamp_ms(arg6),
            amount        : v0,
            status        : 0,
            redeem_amount : 0,
        };
        0x1::vector::push_back<StakeOrder>(&mut 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.users, v1).orders, v4);
        arg0.cumulative_staked = arg0.cumulative_staked + v0;
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T0>(arg6, arg2, arg3, arg0.vault.pool_index, arg1, arg4, arg5, &arg0.vault.account_cap);
        v2
    }

    public fun transfer_admin<T0>(arg0: &mut Global<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0xed32c207b585e6861bb7b75ee3ea491d61e0e8c9034d3b1fab24aafc994c61ca, 1);
        arg0.admin = arg1;
    }

    public fun unstake<T0>(arg0: &mut Global<T0>, arg1: u64, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0x2::clock::Clock, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64, u64) {
        assert!(!arg0.has_paused, 3);
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(0x2::table::contains<address, UserInfo>(&arg0.users, v0), 4);
        let v1 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.users, v0);
        let v2 = find_order_idx(&v1.orders, arg1);
        assert!(v2 < 0x1::vector::length<StakeOrder>(&v1.orders), 4);
        let v3 = 0x1::vector::borrow<StakeOrder>(&v1.orders, v2);
        assert!(v3.status == 0, 5);
        let v4 = v3.amount;
        0x1::vector::borrow_mut<StakeOrder>(&mut v1.orders, v2).status = 1;
        let v5 = (0x2::clock::timestamp_ms(arg6) - v3.start_time) / 86400000;
        let v6 = calc_compound(v4, v5);
        arg0.cumulative_redeemed = arg0.cumulative_redeemed + v6;
        0x1::vector::borrow_mut<StakeOrder>(&mut v1.orders, v2).redeem_amount = v6;
        (0x2::coin::from_balance<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap_v2<T0>(arg6, arg8, arg2, arg3, arg0.vault.pool_index, v6, arg4, arg5, &arg0.vault.account_cap, arg7, arg9), arg9), v4, v5)
    }

    // decompiled from Move bytecode v6
}

