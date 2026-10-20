module 0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::vault {
    struct Vault has key {
        id: 0x2::object::UID,
        version: u64,
        domain: u64,
        bridge: u64,
        client: 0x2::object::ID,
        nonce: u64,
        assets: 0x2::table::Table<0x1::type_name::TypeName, Asset>,
        balances: 0x2::bag::Bag,
        settled: 0x2::table::Table<u64, bool>,
        deposits_paused: bool,
        withdrawals_paused: bool,
        guardian: address,
    }

    struct OwnerCap has store, key {
        id: 0x2::object::UID,
        vault: 0x2::object::ID,
    }

    struct Asset has store {
        scale: u64,
        min_deposit: u64,
        cap: u64,
        enabled: bool,
        per_period: u64,
        available: u64,
        updated_ms: u64,
    }

    struct Deposit has copy, drop {
        vault: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        from: address,
        raw: u64,
        canonical: u64,
        telos_to: u64,
        nonce: u64,
        refund_to: address,
        fill_fee: u64,
        filler: u64,
        memo: vector<u8>,
    }

    struct Released has copy, drop {
        vault: 0x2::object::ID,
        id: u64,
        recipient: address,
        amount: u64,
        fee: u64,
    }

    struct Voided has copy, drop {
        vault: 0x2::object::ID,
        id: u64,
    }

    struct Paused has copy, drop {
        vault: 0x2::object::ID,
        deposits: bool,
        withdrawals: bool,
    }

    public fun add_asset<T0>(arg0: &OwnerCap, arg1: &mut Vault, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        check_owner(arg0, arg1);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, Asset>(&arg1.assets, v0), 18);
        assert!(arg2 > 0, 19);
        let v1 = if (arg5 == 18446744073709551615) {
            0
        } else {
            arg5
        };
        let v2 = Asset{
            scale       : arg2,
            min_deposit : arg3,
            cap         : arg4,
            enabled     : false,
            per_period  : arg5,
            available   : v1,
            updated_ms  : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::table::add<0x1::type_name::TypeName, Asset>(&mut arg1.assets, v0, v2);
    }

    public fun balance_of<T0>(arg0: &Vault) : u64 {
        held<T0>(arg0)
    }

    fun check_owner(arg0: &OwnerCap, arg1: &Vault) {
        check_version(arg1);
        assert!(arg0.vault == 0x2::object::id<Vault>(arg1), 21);
    }

    fun check_version(arg0: &Vault) {
        assert!(arg0.version == 1, 22);
    }

    public fun create(arg0: &0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::telos_client::TelosClient, arg1: u64, arg2: u64, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) : OwnerCap {
        let v0 = Vault{
            id                 : 0x2::object::new(arg5),
            version            : 1,
            domain             : arg1,
            bridge             : arg2,
            client             : 0x2::object::id<0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::telos_client::TelosClient>(arg0),
            nonce              : arg3,
            assets             : 0x2::table::new<0x1::type_name::TypeName, Asset>(arg5),
            balances           : 0x2::bag::new(arg5),
            settled            : 0x2::table::new<u64, bool>(arg5),
            deposits_paused    : true,
            withdrawals_paused : true,
            guardian           : arg4,
        };
        let v1 = OwnerCap{
            id    : 0x2::object::new(arg5),
            vault : 0x2::object::id<Vault>(&v0),
        };
        0x2::transfer::share_object<Vault>(v0);
        v1
    }

    public fun deposit<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: address, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        check_version(arg0);
        assert!(!arg0.deposits_paused, 1);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Asset>(&arg0.assets, v0), 3);
        assert!(arg2 != 0 && arg3 != @0x0, 7);
        assert!(0x1::vector::length<u8>(&arg6) <= 256, 8);
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, Asset>(&arg0.assets, v0);
        assert!(v1.enabled, 4);
        let v2 = 0x2::coin::value<T0>(&arg1) / v1.scale;
        assert!(v2 >= v1.min_deposit && v2 > 0, 5);
        assert!(arg4 < v2, 9);
        let v3 = v2 * v1.scale;
        assert!(v1.cap == 0 || (held<T0>(arg0) + v3) / v1.scale <= v1.cap, 6);
        put<T0>(arg0, 0x2::coin::into_balance<T0>(arg1));
        let v4 = arg0.nonce;
        arg0.nonce = v4 + 1;
        let v5 = Deposit{
            vault     : 0x2::object::id<Vault>(arg0),
            coin_type : 0x1::type_name::into_string(v0),
            from      : 0x2::tx_context::sender(arg7),
            raw       : v3,
            canonical : v2,
            telos_to  : arg2,
            nonce     : v4,
            refund_to : arg3,
            fill_fee  : arg4,
            filler    : arg5,
            memo      : arg6,
        };
        0x2::event::emit<Deposit>(v5);
        0x2::coin::split<T0>(&mut arg1, 0x2::coin::value<T0>(&arg1) - v3, arg7)
    }

    public fun domain(arg0: &Vault) : u64 {
        arg0.domain
    }

    public fun expire(arg0: &mut Vault, arg1: &0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::telos_client::TelosClient, arg2: 0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::withdrawal::Proof, arg3: &0x2::clock::Clock) {
        let v0 = proved(arg0, arg1, &arg2);
        assert!(0x2::clock::timestamp_ms(arg3) / 1000 > 0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::withdrawal::deadline(&v0), 15);
        settle(arg0, 0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::withdrawal::id(&v0));
        let v1 = Voided{
            vault : 0x2::object::id<Vault>(arg0),
            id    : 0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::withdrawal::id(&v0),
        };
        0x2::event::emit<Voided>(v1);
    }

    entry fun expire_entry(arg0: &mut Vault, arg1: &0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::telos_client::TelosClient, arg2: vector<u8>, arg3: u64, arg4: vector<u8>, arg5: vector<vector<u8>>, arg6: vector<bool>, arg7: u32, arg8: u32, arg9: u32, arg10: u32, arg11: u32, arg12: vector<u8>, arg13: vector<vector<u8>>, arg14: vector<bool>, arg15: &0x2::clock::Clock) {
        expire(arg0, arg1, 0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::withdrawal::proof(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14), arg15);
    }

    public fun halt(arg0: &mut Vault, arg1: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(0x2::tx_context::sender(arg1) == arg0.guardian, 20);
        arg0.deposits_paused = true;
        arg0.withdrawals_paused = true;
        let v0 = Paused{
            vault       : 0x2::object::id<Vault>(arg0),
            deposits    : true,
            withdrawals : true,
        };
        0x2::event::emit<Paused>(v0);
    }

    fun held<T0>(arg0: &Vault) : u64 {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            return 0
        };
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0))
    }

    public fun is_settled(arg0: &Vault, arg1: u64) : bool {
        0x2::table::contains<u64, bool>(&arg0.settled, arg1)
    }

    public fun migrate(arg0: &OwnerCap, arg1: &mut Vault) {
        assert!(arg0.vault == 0x2::object::id<Vault>(arg1), 21);
        assert!(arg1.version < 1, 22);
        arg1.version = 1;
    }

    public fun nonce(arg0: &Vault) : u64 {
        arg0.nonce
    }

    fun proved(arg0: &Vault, arg1: &0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::telos_client::TelosClient, arg2: &0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::withdrawal::Proof) : 0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::withdrawal::Withdrawal {
        check_version(arg0);
        assert!(0x2::object::id<0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::telos_client::TelosClient>(arg1) == arg0.client, 10);
        let v0 = 0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::withdrawal::prove(arg1, arg0.bridge, arg2);
        assert!(0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::withdrawal::domain(&v0) == arg0.domain, 11);
        assert!(0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::withdrawal::vault(&v0) == 0x2::object::id_bytes<Vault>(arg0), 12);
        v0
    }

    fun put<T0>(arg0: &mut Vault, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, arg1);
        };
    }

    public fun release<T0>(arg0: &mut Vault, arg1: &0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::telos_client::TelosClient, arg2: 0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::withdrawal::Proof, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!arg0.withdrawals_paused, 2);
        let v0 = proved(arg0, arg1, &arg2);
        assert!(0x2::clock::timestamp_ms(arg3) / 1000 <= 0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::withdrawal::deadline(&v0), 14);
        assert!(0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::withdrawal::token(&v0) == token_of<T0>(), 13);
        assert!(0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::withdrawal::fee(&v0) < 0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::withdrawal::amount(&v0), 9);
        assert!(0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::withdrawal::recipient(&v0) != @0x0, 7);
        settle(arg0, 0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::withdrawal::id(&v0));
        let v1 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Asset>(&arg0.assets, v1), 3);
        let v2 = 0x2::table::borrow_mut<0x1::type_name::TypeName, Asset>(&mut arg0.assets, v1);
        spend(v2, 0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::withdrawal::amount(&v0), 0x2::clock::timestamp_ms(arg3));
        let v3 = v2.scale;
        let v4 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(v4, (0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::withdrawal::amount(&v0) - 0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::withdrawal::fee(&v0)) * v3, arg4), 0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::withdrawal::recipient(&v0));
        let v5 = 0x2::coin::take<T0>(v4, 0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::withdrawal::fee(&v0) * v3, arg4);
        let v6 = Released{
            vault     : 0x2::object::id<Vault>(arg0),
            id        : 0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::withdrawal::id(&v0),
            recipient : 0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::withdrawal::recipient(&v0),
            amount    : 0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::withdrawal::amount(&v0),
            fee       : 0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::withdrawal::fee(&v0),
        };
        0x2::event::emit<Released>(v6);
        v5
    }

    entry fun release_entry<T0>(arg0: &mut Vault, arg1: &0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::telos_client::TelosClient, arg2: vector<u8>, arg3: u64, arg4: vector<u8>, arg5: vector<vector<u8>>, arg6: vector<bool>, arg7: u32, arg8: u32, arg9: u32, arg10: u32, arg11: u32, arg12: vector<u8>, arg13: vector<vector<u8>>, arg14: vector<bool>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = release<T0>(arg0, arg1, 0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::withdrawal::proof(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14), arg15, arg16);
        if (0x2::coin::value<T0>(&v0) == 0) {
            0x2::coin::destroy_zero<T0>(v0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg16));
        };
    }

    public fun set_asset<T0>(arg0: &OwnerCap, arg1: &mut Vault, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock) {
        check_owner(arg0, arg1);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Asset>(&arg1.assets, v0), 3);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, Asset>(&mut arg1.assets, v0);
        if (v1.per_period != 18446744073709551615) {
            spend(v1, 0, 0x2::clock::timestamp_ms(arg6));
        };
        v1.min_deposit = arg2;
        v1.cap = arg3;
        if (arg4 != v1.per_period) {
            let v2 = if (arg4 == 18446744073709551615 || v1.available > arg4) {
                arg4
            } else {
                v1.available
            };
            v1.available = v2;
            v1.per_period = arg4;
        };
        v1.updated_ms = 0x2::clock::timestamp_ms(arg6);
        v1.enabled = arg5;
    }

    public fun set_guardian(arg0: &OwnerCap, arg1: &mut Vault, arg2: address) {
        check_owner(arg0, arg1);
        arg1.guardian = arg2;
    }

    public fun set_paused(arg0: &OwnerCap, arg1: &mut Vault, arg2: bool, arg3: bool) {
        check_owner(arg0, arg1);
        arg1.deposits_paused = arg2;
        arg1.withdrawals_paused = arg3;
        let v0 = Paused{
            vault       : 0x2::object::id<Vault>(arg1),
            deposits    : arg2,
            withdrawals : arg3,
        };
        0x2::event::emit<Paused>(v0);
    }

    fun settle(arg0: &mut Vault, arg1: u64) {
        assert!(!0x2::table::contains<u64, bool>(&arg0.settled, arg1), 16);
        0x2::table::add<u64, bool>(&mut arg0.settled, arg1, true);
    }

    fun spend(arg0: &mut Asset, arg1: u64, arg2: u64) {
        if (arg0.per_period == 18446744073709551615) {
            return
        };
        let v0 = (arg0.available as u128) + (((arg0.per_period as u128) * ((arg2 - arg0.updated_ms) as u128) / (86400000 as u128)) as u128);
        let v1 = if (v0 > (arg0.per_period as u128)) {
            arg0.per_period
        } else {
            (v0 as u64)
        };
        arg0.available = v1;
        arg0.updated_ms = arg2;
        assert!(arg1 <= arg0.available, 17);
        arg0.available = arg0.available - arg1;
    }

    public fun token_of<T0>() : vector<u8> {
        0x1::hash::sha2_256(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())))
    }

    // decompiled from Move bytecode v7
}

