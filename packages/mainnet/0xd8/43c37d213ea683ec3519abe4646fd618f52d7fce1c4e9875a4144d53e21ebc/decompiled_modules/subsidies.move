module 0xd843c37d213ea683ec3519abe4646fd618f52d7fce1c4e9875a4144d53e21ebc::subsidies {
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

    public fun new(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : AdminCap {
        let v0 = Subsidies{
            id                  : 0x2::object::new(arg1),
            buyer_subsidy_rate  : 0,
            system_subsidy_rate : 0,
            subsidy_pool        : 0x2::balance::zero<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(),
            package_id          : arg0,
            version             : 1,
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

    fun apply_subsidies(arg0: &mut Subsidies, arg1: u64, arg2: u32, arg3: &mut 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg4: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg5: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.subsidy_pool) == 0) {
            return
        };
        let v0 = arg1 * (arg0.buyer_subsidy_rate as u64) / (10000 as u64);
        let v1 = arg1 * (arg0.system_subsidy_rate as u64) / (10000 as u64);
        let (v2, v3) = if (0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.subsidy_pool) >= v0 + v1) {
            (v0, v1)
        } else {
            let v4 = 0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.subsidy_pool);
            let v5 = arg0.buyer_subsidy_rate + arg0.system_subsidy_rate;
            (v4 * (arg0.buyer_subsidy_rate as u64) / (v5 as u64), v4 * (arg0.system_subsidy_rate as u64) / (v5 as u64))
        };
        0x2::coin::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg3, 0x2::coin::from_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(0x2::balance::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.subsidy_pool, v2), arg5));
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::add_subsidy(arg4, 0x2::coin::from_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(0x2::balance::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.subsidy_pool, v3), arg5), arg2);
    }

    public fun buyer_subsidy_rate(arg0: &Subsidies) : u16 {
        arg0.buyer_subsidy_rate
    }

    fun check_admin(arg0: &Subsidies, arg1: &AdminCap) {
        assert!(0x2::object::id<Subsidies>(arg0) == arg1.subsidies_id, 1);
    }

    fun check_version_upgrade(arg0: &Subsidies) {
        assert!(arg0.version < 1, 2);
    }

    public fun extend_blob(arg0: &mut Subsidies, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg3: u32, arg4: &mut 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::extend_blob(arg1, arg2, arg3, arg4);
        let v0 = 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg4) - 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg4);
        apply_subsidies(arg0, v0, arg3, arg4, arg1, arg5);
    }

    entry fun migrate(arg0: &mut Subsidies, arg1: &AdminCap, arg2: 0x2::object::ID) {
        check_admin(arg0, arg1);
        check_version_upgrade(arg0);
        arg0.version = 1;
        arg0.package_id = arg2;
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
            version             : 1,
        };
        let v1 = AdminCap{
            id           : 0x2::object::new(arg4),
            subsidies_id : 0x2::object::id<Subsidies>(&v0),
        };
        0x2::transfer::share_object<Subsidies>(v0);
        v1
    }

    public fun reserve_space(arg0: &mut Subsidies, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: u64, arg3: u32, arg4: &mut 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg5: &mut 0x2::tx_context::TxContext) : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage {
        assert!(arg0.version == 1, 2);
        let v0 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::reserve_space(arg1, arg2, arg3, arg4, arg5);
        let v1 = 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg4) - 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg4);
        apply_subsidies(arg0, v1, arg3, arg4, arg1, arg5);
        v0
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

    // decompiled from Move bytecode v6
}

