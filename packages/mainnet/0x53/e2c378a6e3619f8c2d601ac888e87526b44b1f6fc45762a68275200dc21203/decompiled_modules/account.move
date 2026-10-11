module 0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::account {
    struct Registry has key {
        id: 0x2::object::UID,
        accounts: 0x2::table::Table<vector<u8>, 0x2::object::ID>,
    }

    struct Account has key {
        id: 0x2::object::UID,
        public_key: vector<u8>,
        nonce: u64,
    }

    struct BalanceKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct AccountCreated has copy, drop {
        account_id: 0x2::object::ID,
        public_key: vector<u8>,
    }

    struct Deposited has copy, drop {
        account_id: 0x2::object::ID,
        coin_type: 0x1::string::String,
        amount: u64,
    }

    struct Authorized has copy, drop {
        account_id: 0x2::object::ID,
        nonce: u64,
        action: 0x1::string::String,
        relay_fee: u64,
    }

    struct Withdrawn has copy, drop {
        account_id: 0x2::object::ID,
        coin_type: 0x1::string::String,
        amount: u64,
        recipient: address,
    }

    public fun account_of(arg0: &Registry, arg1: vector<u8>) : 0x1::option::Option<0x2::object::ID> {
        if (0x2::table::contains<vector<u8>, 0x2::object::ID>(&arg0.accounts, arg1)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<vector<u8>, 0x2::object::ID>(&arg0.accounts, arg1))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    fun address_string(arg0: address) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"0x");
        0x1::string::append(&mut v0, 0x2::address::to_string(arg0));
        v0
    }

    fun authorize(arg0: &mut Account, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg6) <= arg5, 301);
        assert!(arg4 <= 100000000, 305);
        assert!(0x2::ed25519::ed25519_verify(&arg3, &arg0.public_key, 0x1::string::as_bytes(&arg2)), 300);
        let v0 = Authorized{
            account_id : 0x2::object::id<Account>(arg0),
            nonce      : arg0.nonce,
            action     : arg1,
            relay_fee  : arg4,
        };
        0x2::event::emit<Authorized>(v0);
        arg0.nonce = arg0.nonce + 1;
        if (arg4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(take<0x2::sui::SUI>(arg0, arg4), arg7), 0x2::tx_context::sender(arg7));
        };
    }

    public fun balance_of<T0>(arg0: &Account) : u64 {
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists<BalanceKey<T0>>(&arg0.id, v0)) {
            let v2 = BalanceKey<T0>{dummy_field: false};
            0x2::balance::value<T0>(0x2::dynamic_field::borrow<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&arg0.id, v2))
        } else {
            0
        }
    }

    public fun buy<T0>(arg0: &mut Account, arg1: &mut 0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::curve::BondingCurve<T0>, arg2: &0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::Config, arg3: &0x2::coin::CoinMetadata<T0>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = buy_message<T0>(arg0, arg3, arg4, arg5, false, arg6, arg7);
        authorize(arg0, 0x1::string::utf8(b"buy"), v0, arg8, arg6, arg7, arg9, arg10);
        let v1 = deposit_address(arg0);
        let v2 = take<0x2::sui::SUI>(arg0, arg4);
        let v3 = 0x2::coin::from_balance<0x2::sui::SUI>(v2, arg10);
        put<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(v3));
        put<T0>(arg0, 0x2::coin::into_balance<T0>(0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::curve::buy_as<T0>(arg1, arg2, &mut v3, arg4, arg5, v1, arg9, arg10)));
    }

    public(friend) fun buy_message<T0>(arg0: &Account, arg1: &0x2::coin::CoinMetadata<T0>, arg2: u64, arg3: u64, arg4: bool, arg5: u64, arg6: u64) : 0x1::string::String {
        trade_message(arg0, b"Buy", symbol_of<T0>(arg1), b"Pay", fmt_units(arg2, 9), 0x1::string::utf8(b"SUI"), fmt_units(arg3, 0x2::coin::get_decimals<T0>(arg1)), symbol_of<T0>(arg1), arg4, type_string<T0>(), arg5, arg6)
    }

    public fun claim_creator_fees<T0>(arg0: &mut Account, arg1: &mut 0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::curve::BondingCurve<T0>) {
        let v0 = 0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::curve::take_creator_fees<T0>(arg1, deposit_address(arg0));
        put<0x2::sui::SUI>(arg0, v0);
    }

    public fun create(arg0: &mut Registry, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 303);
        assert!(!0x2::table::contains<vector<u8>, 0x2::object::ID>(&arg0.accounts, arg1), 302);
        let v0 = Account{
            id         : 0x2::object::new(arg2),
            public_key : arg1,
            nonce      : 0,
        };
        let v1 = 0x2::object::id<Account>(&v0);
        0x2::table::add<vector<u8>, 0x2::object::ID>(&mut arg0.accounts, arg1, v1);
        let v2 = AccountCreated{
            account_id : v1,
            public_key : arg1,
        };
        0x2::event::emit<AccountCreated>(v2);
        0x2::transfer::share_object<Account>(v0);
        v1
    }

    public fun deposit<T0>(arg0: &mut Account, arg1: 0x2::coin::Coin<T0>) {
        put<T0>(arg0, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun deposit_address(arg0: &Account) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun dex_buy<T0>(arg0: &mut Account, arg1: &0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg4: &0x2::coin::CoinMetadata<T0>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = buy_message<T0>(arg0, arg4, arg5, arg6, true, arg7, arg8);
        authorize(arg0, 0x1::string::utf8(b"dex_buy"), v0, arg9, arg7, arg8, arg10, arg11);
        let v1 = deposit_address(arg0);
        let v2 = take<0x2::sui::SUI>(arg0, arg5);
        let v3 = 0x2::coin::from_balance<0x2::sui::SUI>(v2, arg11);
        put<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(v3));
        put<T0>(arg0, 0x2::coin::into_balance<T0>(0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::dex::buy_as<T0>(arg1, arg2, arg3, &mut v3, arg5, arg6, v1, arg10, arg11)));
    }

    public fun dex_sell<T0>(arg0: &mut Account, arg1: &0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg4: &0x2::coin::CoinMetadata<T0>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = sell_message<T0>(arg0, arg4, arg5, arg6, true, arg7, arg8);
        authorize(arg0, 0x1::string::utf8(b"dex_sell"), v0, arg9, arg7, arg8, arg10, arg11);
        let v1 = deposit_address(arg0);
        let v2 = take<T0>(arg0, arg5);
        let v3 = 0x2::coin::from_balance<T0>(v2, arg11);
        put<T0>(arg0, 0x2::coin::into_balance<T0>(v3));
        put<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::dex::sell_as<T0>(arg1, arg2, arg3, &mut v3, arg5, arg6, v1, arg10, arg11)));
    }

    public(friend) fun fmt_units(arg0: u64, arg1: u8) : 0x1::string::String {
        let v0 = 0x1::string::into_bytes(0x1::u64::to_string(arg0));
        let v1 = (arg1 as u64);
        let v2 = 0x1::vector::length<u8>(&v0);
        let v3 = b"";
        let v4 = b"";
        if (v2 > v1) {
            let v5 = 0;
            while (v5 < v2 - v1) {
                0x1::vector::push_back<u8>(&mut v3, *0x1::vector::borrow<u8>(&v0, v5));
                v5 = v5 + 1;
            };
            while (v5 < v2) {
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v0, v5));
                v5 = v5 + 1;
            };
        } else {
            0x1::vector::push_back<u8>(&mut v3, 48);
            let v6 = 0;
            while (v6 < v1 - v2) {
                0x1::vector::push_back<u8>(&mut v4, 48);
                v6 = v6 + 1;
            };
            0x1::vector::append<u8>(&mut v4, v0);
        };
        while (!0x1::vector::is_empty<u8>(&v4) && *0x1::vector::borrow<u8>(&v4, 0x1::vector::length<u8>(&v4) - 1) == 48) {
            0x1::vector::pop_back<u8>(&mut v4);
        };
        if (!0x1::vector::is_empty<u8>(&v4)) {
            0x1::vector::push_back<u8>(&mut v3, 46);
            0x1::vector::append<u8>(&mut v3, v4);
        };
        0x1::string::utf8(v3)
    }

    fun footer(arg0: &Account, arg1: &mut 0x1::string::String, arg2: u64, arg3: u64) {
        line(arg1, b"Network fee", units(arg2, 9, b"SUI"));
        line(arg1, b"Account", address_string(deposit_address(arg0)));
        line(arg1, b"Nonce", 0x1::u64::to_string(arg0.nonce));
        line(arg1, b"Valid until", 0x1::u64::to_string(arg3));
    }

    fun header(arg0: vector<u8>, arg1: &0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"sui.fun | ");
        0x1::string::append_utf8(&mut v0, arg0);
        0x1::string::append(&mut v0, *arg1);
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id       : 0x2::object::new(arg0),
            accounts : 0x2::table::new<vector<u8>, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun launch<T0>(arg0: &mut Account, arg1: &0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::Config, arg2: 0x2::coin::TreasuryCap<T0>, arg3: &0x2::coin::CoinMetadata<T0>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: vector<u8>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = launch_message<T0>(arg0, arg1, arg3, arg6, arg7, arg8, arg9);
        authorize(arg0, 0x1::string::utf8(b"launch"), v0, arg10, arg8, arg9, arg11, arg12);
        let v1 = deposit_address(arg0);
        let v2 = take<0x2::sui::SUI>(arg0, 0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::launch_fee(arg1));
        let v3 = 0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::curve::create_for<T0>(arg1, arg2, arg3, 0x2::coin::from_balance<0x2::sui::SUI>(v2, arg12), arg4, arg5, v1, arg11, arg12);
        if (arg6 > 0) {
            let v4 = take<0x2::sui::SUI>(arg0, arg6);
            let v5 = 0x2::coin::from_balance<0x2::sui::SUI>(v4, arg12);
            put<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(v5));
            put<T0>(arg0, 0x2::coin::into_balance<T0>(0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::curve::buy_as<T0>(&mut v3, arg1, &mut v5, arg6, arg7, v1, arg11, arg12)));
        };
        0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::curve::share<T0>(v3);
    }

    public(friend) fun launch_message<T0>(arg0: &Account, arg1: &0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::Config, arg2: &0x2::coin::CoinMetadata<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : 0x1::string::String {
        let v0 = symbol_of<T0>(arg2);
        let v1 = header(b"Launch $", &v0);
        let v2 = &mut v1;
        line(v2, b"Name", 0x2::coin::get_name<T0>(arg2));
        let v3 = &mut v1;
        line(v3, b"Ticker", v0);
        let v4 = &mut v1;
        line(v4, b"Launch fee", units(0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::launch_fee(arg1), 9, b"SUI"));
        let v5 = &mut v1;
        line(v5, b"Initial buy", units(arg3, 9, b"SUI"));
        if (arg3 > 0) {
            let v6 = fmt_units(arg4, 0x2::coin::get_decimals<T0>(arg2));
            0x1::string::append_utf8(&mut v6, b" ");
            0x1::string::append(&mut v6, v0);
            let v7 = &mut v1;
            line(v7, b"Receive at least", v6);
        };
        let v8 = &mut v1;
        footer(arg0, v8, arg5, arg6);
        v1
    }

    fun line(arg0: &mut 0x1::string::String, arg1: vector<u8>, arg2: 0x1::string::String) {
        0x1::string::append_utf8(arg0, x"0a");
        0x1::string::append_utf8(arg0, arg1);
        0x1::string::append_utf8(arg0, b": ");
        0x1::string::append(arg0, arg2);
    }

    public fun nonce(arg0: &Account) : u64 {
        arg0.nonce
    }

    public fun public_key(arg0: &Account) : vector<u8> {
        arg0.public_key
    }

    fun put<T0>(arg0: &mut Account, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        let v1 = BalanceKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists<BalanceKey<T0>>(&arg0.id, v1)) {
            let v2 = BalanceKey<T0>{dummy_field: false};
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v2), arg1);
        } else {
            let v3 = BalanceKey<T0>{dummy_field: false};
            0x2::dynamic_field::add<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v3, arg1);
        };
        let v4 = Deposited{
            account_id : 0x2::object::id<Account>(arg0),
            coin_type  : type_string<T0>(),
            amount     : v0,
        };
        0x2::event::emit<Deposited>(v4);
    }

    public fun receive_coin<T0>(arg0: &mut Account, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>) {
        let v0 = 0x2::coin::into_balance<T0>(0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1));
        put<T0>(arg0, v0);
    }

    public fun receive_funds<T0>(arg0: &mut Account, arg1: u64) {
        let v0 = 0x2::balance::redeem_funds<T0>(0x2::balance::withdraw_funds_from_object<T0>(&mut arg0.id, arg1));
        put<T0>(arg0, v0);
    }

    public fun sell<T0>(arg0: &mut Account, arg1: &mut 0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::curve::BondingCurve<T0>, arg2: &0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::Config, arg3: &0x2::coin::CoinMetadata<T0>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = sell_message<T0>(arg0, arg3, arg4, arg5, false, arg6, arg7);
        authorize(arg0, 0x1::string::utf8(b"sell"), v0, arg8, arg6, arg7, arg9, arg10);
        let v1 = deposit_address(arg0);
        let v2 = take<T0>(arg0, arg4);
        put<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::curve::sell_as<T0>(arg1, arg2, 0x2::coin::from_balance<T0>(v2, arg10), arg5, v1, arg9, arg10)));
    }

    public(friend) fun sell_message<T0>(arg0: &Account, arg1: &0x2::coin::CoinMetadata<T0>, arg2: u64, arg3: u64, arg4: bool, arg5: u64, arg6: u64) : 0x1::string::String {
        trade_message(arg0, b"Sell", symbol_of<T0>(arg1), b"Sell", fmt_units(arg2, 0x2::coin::get_decimals<T0>(arg1)), symbol_of<T0>(arg1), fmt_units(arg3, 9), 0x1::string::utf8(b"SUI"), arg4, type_string<T0>(), arg5, arg6)
    }

    fun send<T0>(arg0: &mut Account, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 306);
        let v0 = take<T0>(arg0, arg1);
        let v1 = Withdrawn{
            account_id : 0x2::object::id<Account>(arg0),
            coin_type  : type_string<T0>(),
            amount     : arg1,
            recipient  : arg2,
        };
        0x2::event::emit<Withdrawn>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg3), arg2);
    }

    fun symbol_of<T0>(arg0: &0x2::coin::CoinMetadata<T0>) : 0x1::string::String {
        0x1::string::from_ascii(0x2::coin::get_symbol<T0>(arg0))
    }

    fun take<T0>(arg0: &mut Account, arg1: u64) : 0x2::balance::Balance<T0> {
        assert!(balance_of<T0>(arg0) >= arg1, 304);
        if (arg1 == 0) {
            return 0x2::balance::zero<T0>()
        };
        let v0 = BalanceKey<T0>{dummy_field: false};
        0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg1)
    }

    fun trade_message(arg0: &Account, arg1: vector<u8>, arg2: 0x1::string::String, arg3: vector<u8>, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: bool, arg9: 0x1::string::String, arg10: u64, arg11: u64) : 0x1::string::String {
        0x1::vector::append<u8>(&mut arg1, b" $");
        let v0 = header(arg1, &arg2);
        if (arg8) {
            0x1::string::append_utf8(&mut v0, b" on Cetus");
        };
        0x1::string::append_utf8(&mut arg4, b" ");
        0x1::string::append(&mut arg4, arg5);
        let v1 = &mut v0;
        line(v1, arg3, arg4);
        0x1::string::append_utf8(&mut arg6, b" ");
        0x1::string::append(&mut arg6, arg7);
        let v2 = &mut v0;
        line(v2, b"Receive at least", arg6);
        let v3 = &mut v0;
        line(v3, b"Token", arg9);
        let v4 = &mut v0;
        footer(arg0, v4, arg10, arg11);
        v0
    }

    fun type_string<T0>() : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"0x");
        0x1::string::append(&mut v0, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())));
        v0
    }

    fun units(arg0: u64, arg1: u8, arg2: vector<u8>) : 0x1::string::String {
        let v0 = fmt_units(arg0, arg1);
        0x1::string::append_utf8(&mut v0, b" ");
        0x1::string::append_utf8(&mut v0, arg2);
        v0
    }

    public fun withdraw<T0>(arg0: &mut Account, arg1: &0x2::coin::CoinMetadata<T0>, arg2: u64, arg3: address, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_message<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        authorize(arg0, 0x1::string::utf8(b"withdraw"), v0, arg6, arg4, arg5, arg7, arg8);
        send<T0>(arg0, arg2, arg3, arg8);
    }

    public(friend) fun withdraw_message<T0>(arg0: &Account, arg1: &0x2::coin::CoinMetadata<T0>, arg2: u64, arg3: address, arg4: u64, arg5: u64) : 0x1::string::String {
        let v0 = symbol_of<T0>(arg1);
        let v1 = header(b"Withdraw $", &v0);
        let v2 = fmt_units(arg2, 0x2::coin::get_decimals<T0>(arg1));
        0x1::string::append_utf8(&mut v2, b" ");
        0x1::string::append(&mut v2, v0);
        let v3 = &mut v1;
        line(v3, b"Amount", v2);
        let v4 = &mut v1;
        line(v4, b"Token", type_string<T0>());
        let v5 = &mut v1;
        line(v5, b"To", address_string(arg3));
        let v6 = &mut v1;
        footer(arg0, v6, arg4, arg5);
        v1
    }

    public fun withdraw_sui(arg0: &mut Account, arg1: u64, arg2: address, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_sui_message(arg0, arg1, arg2, arg3, arg4);
        authorize(arg0, 0x1::string::utf8(b"withdraw"), v0, arg5, arg3, arg4, arg6, arg7);
        send<0x2::sui::SUI>(arg0, arg1, arg2, arg7);
    }

    public(friend) fun withdraw_sui_message(arg0: &Account, arg1: u64, arg2: address, arg3: u64, arg4: u64) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"SUI");
        let v1 = header(b"Withdraw ", &v0);
        let v2 = &mut v1;
        line(v2, b"Amount", units(arg1, 9, b"SUI"));
        let v3 = &mut v1;
        line(v3, b"To", address_string(arg2));
        let v4 = &mut v1;
        footer(arg0, v4, arg3, arg4);
        v1
    }

    // decompiled from Move bytecode v7
}

