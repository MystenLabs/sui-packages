module 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::events {
    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        coll_type: 0x1::string::String,
        interest_rate: u256,
        supply_limit: u64,
        min_coll_ratio: u128,
    }

    struct SupplyLimitUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        coll_type: 0x1::string::String,
        before: u64,
        after: u64,
    }

    struct InterestRateUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        coll_type: 0x1::string::String,
        interest_rate_bps: u64,
    }

    struct LiquidationRuleUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        coll_type: 0x1::string::String,
        before: 0x1::string::String,
        after: 0x1::string::String,
    }

    struct PositionUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        coll_type: 0x1::string::String,
        debtor: address,
        deposit_amount: u64,
        borrow_amount: u64,
        withdraw_amount: u64,
        repay_amount: u64,
        interest_amount: u64,
        current_coll_amount: u64,
        current_debt_amount: u64,
        memo: 0x1::string::String,
    }

    struct SetSecurity has copy, drop {
        vault_id: 0x2::object::ID,
        coll_type: 0x1::string::String,
        sender: address,
        level: 0x1::option::Option<u8>,
    }

    public(friend) fun emit_interest_rate_updated<T0>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = InterestRateUpdated{
            vault_id          : arg0,
            coll_type         : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())),
            interest_rate_bps : arg1,
        };
        0x2::event::emit<InterestRateUpdated>(v0);
    }

    public(friend) fun emit_liquidation_rule_updated<T0>(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName) {
        let v0 = LiquidationRuleUpdated{
            vault_id  : arg0,
            coll_type : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())),
            before    : 0x1::string::from_ascii(0x1::type_name::into_string(arg1)),
            after     : 0x1::string::from_ascii(0x1::type_name::into_string(arg2)),
        };
        0x2::event::emit<LiquidationRuleUpdated>(v0);
    }

    public(friend) fun emit_position_updated<T0>(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: 0x1::string::String) {
        let v0 = PositionUpdated{
            vault_id            : arg0,
            coll_type           : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())),
            debtor              : arg1,
            deposit_amount      : arg2,
            borrow_amount       : arg3,
            withdraw_amount     : arg5,
            repay_amount        : arg4,
            interest_amount     : arg6,
            current_coll_amount : arg7,
            current_debt_amount : arg8,
            memo                : arg9,
        };
        0x2::event::emit<PositionUpdated>(v0);
    }

    public(friend) fun emit_set_security_level<T0>(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::option::Option<u8>) {
        let v0 = SetSecurity{
            vault_id  : arg0,
            coll_type : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())),
            sender    : arg1,
            level     : arg2,
        };
        0x2::event::emit<SetSecurity>(v0);
    }

    public(friend) fun emit_supply_limit_updated<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = SupplyLimitUpdated{
            vault_id  : arg0,
            coll_type : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())),
            before    : arg1,
            after     : arg2,
        };
        0x2::event::emit<SupplyLimitUpdated>(v0);
    }

    public(friend) fun emit_vault_created<T0>(arg0: 0x2::object::ID, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double, arg2: u64, arg3: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float) {
        let v0 = VaultCreated{
            vault_id       : arg0,
            coll_type      : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())),
            interest_rate  : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::to_scaled_val(arg1),
            supply_limit   : arg2,
            min_coll_ratio : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::to_scaled_val(arg3),
        };
        0x2::event::emit<VaultCreated>(v0);
    }

    // decompiled from Move bytecode v6
}

