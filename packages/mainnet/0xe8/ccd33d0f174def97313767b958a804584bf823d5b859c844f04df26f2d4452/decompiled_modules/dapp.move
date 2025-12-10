module 0xe8ccd33d0f174def97313767b958a804584bf823d5b859c844f04df26f2d4452::dapp {
    struct GlobalNetworkData has store {
        total_user: u64,
        total_effective_user: u64,
        total_user_balance: u64,
        total_invested_amount: u64,
        total_sui_invested_amount: u64,
        total_pre_invested_amount: u64,
        total_withdrawn_amount: u64,
        total_asset_invested: u64,
    }

    struct User has drop, store {
        inviter: 0x1::option::Option<address>,
        invitees: vector<address>,
        level: u8,
        appoint_level: u8,
        join_amount: u64,
        performance: u64,
        benefit_expiry: u64,
        today_earning: u64,
        total_earning: u64,
        balance: u64,
        state: u8,
        invest_amount: u64,
        dynamic_power: u64,
        quota: u64,
        orders: vector<Order>,
        stake_orders: vector<Order>,
    }

    struct Order has drop, store {
        id: u64,
        start_time: u64,
        amount: u64,
        rate: u8,
        sui_amount: u64,
        pre_amount: u64,
        static_power: u64,
        status: u8,
    }

    struct StakeOrder has drop, store {
        id: u64,
        start_time: u64,
        status: u8,
        amount: u64,
        interest: u64,
    }

    struct Contract<phantom T0> has key {
        id: 0x2::object::UID,
        users: 0x2::table::Table<address, User>,
        user_list: vector<address>,
        pre_balace: 0x2::balance::Balance<T0>,
        pay_ratio: u8,
        up_time: u64,
        withdraw_charges: u8,
        withdraw_ratio: u8,
        global_network_data: GlobalNetworkData,
        vault: Vault,
        admin: address,
        rebot: address,
    }

    struct Vault has store {
        account_cap: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
        sui_index: u8,
        usdc_index: u8,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        admin: address,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{
            id    : 0x2::object::new(arg0),
            admin : v0,
        };
        0x2::transfer::transfer<AdminCap>(v1, v0);
    }

    public fun init_contract<T0>(arg0: &AdminCap, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 0);
        let v0 = @0x48a451b8a98f4e9cda542e4a87ab2449c9d3e53fbe1bac991ae38de4599143a0;
        let v1 = User{
            inviter        : 0x1::option::none<address>(),
            invitees       : 0x1::vector::empty<address>(),
            level          : 0,
            appoint_level  : 0,
            join_amount    : 0,
            performance    : 0,
            benefit_expiry : 0,
            today_earning  : 0,
            total_earning  : 0,
            balance        : 0,
            state          : 0,
            invest_amount  : 0,
            dynamic_power  : 0,
            quota          : 0,
            orders         : 0x1::vector::empty<Order>(),
            stake_orders   : 0x1::vector::empty<Order>(),
        };
        let v2 = 0x2::table::new<address, User>(arg2);
        0x2::table::add<address, User>(&mut v2, v0, v1);
        let v3 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v3, v0);
        let v4 = Vault{
            account_cap : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg2),
            sui_index   : 0,
            usdc_index  : 1,
        };
        let v5 = GlobalNetworkData{
            total_user                : 0,
            total_effective_user      : 0,
            total_user_balance        : 0,
            total_invested_amount     : 0,
            total_sui_invested_amount : 0,
            total_pre_invested_amount : 0,
            total_withdrawn_amount    : 0,
            total_asset_invested      : 0,
        };
        let v6 = Contract<T0>{
            id                  : 0x2::object::new(arg2),
            users               : v2,
            user_list           : v3,
            pre_balace          : 0x2::balance::zero<T0>(),
            pay_ratio           : 100,
            up_time             : 0x2::clock::timestamp_ms(arg1),
            withdraw_charges    : 10,
            withdraw_ratio      : 100,
            global_network_data : v5,
            vault               : v4,
            admin               : @0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca,
            rebot               : @0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca,
        };
        0x2::transfer::share_object<Contract<T0>>(v6);
    }

    // decompiled from Move bytecode v6
}

