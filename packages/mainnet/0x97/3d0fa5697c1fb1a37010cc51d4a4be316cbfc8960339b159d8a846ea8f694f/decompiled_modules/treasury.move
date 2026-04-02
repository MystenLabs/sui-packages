module 0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::treasury {
    struct Treasury<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        charity: address,
        charity_reserve: 0x2::balance::Balance<T0>,
        operator_reserve: 0x2::balance::Balance<T0>,
        protocol_reserve: 0x2::balance::Balance<T0>,
        total_charity_accrued: u64,
        total_operator_accrued: u64,
        total_protocol_reserve_accrued: u64,
    }

    struct CharitySet has copy, drop {
        owner: address,
        charity: address,
    }

    struct PermanentShutdownTreasuryDisbursed has copy, drop {
        owner: address,
        charity_amount: u64,
        operator_amount: u64,
        reserve_amount: u64,
    }

    public fun charity<T0>(arg0: &Treasury<T0>) : address {
        arg0.charity
    }

    public fun charity_balance<T0>(arg0: &Treasury<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.charity_reserve)
    }

    public fun claim_charity<T0>(arg0: &mut Treasury<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg1) == arg0.charity, 1);
        0x2::coin::take<T0>(&mut arg0.charity_reserve, 0x2::balance::value<T0>(&arg0.charity_reserve), arg1)
    }

    public fun claim_operator<T0>(arg0: &mut Treasury<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0);
        0x2::coin::take<T0>(&mut arg0.operator_reserve, 0x2::balance::value<T0>(&arg0.operator_reserve), arg1)
    }

    public fun claim_reserve<T0>(arg0: &mut Treasury<T0>, arg1: &0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::Guardrails, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        assert!(0x2::balance::value<T0>(&arg0.protocol_reserve) >= 0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::reserve_claim_threshold(arg1), 0);
        0x2::coin::take<T0>(&mut arg0.protocol_reserve, 0x2::balance::value<T0>(&arg0.protocol_reserve), arg2)
    }

    public fun create<T0>(arg0: address, arg1: address, arg2: &0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::Guardrails, arg3: &mut 0x2::tx_context::TxContext) {
        0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::assert_charity_allowed(arg2, arg1);
        let v0 = Treasury<T0>{
            id                             : 0x2::object::new(arg3),
            owner                          : arg0,
            charity                        : arg1,
            charity_reserve                : 0x2::balance::zero<T0>(),
            operator_reserve               : 0x2::balance::zero<T0>(),
            protocol_reserve               : 0x2::balance::zero<T0>(),
            total_charity_accrued          : 0,
            total_operator_accrued         : 0,
            total_protocol_reserve_accrued : 0,
        };
        0x2::transfer::share_object<Treasury<T0>>(v0);
    }

    public fun credit_charity<T0>(arg0: &mut Treasury<T0>, arg1: 0x2::coin::Coin<T0>) {
        arg0.total_charity_accrued = arg0.total_charity_accrued + 0x2::coin::value<T0>(&arg1);
        0x2::coin::put<T0>(&mut arg0.charity_reserve, arg1);
    }

    public fun credit_operator<T0>(arg0: &mut Treasury<T0>, arg1: 0x2::coin::Coin<T0>) {
        arg0.total_operator_accrued = arg0.total_operator_accrued + 0x2::coin::value<T0>(&arg1);
        0x2::coin::put<T0>(&mut arg0.operator_reserve, arg1);
    }

    public fun credit_reserve<T0>(arg0: &mut Treasury<T0>, arg1: 0x2::coin::Coin<T0>) {
        arg0.total_protocol_reserve_accrued = arg0.total_protocol_reserve_accrued + 0x2::coin::value<T0>(&arg1);
        0x2::coin::put<T0>(&mut arg0.protocol_reserve, arg1);
    }

    public fun disburse_all_on_shutdown<T0>(arg0: &mut Treasury<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0);
        let v0 = 0x2::balance::value<T0>(&arg0.charity_reserve);
        let v1 = 0x2::balance::value<T0>(&arg0.operator_reserve);
        let v2 = 0x2::balance::value<T0>(&arg0.protocol_reserve);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.charity_reserve, v0, arg1), arg0.charity);
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.operator_reserve, v1, arg1), arg0.owner);
        };
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.protocol_reserve, v2, arg1), arg0.charity);
        };
        let v3 = PermanentShutdownTreasuryDisbursed{
            owner           : arg0.owner,
            charity_amount  : v0,
            operator_amount : v1,
            reserve_amount  : v2,
        };
        0x2::event::emit<PermanentShutdownTreasuryDisbursed>(v3);
    }

    public fun operator_balance<T0>(arg0: &Treasury<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.operator_reserve)
    }

    public fun owner<T0>(arg0: &Treasury<T0>) : address {
        arg0.owner
    }

    public fun protocol_reserve_balance<T0>(arg0: &Treasury<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.protocol_reserve)
    }

    public fun set_charity<T0>(arg0: &mut Treasury<T0>, arg1: &0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::Guardrails, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 0);
        0x973d0fa5697c1fb1a37010cc51d4a4be316cbfc8960339b159d8a846ea8f694f::guardrails::assert_charity_allowed(arg1, arg2);
        arg0.charity = arg2;
        let v0 = CharitySet{
            owner   : 0x2::tx_context::sender(arg3),
            charity : arg2,
        };
        0x2::event::emit<CharitySet>(v0);
    }

    public fun total_charity_accrued<T0>(arg0: &Treasury<T0>) : u64 {
        arg0.total_charity_accrued
    }

    public fun total_operator_accrued<T0>(arg0: &Treasury<T0>) : u64 {
        arg0.total_operator_accrued
    }

    public fun total_protocol_reserve_accrued<T0>(arg0: &Treasury<T0>) : u64 {
        arg0.total_protocol_reserve_accrued
    }

    // decompiled from Move bytecode v6
}

