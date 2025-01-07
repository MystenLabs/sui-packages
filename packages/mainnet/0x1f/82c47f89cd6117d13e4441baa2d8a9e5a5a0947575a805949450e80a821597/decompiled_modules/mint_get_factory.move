module 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::mint_get_factory {
    struct WITNESS has drop {
        dummy_field: bool,
    }

    struct MintGetFactory has store {
        amount_per_mint: u64,
        init_locked_sui: u64,
        init_locked_move: u64,
    }

    fun after_deploy(arg0: 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecordV2, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = MintGetFactory{
            amount_per_mint  : arg1,
            init_locked_sui  : arg2,
            init_locked_move : arg3,
        };
        let v1 = WITNESS{dummy_field: false};
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::tick_record_add_df<MintGetFactory, WITNESS>(&mut arg0, v0, v1);
        0x2::transfer::public_share_object<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecordV2>(arg0);
    }

    public fun amount_per_mint(arg0: &0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecordV2) : u64 {
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::tick_record_borrow_df<MintGetFactory>(arg0).amount_per_mint
    }

    public entry fun deploy(arg0: &mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::DeployRecord, arg1: &mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecordV2, arg2: 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        do_deploy(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun deploy_test_tick(arg0: &mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::DeployRecord, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::is_deployed(arg0, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::tick_name::test_tick())) {
            return
        };
        let v0 = WITNESS{dummy_field: false};
        after_deploy(0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::internal_deploy_with_witness<WITNESS>(arg0, 0x1::ascii::string(0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::tick_name::test_tick()), 18446744073709551615, true, v0, arg1), 10000, 0, 0);
    }

    public fun do_deploy(arg0: &mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::DeployRecord, arg1: &mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecordV2, arg2: 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::assert_util::assert_tick_tick(&arg2);
        assert!(arg6 == 0 && arg5 == 0 || arg6 > 0 && arg5 == 0 || arg5 > 0 && arg6 == 0, 1);
        let v0 = WITNESS{dummy_field: false};
        after_deploy(0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::tick_factory::do_deploy<WITNESS>(arg0, arg1, arg2, arg3, true, v0, arg7, arg8), arg4, arg5, arg6);
    }

    public fun do_mint(arg0: &mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecordV2, arg1: &mut 0x2::tx_context::TxContext) : 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription {
        let v0 = WITNESS{dummy_field: false};
        let v1 = 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::tick_record_borrow_mut_df<MintGetFactory, WITNESS>(arg0, v0);
        assert!(v1.init_locked_sui == 0 && v1.init_locked_move == 0, 2);
        internal_mint(arg0, v1.amount_per_mint, 0x2::balance::zero<0x2::sui::SUI>(), 0x1::option::none<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(), arg1)
    }

    public fun do_mint_with_move(arg0: &mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecordV2, arg1: 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription, arg2: &mut 0x2::tx_context::TxContext) : 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription {
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::assert_util::assert_move_tick(&arg1);
        let v0 = WITNESS{dummy_field: false};
        let v1 = 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::tick_record_borrow_mut_df<MintGetFactory, WITNESS>(arg0, v0);
        assert!(v1.init_locked_move > 0, 2);
        let v2 = 0x1::option::some<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::util::split_and_give_back(arg1, v1.init_locked_move, arg2));
        internal_mint(arg0, v1.amount_per_mint, 0x2::balance::zero<0x2::sui::SUI>(), v2, arg2)
    }

    public fun do_mint_with_sui(arg0: &mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecordV2, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription {
        let v0 = WITNESS{dummy_field: false};
        let v1 = 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::tick_record_borrow_mut_df<MintGetFactory, WITNESS>(arg0, v0);
        assert!(v1.init_locked_sui > 0, 2);
        let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::util::split_coin_and_give_back<0x2::sui::SUI>(arg1, v1.init_locked_sui, arg2));
        internal_mint(arg0, v1.amount_per_mint, v2, 0x1::option::none<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(), arg2)
    }

    public fun init_locked_move(arg0: &0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecordV2) : u64 {
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::tick_record_borrow_df<MintGetFactory>(arg0).init_locked_move
    }

    public fun init_locked_sui(arg0: &0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecordV2) : u64 {
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::tick_record_borrow_df<MintGetFactory>(arg0).init_locked_sui
    }

    fun internal_mint(arg0: &mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecordV2, arg1: u64, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: 0x1::option::Option<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>, arg4: &mut 0x2::tx_context::TxContext) : 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription {
        let v0 = 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::tick_record_v2_remain(arg0);
        let v1 = if (v0 < arg1) {
            v0
        } else {
            arg1
        };
        let v2 = WITNESS{dummy_field: false};
        let v3 = 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::do_mint_with_witness<WITNESS>(arg0, arg2, v1, 0x1::option::none<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Metadata>(), v2, arg4);
        if (0x1::option::is_some<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&arg3)) {
            0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::lock_within(&mut v3, 0x1::option::destroy_some<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(arg3));
        } else {
            0x1::option::destroy_none<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(arg3);
        };
        v3
    }

    public entry fun mint(arg0: &mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecordV2, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = do_mint(arg0, arg1);
        0x2::transfer::public_transfer<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_with_move(arg0: &mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecordV2, arg1: 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        0x2::transfer::public_transfer<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(do_mint_with_move(arg0, arg1, arg2), v0);
    }

    public entry fun mint_with_sui(arg0: &mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecordV2, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        0x2::transfer::public_transfer<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(do_mint_with_sui(arg0, arg1, arg2), v0);
    }

    // decompiled from Move bytecode v6
}

