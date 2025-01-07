module 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::mint_ratio_50_factory {
    struct WITNESS has drop {
        dummy_field: bool,
    }

    struct MintRatioFactory has store {
        amount_per_sui: u128,
        start_time_ms: u64,
        min_value_sui: u64,
        max_value_sui: u64,
        participants: 0x2::table_vec::TableVec<address>,
        minted_per_user: 0x2::table::Table<address, u64>,
    }

    fun after_deploy(arg0: 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecordV2, arg1: u128, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = MintRatioFactory{
            amount_per_sui  : arg1,
            start_time_ms   : arg2,
            min_value_sui   : arg3,
            max_value_sui   : arg4,
            participants    : 0x2::table_vec::empty<address>(arg5),
            minted_per_user : 0x2::table::new<address, u64>(arg5),
        };
        let v1 = WITNESS{dummy_field: false};
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::tick_record_add_df<MintRatioFactory, WITNESS>(&mut arg0, v0, v1);
        0x2::transfer::public_share_object<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecordV2>(arg0);
    }

    public entry fun clean(arg0: &mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecordV2, arg1: u64) {
        do_clean(arg0, arg1);
    }

    public entry fun deploy(arg0: &mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::DeployRecord, arg1: &mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecordV2, arg2: 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription, arg3: u64, arg4: u128, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        do_deploy(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun do_clean(arg0: &mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecordV2, arg1: u64) {
        assert!(0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::tick_record_v2_remain(arg0) == 0, 3);
        let v0 = WITNESS{dummy_field: false};
        let v1 = 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::tick_record_borrow_mut_df<MintRatioFactory, WITNESS>(arg0, v0);
        let v2 = 0x2::table_vec::length<address>(&v1.participants);
        while (v2 > 0 && arg1 > 0) {
            0x2::table::remove<address, u64>(&mut v1.minted_per_user, 0x2::table_vec::pop_back<address>(&mut v1.participants));
            v2 = v2 - 1;
            arg1 = arg1 - 1;
        };
    }

    public fun do_deploy(arg0: &mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::DeployRecord, arg1: &mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecordV2, arg2: 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription, arg3: u64, arg4: u128, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::assert_util::assert_tick_tick(&arg2);
        let v0 = 0x2::clock::timestamp_ms(arg8);
        if (arg5 < v0) {
            arg5 = v0;
        };
        let v1 = WITNESS{dummy_field: false};
        let v2 = 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::tick_factory::do_deploy<WITNESS>(arg0, arg1, arg2, arg3, true, v1, arg8, arg9);
        after_deploy(v2, arg4, arg5, arg6, arg7, arg9);
    }

    public fun do_mint(arg0: &mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecordV2, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription {
        abort 0
    }

    public fun do_mint_v2(arg0: &mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecordV2, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription {
        let v0 = 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::tick_record_v2_remain(arg0);
        let v1 = WITNESS{dummy_field: false};
        let v2 = 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::tick_record_borrow_mut_df<MintRatioFactory, WITNESS>(arg0, v1);
        assert!(0x2::clock::timestamp_ms(arg2) > v2.start_time_ms, 4);
        let v3 = 0x2::coin::value<0x2::sui::SUI>(arg1);
        let v4 = v3;
        assert!(v3 >= v2.min_value_sui, 1);
        let v5 = 0x2::tx_context::sender(arg3);
        if (0x2::table::contains<address, u64>(&v2.minted_per_user, v5)) {
            let v6 = 0x2::table::borrow_mut<address, u64>(&mut v2.minted_per_user, v5);
            if (v3 + *v6 > v2.max_value_sui) {
                v4 = v2.max_value_sui - *v6;
            };
            assert!(v4 > 0, 2);
            *v6 = *v6 + v4;
        } else {
            if (v3 > v2.max_value_sui) {
                v4 = v2.max_value_sui;
            };
            0x2::table::add<address, u64>(&mut v2.minted_per_user, v5, v4);
            0x2::table_vec::push_back<address>(&mut v2.participants, v5);
        };
        let v7 = (((v4 as u128) * v2.amount_per_sui / 1000000000) as u64);
        let v8 = v7;
        if (v7 > v0) {
            v8 = v0;
            v4 = (((v0 as u128) * 1000000000 / v2.amount_per_sui) as u64);
        };
        let v9 = WITNESS{dummy_field: false};
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::do_mint_with_witness<WITNESS>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg1, v4, arg3)), v8, 0x1::option::none<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Metadata>(), v9, arg3)
    }

    public entry fun mint(arg0: &mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecordV2, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun mint_v2(arg0: &mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecordV2, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = do_mint_v2(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(v0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

