module 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_events {
    struct New has copy, drop {
        memez_fun: address,
        inner_state: address,
        meme: 0x1::type_name::TypeName,
        quote: 0x1::type_name::TypeName,
        curve: 0x1::type_name::TypeName,
        config_key: 0x1::type_name::TypeName,
        migration_witness: 0x1::type_name::TypeName,
        ipx_meme_coin_treasury: address,
        virtual_liquidity: u64,
        target_quote_liquidity: u64,
        meme_balance: u64,
        meme_total_supply: u64,
    }

    struct Pump has copy, drop {
        memez_fun: address,
        meme: 0x1::type_name::TypeName,
        quote: 0x1::type_name::TypeName,
        quote_amount_in: u64,
        meme_amount_out: u64,
        meme_swap_fee: u64,
        quote_swap_fee: u64,
        quote_balance: u64,
        meme_balance: u64,
        quote_virtual_liquidity: u64,
    }

    struct Dump has copy, drop {
        memez_fun: address,
        meme: 0x1::type_name::TypeName,
        quote: 0x1::type_name::TypeName,
        quote_amount_out: u64,
        meme_amount_in: u64,
        meme_swap_fee: u64,
        quote_swap_fee: u64,
        meme_burn_amount: u64,
        quote_balance: u64,
        meme_balance: u64,
        quote_virtual_liquidity: u64,
    }

    struct CanMigrate has copy, drop {
        memez_fun: address,
        migration_witness: 0x1::type_name::TypeName,
    }

    struct Migrated has copy, drop {
        memez_fun: address,
        migration_witness: 0x1::type_name::TypeName,
        quote_amount: u64,
        meme_amount: u64,
        meme: 0x1::type_name::TypeName,
        quote: 0x1::type_name::TypeName,
    }

    public(friend) fun can_migrate(arg0: address, arg1: 0x1::type_name::TypeName) {
        let v0 = CanMigrate{
            memez_fun         : arg0,
            migration_witness : arg1,
        };
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_events_wrapper::emit_event<CanMigrate>(v0);
    }

    public(friend) fun dump<T0, T1>(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        let v0 = Dump{
            memez_fun               : arg0,
            meme                    : 0x1::type_name::get<T0>(),
            quote                   : 0x1::type_name::get<T1>(),
            quote_amount_out        : arg2,
            meme_amount_in          : arg1,
            meme_swap_fee           : arg3,
            quote_swap_fee          : arg4,
            meme_burn_amount        : arg5,
            quote_balance           : arg6,
            meme_balance            : arg7,
            quote_virtual_liquidity : arg8,
        };
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_events_wrapper::emit_event<Dump>(v0);
    }

    public(friend) fun migrated<T0, T1>(arg0: address, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64) {
        let v0 = Migrated{
            memez_fun         : arg0,
            migration_witness : arg1,
            quote_amount      : arg3,
            meme_amount       : arg2,
            meme              : 0x1::type_name::get<T0>(),
            quote             : 0x1::type_name::get<T1>(),
        };
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_events_wrapper::emit_event<Migrated>(v0);
    }

    public(friend) fun new<T0, T1, T2>(arg0: address, arg1: address, arg2: 0x1::type_name::TypeName, arg3: 0x1::type_name::TypeName, arg4: address, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        let v0 = New{
            memez_fun              : arg0,
            inner_state            : arg1,
            meme                   : 0x1::type_name::get<T1>(),
            quote                  : 0x1::type_name::get<T2>(),
            curve                  : 0x1::type_name::get<T0>(),
            config_key             : arg2,
            migration_witness      : arg3,
            ipx_meme_coin_treasury : arg4,
            virtual_liquidity      : arg5,
            target_quote_liquidity : arg6,
            meme_balance           : arg7,
            meme_total_supply      : arg8,
        };
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_events_wrapper::emit_event<New>(v0);
    }

    public(friend) fun pump<T0, T1>(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = Pump{
            memez_fun               : arg0,
            meme                    : 0x1::type_name::get<T0>(),
            quote                   : 0x1::type_name::get<T1>(),
            quote_amount_in         : arg1,
            meme_amount_out         : arg2,
            meme_swap_fee           : arg3,
            quote_swap_fee          : arg4,
            quote_balance           : arg5,
            meme_balance            : arg6,
            quote_virtual_liquidity : arg7,
        };
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_events_wrapper::emit_event<Pump>(v0);
    }

    // decompiled from Move bytecode v6
}

