module 0x2a672dee60b860a1dc9d315d63254a800343e4e9374ce705f65d8dfbf4c5b7ef::pump {
    struct Configuration has store, key {
        id: 0x2::object::UID,
        platform_fee: u64,
        graduated_fee: u64,
        initial_virtual_sui_reserves: u64,
        initial_virtual_token_reserves: u64,
        remain_token_reserves: u64,
        token_decimals: u8,
        max_sui_liquidity: u64,
    }

    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        real_sui_reserves: 0x2::coin::Coin<0x2::sui::SUI>,
        real_token_reserves: 0x2::coin::Coin<T0>,
        virtual_token_reserves: u64,
        virtual_sui_reserves: u64,
        remain_token_reserves: 0x2::coin::Coin<T0>,
        is_completed: bool,
    }

    struct CreatedEvent has copy, drop, store {
        name: 0x1::ascii::String,
        symbol: 0x1::ascii::String,
        uri: 0x1::ascii::String,
        description: 0x1::ascii::String,
        twitter: 0x1::ascii::String,
        telegram: 0x1::ascii::String,
        website: 0x1::ascii::String,
        token_address: 0x1::ascii::String,
        bonding_curve: 0x1::ascii::String,
        pool_id: 0x2::object::ID,
        created_by: address,
        virtual_sui_reserves: u64,
        virtual_token_reserves: u64,
        ts: u64,
    }

    struct PUMP has drop {
        dummy_field: bool,
    }

    public entry fun create_and_first_buy<T0>(arg0: &mut Configuration, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: 0x1::ascii::String, arg6: 0x1::ascii::String, arg7: 0x1::ascii::String, arg8: 0x1::ascii::String, arg9: 0x1::ascii::String, arg10: 0x1::ascii::String, arg11: 0x1::ascii::String, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::ascii::length(&arg5) <= 32, 2);
        assert!(0x1::ascii::length(&arg6) <= 8, 2);
        assert!(0x1::ascii::length(&arg7) <= 320, 2);
        assert!(0x1::ascii::length(&arg8) <= 320, 2);
        assert!(0x1::ascii::length(&arg9) <= 500, 2);
        assert!(0x1::ascii::length(&arg10) <= 500, 2);
        assert!(0x1::ascii::length(&arg11) <= 500, 2);
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 7);
        let v0 = Pool<T0>{
            id                     : 0x2::object::new(arg12),
            real_sui_reserves      : 0x2::coin::zero<0x2::sui::SUI>(arg12),
            real_token_reserves    : 0x2::coin::mint<T0>(&mut arg1, arg0.initial_virtual_token_reserves - arg0.remain_token_reserves, arg12),
            virtual_token_reserves : arg0.initial_virtual_token_reserves,
            virtual_sui_reserves   : arg0.initial_virtual_sui_reserves,
            remain_token_reserves  : 0x2::coin::mint<T0>(&mut arg1, arg0.remain_token_reserves, arg12),
            is_completed           : false,
        };
        let v1 = 0x1::type_name::get<T0>();
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        let v2 = 0x1::type_name::get<Pool<T0>>();
        let v3 = CreatedEvent{
            name                   : arg5,
            symbol                 : arg6,
            uri                    : arg7,
            description            : arg8,
            twitter                : arg9,
            telegram               : arg10,
            website                : arg11,
            token_address          : 0x1::type_name::into_string(v1),
            bonding_curve          : 0x1::type_name::get_module(&v2),
            pool_id                : 0x2::object::id<Pool<T0>>(&v0),
            created_by             : 0x2::tx_context::sender(arg12),
            virtual_sui_reserves   : arg0.initial_virtual_sui_reserves,
            virtual_token_reserves : arg0.initial_virtual_token_reserves,
            ts                     : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<CreatedEvent>(v3);
        0x2::dynamic_object_field::add<0x1::ascii::String, Pool<T0>>(&mut arg0.id, 0x1::type_name::get_address(&v1), v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(arg1, @0x0);
    }

    fun init(arg0: PUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Configuration{
            id                             : 0x2::object::new(arg1),
            platform_fee                   : 990000000,
            graduated_fee                  : 300000000000,
            initial_virtual_sui_reserves   : 400000000000,
            initial_virtual_token_reserves : 10000000000000000,
            remain_token_reserves          : 2000000000000000,
            token_decimals                 : 6,
            max_sui_liquidity              : 2000000000000,
        };
        0x2::transfer::public_share_object<Configuration>(v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<PUMP>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun update_config(arg0: &0x2::package::Publisher, arg1: &mut Configuration, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u8, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_module<Configuration>(arg0), 0);
        arg1.platform_fee = arg2;
        arg1.graduated_fee = arg3;
        arg1.initial_virtual_sui_reserves = arg4;
        arg1.initial_virtual_token_reserves = arg5;
        arg1.remain_token_reserves = arg6;
        arg1.token_decimals = arg7;
        arg1.max_sui_liquidity = arg8;
    }

    // decompiled from Move bytecode v6
}

