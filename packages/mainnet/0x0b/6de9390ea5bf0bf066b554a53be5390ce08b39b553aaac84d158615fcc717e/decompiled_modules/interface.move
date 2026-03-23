module 0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::interface {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct INTERFACE has drop {
        dummy_field: bool,
    }

    public fun add_airdrop_coin<T0, T1>(arg0: &0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::version::Version, arg1: &mut 0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::alphafi_ember_pool::Pool<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::tx_context::TxContext) {
        0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::version::assert_current_version(arg0);
        0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::alphafi_ember_pool::add_airdrop_coin<T0, T1>(arg1, arg2, arg3);
    }

    entry fun change_fee_address<T0>(arg0: &AdminCap, arg1: &0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::version::Version, arg2: &mut 0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::alphafi_ember_pool::Pool<T0>, arg3: address) {
        0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::version::assert_current_version(arg1);
        0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::alphafi_ember_pool::change_fee_address<T0>(arg2, arg3);
    }

    entry fun change_locking_period<T0>(arg0: &AdminCap, arg1: &0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::version::Version, arg2: &mut 0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::alphafi_ember_pool::Pool<T0>, arg3: u64) {
        0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::version::assert_current_version(arg1);
        0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::alphafi_ember_pool::change_locking_period<T0>(arg2, arg3);
    }

    entry fun collect_fee<T0>(arg0: &0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::version::Version, arg1: &mut 0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::alphafi_ember_pool::Pool<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::version::assert_current_version(arg0);
        0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::alphafi_ember_pool::collect_fee<T0>(arg1, arg2);
    }

    public fun create_pool<T0>(arg0: &AdminCap, arg1: &0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::version::Version, arg2: address, arg3: u64, arg4: 0x18533807391b15db5f1f530f54b32553372e5c204d179928d8da0a1753cbb63c::alphafi_receipt::PartnerCap, arg5: 0x2::object::ID, arg6: &mut 0x2::tx_context::TxContext) {
        0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::version::assert_current_version(arg1);
        0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::alphafi_ember_pool::create_pool<T0>(arg2, arg3, arg4, arg5, arg6);
    }

    public fun set_admin_address<T0>(arg0: &AdminCap, arg1: &0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::version::Version, arg2: &mut 0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::alphafi_ember_pool::Pool<T0>, arg3: address) {
        0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::version::assert_current_version(arg1);
        0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::alphafi_ember_pool::set_admin_address<T0>(arg2, arg3);
    }

    entry fun set_deposit_fee<T0>(arg0: &AdminCap, arg1: &0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::version::Version, arg2: &mut 0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::alphafi_ember_pool::Pool<T0>, arg3: u64) {
        0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::version::assert_current_version(arg1);
        0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::alphafi_ember_pool::set_deposit_fee<T0>(arg2, arg3);
    }

    public fun set_investor_id<T0>(arg0: &AdminCap, arg1: &0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::version::Version, arg2: &mut 0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::alphafi_ember_pool::Pool<T0>, arg3: 0x2::object::ID) {
        0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::version::assert_current_version(arg1);
        0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::alphafi_ember_pool::set_investor_id<T0>(arg2, arg3);
    }

    entry fun set_pause<T0>(arg0: &AdminCap, arg1: &0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::version::Version, arg2: &mut 0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::alphafi_ember_pool::Pool<T0>, arg3: bool, arg4: bool) {
        0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::version::assert_current_version(arg1);
        0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::alphafi_ember_pool::set_pause<T0>(arg2, arg3, arg4);
    }

    entry fun set_withdrawal_fee<T0>(arg0: &AdminCap, arg1: &0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::version::Version, arg2: &mut 0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::alphafi_ember_pool::Pool<T0>, arg3: u64) {
        0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::version::assert_current_version(arg1);
        0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::alphafi_ember_pool::set_withdrawal_fee<T0>(arg2, arg3);
    }

    public fun add_admin(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<AdminCap>(v0, arg1);
    }

    public fun collect_unsupplied_balance<T0>(arg0: &0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::version::Version, arg1: &mut 0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::alphafi_ember_pool::Pool<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::version::assert_current_version(arg0);
        assert!(0x2::tx_context::sender(arg2) == 0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::alphafi_ember_pool::get_admin_address<T0>(arg1), 1009);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::alphafi_ember_pool::remove_unsupplied_balance<T0>(arg1), arg2), 0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::alphafi_ember_pool::get_admin_address<T0>(arg1));
    }

    fun init(arg0: INTERFACE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun initialize_airdrop_manual<T0, T1>(arg0: &AdminCap, arg1: &0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::version::Version, arg2: &mut 0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::alphafi_ember_pool::Pool<T0>, arg3: &0x2::clock::Clock) {
        0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::version::assert_current_version(arg1);
        0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::alphafi_ember_pool::add_rewards<T0, T1>(arg2, 0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::alphafi_ember_pool::remove_airdrop_balance<T0, T1>(arg2), arg3);
    }

    public fun initialize_pool<T0>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::AdminCap, arg1: &0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::version::Version, arg2: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg3: &mut 0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::alphafi_ember_pool::Pool<T0>, arg4: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Pool<T0>, arg5: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::version::assert_current_version(arg1);
        0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::alphafi_ember_pool::initialize<T0>(arg0, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun process_withdraw_requests_manual<T0>(arg0: &0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::version::Version, arg1: &mut 0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::alphafi_ember_pool::Pool<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::version::assert_current_version(arg0);
        let v0 = 0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::alphafi_ember_pool::process_withdraw_requests<T0>(arg1, 0, true);
        assert!(0x2::coin::value<T0>(&arg2) >= v0, 19192);
        0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::alphafi_ember_pool::add_to_claimable<T0>(arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v0, arg3)));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg3));
    }

    public fun settle_requests_manual<T0>(arg0: &AdminCap, arg1: &0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::version::Version, arg2: &mut 0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::alphafi_ember_pool::Pool<T0>, arg3: &0x2::clock::Clock) {
        0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::version::assert_current_version(arg1);
        0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::alphafi_ember_pool::add_to_unsupplied<T0>(arg2, 0x975430704dc4d8536464a5d78e0938236d0e035a72b8224fb9606b28f6a75658::alphafi_ember_pool::settle_requests<T0>(arg2, arg3));
    }

    // decompiled from Move bytecode v6
}

