module 0xa7f793f3bdcf713da47309829cb3286cf329a35b003a1ec81044f9acf9b60ec1::ido {
    struct Setting has key {
        id: 0x2::object::UID,
        verifier: vector<u8>,
    }

    struct AdminCapability has key {
        id: 0x2::object::UID,
    }

    struct PoolOwner has key {
        id: 0x2::object::UID,
        for: 0x2::object::ID,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        start_time: u64,
        end_time: u64,
        min_deposit: u64,
        price_per_token: u64,
        token_unit: u64,
        total_supply: u64,
        total_deposited: u64,
        tge_time: u64,
        tge_percent: u8,
        vesting_percent: u8,
        vesting_period: u64,
        currency: 0x2::balance::Balance<T0>,
        token: 0x2::balance::Balance<T1>,
        has_whitelist: bool,
    }

    struct Member<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        pool: 0x2::object::ID,
        deposited: u64,
        token_amount: u64,
        latest_redeem_time: 0x1::option::Option<u64>,
        remaining_token: u64,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        has_whitelist: bool,
    }

    struct PoolClosed has copy, drop {
        pool_id: 0x2::object::ID,
    }

    struct Deposited has copy, drop {
        member_id: 0x2::object::ID,
        amount: u64,
    }

    struct Withdrawn has copy, drop {
        member_id: 0x2::object::ID,
        amount: u64,
    }

    struct Claimed has copy, drop {
        member_id: 0x2::object::ID,
        amount: u64,
    }

    struct Redeemed has copy, drop {
        member_id: 0x2::object::ID,
        amount: u64,
    }

    struct ProfitsCollected has copy, drop {
        member_id: 0x2::object::ID,
        amount: u64,
    }

    fun cal_claimable_amount(arg0: u64, arg1: u8) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128) / 100;
        assert!(v0 <= 18446744073709551615, 24);
        (v0 as u64)
    }

    fun cal_sold_token<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        cal_token_amount<T0, T1>(arg0, arg0.total_deposited)
    }

    fun cal_token_amount<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : u64 {
        let v0 = (arg1 as u128) * (arg0.token_unit as u128) / (arg0.price_per_token as u128);
        assert!(v0 <= 18446744073709551615, 24);
        (v0 as u64)
    }

    fun checked_compare(arg0: u64, arg1: u64, arg2: u64) : bool {
        (arg0 as u128) + (arg1 as u128) <= (arg2 as u128)
    }

    public entry fun claim<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut Member<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.pool == 0x2::object::id<Pool<T0, T1>>(arg0), 17);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg0.tge_time <= v0, 18);
        let v1 = if (0x1::option::is_none<u64>(&arg1.latest_redeem_time)) {
            arg1.latest_redeem_time = 0x1::option::some<u64>(arg0.tge_time);
            arg1.remaining_token = arg1.token_amount;
            let v2 = cal_claimable_amount(arg1.token_amount, arg0.tge_percent);
            let v1 = v2;
            if (v2 == 0) {
                v1 = arg1.remaining_token;
            };
            v1
        } else {
            assert!(v0 - *0x1::option::borrow<u64>(&arg1.latest_redeem_time) >= arg0.vesting_period, 18);
            let v3 = cal_claimable_amount(arg1.token_amount, arg0.vesting_percent);
            let v1 = v3;
            if (v3 > arg1.remaining_token) {
                v1 = arg1.remaining_token;
            };
            arg1.latest_redeem_time = 0x1::option::some<u64>(*0x1::option::borrow<u64>(&arg1.latest_redeem_time) + arg0.vesting_period);
            v1
        };
        arg1.remaining_token = arg1.remaining_token - v1;
        if (v1 > 0) {
            let v4 = Claimed{
                member_id : 0x2::object::uid_to_inner(&arg1.id),
                amount    : v1,
            };
            0x2::event::emit<Claimed>(v4);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.token, v1, arg3), 0x2::tx_context::sender(arg3));
        };
    }

    public entry fun close_pool<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &PoolOwner, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.start_time, 8);
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == arg1.for, 19);
        arg0.total_supply = 0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.token, 0x2::balance::value<T1>(&arg0.token), arg3), 0x2::tx_context::sender(arg3));
        let v0 = PoolClosed{pool_id: 0x2::object::id<Pool<T0, T1>>(arg0)};
        0x2::event::emit<PoolClosed>(v0);
    }

    public entry fun collect_currency<T0, T1>(arg0: &PoolOwner, arg1: &mut Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<Pool<T0, T1>>(arg1) == arg0.for, 19);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.end_time, 14);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.currency, 0x2::balance::value<T0>(&arg1.currency), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun collect_remainning_token<T0, T1>(arg0: &PoolOwner, arg1: &mut Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<Pool<T0, T1>>(arg1) == arg0.for, 19);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.end_time, 14);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg1.token, arg1.total_supply - cal_sold_token<T0, T1>(arg1), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun create_pool<T0, T1>(arg0: bool, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u8, arg8: u8, arg9: u64, arg10: &0x2::coin::CoinMetadata<T1>, arg11: &mut 0x2::coin::Coin<T1>, arg12: &AdminCapability, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg13) < arg1, 1);
        assert!(arg2 > 0, 3);
        assert!(arg4 > 0, 5);
        let v0 = 0x2::math::pow(10, 0x2::coin::get_decimals<T1>(arg10));
        assert!(arg3 >= arg4 / v0, 21);
        assert!(arg5 > 0, 6);
        let v1 = arg1 + arg2;
        assert!(v1 <= arg6, 4);
        assert!(arg7 > 0 && (arg7 < 100 && arg8 > 0 || arg7 == 100) && arg7 + arg8 <= 100, 20);
        assert!(0x2::coin::value<T1>(arg11) >= arg5, 7);
        let v2 = 0x2::object::new(arg14);
        let v3 = 0x2::object::uid_to_inner(&v2);
        let v4 = Pool<T0, T1>{
            id              : v2,
            start_time      : arg1,
            end_time        : v1,
            min_deposit     : arg3,
            price_per_token : arg4,
            token_unit      : v0,
            total_supply    : arg5,
            total_deposited : 0,
            tge_time        : arg6,
            tge_percent     : arg7,
            vesting_percent : arg8,
            vesting_period  : arg9,
            currency        : 0x2::balance::zero<T0>(),
            token           : 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg11, arg5, arg14)),
            has_whitelist   : arg0,
        };
        0x2::transfer::share_object<Pool<T0, T1>>(v4);
        let v5 = PoolOwner{
            id  : 0x2::object::new(arg14),
            for : v3,
        };
        0x2::transfer::transfer<PoolOwner>(v5, 0x2::tx_context::sender(arg14));
        let v6 = PoolCreated{
            pool_id       : v3,
            has_whitelist : arg0,
        };
        0x2::event::emit<PoolCreated>(v6);
    }

    public entry fun delete_member<T0, T1>(arg0: Member<T0, T1>) {
        let Member {
            id                 : v0,
            pool               : _,
            deposited          : _,
            token_amount       : _,
            latest_redeem_time : _,
            remaining_token    : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun deposit<T0, T1>(arg0: &Setting, arg1: &mut Pool<T0, T1>, arg2: &mut Member<T0, T1>, arg3: u64, arg4: &mut 0x2::coin::Coin<T0>, arg5: 0x1::option::Option<vector<u8>>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.pool == 0x2::object::id<Pool<T0, T1>>(arg1), 17);
        let v0 = do_deposit<T0, T1>(arg0, arg1, arg4, arg3, arg5, arg6, arg7, arg8);
        assert!(arg6 == 0 || checked_compare(arg2.token_amount, v0, arg6), 9);
        arg2.deposited = arg2.deposited + arg3;
        arg2.token_amount = arg2.token_amount + v0;
        let v1 = Deposited{
            member_id : 0x2::object::uid_to_inner(&arg2.id),
            amount    : arg3,
        };
        0x2::event::emit<Deposited>(v1);
    }

    public entry fun deposit_public_pool<T0, T1>(arg0: &Setting, arg1: &mut Pool<T0, T1>, arg2: &mut Member<T0, T1>, arg3: u64, arg4: &mut 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.has_whitelist, 2);
        deposit<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0x1::option::none<vector<u8>>(), 0, arg5, arg6);
    }

    public entry fun deposit_whitelist_pool<T0, T1>(arg0: &Setting, arg1: &mut Pool<T0, T1>, arg2: &mut Member<T0, T1>, arg3: u64, arg4: &mut 0x2::coin::Coin<T0>, arg5: vector<u8>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.has_whitelist, 2);
        deposit<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0x1::option::some<vector<u8>>(arg5), arg6, arg7, arg8);
    }

    fun do_deposit<T0, T1>(arg0: &Setting, arg1: &mut Pool<T0, T1>, arg2: &mut 0x2::coin::Coin<T0>, arg3: u64, arg4: 0x1::option::Option<vector<u8>>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg1.has_whitelist) {
            assert!(0x1::option::is_some<vector<u8>>(&arg4) && verify_signature(&arg0.verifier, *0x1::option::borrow<vector<u8>>(&arg4), &arg1.id, 0x2::tx_context::sender(arg7), arg5), 11);
        };
        assert!(arg1.total_supply > 0, 22);
        assert!(arg3 >= arg1.min_deposit, 16);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        assert!(arg1.start_time <= v0 && v0 < arg1.end_time, 15);
        assert!(0x2::coin::value<T0>(arg2) >= arg3, 12);
        let v1 = cal_token_amount<T0, T1>(arg1, arg3);
        assert!(checked_compare(cal_sold_token<T0, T1>(arg1), v1, arg1.total_supply), 13);
        0x2::coin::put<T0>(&mut arg1.currency, 0x2::coin::split<T0>(arg2, arg3, arg7));
        arg1.total_deposited = arg1.total_deposited + arg3;
        v1
    }

    fun do_init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCapability{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCapability>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Setting{
            id       : 0x2::object::new(arg0),
            verifier : 0x2::address::to_bytes(0x2::tx_context::sender(arg0)),
        };
        0x2::transfer::share_object<Setting>(v1);
    }

    fun first_deposit<T0, T1>(arg0: &Setting, arg1: &mut Pool<T0, T1>, arg2: u64, arg3: &mut 0x2::coin::Coin<T0>, arg4: 0x1::option::Option<vector<u8>>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = do_deposit<T0, T1>(arg0, arg1, arg3, arg2, arg4, arg5, arg6, arg7);
        assert!(arg5 == 0 || v0 <= arg5, 9);
        let v1 = 0x2::tx_context::sender(arg7);
        assert!(!0x2::dynamic_field::exists_with_type<address, bool>(&arg1.id, v1), 23);
        0x2::dynamic_field::add<address, bool>(&mut arg1.id, v1, true);
        let v2 = Member<T0, T1>{
            id                 : 0x2::object::new(arg7),
            pool               : 0x2::object::id<Pool<T0, T1>>(arg1),
            deposited          : arg2,
            token_amount       : v0,
            latest_redeem_time : 0x1::option::none<u64>(),
            remaining_token    : 0,
        };
        let v3 = Deposited{
            member_id : 0x2::object::uid_to_inner(&v2.id),
            amount    : arg2,
        };
        0x2::event::emit<Deposited>(v3);
        0x2::transfer::transfer<Member<T0, T1>>(v2, v1);
    }

    public entry fun first_deposit_public_pool<T0, T1>(arg0: &Setting, arg1: &mut Pool<T0, T1>, arg2: u64, arg3: &mut 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.has_whitelist, 2);
        first_deposit<T0, T1>(arg0, arg1, arg2, arg3, 0x1::option::none<vector<u8>>(), 0, arg4, arg5);
    }

    public entry fun first_deposit_whitelist_pool<T0, T1>(arg0: &Setting, arg1: &mut Pool<T0, T1>, arg2: u64, arg3: &mut 0x2::coin::Coin<T0>, arg4: vector<u8>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.has_whitelist, 2);
        first_deposit<T0, T1>(arg0, arg1, arg2, arg3, 0x1::option::some<vector<u8>>(arg4), arg5, arg6, arg7);
    }

    public fun get_member_info<T0, T1>(arg0: &Member<T0, T1>) : (0x2::object::ID, u64, u64, 0x1::option::Option<u64>, u64) {
        (arg0.pool, arg0.deposited, arg0.token_amount, arg0.latest_redeem_time, arg0.remaining_token)
    }

    public fun get_pool_balances<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.currency), 0x2::balance::value<T1>(&arg0.token))
    }

    public fun get_pool_info<T0, T1>(arg0: &Pool<T0, T1>) : (bool, u64, u64, u64, u64, u64, u64, u8, u8, u64) {
        (arg0.has_whitelist, arg0.start_time, arg0.end_time, arg0.min_deposit, arg0.price_per_token, arg0.total_supply, arg0.tge_time, arg0.tge_percent, arg0.vesting_percent, arg0.vesting_period)
    }

    public fun get_pool_total_deposited<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.total_deposited
    }

    public fun get_pool_vesting_info<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u8, u8, u64) {
        (arg0.tge_time, arg0.tge_percent, arg0.vesting_percent, arg0.vesting_period)
    }

    public fun get_verifier(arg0: &Setting) : vector<u8> {
        arg0.verifier
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        do_init(arg0);
    }

    public entry fun update_verifier(arg0: &mut Setting, arg1: vector<u8>, arg2: &AdminCapability, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.verifier = arg1;
    }

    fun verify_signature(arg0: &vector<u8>, arg1: vector<u8>, arg2: &0x2::object::UID, arg3: address, arg4: u64) : bool {
        let v0 = 0x2::object::uid_to_bytes(arg2);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg4));
        0x2::ecdsa_k1::secp256k1_verify(&arg1, arg0, &v0, 1)
    }

    // decompiled from Move bytecode v6
}

