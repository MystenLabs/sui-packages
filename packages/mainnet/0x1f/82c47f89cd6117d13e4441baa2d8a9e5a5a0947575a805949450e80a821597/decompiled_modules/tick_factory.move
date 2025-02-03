module 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::tick_factory {
    struct WITNESS has drop {
        dummy_field: bool,
    }

    struct TickFactory has store {
        tick_names: 0x2::table::Table<0x1::ascii::String, u64>,
        total_tick_fee: 0x1::option::Option<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>,
    }

    public entry fun burn(arg0: &mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecordV2, arg1: 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = do_burn(arg0, arg1, arg2, arg3);
        let v2 = v1;
        let v3 = v0;
        if (0x2::coin::value<0x2::sui::SUI>(&v3) == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, 0x2::tx_context::sender(arg3));
        };
        if (0x1::option::is_some<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&v2)) {
            0x2::transfer::public_transfer<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(0x1::option::destroy_some<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(v2), 0x2::tx_context::sender(arg3));
        } else {
            0x1::option::destroy_none<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(v2);
        };
    }

    public fun calculate_tick_fee(arg0: 0x1::ascii::String, arg1: u64, arg2: u64) : u64 {
        let v0 = 1000 * 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::tick_name::min_tick_length() / 0x1::ascii::length(&arg0) + (arg2 - arg1) / 3600000 * 1;
        if (v0 > 10000) {
            10000
        } else {
            v0
        }
    }

    fun charge_fee(arg0: &mut TickFactory, arg1: 0x1::ascii::String, arg2: u64, arg3: 0x1::option::Option<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription> {
        if (0x1::option::is_some<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&arg3)) {
            let (v1, v2) = 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::util::split_and_return_remain(0x1::option::destroy_some<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(arg3), calculate_tick_fee(arg1, arg2, 0x2::clock::timestamp_ms(arg4)), arg5);
            if (0x1::option::is_some<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&arg0.total_tick_fee)) {
                0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::do_merge(0x1::option::borrow_mut<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg0.total_tick_fee), v1);
            } else {
                0x1::option::fill<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg0.total_tick_fee, v1);
            };
            v2
        } else {
            arg3
        }
    }

    fun decode_metadata(arg0: &0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription) : (0x1::ascii::String, u64, address) {
        let v0 = 0x1::option::destroy_some<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Metadata>(0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::metadata(arg0));
        let (v1, v2, v3) = 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::metadata::unpack_text_metadata(0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::metadata::decode_text_metadata(&v0));
        (0x1::ascii::string(v1), v2, v3)
    }

    public fun deploy_tick_tick(arg0: &mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::DeployRecord, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::is_deployed(arg0, tick())) {
            return
        };
        let v0 = WITNESS{dummy_field: false};
        let v1 = 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::internal_deploy_with_witness<WITNESS>(arg0, 0x1::ascii::string(tick()), 18446744073709551615, false, v0, arg1);
        let v2 = TickFactory{
            tick_names     : 0x2::table::new<0x1::ascii::String, u64>(arg1),
            total_tick_fee : 0x1::option::none<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(),
        };
        let v3 = WITNESS{dummy_field: false};
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::tick_record_add_df<TickFactory, WITNESS>(&mut v1, v2, v3);
        0x2::transfer::public_share_object<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecordV2>(v1);
    }

    public fun do_burn(arg0: &mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecordV2, arg1: 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x1::option::Option<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>) {
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::assert_util::assert_tick_record(arg0, tick());
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::assert_util::assert_tick_tick(&arg1);
        let (v0, v1, v2) = internal_burn(arg0, arg1, arg2, arg3);
        let v3 = WITNESS{dummy_field: false};
        0x2::table::remove<0x1::ascii::String, u64>(&mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::tick_record_borrow_mut_df<TickFactory, WITNESS>(arg0, v3).tick_names, v0);
        (v1, v2)
    }

    public fun do_deploy<T0: drop>(arg0: &mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::DeployRecord, arg1: &mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecordV2, arg2: 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription, arg3: u64, arg4: bool, arg5: T0, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecordV2 {
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::assert_util::assert_tick_record(arg1, tick());
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::assert_util::assert_tick_tick(&arg2);
        let (v0, v1, v2) = internal_burn(arg1, arg2, arg6, arg7);
        let v3 = v2;
        let v4 = 0x2::tx_context::sender(arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, v4);
        if (0x1::option::is_some<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&v3)) {
            0x2::transfer::public_transfer<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(0x1::option::destroy_some<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(v3), v4);
        } else {
            0x1::option::destroy_none<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(v3);
        };
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::internal_deploy_with_witness<T0>(arg0, v0, arg3, arg4, arg5, arg7)
    }

    public fun do_mint(arg0: &mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecordV2, arg1: 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription {
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::assert_util::assert_tick_record(arg0, tick());
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::assert_util::assert_move_tick(&arg1);
        assert!(0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::tick_name::is_tick_name_valid(arg2), 1);
        assert!(is_tick_name_available(arg0, arg2), 2);
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::string_util::to_uppercase(&mut arg2);
        let v0 = 0x1::ascii::string(arg2);
        let v1 = WITNESS{dummy_field: false};
        let v2 = 0x2::clock::timestamp_ms(arg3);
        0x2::table::add<0x1::ascii::String, u64>(&mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::tick_record_borrow_mut_df<TickFactory, WITNESS>(arg0, v1).tick_names, v0, v2);
        let v3 = WITNESS{dummy_field: false};
        let v4 = 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::do_mint_with_witness<WITNESS>(arg0, 0x2::balance::zero<0x2::sui::SUI>(), 1, 0x1::option::some<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Metadata>(new_tick_metadata(v0, v2, 0x2::tx_context::sender(arg4))), v3, arg4);
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::lock_within(&mut v4, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::util::split_and_give_back(arg1, 10000, arg4));
        v4
    }

    public fun init_locked_move() : u64 {
        10000
    }

    fun internal_burn(arg0: &mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecordV2, arg1: 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x1::ascii::String, 0x2::coin::Coin<0x2::sui::SUI>, 0x1::option::Option<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>) {
        let (v0, v1, _) = decode_metadata(&arg1);
        let v3 = WITNESS{dummy_field: false};
        let (v4, v5) = 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::do_burn_with_witness<WITNESS>(arg0, arg1, 0x1::ascii::into_bytes(v0), v3, arg3);
        let v6 = WITNESS{dummy_field: false};
        let v7 = 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::tick_record_borrow_mut_df<TickFactory, WITNESS>(arg0, v6);
        (v0, v4, charge_fee(v7, v0, v1, v5, arg2, arg3))
    }

    public fun is_tick_name_available(arg0: &0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecordV2, arg1: vector<u8>) : bool {
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::string_util::to_uppercase(&mut arg1);
        let v0 = 0x1::ascii::string(arg1);
        !0x2::table::contains<0x1::ascii::String, u64>(&0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::tick_record_borrow_df<TickFactory>(arg0).tick_names, v0) && !0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::tick_name::is_tick_name_reserved(0x1::ascii::into_bytes(v0))
    }

    public entry fun mint(arg0: &mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecordV2, arg1: 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = do_mint(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(v0, 0x2::tx_context::sender(arg4));
    }

    fun new_tick_metadata(arg0: 0x1::ascii::String, arg1: u64, arg2: address) : 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Metadata {
        let v0 = 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::metadata::new_ascii_metadata(arg0, arg1, arg2);
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::content_type::new_bcs_metadata<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::metadata::TextMetadata>(&v0)
    }

    public fun tick() : vector<u8> {
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::tick_name::tick_tick()
    }

    public fun tick_names(arg0: &0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecordV2) : &0x2::table::Table<0x1::ascii::String, u64> {
        &0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::tick_record_borrow_df<TickFactory>(arg0).tick_names
    }

    public fun total_tick_fee(arg0: &0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecordV2) : u64 {
        let v0 = 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::tick_record_borrow_df<TickFactory>(arg0);
        if (0x1::option::is_none<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&v0.total_tick_fee)) {
            0
        } else {
            0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::amount(0x1::option::borrow<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&v0.total_tick_fee))
        }
    }

    // decompiled from Move bytecode v6
}

