module 0xb6ec392c49fc79fd66bcd63eb7c105cd6dfbc1331e0a367305cb6cb2312efb11::ve_sca {
    struct VeSca has copy, drop, store {
        locked_sca_amount: u64,
        unlock_at: u64,
    }

    struct VeScaTable has key {
        id: 0x2::object::UID,
        table: 0x2::table::Table<0x2::object::ID, VeSca>,
    }

    struct VeScaKey has store, key {
        id: 0x2::object::UID,
    }

    public fun extend_lock_period(arg0: &0xb6ec392c49fc79fd66bcd63eb7c105cd6dfbc1331e0a367305cb6cb2312efb11::config::VeScaProtocolConfig, arg1: &VeScaKey, arg2: &mut VeScaTable, arg3: &mut 0xb6ec392c49fc79fd66bcd63eb7c105cd6dfbc1331e0a367305cb6cb2312efb11::treasury::VeScaTreasury, arg4: u64, arg5: &0x2::clock::Clock) {
        0xb6ec392c49fc79fd66bcd63eb7c105cd6dfbc1331e0a367305cb6cb2312efb11::config::assert_protocol_version_and_status(arg0);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, VeSca>(&mut arg2.table, 0x2::object::id<VeScaKey>(arg1));
        0xb6ec392c49fc79fd66bcd63eb7c105cd6dfbc1331e0a367305cb6cb2312efb11::treasury::extend_lock_period(arg3, v0.locked_sca_amount, v0.unlock_at, arg4, arg5);
        v0.unlock_at = arg4;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VeScaTable{
            id    : 0x2::object::new(arg0),
            table : 0x2::table::new<0x2::object::ID, VeSca>(arg0),
        };
        0x2::transfer::share_object<VeScaTable>(v0);
    }

    public fun lock_more_sca(arg0: &0xb6ec392c49fc79fd66bcd63eb7c105cd6dfbc1331e0a367305cb6cb2312efb11::config::VeScaProtocolConfig, arg1: &VeScaKey, arg2: &mut VeScaTable, arg3: &mut 0xb6ec392c49fc79fd66bcd63eb7c105cd6dfbc1331e0a367305cb6cb2312efb11::treasury::VeScaTreasury, arg4: 0x2::coin::Coin<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::sca::SCA>, arg5: &0x2::clock::Clock) {
        0xb6ec392c49fc79fd66bcd63eb7c105cd6dfbc1331e0a367305cb6cb2312efb11::config::assert_protocol_version_and_status(arg0);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, VeSca>(&mut arg2.table, 0x2::object::id<VeScaKey>(arg1));
        assert!(0x2::clock::timestamp_ms(arg5) / 1000 < v0.unlock_at, 0xb6ec392c49fc79fd66bcd63eb7c105cd6dfbc1331e0a367305cb6cb2312efb11::error_code::cannot_topup_after_unlock());
        v0.locked_sca_amount = v0.locked_sca_amount + 0x2::coin::value<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::sca::SCA>(&arg4);
        0xb6ec392c49fc79fd66bcd63eb7c105cd6dfbc1331e0a367305cb6cb2312efb11::treasury::lock_sca(arg3, arg4, v0.unlock_at, arg5);
    }

    public fun locked_sca_amount(arg0: 0x2::object::ID, arg1: &VeScaTable) : u64 {
        0x2::table::borrow<0x2::object::ID, VeSca>(&arg1.table, arg0).locked_sca_amount
    }

    public fun mint_ve_sca_key(arg0: &0xb6ec392c49fc79fd66bcd63eb7c105cd6dfbc1331e0a367305cb6cb2312efb11::config::VeScaProtocolConfig, arg1: &mut VeScaTable, arg2: &mut 0xb6ec392c49fc79fd66bcd63eb7c105cd6dfbc1331e0a367305cb6cb2312efb11::treasury::VeScaTreasury, arg3: 0x2::coin::Coin<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::sca::SCA>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : VeScaKey {
        0xb6ec392c49fc79fd66bcd63eb7c105cd6dfbc1331e0a367305cb6cb2312efb11::config::assert_protocol_version_and_status(arg0);
        0xb6ec392c49fc79fd66bcd63eb7c105cd6dfbc1331e0a367305cb6cb2312efb11::treasury::lock_sca(arg2, arg3, arg4, arg5);
        let v0 = VeScaKey{id: 0x2::object::new(arg6)};
        let v1 = VeSca{
            locked_sca_amount : 0x2::coin::value<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::sca::SCA>(&arg3),
            unlock_at         : arg4,
        };
        0x2::table::add<0x2::object::ID, VeSca>(&mut arg1.table, 0x2::object::id<VeScaKey>(&v0), v1);
        v0
    }

    public fun redeem(arg0: &0xb6ec392c49fc79fd66bcd63eb7c105cd6dfbc1331e0a367305cb6cb2312efb11::config::VeScaProtocolConfig, arg1: &VeScaKey, arg2: &mut VeScaTable, arg3: &mut 0xb6ec392c49fc79fd66bcd63eb7c105cd6dfbc1331e0a367305cb6cb2312efb11::treasury::VeScaTreasury, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::sca::SCA> {
        0xb6ec392c49fc79fd66bcd63eb7c105cd6dfbc1331e0a367305cb6cb2312efb11::config::assert_protocol_version_and_status(arg0);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, VeSca>(&mut arg2.table, 0x2::object::id<VeScaKey>(arg1));
        assert!(0x2::clock::timestamp_ms(arg4) / 1000 > v0.unlock_at, 0xb6ec392c49fc79fd66bcd63eb7c105cd6dfbc1331e0a367305cb6cb2312efb11::error_code::lock_not_over_yet());
        0xb6ec392c49fc79fd66bcd63eb7c105cd6dfbc1331e0a367305cb6cb2312efb11::treasury::withdraw_sca(arg3, v0.locked_sca_amount, arg4, arg5)
    }

    public fun unlock_at(arg0: 0x2::object::ID, arg1: &VeScaTable) : u64 {
        0x2::table::borrow<0x2::object::ID, VeSca>(&arg1.table, arg0).unlock_at
    }

    public fun ve_sca_amount(arg0: 0x2::object::ID, arg1: &VeScaTable, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::table::borrow<0x2::object::ID, VeSca>(&arg1.table, arg0);
        0xb6ec392c49fc79fd66bcd63eb7c105cd6dfbc1331e0a367305cb6cb2312efb11::calculator::calc_ve_sca(v0.locked_sca_amount, v0.unlock_at, arg2)
    }

    // decompiled from Move bytecode v6
}

