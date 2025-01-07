module 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap {
    struct Created_Pool_Event has copy, drop {
        pool_id: 0x2::object::ID,
        creator: address,
        token_x_name: 0x1::string::String,
        token_y_name: 0x1::string::String,
        token_x_amount_in: u64,
        token_y_amount_in: u64,
        lsp_balance: u64,
    }

    struct Add_Liquidity_Pool has copy, drop {
        pool_id: 0x2::object::ID,
        user: address,
        token_x_name: 0x1::string::String,
        token_y_name: 0x1::string::String,
        token_x_amount_in: u64,
        token_y_amount_in: u64,
        lsp_balance: u64,
        fee_amount: u64,
    }

    struct Remove_Liqidity_Pool has copy, drop {
        pool_id: 0x2::object::ID,
        user: address,
        token_x_name: 0x1::string::String,
        token_y_name: 0x1::string::String,
        token_x_amount_out: u64,
        token_y_amount_out: u64,
        fee_amount: u64,
    }

    struct Swap_Event<phantom T0, phantom T1> has copy, drop {
        pool_id: 0x2::object::ID,
        user: address,
        token_x_in: 0x1::string::String,
        amount_x_in: u64,
        token_y_in: 0x1::string::String,
        amount_y_in: u64,
        token_x_out: 0x1::string::String,
        amount_x_out: u64,
        token_y_out: 0x1::string::String,
        amount_y_out: u64,
    }

    struct Freeze_Event has copy, drop {
        pool_id: 0x2::object::ID,
        token_x_in: 0x1::string::String,
        token_y_out: 0x1::string::String,
        lsp_balance: u64,
        is_freeze: bool,
    }

    struct LSP<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        creator: address,
        token_x: 0x2::balance::Balance<T0>,
        token_y: 0x2::balance::Balance<T1>,
        lsp_supply: 0x2::balance::Supply<LSP<T0, T1>>,
        fee_amount: 0x2::balance::Balance<LSP<T0, T1>>,
        fee_x: 0x2::balance::Balance<T0>,
        fee_y: 0x2::balance::Balance<T1>,
        minimum_liq: 0x2::balance::Balance<LSP<T0, T1>>,
        k_last: u128,
        reserve_x: u64,
        reserve_y: u64,
        is_freeze: bool,
    }

    struct Dex_Info has store, key {
        id: 0x2::object::UID,
        fee_to: address,
        dev: address,
        total_pool_created: u64,
    }

    fun swap<T0, T1>(arg0: u64, arg1: u64, arg2: &mut Pool<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(arg0 > 0 || arg1 > 0, 13);
        assert!(arg0 < arg2.reserve_x && arg1 < arg2.reserve_y, 7);
        let v0 = 0x2::coin::zero<T0>(arg3);
        let v1 = 0x2::coin::zero<T1>(arg3);
        if (arg0 > 0) {
            0x2::coin::join<T0>(&mut v0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.token_x, arg0), arg3));
        };
        if (arg1 > 0) {
            0x2::coin::join<T1>(&mut v1, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg2.token_y, arg1), arg3));
        };
        let (v2, v3) = token_balances<T0, T1>(arg2);
        let v4 = if (v2 > arg2.reserve_x - arg0) {
            v2 - arg2.reserve_x - arg0
        } else {
            0
        };
        let v5 = if (v3 > arg2.reserve_y - arg1) {
            v3 - arg2.reserve_y - arg1
        } else {
            0
        };
        assert!(v4 > 0 || v5 > 0, 14);
        let v6 = (10000 as u128);
        let v7 = (v2 as u128) * v6 - (v4 as u128) * 20;
        let v8 = (v3 as u128) * v6 - (v5 as u128) * 20;
        let v9 = (arg2.reserve_x as u128) * v6;
        let v10 = (arg2.reserve_y as u128) * v6;
        let v11 = if (v7 > 0 && v9 > 0 && 340282366920938463463374607431768211455 / v7 > v8 && 340282366920938463463374607431768211455 / v9 > v10) {
            v7 * v8 >= v9 * v10
        } else {
            let v12 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::u256::mul_u128(v7, v8);
            let v13 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::u256::mul_u128(v9, v10);
            0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::u256::ge(&v12, &v13)
        };
        assert!(v11, 15);
        update<T0, T1>(v2, v3, arg2);
        (v0, v1)
    }

    public(friend) fun add_liquidity<T0, T1>(arg0: u64, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &mut Pool<T0, T1>, arg5: &mut 0x2::tx_context::TxContext) : (u64, u64, u64) {
        assert!(!arg4.is_freeze, 24);
        assert_input_amount<T0>(arg0, &arg2);
        assert_input_amount<T1>(arg1, &arg3);
        let (v0, v1, v2, v3, v4, v5) = add_liquidity_direct<T0, T1>(arg2, arg3, arg4, arg5);
        let v6 = v5;
        let v7 = v4;
        let v8 = v2;
        let v9 = 0x2::tx_context::sender(arg5);
        let v10 = 0x2::coin::value<LSP<T0, T1>>(&v8);
        assert!(v10 > 0, 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<LSP<T0, T1>>>(v8, v9);
        if (0x2::coin::value<T0>(&v7) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v7, v9);
        } else {
            0x2::coin::destroy_zero<T0>(v7);
        };
        if (0x2::coin::value<T1>(&v6) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v6, v9);
        } else {
            0x2::coin::destroy_zero<T1>(v6);
        };
        let v11 = Add_Liquidity_Pool{
            pool_id           : 0x2::object::uid_to_inner(&arg4.id),
            user              : v9,
            token_x_name      : 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::get_token_name<T0>(),
            token_y_name      : 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::get_token_name<T1>(),
            token_x_amount_in : v0,
            token_y_amount_in : v1,
            lsp_balance       : v10,
            fee_amount        : v3,
        };
        0x2::event::emit<Add_Liquidity_Pool>(v11);
        (v0, v1, v10)
    }

    fun add_liquidity_direct<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &mut Pool<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) : (u64, u64, 0x2::coin::Coin<LSP<T0, T1>>, u64, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0x2::coin::value<T1>(&arg1);
        let (v2, v3) = if (arg2.reserve_x == 0 && arg2.reserve_y == 0) {
            (v0, v1)
        } else {
            let v4 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::quote(v0, arg2.reserve_x, arg2.reserve_y);
            if (v4 <= v1) {
                (v0, v4)
            } else {
                let v5 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::quote(v1, arg2.reserve_y, arg2.reserve_x);
                assert!(v5 <= v0, 8);
                (v5, v1)
            }
        };
        assert!(v2 <= v0, 6);
        assert!(v3 <= v1, 6);
        let v6 = 0x2::coin::split<T0>(&mut arg0, v0 - v2, arg3);
        let v7 = 0x2::coin::split<T1>(&mut arg1, v1 - v3, arg3);
        0x2::balance::join<T0>(&mut arg2.token_x, 0x2::coin::into_balance<T0>(arg0));
        0x2::balance::join<T1>(&mut arg2.token_y, 0x2::coin::into_balance<T1>(arg1));
        let (v8, v9) = mint<T0, T1>(arg2, arg3);
        (v2, v3, v8, v9, v6, v7)
    }

    public(friend) fun add_liquidity_returns<T0, T1>(arg0: u64, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &mut Pool<T0, T1>, arg5: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<LSP<T0, T1>>) {
        assert!(!arg4.is_freeze, 24);
        assert_input_amount<T0>(arg0, &arg2);
        assert_input_amount<T1>(arg1, &arg3);
        let (v0, v1, v2, v3, v4, v5) = add_liquidity_direct<T0, T1>(arg2, arg3, arg4, arg5);
        let v6 = v2;
        let v7 = 0x2::coin::value<LSP<T0, T1>>(&v6);
        assert!(v7 > 0, 7);
        let v8 = Add_Liquidity_Pool{
            pool_id           : 0x2::object::uid_to_inner(&arg4.id),
            user              : 0x2::tx_context::sender(arg5),
            token_x_name      : 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::get_token_name<T0>(),
            token_y_name      : 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::get_token_name<T1>(),
            token_x_amount_in : v0,
            token_y_amount_in : v1,
            lsp_balance       : v7,
            fee_amount        : v3,
        };
        0x2::event::emit<Add_Liquidity_Pool>(v8);
        (v0, v1, v7, v4, v5, v6)
    }

    public fun add_swap_event_internal<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: &mut Dex_Info, arg5: &mut 0x2::tx_context::TxContext) {
        add_swap_event_with_address_internal<T0, T1>(0x2::tx_context::sender(arg5), arg0, arg1, arg2, arg3, arg4);
    }

    public fun add_swap_event_with_address<T0, T1>(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut Pool<T0, T1>) {
        let v0 = Swap_Event<T0, T1>{
            pool_id      : 0x2::object::uid_to_inner(&arg5.id),
            user         : arg0,
            token_x_in   : 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::get_token_name<T0>(),
            amount_x_in  : arg1,
            token_y_in   : 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::get_token_name<T1>(),
            amount_y_in  : arg2,
            token_x_out  : 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::get_token_name<T0>(),
            amount_x_out : arg3,
            token_y_out  : 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::get_token_name<T1>(),
            amount_y_out : arg4,
        };
        0x2::event::emit<Swap_Event<T0, T1>>(v0);
    }

    fun add_swap_event_with_address_internal<T0, T1>(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut Dex_Info) {
        if (0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::sort_token_type<T0, T1>()) {
            let v0 = get_pool<T0, T1>(arg5);
            add_swap_event_with_address<T0, T1>(arg0, arg1, arg2, arg3, arg4, v0);
        } else {
            let v1 = get_pool<T1, T0>(arg5);
            add_swap_event_with_address<T1, T0>(arg0, arg2, arg1, arg4, arg3, v1);
        };
    }

    public fun assert_input_amount<T0>(arg0: u64, arg1: &0x2::coin::Coin<T0>) {
        assert!(0x2::coin::value<T0>(arg1) == arg0, 14);
    }

    fun burn<T0, T1>(arg0: 0x2::coin::Coin<LSP<T0, T1>>, arg1: &mut Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, u64) {
        let v0 = 0x2::balance::value<T0>(&arg1.token_x);
        let v1 = 0x2::balance::value<T1>(&arg1.token_y);
        let v2 = 0x2::coin::value<LSP<T0, T1>>(&arg0);
        assert!(v2 > 0, 7);
        let v3 = mint_fee<T0, T1>(arg1);
        let v4 = 0x2::balance::supply_value<LSP<T0, T1>>(&arg1.lsp_supply);
        let v5 = (((v0 as u128) * (v2 as u128) / (v4 as u128)) as u64);
        let v6 = (((v1 as u128) * (v2 as u128) / (v4 as u128)) as u64);
        assert!(v5 > 0 && v6 > 0, 10);
        0x2::balance::decrease_supply<LSP<T0, T1>>(&mut arg1.lsp_supply, 0x2::coin::into_balance<LSP<T0, T1>>(arg0));
        let v7 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.token_x, v5), arg2);
        let v8 = 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.token_y, v6), arg2);
        let v9 = 0x2::balance::value<T0>(&arg1.token_x);
        let v10 = 0x2::balance::value<T1>(&arg1.token_y);
        update<T0, T1>(v9, v10, arg1);
        arg1.k_last = (arg1.reserve_x as u128) * (arg1.reserve_y as u128);
        (v7, v8, v3)
    }

    public fun check_pool_exist<T0, T1>(arg0: &Dex_Info) : bool {
        0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::get_lp_name<T0, T1>())
    }

    public(friend) fun create_new_pool<T0, T1>(arg0: &mut Dex_Info, arg1: &mut 0x2::tx_context::TxContext) {
        if (0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::sort_token_type<T0, T1>()) {
            create_pool_internal<T0, T1>(arg0, arg1);
        } else {
            create_pool_internal<T1, T0>(arg0, arg1);
        };
    }

    public entry fun create_new_pool_admin<T0, T1>(arg0: &mut Dex_Info, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.dev, 17);
        if (0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::sort_token_type<T0, T1>()) {
            create_pool_internal<T0, T1>(arg0, arg1);
        } else {
            create_pool_internal<T1, T0>(arg0, arg1);
        };
    }

    fun create_pool_internal<T0, T1>(arg0: &mut Dex_Info, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::get_lp_name<T0, T1>();
        assert!(!0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, v0), 1);
        let v1 = 0x2::tx_context::sender(arg1);
        let v2 = LSP<T0, T1>{dummy_field: false};
        let v3 = 0x2::object::new(arg1);
        let v4 = Pool<T0, T1>{
            id          : v3,
            creator     : v1,
            token_x     : 0x2::balance::zero<T0>(),
            token_y     : 0x2::balance::zero<T1>(),
            lsp_supply  : 0x2::balance::create_supply<LSP<T0, T1>>(v2),
            fee_amount  : 0x2::balance::zero<LSP<T0, T1>>(),
            fee_x       : 0x2::balance::zero<T0>(),
            fee_y       : 0x2::balance::zero<T1>(),
            minimum_liq : 0x2::balance::zero<LSP<T0, T1>>(),
            k_last      : 0,
            reserve_x   : 0,
            reserve_y   : 0,
            is_freeze   : false,
        };
        arg0.total_pool_created = arg0.total_pool_created + 1;
        0x2::dynamic_object_field::add<0x1::string::String, Pool<T0, T1>>(&mut arg0.id, v0, v4);
        let v5 = Created_Pool_Event{
            pool_id           : 0x2::object::uid_to_inner(&v3),
            creator           : v1,
            token_x_name      : 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::get_token_name<T0>(),
            token_y_name      : 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::get_token_name<T1>(),
            token_x_amount_in : 0,
            token_y_amount_in : 0,
            lsp_balance       : 0,
        };
        0x2::event::emit<Created_Pool_Event>(v5);
    }

    public entry fun freeze_pool<T0, T1>(arg0: bool, arg1: &mut Dex_Info, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.dev, 17);
        if (0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::sort_token_type<T0, T1>()) {
            let v0 = get_pool<T0, T1>(arg1);
            v0.is_freeze = arg0;
            let v1 = Freeze_Event{
                pool_id     : 0x2::object::uid_to_inner(&v0.id),
                token_x_in  : 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::get_token_name<T0>(),
                token_y_out : 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::get_token_name<T1>(),
                lsp_balance : 0x2::balance::supply_value<LSP<T0, T1>>(&v0.lsp_supply),
                is_freeze   : arg0,
            };
            0x2::event::emit<Freeze_Event>(v1);
        } else {
            let v2 = get_pool<T1, T0>(arg1);
            v2.is_freeze = arg0;
            let v3 = Freeze_Event{
                pool_id     : 0x2::object::uid_to_inner(&v2.id),
                token_x_in  : 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::get_token_name<T1>(),
                token_y_out : 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::get_token_name<T0>(),
                lsp_balance : 0x2::balance::supply_value<LSP<T1, T0>>(&v2.lsp_supply),
                is_freeze   : arg0,
            };
            0x2::event::emit<Freeze_Event>(v3);
        };
    }

    public fun get_amounts<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.token_x), 0x2::balance::value<T1>(&arg0.token_y), 0x2::balance::supply_value<LSP<T0, T1>>(&arg0.lsp_supply))
    }

    public fun get_pool<T0, T1>(arg0: &mut Dex_Info) : &mut Pool<T0, T1> {
        assert!(check_pool_exist<T0, T1>(arg0), 23);
        0x2::dynamic_object_field::borrow_mut<0x1::string::String, Pool<T0, T1>>(&mut arg0.id, 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::get_lp_name<T0, T1>())
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg0);
        let v0 = Dex_Info{
            id                 : 0x2::object::new(arg0),
            fee_to             : @0x85bf745a737a34bf73f360c22d5c8aea1f1767f3c458f5269a7c2f821b9d3781,
            dev                : @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1,
            total_pool_created : 0,
        };
        0x2::transfer::public_share_object<Dex_Info>(v0);
    }

    fun mint<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<LSP<T0, T1>>, u64) {
        let v0 = 0x2::balance::value<T0>(&arg0.token_x);
        let v1 = 0x2::balance::value<T1>(&arg0.token_y);
        let v2 = (v0 as u128) - (arg0.reserve_x as u128);
        let v3 = (v1 as u128) - (arg0.reserve_y as u128);
        let v4 = mint_fee<T0, T1>(arg0);
        let v5 = (0x2::balance::supply_value<LSP<T0, T1>>(&arg0.lsp_supply) as u128);
        let v6 = if (v5 == 0) {
            let v7 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::math::sqrt(v2 * v3);
            assert!(v7 > 1000, 4);
            0x2::balance::join<LSP<T0, T1>>(&mut arg0.minimum_liq, 0x2::balance::increase_supply<LSP<T0, T1>>(&mut arg0.lsp_supply, (1000 as u64)));
            v7 - 1000
        } else {
            let v8 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::math::min(v2 * v5 / (arg0.reserve_x as u128), v3 * v5 / (arg0.reserve_y as u128));
            assert!(v8 > 0, 4);
            v8
        };
        let v9 = 0x2::coin::from_balance<LSP<T0, T1>>(0x2::balance::increase_supply<LSP<T0, T1>>(&mut arg0.lsp_supply, (v6 as u64)), arg1);
        update<T0, T1>(v0, v1, arg0);
        arg0.k_last = (arg0.reserve_x as u128) * (arg0.reserve_y as u128);
        (v9, v4)
    }

    fun mint_fee<T0, T1>(arg0: &mut Pool<T0, T1>) : u64 {
        let v0 = 0;
        if (arg0.k_last != 0) {
            let v1 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::math::sqrt((arg0.reserve_x as u128) * (arg0.reserve_y as u128));
            let v2 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::math::sqrt(arg0.k_last);
            if (v1 > v2) {
                let v3 = (((0x2::balance::supply_value<LSP<T0, T1>>(&arg0.lsp_supply) as u128) * (v1 - v2) * 10 / (v2 * 20 + v1 * 10)) as u64);
                v0 = v3;
                if (v3 > 0) {
                    0x2::balance::join<LSP<T0, T1>>(&mut arg0.fee_amount, 0x2::balance::increase_supply<LSP<T0, T1>>(&mut arg0.lsp_supply, v3));
                };
            };
        };
        v0
    }

    public(friend) fun remove_liquidity<T0, T1>(arg0: u64, arg1: 0x2::coin::Coin<LSP<T0, T1>>, arg2: &mut Pool<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        assert!(!arg2.is_freeze, 24);
        assert!(0x2::coin::value<LSP<T0, T1>>(&arg1) == arg0, 14);
        let (v0, v1, v2) = remove_liquidity_direct<T0, T1>(arg1, arg2, arg3);
        let v3 = v1;
        let v4 = v0;
        let v5 = 0x2::coin::value<T0>(&v4);
        let v6 = 0x2::coin::value<T1>(&v3);
        let v7 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, v7);
        let v8 = Remove_Liqidity_Pool{
            pool_id            : 0x2::object::uid_to_inner(&arg2.id),
            user               : v7,
            token_x_name       : 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::get_token_name<T0>(),
            token_y_name       : 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::get_token_name<T1>(),
            token_x_amount_out : v5,
            token_y_amount_out : v6,
            fee_amount         : v2,
        };
        0x2::event::emit<Remove_Liqidity_Pool>(v8);
        (v5, v6)
    }

    fun remove_liquidity_direct<T0, T1>(arg0: 0x2::coin::Coin<LSP<T0, T1>>, arg1: &mut Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, u64) {
        burn<T0, T1>(arg0, arg1, arg2)
    }

    public entry fun set_fee_to(arg0: &mut Dex_Info, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.dev, 17);
        arg0.fee_to = arg1;
    }

    public(friend) fun swap_exact_x_to_y<T0, T1>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: &mut Pool<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T1>) {
        assert!(!arg3.is_freeze, 24);
        assert_input_amount<T0>(arg0, &arg1);
        let (v0, v1) = swap_exact_x_to_y_direct<T0, T1>(arg1, arg3, arg4);
        let v2 = v1;
        0x2::coin::destroy_zero<T0>(v0);
        (0x2::coin::value<T1>(&v2), v2)
    }

    public(friend) fun swap_exact_x_to_y_direct<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = v0 * 10 / 10000;
        0x2::balance::join<T0>(&mut arg1.fee_x, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg0, v1, arg2)));
        0x2::balance::join<T0>(&mut arg1.token_x, 0x2::coin::into_balance<T0>(arg0));
        let (v2, v3) = token_reserves<T0, T1>(arg1);
        let (v4, v5) = swap<T0, T1>(0, 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::get_amount_out(v0 - v1, v2, v3), arg1, arg2);
        let v6 = v4;
        assert!(0x2::coin::value<T0>(&v6) == 0, 13);
        (v6, v5)
    }

    public(friend) fun swap_exact_y_to_x<T0, T1>(arg0: u64, arg1: 0x2::coin::Coin<T1>, arg2: &mut Pool<T0, T1>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T0>) {
        assert!(!arg2.is_freeze, 24);
        assert_input_amount<T1>(arg0, &arg1);
        let (v0, v1) = swap_exact_y_to_x_direct<T0, T1>(arg1, arg2, arg4);
        let v2 = v0;
        0x2::coin::destroy_zero<T1>(v1);
        (0x2::coin::value<T0>(&v2), v2)
    }

    public(friend) fun swap_exact_y_to_x_direct<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T1>(&arg0);
        let v1 = v0 * 10 / 10000;
        0x2::balance::join<T1>(&mut arg1.fee_y, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg0, v1, arg2)));
        0x2::balance::join<T1>(&mut arg1.token_y, 0x2::coin::into_balance<T1>(arg0));
        let (v2, v3) = token_reserves<T0, T1>(arg1);
        let (v4, v5) = swap<T0, T1>(0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::get_amount_out(v0 - v1, v3, v2), 0, arg1, arg2);
        let v6 = v5;
        assert!(0x2::coin::value<T1>(&v6) == 0, 13);
        (v4, v6)
    }

    public(friend) fun swap_x_to_exact_y<T0, T1>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: address, arg4: &mut Pool<T0, T1>, arg5: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T1>) {
        assert!(!arg4.is_freeze, 24);
        assert_input_amount<T0>(arg0, &arg1);
        let (v0, v1) = swap_x_to_exact_y_direct<T0, T1>(arg1, arg2, arg4, arg5);
        0x2::coin::destroy_zero<T0>(v0);
        (arg0, v1)
    }

    public(friend) fun swap_x_to_exact_y_direct<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut Pool<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::into_balance<T0>(arg0);
        0x2::balance::join<T0>(&mut arg2.fee_x, 0x2::balance::split<T0>(&mut v0, 0x2::balance::value<T0>(&v0) * 10 / 10000));
        0x2::balance::join<T0>(&mut arg2.token_x, v0);
        let (v1, v2) = swap<T0, T1>(0, arg1, arg2, arg3);
        let v3 = v1;
        assert!(0x2::coin::value<T0>(&v3) == 0, 13);
        (v3, v2)
    }

    public(friend) fun swap_y_to_exact_x<T0, T1>(arg0: u64, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: address, arg4: &mut Pool<T0, T1>, arg5: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T0>) {
        assert!(!arg4.is_freeze, 24);
        assert_input_amount<T1>(arg0, &arg1);
        let (v0, v1) = swap_y_to_exact_x_direct<T0, T1>(arg1, arg2, arg4, arg5);
        0x2::coin::destroy_zero<T1>(v1);
        (arg0, v0)
    }

    public(friend) fun swap_y_to_exact_x_direct<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: u64, arg2: &mut Pool<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x2::balance::join<T1>(&mut arg2.fee_y, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg0, 0x2::coin::value<T1>(&arg0) * 10 / 10000, arg3)));
        0x2::balance::join<T1>(&mut arg2.token_y, 0x2::coin::into_balance<T1>(arg0));
        let (v0, v1) = swap<T0, T1>(arg1, 0, arg2, arg3);
        let v2 = v1;
        assert!(0x2::coin::value<T1>(&v2) == 0, 13);
        (v0, v2)
    }

    public fun token_balances<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.token_x), 0x2::balance::value<T1>(&arg0.token_y))
    }

    public fun token_reserves<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (arg0.reserve_x, arg0.reserve_y)
    }

    fun transfer_withdraw_fee<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::math::mul_div(0x2::balance::value<LSP<T0, T1>>(&arg0.fee_amount), arg1, 10000);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<LSP<T0, T1>>>(0x2::coin::from_balance<LSP<T0, T1>>(0x2::balance::split<LSP<T0, T1>>(&mut arg0.fee_amount, v0), arg3), arg2);
        };
        let v1 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::math::mul_div(0x2::balance::value<T0>(&arg0.fee_x), arg1, 10000);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.fee_x, v1), arg3), arg2);
        };
        let v2 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::math::mul_div(0x2::balance::value<T1>(&arg0.fee_y), arg1, 10000);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.fee_y, v2), arg3), arg2);
        };
    }

    fun update<T0, T1>(arg0: u64, arg1: u64, arg2: &mut Pool<T0, T1>) {
        arg2.reserve_x = arg0;
        arg2.reserve_y = arg1;
    }

    public entry fun withdraw_fee<T0, T1>(arg0: &mut Dex_Info, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.fee_to || v0 == arg0.dev || v0 == @0x9c8c8293866415a0b631a87e7b2ff960c65c9a497945df83827dfacb69627123 || v0 == @0x97a745334d470988140336826a83ec47a44714635e376ca705bbf10381223213, 17);
        if (0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::sort_token_type<T0, T1>()) {
            let v1 = get_pool<T0, T1>(arg0);
            if (v0 == @0x9c8c8293866415a0b631a87e7b2ff960c65c9a497945df83827dfacb69627123) {
                transfer_withdraw_fee<T0, T1>(v1, 3000, v0, arg1);
            } else if (v0 == @0x97a745334d470988140336826a83ec47a44714635e376ca705bbf10381223213) {
                transfer_withdraw_fee<T0, T1>(v1, 2000, v0, arg1);
            } else {
                transfer_withdraw_fee<T0, T1>(v1, 10000, v0, arg1);
            };
        } else {
            let v2 = get_pool<T1, T0>(arg0);
            if (v0 == @0x9c8c8293866415a0b631a87e7b2ff960c65c9a497945df83827dfacb69627123) {
                transfer_withdraw_fee<T1, T0>(v2, 3000, v0, arg1);
            } else if (v0 == @0x97a745334d470988140336826a83ec47a44714635e376ca705bbf10381223213) {
                transfer_withdraw_fee<T1, T0>(v2, 2000, v0, arg1);
            } else {
                transfer_withdraw_fee<T1, T0>(v2, 10000, v0, arg1);
            };
        };
    }

    public fun withdraw_fee_<T0, T1>(arg0: u64, arg1: &mut Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun withdraw_fee_direct<T0, T1>(arg0: u64, arg1: &mut Dex_Info, arg2: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

