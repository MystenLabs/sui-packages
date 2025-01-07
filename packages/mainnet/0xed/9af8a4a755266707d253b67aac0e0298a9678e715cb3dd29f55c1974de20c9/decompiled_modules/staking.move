module 0xed9af8a4a755266707d253b67aac0e0298a9678e715cb3dd29f55c1974de20c9::staking {
    struct Registry has key {
        id: 0x2::object::UID,
    }

    struct ManagerCap has key {
        id: 0x2::object::UID,
    }

    struct StakingTails has store {
        nft: 0xed9af8a4a755266707d253b67aac0e0298a9678e715cb3dd29f55c1974de20c9::typus_nft::Tails,
        snapshot_ms: u64,
        updating_url: bool,
    }

    struct NftExtension has store {
        nft_table: 0x2::table::Table<address, StakingTails>,
        nft_manager_cap: 0xed9af8a4a755266707d253b67aac0e0298a9678e715cb3dd29f55c1974de20c9::typus_nft::ManagerCap,
    }

    struct LevelUpEvent has copy, drop {
        nft_id: 0x2::object::ID,
        sender: address,
        number: u64,
        level: u64,
    }

    public fun add_exp(arg0: &mut Registry, arg1: &ManagerCap, arg2: address, arg3: u64) {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"nft_extension"), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(&mut arg0.id, b"nft_extension");
        let v1 = &mut v0.nft_table;
        assert!(0x2::table::contains<address, StakingTails>(v1, arg2), 2);
        0xed9af8a4a755266707d253b67aac0e0298a9678e715cb3dd29f55c1974de20c9::typus_nft::nft_exp_up(&v0.nft_manager_cap, &mut 0x2::table::borrow_mut<address, StakingTails>(v1, arg2).nft, arg3);
    }

    public fun add_nft_extension(arg0: &mut Registry, arg1: 0xed9af8a4a755266707d253b67aac0e0298a9678e715cb3dd29f55c1974de20c9::typus_nft::ManagerCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"nft_extension"), 0);
        let v0 = NftExtension{
            nft_table       : 0x2::table::new<address, StakingTails>(arg2),
            nft_manager_cap : arg1,
        };
        0x2::dynamic_field::add<vector<u8>, NftExtension>(&mut arg0.id, b"nft_extension", v0);
    }

    public fun first_bid(arg0: &mut Registry, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"nft_extension"), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(&mut arg0.id, b"nft_extension");
        let v1 = &mut v0.nft_table;
        if (0x2::table::contains<address, StakingTails>(v1, 0x2::tx_context::sender(arg1))) {
            0xed9af8a4a755266707d253b67aac0e0298a9678e715cb3dd29f55c1974de20c9::typus_nft::first_bid(&v0.nft_manager_cap, &mut 0x2::table::borrow_mut<address, StakingTails>(v1, 0x2::tx_context::sender(arg1)).nft);
        };
    }

    public fun first_deposit(arg0: &mut Registry, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"nft_extension"), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(&mut arg0.id, b"nft_extension");
        let v1 = &mut v0.nft_table;
        if (0x2::table::contains<address, StakingTails>(v1, 0x2::tx_context::sender(arg1))) {
            0xed9af8a4a755266707d253b67aac0e0298a9678e715cb3dd29f55c1974de20c9::typus_nft::first_deposit(&v0.nft_manager_cap, &mut 0x2::table::borrow_mut<address, StakingTails>(v1, 0x2::tx_context::sender(arg1)).nft);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{id: 0x2::object::new(arg0)};
        let v1 = ManagerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Registry>(v0);
        0x2::transfer::transfer<ManagerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun level_up(arg0: &mut Registry, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"nft_extension"), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(&mut arg0.id, b"nft_extension");
        let v1 = &mut v0.nft_table;
        let v2 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, StakingTails>(v1, 0x2::tx_context::sender(arg1)), 2);
        let v3 = 0x2::table::borrow_mut<address, StakingTails>(v1, v2);
        let v4 = 0xed9af8a4a755266707d253b67aac0e0298a9678e715cb3dd29f55c1974de20c9::typus_nft::level_up(&v0.nft_manager_cap, &mut v3.nft);
        if (0x1::option::is_some<u64>(&v4)) {
            let v5 = LevelUpEvent{
                nft_id : 0x2::object::id<0xed9af8a4a755266707d253b67aac0e0298a9678e715cb3dd29f55c1974de20c9::typus_nft::Tails>(&v3.nft),
                sender : v2,
                number : 0xed9af8a4a755266707d253b67aac0e0298a9678e715cb3dd29f55c1974de20c9::typus_nft::tails_number(&v3.nft),
                level  : 0x1::option::extract<u64>(&mut v4),
            };
            0x2::event::emit<LevelUpEvent>(v5);
            v3.updating_url = true;
        };
    }

    public fun snapshot(arg0: &mut Registry, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"nft_extension"), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(&mut arg0.id, b"nft_extension");
        let v1 = &mut v0.nft_table;
        assert!(0x2::table::contains<address, StakingTails>(v1, 0x2::tx_context::sender(arg2)), 2);
        let v2 = 0x2::table::borrow_mut<address, StakingTails>(v1, 0x2::tx_context::sender(arg2));
        let v3 = 0x2::clock::timestamp_ms(arg1);
        assert!(v3 - v2.snapshot_ms >= 86400000, 3);
        v2.snapshot_ms = v3;
        0xed9af8a4a755266707d253b67aac0e0298a9678e715cb3dd29f55c1974de20c9::typus_nft::nft_exp_up(&v0.nft_manager_cap, &mut v2.nft, 10);
    }

    public fun stake_nft(arg0: &mut Registry, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"nft_extension"), 0);
        let v0 = &mut 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(&mut arg0.id, b"nft_extension").nft_table;
        let v1 = StakingTails{
            nft          : 0x2::kiosk::take<0xed9af8a4a755266707d253b67aac0e0298a9678e715cb3dd29f55c1974de20c9::typus_nft::Tails>(arg1, arg2, arg3),
            snapshot_ms  : 0x2::clock::timestamp_ms(arg4),
            updating_url : false,
        };
        assert!(!0x2::table::contains<address, StakingTails>(v0, 0x2::tx_context::sender(arg5)), 1);
        0x2::table::add<address, StakingTails>(v0, 0x2::tx_context::sender(arg5), v1);
    }

    public fun unstake_nft(arg0: &mut Registry, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"nft_extension"), 0);
        let v0 = &mut 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(&mut arg0.id, b"nft_extension").nft_table;
        assert!(0x2::table::contains<address, StakingTails>(v0, 0x2::tx_context::sender(arg3)), 2);
        let StakingTails {
            nft          : v1,
            snapshot_ms  : _,
            updating_url : v3,
        } = 0x2::table::remove<address, StakingTails>(v0, 0x2::tx_context::sender(arg3));
        assert!(!v3, 4);
        0x2::kiosk::place<0xed9af8a4a755266707d253b67aac0e0298a9678e715cb3dd29f55c1974de20c9::typus_nft::Tails>(arg1, arg2, v1);
    }

    public fun update_image_url(arg0: &mut Registry, arg1: &ManagerCap, arg2: address, arg3: vector<u8>) {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"nft_extension"), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(&mut arg0.id, b"nft_extension");
        let v1 = &mut v0.nft_table;
        assert!(0x2::table::contains<address, StakingTails>(v1, arg2), 2);
        let v2 = 0x2::table::borrow_mut<address, StakingTails>(v1, arg2);
        0xed9af8a4a755266707d253b67aac0e0298a9678e715cb3dd29f55c1974de20c9::typus_nft::update_image_url(&v0.nft_manager_cap, &mut v2.nft, arg3);
        v2.updating_url = false;
    }

    // decompiled from Move bytecode v6
}

