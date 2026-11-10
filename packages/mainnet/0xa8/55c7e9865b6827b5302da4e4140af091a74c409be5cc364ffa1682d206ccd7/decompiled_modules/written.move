module 0xa855c7e9865b6827b5302da4e4140af091a74c409be5cc364ffa1682d206ccd7::written {
    struct OperatorCap has store, key {
        id: 0x2::object::UID,
    }

    struct Registry<phantom T0> has key {
        id: 0x2::object::UID,
        oracle_pubkey: vector<u8>,
        vault: 0x2::balance::Balance<T0>,
        received: 0x2::bag::Bag,
        by_user: 0x2::table::Table<address, vector<0x2::object::ID>>,
    }

    struct Written<phantom T0> has key {
        id: 0x2::object::UID,
        registry: 0x2::object::ID,
        user: address,
        underlying: vector<u8>,
        hedge: vector<u8>,
        option_type: u8,
        strike: u64,
        amount: u64,
        premium: u64,
        opened_ms: u64,
        expiry_ms: u64,
        collateral: 0x2::balance::Balance<T0>,
        status: u8,
        to_paramx: u64,
    }

    struct QuoteProof has drop {
        domain: vector<u8>,
        registry: 0x2::object::ID,
        user: address,
        collateral: 0x1::ascii::String,
        underlying: vector<u8>,
        hedge: vector<u8>,
        option_type: u8,
        strike: u64,
        amount: u64,
        premium: u64,
        expiry_ms: u64,
        quote_expiry_ms: u64,
    }

    struct CloseProof has drop {
        domain: vector<u8>,
        registry: 0x2::object::ID,
        position: 0x2::object::ID,
        user: address,
        price: u64,
        quote_expiry_ms: u64,
    }

    struct SettleProof has drop {
        domain: vector<u8>,
        registry: 0x2::object::ID,
        underlying: vector<u8>,
        expiry_ms: u64,
        price: u64,
    }

    struct Opened has copy, drop {
        position_id: 0x2::object::ID,
        user: address,
        collateral: 0x1::ascii::String,
        underlying: vector<u8>,
        hedge: vector<u8>,
        option_type: u8,
        strike: u64,
        amount: u64,
        premium: u64,
        opened_ms: u64,
        expiry_ms: u64,
    }

    struct Ended has copy, drop {
        position_id: 0x2::object::ID,
        status: u8,
        to_paramx: u64,
        to_user: u64,
        at_ms: u64,
    }

    fun check_registry<T0, T1>(arg0: &Registry<T0>, arg1: &Written<T1>) {
        assert!(arg1.registry == 0x2::object::id<Registry<T0>>(arg0), 12);
    }

    public fun close<T0, T1>(arg0: &mut Registry<T0>, arg1: &mut Written<T1>, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        check_registry<T0, T1>(arg0, arg1);
        assert!(0x2::tx_context::sender(arg6) == arg1.user, 2);
        assert!(arg1.status == 0, 5);
        let v0 = CloseProof{
            domain          : b"paramx-written-v1",
            registry        : arg1.registry,
            position        : 0x2::object::id<Written<T1>>(arg1),
            user            : arg1.user,
            price           : arg2,
            quote_expiry_ms : arg3,
        };
        verify<T0, CloseProof>(arg0, v0, &arg4);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        assert!(v1 <= arg3, 3);
        assert!(v1 < arg1.expiry_ms, 7);
        assert!(arg2 <= 0x2::balance::value<T1>(&arg1.collateral), 11);
        finish<T0, T1>(arg0, arg1, arg2, 1, v1, arg6);
    }

    fun collateral_for(arg0: u8, arg1: u64, arg2: u64) : u64 {
        if (arg0 == 0) {
            arg2
        } else {
            ((((arg1 as u128) * (arg2 as u128) + 100000000 - 1) / 100000000) as u64)
        }
    }

    public fun collateral_held<T0>(arg0: &Written<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.collateral)
    }

    public fun create_registry<T0>(arg0: &OperatorCap, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry<T0>{
            id            : 0x2::object::new(arg2),
            oracle_pubkey : arg1,
            vault         : 0x2::balance::zero<T0>(),
            received      : 0x2::bag::new(arg2),
            by_user       : 0x2::table::new<address, vector<0x2::object::ID>>(arg2),
        };
        0x2::transfer::share_object<Registry<T0>>(v0);
    }

    public fun deposit<T0>(arg0: &mut Registry<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.vault, 0x2::coin::into_balance<T0>(arg1));
    }

    fun finish<T0, T1>(arg0: &mut Registry<T0>, arg1: &mut Written<T1>, arg2: u64, arg3: u8, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg2 > 0) {
            let v0 = 0x1::type_name::into_string(0x1::type_name::with_original_ids<T1>());
            if (0x2::bag::contains<0x1::ascii::String>(&arg0.received, v0)) {
                0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg0.received, v0), 0x2::balance::split<T1>(&mut arg1.collateral, arg2));
            } else {
                0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg0.received, v0, 0x2::balance::split<T1>(&mut arg1.collateral, arg2));
            };
        };
        let v1 = 0x2::balance::value<T1>(&arg1.collateral);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg1.collateral), arg5), arg1.user);
        };
        arg1.status = arg3;
        arg1.to_paramx = arg2;
        let v2 = Ended{
            position_id : 0x2::object::id<Written<T1>>(arg1),
            status      : arg3,
            to_paramx   : arg2,
            to_user     : v1,
            at_ms       : arg4,
        };
        0x2::event::emit<Ended>(v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<OperatorCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun open<T0, T1>(arg0: &mut Registry<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: vector<u8>, arg10: 0x2::coin::Coin<T1>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg12);
        let v1 = 0x1::type_name::into_string(0x1::type_name::with_original_ids<T1>());
        let v2 = QuoteProof{
            domain          : b"paramx-written-v1",
            registry        : 0x2::object::id<Registry<T0>>(arg0),
            user            : v0,
            collateral      : v1,
            underlying      : arg1,
            hedge           : arg2,
            option_type     : arg3,
            strike          : arg4,
            amount          : arg5,
            premium         : arg6,
            expiry_ms       : arg7,
            quote_expiry_ms : arg8,
        };
        verify<T0, QuoteProof>(arg0, v2, &arg9);
        let v3 = 0x2::clock::timestamp_ms(arg11);
        assert!(v3 <= arg8, 3);
        assert!(v3 < arg7, 7);
        assert!(arg3 <= 1, 8);
        assert!(arg4 > 0 && arg5 > 0, 9);
        assert!(arg3 == 0 || v1 == 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()), 14);
        assert!(0x2::coin::value<T1>(&arg10) == collateral_for(arg3, arg4, arg5), 10);
        assert!(arg6 <= 0x2::balance::value<T0>(&arg0.vault), 4);
        let v4 = Written<T1>{
            id          : 0x2::object::new(arg12),
            registry    : 0x2::object::id<Registry<T0>>(arg0),
            user        : v0,
            underlying  : arg1,
            hedge       : arg2,
            option_type : arg3,
            strike      : arg4,
            amount      : arg5,
            premium     : arg6,
            opened_ms   : v3,
            expiry_ms   : arg7,
            collateral  : 0x2::coin::into_balance<T1>(arg10),
            status      : 0,
            to_paramx   : 0,
        };
        let v5 = 0x2::object::id<Written<T1>>(&v4);
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.by_user, v0)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.by_user, v0, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.by_user, v0), v5);
        let v6 = Opened{
            position_id : v5,
            user        : v0,
            collateral  : v1,
            underlying  : v4.underlying,
            hedge       : v4.hedge,
            option_type : arg3,
            strike      : arg4,
            amount      : arg5,
            premium     : arg6,
            opened_ms   : v3,
            expiry_ms   : arg7,
        };
        0x2::event::emit<Opened>(v6);
        0x2::transfer::share_object<Written<T1>>(v4);
        0x2::coin::take<T0>(&mut arg0.vault, arg6, arg12)
    }

    fun owed<T0>(arg0: &Written<T0>, arg1: u64) : u64 {
        let v0 = if (arg0.option_type == 0) {
            if (arg1 > arg0.strike) {
                ((((arg0.amount as u128) * ((arg1 - arg0.strike) as u128) + (arg1 as u128) - 1) / (arg1 as u128)) as u64)
            } else {
                0
            }
        } else if (arg0.strike > arg1) {
            (((((arg0.strike - arg1) as u128) * (arg0.amount as u128) + 100000000 - 1) / 100000000) as u64)
        } else {
            0
        };
        let v1 = 0x2::balance::value<T0>(&arg0.collateral);
        if (v0 < v1) {
            v0
        } else {
            v1
        }
    }

    public fun received_value<T0, T1>(arg0: &Registry<T0>) : u64 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_original_ids<T1>());
        if (0x2::bag::contains<0x1::ascii::String>(&arg0.received, v0)) {
            0x2::balance::value<T1>(0x2::bag::borrow<0x1::ascii::String, 0x2::balance::Balance<T1>>(&arg0.received, v0))
        } else {
            0
        }
    }

    public fun set_oracle<T0>(arg0: &OperatorCap, arg1: &mut Registry<T0>, arg2: vector<u8>) {
        arg1.oracle_pubkey = arg2;
    }

    public fun settle<T0, T1>(arg0: &mut Registry<T0>, arg1: &mut Written<T1>, arg2: u64, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        check_registry<T0, T1>(arg0, arg1);
        assert!(arg1.status == 0, 5);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 >= arg1.expiry_ms, 6);
        assert!(arg2 > 0, 13);
        let v1 = SettleProof{
            domain     : b"paramx-written-v1",
            registry   : arg1.registry,
            underlying : arg1.underlying,
            expiry_ms  : arg1.expiry_ms,
            price      : arg2,
        };
        verify<T0, SettleProof>(arg0, v1, &arg3);
        let v2 = owed<T1>(arg1, arg2);
        finish<T0, T1>(arg0, arg1, v2, 2, v0, arg5);
    }

    public fun status<T0>(arg0: &Written<T0>) : u8 {
        arg0.status
    }

    public fun to_paramx<T0>(arg0: &Written<T0>) : u64 {
        arg0.to_paramx
    }

    public fun user<T0>(arg0: &Written<T0>) : address {
        arg0.user
    }

    public fun user_positions<T0>(arg0: &Registry<T0>, arg1: address) : vector<0x2::object::ID> {
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.by_user, arg1)) {
            *0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.by_user, arg1)
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
    }

    public fun vault_value<T0>(arg0: &Registry<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.vault)
    }

    fun verify<T0, T1: drop>(arg0: &Registry<T0>, arg1: T1, arg2: &vector<u8>) {
        let v0 = 0x2::bcs::to_bytes<T1>(&arg1);
        assert!(0x2::ed25519::ed25519_verify(arg2, &arg0.oracle_pubkey, &v0), 1);
    }

    public fun withdraw<T0>(arg0: &OperatorCap, arg1: &mut Registry<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg2 <= 0x2::balance::value<T0>(&arg1.vault), 4);
        0x2::coin::take<T0>(&mut arg1.vault, arg2, arg3)
    }

    public fun withdraw_received<T0, T1>(arg0: &OperatorCap, arg1: &mut Registry<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_original_ids<T1>());
        assert!(0x2::bag::contains<0x1::ascii::String>(&arg1.received, v0), 4);
        let v1 = 0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg1.received, v0);
        assert!(arg2 <= 0x2::balance::value<T1>(v1), 4);
        0x2::coin::take<T1>(v1, arg2, arg3)
    }

    // decompiled from Move bytecode v7
}

