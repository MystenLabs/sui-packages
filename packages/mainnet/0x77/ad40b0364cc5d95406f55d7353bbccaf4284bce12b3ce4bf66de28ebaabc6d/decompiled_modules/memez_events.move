module 0x77ad40b0364cc5d95406f55d7353bbccaf4284bce12b3ce4bf66de28ebaabc6d::memez_events {
    struct New has copy, drop {
        memez_fun: address,
        public_key: vector<u8>,
        inner_state: address,
        dev: address,
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
        inner_state: address,
        meme: 0x1::type_name::TypeName,
        quote: 0x1::type_name::TypeName,
        quote_amount_in: u64,
        meme_amount_out: u64,
        meme_swap_fee: u64,
        quote_swap_fee: u64,
        quote_balance: u64,
        meme_balance: u64,
        quote_virtual_liquidity: u64,
        referrer: 0x1::option::Option<address>,
        meme_referrer_fee: u64,
        quote_referrer_fee: u64,
    }

    struct Dump has copy, drop {
        memez_fun: address,
        inner_state: address,
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
        referrer: 0x1::option::Option<address>,
        meme_referrer_fee: u64,
        quote_referrer_fee: u64,
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
        0x77ad40b0364cc5d95406f55d7353bbccaf4284bce12b3ce4bf66de28ebaabc6d::memez_events_wrapper::emit_event<CanMigrate>(v0);
    }

    public(friend) fun dump<T0, T1>(arg0: address, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: 0x1::option::Option<address>, arg11: u64, arg12: u64) {
        let v0 = Dump{
            memez_fun               : arg0,
            inner_state             : arg1,
            meme                    : 0x1::type_name::get<T0>(),
            quote                   : 0x1::type_name::get<T1>(),
            quote_amount_out        : arg3,
            meme_amount_in          : arg2,
            meme_swap_fee           : arg4,
            quote_swap_fee          : arg5,
            meme_burn_amount        : arg6,
            quote_balance           : arg7,
            meme_balance            : arg8,
            quote_virtual_liquidity : arg9,
            referrer                : arg10,
            meme_referrer_fee       : arg11,
            quote_referrer_fee      : arg12,
        };
        0x77ad40b0364cc5d95406f55d7353bbccaf4284bce12b3ce4bf66de28ebaabc6d::memez_events_wrapper::emit_event<Dump>(v0);
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
        0x77ad40b0364cc5d95406f55d7353bbccaf4284bce12b3ce4bf66de28ebaabc6d::memez_events_wrapper::emit_event<Migrated>(v0);
    }

    public(friend) fun new<T0, T1, T2>(arg0: address, arg1: vector<u8>, arg2: address, arg3: address, arg4: 0x1::type_name::TypeName, arg5: 0x1::type_name::TypeName, arg6: address, arg7: u64, arg8: u64, arg9: u64, arg10: u64) {
        let v0 = New{
            memez_fun              : arg0,
            public_key             : arg1,
            inner_state            : arg2,
            dev                    : arg3,
            meme                   : 0x1::type_name::get<T1>(),
            quote                  : 0x1::type_name::get<T2>(),
            curve                  : 0x1::type_name::get<T0>(),
            config_key             : arg4,
            migration_witness      : arg5,
            ipx_meme_coin_treasury : arg6,
            virtual_liquidity      : arg7,
            target_quote_liquidity : arg8,
            meme_balance           : arg9,
            meme_total_supply      : arg10,
        };
        0x77ad40b0364cc5d95406f55d7353bbccaf4284bce12b3ce4bf66de28ebaabc6d::memez_events_wrapper::emit_event<New>(v0);
    }

    public(friend) fun pump<T0, T1>(arg0: address, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: 0x1::option::Option<address>, arg10: u64, arg11: u64) {
        let v0 = Pump{
            memez_fun               : arg0,
            inner_state             : arg1,
            meme                    : 0x1::type_name::get<T0>(),
            quote                   : 0x1::type_name::get<T1>(),
            quote_amount_in         : arg2,
            meme_amount_out         : arg3,
            meme_swap_fee           : arg4,
            quote_swap_fee          : arg5,
            quote_balance           : arg6,
            meme_balance            : arg7,
            quote_virtual_liquidity : arg8,
            referrer                : arg9,
            meme_referrer_fee       : arg10,
            quote_referrer_fee      : arg11,
        };
        0x77ad40b0364cc5d95406f55d7353bbccaf4284bce12b3ce4bf66de28ebaabc6d::memez_events_wrapper::emit_event<Pump>(v0);
    }

    // decompiled from Move bytecode v6
}

