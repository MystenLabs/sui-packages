module 0x14b874da49e152d2b2910122330f7eb925d75bdb0a0f8e2c6b9b1162a5560a8c::walrus_subsidies {
    struct V1 {
        dummy_field: bool,
    }

    struct SubsidiesInnerKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        subsidies_id: 0x2::object::ID,
    }

    struct WalrusSubsidies has key {
        id: 0x2::object::UID,
        version: u64,
        package_id: 0x2::object::ID,
    }

    public fun new(arg0: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg2: u32, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : AdminCap {
        let v0 = WalrusSubsidies{
            id         : 0x2::object::new(arg5),
            version    : 1,
            package_id : package_id_for_current_version(),
        };
        let v1 = SubsidiesInnerKey{dummy_field: false};
        0x2::dynamic_field::add<SubsidiesInnerKey, 0x14b874da49e152d2b2910122330f7eb925d75bdb0a0f8e2c6b9b1162a5560a8c::walrus_subsidies_inner::WalrusSubsidiesInnerV1>(&mut v0.id, v1, 0x14b874da49e152d2b2910122330f7eb925d75bdb0a0f8e2c6b9b1162a5560a8c::walrus_subsidies_inner::new(arg0, arg1, arg2, arg3, arg4, arg5));
        let v2 = AdminCap{
            id           : 0x2::object::new(arg5),
            subsidies_id : 0x2::object::uid_to_inner(&v0.id),
        };
        0x2::transfer::share_object<WalrusSubsidies>(v0);
        v2
    }

    public fun add_balance(arg0: &mut WalrusSubsidies, arg1: 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>) {
        check_version(arg0);
        0x14b874da49e152d2b2910122330f7eb925d75bdb0a0f8e2c6b9b1162a5560a8c::walrus_subsidies_inner::add_balance(inner_mut(arg0), arg1);
    }

    public fun add_coin(arg0: &mut WalrusSubsidies, arg1: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>) {
        check_version(arg0);
        0x14b874da49e152d2b2910122330f7eb925d75bdb0a0f8e2c6b9b1162a5560a8c::walrus_subsidies_inner::add_balance(inner_mut(arg0), 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg1));
    }

    fun check_admin(arg0: &WalrusSubsidies, arg1: &AdminCap) {
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg1.subsidies_id, 0);
    }

    fun check_version(arg0: &WalrusSubsidies) {
        assert!(arg0.version == 1, 1);
    }

    fun inner_mut(arg0: &mut WalrusSubsidies) : &mut 0x14b874da49e152d2b2910122330f7eb925d75bdb0a0f8e2c6b9b1162a5560a8c::walrus_subsidies_inner::WalrusSubsidiesInnerV1 {
        let v0 = SubsidiesInnerKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<SubsidiesInnerKey, 0x14b874da49e152d2b2910122330f7eb925d75bdb0a0f8e2c6b9b1162a5560a8c::walrus_subsidies_inner::WalrusSubsidiesInnerV1>(&mut arg0.id, v0)
    }

    fun package_id_for_current_version() : 0x2::object::ID {
        package_id_for_type<V1>()
    }

    fun package_id_for_type<T0>() : 0x2::object::ID {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get_address(&v0);
        0x2::object::id_from_bytes(0x2::hex::decode(0x1::ascii::into_bytes(0x1::ascii::to_lowercase(&v1))))
    }

    public fun process_subsidies(arg0: &mut WalrusSubsidies, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg2: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg3: &0x2::clock::Clock) {
        check_version(arg0);
        0x14b874da49e152d2b2910122330f7eb925d75bdb0a0f8e2c6b9b1162a5560a8c::walrus_subsidies_inner::process_subsidies(inner_mut(arg0), arg1, arg2, arg3);
    }

    public fun set_base_subsidy(arg0: &mut WalrusSubsidies, arg1: &AdminCap, arg2: u64) {
        check_admin(arg0, arg1);
        check_version(arg0);
        0x14b874da49e152d2b2910122330f7eb925d75bdb0a0f8e2c6b9b1162a5560a8c::walrus_subsidies_inner::set_base_subsidy(inner_mut(arg0), arg2);
    }

    public fun set_per_shard_subsidy(arg0: &mut WalrusSubsidies, arg1: &AdminCap, arg2: u64) {
        check_admin(arg0, arg1);
        check_version(arg0);
        0x14b874da49e152d2b2910122330f7eb925d75bdb0a0f8e2c6b9b1162a5560a8c::walrus_subsidies_inner::set_per_shard_subsidy(inner_mut(arg0), arg2);
    }

    public fun set_system_subsidy_rate(arg0: &mut WalrusSubsidies, arg1: &AdminCap, arg2: u32) {
        check_admin(arg0, arg1);
        check_version(arg0);
        0x14b874da49e152d2b2910122330f7eb925d75bdb0a0f8e2c6b9b1162a5560a8c::walrus_subsidies_inner::set_system_subsidy_rate(inner_mut(arg0), arg2);
    }

    // decompiled from Move bytecode v6
}

