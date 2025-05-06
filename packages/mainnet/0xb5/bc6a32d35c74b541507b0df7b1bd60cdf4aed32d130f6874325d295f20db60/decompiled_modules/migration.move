module 0xac05fba3c5adc6296d3b65c0d09cc9d579f0e1ad8f0a8a6e734feaa0fb8b7c8b::migration {
    struct ExportedEvent has copy, drop {
        total_sui_balance: u64,
        exported_count: u64,
        sui_amount: u64,
        pending_sui_amount: u64,
        epoch: u64,
    }

    struct ImportedEvent has copy, drop {
        imported_amount: u64,
        ratio: u64,
    }

    struct UnclaimedFeesEvent has copy, drop {
        amount: u64,
    }

    struct SuiChangedEvent has copy, drop {
        amount: u64,
    }

    struct MigrationStorage has store, key {
        id: 0x2::object::UID,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        exported_count: u64,
    }

    struct MigrationCap has store, key {
        id: 0x2::object::UID,
        pool_created: bool,
        fees_taken: bool,
    }

    public fun create_stake_pool(arg0: &mut MigrationCap, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.pool_created, 0);
        arg0.pool_created = true;
        0xac05fba3c5adc6296d3b65c0d09cc9d579f0e1ad8f0a8a6e734feaa0fb8b7c8b::stake_pool::create_stake_pool(arg1);
    }

    public fun deposit_sui(arg0: &mut MigrationStorage, arg1: &mut MigrationCap, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg2, arg3, arg4)));
        let v0 = SuiChangedEvent{amount: 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance)};
        0x2::event::emit<SuiChangedEvent>(v0);
    }

    public fun destroy_migration_cap(arg0: MigrationCap, arg1: &MigrationStorage, arg2: u64) {
        assert!(arg1.exported_count == arg2, 1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.sui_balance) == 0, 3);
        let MigrationCap {
            id           : v0,
            pool_created : v1,
            fees_taken   : v2,
        } = arg0;
        assert!(v1, 0);
        assert!(v2, 2);
        0x2::object::delete(v0);
    }

    public fun export_stakes(arg0: &mut MigrationStorage, arg1: &MigrationCap, arg2: &mut 0xac05fba3c5adc6296d3b65c0d09cc9d579f0e1ad8f0a8a6e734feaa0fb8b7c8b::native_pool::NativePool, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0xac05fba3c5adc6296d3b65c0d09cc9d579f0e1ad8f0a8a6e734feaa0fb8b7c8b::validator_set::export_stakes_from_v1(0xac05fba3c5adc6296d3b65c0d09cc9d579f0e1ad8f0a8a6e734feaa0fb8b7c8b::native_pool::mut_validator_set(arg2), arg3, arg4, arg5);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, v0);
        arg0.exported_count = arg0.exported_count + v1;
        let v3 = 0x2::balance::withdraw_all<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(0xac05fba3c5adc6296d3b65c0d09cc9d579f0e1ad8f0a8a6e734feaa0fb8b7c8b::native_pool::mut_pending(arg2)));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, v3);
        let v4 = ExportedEvent{
            total_sui_balance  : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance),
            exported_count     : v1,
            sui_amount         : v2,
            pending_sui_amount : 0x2::balance::value<0x2::sui::SUI>(&v3),
            epoch              : 0x2::tx_context::epoch(arg5),
        };
        0x2::event::emit<ExportedEvent>(v4);
    }

    public fun import_stakes(arg0: &mut MigrationStorage, arg1: &MigrationCap, arg2: &0xac05fba3c5adc6296d3b65c0d09cc9d579f0e1ad8f0a8a6e734feaa0fb8b7c8b::stake_pool::AdminCap, arg3: &mut 0xac05fba3c5adc6296d3b65c0d09cc9d579f0e1ad8f0a8a6e734feaa0fb8b7c8b::stake_pool::StakePool, arg4: &mut 0xac05fba3c5adc6296d3b65c0d09cc9d579f0e1ad8f0a8a6e734feaa0fb8b7c8b::cert::Metadata<0xac05fba3c5adc6296d3b65c0d09cc9d579f0e1ad8f0a8a6e734feaa0fb8b7c8b::cert::CERT>, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::u64::min(arg6, 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance));
        0xac05fba3c5adc6296d3b65c0d09cc9d579f0e1ad8f0a8a6e734feaa0fb8b7c8b::stake_pool::set_paused(arg3, arg2, false);
        0xac05fba3c5adc6296d3b65c0d09cc9d579f0e1ad8f0a8a6e734feaa0fb8b7c8b::stake_pool::join_to_sui_pool(arg3, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, v0));
        0xac05fba3c5adc6296d3b65c0d09cc9d579f0e1ad8f0a8a6e734feaa0fb8b7c8b::stake_pool::rebalance(arg3, arg4, arg5, arg8);
        0xac05fba3c5adc6296d3b65c0d09cc9d579f0e1ad8f0a8a6e734feaa0fb8b7c8b::stake_pool::set_paused(arg3, arg2, true);
        let v1 = 0xac05fba3c5adc6296d3b65c0d09cc9d579f0e1ad8f0a8a6e734feaa0fb8b7c8b::stake_pool::get_ratio(arg3, arg4);
        assert!(v1 <= arg7, 0);
        let v2 = ImportedEvent{
            imported_amount : v0,
            ratio           : v1,
        };
        0x2::event::emit<ImportedEvent>(v2);
    }

    public fun init_objects(arg0: &0xac05fba3c5adc6296d3b65c0d09cc9d579f0e1ad8f0a8a6e734feaa0fb8b7c8b::ownership::OwnerCap, arg1: &mut 0xac05fba3c5adc6296d3b65c0d09cc9d579f0e1ad8f0a8a6e734feaa0fb8b7c8b::native_pool::NativePool, arg2: &mut 0x2::tx_context::TxContext) {
        0xac05fba3c5adc6296d3b65c0d09cc9d579f0e1ad8f0a8a6e734feaa0fb8b7c8b::native_pool::mark_cap_created(arg1);
        let v0 = 0;
        assert!(0xac05fba3c5adc6296d3b65c0d09cc9d579f0e1ad8f0a8a6e734feaa0fb8b7c8b::native_pool::mut_collected_rewards(arg1) != &v0, 0);
        0xac05fba3c5adc6296d3b65c0d09cc9d579f0e1ad8f0a8a6e734feaa0fb8b7c8b::native_pool::set_pause(arg1, arg0, true);
        let v1 = MigrationStorage{
            id             : 0x2::object::new(arg2),
            sui_balance    : 0x2::balance::zero<0x2::sui::SUI>(),
            exported_count : 0,
        };
        let v2 = MigrationCap{
            id           : 0x2::object::new(arg2),
            pool_created : false,
            fees_taken   : false,
        };
        0x2::transfer::public_share_object<MigrationStorage>(v1);
        0x2::transfer::public_transfer<MigrationCap>(v2, 0x2::tx_context::sender(arg2));
    }

    public fun take_unclaimed_fees(arg0: &mut MigrationStorage, arg1: &mut MigrationCap, arg2: address, arg3: &mut 0xac05fba3c5adc6296d3b65c0d09cc9d579f0e1ad8f0a8a6e734feaa0fb8b7c8b::native_pool::NativePool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xac05fba3c5adc6296d3b65c0d09cc9d579f0e1ad8f0a8a6e734feaa0fb8b7c8b::native_pool::mut_collected_rewards(arg3);
        let v1 = *v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, v1), arg4), arg2);
        *v0 = 0;
        arg1.fees_taken = true;
        let v2 = UnclaimedFeesEvent{amount: v1};
        0x2::event::emit<UnclaimedFeesEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

