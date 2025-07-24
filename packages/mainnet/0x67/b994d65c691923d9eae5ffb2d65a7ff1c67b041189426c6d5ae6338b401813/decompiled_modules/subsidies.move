module 0xd843c37d213ea683ec3519abe4646fd618f52d7fce1c4e9875a4144d53e21ebc::subsidies {
    struct V3 {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        subsidies_id: 0x2::object::ID,
    }

    struct Subsidies has store, key {
        id: 0x2::object::UID,
        buyer_subsidy_rate: u16,
        system_subsidy_rate: u16,
        subsidy_pool: 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>,
        package_id: 0x2::object::ID,
        version: u64,
    }

    struct CombinedPayment {
        payment: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>,
        initial_payment_value: u64,
        initial_pool_value: u64,
    }

    public fun new(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : AdminCap {
        let v0 = Subsidies{
            id                  : 0x2::object::new(arg1),
            buyer_subsidy_rate  : 0,
            system_subsidy_rate : 0,
            subsidy_pool        : 0x2::balance::zero<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(),
            package_id          : arg0,
            version             : 3,
        };
        let v1 = AdminCap{
            id           : 0x2::object::new(arg1),
            subsidies_id : 0x2::object::id<Subsidies>(&v0),
        };
        0x2::transfer::share_object<Subsidies>(v0);
        v1
    }

    public fun add_funds(arg0: &mut Subsidies, arg1: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>) {
        0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.subsidy_pool, 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg1));
    }

    public fun admin_cap_subsidies_id(arg0: &AdminCap) : 0x2::object::ID {
        arg0.subsidies_id
    }

    fun allocate_subsidies(arg0: &Subsidies, arg1: u64, arg2: u64) : (u64, u64) {
        if (arg2 == 0) {
            return (0, 0)
        };
        let v0 = arg1 * (arg0.buyer_subsidy_rate as u64) / (10000 as u64);
        let v1 = arg1 * (arg0.system_subsidy_rate as u64) / (10000 as u64);
        if (arg2 >= v0 + v1) {
            (v0, v1)
        } else {
            let v4 = arg0.buyer_subsidy_rate + arg0.system_subsidy_rate;
            (arg2 * (arg0.buyer_subsidy_rate as u64) / (v4 as u64), arg2 * (arg0.system_subsidy_rate as u64) / (v4 as u64))
        }
    }

    public fun buyer_subsidy_rate(arg0: &Subsidies) : u16 {
        arg0.buyer_subsidy_rate
    }

    fun check_admin(arg0: &Subsidies, arg1: &AdminCap) {
        assert!(0x2::object::id<Subsidies>(arg0) == arg1.subsidies_id, 1);
    }

    fun check_version_upgrade(arg0: &Subsidies) {
        assert!(arg0.version < 3, 2);
    }

    fun combine_payment_with_pool(arg0: &mut Subsidies, arg1: &mut 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg2: &mut 0x2::tx_context::TxContext) : CombinedPayment {
        let v0 = 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg1);
        let v1 = 0x2::coin::from_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(0x2::balance::withdraw_all<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.subsidy_pool), arg2);
        0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(0x2::coin::balance_mut<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut v1), 0x2::balance::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(0x2::coin::balance_mut<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg1), v0));
        CombinedPayment{
            payment               : v1,
            initial_payment_value : v0,
            initial_pool_value    : 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&v1),
        }
    }

    public fun extend_blob(arg0: &mut Subsidies, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg3: u32, arg4: &mut 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 3, 2);
        if (0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.subsidy_pool) == 0) {
            0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::extend_blob(arg1, arg2, arg3, arg4);
            return
        };
        let v0 = combine_payment_with_pool(arg0, arg4, arg5);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::extend_blob(arg1, arg2, arg3, &mut v0.payment);
        handle_subsidies_and_payment(arg0, arg1, v0, arg4, arg3, arg5);
    }

    fun handle_subsidies_and_payment(arg0: &mut Subsidies, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: CombinedPayment, arg3: &mut 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg4: u32, arg5: &mut 0x2::tx_context::TxContext) {
        let CombinedPayment {
            payment               : v0,
            initial_payment_value : v1,
            initial_pool_value    : v2,
        } = arg2;
        let v3 = v0;
        let v4 = v2 + v1 - 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&v3);
        0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.subsidy_pool, 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v3));
        let (v5, v6) = allocate_subsidies(arg0, v4, v2);
        0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(0x2::coin::balance_mut<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg3), 0x2::balance::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.subsidy_pool, v1 + v5 - v4));
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::add_subsidy(arg1, 0x2::coin::from_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(0x2::balance::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.subsidy_pool, v6), arg5), arg4);
        assert!(0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg3) <= v1, 13906835273855008767);
    }

    entry fun migrate(arg0: &mut Subsidies, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System) {
        check_version_upgrade(arg0);
        assert!(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::version(arg1) == 2, 2);
        arg0.version = 3;
        arg0.package_id = package_id_for_current_version();
        arg0.buyer_subsidy_rate = 0;
        arg0.system_subsidy_rate = 0;
    }

    public fun new_with_initial_rates_and_funds(arg0: 0x2::object::ID, arg1: u16, arg2: u16, arg3: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg4: &mut 0x2::tx_context::TxContext) : AdminCap {
        assert!(arg1 <= 10000, 0);
        assert!(arg2 <= 10000, 0);
        let v0 = Subsidies{
            id                  : 0x2::object::new(arg4),
            buyer_subsidy_rate  : arg1,
            system_subsidy_rate : arg2,
            subsidy_pool        : 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg3),
            package_id          : arg0,
            version             : 3,
        };
        let v1 = AdminCap{
            id           : 0x2::object::new(arg4),
            subsidies_id : 0x2::object::id<Subsidies>(&v0),
        };
        0x2::transfer::share_object<Subsidies>(v0);
        v1
    }

    fun package_id_for_current_version() : 0x2::object::ID {
        package_id_for_type<V3>()
    }

    fun package_id_for_type<T0>() : 0x2::object::ID {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get_address(&v0);
        0x2::object::id_from_bytes(0x2::hex::decode(0x1::ascii::into_bytes(0x1::ascii::to_lowercase(&v1))))
    }

    public fun register_blob(arg0: &mut Subsidies, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage, arg3: u256, arg4: u256, arg5: u64, arg6: u8, arg7: bool, arg8: &mut 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg9: &mut 0x2::tx_context::TxContext) : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob {
        assert!(arg0.version == 3, 2);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::register_blob(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    public fun reserve_space(arg0: &mut Subsidies, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: u64, arg3: u32, arg4: &mut 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg5: &mut 0x2::tx_context::TxContext) : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage {
        assert!(arg0.version == 3, 2);
        if (0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.subsidy_pool) == 0) {
            return 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::reserve_space(arg1, arg2, arg3, arg4, arg5)
        };
        let v0 = combine_payment_with_pool(arg0, arg4, arg5);
        let v1 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::reserve_space(arg1, arg2, arg3, &mut v0.payment, arg5);
        handle_subsidies_and_payment(arg0, arg1, v0, arg4, arg3, arg5);
        v1
    }

    public fun set_buyer_subsidy_rate(arg0: &mut Subsidies, arg1: &AdminCap, arg2: u16) {
        check_admin(arg0, arg1);
        assert!(arg2 <= 10000, 0);
        arg0.buyer_subsidy_rate = arg2;
    }

    public fun set_system_subsidy_rate(arg0: &mut Subsidies, arg1: &AdminCap, arg2: u16) {
        check_admin(arg0, arg1);
        assert!(arg2 <= 10000, 0);
        arg0.system_subsidy_rate = arg2;
    }

    public fun subsidy_pool_value(arg0: &Subsidies) : u64 {
        0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.subsidy_pool)
    }

    public fun system_subsidy_rate(arg0: &Subsidies) : u16 {
        arg0.system_subsidy_rate
    }

    public fun withdraw_balance(arg0: &mut Subsidies, arg1: &AdminCap) : 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL> {
        check_admin(arg0, arg1);
        0x2::balance::withdraw_all<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.subsidy_pool)
    }

    // decompiled from Move bytecode v6
}

