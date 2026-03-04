module 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::moderation {
    struct EmergencyStatusChange has copy, drop {
        epoch: u64,
        old_status: u8,
        new_status: u8,
        admin: address,
        timestamp: u64,
        reason: 0x1::string::String,
    }

    struct StorageTransferred has copy, drop {
        storage_ids: vector<0x2::object::ID>,
        total_storage_size: u64,
        count: u64,
        start_epoch: u32,
        end_epoch: u32,
        from: address,
        to: address,
        admin: address,
        timestamp: u64,
    }

    public fun admin_transfer_storage(arg0: &0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::smashblob_game::AdminCap, arg1: vector<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        let v2 = 0;
        while (v2 < v0) {
            0x1::vector::push_back<0x2::object::ID>(&mut v1, 0x2::object::id<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(0x1::vector::borrow<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(&arg1, v2)));
            v2 = v2 + 1;
        };
        let (v3, v4, v5) = fuse_storage_vector(arg1);
        let v6 = v3;
        0x2::transfer::public_transfer<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(v6, arg2);
        let v7 = StorageTransferred{
            storage_ids        : v1,
            total_storage_size : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::size(&v6),
            count              : v0,
            start_epoch        : v4,
            end_epoch          : v5,
            from               : @0x0,
            to                 : arg2,
            admin              : 0x2::tx_context::sender(arg4),
            timestamp          : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<StorageTransferred>(v7);
    }

    public fun auto_cleanup_epoch_admin(arg0: &0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::smashblob_game::AdminCap, arg1: &mut 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::smashblob_game::SmashBlobGame, arg2: &mut 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::smashblob_game::Garbage, arg3: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::smashblob_game::auto_cleanup_old_garbage_internal(arg1, arg2, arg3, arg4, arg5);
    }

    public fun claim_cron_treasury(arg0: &0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::smashblob_game::AdminCap, arg1: &mut 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::smashblob_game::TreasuryConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::smashblob_game::get_cron_treasury_mut(arg1);
        if (0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(0x2::coin::from_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(0x2::balance::withdraw_all<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v0), arg3), arg2);
        };
    }

    public fun force_epoch_status(arg0: &0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::smashblob_game::AdminCap, arg1: &mut 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::smashblob_game::EpochData, arg2: u8, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let (v0, v1) = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::smashblob_game::force_epoch_status_internal(arg1, arg2);
        let v2 = EmergencyStatusChange{
            epoch      : v0,
            old_status : v1,
            new_status : arg2,
            admin      : 0x2::tx_context::sender(arg4),
            timestamp  : 0x2::clock::timestamp_ms(arg3),
            reason     : 0x1::string::utf8(b"Emergency admin override"),
        };
        0x2::event::emit<EmergencyStatusChange>(v2);
    }

    fun fuse_storage_vector(arg0: vector<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>) : (0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage, u32, u32) {
        let v0 = 0x1::vector::length<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(&arg0);
        assert!(v0 > 0, 1);
        let v1 = 0x1::vector::borrow<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(&arg0, 0);
        let v2 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::start_epoch(v1);
        let v3 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::end_epoch(v1);
        if (v0 == 1) {
            0x1::vector::destroy_empty<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(arg0);
            return (0x1::vector::pop_back<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(&mut arg0), v2, v3)
        };
        let v4 = 1;
        while (v4 < v0) {
            let v5 = 0x1::vector::borrow<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(&arg0, v4);
            assert!(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::start_epoch(v5) == v2 && 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::end_epoch(v5) == v3, 2);
            v4 = v4 + 1;
        };
        let v6 = 0x1::vector::pop_back<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(&mut arg0);
        while (!0x1::vector::is_empty<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(&arg0)) {
            0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::fuse(&mut v6, 0x1::vector::pop_back<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(&mut arg0));
        };
        0x1::vector::destroy_empty<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(arg0);
        (v6, v2, v3)
    }

    public fun open_new_epoch_admin(arg0: &0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::smashblob_game::AdminCap, arg1: &mut 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::smashblob_game::SmashBlobGame, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::smashblob_game::open_new_epoch_admin_internal(arg1, arg2, arg3);
    }

    public fun refund_epoch_treasury(arg0: &0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::smashblob_game::AdminCap, arg1: &mut 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::smashblob_game::SmashBlobGame, arg2: 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::smashblob_game::CompetitionEpoch, arg3: address, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::smashblob_game::refund_epoch_treasury_internal(arg1, arg2, arg3, arg4, arg5)
    }

    public fun set_cleanup_grace_period(arg0: &0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::smashblob_game::AdminCap, arg1: &mut 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::smashblob_game::SmashBlobGame, arg2: u64) {
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::smashblob_game::set_cleanup_grace_period_internal(arg1, arg2);
    }

    public fun set_extension_epochs(arg0: &0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::smashblob_game::AdminCap, arg1: &mut 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::smashblob_game::SmashBlobGame, arg2: u32) {
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::smashblob_game::set_extension_epochs_internal(arg1, arg2);
    }

    public fun set_max_future_epochs(arg0: &0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::smashblob_game::AdminCap, arg1: &mut 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::smashblob_game::SmashBlobGame, arg2: u64) {
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::smashblob_game::set_max_future_epochs_internal(arg1, arg2);
    }

    public fun set_minimum_bid_increment(arg0: &0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::smashblob_game::AdminCap, arg1: &mut 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::smashblob_game::SmashBlobGame, arg2: u64) {
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::smashblob_game::set_minimum_bid_increment_internal(arg1, arg2);
    }

    public fun set_treasury_split(arg0: &0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::smashblob_game::AdminCap, arg1: &mut 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::smashblob_game::TreasuryConfig, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::smashblob_game::set_treasury_split_internal(arg1, arg2, arg3, arg4, arg5);
    }

    public fun set_vote_fee(arg0: &0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::smashblob_game::AdminCap, arg1: &mut 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::smashblob_game::SmashBlobGame, arg2: u64) {
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::smashblob_game::set_vote_fee_internal(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

