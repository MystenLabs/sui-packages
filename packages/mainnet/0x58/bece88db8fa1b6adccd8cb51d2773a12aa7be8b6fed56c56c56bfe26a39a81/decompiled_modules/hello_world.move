module 0x58bece88db8fa1b6adccd8cb51d2773a12aa7be8b6fed56c56c56bfe26a39a81::hello_world {
    struct Hello has store, key {
        id: 0x2::object::UID,
        text: address,
    }

    struct Contract<phantom T0> has key {
        id: 0x2::object::UID,
        users: 0x2::table::Table<address, User>,
        user_list: vector<address>,
        yy_balace: 0x2::balance::Balance<T0>,
        withdraw_charges: u8,
        withdraw_ratio: u8,
        pay_ratio: u8,
        prize_pool: PrizePool,
        global_network_statistics: Global_NetworkStatistics,
        vault: Vault,
        admin: address,
        rebot: address,
    }

    struct PrizePool has store {
        level5_gross: u64,
        level5_issued: u64,
        level5_ratio: u8,
        level6_gross: u64,
        level6_issued: u64,
        level6_ratio: u8,
        level7_gross: u64,
        level7_issued: u64,
        level7_ratio: u8,
        market_gross: u64,
        market_addr: address,
    }

    struct Global_NetworkStatistics has copy, store {
        total_static_power_invested: u64,
        total_dynamic_power_invested: u64,
        total_static_power_released: u64,
        total_dynamic_power_released: u64,
        total_invested_amount: u64,
        total_withdrawn_amount: u64,
        total_user_balance: u64,
        yu_li_bao_unredeemed_amount: u64,
        total_asset_invested: u64,
    }

    struct User has store {
        id: 0x2::object::UID,
        inviter: 0x1::option::Option<address>,
        invitees: vector<address>,
        total_revenue: u64,
        total_amount: u64,
        performance: u64,
        total_static_power: u64,
        dynamic_power: u64,
        level: u8,
        appoint_level: u8,
        balance: u64,
        underway_power: u64,
        underway_amount: u64,
        daily_static_revenue: u64,
        release_static_power: u64,
        release_dynamic_power: u64,
        orders: vector<Order>,
        stake_orders: vector<StakeOrder>,
    }

    struct Order has store {
        id: u64,
        start_time: u64,
        amount: u64,
        rate: u8,
        sui_amount: u64,
        yy_amount: u64,
        static_power: u64,
        status: u8,
    }

    struct StakeOrder has store {
        id: u64,
        start_time: u64,
        status: u8,
        amount: u64,
        interest: u64,
    }

    struct Vault has store {
        account_cap: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
        sui_index: u8,
        usdc_index: u8,
    }

    struct Owner has store, key {
        id: 0x2::object::UID,
        admin: address,
    }

    fun deposit<T0>(arg0: &Vault, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0x2::clock::Clock) {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T0>(arg6, arg2, arg3, arg0.sui_index, arg1, arg4, arg5, &arg0.account_cap);
    }

    public fun extract_sui_newV1<T0, T1>(arg0: &mut Contract<T1>, arg1: address, arg2: u64, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &0x2::clock::Clock, arg8: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg9: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(withdrawSui<T0>(&mut arg0.vault, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9), arg1);
    }

    public fun init_contract<T0>(arg0: &Owner, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            account_cap : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg1),
            sui_index   : 0,
            usdc_index  : 1,
        };
        let v1 = PrizePool{
            level5_gross  : 0,
            level5_issued : 0,
            level5_ratio  : 100,
            level6_gross  : 0,
            level6_issued : 0,
            level6_ratio  : 100,
            level7_gross  : 0,
            level7_issued : 0,
            level7_ratio  : 100,
            market_gross  : 0,
            market_addr   : @0xae19bd71660b81394336758e6e47cd11cfca09fd0ef78efa442c12c8f85af61b,
        };
        let v2 = Global_NetworkStatistics{
            total_static_power_invested  : 0,
            total_dynamic_power_invested : 0,
            total_static_power_released  : 0,
            total_dynamic_power_released : 0,
            total_invested_amount        : 0,
            total_withdrawn_amount       : 0,
            total_user_balance           : 0,
            yu_li_bao_unredeemed_amount  : 0,
            total_asset_invested         : 0,
        };
        let v3 = Contract<T0>{
            id                        : 0x2::object::new(arg1),
            users                     : 0x2::table::new<address, User>(arg1),
            user_list                 : vector[],
            yy_balace                 : 0x2::balance::zero<T0>(),
            withdraw_charges          : 10,
            withdraw_ratio            : 80,
            pay_ratio                 : 100,
            prize_pool                : v1,
            global_network_statistics : v2,
            vault                     : v0,
            admin                     : @0xae19bd71660b81394336758e6e47cd11cfca09fd0ef78efa442c12c8f85af61b,
            rebot                     : @0xff1a28d522a7403932b95c249ad341a91b51e4633f0ee7e62149fdfe624d30e1,
        };
        let v4 = User{
            id                    : 0x2::object::new(arg1),
            inviter               : 0x1::option::none<address>(),
            invitees              : vector[],
            total_revenue         : 0,
            total_amount          : 0,
            performance           : 0,
            total_static_power    : 0,
            dynamic_power         : 0,
            level                 : 0,
            appoint_level         : 0,
            balance               : 0,
            underway_power        : 0,
            underway_amount       : 0,
            daily_static_revenue  : 0,
            release_static_power  : 0,
            release_dynamic_power : 0,
            orders                : 0x1::vector::empty<Order>(),
            stake_orders          : 0x1::vector::empty<StakeOrder>(),
        };
        0x1::vector::push_back<address>(&mut v3.user_list, @0xff1a28d522a7403932b95c249ad341a91b51e4633f0ee7e62149fdfe624d30e1);
        0x2::table::add<address, User>(&mut v3.users, @0xff1a28d522a7403932b95c249ad341a91b51e4633f0ee7e62149fdfe624d30e1, v4);
        0x2::transfer::share_object<Contract<T0>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Hello{
            id   : 0x2::object::new(arg0),
            text : 0x2::tx_context::sender(arg0),
        };
        let v1 = Owner{
            id    : 0x2::object::new(arg0),
            admin : @0xae19bd71660b81394336758e6e47cd11cfca09fd0ef78efa442c12c8f85af61b,
        };
        0x2::transfer::transfer<Owner>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::transfer<Hello>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun purchaseV1<T0, T1, T2>(arg0: &mut Contract<T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        deposit<T0>(&mut arg0.vault, arg1, arg4, arg5, arg6, arg7, arg8);
    }

    fun withdrawSui<T0>(arg0: &Vault, arg1: u64, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0x2::clock::Clock, arg7: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<T0>(arg6, arg7, arg2, arg3, arg0.sui_index, arg1, arg4, arg5, &arg0.account_cap), arg8)
    }

    // decompiled from Move bytecode v6
}

