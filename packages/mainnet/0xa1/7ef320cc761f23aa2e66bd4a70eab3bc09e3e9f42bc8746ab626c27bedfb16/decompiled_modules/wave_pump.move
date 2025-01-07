module 0xa17ef320cc761f23aa2e66bd4a70eab3bc09e3e9f42bc8746ab626c27bedfb16::wave_pump {
    struct App has key {
        id: 0x2::object::UID,
        virtual_sui_amount: u64,
        initial_token: u64,
        listing_dex_threshold: u64,
        swap_fee: u64,
        listing_fee: u64,
        fee_receiver: address,
        operator: address,
        version: u64,
    }

    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        virtual_sui_amount: u64,
        sui_reserves: 0x2::balance::Balance<0x2::sui::SUI>,
        token_reserves: 0x2::balance::Balance<T0>,
        is_completed: bool,
    }

    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct ListingEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        name: 0x1::string::String,
        symbol: 0x1::ascii::String,
        url: 0x1::option::Option<0x2::url::Url>,
        description: 0x1::string::String,
        twitter: 0x1::option::Option<0x1::ascii::String>,
        telegram: 0x1::option::Option<0x1::ascii::String>,
        website: 0x1::option::Option<0x1::ascii::String>,
        token_type: 0x1::ascii::String,
        created_by: address,
        created_at: u64,
        sui_amount: u64,
        token_amount: u64,
        virtual_sui_amount: u64,
    }

    struct SwapEvent has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        token_type: 0x1::ascii::String,
        is_buy: bool,
        input_amount: u64,
        output_amount: u64,
        sui_reserve_amount: u64,
        token_reserve_amount: u64,
    }

    struct CompletedEvent has copy, drop, store {
        token_type: 0x1::ascii::String,
        pool_id: 0x2::object::ID,
        sui_amount: u64,
        token_amount: u64,
    }

    struct ConfigUpdatedEvent has copy, drop, store {
        operator: address,
        fee_receiver: address,
        virtual_sui_amount: u64,
        initial_token: u64,
        listing_dex_threshold: u64,
        listing_fee: u64,
        swap_fee: u64,
    }

    public fun buy<T0>(arg0: &mut App, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.version <= 1, 8);
        let v0 = get_token_type_str<T0>();
        assert!(0x2::dynamic_object_field::exists_with_type<0x1::ascii::String, Pool<T0>>(&arg0.id, v0), 3);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg0.id, v0);
        assert!(!v1.is_completed, 5);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v3 = v2 * arg0.swap_fee / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v3, arg3), arg0.fee_receiver);
        let v4 = 0x2::balance::value<0x2::sui::SUI>(&v1.sui_reserves);
        let v5 = 0x2::balance::value<T0>(&v1.token_reserves);
        let v6 = get_output_amount(v2 - v3, v4 + v1.virtual_sui_amount, v5);
        assert!(v6 >= arg2, 4);
        0x2::balance::join<0x2::sui::SUI>(&mut v1.sui_reserves, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v7 = v4 + v2 - v3;
        let v8 = v5 - v6;
        if (v7 >= arg0.listing_dex_threshold) {
            v1.is_completed = true;
            let v9 = CompletedEvent{
                token_type   : v0,
                pool_id      : 0x2::object::id<Pool<T0>>(v1),
                sui_amount   : v7,
                token_amount : v8,
            };
            0x2::event::emit<CompletedEvent>(v9);
        };
        let v10 = SwapEvent{
            sender               : 0x2::tx_context::sender(arg3),
            pool_id              : 0x2::object::id<Pool<T0>>(v1),
            token_type           : v0,
            is_buy               : true,
            input_amount         : v2,
            output_amount        : v6,
            sui_reserve_amount   : v7,
            token_reserve_amount : v8,
        };
        0x2::event::emit<SwapEvent>(v10);
        0x2::coin::take<T0>(&mut v1.token_reserves, v6, arg3)
    }

    fun get_output_amount(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u128);
        ((v0 * (arg2 as u128) / ((arg1 as u128) + v0)) as u64)
    }

    fun get_token_type_str<T0>() : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::get<T0>())
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = App{
            id                    : 0x2::object::new(arg0),
            virtual_sui_amount    : 4500000000000,
            initial_token         : 1000000000000000000,
            listing_dex_threshold : 10000000000000,
            swap_fee              : 100,
            listing_fee           : 500000000,
            fee_receiver          : @0x85edbbbfd69c6b2c1d695b89ec93153b786b78a8963989268843cc5716434049,
            operator              : @0x85edbbbfd69c6b2c1d695b89ec93153b786b78a8963989268843cc5716434049,
            version               : 1,
        };
        0x2::transfer::share_object<App>(v1);
    }

    public fun list<T0>(arg0: &mut App, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x1::option::Option<0x1::ascii::String>, arg5: 0x1::option::Option<0x1::ascii::String>, arg6: 0x1::option::Option<0x1::ascii::String>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 8);
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 1);
        assert!(0x2::coin::get_decimals<T0>(arg2) == 9, 2);
        let v0 = Pool<T0>{
            id                 : 0x2::object::new(arg8),
            virtual_sui_amount : arg0.virtual_sui_amount,
            sui_reserves       : 0x2::balance::zero<0x2::sui::SUI>(),
            token_reserves     : 0x2::coin::mint_balance<T0>(&mut arg1, arg0.initial_token),
            is_completed       : false,
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(arg1, @0x0);
        let v1 = 0x1::type_name::get<T0>();
        0x2::dynamic_object_field::add<0x1::ascii::String, Pool<T0>>(&mut arg0.id, 0x1::type_name::into_string(v1), v0);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v2 >= arg0.listing_fee, 11);
        let v3 = if (v2 > arg0.listing_fee) {
            0x2::pay::keep<0x2::sui::SUI>(arg3, arg8);
            0x2::coin::split<0x2::sui::SUI>(&mut arg3, arg0.listing_fee, arg8)
        } else {
            arg3
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, arg0.fee_receiver);
        let v4 = ListingEvent{
            pool_id            : 0x2::object::id<Pool<T0>>(&v0),
            name               : 0x2::coin::get_name<T0>(arg2),
            symbol             : 0x2::coin::get_symbol<T0>(arg2),
            url                : 0x2::coin::get_icon_url<T0>(arg2),
            description        : 0x2::coin::get_description<T0>(arg2),
            twitter            : arg4,
            telegram           : arg5,
            website            : arg6,
            token_type         : 0x1::type_name::into_string(v1),
            created_by         : 0x2::tx_context::sender(arg8),
            created_at         : 0x2::clock::timestamp_ms(arg7),
            sui_amount         : 0,
            token_amount       : arg0.initial_token,
            virtual_sui_amount : arg0.virtual_sui_amount,
        };
        0x2::event::emit<ListingEvent>(v4);
    }

    entry fun migrate(arg0: &OwnerCap, arg1: &mut App) {
        assert!(arg1.version < 1, 7);
        arg1.version = 1;
    }

    public fun sell<T0>(arg0: &mut App, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.version <= 1, 8);
        let v0 = get_token_type_str<T0>();
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg0.id, v0);
        assert!(!v1.is_completed, 5);
        let v2 = 0x2::coin::value<T0>(&arg1);
        let v3 = 0x2::balance::value<0x2::sui::SUI>(&v1.sui_reserves);
        let v4 = 0x2::balance::value<T0>(&v1.token_reserves);
        let v5 = get_output_amount(v2, v4, v3 + v1.virtual_sui_amount);
        assert!(v5 >= arg2, 4);
        0x2::balance::join<T0>(&mut v1.token_reserves, 0x2::coin::into_balance<T0>(arg1));
        let v6 = 0x2::coin::take<0x2::sui::SUI>(&mut v1.sui_reserves, v5, arg3);
        let v7 = v5 * arg0.swap_fee / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v6, v7, arg3), arg0.fee_receiver);
        let v8 = SwapEvent{
            sender               : 0x2::tx_context::sender(arg3),
            pool_id              : 0x2::object::id<Pool<T0>>(v1),
            token_type           : v0,
            is_buy               : false,
            input_amount         : v2,
            output_amount        : v5 - v7,
            sui_reserve_amount   : v3 - v5,
            token_reserve_amount : v4 + v2,
        };
        0x2::event::emit<SwapEvent>(v8);
        v6
    }

    public fun transfer_liquidity<T0>(arg0: &mut App, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        assert!(0x2::tx_context::sender(arg1) == arg0.operator, 9);
        let v0 = get_token_type_str<T0>();
        assert!(0x2::dynamic_object_field::exists_with_type<0x1::ascii::String, Pool<T0>>(&arg0.id, v0), 3);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg0.id, v0);
        assert!(v1.is_completed, 6);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v1.sui_reserves) > 0, 10);
        (0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut v1.sui_reserves), arg1), 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut v1.token_reserves), arg1))
    }

    entry fun update_config(arg0: &OwnerCap, arg1: &mut App, arg2: address, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        arg1.operator = arg2;
        arg1.fee_receiver = arg3;
        arg1.virtual_sui_amount = arg4;
        arg1.initial_token = arg5;
        arg1.listing_dex_threshold = arg6;
        arg1.swap_fee = arg8;
        arg1.listing_fee = arg7;
        let v0 = ConfigUpdatedEvent{
            operator              : arg2,
            fee_receiver          : arg3,
            virtual_sui_amount    : arg4,
            initial_token         : arg5,
            listing_dex_threshold : arg6,
            listing_fee           : arg7,
            swap_fee              : arg8,
        };
        0x2::event::emit<ConfigUpdatedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

