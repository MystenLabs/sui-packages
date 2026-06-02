module 0x7c28438735d3314fe1c48ce74e3131eb2025fa21694bd1c58b0fd12753974c2f::config {
    struct AirdropConfig has key {
        id: 0x2::object::UID,
        unlock_timestamp_ms: 0x1::option::Option<u64>,
        recovery_timestamp_ms: u64,
        recovered_tokens: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>,
    }

    struct AirdropConfigCap has store, key {
        id: 0x2::object::UID,
    }

    struct AirdropRecoveryCap has key {
        id: 0x2::object::UID,
    }

    public fun transfer(arg0: AirdropRecoveryCap, arg1: address) {
        0x2::transfer::transfer<AirdropRecoveryCap>(arg0, arg1);
    }

    public fun assert_can_withdraw_funds(arg0: &AirdropConfig, arg1: &0x2::clock::Clock) {
        let v0 = &arg0.unlock_timestamp_ms;
        assert!(0x1::option::is_some<u64>(v0) && 0x2::clock::timestamp_ms(arg1) >= *0x1::option::borrow<u64>(v0), 2);
    }

    public fun enable(arg0: &AirdropConfigCap, arg1: &mut AirdropConfig, arg2: &0x2::clock::Clock, arg3: u64) {
        let v0 = unlock_timestamp_ms(arg1);
        assert!(0x1::option::is_none<u64>(&v0), 0);
        assert!(0x2::clock::timestamp_ms(arg2) < arg3, 1);
        0x1::option::fill<u64>(&mut arg1.unlock_timestamp_ms, arg3);
        arg1.recovery_timestamp_ms = arg3 + 31536000000;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AirdropConfig{
            id                    : 0x2::object::new(arg0),
            unlock_timestamp_ms   : 0x1::option::none<u64>(),
            recovery_timestamp_ms : 0,
            recovered_tokens      : 0x2::balance::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(),
        };
        0x2::transfer::share_object<AirdropConfig>(v0);
        let v1 = AirdropConfigCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AirdropConfigCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public(friend) fun merge_balance(arg0: &mut AirdropConfig, arg1: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.recovered_tokens, arg1);
    }

    public fun new_recovery_cap(arg0: &AirdropConfigCap, arg1: &mut 0x2::tx_context::TxContext) : AirdropRecoveryCap {
        AirdropRecoveryCap{id: 0x2::object::new(arg1)}
    }

    public fun recovery_timestamp_ms(arg0: &AirdropConfig) : u64 {
        arg0.recovery_timestamp_ms
    }

    public fun unlock_timestamp_ms(arg0: &AirdropConfig) : 0x1::option::Option<u64> {
        arg0.unlock_timestamp_ms
    }

    public fun withdraw(arg0: &AirdropConfigCap, arg1: &mut AirdropConfig, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        let v0 = 0x2::balance::withdraw_all<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg1.recovered_tokens);
        0x7c28438735d3314fe1c48ce74e3131eb2025fa21694bd1c58b0fd12753974c2f::events::emit_admin_withdrawal(0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v0));
        0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v0, arg2)
    }

    // decompiled from Move bytecode v6
}

