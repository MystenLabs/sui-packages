module 0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::llm_allowance {
    struct AllowanceBookKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AllowanceKey has copy, drop, store {
        id: u64,
    }

    struct AllowanceByIdKey has copy, drop, store {
        allowance: 0x2::object::ID,
    }

    struct UsedVoucherKey has copy, drop, store {
        allowance: u64,
        voucher: u64,
    }

    struct GrantKey has copy, drop, store {
        allowance: u64,
        nonce: vector<u8>,
    }

    struct AllowanceBook has store {
        next_id: u64,
        open: u64,
    }

    struct Allowance<phantom T0> has store, key {
        id: 0x2::object::UID,
        escrow: 0x2::balance::Balance<T0>,
        budget: u64,
        max_per_call: u64,
        spend_pk: vector<u8>,
        model_allow_hash: 0x1::option::Option<vector<u8>>,
        expires_ms: u64,
        closing_since_ms: 0x1::option::Option<u64>,
        config_id: 0x2::object::ID,
        provider: 0x2::object::ID,
        spender: 0x1::option::Option<0x2::object::ID>,
    }

    struct UsedVoucher has store {
        reap_after_ms: u64,
    }

    struct Grant<phantom T0> has store {
        escrow: 0x2::balance::Balance<T0>,
        max_cost: u64,
        provider: 0x2::object::ID,
        spender: 0x2::object::ID,
        context: 0x2::object::ID,
        operation: vector<u8>,
        input_hash: vector<u8>,
        reserved_ms: u64,
        settle_by_ms: u64,
        reserved_tx: vector<u8>,
        settled: 0x1::option::Option<u64>,
        ext: vector<u8>,
    }

    public fun allowance_book(arg0: &0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion) : (u64, u64) {
        let v0 = AllowanceBookKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<AllowanceBookKey>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg0), v0)) {
            return (0, 0)
        };
        let v1 = AllowanceBookKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<AllowanceBookKey, AllowanceBook>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg0), v1);
        (v2.next_id, v2.open)
    }

    public fun allowance_by_id(arg0: &0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion, arg1: 0x2::object::ID) : 0x1::option::Option<u64> {
        let v0 = AllowanceByIdKey{allowance: arg1};
        if (!0x2::dynamic_field::exists<AllowanceByIdKey>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg0), v0)) {
            return 0x1::option::none<u64>()
        };
        let v1 = AllowanceByIdKey{allowance: arg1};
        0x1::option::some<u64>(*0x2::dynamic_field::borrow<AllowanceByIdKey, u64>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg0), v1))
    }

    public fun allowance_info<T0>(arg0: &0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion, arg1: u64) : (u64, u64, u64, vector<u8>, 0x1::option::Option<vector<u8>>, u64, 0x1::option::Option<u64>, u64, 0x2::object::ID, 0x2::object::ID, 0x1::option::Option<0x2::object::ID>) {
        let v0 = AllowanceKey{id: arg1};
        assert!(0x2::dynamic_field::exists<AllowanceKey>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg0), v0), 307);
        let v1 = AllowanceKey{id: arg1};
        let v2 = 0x2::dynamic_field::borrow<AllowanceKey, Allowance<T0>>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg0), v1);
        (0x2::balance::value<T0>(&v2.escrow), v2.budget, v2.max_per_call, v2.spend_pk, v2.model_allow_hash, v2.expires_ms, v2.closing_since_ms, release_at<T0>(v2), 0x2::object::id<Allowance<T0>>(v2), v2.provider, v2.spender)
    }

    fun book_mut(arg0: &mut 0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion) : &mut AllowanceBook {
        let v0 = AllowanceBookKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<AllowanceBookKey>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg0), v0)) {
            let v1 = AllowanceBookKey{dummy_field: false};
            let v2 = AllowanceBook{
                next_id : 0,
                open    : 0,
            };
            0x2::dynamic_field::add<AllowanceBookKey, AllowanceBook>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid_mut(arg0), v1, v2);
        };
        let v3 = AllowanceBookKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<AllowanceBookKey, AllowanceBook>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid_mut(arg0), v3)
    }

    public fun create_allowance<T0>(arg0: &0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::Config, arg1: &mut 0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion, arg2: &0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::OwnerCap, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: 0x1::option::Option<0x2::object::ID>, arg8: 0x1::option::Option<vector<u8>>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : u64 {
        0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::check_owner(arg1, arg2);
        0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::assert_live(arg1);
        assert!(!0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::is_paused(arg0), 301);
        0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::assert_pinned_coin<T0>(arg0);
        assert!(0x1::vector::length<u8>(&arg6) == 32 || 0x1::vector::is_empty<u8>(&arg6), 302);
        assert!(0x1::vector::is_empty<u8>(&arg6) == 0x1::option::is_some<0x2::object::ID>(&arg7), 333);
        assert!(0x1::vector::is_empty<u8>(&arg6) || !is_small_order(&arg6), 302);
        if (0x1::option::is_some<vector<u8>>(&arg8)) {
            assert!(0x1::vector::length<u8>(0x1::option::borrow<vector<u8>>(&arg8)) == 32, 303);
        };
        assert!(arg3 > 0 && arg3 <= 50000000, 304);
        assert!(arg4 > 0 && arg4 <= 10000000, 305);
        let v0 = 0x2::clock::timestamp_ms(arg9);
        assert!(arg5 > v0 && arg5 <= v0 + 2592000000, 306);
        let v1 = 0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::allowance_split<T0>(arg0, arg1, arg3, arg9);
        assert!(arg4 <= 0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::effective_charge_cap<T0>(arg0, arg1), 338);
        let v2 = 0x2::object::id<0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion>(arg1);
        let v3 = book_mut(arg1);
        let v4 = v3.next_id;
        v3.next_id = v4 + 1;
        v3.open = v3.open + 1;
        let v5 = 0x2::object::id<0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::Config>(arg0);
        let v6 = Allowance<T0>{
            id               : 0x2::object::new(arg10),
            escrow           : v1,
            budget           : arg3,
            max_per_call     : arg4,
            spend_pk         : arg6,
            model_allow_hash : arg8,
            expires_ms       : arg5,
            closing_since_ms : 0x1::option::none<u64>(),
            config_id        : 0x2::object::id<0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::Config>(arg0),
            provider         : v5,
            spender          : arg7,
        };
        let v7 = 0x2::object::id<Allowance<T0>>(&v6);
        let v8 = AllowanceByIdKey{allowance: v7};
        0x2::dynamic_field::add<AllowanceByIdKey, u64>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid_mut(arg1), v8, v4);
        let v9 = AllowanceKey{id: v4};
        0x2::dynamic_field::add<AllowanceKey, Allowance<T0>>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid_mut(arg1), v9, v6);
        0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::events::emit_allowance_created(v2, v4, arg3, arg4, arg5, arg6, arg8, v7, v5, arg7);
        v4
    }

    public fun finish_revoke<T0>(arg0: &mut 0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = AllowanceKey{id: arg1};
        assert!(0x2::dynamic_field::exists<AllowanceKey>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg0), v0), 307);
        let v1 = 0x2::object::id<0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion>(arg0);
        let v2 = AllowanceKey{id: arg1};
        assert!(0x2::clock::timestamp_ms(arg2) >= release_at<T0>(0x2::dynamic_field::borrow<AllowanceKey, Allowance<T0>>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg0), v2)), 319);
        let v3 = AllowanceKey{id: arg1};
        let Allowance {
            id               : v4,
            escrow           : v5,
            budget           : _,
            max_per_call     : _,
            spend_pk         : _,
            model_allow_hash : _,
            expires_ms       : _,
            closing_since_ms : v11,
            config_id        : _,
            provider         : _,
            spender          : _,
        } = 0x2::dynamic_field::remove<AllowanceKey, Allowance<T0>>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid_mut(arg0), v3);
        let v15 = v11;
        let v16 = v5;
        let v17 = v4;
        let v18 = AllowanceByIdKey{allowance: 0x2::object::uid_to_inner(&v17)};
        0x2::dynamic_field::remove<AllowanceByIdKey, u64>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid_mut(arg0), v18);
        0x2::object::delete(v17);
        0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::allowance_return<T0>(arg0, v16);
        let v19 = book_mut(arg0);
        v19.open = v19.open - 1;
        let v20 = if (0x1::option::is_some<u64>(&v15)) {
            0
        } else {
            1
        };
        0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::events::emit_allowance_closed(v1, arg1, 0x2::balance::value<T0>(&v16), v20);
    }

    public fun grace_ms() : u64 {
        86400000
    }

    public fun grant_info<T0>(arg0: &0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion, arg1: u64, arg2: vector<u8>) : (u64, u64, 0x2::object::ID, 0x2::object::ID, 0x2::object::ID, vector<u8>, vector<u8>, u64, u64, vector<u8>, 0x1::option::Option<u64>, vector<u8>) {
        let v0 = GrantKey{
            allowance : arg1,
            nonce     : arg2,
        };
        assert!(0x2::dynamic_field::exists<GrantKey>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg0), v0), 324);
        let v1 = 0x2::dynamic_field::borrow<GrantKey, Grant<T0>>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg0), v0);
        (0x2::balance::value<T0>(&v1.escrow), v1.max_cost, v1.provider, v1.spender, v1.context, v1.operation, v1.input_hash, v1.reserved_ms, v1.settle_by_ms, v1.reserved_tx, v1.settled, v1.ext)
    }

    public fun has_allowance(arg0: &0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion, arg1: u64) : bool {
        let v0 = AllowanceKey{id: arg1};
        0x2::dynamic_field::exists<AllowanceKey>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg0), v0)
    }

    public fun has_grant(arg0: &0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion, arg1: u64, arg2: vector<u8>) : bool {
        let v0 = GrantKey{
            allowance : arg1,
            nonce     : arg2,
        };
        0x2::dynamic_field::exists<GrantKey>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg0), v0)
    }

    fun is_small_order(arg0: &vector<u8>) : bool {
        let v0 = *arg0;
        0x1::vector::push_back<u8>(&mut v0, 0x1::vector::pop_back<u8>(&mut v0) & 127);
        let v1 = vector[x"0000000000000000000000000000000000000000000000000000000000000000", x"0100000000000000000000000000000000000000000000000000000000000000", x"26e8958fc2b227b045c3f489f2ef98f0d5dfac05d3c63339b13802886d53fc05", x"c7176a703d4dd84fba3c0b760d10670f2a2053fa2c39ccc64ec7fd7792ac037a", x"ecffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f", x"edffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f", x"eeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f"];
        0x1::vector::contains<vector<u8>>(&v1, &v0)
    }

    public fun max_budget() : u64 {
        50000000
    }

    public fun max_ext_bytes() : u64 {
        256
    }

    public fun max_lifetime_ms() : u64 {
        2592000000
    }

    public fun max_per_call() : u64 {
        10000000
    }

    public fun max_voucher_lifetime_ms() : u64 {
        3600000
    }

    fun pay_treasury<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    public fun reap_grant<T0>(arg0: &mut 0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion, arg1: u64, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = GrantKey{
            allowance : arg1,
            nonce     : arg2,
        };
        assert!(0x2::dynamic_field::exists<GrantKey>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg0), v0), 324);
        assert!(0x2::clock::timestamp_ms(arg3) > 0x2::dynamic_field::borrow<GrantKey, Grant<T0>>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg0), v0).settle_by_ms, 327);
        let Grant {
            escrow       : v1,
            max_cost     : _,
            provider     : _,
            spender      : _,
            context      : _,
            operation    : _,
            input_hash   : _,
            reserved_ms  : _,
            settle_by_ms : _,
            reserved_tx  : _,
            settled      : _,
            ext          : _,
        } = 0x2::dynamic_field::remove<GrantKey, Grant<T0>>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid_mut(arg0), v0);
        let v13 = v1;
        let v14 = AllowanceKey{id: arg1};
        let v15 = !0x2::dynamic_field::exists<AllowanceKey>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg0), v14);
        if (v15) {
            0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::allowance_return<T0>(arg0, v13);
        } else {
            let v16 = AllowanceKey{id: arg1};
            0x2::balance::join<T0>(&mut 0x2::dynamic_field::borrow_mut<AllowanceKey, Allowance<T0>>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid_mut(arg0), v16).escrow, v13);
        };
        0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::events::emit_grant_reaped(0x2::object::id<0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion>(arg0), arg1, arg2, 0x2::balance::value<T0>(&v13), v15, 0x2::tx_context::sender(arg4));
    }

    public fun reap_voucher(arg0: &mut 0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = UsedVoucherKey{
            allowance : arg1,
            voucher   : arg2,
        };
        assert!(0x2::dynamic_field::exists<UsedVoucherKey>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg0), v0), 320);
        assert!(0x2::clock::timestamp_ms(arg3) > 0x2::dynamic_field::borrow<UsedVoucherKey, UsedVoucher>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg0), v0).reap_after_ms, 321);
        let UsedVoucher {  } = 0x2::dynamic_field::remove<UsedVoucherKey, UsedVoucher>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid_mut(arg0), v0);
    }

    fun release_at<T0>(arg0: &Allowance<T0>) : u64 {
        let v0 = if (0x1::option::is_some<u64>(&arg0.closing_since_ms) && *0x1::option::borrow<u64>(&arg0.closing_since_ms) < arg0.expires_ms) {
            *0x1::option::borrow<u64>(&arg0.closing_since_ms)
        } else {
            arg0.expires_ms
        };
        v0 + 86400000
    }

    public fun reserve_grant<T0, T1: drop>(arg0: T1, arg1: &0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::Config, arg2: &mut 0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: u64, arg10: vector<u8>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::assert_charger_registered<T1>(arg1);
        0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::assert_live(arg2);
        assert!(!0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::is_paused(arg1), 301);
        0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::assert_pinned_coin<T0>(arg1);
        assert!(0x1::vector::length<u8>(&arg6) >= 1 && 0x1::vector::length<u8>(&arg6) <= 64, 330);
        assert!(0x1::vector::length<u8>(&arg7) >= 1 && 0x1::vector::length<u8>(&arg7) <= 32, 328);
        assert!(0x1::vector::is_empty<u8>(&arg8) || 0x1::vector::length<u8>(&arg8) == 32, 331);
        assert!(0x1::vector::length<u8>(&arg10) <= 256, 335);
        let v0 = AllowanceByIdKey{allowance: arg3};
        assert!(0x2::dynamic_field::exists<AllowanceByIdKey>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg2), v0), 307);
        let v1 = AllowanceByIdKey{allowance: arg3};
        let v2 = *0x2::dynamic_field::borrow<AllowanceByIdKey, u64>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg2), v1);
        let v3 = 0x2::clock::timestamp_ms(arg11);
        let v4 = AllowanceKey{id: v2};
        let v5 = 0x2::dynamic_field::borrow<AllowanceKey, Allowance<T0>>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg2), v4);
        assert!(v5.config_id == 0x2::object::id<0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::Config>(arg1), 308);
        assert!(0x1::option::is_some<0x2::object::ID>(&v5.spender), 337);
        assert!(v5.spender == 0x1::option::some<0x2::object::ID>(arg4), 329);
        assert!(0x1::option::is_none<u64>(&v5.closing_since_ms), 334);
        assert!(v3 < v5.expires_ms, 306);
        assert!(arg9 > 0 && arg9 <= v5.max_per_call, 309);
        let v6 = v5.provider;
        let v7 = v3 + 86400000;
        let v8 = GrantKey{
            allowance : v2,
            nonce     : arg6,
        };
        assert!(!0x2::dynamic_field::exists<GrantKey>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg2), v8), 323);
        let v9 = AllowanceKey{id: v2};
        let v10 = 0x2::dynamic_field::borrow_mut<AllowanceKey, Allowance<T0>>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid_mut(arg2), v9);
        assert!(0x2::balance::value<T0>(&v10.escrow) >= arg9, 317);
        let v11 = Grant<T0>{
            escrow       : 0x2::balance::split<T0>(&mut v10.escrow, arg9),
            max_cost     : arg9,
            provider     : v6,
            spender      : arg4,
            context      : arg5,
            operation    : arg7,
            input_hash   : arg8,
            reserved_ms  : v3,
            settle_by_ms : v7,
            reserved_tx  : *0x2::tx_context::digest(arg12),
            settled      : 0x1::option::none<u64>(),
            ext          : arg10,
        };
        0x2::dynamic_field::add<GrantKey, Grant<T0>>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid_mut(arg2), v8, v11);
        0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::events::emit_grant_reserved(0x2::object::id<0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion>(arg2), v2, arg3, arg6, arg4, arg5, arg7, arg8, arg9, v7, v6, 0x2::balance::value<T0>(&v10.escrow), arg10);
    }

    public fun revoke_allowance<T0>(arg0: &mut 0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion, arg1: &0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::OwnerCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::check_owner(arg0, arg1);
        let v0 = AllowanceKey{id: arg2};
        assert!(0x2::dynamic_field::exists<AllowanceKey>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg0), v0), 307);
        let v1 = AllowanceKey{id: arg2};
        let v2 = 0x2::dynamic_field::borrow_mut<AllowanceKey, Allowance<T0>>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid_mut(arg0), v1);
        assert!(0x1::option::is_none<u64>(&v2.closing_since_ms), 318);
        v2.closing_since_ms = 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg3));
        0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::events::emit_allowance_revoking(0x2::object::id<0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion>(arg0), arg2, release_at<T0>(v2));
    }

    public fun settle_grant<T0>(arg0: &0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::Config, arg1: &0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::IssuerCap, arg2: &mut 0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::assert_issuer(arg0, arg1);
        assert!(!0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::is_paused(arg0), 301);
        0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::assert_pinned_coin<T0>(arg0);
        assert!(0x1::vector::length<u8>(&arg6) <= 256, 336);
        let v0 = GrantKey{
            allowance : arg3,
            nonce     : arg4,
        };
        assert!(0x2::dynamic_field::exists<GrantKey>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg2), v0), 324);
        let v1 = 0x2::object::id<0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::Config>(arg0);
        let v2 = 0x2::dynamic_field::borrow_mut<GrantKey, Grant<T0>>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid_mut(arg2), v0);
        assert!(0x1::option::is_none<u64>(&v2.settled), 325);
        assert!(v2.provider == v1, 332);
        assert!(0x2::clock::timestamp_ms(arg7) < v2.settle_by_ms, 326);
        assert!(arg5 <= v2.max_cost, 310);
        let v3 = v2.max_cost;
        v2.settled = 0x1::option::some<u64>(arg5);
        let v4 = 0x2::balance::withdraw_all<T0>(&mut v2.escrow);
        let v5 = AllowanceKey{id: arg3};
        let v6 = 0x2::dynamic_field::borrow_mut<AllowanceKey, Allowance<T0>>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid_mut(arg2), v5);
        0x2::balance::join<T0>(&mut v6.escrow, v4);
        let v7 = 0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::treasury(arg0);
        pay_treasury<T0>(0x2::balance::split<T0>(&mut v4, arg5), v7, arg8);
        0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::events::emit_grant_settled(0x2::object::id<0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion>(arg2), arg3, arg4, v3, arg5, 0x2::balance::value<T0>(&v6.escrow), v7, v1, arg6);
    }

    public fun settle_voucher<T0>(arg0: &0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::Config, arg1: &0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::IssuerCap, arg2: &mut 0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: vector<u8>, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::assert_issuer(arg0, arg1);
        assert!(!0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::is_paused(arg0), 301);
        0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::assert_pinned_coin<T0>(arg0);
        let v0 = AllowanceKey{id: arg3};
        assert!(0x2::dynamic_field::exists<AllowanceKey>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg2), v0), 307);
        let v1 = 0x2::object::id<0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion>(arg2);
        let v2 = 0x2::clock::timestamp_ms(arg11);
        let v3 = AllowanceKey{id: arg3};
        let v4 = 0x2::dynamic_field::borrow<AllowanceKey, Allowance<T0>>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg2), v3);
        assert!(v4.config_id == 0x2::object::id<0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::Config>(arg0), 308);
        assert!(0x1::option::is_none<0x2::object::ID>(&v4.spender), 337);
        assert!(arg5 <= v4.max_per_call, 309);
        assert!(arg10 <= arg5, 310);
        assert!(arg6 < arg7 && arg7 - arg6 <= 3600000, 311);
        assert!(arg7 <= v4.expires_ms, 312);
        assert!(v2 <= arg7 + 86400000, 313);
        assert!(v2 < release_at<T0>(v4), 314);
        assert!(0x1::vector::length<u8>(&arg8) <= 256, 322);
        let v5 = voucher_message(v1, arg3, arg4, arg5, arg6, arg7, arg8);
        assert!(0x2::ed25519::ed25519_verify(&arg9, &v4.spend_pk, &v5), 315);
        let v6 = UsedVoucherKey{
            allowance : arg3,
            voucher   : arg4,
        };
        assert!(!0x2::dynamic_field::exists<UsedVoucherKey>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg2), v6), 316);
        let v7 = UsedVoucher{reap_after_ms: arg7 + 86400000};
        0x2::dynamic_field::add<UsedVoucherKey, UsedVoucher>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid_mut(arg2), v6, v7);
        let v8 = 0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::account::treasury(arg0);
        let v9 = AllowanceKey{id: arg3};
        let v10 = 0x2::dynamic_field::borrow_mut<AllowanceKey, Allowance<T0>>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid_mut(arg2), v9);
        assert!(arg10 <= 0x2::balance::value<T0>(&v10.escrow), 317);
        pay_treasury<T0>(0x2::balance::split<T0>(&mut v10.escrow, arg10), v8, arg12);
        0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::events::emit_voucher_settled(v1, arg3, arg4, arg5, arg10, arg6, arg7, 0x2::balance::value<T0>(&v10.escrow), v8);
    }

    public fun settle_window_ms() : u64 {
        86400000
    }

    public fun voucher_message(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>) : vector<u8> {
        let v0 = b"daimon.llm.voucher.v1";
        0x1::vector::append<u8>(&mut v0, 0x2::object::id_to_bytes(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg5));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<vector<u8>>(&arg6));
        v0
    }

    public fun voucher_used(arg0: &0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::Aion, arg1: u64, arg2: u64) : bool {
        let v0 = UsedVoucherKey{
            allowance : arg1,
            voucher   : arg2,
        };
        0x2::dynamic_field::exists<UsedVoucherKey>(0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent::uid(arg0), v0)
    }

    // decompiled from Move bytecode v7
}

