module 0x6ff797266f894bbf4ea2c69ae4c84a09e4d9e1c6ff76b03a07a7e099a185ace0::newapp {
    struct User has store {
        id: 0x2::object::UID,
        balance: u64,
        withdrawal_balance: u64,
    }

    struct SuiPrice has store {
        id: 0x2::object::UID,
        price: u64,
        timestamp: u64,
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
        withdraw_ratio: u8,
        pay_ratio: u8,
        vault: Vault,
        sui_price: SuiPrice,
        admin: address,
        rebot: address,
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

    fun swap<T0, T1>(arg0: &mut 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::Global, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::interface::swapCoin<T0, T1>(arg0, arg1, 0, arg2)
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
            };
            0x2::table::add<address, User>(v1, v0, v2);
        };
    }

    public fun debug<T0, T1>(arg0: &mut Contract<T1>, arg1: address, arg2: u64, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &0x2::clock::Clock, arg8: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg9: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    fun deposit<T0>(arg0: &Vault, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0x2::clock::Clock) {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T0>(arg6, arg2, arg3, arg0.sui_index, arg1, arg4, arg5, &arg0.account_cap);
    }

    public fun extract_sui_new<T0, T1>(arg0: &mut Contract<T1>, arg1: address, arg2: u64, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &0x2::clock::Clock, arg8: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg9: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun extract_sui_newV1<T0, T1>(arg0: &mut Contract<T1>, arg1: address, arg2: u64, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &0x2::clock::Clock, arg8: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg9), 201);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(withdrawSui<T0>(&mut arg0.vault, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9), arg1);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NewNetData>(&mut arg0.id, b"newNetData");
        v0.admin_sui = v0.admin_sui + arg2;
    }

    public fun extract_yy<T0>(arg0: &mut Contract<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 201);
        let v0 = &mut arg0.yy_balace;
        assert!(0x2::balance::value<T0>(v0) >= arg2, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(v0, arg2, arg3), arg1);
        let v1 = 0x2::dynamic_field::borrow_mut<vector<u8>, NewNetData>(&mut arg0.id, b"newNetData");
        v1.admin_yy = v1.admin_yy + arg2;
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

    public fun get_amount<T0>(arg0: &Contract<T0>, arg1: u64) : u64 {
        let v0 = &arg0.sui_price;
        if (arg1 == 0 || v0.price == 0) {
            return 0
        };
        arg1 * 1000 * 1000000 / v0.price
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
            id               : 0x2::object::new(arg1),
            users            : 0x2::table::new<address, User>(arg1),
            user_list        : vector[],
            yy_balace        : 0x2::balance::zero<T0>(),
            withdraw_charges : 10,
            withdraw_ratio   : 80,
            pay_ratio        : 100,
            vault            : v0,
            sui_price        : v1,
            admin            : @0xfec2432232f6a7a9dd1fdbdab5d44ec0ecf6ca104cdee0e7f0adc66c3bff2e61,
            rebot            : @0xff1a28d522a7403932b95c249ad341a91b51e4633f0ee7e62149fdfe624d30e1,
        };
        let v3 = User{
            id                 : 0x2::object::new(arg1),
            balance            : 0,
            withdrawal_balance : 0,
        };
        0x1::vector::push_back<address>(&mut v2.user_list, @0xff1a28d522a7403932b95c249ad341a91b51e4633f0ee7e62149fdfe624d30e1);
        0x2::table::add<address, User>(&mut v2.users, @0xff1a28d522a7403932b95c249ad341a91b51e4633f0ee7e62149fdfe624d30e1, v3);
        0x2::transfer::share_object<Contract<T0>>(v2);
    }

    public fun preSuiSwap(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0 || arg0 == 0) {
            return 0
        };
        arg1 * 1000 * 1000000 / arg0
    }

    public fun preSwap<T0>(arg0: &Contract<T0>, arg1: u64) : u64 {
        let v0 = &arg0.sui_price;
        if (arg1 == 0 || v0.price == 0) {
            return 0
        };
        arg1 * 1000 * 1000000 / v0.price
    }

    public entry fun purchase<T0, T1, T2>(arg0: &mut Contract<T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg5: &mut 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::Global, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun purchaseV1<T0, T1, T2>(arg0: &mut Contract<T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg5: &mut 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::Global, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        bindInviter<T1>(arg0, arg11);
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = &mut arg0.users;
        let v2 = &mut arg0.vault;
        assert!(arg3 >= 100000000, 3);
        assert!(0x2::table::contains<address, User>(v1, v0), 4);
        0x2::table::borrow_mut<address, User>(v1, v0);
        let v3 = arg0.pay_ratio;
        assert!(v3 >= 0 && v3 <= 100, 3);
        let v4 = &arg0.sui_price;
        let v5 = 0;
        if (v3 > 0) {
            let v6 = 0x2::coin::value<T0>(&arg1);
            v5 = v6;
            assert!(v6 >= preSuiSwap(v4.price, arg3 * (v3 as u64) / 100), 4);
            deposit<T0>(v2, arg1, arg6, arg7, arg8, arg9, arg10);
            let v7 = 0x2::dynamic_field::borrow_mut<vector<u8>, NewNetData>(&mut arg0.id, b"newNetData");
            v7.in_sui = v7.in_sui + v6;
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        };
        let v8 = 100 - v3;
        let v9 = 0;
        if (v8 > 0) {
            let v10 = 0x2::coin::value<T1>(&arg2);
            v9 = v10;
            assert!(v10 >= yy_swap_out<T0, T1>(arg5, preSuiSwap(v4.price, arg3 * (v8 as u64) / 100)), 4);
        };
        0x2::balance::join<T1>(&mut arg0.yy_balace, 0x2::coin::into_balance<T1>(arg2));
        0x6ff797266f894bbf4ea2c69ae4c84a09e4d9e1c6ff76b03a07a7e099a185ace0::event::purchase_event(v0, arg3, arg0.sui_price.price, v5, v9);
    }

    public fun recharge_sui<T0, T1>(arg0: &mut Contract<T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun recharge_yy<T0>(arg0: &mut Contract<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 201);
        0x2::balance::join<T0>(&mut arg0.yy_balace, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun removeFields<T0>(arg0: &Owner, arg1: &mut Contract<T0>, arg2: &mut 0x2::tx_context::TxContext) : NewNetData {
        0x2::dynamic_field::remove<vector<u8>, NewNetData>(&mut arg1.id, b"newNetData")
    }

    public fun setRebot<T0>(arg0: &Owner, arg1: &mut Contract<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.rebot = arg2;
    }

    public fun set_balance<T0>(arg0: &mut Contract<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 201);
        0x2::table::borrow_mut<address, User>(&mut arg0.users, arg1).balance = arg2;
    }

    public entry fun set_pay_ratio<T0>(arg0: &mut Contract<T0>, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 201);
        arg0.pay_ratio = arg1;
    }

    public entry fun set_price<T0>(arg0: &mut Contract<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 201);
        let v0 = &mut arg0.sui_price;
        v0.price = arg1;
        v0.timestamp = arg2;
    }

    public entry fun set_withdraw_conf<T0>(arg0: &mut Contract<T0>, arg1: u8, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 201);
        arg0.withdraw_charges = arg1;
        arg0.withdraw_ratio = arg2;
    }

    public fun setadmin<T0>(arg0: &Owner, arg1: &mut Contract<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.admin = arg2;
    }

    public fun transter_owner(arg0: Owner, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<Owner>(arg0, arg1);
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
        let v2 = arg1 * (arg0.withdraw_charges as u64) / 100;
        let v3 = arg1 - v2;
        let v4 = v3 * (arg0.withdraw_ratio as u64) / 100;
        let v5 = v3 - v4;
        let v6 = &arg0.sui_price;
        let v7 = 0x2::dynamic_field::borrow_mut<vector<u8>, NewNetData>(&mut arg0.id, b"newNetData");
        let v8 = 0x2::table::borrow_mut<address, u64>(&mut v7.user_table, 0x2::tx_context::sender(arg10));
        *v8 = *v8 + arg1;
        if (v4 > 0) {
            let v9 = withdrawSui<T0>(v0, preSuiSwap(v6.price, v4), arg4, arg5, arg6, arg7, arg8, arg9, arg10);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v9, 0x2::tx_context::sender(arg10));
            v7.out_sui = v7.out_sui + 0x2::coin::value<T0>(&v9);
        };
        if (v5 > 0) {
            let v10 = &mut arg0.yy_balace;
            let v11 = yy_swap_out<T0, T1>(arg3, preSuiSwap(v6.price, v5));
            assert!(v11 <= 0x2::balance::value<T1>(v10), 5);
            let v12 = 0x2::coin::take<T1>(v10, v11, arg10);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v12, 0x2::tx_context::sender(arg10));
            v7.user_yy = v7.user_yy + 0x2::coin::value<T1>(&v12);
        };
        let v13 = v2 / 2;
        if (v13 > 0) {
            let v14 = withdrawSui<T0>(v0, preSuiSwap(v6.price, v13), arg4, arg5, arg6, arg7, arg8, arg9, arg10);
            let v15 = 0x2::coin::value<T0>(&v14);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v14, @0xfec2432232f6a7a9dd1fdbdab5d44ec0ecf6ca104cdee0e7f0adc66c3bff2e61);
            v7.out_sui = v7.out_sui + v15;
            v7.consume_sui = v7.consume_sui + v15;
        };
        0x6ff797266f894bbf4ea2c69ae4c84a09e4d9e1c6ff76b03a07a7e099a185ace0::event::withdraw_event(0x2::tx_context::sender(arg10), arg1, v13, v4, v5, arg0.sui_price.price);
    }

    public fun yy_swap_out<T0, T1>(arg0: &mut 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::implements::Global, arg1: u64) : u64 {
        if (arg1 <= 0) {
            0
        } else {
            let (v1, v2, _) = 0xdfbcc2225b98c4a483762b8dfe0df367921bf00108d420371839b55af6ca9e89::interface::getLpliquidity<T0, T1>(arg0);
            arg1 * v2 / v1
        }
    }

    // decompiled from Move bytecode v6
}

