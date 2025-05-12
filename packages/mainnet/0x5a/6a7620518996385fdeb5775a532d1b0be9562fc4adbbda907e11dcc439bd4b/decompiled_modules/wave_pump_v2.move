module 0xbcf04fd43407271d2db19a1f016b4d9a8cb93169ec2629a3e84adfc22d6dd4::wave_pump_v2 {
    struct App has key {
        id: 0x2::object::UID,
        virtual_wav_amount: u64,
        initial_token: u64,
        listing_dex_threshold: u64,
        enable_dex_listing: bool,
        swap_fee: u64,
        listing_fee: u64,
        fee_receiver: address,
        operator: address,
        version: u64,
        creator_fee_rate: u64,
    }

    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        virtual_wav_amount: u64,
        listing_dex_threshold: u64,
        enable_dex_listing: bool,
        wav_reserves: 0x2::balance::Balance<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>,
        token_reserves: 0x2::balance::Balance<T0>,
        is_completed: bool,
        creator: address,
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
        wav_amount: u64,
        token_amount: u64,
        listing_dex_threshold: u64,
        virtual_wav_amount: u64,
    }

    struct SwapEvent has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        token_type: 0x1::ascii::String,
        is_buy: bool,
        input_amount: u64,
        output_amount: u64,
        wav_reserve_amount: u64,
        token_reserve_amount: u64,
    }

    struct CompletedEvent has copy, drop, store {
        token_type: 0x1::ascii::String,
        pool_id: 0x2::object::ID,
        wav_amount: u64,
        token_amount: u64,
    }

    struct ConfigUpdatedEvent has copy, drop, store {
        operator: address,
        fee_receiver: address,
        virtual_wav_amount: u64,
        initial_token: u64,
        listing_dex_threshold: u64,
        listing_fee: u64,
        swap_fee: u64,
    }

    public fun buy<T0>(arg0: &mut App, arg1: 0x2::coin::Coin<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.version <= 1, 8);
        let v0 = get_token_type_str<T0>();
        assert!(0x2::dynamic_object_field::exists_with_type<0x1::ascii::String, Pool<T0>>(&arg0.id, v0), 3);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg0.id, v0);
        assert!(!v1.is_completed, 5);
        let v2 = 0x2::coin::value<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>(&arg1);
        let v3 = v2 * arg0.swap_fee / 10000;
        let v4 = 0x2::coin::split<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>(&mut arg1, v3, arg3);
        if (arg0.creator_fee_rate > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>>(0x2::coin::split<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>(&mut v4, v3 * arg0.creator_fee_rate / 10000, arg3), v1.creator);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>>(v4, arg0.fee_receiver);
        let v5 = 0x2::balance::value<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>(&v1.wav_reserves);
        let v6 = 0x2::balance::value<T0>(&v1.token_reserves);
        let v7 = get_output_amount(v2 - v3, v5 + v1.virtual_wav_amount, v6);
        assert!(v7 >= arg2, 4);
        0x2::balance::join<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>(&mut v1.wav_reserves, 0x2::coin::into_balance<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>(arg1));
        let v8 = v5 + v2 - v3;
        let v9 = v6 - v7;
        let v10 = if (v1.listing_dex_threshold > 0) {
            if (v8 >= v1.listing_dex_threshold) {
                v1.enable_dex_listing
            } else {
                false
            }
        } else {
            false
        };
        if (v10) {
            v1.is_completed = true;
            let v11 = CompletedEvent{
                token_type   : v0,
                pool_id      : 0x2::object::id<Pool<T0>>(v1),
                wav_amount   : v8,
                token_amount : v9,
            };
            0x2::event::emit<CompletedEvent>(v11);
        };
        let v12 = SwapEvent{
            sender               : 0x2::tx_context::sender(arg3),
            pool_id              : 0x2::object::id<Pool<T0>>(v1),
            token_type           : v0,
            is_buy               : true,
            input_amount         : v2 - v3,
            output_amount        : v7,
            wav_reserve_amount   : v8,
            token_reserve_amount : v9,
        };
        0x2::event::emit<SwapEvent>(v12);
        0x2::coin::take<T0>(&mut v1.token_reserves, v7, arg3)
    }

    fun get_output_amount(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u128);
        ((v0 * (arg2 as u128) / ((arg1 as u128) + v0)) as u64)
    }

    fun get_token_type_str<T0>() : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::get<T0>())
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = App{
            id                    : 0x2::object::new(arg0),
            virtual_wav_amount    : 4500000000000,
            initial_token         : 1000000000000000000,
            listing_dex_threshold : 0,
            enable_dex_listing    : false,
            swap_fee              : 100,
            listing_fee           : 100000000000,
            fee_receiver          : @0x85edbbbfd69c6b2c1d695b89ec93153b786b78a8963989268843cc5716434049,
            operator              : @0x85edbbbfd69c6b2c1d695b89ec93153b786b78a8963989268843cc5716434049,
            version               : 1,
            creator_fee_rate      : 5000,
        };
        0x2::transfer::share_object<App>(v0);
    }

    public entry fun init_module(arg0: &0xbcf04fd43407271d2db19a1f016b4d9a8cb93169ec2629a3e84adfc22d6dd4::wave_pump::OwnerCap, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = App{
            id                    : 0x2::object::new(arg3),
            virtual_wav_amount    : 4500000000000,
            initial_token         : 1000000000000000000,
            listing_dex_threshold : 0,
            enable_dex_listing    : false,
            swap_fee              : 100,
            listing_fee           : 100000000000,
            fee_receiver          : arg2,
            operator              : arg1,
            version               : 1,
            creator_fee_rate      : 5000,
        };
        0x2::transfer::share_object<App>(v0);
    }

    public fun list<T0>(arg0: &mut App, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: 0x2::coin::Coin<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>, arg4: 0x1::option::Option<0x1::ascii::String>, arg5: 0x1::option::Option<0x1::ascii::String>, arg6: 0x1::option::Option<0x1::ascii::String>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 8);
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 1);
        assert!(0x2::coin::get_decimals<T0>(arg2) == 9, 2);
        let v0 = Pool<T0>{
            id                    : 0x2::object::new(arg8),
            virtual_wav_amount    : arg0.virtual_wav_amount,
            listing_dex_threshold : arg0.listing_dex_threshold,
            enable_dex_listing    : arg0.enable_dex_listing,
            wav_reserves          : 0x2::balance::zero<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>(),
            token_reserves        : 0x2::coin::mint_balance<T0>(&mut arg1, arg0.initial_token),
            is_completed          : false,
            creator               : 0x2::tx_context::sender(arg8),
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(arg1, @0x0);
        let v1 = 0x1::type_name::get<T0>();
        0x2::dynamic_object_field::add<0x1::ascii::String, Pool<T0>>(&mut arg0.id, 0x1::type_name::into_string(v1), v0);
        let v2 = 0x2::coin::value<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>(&arg3);
        assert!(v2 >= arg0.listing_fee, 11);
        let v3 = if (v2 > arg0.listing_fee) {
            0x2::pay::keep<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>(arg3, arg8);
            0x2::coin::split<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>(&mut arg3, arg0.listing_fee, arg8)
        } else {
            arg3
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>>(v3, arg0.fee_receiver);
        let v4 = ListingEvent{
            pool_id               : 0x2::object::id<Pool<T0>>(&v0),
            name                  : 0x2::coin::get_name<T0>(arg2),
            symbol                : 0x2::coin::get_symbol<T0>(arg2),
            url                   : 0x2::coin::get_icon_url<T0>(arg2),
            description           : 0x2::coin::get_description<T0>(arg2),
            twitter               : arg4,
            telegram              : arg5,
            website               : arg6,
            token_type            : 0x1::type_name::into_string(v1),
            created_by            : 0x2::tx_context::sender(arg8),
            created_at            : 0x2::clock::timestamp_ms(arg7),
            wav_amount            : 0,
            token_amount          : arg0.initial_token,
            listing_dex_threshold : arg0.listing_dex_threshold,
            virtual_wav_amount    : arg0.virtual_wav_amount,
        };
        0x2::event::emit<ListingEvent>(v4);
    }

    entry fun migrate(arg0: &0xbcf04fd43407271d2db19a1f016b4d9a8cb93169ec2629a3e84adfc22d6dd4::wave_pump::OwnerCap, arg1: &mut App) {
        assert!(arg1.version < 1, 7);
        arg1.version = 1;
    }

    public fun sell<T0>(arg0: &mut App, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV> {
        assert!(arg0.version <= 1, 8);
        let v0 = get_token_type_str<T0>();
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg0.id, v0);
        assert!(!v1.is_completed, 5);
        let v2 = 0x2::coin::value<T0>(&arg1);
        let v3 = 0x2::balance::value<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>(&v1.wav_reserves);
        let v4 = 0x2::balance::value<T0>(&v1.token_reserves);
        let v5 = get_output_amount(v2, v4, v3 + v1.virtual_wav_amount);
        assert!(v5 >= arg2, 4);
        0x2::balance::join<T0>(&mut v1.token_reserves, 0x2::coin::into_balance<T0>(arg1));
        let v6 = 0x2::coin::take<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>(&mut v1.wav_reserves, v5, arg3);
        let v7 = v5 * arg0.swap_fee / 10000;
        let v8 = 0x2::coin::split<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>(&mut v6, v7, arg3);
        if (arg0.creator_fee_rate > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>>(0x2::coin::split<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>(&mut v8, v7 * arg0.creator_fee_rate / 10000, arg3), v1.creator);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>>(v8, arg0.fee_receiver);
        let v9 = SwapEvent{
            sender               : 0x2::tx_context::sender(arg3),
            pool_id              : 0x2::object::id<Pool<T0>>(v1),
            token_type           : v0,
            is_buy               : false,
            input_amount         : v2,
            output_amount        : v5 - v7,
            wav_reserve_amount   : v3 - v5,
            token_reserve_amount : v4 + v2,
        };
        0x2::event::emit<SwapEvent>(v9);
        v6
    }

    public fun transfer_liquidity<T0>(arg0: &mut App, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>, 0x2::coin::Coin<T0>) {
        assert!(arg0.version <= 1, 8);
        assert!(0x2::tx_context::sender(arg1) == arg0.operator, 9);
        let v0 = get_token_type_str<T0>();
        assert!(0x2::dynamic_object_field::exists_with_type<0x1::ascii::String, Pool<T0>>(&arg0.id, v0), 3);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg0.id, v0);
        assert!(v1.is_completed, 6);
        assert!(0x2::balance::value<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>(&v1.wav_reserves) > 0, 10);
        (0x2::coin::from_balance<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>(0x2::balance::withdraw_all<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>(&mut v1.wav_reserves), arg1), 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut v1.token_reserves), arg1))
    }

    entry fun update_config(arg0: &0xbcf04fd43407271d2db19a1f016b4d9a8cb93169ec2629a3e84adfc22d6dd4::wave_pump::OwnerCap, arg1: &mut App, arg2: address, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: u64, arg9: u64) {
        assert!(arg1.version <= 1, 8);
        arg1.operator = arg2;
        arg1.fee_receiver = arg3;
        arg1.virtual_wav_amount = arg4;
        arg1.initial_token = arg5;
        arg1.listing_dex_threshold = arg6;
        arg1.enable_dex_listing = arg7;
        arg1.swap_fee = arg9;
        arg1.listing_fee = arg8;
        let v0 = ConfigUpdatedEvent{
            operator              : arg2,
            fee_receiver          : arg3,
            virtual_wav_amount    : arg4,
            initial_token         : arg5,
            listing_dex_threshold : arg6,
            listing_fee           : arg8,
            swap_fee              : arg9,
        };
        0x2::event::emit<ConfigUpdatedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

