module 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool {
    struct CreatePoolCap<phantom T0> has key {
        id: 0x2::object::UID,
        lp_treasury_cap: 0x2::coin::TreasuryCap<T0>,
        lp_coin_metadata: 0x2::coin::CoinMetadata<T0>,
    }

    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        creator: address,
        lp_supply: 0x2::balance::Supply<T0>,
        illiquid_lp_supply: 0x2::balance::Balance<T0>,
        type_names: vector<0x1::ascii::String>,
        balances: vector<u64>,
        weights: vector<u64>,
        flatness: u64,
        fees_swap_in: vector<u64>,
        fees_swap_out: vector<u64>,
        fees_deposit: vector<u64>,
        fees_withdraw: vector<u64>,
    }

    public(friend) fun join<T0, T1>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T1>) {
        let v0 = 0x1::vector::borrow_mut<u64>(&mut arg0.balances, type_to_index<T0, T1>(arg0));
        *v0 = *v0 + 0x2::coin::value<T1>(&arg1);
        0x2::coin::put<T1>(borrow_mut_balance<T0, T1>(arg0), arg1);
    }

    public(friend) fun take<T0, T1>(arg0: &mut Pool<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x1::vector::borrow_mut<u64>(&mut arg0.balances, type_to_index<T0, T1>(arg0));
        *v0 = *v0 - arg1;
        0x2::coin::take<T1>(borrow_mut_balance<T0, T1>(arg0), arg1, arg2)
    }

    public(friend) fun new<T0>(arg0: CreatePoolCap<T0>, arg1: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<0x1::ascii::String>, arg7: vector<u64>, arg8: u64, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: vector<u64>, arg13: &mut 0x2::tx_context::TxContext) : Pool<T0> {
        let v0 = 0x1::vector::length<0x1::ascii::String>(&arg6);
        assert_pool_creation_parameters_are_valid(v0, arg8, &arg7, &arg9, &arg10, &arg11, &arg12);
        let CreatePoolCap {
            id               : v1,
            lp_treasury_cap  : v2,
            lp_coin_metadata : v3,
        } = arg0;
        let v4 = v3;
        let v5 = v2;
        0x2::object::delete(v1);
        assert!(0x2::coin::total_supply<T0>(&v5) == 0, 7);
        let v6 = b"AfLp";
        0x1::vector::append<u8>(&mut v6, arg3);
        0x2::coin::update_name<T0>(&v5, &mut v4, 0x1::string::utf8(v6));
        let v7 = b"AF_LP_";
        0x1::vector::append<u8>(&mut v7, arg4);
        0x2::coin::update_symbol<T0>(&v5, &mut v4, 0x1::ascii::string(v7));
        0x2::coin::update_description<T0>(&v5, &mut v4, 0x1::string::utf8(arg5));
        0x2::coin::update_icon_url<T0>(&v5, &mut v4, 0x1::ascii::string(b"https://i.ibb.co/GV98MHf/Aftermath-Lp-Coin-Default.png"));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v4);
        let v8 = 0x2::object::new(arg13);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::register_pool<T0>(arg1, &v8, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        Pool<T0>{
            id                 : v8,
            name               : 0x1::string::utf8(arg2),
            creator            : 0x2::tx_context::sender(arg13),
            lp_supply          : 0x2::coin::treasury_into_supply<T0>(v5),
            illiquid_lp_supply : 0x2::balance::zero<T0>(),
            type_names         : arg6,
            balances           : 0x11b955825d69f808589ef3bd86a653af1c7e3db4bda4455b0b081dfe5eff100c::vector::empty_vector(v0),
            weights            : arg7,
            flatness           : arg8,
            fees_swap_in       : arg9,
            fees_swap_out      : arg10,
            fees_deposit       : arg11,
            fees_withdraw      : arg12,
        }
    }

    fun assert_pool_creation_parameters_are_valid(arg0: u64, arg1: u64, arg2: &vector<u64>, arg3: &vector<u64>, arg4: &vector<u64>, arg5: &vector<u64>, arg6: &vector<u64>) {
        assert!(0 <= arg1 && arg1 <= 1000000000000000000, 0);
        assert!(arg1 == 0 || arg1 == 1000000000000000000, 1);
        assert!(0x1::vector::length<u64>(arg2) == arg0, 5);
        assert!(0x1::vector::length<u64>(arg3) == arg0, 5);
        assert!(0x1::vector::length<u64>(arg4) == arg0, 5);
        assert!(0x1::vector::length<u64>(arg5) == arg0, 5);
        assert!(0x1::vector::length<u64>(arg6) == arg0, 5);
        let v0 = 0;
        let v1 = 0;
        while (v0 < arg0) {
            let v2 = *0x1::vector::borrow<u64>(arg2, v0);
            v1 = v1 + v2;
            assert!(10000000000000000 <= v2, 3);
            let v3 = *0x1::vector::borrow<u64>(arg3, v0);
            assert!(100000000000000 <= v3 && v3 <= 100000000000000000, 4);
            assert!(*0x1::vector::borrow<u64>(arg4, v0) == 0, 4);
            assert!(*0x1::vector::borrow<u64>(arg5, v0) == 0, 4);
            assert!(*0x1::vector::borrow<u64>(arg6, v0) == 0, 4);
            v0 = v0 + 1;
        };
        assert!(v1 == 1000000000000000000, 2);
    }

    public fun balance_of<T0, T1>(arg0: &Pool<T0>) : u64 {
        *0x1::vector::borrow<u64>(&arg0.balances, type_to_index<T0, T1>(arg0))
    }

    public fun balances<T0>(arg0: &Pool<T0>) : vector<u64> {
        arg0.balances
    }

    fun borrow_balance<T0, T1>(arg0: &Pool<T0>) : &0x2::balance::Balance<T1> {
        0x2::dynamic_field::borrow<0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::BalanceKey<T1>, 0x2::balance::Balance<T1>>(&arg0.id, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_balance_key<T1>())
    }

    fun borrow_mut_balance<T0, T1>(arg0: &mut Pool<T0>) : &mut 0x2::balance::Balance<T1> {
        0x2::dynamic_field::borrow_mut<0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::BalanceKey<T1>, 0x2::balance::Balance<T1>>(&mut arg0.id, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_balance_key<T1>())
    }

    public(friend) fun burn_lp_coins<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::decrease_supply<T0>(&mut arg0.lp_supply, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun contains_type<T0, T1>(arg0: &Pool<T0>) : bool {
        let v0 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T1>();
        let (v1, _) = 0x1::vector::index_of<0x1::ascii::String>(&arg0.type_names, &v0);
        v1
    }

    public(friend) fun create_lp_coin<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : CreatePoolCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 9, b"", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        CreatePoolCap<T0>{
            id               : 0x2::object::new(arg1),
            lp_treasury_cap  : v0,
            lp_coin_metadata : v1,
        }
    }

    public fun creator<T0>(arg0: &Pool<T0>) : address {
        arg0.creator
    }

    public fun fees_deposit<T0>(arg0: &Pool<T0>) : vector<u64> {
        arg0.fees_deposit
    }

    public fun fees_deposit_for<T0, T1>(arg0: &Pool<T0>) : u64 {
        *0x1::vector::borrow<u64>(&arg0.fees_deposit, type_to_index<T0, T1>(arg0))
    }

    public fun fees_swap_in<T0>(arg0: &Pool<T0>) : vector<u64> {
        arg0.fees_swap_in
    }

    public fun fees_swap_in_for<T0, T1>(arg0: &Pool<T0>) : u64 {
        *0x1::vector::borrow<u64>(&arg0.fees_swap_in, type_to_index<T0, T1>(arg0))
    }

    public fun fees_swap_out<T0>(arg0: &Pool<T0>) : vector<u64> {
        arg0.fees_swap_out
    }

    public fun fees_swap_out_for<T0, T1>(arg0: &Pool<T0>) : u64 {
        *0x1::vector::borrow<u64>(&arg0.fees_swap_out, type_to_index<T0, T1>(arg0))
    }

    public fun fees_withdraw<T0>(arg0: &Pool<T0>) : vector<u64> {
        arg0.fees_withdraw
    }

    public fun fees_withdraw_for<T0, T1>(arg0: &Pool<T0>) : u64 {
        *0x1::vector::borrow<u64>(&arg0.fees_withdraw, type_to_index<T0, T1>(arg0))
    }

    public fun flatness<T0>(arg0: &Pool<T0>) : u64 {
        arg0.flatness
    }

    public(friend) fun initialize_liquidity<T0, T1>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg1: &mut Pool<T0>, arg2: 0x2::coin::Coin<T1>) {
        *0x1::vector::borrow_mut<u64>(&mut arg1.balances, type_to_index<T0, T1>(arg1)) = 0x2::coin::value<T1>(&arg2);
        0x2::dynamic_field::add<0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::BalanceKey<T1>, 0x2::balance::Balance<T1>>(&mut arg1.id, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_balance_key<T1>(), 0x2::coin::into_balance<T1>(arg2));
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::add_coin<T1>(arg0);
    }

    public(friend) fun initialize_lp_supply<T0>(arg0: &mut Pool<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1 > 1000, 6);
        0x2::balance::join<T0>(&mut arg0.illiquid_lp_supply, 0x2::balance::increase_supply<T0>(&mut arg0.lp_supply, 1000));
        0x2::coin::from_balance<T0>(0x2::balance::increase_supply<T0>(&mut arg0.lp_supply, arg1 - 1000), arg2)
    }

    public fun lp_supply_value<T0>(arg0: &Pool<T0>) : u64 {
        0x2::balance::supply_value<T0>(&arg0.lp_supply)
    }

    public fun lp_type<T0>(arg0: &Pool<T0>) : 0x1::ascii::String {
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T0>()
    }

    public(friend) fun mint_lp_coins<T0>(arg0: &mut Pool<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::balance::increase_supply<T0>(&mut arg0.lp_supply, arg1), arg2)
    }

    public fun name<T0>(arg0: &Pool<T0>) : 0x1::string::String {
        arg0.name
    }

    public fun share<T0>(arg0: Pool<T0>) {
        0x2::transfer::public_share_object<Pool<T0>>(arg0);
    }

    public fun size<T0>(arg0: &Pool<T0>) : u64 {
        0x1::vector::length<u64>(&arg0.weights)
    }

    public fun transfer_create_pool_cap<T0>(arg0: CreatePoolCap<T0>, arg1: address) {
        0x2::transfer::transfer<CreatePoolCap<T0>>(arg0, arg1);
    }

    public(friend) fun type_name_to_balance_value<T0>(arg0: &Pool<T0>, arg1: 0x1::ascii::String) : u64 {
        *0x1::vector::borrow<u64>(&arg0.balances, type_name_to_index<T0>(arg0, arg1))
    }

    public(friend) fun type_name_to_index<T0>(arg0: &Pool<T0>, arg1: 0x1::ascii::String) : u64 {
        let (v0, v1) = 0x1::vector::index_of<0x1::ascii::String>(&arg0.type_names, &arg1);
        assert!(v0, 8);
        v1
    }

    public fun type_names<T0>(arg0: &Pool<T0>) : vector<0x1::ascii::String> {
        arg0.type_names
    }

    public(friend) fun type_to_index<T0, T1>(arg0: &Pool<T0>) : u64 {
        type_name_to_index<T0>(arg0, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T1>())
    }

    public fun weight_of<T0, T1>(arg0: &Pool<T0>) : u64 {
        *0x1::vector::borrow<u64>(&arg0.weights, type_to_index<T0, T1>(arg0))
    }

    public fun weights<T0>(arg0: &Pool<T0>) : vector<u64> {
        arg0.weights
    }

    // decompiled from Move bytecode v6
}

