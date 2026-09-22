module 0x850157d11a67d7a61d80b073d866b4f0eac3f80fd5a9ec2840eed45d3fa7e73::desk {
    struct Desk<phantom T0, phantom T1, phantom T2> has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        treasury: 0x2::coin::TreasuryCap<T0>,
        vault: 0x2::balance::Balance<T1>,
        escrow: 0x2::balance::Balance<T2>,
        fees: 0x2::balance::Balance<T2>,
        quote_key: vector<u8>,
        oracle: vector<u8>,
        spread_bps: u64,
        max_age_secs: u64,
        coin_decimals: u8,
        quote_decimals: u8,
        operator: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        desk: 0x2::object::ID,
    }

    struct Quote has copy, drop {
        key: vector<u8>,
        price: u64,
        expo_negative: bool,
        expo: u8,
        timestamp_ms: u64,
    }

    struct DeskCreated has copy, drop {
        desk: 0x2::object::ID,
        quote_key: vector<u8>,
        oracle: vector<u8>,
        coin_decimals: u8,
        quote_decimals: u8,
    }

    struct Bought has copy, drop {
        desk: 0x2::object::ID,
        buyer: address,
        quote_in: u64,
        fee: u64,
        coins_out: u64,
        price: u64,
        expo_negative: bool,
        expo: u8,
        quoted_at_ms: u64,
        owed: u64,
    }

    struct Sold has copy, drop {
        desk: 0x2::object::ID,
        seller: address,
        coins_in: u64,
        fee: u64,
        quote_out: u64,
        price: u64,
        expo_negative: bool,
        expo: u8,
        quoted_at_ms: u64,
    }

    struct Redeemed has copy, drop {
        desk: 0x2::object::ID,
        who: address,
        amount: u64,
    }

    struct Wrapped has copy, drop {
        desk: 0x2::object::ID,
        who: address,
        amount: u64,
    }

    struct EscrowMoved has copy, drop {
        desk: 0x2::object::ID,
        who: address,
        amount: u64,
        out: bool,
        escrow_after: u64,
    }

    struct BackingMoved has copy, drop {
        desk: 0x2::object::ID,
        who: address,
        amount: u64,
        into: bool,
        vault_after: u64,
        supply: u64,
    }

    struct FeesWithdrawn has copy, drop {
        desk: 0x2::object::ID,
        amount: u64,
    }

    struct ParamsChanged has copy, drop {
        desk: 0x2::object::ID,
        paused: bool,
        spread_bps: u64,
        max_age_secs: u64,
        operator: address,
        oracle: vector<u8>,
    }

    public fun admin_desk(arg0: &AdminCap) : 0x2::object::ID {
        arg0.desk
    }

    fun as_u64(arg0: u256) : u64 {
        assert!(arg0 <= 18446744073709551615, 13);
        (arg0 as u64)
    }

    public fun buy<T0, T1, T2>(arg0: &mut Desk<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: u64, arg3: bool, arg4: u8, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        check_quote<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5, &arg6, arg7);
        buy_at<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg8, arg9)
    }

    fun buy_at<T0, T1, T2>(arg0: &mut Desk<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: u64, arg3: bool, arg4: u8, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        check_version<T0, T1, T2>(arg0);
        assert!(!arg0.paused, 1);
        let v0 = 0x2::coin::value<T2>(&arg1);
        assert!(v0 > 0, 10);
        let (v1, v2) = quote_buy<T0, T1, T2>(arg0, arg2, arg3, arg4, v0);
        assert!(v1 > 0 && v1 >= arg6, 7);
        let v3 = 0x2::coin::into_balance<T2>(arg1);
        0x2::balance::join<T2>(&mut arg0.fees, 0x2::balance::split<T2>(&mut v3, v2));
        0x2::balance::join<T2>(&mut arg0.escrow, v3);
        let (v4, _) = owed<T0, T1, T2>(arg0);
        let v6 = Bought{
            desk          : 0x2::object::id<Desk<T0, T1, T2>>(arg0),
            buyer         : 0x2::tx_context::sender(arg7),
            quote_in      : v0,
            fee           : v2,
            coins_out     : v1,
            price         : arg2,
            expo_negative : arg3,
            expo          : arg4,
            quoted_at_ms  : arg5,
            owed          : v4,
        };
        0x2::event::emit<Bought>(v6);
        0x2::coin::mint<T0>(&mut arg0.treasury, v1, arg7)
    }

    fun check_admin<T0, T1, T2>(arg0: &Desk<T0, T1, T2>, arg1: &AdminCap) {
        check_version<T0, T1, T2>(arg0);
        assert!(arg1.desk == 0x2::object::id<Desk<T0, T1, T2>>(arg0), 3);
    }

    fun check_operator<T0, T1, T2>(arg0: &Desk<T0, T1, T2>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.operator, 2);
    }

    fun check_quote<T0, T1, T2>(arg0: &Desk<T0, T1, T2>, arg1: u64, arg2: bool, arg3: u8, arg4: u64, arg5: &vector<u8>, arg6: &0x2::clock::Clock) {
        assert!(arg1 > 0 && arg3 <= 30, 5);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        assert!(arg4 + arg0.max_age_secs * 1000 >= v0, 6);
        assert!(arg4 <= v0 + 60000, 6);
        assert!(0x1::vector::length<u8>(arg5) == 64, 4);
        let v1 = quote_bytes<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4);
        assert!(0x2::ed25519::ed25519_verify(arg5, &arg0.oracle, &v1), 4);
    }

    fun check_version<T0, T1, T2>(arg0: &Desk<T0, T1, T2>) {
        assert!(arg0.version == 1, 0);
    }

    public fun create<T0, T1, T2>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: u8, arg5: u64, arg6: u64, arg7: address, arg8: &mut 0x2::tx_context::TxContext) : AdminCap {
        assert!(0x2::coin::total_supply<T0>(&arg0) == 0, 12);
        assert!(0x1::vector::length<u8>(&arg1) > 0 && 0x1::vector::length<u8>(&arg2) == 32, 11);
        assert!(arg5 < 10000 && arg6 > 0, 11);
        assert!(arg3 <= 18 && arg4 <= 18, 11);
        let v0 = Desk<T0, T1, T2>{
            id             : 0x2::object::new(arg8),
            version        : 1,
            paused         : false,
            treasury       : arg0,
            vault          : 0x2::balance::zero<T1>(),
            escrow         : 0x2::balance::zero<T2>(),
            fees           : 0x2::balance::zero<T2>(),
            quote_key      : arg1,
            oracle         : arg2,
            spread_bps     : arg5,
            max_age_secs   : arg6,
            coin_decimals  : arg3,
            quote_decimals : arg4,
            operator       : arg7,
        };
        let v1 = 0x2::object::id<Desk<T0, T1, T2>>(&v0);
        let v2 = DeskCreated{
            desk           : v1,
            quote_key      : v0.quote_key,
            oracle         : v0.oracle,
            coin_decimals  : arg3,
            quote_decimals : arg4,
        };
        0x2::event::emit<DeskCreated>(v2);
        0x2::transfer::share_object<Desk<T0, T1, T2>>(v0);
        AdminCap{
            id   : 0x2::object::new(arg8),
            desk : v1,
        }
    }

    public fun deposit_backing<T0, T1, T2>(arg0: &mut Desk<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::tx_context::TxContext) {
        check_version<T0, T1, T2>(arg0);
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 10);
        0x2::balance::join<T1>(&mut arg0.vault, 0x2::coin::into_balance<T1>(arg1));
        let v1 = BackingMoved{
            desk        : 0x2::object::id<Desk<T0, T1, T2>>(arg0),
            who         : 0x2::tx_context::sender(arg2),
            amount      : v0,
            into        : true,
            vault_after : 0x2::balance::value<T1>(&arg0.vault),
            supply      : 0x2::coin::total_supply<T0>(&arg0.treasury),
        };
        0x2::event::emit<BackingMoved>(v1);
    }

    public fun deposit_escrow<T0, T1, T2>(arg0: &mut Desk<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: &0x2::tx_context::TxContext) {
        check_version<T0, T1, T2>(arg0);
        let v0 = 0x2::coin::value<T2>(&arg1);
        assert!(v0 > 0, 10);
        0x2::balance::join<T2>(&mut arg0.escrow, 0x2::coin::into_balance<T2>(arg1));
        let v1 = EscrowMoved{
            desk         : 0x2::object::id<Desk<T0, T1, T2>>(arg0),
            who          : 0x2::tx_context::sender(arg2),
            amount       : v0,
            out          : false,
            escrow_after : 0x2::balance::value<T2>(&arg0.escrow),
        };
        0x2::event::emit<EscrowMoved>(v1);
    }

    fun emit_params<T0, T1, T2>(arg0: &Desk<T0, T1, T2>) {
        let v0 = ParamsChanged{
            desk         : 0x2::object::id<Desk<T0, T1, T2>>(arg0),
            paused       : arg0.paused,
            spread_bps   : arg0.spread_bps,
            max_age_secs : arg0.max_age_secs,
            operator     : arg0.operator,
            oracle       : arg0.oracle,
        };
        0x2::event::emit<ParamsChanged>(v0);
    }

    public fun escrow_value<T0, T1, T2>(arg0: &Desk<T0, T1, T2>) : u64 {
        0x2::balance::value<T2>(&arg0.escrow)
    }

    public fun fees_value<T0, T1, T2>(arg0: &Desk<T0, T1, T2>) : u64 {
        0x2::balance::value<T2>(&arg0.fees)
    }

    public fun is_paused<T0, T1, T2>(arg0: &Desk<T0, T1, T2>) : bool {
        arg0.paused
    }

    public fun max_age_secs<T0, T1, T2>(arg0: &Desk<T0, T1, T2>) : u64 {
        arg0.max_age_secs
    }

    public fun operator<T0, T1, T2>(arg0: &Desk<T0, T1, T2>) : address {
        arg0.operator
    }

    public fun oracle<T0, T1, T2>(arg0: &Desk<T0, T1, T2>) : vector<u8> {
        arg0.oracle
    }

    public fun owed<T0, T1, T2>(arg0: &Desk<T0, T1, T2>) : (u64, u64) {
        let v0 = 0x2::coin::total_supply<T0>(&arg0.treasury);
        let v1 = 0x2::balance::value<T1>(&arg0.vault);
        if (v0 >= v1) {
            (v0 - v1, 0)
        } else {
            (0, v1 - v0)
        }
    }

    fun pow10(arg0: u8) : u256 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun quote_buy<T0, T1, T2>(arg0: &Desk<T0, T1, T2>, arg1: u64, arg2: bool, arg3: u8, arg4: u64) : (u64, u64) {
        let v0 = (((arg4 as u128) * ((10000 - arg0.spread_bps) as u128) / (10000 as u128)) as u64);
        let (v1, v2) = scale(arg2, arg3);
        (as_u64((v0 as u256) * pow10(arg0.coin_decimals) * v2 / pow10(arg0.quote_decimals) * (arg1 as u256) * v1), arg4 - v0)
    }

    public fun quote_bytes<T0, T1, T2>(arg0: &Desk<T0, T1, T2>, arg1: u64, arg2: bool, arg3: u8, arg4: u64) : vector<u8> {
        let v0 = Quote{
            key           : arg0.quote_key,
            price         : arg1,
            expo_negative : arg2,
            expo          : arg3,
            timestamp_ms  : arg4,
        };
        0x2::bcs::to_bytes<Quote>(&v0)
    }

    public fun quote_key<T0, T1, T2>(arg0: &Desk<T0, T1, T2>) : vector<u8> {
        arg0.quote_key
    }

    public fun quote_sell<T0, T1, T2>(arg0: &Desk<T0, T1, T2>, arg1: u64, arg2: bool, arg3: u8, arg4: u64) : (u64, u64) {
        let (v0, v1) = scale(arg2, arg3);
        let v2 = as_u64((arg4 as u256) * (arg1 as u256) * v0 * pow10(arg0.quote_decimals) / pow10(arg0.coin_decimals) * v1);
        let v3 = (((v2 as u128) * (arg0.spread_bps as u128) / (10000 as u128)) as u64);
        (v2 - v3, v3)
    }

    public fun redeem<T0, T1, T2>(arg0: &mut Desk<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        check_version<T0, T1, T2>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 10);
        assert!(0x2::balance::value<T1>(&arg0.vault) >= v0, 9);
        0x2::coin::burn<T0>(&mut arg0.treasury, arg1);
        let v1 = Redeemed{
            desk   : 0x2::object::id<Desk<T0, T1, T2>>(arg0),
            who    : 0x2::tx_context::sender(arg2),
            amount : v0,
        };
        0x2::event::emit<Redeemed>(v1);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.vault, v0), arg2)
    }

    fun scale(arg0: bool, arg1: u8) : (u256, u256) {
        if (arg0) {
            (1, pow10(arg1))
        } else {
            (pow10(arg1), 1)
        }
    }

    public fun sell<T0, T1, T2>(arg0: &mut Desk<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: bool, arg4: u8, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        check_quote<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5, &arg6, arg7);
        sell_at<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg8, arg9)
    }

    fun sell_at<T0, T1, T2>(arg0: &mut Desk<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: bool, arg4: u8, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        check_version<T0, T1, T2>(arg0);
        assert!(!arg0.paused, 1);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 10);
        let (v1, v2) = quote_sell<T0, T1, T2>(arg0, arg2, arg3, arg4, v0);
        assert!(v1 > 0 && v1 >= arg6, 7);
        assert!(0x2::balance::value<T2>(&arg0.escrow) >= v1 + v2, 8);
        0x2::coin::burn<T0>(&mut arg0.treasury, arg1);
        0x2::balance::join<T2>(&mut arg0.fees, 0x2::balance::split<T2>(&mut arg0.escrow, v2));
        let v3 = Sold{
            desk          : 0x2::object::id<Desk<T0, T1, T2>>(arg0),
            seller        : 0x2::tx_context::sender(arg7),
            coins_in      : v0,
            fee           : v2,
            quote_out     : v1,
            price         : arg2,
            expo_negative : arg3,
            expo          : arg4,
            quoted_at_ms  : arg5,
        };
        0x2::event::emit<Sold>(v3);
        0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut arg0.escrow, v1), arg7)
    }

    public fun set_max_age<T0, T1, T2>(arg0: &mut Desk<T0, T1, T2>, arg1: &AdminCap, arg2: u64) {
        check_admin<T0, T1, T2>(arg0, arg1);
        assert!(arg2 > 0, 11);
        arg0.max_age_secs = arg2;
        emit_params<T0, T1, T2>(arg0);
    }

    public fun set_operator<T0, T1, T2>(arg0: &mut Desk<T0, T1, T2>, arg1: &AdminCap, arg2: address) {
        check_admin<T0, T1, T2>(arg0, arg1);
        arg0.operator = arg2;
        emit_params<T0, T1, T2>(arg0);
    }

    public fun set_oracle<T0, T1, T2>(arg0: &mut Desk<T0, T1, T2>, arg1: &AdminCap, arg2: vector<u8>) {
        check_admin<T0, T1, T2>(arg0, arg1);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 11);
        arg0.oracle = arg2;
        emit_params<T0, T1, T2>(arg0);
    }

    public fun set_paused<T0, T1, T2>(arg0: &mut Desk<T0, T1, T2>, arg1: &AdminCap, arg2: bool) {
        check_admin<T0, T1, T2>(arg0, arg1);
        arg0.paused = arg2;
        emit_params<T0, T1, T2>(arg0);
    }

    public fun set_spread<T0, T1, T2>(arg0: &mut Desk<T0, T1, T2>, arg1: &AdminCap, arg2: u64) {
        check_admin<T0, T1, T2>(arg0, arg1);
        assert!(arg2 < 10000, 11);
        arg0.spread_bps = arg2;
        emit_params<T0, T1, T2>(arg0);
    }

    public fun spread_bps<T0, T1, T2>(arg0: &Desk<T0, T1, T2>) : u64 {
        arg0.spread_bps
    }

    public fun supply<T0, T1, T2>(arg0: &Desk<T0, T1, T2>) : u64 {
        0x2::coin::total_supply<T0>(&arg0.treasury)
    }

    public fun vault_value<T0, T1, T2>(arg0: &Desk<T0, T1, T2>) : u64 {
        0x2::balance::value<T1>(&arg0.vault)
    }

    public fun withdraw_escrow<T0, T1, T2>(arg0: &mut Desk<T0, T1, T2>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        check_version<T0, T1, T2>(arg0);
        check_operator<T0, T1, T2>(arg0, arg2);
        assert!(arg1 > 0, 10);
        assert!(0x2::balance::value<T2>(&arg0.escrow) >= arg1, 8);
        let v0 = EscrowMoved{
            desk         : 0x2::object::id<Desk<T0, T1, T2>>(arg0),
            who          : 0x2::tx_context::sender(arg2),
            amount       : arg1,
            out          : true,
            escrow_after : 0x2::balance::value<T2>(&arg0.escrow),
        };
        0x2::event::emit<EscrowMoved>(v0);
        0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut arg0.escrow, arg1), arg2)
    }

    public fun withdraw_fees<T0, T1, T2>(arg0: &mut Desk<T0, T1, T2>, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        check_admin<T0, T1, T2>(arg0, arg1);
        let v0 = 0x2::balance::value<T2>(&arg0.fees);
        assert!(v0 > 0, 10);
        let v1 = FeesWithdrawn{
            desk   : 0x2::object::id<Desk<T0, T1, T2>>(arg0),
            amount : v0,
        };
        0x2::event::emit<FeesWithdrawn>(v1);
        0x2::coin::from_balance<T2>(0x2::balance::withdraw_all<T2>(&mut arg0.fees), arg2)
    }

    public fun withdraw_surplus<T0, T1, T2>(arg0: &mut Desk<T0, T1, T2>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        check_version<T0, T1, T2>(arg0);
        check_operator<T0, T1, T2>(arg0, arg2);
        assert!(arg1 > 0, 10);
        let (_, v1) = owed<T0, T1, T2>(arg0);
        assert!(v1 >= arg1, 9);
        let v2 = BackingMoved{
            desk        : 0x2::object::id<Desk<T0, T1, T2>>(arg0),
            who         : 0x2::tx_context::sender(arg2),
            amount      : arg1,
            into        : false,
            vault_after : 0x2::balance::value<T1>(&arg0.vault),
            supply      : 0x2::coin::total_supply<T0>(&arg0.treasury),
        };
        0x2::event::emit<BackingMoved>(v2);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.vault, arg1), arg2)
    }

    public fun wrap<T0, T1, T2>(arg0: &mut Desk<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        check_version<T0, T1, T2>(arg0);
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 10);
        0x2::balance::join<T1>(&mut arg0.vault, 0x2::coin::into_balance<T1>(arg1));
        let v1 = Wrapped{
            desk   : 0x2::object::id<Desk<T0, T1, T2>>(arg0),
            who    : 0x2::tx_context::sender(arg2),
            amount : v0,
        };
        0x2::event::emit<Wrapped>(v1);
        0x2::coin::mint<T0>(&mut arg0.treasury, v0, arg2)
    }

    // decompiled from Move bytecode v7
}

