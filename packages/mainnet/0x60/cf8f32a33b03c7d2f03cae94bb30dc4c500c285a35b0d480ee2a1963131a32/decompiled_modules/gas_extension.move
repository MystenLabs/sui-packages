module 0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas_extension {
    struct ExpiryCostPerMinuteKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ExpiryGasOwnerCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct LimitedInvocationsCostPerInvocationKey has copy, drop, store {
        dummy_field: bool,
    }

    struct LimitedInvocationsGasOwnerCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct LimitedInvocationsMinInvocationsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct LimitedInvocationsMaxInvocationsKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun buy_expiry_gas_ticket(arg0: &mut 0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::ToolGas, arg1: &0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::tool_registry::Tool, arg2: u64, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::get_tool_gas_setting(arg0);
        let v1 = ExpiryGasOwnerCapKey{dummy_field: false};
        assert!(0x2::bag::contains<ExpiryGasOwnerCapKey>(v0, v1), 13906834341847105537);
        let v2 = 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::owner_cap::clone<0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::OverGas>(0x2::bag::borrow<ExpiryGasOwnerCapKey, 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::owner_cap::CloneableOwnerCap<0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::OverGas>>(v0, v1), arg5);
        let v3 = ExpiryCostPerMinuteKey{dummy_field: false};
        0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::add_gas_ticket(arg0, arg1, &mut v2, 0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::scope_invoker_address(0x2::tx_context::sender(arg5)), 0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::modus_operandi_expiry(arg2 * 60 * 1000), arg4);
        0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::owner_cap::destroy<0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::OverGas>(v2);
        0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::donate_to_tool(arg0, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg3), *0x2::bag::borrow<ExpiryCostPerMinuteKey, u64>(v0, v3) * arg2));
    }

    public fun buy_limited_invocations_gas_ticket(arg0: &mut 0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::ToolGas, arg1: &0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::tool_registry::Tool, arg2: u64, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::get_tool_gas_setting(arg0);
        let v1 = LimitedInvocationsGasOwnerCapKey{dummy_field: false};
        assert!(0x2::bag::contains<LimitedInvocationsGasOwnerCapKey>(v0, v1), 13906834741279064065);
        let v2 = LimitedInvocationsGasOwnerCapKey{dummy_field: false};
        let v3 = 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::owner_cap::clone<0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::OverGas>(0x2::bag::borrow<LimitedInvocationsGasOwnerCapKey, 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::owner_cap::CloneableOwnerCap<0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::OverGas>>(v0, v2), arg5);
        let v4 = LimitedInvocationsMinInvocationsKey{dummy_field: false};
        let v5 = LimitedInvocationsMaxInvocationsKey{dummy_field: false};
        assert!(arg2 >= *0x2::bag::borrow<LimitedInvocationsMinInvocationsKey, u64>(v0, v4) && arg2 <= *0x2::bag::borrow<LimitedInvocationsMaxInvocationsKey, u64>(v0, v5), 13906834779933900803);
        let v6 = LimitedInvocationsCostPerInvocationKey{dummy_field: false};
        0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::add_gas_ticket(arg0, arg1, &mut v3, 0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::scope_invoker_address(0x2::tx_context::sender(arg5)), 0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::modus_operandi_limited_invocations(arg2, 0, 0), arg4);
        0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::owner_cap::destroy<0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::OverGas>(v3);
        0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::donate_to_tool(arg0, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg3), *0x2::bag::borrow<LimitedInvocationsCostPerInvocationKey, u64>(v0, v6) * arg2));
    }

    public fun disable_expiry(arg0: &mut 0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::ToolGas, arg1: &0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::tool_registry::Tool, arg2: &mut 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::owner_cap::CloneableOwnerCap<0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::OverGas>) {
        let v0 = 0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::get_tool_gas_setting_mut(arg0, arg1, arg2);
        let v1 = ExpiryGasOwnerCapKey{dummy_field: false};
        if (0x2::bag::contains<ExpiryGasOwnerCapKey>(v0, v1)) {
            let v2 = ExpiryGasOwnerCapKey{dummy_field: false};
            0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::owner_cap::destroy<0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::OverGas>(0x2::bag::remove<ExpiryGasOwnerCapKey, 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::owner_cap::CloneableOwnerCap<0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::OverGas>>(v0, v2));
        };
        let v3 = ExpiryCostPerMinuteKey{dummy_field: false};
        if (0x2::bag::contains<ExpiryCostPerMinuteKey>(v0, v3)) {
            0x2::bag::remove<ExpiryCostPerMinuteKey, u64>(v0, v3);
        };
    }

    public fun disable_limited_invocations(arg0: &mut 0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::ToolGas, arg1: &0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::tool_registry::Tool, arg2: &mut 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::owner_cap::CloneableOwnerCap<0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::OverGas>) {
        let v0 = 0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::get_tool_gas_setting_mut(arg0, arg1, arg2);
        let v1 = LimitedInvocationsGasOwnerCapKey{dummy_field: false};
        if (0x2::bag::contains<LimitedInvocationsGasOwnerCapKey>(v0, v1)) {
            0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::owner_cap::destroy<0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::OverGas>(0x2::bag::remove<LimitedInvocationsGasOwnerCapKey, 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::owner_cap::CloneableOwnerCap<0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::OverGas>>(v0, v1));
        };
        let v2 = LimitedInvocationsCostPerInvocationKey{dummy_field: false};
        if (0x2::bag::contains<LimitedInvocationsCostPerInvocationKey>(v0, v2)) {
            0x2::bag::remove<LimitedInvocationsCostPerInvocationKey, u64>(v0, v2);
        };
        let v3 = LimitedInvocationsMinInvocationsKey{dummy_field: false};
        let v4 = LimitedInvocationsMaxInvocationsKey{dummy_field: false};
        if (0x2::bag::contains<LimitedInvocationsMinInvocationsKey>(v0, v3)) {
            0x2::bag::remove<LimitedInvocationsMinInvocationsKey, u64>(v0, v3);
        };
        if (0x2::bag::contains<LimitedInvocationsMaxInvocationsKey>(v0, v4)) {
            0x2::bag::remove<LimitedInvocationsMaxInvocationsKey, u64>(v0, v4);
        };
    }

    public fun enable_expiry(arg0: &mut 0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::ToolGas, arg1: &0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::tool_registry::Tool, arg2: &mut 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::owner_cap::CloneableOwnerCap<0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::OverGas>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::get_tool_gas_setting_mut(arg0, arg1, arg2);
        let v1 = ExpiryGasOwnerCapKey{dummy_field: false};
        if (!0x2::bag::contains<ExpiryGasOwnerCapKey>(v0, v1)) {
            0x2::bag::add<ExpiryGasOwnerCapKey, 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::owner_cap::CloneableOwnerCap<0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::OverGas>>(v0, v1, 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::owner_cap::clone<0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::OverGas>(arg2, arg4));
        } else {
            0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::owner_cap::destroy<0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::OverGas>(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::owner_cap::clone<0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::OverGas>(arg2, arg4));
        };
        let v2 = ExpiryCostPerMinuteKey{dummy_field: false};
        if (0x2::bag::contains<ExpiryCostPerMinuteKey>(v0, v2)) {
            0x2::bag::remove<ExpiryCostPerMinuteKey, u64>(v0, v2);
        };
        0x2::bag::add<ExpiryCostPerMinuteKey, u64>(v0, v2, arg3);
    }

    public fun enable_limited_invocations(arg0: &mut 0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::ToolGas, arg1: &0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::tool_registry::Tool, arg2: &mut 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::owner_cap::CloneableOwnerCap<0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::OverGas>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::get_tool_gas_setting_mut(arg0, arg1, arg2);
        let v1 = LimitedInvocationsGasOwnerCapKey{dummy_field: false};
        if (!0x2::bag::contains<LimitedInvocationsGasOwnerCapKey>(v0, v1)) {
            let v2 = LimitedInvocationsGasOwnerCapKey{dummy_field: false};
            0x2::bag::add<LimitedInvocationsGasOwnerCapKey, 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::owner_cap::CloneableOwnerCap<0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::OverGas>>(v0, v2, 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::owner_cap::clone<0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::OverGas>(arg2, arg6));
        } else {
            0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::owner_cap::destroy<0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::OverGas>(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::owner_cap::clone<0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::OverGas>(arg2, arg6));
        };
        let v3 = LimitedInvocationsCostPerInvocationKey{dummy_field: false};
        if (0x2::bag::contains<LimitedInvocationsCostPerInvocationKey>(v0, v3)) {
            0x2::bag::remove<LimitedInvocationsCostPerInvocationKey, u64>(v0, v3);
        };
        0x2::bag::add<LimitedInvocationsCostPerInvocationKey, u64>(v0, v3, arg3);
        assert!(arg4 <= arg5, 13906834998977363973);
        let v4 = LimitedInvocationsMinInvocationsKey{dummy_field: false};
        let v5 = LimitedInvocationsMaxInvocationsKey{dummy_field: false};
        if (0x2::bag::contains<LimitedInvocationsMinInvocationsKey>(v0, v4)) {
            0x2::bag::remove<LimitedInvocationsMinInvocationsKey, u64>(v0, v4);
        };
        0x2::bag::add<LimitedInvocationsMinInvocationsKey, u64>(v0, v4, arg4);
        if (0x2::bag::contains<LimitedInvocationsMaxInvocationsKey>(v0, v5)) {
            0x2::bag::remove<LimitedInvocationsMaxInvocationsKey, u64>(v0, v5);
        };
        0x2::bag::add<LimitedInvocationsMaxInvocationsKey, u64>(v0, v5, arg5);
    }

    // decompiled from Move bytecode v6
}

