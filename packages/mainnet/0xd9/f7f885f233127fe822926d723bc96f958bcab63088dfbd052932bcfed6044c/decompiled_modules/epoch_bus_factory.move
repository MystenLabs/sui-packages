module 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::epoch_bus_factory {
    struct EpochRecord has store {
        epoch: u64,
        start_time_ms: u64,
        players: vector<address>,
        locked_sui: 0x2::table::Table<address, 0x2::balance::Balance<0x2::sui::SUI>>,
    }

    struct NewEpochEvent has copy, drop {
        tick: 0x1::ascii::String,
        epoch: u64,
        start_time_ms: u64,
    }

    struct SettleEpochEvent has copy, drop {
        tick: 0x1::ascii::String,
        epoch: u64,
        settle_user: address,
        settle_time_ms: u64,
        palyers_count: u64,
        epoch_supply: u64,
    }

    struct EpochBusFactory has store {
        init_locked_sui: u64,
        start_time_ms: u64,
        epoch_count: u64,
        epoch_amount: u64,
        current_epoch: u64,
        epoch_records: 0x2::table::Table<u64, EpochRecord>,
    }

    struct WITNESS has drop {
        dummy_field: bool,
    }

    fun after_deploy(arg0: 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecordV2, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = EpochBusFactory{
            init_locked_sui : arg2,
            start_time_ms   : arg3,
            epoch_count     : arg4,
            epoch_amount    : arg1 / arg4,
            current_epoch   : 0,
            epoch_records   : 0x2::table::new<u64, EpochRecord>(arg5),
        };
        let v1 = WITNESS{dummy_field: false};
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::tick_record_add_df<EpochBusFactory, WITNESS>(&mut arg0, v0, v1);
        0x2::transfer::public_share_object<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecordV2>(arg0);
    }

    public entry fun deploy(arg0: &mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::DeployRecord, arg1: &mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecordV2, arg2: 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        do_deploy(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun deploy_move_tick(arg0: &mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::DeployRecord, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::tick_name::move_tick();
        if (0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::is_deployed(arg0, v0)) {
            return
        };
        let v1 = 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::move_tick_total_supply();
        let v2 = WITNESS{dummy_field: false};
        let v3 = 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::internal_deploy_with_witness<WITNESS>(arg0, 0x1::ascii::string(v0), v1, true, v2, arg1);
        after_deploy(v3, v1, 100000000, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::protocol_start_time_ms(), 21600, arg1);
    }

    public fun do_deploy(arg0: &mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::DeployRecord, arg1: &mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecordV2, arg2: 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::assert_util::assert_tick_tick(&arg2);
        assert!(arg6 >= 120, 2);
        let v0 = WITNESS{dummy_field: false};
        let v1 = 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::tick_factory::do_deploy<WITNESS>(arg0, arg1, arg2, arg3, true, v0, arg7, arg8);
        after_deploy(v1, arg3, arg4, arg5, arg6, arg8);
    }

    public fun do_mint(arg0: &mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecordV2, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = WITNESS{dummy_field: false};
        let v2 = 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::tick_record_borrow_mut_df<EpochBusFactory, WITNESS>(arg0, v1);
        assert!(v0 >= v2.start_time_ms, 1);
        let v3 = 0x2::tx_context::sender(arg3);
        let v4 = 0x2::coin::into_balance<0x2::sui::SUI>(0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::util::split_coin_and_give_back<0x2::sui::SUI>(arg1, v2.init_locked_sui, arg3));
        let v5 = v2.current_epoch;
        if (0x2::table::contains<u64, EpochRecord>(&v2.epoch_records, v5)) {
            let v6 = 0x2::table::borrow_mut<u64, EpochRecord>(&mut v2.epoch_records, v5);
            mint_in_epoch(v6, v3, v4);
            if (v6.start_time_ms + 60000 < v0 || 0x1::vector::length<address>(&v6.players) >= 500) {
                settlement(arg0, v5, v3, v0, arg3);
            };
        } else {
            0x2::table::add<u64, EpochRecord>(&mut v2.epoch_records, v5, new_epoch_record(0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::tick_record_v2_tick(arg0), v5, v0, v3, v4, arg3));
        };
    }

    public fun epoch_count_of_move() : u64 {
        21600
    }

    public fun epoch_duration_ms() : u64 {
        60000
    }

    public fun epoch_max_player() : u64 {
        500
    }

    public fun init_locked_sui_of_move() : u64 {
        100000000
    }

    fun internal_mint(arg0: &mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecordV2, arg1: u64, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription {
        let v0 = WITNESS{dummy_field: false};
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::do_mint_with_witness<WITNESS>(arg0, arg2, arg1, 0x1::option::none<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Metadata>(), v0, arg3)
    }

    fun migrate_epoch_record(arg0: 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::EpochRecord) : EpochRecord {
        let (v0, v1, v2, v3) = 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::unwrap_epoch_record(arg0);
        EpochRecord{
            epoch         : v0,
            start_time_ms : v1,
            players       : v2,
            locked_sui    : v3,
        }
    }

    public fun migrate_tick_record_to_v2(arg0: &mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::DeployRecord, arg1: 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecord, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = WITNESS{dummy_field: false};
        let (v1, v2, v3, v4, v5, v6) = 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::migrate_tick_record_to_v2<WITNESS>(arg0, arg1, v0, arg2);
        let v7 = v6;
        let v8 = v1;
        let v9 = if (0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::tick_record_v2_remain(&v8) == 0) {
            0x2::table::new<u64, EpochRecord>(arg2)
        } else {
            let v10 = 0x2::table::new<u64, EpochRecord>(arg2);
            let v11 = 0;
            while (v11 < v4) {
                let (_, _, _, v15) = 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::unwrap_epoch_record(0x2::table::remove<u64, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::EpochRecord>(&mut v7, v11));
                0x2::table::destroy_empty<address, 0x2::balance::Balance<0x2::sui::SUI>>(v15);
                v11 = v11 + 1;
            };
            0x2::table::add<u64, EpochRecord>(&mut v10, v4, migrate_epoch_record(0x2::table::remove<u64, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::EpochRecord>(&mut v7, v4)));
            v10
        };
        0x2::table::destroy_empty<u64, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::EpochRecord>(v7);
        let v16 = EpochBusFactory{
            init_locked_sui : v5,
            start_time_ms   : v2,
            epoch_count     : v3,
            epoch_amount    : 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::tick_record_v2_total_supply(&v8) / v3,
            current_epoch   : v4,
            epoch_records   : v9,
        };
        let v17 = WITNESS{dummy_field: false};
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::tick_record_add_df<EpochBusFactory, WITNESS>(&mut v8, v16, v17);
        0x2::transfer::public_share_object<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecordV2>(v8);
    }

    public fun min_epochs() : u64 {
        120
    }

    public entry fun mint(arg0: &mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecordV2, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        do_mint(arg0, arg1, arg2, arg3);
    }

    fun mint_in_epoch(arg0: &mut EpochRecord, arg1: address, arg2: 0x2::balance::Balance<0x2::sui::SUI>) {
        if (!0x2::table::contains<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.locked_sui, arg1)) {
            0x1::vector::push_back<address>(&mut arg0.players, arg1);
            0x2::table::add<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.locked_sui, arg1, arg2);
        } else {
            0x2::balance::join<0x2::sui::SUI>(0x2::table::borrow_mut<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.locked_sui, arg1), arg2);
        };
    }

    fun new_epoch_record(arg0: 0x1::ascii::String, arg1: u64, arg2: u64, arg3: address, arg4: 0x2::balance::Balance<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) : EpochRecord {
        let v0 = 0x2::table::new<address, 0x2::balance::Balance<0x2::sui::SUI>>(arg5);
        0x2::table::add<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut v0, arg3, arg4);
        let v1 = NewEpochEvent{
            tick          : arg0,
            epoch         : arg1,
            start_time_ms : arg2,
        };
        0x2::event::emit<NewEpochEvent>(v1);
        let v2 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v2, arg3);
        EpochRecord{
            epoch         : arg1,
            start_time_ms : arg2,
            players       : v2,
            locked_sui    : v0,
        }
    }

    fun settlement(arg0: &mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecordV2, arg1: u64, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::tick_record_v2_remain(arg0);
        let v1 = v0;
        let v2 = 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::tick_record_v2_tick(arg0);
        let v3 = WITNESS{dummy_field: false};
        let v4 = 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::tick_record_remove_df<EpochBusFactory, WITNESS>(arg0, v3);
        let v5 = v4.epoch_amount;
        let v6 = v5;
        let EpochRecord {
            epoch         : v7,
            start_time_ms : _,
            players       : v9,
            locked_sui    : v10,
        } = 0x2::table::remove<u64, EpochRecord>(&mut v4.epoch_records, arg1);
        let v11 = v10;
        let v12 = v9;
        if (v5 * 2 > v0) {
            v6 = v0;
        };
        let v13 = 0;
        let v14 = 0;
        let v15 = 0x1::vector::length<address>(&v12);
        let v16 = v6 / v15;
        let v17 = v16;
        if (v16 == 0) {
            v17 = 1;
        };
        while (v14 < v15) {
            let v18 = *0x1::vector::borrow<address>(&v12, v14);
            if (v1 > 0) {
                let v19 = internal_mint(arg0, v17, 0x2::table::remove<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut v11, v18), arg4);
                0x2::transfer::public_transfer<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(v19, v18);
                v1 = v1 - v17;
                v13 = v13 + v17;
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::table::remove<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut v11, v18), arg4), v18);
            };
            v14 = v14 + 1;
        };
        let v20 = v17 * v15;
        if (v20 < v6) {
            let v21 = v6 - v20;
            let v22 = internal_mint(arg0, v21, 0x2::balance::zero<0x2::sui::SUI>(), arg4);
            0x2::transfer::public_transfer<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(v22, arg2);
            v1 = v1 - v21;
            v13 = v13 + v21;
        };
        0x2::table::destroy_empty<address, 0x2::balance::Balance<0x2::sui::SUI>>(v11);
        let v23 = SettleEpochEvent{
            tick           : v2,
            epoch          : v7,
            settle_user    : arg2,
            settle_time_ms : arg3,
            palyers_count  : v15,
            epoch_supply   : v13,
        };
        0x2::event::emit<SettleEpochEvent>(v23);
        if (v1 != 0) {
            let v24 = v7 + 1;
            0x2::table::add<u64, EpochRecord>(&mut v4.epoch_records, v24, new_epoch_record(v2, v24, arg3, arg2, 0x2::balance::zero<0x2::sui::SUI>(), arg4));
            v4.current_epoch = v24;
        };
        let v25 = WITNESS{dummy_field: false};
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::tick_record_add_df<EpochBusFactory, WITNESS>(arg0, v4, v25);
    }

    // decompiled from Move bytecode v6
}

