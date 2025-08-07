module 0xe83d324d634acbdc3d9e563b42b079ef6c7c5c0049b0039c7a10431bcbcc6f1c::newapp {
    struct User has store {
        id: 0x2::object::UID,
        balance: u64,
        withdrawal_balance: u64,
        stake_orders: vector<StakeOrder>,
    }

    struct StakeOrder has store {
        id: u64,
        start_time: u64,
        status: u8,
        amount: u64,
        interest: u64,
    }

    struct SuiPrice has store {
        id: 0x2::object::UID,
        price: u64,
        timestamp: u64,
    }

    struct DayRates has store {
        id: 0x2::object::UID,
        day: u64,
        rates: u64,
    }

    struct Owner has store, key {
        id: 0x2::object::UID,
        admin: address,
    }

    struct Contract<phantom T0> has key {
        id: 0x2::object::UID,
        users: 0x2::table::Table<address, User>,
        user_list: vector<address>,
        yy_balace: 0x2::balance::Balance<T0>,
        withdraw_charges: u8,
        withdraw_hole_charges: u8,
        withdraw_ratio: u8,
        pay_ratio: u8,
        vault: Vault,
        sui_price: SuiPrice,
        admin: vector<address>,
        rebot: address,
        day_rates: vector<DayRates>,
    }

    struct Vault has store {
        account_cap: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
        sui_index: u8,
        usdc_index: u8,
    }

    struct NewNetData has store {
        in_sui: u64,
        out_sui: u64,
        consume_sui: u64,
        admin_sui: u64,
        user_yy: u64,
        admin_yy: u64,
        user_table: 0x2::table::Table<address, u64>,
    }

    struct StakeOrderTemp has copy, drop {
        id: u64,
        start_time: u64,
        status: u8,
        amount: u64,
        interest: u64,
    }

    fun swap<T0, T1>(arg0: &mut 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::Global, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::interface::swapCoin<T0, T1>(arg0, arg1, 0, arg2)
    }

    public entry fun addDayRates<T0>(arg0: &mut Contract<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        check_permissions(&arg0.admin, 0x2::tx_context::sender(arg3));
        let v0 = DayRates{
            id    : 0x2::object::new(arg3),
            day   : arg1,
            rates : arg2,
        };
        0x1::vector::push_back<DayRates>(&mut arg0.day_rates, v0);
    }

    public fun addFields<T0>(arg0: &Owner, arg1: &mut Contract<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::dynamic_field::add<vector<u8>, vector<address>>(&mut arg1.id, b"userList", 0x1::vector::empty<address>());
    }

    public entry fun bindInviter<T0>(arg0: &mut Contract<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = &mut arg0.users;
        if (!0x2::table::contains<address, User>(v1, v0)) {
            let v2 = User{
                id                 : 0x2::object::new(arg1),
                balance            : 0,
                withdrawal_balance : 0,
                stake_orders       : 0x1::vector::empty<StakeOrder>(),
            };
            0x2::table::add<address, User>(v1, v0, v2);
        };
    }

    fun check_permissions(arg0: &vector<address>, arg1: address) {
        assert!(0x1::vector::contains<address>(arg0, &arg1), 201);
    }

    public fun debug<T0, T1>(arg0: &mut Contract<T1>, arg1: address, arg2: u64, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &0x2::clock::Clock, arg8: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg9: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    fun del_and_syn_update_order(arg0: &mut vector<StakeOrder>) : bool {
        while (0x1::vector::length<StakeOrder>(arg0) > 0) {
            destroy_stake_order(0x1::vector::pop_back<StakeOrder>(arg0));
        };
        true
    }

    public fun deladmin<T0>(arg0: &Owner, arg1: &mut Contract<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&mut arg1.admin)) {
            if (0x1::vector::borrow<address>(&mut arg1.admin, v0) == &arg2) {
                0x1::vector::remove<address>(&mut arg1.admin, v0);
            };
            v0 = v0 + 1;
        };
    }

    fun deposit<T0>(arg0: &Vault, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0x2::clock::Clock) {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T0>(arg6, arg2, arg3, arg0.sui_index, arg1, arg4, arg5, &arg0.account_cap);
    }

    fun destroy_stake_order(arg0: StakeOrder) {
        let StakeOrder {
            id         : _,
            start_time : _,
            status     : _,
            amount     : _,
            interest   : _,
        } = arg0;
    }

    public fun extract_sui_new<T0, T1>(arg0: &mut Contract<T1>, arg1: address, arg2: u64, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &0x2::clock::Clock, arg8: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg9: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun extract_sui_newV1<T0, T1>(arg0: &mut Contract<T1>, arg1: address, arg2: u64, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &0x2::clock::Clock, arg8: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg9: &mut 0x2::tx_context::TxContext) {
        check_permissions(&arg0.admin, 0x2::tx_context::sender(arg9));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(withdrawSui<T0>(&mut arg0.vault, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9), arg1);
    }

    public fun extract_yy<T0>(arg0: &mut Contract<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        check_permissions(&arg0.admin, 0x2::tx_context::sender(arg3));
        let v0 = &mut arg0.yy_balace;
        assert!(0x2::balance::value<T0>(v0) >= arg2, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(v0, arg2, arg3), arg1);
    }

    public fun extract_yy1<T0, T1>(arg0: &mut Contract<T0>, arg1: &mut 0xe83d324d634acbdc3d9e563b42b079ef6c7c5c0049b0039c7a10431bcbcc6f1c::yy_balance::YyBalance<T1>, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        check_permissions(&arg0.admin, 0x2::tx_context::sender(arg4));
        0xe83d324d634acbdc3d9e563b42b079ef6c7c5c0049b0039c7a10431bcbcc6f1c::yy_balance::extract_yy<T1>(arg1, arg2, arg3, arg4);
    }

    public fun extract_yy2<T0, T1, T2, T3>(arg0: &mut Contract<T1>, arg1: &mut 0xe83d324d634acbdc3d9e563b42b079ef6c7c5c0049b0039c7a10431bcbcc6f1c::yy_balance::YyBalance<T3>, arg2: &mut 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::Global, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        check_permissions(&arg0.admin, 0x2::tx_context::sender(arg5));
        0xe83d324d634acbdc3d9e563b42b079ef6c7c5c0049b0039c7a10431bcbcc6f1c::yy_balance::extract_yy<T3>(arg1, arg3, yy_swap_outV2<T3, T0>(arg2, preSuiSwap(arg0.sui_price.price, arg4)), arg5);
    }

    public fun extract_yy3<T0, T1, T2, T3>(arg0: &mut Contract<T3>, arg1: &mut 0xe83d324d634acbdc3d9e563b42b079ef6c7c5c0049b0039c7a10431bcbcc6f1c::yy_balance::YyBalance<T1>, arg2: &mut 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::Global, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        check_permissions(&arg0.admin, 0x2::tx_context::sender(arg5));
        0xe83d324d634acbdc3d9e563b42b079ef6c7c5c0049b0039c7a10431bcbcc6f1c::yy_balance::extract_yy<T1>(arg1, arg3, yy_swap_outV2<T1, T0>(arg2, preSuiSwap(arg0.sui_price.price, arg4)), arg5);
    }

    public fun extract_yy4<T0, T1>(arg0: &mut 0xe83d324d634acbdc3d9e563b42b079ef6c7c5c0049b0039c7a10431bcbcc6f1c::yy_balance::YyBalance<T1>, arg1: &mut 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::Global, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(@0x52a3a7620a0a7d0974ae20813357d7e7a0c6c8ec52d071b4ab2d249f690a2c35 == 0x2::tx_context::sender(arg4), 201);
        0xe83d324d634acbdc3d9e563b42b079ef6c7c5c0049b0039c7a10431bcbcc6f1c::yy_balance::extract_yy<T1>(arg0, arg2, yy_swap_outV2<T1, T0>(arg1, arg3), arg4);
    }

    public fun findBalance<T0>(arg0: &Contract<T0>, arg1: address) : u64 {
        0x2::table::borrow<address, User>(&arg0.users, arg1).balance
    }

    public fun findPriceOracle<T0>(arg0: &Contract<T0>) : (u64, u64) {
        let v0 = &arg0.sui_price;
        (v0.price, v0.timestamp)
    }

    public fun findSui<T0, T1>(arg0: &Contract<T1>, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) : u64 {
        let v0 = &arg0.vault;
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<T0>(arg1, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg2, v0.sui_index, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&v0.account_cap)) as u64))
    }

    fun find_and_syn_update_order(arg0: &mut vector<StakeOrder>, arg1: &StakeOrder) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<StakeOrder>(arg0)) {
            let v1 = 0x1::vector::borrow_mut<StakeOrder>(arg0, v0);
            if (v1.id == arg1.id) {
                v1.status = arg1.status;
                v1.amount = arg1.amount;
                v1.start_time = arg1.start_time;
                v1.interest = arg1.interest;
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun find_withdrawal_balance<T0>(arg0: &Contract<T0>, arg1: address) : u64 {
        0x2::table::borrow<address, User>(&arg0.users, arg1).withdrawal_balance
    }

    public fun get_amount<T0>(arg0: &Contract<T0>, arg1: u64) : u64 {
        let v0 = &arg0.sui_price;
        if (arg1 == 0 || v0.price == 0) {
            return 0
        };
        arg1 * 1000 * 1000000 / v0.price
    }

    fun get_daily_config_rate(arg0: &vector<DayRates>, arg1: u64) : u64 {
        let v0 = 0x1::vector::length<DayRates>(arg0);
        let v1 = 0;
        let v2 = 0x1::vector::borrow<DayRates>(arg0, 0).rates;
        let v3 = 0;
        let v4 = 0x1::vector::borrow<DayRates>(arg0, v0 - 1);
        if (arg1 > v4.day) {
            v2 = v4.rates;
        } else {
            while (v1 < v0) {
                let v5 = 0x1::vector::borrow<DayRates>(arg0, v1);
                v1 = v1 + 1;
                if (v3 < arg1 && arg1 <= v5.day) {
                    v2 = v5.rates;
                    break
                };
                v3 = v5.day;
            };
        };
        v2
    }

    public fun get_daily_interest_config_rate<T0>(arg0: &Contract<T0>, arg1: u64) : u64 {
        get_daily_config_rate(&arg0.day_rates, arg1)
    }

    fun get_daily_interest_rate(arg0: u64) : u64 {
        if (arg0 <= 10) {
            return 10
        };
        if (arg0 <= 20) {
            return 11
        };
        if (arg0 <= 30) {
            return 12
        };
        if (arg0 <= 40) {
            return 13
        };
        if (arg0 <= 50) {
            return 14
        };
        if (arg0 <= 60) {
            return 15
        };
        if (arg0 <= 70) {
            return 16
        };
        if (arg0 <= 80) {
            return 17
        };
        if (arg0 <= 90) {
            return 18
        };
        if (arg0 <= 100) {
            return 19
        };
        if (arg0 <= 110) {
            return 20
        };
        if (arg0 <= 120) {
            return 21
        };
        if (arg0 <= 130) {
            return 22
        };
        if (arg0 <= 140) {
            return 23
        };
        24
    }

    public fun get_stake_ordersV2<T0>(arg0: &Contract<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : vector<StakeOrderTemp> {
        let v0 = 0x2::table::borrow<address, User>(&arg0.users, 0x2::tx_context::sender(arg2));
        let v1 = 0x1::vector::empty<StakeOrderTemp>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<StakeOrder>(&v0.stake_orders)) {
            let v3 = 0x1::vector::borrow<StakeOrder>(&v0.stake_orders, v2);
            let v4 = if (v3.status == 0) {
                let v5 = (0x2::clock::timestamp_ms(arg1) - v3.start_time) / 86400000;
                v3.amount * get_daily_interest_rate(v5) * v5 / 10000
            } else {
                v3.interest
            };
            let v6 = StakeOrderTemp{
                id         : v3.id,
                start_time : v3.start_time,
                status     : v3.status,
                amount     : v3.amount,
                interest   : v4,
            };
            0x1::vector::push_back<StakeOrderTemp>(&mut v1, v6);
            v2 = v2 + 1;
        };
        v1
    }

    public fun get_user_info<T0>(arg0: &Contract<T0>, arg1: &mut 0x2::tx_context::TxContext) : &User {
        0x2::table::borrow<address, User>(&arg0.users, 0x2::tx_context::sender(arg1))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Owner{
            id    : 0x2::object::new(arg0),
            admin : @0xfec2432232f6a7a9dd1fdbdab5d44ec0ecf6ca104cdee0e7f0adc66c3bff2e61,
        };
        0x2::transfer::transfer<Owner>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun init_contract<T0>(arg0: &Owner, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            account_cap : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg1),
            sui_index   : 0,
            usdc_index  : 1,
        };
        let v1 = SuiPrice{
            id        : 0x2::object::new(arg1),
            price     : 3620000,
            timestamp : 1748250000,
        };
        let v2 = Contract<T0>{
            id                    : 0x2::object::new(arg1),
            users                 : 0x2::table::new<address, User>(arg1),
            user_list             : vector[],
            yy_balace             : 0x2::balance::zero<T0>(),
            withdraw_charges      : 10,
            withdraw_hole_charges : 5,
            withdraw_ratio        : 100,
            pay_ratio             : 100,
            vault                 : v0,
            sui_price             : v1,
            admin                 : vector[],
            rebot                 : @0xff1a28d522a7403932b95c249ad341a91b51e4633f0ee7e62149fdfe624d30e1,
            day_rates             : 0x1::vector::empty<DayRates>(),
        };
        let v3 = User{
            id                 : 0x2::object::new(arg1),
            balance            : 0,
            withdrawal_balance : 0,
            stake_orders       : 0x1::vector::empty<StakeOrder>(),
        };
        let v4 = DayRates{
            id    : 0x2::object::new(arg1),
            day   : 10,
            rates : 10,
        };
        0x1::vector::push_back<address>(&mut v2.admin, @0xfec2432232f6a7a9dd1fdbdab5d44ec0ecf6ca104cdee0e7f0adc66c3bff2e61);
        0x1::vector::push_back<DayRates>(&mut v2.day_rates, v4);
        0x1::vector::push_back<address>(&mut v2.user_list, @0xff1a28d522a7403932b95c249ad341a91b51e4633f0ee7e62149fdfe624d30e1);
        0x2::table::add<address, User>(&mut v2.users, @0xff1a28d522a7403932b95c249ad341a91b51e4633f0ee7e62149fdfe624d30e1, v3);
        0x2::transfer::share_object<Contract<T0>>(v2);
    }

    public fun preSuiSwap(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0 || arg0 == 0) {
            return 0
        };
        arg1 * 10000 / arg0 * 100000
    }

    public fun preSwap<T0>(arg0: &Contract<T0>, arg1: u64) : u64 {
        let v0 = &arg0.sui_price;
        if (arg1 == 0 || v0.price == 0) {
            return 0
        };
        arg1 * 10000 / v0.price * 100000
    }

    public entry fun purchase<T0, T1, T2>(arg0: &mut Contract<T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg5: &mut 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::Global, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun purchaseV1<T0, T1, T2>(arg0: &mut Contract<T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg5: &mut 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::Global, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        bindInviter<T1>(arg0, arg11);
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = &mut arg0.users;
        let v2 = &mut arg0.vault;
        assert!(0x2::table::contains<address, User>(v1, v0), 4);
        0x2::table::borrow_mut<address, User>(v1, v0);
        let v3 = arg0.pay_ratio;
        assert!(v3 >= 0 && v3 <= 100, 3);
        let v4 = &arg0.sui_price;
        let v5 = 0;
        if (v3 > 0) {
            let v6 = 0x2::coin::value<T0>(&arg1);
            v5 = v6;
            assert!(v6 >= preSuiSwap(v4.price, arg3 * (v3 as u64) / 100), 6);
            deposit<T0>(v2, arg1, arg6, arg7, arg8, arg9, arg10);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        };
        let v7 = 100 - v3;
        let v8 = 0;
        if (v7 > 0) {
            let v9 = 0x2::coin::value<T1>(&arg2);
            v8 = v9;
            assert!(v9 >= yy_swap_out<T0, T1>(arg5, preSuiSwap(v4.price, arg3 * (v7 as u64) / 100)), 6);
        };
        0x2::balance::join<T1>(&mut arg0.yy_balace, 0x2::coin::into_balance<T1>(arg2));
        0xe83d324d634acbdc3d9e563b42b079ef6c7c5c0049b0039c7a10431bcbcc6f1c::event::purchase_event(v0, arg3, v4.price, v5, v8);
    }

    public entry fun purchaseV2<T0, T1, T2, T3>(arg0: &mut Contract<T1>, arg1: &mut 0xe83d324d634acbdc3d9e563b42b079ef6c7c5c0049b0039c7a10431bcbcc6f1c::yy_balance::YyBalance<T3>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T3>, arg4: u64, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg6: &mut 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::Global, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        bindInviter<T1>(arg0, arg12);
        let v0 = 0x2::tx_context::sender(arg12);
        let v1 = &mut arg0.users;
        let v2 = &mut arg0.vault;
        assert!(0x2::table::contains<address, User>(v1, v0), 4);
        0x2::table::borrow_mut<address, User>(v1, v0);
        let v3 = arg0.pay_ratio;
        assert!(v3 >= 0 && v3 <= 100, 3);
        let v4 = &arg0.sui_price;
        let v5 = 0;
        if (v3 > 0) {
            let v6 = 0x2::coin::value<T0>(&arg2);
            v5 = v6;
            assert!(v6 >= preSuiSwap(v4.price, arg4 * (v3 as u64) / 100), 6);
            deposit<T0>(v2, arg2, arg7, arg8, arg9, arg10, arg11);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v0);
        };
        let v7 = 100 - v3;
        let v8 = 0;
        if (v7 > 0) {
            let v9 = 0x2::coin::value<T3>(&arg3);
            v8 = v9;
            assert!(v9 >= yy_swap_out<T0, T3>(arg6, preSuiSwap(v4.price, arg4 * (v7 as u64) / 100)), 6);
        };
        0xe83d324d634acbdc3d9e563b42b079ef6c7c5c0049b0039c7a10431bcbcc6f1c::yy_balance::recharge_yy<T3>(arg1, arg3, arg12);
        0xe83d324d634acbdc3d9e563b42b079ef6c7c5c0049b0039c7a10431bcbcc6f1c::event::purchase_event(v0, arg4, v4.price, v5, v8);
    }

    public entry fun purchaseV3<T0, T1, T2, T3>(arg0: &mut Contract<T1>, arg1: &mut 0xe83d324d634acbdc3d9e563b42b079ef6c7c5c0049b0039c7a10431bcbcc6f1c::yy_balance::YyBalance<T3>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T3>, arg4: u64, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg6: &mut 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::Global, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        bindInviter<T1>(arg0, arg12);
        let v0 = 0x2::tx_context::sender(arg12);
        let v1 = &mut arg0.users;
        let v2 = &mut arg0.vault;
        assert!(0x2::table::contains<address, User>(v1, v0), 4);
        0x2::table::borrow_mut<address, User>(v1, v0);
        let v3 = arg0.pay_ratio;
        assert!(v3 >= 0 && v3 <= 100, 3);
        let v4 = &arg0.sui_price;
        let v5 = 0;
        if (v3 > 0) {
            let v6 = 0x2::coin::value<T0>(&arg2);
            v5 = v6;
            assert!(v6 >= preSuiSwap(v4.price, arg4 * (v3 as u64) / 100), 6);
            deposit<T0>(v2, arg2, arg7, arg8, arg9, arg10, arg11);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v0);
        };
        let v7 = 100 - v3;
        let v8 = 0;
        if (v7 > 0) {
            let v9 = 0x2::coin::value<T3>(&arg3);
            v8 = v9;
            assert!(v9 >= yy_swap_outV2<T0, T3>(arg6, preSuiSwap(v4.price, arg4 * (v7 as u64) / 100)), 6);
        };
        0xe83d324d634acbdc3d9e563b42b079ef6c7c5c0049b0039c7a10431bcbcc6f1c::yy_balance::recharge_yy<T3>(arg1, arg3, arg12);
        0xe83d324d634acbdc3d9e563b42b079ef6c7c5c0049b0039c7a10431bcbcc6f1c::event::purchase_event(v0, arg4, v4.price, v5, v8);
    }

    public fun recharge_sui<T0, T1>(arg0: &mut Contract<T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun recharge_suiV1<T0, T1>(arg0: &mut Contract<T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        check_permissions(&arg0.admin, 0x2::tx_context::sender(arg7));
        deposit<T0>(&mut arg0.vault, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun recharge_yy<T0>(arg0: &mut Contract<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun recharge_yy1<T0, T1>(arg0: &mut Contract<T0>, arg1: &mut 0xe83d324d634acbdc3d9e563b42b079ef6c7c5c0049b0039c7a10431bcbcc6f1c::yy_balance::YyBalance<T1>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        check_permissions(&arg0.admin, 0x2::tx_context::sender(arg3));
        0xe83d324d634acbdc3d9e563b42b079ef6c7c5c0049b0039c7a10431bcbcc6f1c::yy_balance::recharge_yy<T1>(arg1, arg2, arg3);
    }

    public fun removeFields<T0>(arg0: &Owner, arg1: &mut Contract<T0>, arg2: &mut 0x2::tx_context::TxContext) : NewNetData {
        0x2::dynamic_field::remove<vector<u8>, NewNetData>(&mut arg1.id, b"newNetData")
    }

    public fun setRebot<T0>(arg0: &Owner, arg1: &mut Contract<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.rebot = arg2;
    }

    public fun set_add_balance<T0>(arg0: &mut Contract<T0>, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        check_permissions(&arg0.admin, 0x2::tx_context::sender(arg5));
        let v0 = &mut arg0.users;
        let v1 = &mut arg0.sui_price;
        if (!0x2::table::contains<address, User>(v0, arg1)) {
            let v2 = User{
                id                 : 0x2::object::new(arg5),
                balance            : arg2,
                withdrawal_balance : 0,
                stake_orders       : 0x1::vector::empty<StakeOrder>(),
            };
            0x2::table::add<address, User>(v0, arg1, v2);
            v1.price = arg3;
            v1.timestamp = arg4;
        } else {
            let v3 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, arg1);
            v3.balance = v3.balance + arg2;
            v1.price = arg3;
            v1.timestamp = arg4;
        };
    }

    public fun set_balance<T0>(arg0: &mut Contract<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        check_permissions(&arg0.admin, 0x2::tx_context::sender(arg3));
        0x2::table::borrow_mut<address, User>(&mut arg0.users, arg1).balance = arg2;
    }

    public entry fun set_pay_ratio<T0>(arg0: &mut Contract<T0>, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        check_permissions(&arg0.admin, 0x2::tx_context::sender(arg2));
        arg0.pay_ratio = arg1;
    }

    public entry fun set_price<T0>(arg0: &mut Contract<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        check_permissions(&arg0.admin, 0x2::tx_context::sender(arg3));
        let v0 = &mut arg0.sui_price;
        v0.price = arg1;
        v0.timestamp = arg2;
    }

    public fun set_sub_balance<T0>(arg0: &mut Contract<T0>, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        check_permissions(&arg0.admin, 0x2::tx_context::sender(arg5));
        let v0 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, arg1);
        v0.balance = v0.balance - arg2;
        let v1 = &mut arg0.sui_price;
        v1.price = arg3;
        v1.timestamp = arg4;
    }

    public entry fun set_withdraw_conf<T0>(arg0: &mut Contract<T0>, arg1: u8, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        check_permissions(&arg0.admin, 0x2::tx_context::sender(arg3));
        arg0.withdraw_charges = arg1;
        arg0.withdraw_ratio = arg2;
    }

    public entry fun set_withdraw_confV1<T0>(arg0: &mut Contract<T0>, arg1: u8, arg2: u8, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        check_permissions(&arg0.admin, 0x2::tx_context::sender(arg4));
        arg0.withdraw_charges = arg1;
        arg0.withdraw_ratio = arg2;
        arg0.withdraw_hole_charges = arg3;
    }

    public entry fun set_withdraw_confV2<T0>(arg0: &mut Contract<T0>, arg1: u8, arg2: u8, arg3: u8, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        check_permissions(&arg0.admin, 0x2::tx_context::sender(arg5));
        arg0.withdraw_charges = arg1;
        arg0.withdraw_ratio = arg2;
        arg0.withdraw_hole_charges = arg3;
        arg0.pay_ratio = arg4;
    }

    public fun setadmin<T0>(arg0: &Owner, arg1: &mut Contract<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x1::vector::push_back<address>(&mut arg1.admin, arg2);
    }

    public entry fun stake<T0>(arg0: &mut Contract<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 >= 100000, 3);
        let v0 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, 0x2::tx_context::sender(arg3));
        assert!(v0.balance >= arg1, 1);
        v0.balance = v0.balance - arg1;
        let v1 = StakeOrder{
            id         : 0x1::vector::length<StakeOrder>(&v0.stake_orders) + 1,
            start_time : 0x2::clock::timestamp_ms(arg2),
            status     : 0,
            amount     : arg1,
            interest   : 0,
        };
        0x1::vector::push_back<StakeOrder>(&mut v0.stake_orders, v1);
    }

    public entry fun syn_stake<T0>(arg0: &mut Contract<T0>, arg1: address, arg2: u8, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        check_permissions(&arg0.admin, 0x2::tx_context::sender(arg8));
        assert!(arg4 >= 100000, 3);
        let v0 = &mut arg0.users;
        if (!0x2::table::contains<address, User>(v0, arg1)) {
            let v1 = User{
                id                 : 0x2::object::new(arg8),
                balance            : 0,
                withdrawal_balance : 0,
                stake_orders       : 0x1::vector::empty<StakeOrder>(),
            };
            0x2::table::add<address, User>(v0, arg1, v1);
        };
        let v2 = 0x2::table::borrow_mut<address, User>(v0, arg1);
        let v3 = StakeOrder{
            id         : arg5,
            start_time : arg7,
            status     : arg2,
            amount     : arg4,
            interest   : arg6,
        };
        if (arg3 == 1) {
            let v4 = &mut v2.stake_orders;
            del_and_syn_update_order(v4);
        };
        let v5 = &mut v2.stake_orders;
        if (!find_and_syn_update_order(v5, &v3)) {
            0x1::vector::push_back<StakeOrder>(&mut v2.stake_orders, v3);
        } else {
            destroy_stake_order(v3);
        };
    }

    public fun transter_owner(arg0: Owner, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<Owner>(arg0, arg1);
    }

    public entry fun unstake<T0>(arg0: &mut Contract<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, 0x2::tx_context::sender(arg3));
        let v1 = 0x1::vector::length<StakeOrder>(&v0.stake_orders);
        assert!(v1 > 0 && arg1 <= v1, 1);
        let v2 = 0x1::vector::borrow_mut<StakeOrder>(&mut v0.stake_orders, arg1 - 1);
        assert!(v2.status == 0, 1);
        let v3 = (0x2::clock::timestamp_ms(arg2) - v2.start_time) / 86400000;
        let v4 = v2.amount * get_daily_interest_rate(v3) * v3 / 10000;
        v2.interest = v4;
        v2.status = 1;
        v0.balance = v0.balance + v4 + v2.amount;
    }

    public fun updateFields<T0>(arg0: &Owner, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut Contract<T0>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NewNetData>(&mut arg7.id, b"newNetData");
        v0.in_sui = arg1;
        v0.out_sui = arg2;
        v0.consume_sui = arg3;
        v0.admin_sui = arg4;
        v0.user_yy = arg5;
        v0.admin_yy = arg6;
    }

    public entry fun withdraw<T0, T1, T2>(arg0: &mut Contract<T1>, arg1: u64, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: &mut 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::Global, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &0x2::clock::Clock, arg9: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg10: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    fun withdrawSui<T0>(arg0: &Vault, arg1: u64, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0x2::clock::Clock, arg7: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<T0>(arg6, arg7, arg2, arg3, arg0.sui_index, arg1, arg4, arg5, &arg0.account_cap), arg8)
    }

    public entry fun withdrawV1<T0, T1, T2>(arg0: &mut Contract<T1>, arg1: u64, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: &mut 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::Global, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: &0x2::clock::Clock, arg9: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = &arg0.vault;
        let v1 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, 0x2::tx_context::sender(arg10));
        assert!(arg1 > 0, 0);
        assert!(v1.balance >= arg1, 1);
        v1.balance = v1.balance - arg1;
        v1.withdrawal_balance = v1.withdrawal_balance + arg1;
        let v2 = arg1 - arg1 * (arg0.withdraw_charges as u64) / 100;
        let v3 = v2 * (arg0.withdraw_ratio as u64) / 100;
        let v4 = v2 - v3;
        let v5 = &arg0.sui_price;
        if (v3 > 0) {
            let v6 = withdrawSui<T0>(v0, preSuiSwap(v5.price, v3), arg4, arg5, arg6, arg7, arg8, arg9, arg10);
            0x2::coin::value<T0>(&v6);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, 0x2::tx_context::sender(arg10));
        };
        if (v4 > 0) {
            let v7 = &mut arg0.yy_balace;
            let v8 = yy_swap_out<T0, T1>(arg3, preSuiSwap(v5.price, v4));
            assert!(v8 <= 0x2::balance::value<T1>(v7), 5);
            let v9 = 0x2::coin::take<T1>(v7, v8, arg10);
            0x2::coin::value<T1>(&v9);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v9, 0x2::tx_context::sender(arg10));
        };
        let v10 = arg1 * (arg0.withdraw_hole_charges as u64) / 100;
        if (v10 > 0) {
            let v11 = withdrawSui<T0>(v0, preSuiSwap(v5.price, v10), arg4, arg5, arg6, arg7, arg8, arg9, arg10);
            0x2::coin::value<T0>(&v11);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v11, @0xf1c047c8d1feb832516c058420c5fc8c823dcfde4e0e311093430c4f38182dd);
        };
        0xe83d324d634acbdc3d9e563b42b079ef6c7c5c0049b0039c7a10431bcbcc6f1c::event::withdraw_event(0x2::tx_context::sender(arg10), arg1, v10, v3, v4, arg0.sui_price.price);
    }

    public entry fun withdrawV2<T0, T1, T2, T3>(arg0: &mut Contract<T1>, arg1: &mut 0xe83d324d634acbdc3d9e563b42b079ef6c7c5c0049b0039c7a10431bcbcc6f1c::yy_balance::YyBalance<T3>, arg2: u64, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg4: &mut 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::Global, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg9: &0x2::clock::Clock, arg10: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = &arg0.vault;
        let v1 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, 0x2::tx_context::sender(arg11));
        assert!(arg2 > 0, 0);
        assert!(v1.balance >= arg2, 1);
        v1.balance = v1.balance - arg2;
        v1.withdrawal_balance = v1.withdrawal_balance + arg2;
        let v2 = arg2 - arg2 * (arg0.withdraw_charges as u64) / 100;
        let v3 = v2 * (arg0.withdraw_ratio as u64) / 100;
        let v4 = v2 - v3;
        let v5 = &arg0.sui_price;
        if (v3 > 0) {
            let v6 = withdrawSui<T0>(v0, preSuiSwap(v5.price, v3), arg5, arg6, arg7, arg8, arg9, arg10, arg11);
            0x2::coin::value<T0>(&v6);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, 0x2::tx_context::sender(arg11));
        };
        if (v4 > 0) {
            0xe83d324d634acbdc3d9e563b42b079ef6c7c5c0049b0039c7a10431bcbcc6f1c::yy_balance::extract_yy<T3>(arg1, 0x2::tx_context::sender(arg11), yy_swap_out<T0, T3>(arg4, preSuiSwap(v5.price, v4)), arg11);
        };
        let v7 = arg2 * (arg0.withdraw_hole_charges as u64) / 100;
        if (v7 > 0) {
            let v8 = withdrawSui<T0>(v0, preSuiSwap(v5.price, v7), arg5, arg6, arg7, arg8, arg9, arg10, arg11);
            0x2::coin::value<T0>(&v8);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v8, @0xf1c047c8d1feb832516c058420c5fc8c823dcfde4e0e311093430c4f38182dd);
        };
        0xe83d324d634acbdc3d9e563b42b079ef6c7c5c0049b0039c7a10431bcbcc6f1c::event::withdraw_event(0x2::tx_context::sender(arg11), arg2, v7, v3, v4, arg0.sui_price.price);
    }

    public entry fun withdrawV3<T0, T1, T2, T3>(arg0: &mut Contract<T1>, arg1: &mut 0xe83d324d634acbdc3d9e563b42b079ef6c7c5c0049b0039c7a10431bcbcc6f1c::yy_balance::YyBalance<T3>, arg2: u64, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg4: &mut 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::Global, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg9: &0x2::clock::Clock, arg10: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = &arg0.vault;
        let v1 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, 0x2::tx_context::sender(arg11));
        assert!(arg2 > 0, 0);
        assert!(v1.balance >= arg2, 1);
        v1.balance = v1.balance - arg2;
        v1.withdrawal_balance = v1.withdrawal_balance + arg2;
        let v2 = arg2 - arg2 * (arg0.withdraw_charges as u64) / 100;
        let v3 = v2 * (arg0.withdraw_ratio as u64) / 100;
        let v4 = v2 - v3;
        let v5 = v4;
        let v6 = &arg0.sui_price;
        if (v3 > 0) {
            let v7 = withdrawSui<T0>(v0, preSuiSwap(v6.price, v3), arg5, arg6, arg7, arg8, arg9, arg10, arg11);
            0x2::coin::value<T0>(&v7);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v7, 0x2::tx_context::sender(arg11));
        };
        if (v4 > 0) {
            let v8 = yy_swap_outV2<T0, T3>(arg4, preSuiSwap(v6.price, v4));
            v5 = v8;
            0xe83d324d634acbdc3d9e563b42b079ef6c7c5c0049b0039c7a10431bcbcc6f1c::yy_balance::extract_yy<T3>(arg1, 0x2::tx_context::sender(arg11), v8, arg11);
        };
        let v9 = arg2 * (arg0.withdraw_hole_charges as u64) / 100;
        if (v9 > 0) {
            let v10 = withdrawSui<T0>(v0, preSuiSwap(v6.price, v9), arg5, arg6, arg7, arg8, arg9, arg10, arg11);
            0x2::coin::value<T0>(&v10);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v10, @0xf1c047c8d1feb832516c058420c5fc8c823dcfde4e0e311093430c4f38182dd);
        };
        0xe83d324d634acbdc3d9e563b42b079ef6c7c5c0049b0039c7a10431bcbcc6f1c::event::withdraw_event(0x2::tx_context::sender(arg11), arg2, v9, v3, v5, arg0.sui_price.price);
    }

    public fun yy_swap_out<T0, T1>(arg0: &mut 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::Global, arg1: u64) : u64 {
        if (arg1 <= 0) {
            0
        } else {
            let (v1, v2, _) = 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::interface::getLpliquidity<T0, T1>(arg0);
            arg1 * v2 / v1
        }
    }

    public fun yy_swap_outV2<T0, T1>(arg0: &mut 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::implements::Global, arg1: u64) : u64 {
        if (arg1 <= 0) {
            0
        } else {
            let (v1, v2, _) = 0x68114ffc0a0d7c4a582b4494d2370205a23d93e96b9ef6a750d0ba5f8f52b7db::interface::getLpliquidity<T0, T1>(arg0);
            arg1 * v1 / v2
        }
    }

    // decompiled from Move bytecode v6
}

