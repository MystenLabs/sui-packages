module 0x67b49498b9e3d942c9ba3c5442fc85aa2011abcdc1a2edf73d83cb4af46f46e0::pawtato_tool_upgrades {
    struct PAWTATO_TOOL_UPGRADES has drop {
        dummy_field: bool,
    }

    struct ToolUpgrades has key {
        id: 0x2::object::UID,
        treasury_address: address,
        kiosk: 0x2::kiosk::Kiosk,
        kiosk_owner_cap: 0x2::kiosk::KioskOwnerCap,
        burned_nft_ids: vector<0x2::object::ID>,
        pending_burned_nft_ids: vector<0x2::object::ID>,
        version: u64,
        paused: bool,
        pawtato_package_cap: 0x1::option::Option<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>,
        total_upgrades_attempted: u64,
        total_upgrades_successful: u64,
        total_crystal_burned: u64,
        total_sui_donated: u64,
        total_dft_donated: u64,
        total_dft_minted: u64,
        total_tools_sacrificed: u64,
    }

    struct ToolUpgradeAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ToolUpgradeAttempted has copy, drop {
        tool_id: 0x2::object::ID,
        user: address,
        old_tier: 0x1::string::String,
        new_tier: 0x1::string::String,
        success: bool,
        crystal_cost: u64,
        donation_type: 0x1::string::String,
        donation_amount: u64,
        sacrifice_count: u64,
        total_success_rate: u64,
        dft_reward: u64,
        roll: u64,
    }

    struct ToolSalvaged has copy, drop {
        tool_id: 0x2::object::ID,
        salvager: address,
        restoration_percentage: u64,
        dft_reward: u64,
    }

    struct ToolQualityRerolled has copy, drop {
        tool_id: 0x2::object::ID,
        user: address,
        old_quality: u64,
        new_quality: u64,
    }

    struct ToolQualityUpgraded has copy, drop {
        tool_id: 0x2::object::ID,
        user: address,
        old_quality: u64,
        new_quality: u64,
        cost: u64,
        cost_type: 0x1::string::String,
        success: bool,
    }

    struct ToolQualityUpgradedV2 has copy, drop {
        tool_id: 0x2::object::ID,
        user: address,
        old_quality: u64,
        new_quality: u64,
        cost: u64,
        cost_type: 0x1::string::String,
        success: bool,
        attempts: u64,
        successful_attempts: u64,
    }

    fun add_dft_from_salvaging(arg0: &mut ToolUpgrades, arg1: u64) {
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"total_dft_from_salvaging")) {
            *0x2::dynamic_field::borrow_mut<vector<u8>, u64>(&mut arg0.id, b"total_dft_from_salvaging") = get_total_dft_from_salvaging(arg0) + arg1;
        } else {
            0x2::dynamic_field::add<vector<u8>, u64>(&mut arg0.id, b"total_dft_from_salvaging", arg1);
        };
    }

    public entry fun add_pawtato_package_cap(arg0: &ToolUpgradeAdminCap, arg1: &mut ToolUpgrades, arg2: 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg1.pawtato_package_cap)) {
            abort 0
        };
        0x1::option::fill<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&mut arg1.pawtato_package_cap, arg2);
    }

    public entry fun bulk_salvage_tools_from_kiosk(arg0: &mut ToolUpgrades, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg6: vector<0x2::object::ID>, arg7: &0x2::random::Random, arg8: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_not_paused(arg0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg6)) {
            internal_salvage_tool(arg0, *0x1::vector::borrow<0x2::object::ID>(&arg6, v0), arg3, arg4, arg1, arg2, arg5, arg7, arg8);
            v0 = v0 + 1;
        };
    }

    public entry fun burn_all_pending_tools(arg0: &mut ToolUpgrades, arg1: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg2: &mut 0x2::transfer_policy::TransferPolicyCap<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg3: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg4: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        if (!0x1::vector::is_empty<0x2::object::ID>(&arg0.burned_nft_ids)) {
            arg0.burned_nft_ids = 0x1::vector::empty<0x2::object::ID>();
        };
        if (0x1::vector::length<0x2::object::ID>(&arg0.pending_burned_nft_ids) == 0) {
            return
        };
        0x2::transfer_policy::remove_rule<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::Rule, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::Config>(arg1, arg2);
        while (!0x1::vector::is_empty<0x2::object::ID>(&arg0.pending_burned_nft_ids)) {
            let (v0, v1) = 0x2::kiosk::purchase_with_cap<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(&mut arg0.kiosk, 0x2::kiosk::list_with_purchase_cap<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(&mut arg0.kiosk, &arg0.kiosk_owner_cap, 0x1::vector::pop_back<0x2::object::ID>(&mut arg0.pending_burned_nft_ids), 0, arg4), 0x2::coin::zero<0x2::sui::SUI>(arg4));
            let v2 = v1;
            if (0x2::transfer_policy::has_rule<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg1)) {
                0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(arg1, &mut v2, 0x2::coin::zero<0x2::sui::SUI>(arg4));
            };
            let (_, _, _) = 0x2::transfer_policy::confirm_request<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(arg1, v2);
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::burn_tool_with_cap(0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg0.pawtato_package_cap), v0, arg3, arg4);
        };
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(arg1, arg2);
    }

    fun calculate_sacrifice_boost(arg0: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL) : u64 {
        let v0 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_attributes(arg0);
        let v1 = 0x1::string::utf8(b"Tier");
        let v2 = 0x1::string::utf8(b"Quality");
        let v3 = if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(v0, &v2)) {
            let v4 = 0x1::string::utf8(b"Quality");
            0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::string_to_u64(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v0, &v4))
        } else {
            100
        };
        let v5 = 0x1::string::as_bytes(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v0, &v1));
        let v6 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_common();
        let (v7, v8) = if (v5 == &v6) {
            (100, 200)
        } else {
            let v9 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_uncommon();
            if (v5 == &v9) {
                (200, 200)
            } else {
                let v10 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_rare();
                if (v5 == &v10) {
                    (500, 200)
                } else {
                    let v11 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_epic();
                    if (v5 == &v11) {
                        (1000, 200)
                    } else {
                        let v12 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_legendary();
                        if (v5 == &v12) {
                            (2000, 200)
                        } else {
                            (0, 0)
                        }
                    }
                }
            }
        };
        v7 + v8 * v3 / 100
    }

    fun calculate_salvage_dft_reward(arg0: &0x1::string::String, arg1: u64) : u64 {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_common();
        if (v0 == &v1) {
            if (arg1 % 10000 < 100) {
                1000000000
            } else {
                0
            }
        } else {
            let v3 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_uncommon();
            if (v0 == &v3) {
                if (arg1 % 10000 < 200) {
                    1000000000
                } else {
                    0
                }
            } else {
                let v4 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_rare();
                if (v0 == &v4) {
                    if (arg1 % 10000 < 1000) {
                        1000000000
                    } else {
                        0
                    }
                } else {
                    let v5 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_epic();
                    if (v0 == &v5) {
                        5000000000
                    } else {
                        let v6 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_legendary();
                        assert!(v0 == &v6, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tier());
                        10000000000
                    }
                }
            }
        }
    }

    fun calculate_tato_donation_amount(arg0: &ToolUpgrades, arg1: u64) : u64 {
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"tato_per_sui")) {
            arg1 * *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"tato_per_sui")
        } else {
            arg1 * 134
        }
    }

    fun calculate_total_sacrifice_boost(arg0: &0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &vector<0x2::object::ID>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(arg2)) {
            v0 = v0 + calculate_sacrifice_boost(0x2::kiosk::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(arg0, arg1, *0x1::vector::borrow<0x2::object::ID>(arg2, v1)));
            v1 = v1 + 1;
        };
        if (v0 > 2000) {
            2000
        } else {
            v0
        }
    }

    public fun check_not_paused(arg0: &ToolUpgrades) {
        assert!(!arg0.paused, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_contract_paused());
    }

    public fun check_version(arg0: &ToolUpgrades) {
        assert!(arg0.version == 1, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_version_mismatch());
    }

    fun consume_dft_donation(arg0: 0x2::token::Token<0xd72ab42db7dfe82f07858fd4af0d821c939b037b51200554256ed0446b488db::pawtato_coin_divine_favor_token::PAWTATO_COIN_DIVINE_FAVOR_TOKEN>, arg1: u64, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg3: &ToolUpgrades, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xd72ab42db7dfe82f07858fd4af0d821c939b037b51200554256ed0446b488db::pawtato_coin_divine_favor_token::get_token_value(&arg0) >= arg1, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        if (0xd72ab42db7dfe82f07858fd4af0d821c939b037b51200554256ed0446b488db::pawtato_coin_divine_favor_token::get_token_value(&arg0) == arg1) {
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_dft_token_with_cap(0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg3.pawtato_package_cap), arg2, arg0, arg4);
        } else {
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_dft_token_with_cap(0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg3.pawtato_package_cap), arg2, 0xd72ab42db7dfe82f07858fd4af0d821c939b037b51200554256ed0446b488db::pawtato_coin_divine_favor_token::split_token(&mut arg0, arg1, arg4), arg4);
            if (0xd72ab42db7dfe82f07858fd4af0d821c939b037b51200554256ed0446b488db::pawtato_coin_divine_favor_token::get_token_value(&arg0) > 0) {
                0x2::token::keep<0xd72ab42db7dfe82f07858fd4af0d821c939b037b51200554256ed0446b488db::pawtato_coin_divine_favor_token::PAWTATO_COIN_DIVINE_FAVOR_TOKEN>(arg0, arg4);
            } else {
                0xd72ab42db7dfe82f07858fd4af0d821c939b037b51200554256ed0446b488db::pawtato_coin_divine_favor_token::destroy_zero_token(arg0);
            };
        };
    }

    public entry fun consume_upgrade_quality<T0>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg5: &mut ToolUpgrades, arg6: &0x2::random::Random, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::kiosk::borrow_mut<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(arg0, arg1, arg2);
        let v1 = 0x1::type_name::get<T0>();
        let (v2, v3, v4) = if (v1 == 0x1::type_name::get<0xdf1ad9d77bbb3e6fcb3c88394a530cebc828f5d5e132345c13edbaf6ee3cfc04::pawtato_coin_wooden_q_rune::PAWTATO_COIN_WOODEN_Q_RUNE>()) {
            (1000000000, 2000, 1)
        } else if (v1 == 0x1::type_name::get<0x5158d67169434694330813ab96862a05ec6de939984ac7a02ccb62a604bd4565::pawtato_coin_stone_q_rune::PAWTATO_COIN_STONE_Q_RUNE>()) {
            (1000000000, 2000, 1)
        } else if (v1 == 0x1::type_name::get<0x2fa23e8c2994b34f5d2bae9cc877ade7bf4a2f62575611d60c006fa162c302ec::pawtato_coin_iron_q_rune::PAWTATO_COIN_IRON_Q_RUNE>()) {
            (1000000000, 5000, 1)
        } else {
            assert!(v1 == 0x1::type_name::get<0xaf5981f9bee15d210e25f2933671ed587a810ed8cb8819d05fa967f2d4913ff::pawtato_coin_dawnstone::PAWTATO_COIN_DAWNSTONE>(), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_unknown_type());
            (1000000000, 10000, 10)
        };
        internal_consume_quality_upgrade<T0>(v0, arg2, arg3, v2, v3, v4, arg4, arg5, arg6, arg7);
    }

    public entry fun consume_upgrade_quality_staked<T0>(arg0: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg4: &mut ToolUpgrades, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_staked_tool_for_upgrading_with_cap(0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg4.pawtato_package_cap), arg0, 0x2::tx_context::sender(arg6), arg1);
        let v1 = 0x1::type_name::get<T0>();
        let (v2, v3, v4) = if (v1 == 0x1::type_name::get<0xdf1ad9d77bbb3e6fcb3c88394a530cebc828f5d5e132345c13edbaf6ee3cfc04::pawtato_coin_wooden_q_rune::PAWTATO_COIN_WOODEN_Q_RUNE>()) {
            (1000000000, 2000, 1)
        } else if (v1 == 0x1::type_name::get<0x5158d67169434694330813ab96862a05ec6de939984ac7a02ccb62a604bd4565::pawtato_coin_stone_q_rune::PAWTATO_COIN_STONE_Q_RUNE>()) {
            (1000000000, 2000, 1)
        } else if (v1 == 0x1::type_name::get<0x2fa23e8c2994b34f5d2bae9cc877ade7bf4a2f62575611d60c006fa162c302ec::pawtato_coin_iron_q_rune::PAWTATO_COIN_IRON_Q_RUNE>()) {
            (1000000000, 5000, 1)
        } else {
            assert!(v1 == 0x1::type_name::get<0xaf5981f9bee15d210e25f2933671ed587a810ed8cb8819d05fa967f2d4913ff::pawtato_coin_dawnstone::PAWTATO_COIN_DAWNSTONE>(), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_unknown_type());
            (1000000000, 10000, 10)
        };
        internal_consume_quality_upgrade<T0>(v0, arg1, arg2, v2, v3, v4, arg3, arg4, arg5, arg6);
    }

    fun get_salvage_restoration_percentage(arg0: &0x1::string::String) : u64 {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_common();
        if (v0 == &v1) {
            3000
        } else {
            let v3 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_uncommon();
            if (v0 == &v3) {
                5000
            } else {
                let v4 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_rare();
                if (v0 == &v4) {
                    7000
                } else {
                    let v5 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_epic();
                    if (v0 == &v5) {
                        10000
                    } else {
                        let v6 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_legendary();
                        assert!(v0 == &v6, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tier());
                        10000
                    }
                }
            }
        }
    }

    fun get_total_dft_from_salvaging(arg0: &ToolUpgrades) : u64 {
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"total_dft_from_salvaging")) {
            *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"total_dft_from_salvaging")
        } else {
            0
        }
    }

    fun get_total_tools_salvaged(arg0: &ToolUpgrades) : u64 {
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"total_tools_salvaged")) {
            *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"total_tools_salvaged")
        } else {
            0
        }
    }

    fun get_upgrade_params(arg0: &0x1::string::String) : (u64, u64, u64, u64, u64, u64) {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_common();
        if (v0 == &v1) {
            (1000000000, 6000, 1000000000, 3000, 1000000000, 100)
        } else {
            let v8 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_uncommon();
            if (v0 == &v8) {
                (2000000000, 4000, 2000000000, 2500, 2000000000, 200)
            } else {
                let v9 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_rare();
                if (v0 == &v9) {
                    (3000000000, 2500, 3000000000, 2000, 3000000000, 500)
                } else {
                    let v10 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_epic();
                    if (v0 == &v10) {
                        (5000000000, 1000, 5000000000, 1000, 5000000000, 1000)
                    } else {
                        let v11 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_legendary();
                        assert!(v0 == &v11, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tier());
                        (10000000000, 0, 10000000000, 500, 10000000000, 2000)
                    }
                }
            }
        }
    }

    fun increment_tools_salvaged(arg0: &mut ToolUpgrades) {
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"total_tools_salvaged")) {
            *0x2::dynamic_field::borrow_mut<vector<u8>, u64>(&mut arg0.id, b"total_tools_salvaged") = get_total_tools_salvaged(arg0) + 1;
        } else {
            0x2::dynamic_field::add<vector<u8>, u64>(&mut arg0.id, b"total_tools_salvaged", 1);
        };
    }

    fun init(arg0: PAWTATO_TOOL_UPGRADES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ToolUpgradeAdminCap{id: 0x2::object::new(arg1)};
        let (v1, v2) = 0x2::kiosk::new(arg1);
        let v3 = ToolUpgrades{
            id                        : 0x2::object::new(arg1),
            treasury_address          : @0xdbcbd9813b8b82eaa422ffb178eb746e6abbb73efeabd977440da0d811ce0742,
            kiosk                     : v1,
            kiosk_owner_cap           : v2,
            burned_nft_ids            : 0x1::vector::empty<0x2::object::ID>(),
            pending_burned_nft_ids    : 0x1::vector::empty<0x2::object::ID>(),
            version                   : 1,
            paused                    : false,
            pawtato_package_cap       : 0x1::option::none<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(),
            total_upgrades_attempted  : 0,
            total_upgrades_successful : 0,
            total_crystal_burned      : 0,
            total_sui_donated         : 0,
            total_dft_donated         : 0,
            total_dft_minted          : 0,
            total_tools_sacrificed    : 0,
        };
        0x2::transfer::transfer<ToolUpgradeAdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<PAWTATO_TOOL_UPGRADES>(arg0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<ToolUpgrades>(v3);
    }

    fun internal_consume_quality_upgrade<T0>(arg0: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg7: &mut ToolUpgrades, arg8: &0x2::random::Random, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        check_version(arg7);
        check_not_paused(arg7);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 >= arg3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        let v1 = v0 / arg3;
        assert!(v1 > 0, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<T0>(arg6, arg2);
        let v2 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_quality_value(arg0);
        assert!(0x1::option::is_some<u64>(&v2), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_quality_not_initialized());
        let v3 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_quality_value(arg0);
        let v4 = *0x1::option::borrow<u64>(&v3);
        assert!(v4 < 100, 100);
        let v5 = v4;
        let v6 = 0;
        let v7 = 0x2::random::new_generator(arg8, arg9);
        let v8 = 0;
        while (v8 < v1 && v5 < 100) {
            if (0x2::random::generate_u64(&mut v7) % 10000 < arg4) {
                let v9 = v5 + arg5;
                let v10 = if (v9 > 100) {
                    100
                } else {
                    v9
                };
                v5 = v10;
                v6 = v6 + 1;
            };
            v8 = v8 + 1;
        };
        if (v5 != v4) {
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::update_tool_quality_with_cap(0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg7.pawtato_package_cap), arg0, v5);
        };
        let v11 = ToolQualityUpgradedV2{
            tool_id             : arg1,
            user                : 0x2::tx_context::sender(arg9),
            old_quality         : v4,
            new_quality         : v5,
            cost                : v0,
            cost_type           : 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<T0>(),
            success             : v6 > 0,
            attempts            : v1,
            successful_attempts : v6,
        };
        0x2::event::emit<ToolQualityUpgradedV2>(v11);
        v6
    }

    fun internal_reroll_quality(arg0: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0xecc04712d7513fe9e9b27bb7366ded7c0acc78746c06276bc9fe8d17fc14061f::pawtato_coin_chaos_seed::PAWTATO_COIN_CHAOS_SEED>, arg3: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg4: &mut ToolUpgrades, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        check_version(arg4);
        check_not_paused(arg4);
        assert!(0x2::coin::value<0xecc04712d7513fe9e9b27bb7366ded7c0acc78746c06276bc9fe8d17fc14061f::pawtato_coin_chaos_seed::PAWTATO_COIN_CHAOS_SEED>(&arg2) == 1000000000, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0xecc04712d7513fe9e9b27bb7366ded7c0acc78746c06276bc9fe8d17fc14061f::pawtato_coin_chaos_seed::PAWTATO_COIN_CHAOS_SEED>(arg3, arg2);
        let v0 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_quality_value(arg0);
        let v1 = 0x2::random::new_generator(arg5, arg6);
        let v2 = 0x2::random::generate_u64(&mut v1) % 100 + 1;
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::update_tool_quality_with_cap(0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg4.pawtato_package_cap), arg0, v2);
        let v3 = if (0x1::option::is_some<u64>(&v0)) {
            *0x1::option::borrow<u64>(&v0)
        } else {
            0
        };
        let v4 = ToolQualityRerolled{
            tool_id     : arg1,
            user        : 0x2::tx_context::sender(arg6),
            old_quality : v3,
            new_quality : v2,
        };
        0x2::event::emit<ToolQualityRerolled>(v4);
    }

    fun internal_salvage_tool(arg0: &mut ToolUpgrades, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg5: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg6: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg7: &0x2::random::Random, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let (v1, v2) = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_kiosk_helpers::borrow_for_modification<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(arg2, arg3, arg1, arg8);
        let v3 = v1;
        let v4 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier(&v3);
        let v5 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_mythic();
        assert!(0x1::string::as_bytes(v4) != &v5, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tier());
        let v6 = 0x2::object::id<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(&v3);
        let v7 = get_salvage_restoration_percentage(v4);
        let v8 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_durability(v4);
        let v9 = if (v8 == 0) {
            10000
        } else {
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_durability_value(&v3) * 10000 / v8
        };
        let v10 = 0x2::random::new_generator(arg7, arg8);
        let v11 = calculate_salvage_dft_reward(v4, 0x2::random::generate_u64(&mut v10));
        let v12 = 0x67b49498b9e3d942c9ba3c5442fc85aa2011abcdc1a2edf73d83cb4af46f46e0::pawtato_tool_crafting_v2::get_tool_resource_costs(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_item_type(&v3));
        let v13 = 0;
        while (v13 < 0x1::vector::length<0x67b49498b9e3d942c9ba3c5442fc85aa2011abcdc1a2edf73d83cb4af46f46e0::pawtato_tool_crafting_v2::ToolResourceCost>(&v12)) {
            let v14 = 0x1::vector::borrow<0x67b49498b9e3d942c9ba3c5442fc85aa2011abcdc1a2edf73d83cb4af46f46e0::pawtato_tool_crafting_v2::ToolResourceCost>(&v12, v13);
            let v15 = 0x67b49498b9e3d942c9ba3c5442fc85aa2011abcdc1a2edf73d83cb4af46f46e0::pawtato_tool_crafting_v2::get_resource_type(v14);
            let v16 = 0x67b49498b9e3d942c9ba3c5442fc85aa2011abcdc1a2edf73d83cb4af46f46e0::pawtato_tool_crafting_v2::get_amount(v14) * v7 / 10000 * v9 / 10000;
            let v17 = if (v16 > 0) {
                if (v15 != 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_water()) {
                    if (v15 != 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_chaos_seed()) {
                        if (v15 != 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_titanium_splinter()) {
                            if (v15 != 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_phoenix_feather()) {
                                if (v15 != 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_dawnstone()) {
                                    v15 != 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_primal_loam()
                                } else {
                                    false
                                }
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v17) {
                mint_and_transfer_resource_by_type(arg0, arg5, v15, v16, v0, arg8);
            };
            v13 = v13 + 1;
        };
        if (v11 > 0) {
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::mint_dft_with_cap(0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg0.pawtato_package_cap), arg5, 0x2::object::id<ToolUpgrades>(arg0), v11, v0, arg8);
        };
        increment_tools_salvaged(arg0);
        add_dft_from_salvaging(arg0, v11);
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::mark_tool_as_burned_with_cap(0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg0.pawtato_package_cap), &mut v3);
        0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_kiosk_helpers::return_after_modification<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(&mut arg0.kiosk, &arg0.kiosk_owner_cap, v3, v2, arg6, arg8);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.pending_burned_nft_ids, v6);
        let v18 = ToolSalvaged{
            tool_id                : v6,
            salvager               : v0,
            restoration_percentage : v7,
            dft_reward             : v11,
        };
        0x2::event::emit<ToolSalvaged>(v18);
    }

    fun mint_and_transfer_resource_by_type(arg0: &ToolUpgrades, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: u8, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg0.pawtato_package_cap);
        if (arg2 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_wood()) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>>(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::mint_coin_with_cap<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>(v0, arg1, 0x2::object::id<ToolUpgrades>(arg0), arg3, arg5), arg4);
        } else if (arg2 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_stone()) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>>(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::mint_coin_with_cap<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>(v0, arg1, 0x2::object::id<ToolUpgrades>(arg0), arg3, arg5), arg4);
        } else if (arg2 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_water()) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>>(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::mint_coin_with_cap<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(v0, arg1, 0x2::object::id<ToolUpgrades>(arg0), arg3, arg5), arg4);
        } else if (arg2 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_coal()) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal::PAWTATO_COIN_COAL>>(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::mint_coin_with_cap<0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal::PAWTATO_COIN_COAL>(v0, arg1, 0x2::object::id<ToolUpgrades>(arg0), arg3, arg5), arg4);
        } else if (arg2 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_iron()) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x422d4e84d7eaee54e75c140e2f7ae9503311f516342ef2c6020c8f8be8629024::pawtato_coin_iron::PAWTATO_COIN_IRON>>(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::mint_coin_with_cap<0x422d4e84d7eaee54e75c140e2f7ae9503311f516342ef2c6020c8f8be8629024::pawtato_coin_iron::PAWTATO_COIN_IRON>(v0, arg1, 0x2::object::id<ToolUpgrades>(arg0), arg3, arg5), arg4);
        } else if (arg2 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_gold()) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xf9d3566bb782d792a93a16a9db69211808048dee1914b64cb7f96a3582258671::pawtato_coin_gold::PAWTATO_COIN_GOLD>>(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::mint_coin_with_cap<0xf9d3566bb782d792a93a16a9db69211808048dee1914b64cb7f96a3582258671::pawtato_coin_gold::PAWTATO_COIN_GOLD>(v0, arg1, 0x2::object::id<ToolUpgrades>(arg0), arg3, arg5), arg4);
        } else if (arg2 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_crystal()) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>>(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::mint_coin_with_cap<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(v0, arg1, 0x2::object::id<ToolUpgrades>(arg0), arg3, arg5), arg4);
        } else if (arg2 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_wooden_plank()) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>>(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::mint_coin_with_cap<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>(v0, arg1, 0x2::object::id<ToolUpgrades>(arg0), arg3, arg5), arg4);
        } else if (arg2 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_stone_block()) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>>(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::mint_coin_with_cap<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>(v0, arg1, 0x2::object::id<ToolUpgrades>(arg0), arg3, arg5), arg4);
        } else if (arg2 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_iron_bar()) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>>(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::mint_coin_with_cap<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>(v0, arg1, 0x2::object::id<ToolUpgrades>(arg0), arg3, arg5), arg4);
        } else {
            assert!(arg2 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_gold_bar(), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_unknown_type());
            0x2::transfer::public_transfer<0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>>(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::mint_coin_with_cap<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>(v0, arg1, 0x2::object::id<ToolUpgrades>(arg0), arg3, arg5), arg4);
        };
    }

    fun perform_upgrade_attempt(arg0: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: 0x1::string::String, arg10: u64, arg11: u64, arg12: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg13: &mut ToolUpgrades, arg14: &0x2::random::Random, arg15: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::tx_context::sender(arg15);
        arg13.total_upgrades_attempted = arg13.total_upgrades_attempted + 1;
        arg13.total_crystal_burned = arg13.total_crystal_burned + arg4;
        if (arg9 == 0x1::string::utf8(b"sui") || arg9 == 0x1::string::utf8(b"sui_sacrifice")) {
            arg13.total_sui_donated = arg13.total_sui_donated + arg10;
        } else if (arg9 == 0x1::string::utf8(b"dft") || arg9 == 0x1::string::utf8(b"dft_sacrifice")) {
            arg13.total_dft_donated = arg13.total_dft_donated + arg10;
        };
        let v1 = arg5 + arg6 + arg7;
        let v2 = if (v1 > 10000) {
            10000
        } else {
            v1
        };
        let v3 = 0x2::random::new_generator(arg14, arg15);
        let v4 = 0x2::random::generate_u64(&mut v3) % 10000;
        let v5 = v4 < v2;
        if (v5) {
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::upgrade_tool_to_next_tier_with_cap(0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg13.pawtato_package_cap), arg0, arg3);
            arg13.total_upgrades_successful = arg13.total_upgrades_successful + 1;
            let v6 = ToolUpgradeAttempted{
                tool_id            : arg1,
                user               : v0,
                old_tier           : arg2,
                new_tier           : arg3,
                success            : true,
                crystal_cost       : arg4,
                donation_type      : arg9,
                donation_amount    : arg10,
                sacrifice_count    : arg11,
                total_success_rate : v2,
                dft_reward         : 0,
                roll               : v4,
            };
            0x2::event::emit<ToolUpgradeAttempted>(v6);
        } else {
            arg13.total_dft_minted = arg13.total_dft_minted + arg8;
            let v7 = ToolUpgradeAttempted{
                tool_id            : arg1,
                user               : v0,
                old_tier           : arg2,
                new_tier           : arg3,
                success            : false,
                crystal_cost       : arg4,
                donation_type      : arg9,
                donation_amount    : arg10,
                sacrifice_count    : arg11,
                total_success_rate : v2,
                dft_reward         : arg8,
                roll               : v4,
            };
            0x2::event::emit<ToolUpgradeAttempted>(v7);
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::mint_dft_with_cap(0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg13.pawtato_package_cap), arg12, 0x2::object::id<ToolUpgrades>(arg13), arg8, v0, arg15);
        };
        v5
    }

    fun prepare_tool_upgrade(arg0: &0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID) : (0x1::string::String, 0x1::string::String, u64, u64, u64, u64, u64) {
        let v0 = *0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier(0x2::kiosk::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(arg0, arg1, arg2));
        let v1 = 0x1::string::utf8(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_mythic());
        assert!(0x1::string::as_bytes(&v0) != 0x1::string::as_bytes(&v1), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tier());
        let (v2, v3, v4, v5, v6, _) = get_upgrade_params(&v0);
        (v0, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_next_tier(&v0), v2, v3, v4, v5, v6)
    }

    public entry fun reroll_quality(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0xecc04712d7513fe9e9b27bb7366ded7c0acc78746c06276bc9fe8d17fc14061f::pawtato_coin_chaos_seed::PAWTATO_COIN_CHAOS_SEED>, arg4: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg5: &mut ToolUpgrades, arg6: &0x2::random::Random, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::kiosk::borrow_mut<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(arg0, arg1, arg2);
        internal_reroll_quality(v0, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun reroll_quality_staked(arg0: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0xecc04712d7513fe9e9b27bb7366ded7c0acc78746c06276bc9fe8d17fc14061f::pawtato_coin_chaos_seed::PAWTATO_COIN_CHAOS_SEED>, arg3: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg4: &mut ToolUpgrades, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_staked_tool_for_upgrading_with_cap(0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg4.pawtato_package_cap), arg0, 0x2::tx_context::sender(arg6), arg1);
        internal_reroll_quality(v0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    fun sacrifice_tools_internal(arg0: &mut ToolUpgrades, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg4: vector<0x2::object::ID>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg4);
        arg0.total_tools_sacrificed = arg0.total_tools_sacrificed + v0;
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<0x2::object::ID>(&arg4, v1);
            let (v3, v4) = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_kiosk_helpers::borrow_for_modification<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(arg1, arg2, v2, arg5);
            let v5 = v3;
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::mark_tool_as_burned_with_cap(0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg0.pawtato_package_cap), &mut v5);
            0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_kiosk_helpers::return_after_modification<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(&mut arg0.kiosk, &arg0.kiosk_owner_cap, v5, v4, arg3, arg5);
            0x1::vector::push_back<0x2::object::ID>(&mut arg0.pending_burned_nft_ids, v2);
            v1 = v1 + 1;
        };
    }

    public entry fun salvage_tool_from_kiosk(arg0: &mut ToolUpgrades, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg6: 0x2::object::ID, arg7: &0x2::random::Random, arg8: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_not_paused(arg0);
        internal_salvage_tool(arg0, arg6, arg3, arg4, arg1, arg2, arg5, arg7, arg8);
    }

    public entry fun set_paused(arg0: &ToolUpgradeAdminCap, arg1: &mut ToolUpgrades, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.paused = arg2;
    }

    public entry fun set_tato_per_sui_rate(arg0: &ToolUpgradeAdminCap, arg1: &mut ToolUpgrades, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, b"tato_per_sui")) {
            *0x2::dynamic_field::borrow_mut<vector<u8>, u64>(&mut arg1.id, b"tato_per_sui") = arg2;
        } else {
            0x2::dynamic_field::add<vector<u8>, u64>(&mut arg1.id, b"tato_per_sui", arg2);
        };
    }

    public entry fun upgrade_staked_tool_basic(arg0: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg5: vector<0x2::object::ID>, arg6: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg7: &mut ToolUpgrades, arg8: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg9: &0x2::random::Random, arg10: &mut 0x2::tx_context::TxContext) {
        validate_upgrade_preconditions(arg7, &arg5);
        let v0 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_staked_tool_for_upgrading_with_cap(0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg7.pawtato_package_cap), arg0, 0x2::tx_context::sender(arg10), arg3);
        let v1 = *0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier(v0);
        let v2 = 0x1::string::utf8(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_mythic());
        assert!(0x1::string::as_bytes(&v1) != 0x1::string::as_bytes(&v2), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tier());
        let (v3, v4, _, _, v7, _) = get_upgrade_params(&v1);
        let v9 = 0x1::vector::length<0x2::object::ID>(&arg5);
        assert!(0x2::coin::value<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(&arg4) >= v3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(arg6, arg4);
        let v10 = if (v9 > 0) {
            0x1::string::utf8(b"none_sacrifice")
        } else {
            0x1::string::utf8(b"none")
        };
        if (perform_upgrade_attempt(v0, arg3, v1, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_next_tier(&v1), v3, v4, 0, calculate_total_sacrifice_boost(arg1, arg2, &arg5), v7, v10, 0, v9, arg6, arg7, arg9, arg10)) {
            sacrifice_tools_internal(arg7, arg1, arg2, arg8, arg5, arg10);
        };
    }

    public entry fun upgrade_staked_tool_urr_epic_to_legendary(arg0: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg5: 0x2::coin::Coin<0x30021448e6d54825ced6d2b73f3b763a0da8a28c1c42fd6f0b864323ac60ab45::pawtato_coin_titanium_splinter::PAWTATO_COIN_TITANIUM_SPLINTER>, arg6: vector<0x2::object::ID>, arg7: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg8: &mut ToolUpgrades, arg9: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg10: &0x2::random::Random, arg11: &mut 0x2::tx_context::TxContext) {
        validate_upgrade_preconditions(arg8, &arg6);
        let v0 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_staked_tool_for_upgrading_with_cap(0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg8.pawtato_package_cap), arg0, 0x2::tx_context::sender(arg11), arg3);
        let v1 = *0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier(v0);
        let v2 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_epic();
        assert!(0x1::string::as_bytes(&v1) == &v2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tier());
        let v3 = 5000000000;
        let v4 = 0x1::vector::length<0x2::object::ID>(&arg6);
        assert!(0x2::coin::value<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(&arg4) >= v3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        assert!(0x2::coin::value<0x30021448e6d54825ced6d2b73f3b763a0da8a28c1c42fd6f0b864323ac60ab45::pawtato_coin_titanium_splinter::PAWTATO_COIN_TITANIUM_SPLINTER>(&arg5) >= 1000000000, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(arg7, arg4);
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x30021448e6d54825ced6d2b73f3b763a0da8a28c1c42fd6f0b864323ac60ab45::pawtato_coin_titanium_splinter::PAWTATO_COIN_TITANIUM_SPLINTER>(arg7, arg5);
        let v5 = if (v4 > 0) {
            0x1::string::utf8(b"none_sacrifice")
        } else {
            0x1::string::utf8(b"none")
        };
        if (perform_upgrade_attempt(v0, arg3, v1, 0x1::string::utf8(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_legendary()), v3, 7500, 0, calculate_total_sacrifice_boost(arg1, arg2, &arg6), 5000000000, v5, 0, v4, arg7, arg8, arg10, arg11)) {
            sacrifice_tools_internal(arg8, arg1, arg2, arg9, arg6, arg11);
        };
    }

    public entry fun upgrade_staked_tool_urr_epic_to_legendary_with_dft(arg0: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg5: 0x2::coin::Coin<0x30021448e6d54825ced6d2b73f3b763a0da8a28c1c42fd6f0b864323ac60ab45::pawtato_coin_titanium_splinter::PAWTATO_COIN_TITANIUM_SPLINTER>, arg6: 0x2::token::Token<0xd72ab42db7dfe82f07858fd4af0d821c939b037b51200554256ed0446b488db::pawtato_coin_divine_favor_token::PAWTATO_COIN_DIVINE_FAVOR_TOKEN>, arg7: vector<0x2::object::ID>, arg8: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg9: &mut ToolUpgrades, arg10: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg11: &0x2::random::Random, arg12: &mut 0x2::tx_context::TxContext) {
        validate_upgrade_preconditions(arg9, &arg7);
        let v0 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_staked_tool_for_upgrading_with_cap(0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg9.pawtato_package_cap), arg0, 0x2::tx_context::sender(arg12), arg3);
        let v1 = *0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier(v0);
        let v2 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_epic();
        assert!(0x1::string::as_bytes(&v1) == &v2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tier());
        let v3 = 5000000000;
        let v4 = 5000000000;
        let v5 = 0x1::vector::length<0x2::object::ID>(&arg7);
        assert!(0x2::coin::value<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(&arg4) >= v3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        assert!(0x2::coin::value<0x30021448e6d54825ced6d2b73f3b763a0da8a28c1c42fd6f0b864323ac60ab45::pawtato_coin_titanium_splinter::PAWTATO_COIN_TITANIUM_SPLINTER>(&arg5) >= 1000000000, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        assert!(0xd72ab42db7dfe82f07858fd4af0d821c939b037b51200554256ed0446b488db::pawtato_coin_divine_favor_token::get_token_value(&arg6) >= v4, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(arg8, arg4);
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x30021448e6d54825ced6d2b73f3b763a0da8a28c1c42fd6f0b864323ac60ab45::pawtato_coin_titanium_splinter::PAWTATO_COIN_TITANIUM_SPLINTER>(arg8, arg5);
        consume_dft_donation(arg6, v4, arg8, arg9, arg12);
        let v6 = if (v5 > 0) {
            0x1::string::utf8(b"dft_sacrifice")
        } else {
            0x1::string::utf8(b"dft")
        };
        if (perform_upgrade_attempt(v0, arg3, v1, 0x1::string::utf8(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_legendary()), v3, 7500, 1000, calculate_total_sacrifice_boost(arg1, arg2, &arg7), 5000000000, v6, v4, v5, arg8, arg9, arg11, arg12)) {
            sacrifice_tools_internal(arg9, arg1, arg2, arg10, arg7, arg12);
        };
    }

    public entry fun upgrade_staked_tool_urr_epic_to_legendary_with_sui(arg0: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg5: 0x2::coin::Coin<0x30021448e6d54825ced6d2b73f3b763a0da8a28c1c42fd6f0b864323ac60ab45::pawtato_coin_titanium_splinter::PAWTATO_COIN_TITANIUM_SPLINTER>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: vector<0x2::object::ID>, arg8: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg9: &mut ToolUpgrades, arg10: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg11: &0x2::random::Random, arg12: &mut 0x2::tx_context::TxContext) {
        validate_upgrade_preconditions(arg9, &arg7);
        let v0 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_staked_tool_for_upgrading_with_cap(0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg9.pawtato_package_cap), arg0, 0x2::tx_context::sender(arg12), arg3);
        let v1 = *0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier(v0);
        let v2 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_epic();
        assert!(0x1::string::as_bytes(&v1) == &v2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tier());
        let v3 = 5000000000;
        let v4 = 5000000000;
        let v5 = 0x1::vector::length<0x2::object::ID>(&arg7);
        assert!(0x2::coin::value<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(&arg4) >= v3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        assert!(0x2::coin::value<0x30021448e6d54825ced6d2b73f3b763a0da8a28c1c42fd6f0b864323ac60ab45::pawtato_coin_titanium_splinter::PAWTATO_COIN_TITANIUM_SPLINTER>(&arg5) >= 1000000000, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg6) >= v4, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(arg8, arg4);
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x30021448e6d54825ced6d2b73f3b763a0da8a28c1c42fd6f0b864323ac60ab45::pawtato_coin_titanium_splinter::PAWTATO_COIN_TITANIUM_SPLINTER>(arg8, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg6, arg9.treasury_address);
        let v6 = if (v5 > 0) {
            0x1::string::utf8(b"sui_sacrifice")
        } else {
            0x1::string::utf8(b"sui")
        };
        if (perform_upgrade_attempt(v0, arg3, v1, 0x1::string::utf8(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_legendary()), v3, 7500, 1000, calculate_total_sacrifice_boost(arg1, arg2, &arg7), 5000000000, v6, v4, v5, arg8, arg9, arg11, arg12)) {
            sacrifice_tools_internal(arg9, arg1, arg2, arg10, arg7, arg12);
        };
    }

    public entry fun upgrade_staked_tool_urr_epic_to_legendary_with_tato(arg0: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg5: 0x2::coin::Coin<0x30021448e6d54825ced6d2b73f3b763a0da8a28c1c42fd6f0b864323ac60ab45::pawtato_coin_titanium_splinter::PAWTATO_COIN_TITANIUM_SPLINTER>, arg6: 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>, arg7: vector<0x2::object::ID>, arg8: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg9: &mut ToolUpgrades, arg10: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg11: &0x2::random::Random, arg12: &mut 0x2::tx_context::TxContext) {
        validate_upgrade_preconditions(arg9, &arg7);
        let v0 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_staked_tool_for_upgrading_with_cap(0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg9.pawtato_package_cap), arg0, 0x2::tx_context::sender(arg12), arg3);
        let v1 = *0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier(v0);
        let v2 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_epic();
        assert!(0x1::string::as_bytes(&v1) == &v2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tier());
        let v3 = 5000000000;
        let v4 = 5000000000;
        let v5 = 0x1::vector::length<0x2::object::ID>(&arg7);
        assert!(0x2::coin::value<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(&arg4) >= v3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        assert!(0x2::coin::value<0x30021448e6d54825ced6d2b73f3b763a0da8a28c1c42fd6f0b864323ac60ab45::pawtato_coin_titanium_splinter::PAWTATO_COIN_TITANIUM_SPLINTER>(&arg5) >= 1000000000, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        assert!(0x2::coin::value<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>(&arg6) >= calculate_tato_donation_amount(arg9, v4), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(arg8, arg4);
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x30021448e6d54825ced6d2b73f3b763a0da8a28c1c42fd6f0b864323ac60ab45::pawtato_coin_titanium_splinter::PAWTATO_COIN_TITANIUM_SPLINTER>(arg8, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>>(arg6, arg9.treasury_address);
        let v6 = if (v5 > 0) {
            0x1::string::utf8(b"tato_sacrifice")
        } else {
            0x1::string::utf8(b"tato")
        };
        if (perform_upgrade_attempt(v0, arg3, v1, 0x1::string::utf8(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_legendary()), v3, 7500, 1000, calculate_total_sacrifice_boost(arg1, arg2, &arg7), 5000000000, v6, v4, v5, arg8, arg9, arg11, arg12)) {
            sacrifice_tools_internal(arg9, arg1, arg2, arg10, arg7, arg12);
        };
    }

    public entry fun upgrade_staked_tool_urr_legendary_to_mythic(arg0: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg5: 0x2::coin::Coin<0x6e82bb8cbed21683ac0109171135b4d75187fc74749593163f3dc426ef3b32b4::pawtato_coin_phoenix_feather::PAWTATO_COIN_PHOENIX_FEATHER>, arg6: vector<0x2::object::ID>, arg7: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg8: &mut ToolUpgrades, arg9: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg10: &0x2::random::Random, arg11: &mut 0x2::tx_context::TxContext) {
        validate_upgrade_preconditions(arg8, &arg6);
        let v0 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_staked_tool_for_upgrading_with_cap(0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg8.pawtato_package_cap), arg0, 0x2::tx_context::sender(arg11), arg3);
        let v1 = *0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier(v0);
        let v2 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_legendary();
        assert!(0x1::string::as_bytes(&v1) == &v2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tier());
        let v3 = 10000000000;
        let v4 = 0x1::vector::length<0x2::object::ID>(&arg6);
        assert!(0x2::coin::value<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(&arg4) >= v3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        assert!(0x2::coin::value<0x6e82bb8cbed21683ac0109171135b4d75187fc74749593163f3dc426ef3b32b4::pawtato_coin_phoenix_feather::PAWTATO_COIN_PHOENIX_FEATHER>(&arg5) >= 1000000000, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(arg7, arg4);
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x6e82bb8cbed21683ac0109171135b4d75187fc74749593163f3dc426ef3b32b4::pawtato_coin_phoenix_feather::PAWTATO_COIN_PHOENIX_FEATHER>(arg7, arg5);
        let v5 = if (v4 > 0) {
            0x1::string::utf8(b"none_sacrifice")
        } else {
            0x1::string::utf8(b"none")
        };
        if (perform_upgrade_attempt(v0, arg3, v1, 0x1::string::utf8(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_mythic()), v3, 7500, 0, calculate_total_sacrifice_boost(arg1, arg2, &arg6), 10000000000, v5, 0, v4, arg7, arg8, arg10, arg11)) {
            sacrifice_tools_internal(arg8, arg1, arg2, arg9, arg6, arg11);
        };
    }

    public entry fun upgrade_staked_tool_urr_legendary_to_mythic_with_dft(arg0: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg5: 0x2::coin::Coin<0x6e82bb8cbed21683ac0109171135b4d75187fc74749593163f3dc426ef3b32b4::pawtato_coin_phoenix_feather::PAWTATO_COIN_PHOENIX_FEATHER>, arg6: 0x2::token::Token<0xd72ab42db7dfe82f07858fd4af0d821c939b037b51200554256ed0446b488db::pawtato_coin_divine_favor_token::PAWTATO_COIN_DIVINE_FAVOR_TOKEN>, arg7: vector<0x2::object::ID>, arg8: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg9: &mut ToolUpgrades, arg10: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg11: &0x2::random::Random, arg12: &mut 0x2::tx_context::TxContext) {
        validate_upgrade_preconditions(arg9, &arg7);
        let v0 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_staked_tool_for_upgrading_with_cap(0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg9.pawtato_package_cap), arg0, 0x2::tx_context::sender(arg12), arg3);
        let v1 = *0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier(v0);
        let v2 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_legendary();
        assert!(0x1::string::as_bytes(&v1) == &v2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tier());
        let v3 = 10000000000;
        let v4 = 10000000000;
        let v5 = 0x1::vector::length<0x2::object::ID>(&arg7);
        assert!(0x2::coin::value<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(&arg4) >= v3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        assert!(0x2::coin::value<0x6e82bb8cbed21683ac0109171135b4d75187fc74749593163f3dc426ef3b32b4::pawtato_coin_phoenix_feather::PAWTATO_COIN_PHOENIX_FEATHER>(&arg5) >= 1000000000, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        assert!(0xd72ab42db7dfe82f07858fd4af0d821c939b037b51200554256ed0446b488db::pawtato_coin_divine_favor_token::get_token_value(&arg6) >= v4, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(arg8, arg4);
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x6e82bb8cbed21683ac0109171135b4d75187fc74749593163f3dc426ef3b32b4::pawtato_coin_phoenix_feather::PAWTATO_COIN_PHOENIX_FEATHER>(arg8, arg5);
        consume_dft_donation(arg6, v4, arg8, arg9, arg12);
        let v6 = if (v5 > 0) {
            0x1::string::utf8(b"dft_sacrifice")
        } else {
            0x1::string::utf8(b"dft")
        };
        if (perform_upgrade_attempt(v0, arg3, v1, 0x1::string::utf8(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_mythic()), v3, 7500, 500, calculate_total_sacrifice_boost(arg1, arg2, &arg7), 10000000000, v6, v4, v5, arg8, arg9, arg11, arg12)) {
            sacrifice_tools_internal(arg9, arg1, arg2, arg10, arg7, arg12);
        };
    }

    public entry fun upgrade_staked_tool_urr_legendary_to_mythic_with_sui(arg0: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg5: 0x2::coin::Coin<0x6e82bb8cbed21683ac0109171135b4d75187fc74749593163f3dc426ef3b32b4::pawtato_coin_phoenix_feather::PAWTATO_COIN_PHOENIX_FEATHER>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: vector<0x2::object::ID>, arg8: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg9: &mut ToolUpgrades, arg10: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg11: &0x2::random::Random, arg12: &mut 0x2::tx_context::TxContext) {
        validate_upgrade_preconditions(arg9, &arg7);
        let v0 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_staked_tool_for_upgrading_with_cap(0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg9.pawtato_package_cap), arg0, 0x2::tx_context::sender(arg12), arg3);
        let v1 = *0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier(v0);
        let v2 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_legendary();
        assert!(0x1::string::as_bytes(&v1) == &v2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tier());
        let v3 = 10000000000;
        let v4 = 10000000000;
        let v5 = 0x1::vector::length<0x2::object::ID>(&arg7);
        assert!(0x2::coin::value<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(&arg4) >= v3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        assert!(0x2::coin::value<0x6e82bb8cbed21683ac0109171135b4d75187fc74749593163f3dc426ef3b32b4::pawtato_coin_phoenix_feather::PAWTATO_COIN_PHOENIX_FEATHER>(&arg5) >= 1000000000, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg6) >= v4, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(arg8, arg4);
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x6e82bb8cbed21683ac0109171135b4d75187fc74749593163f3dc426ef3b32b4::pawtato_coin_phoenix_feather::PAWTATO_COIN_PHOENIX_FEATHER>(arg8, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg6, arg9.treasury_address);
        let v6 = if (v5 > 0) {
            0x1::string::utf8(b"sui_sacrifice")
        } else {
            0x1::string::utf8(b"sui")
        };
        if (perform_upgrade_attempt(v0, arg3, v1, 0x1::string::utf8(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_mythic()), v3, 7500, 500, calculate_total_sacrifice_boost(arg1, arg2, &arg7), 10000000000, v6, v4, v5, arg8, arg9, arg11, arg12)) {
            sacrifice_tools_internal(arg9, arg1, arg2, arg10, arg7, arg12);
        };
    }

    public entry fun upgrade_staked_tool_urr_legendary_to_mythic_with_tato(arg0: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg5: 0x2::coin::Coin<0x6e82bb8cbed21683ac0109171135b4d75187fc74749593163f3dc426ef3b32b4::pawtato_coin_phoenix_feather::PAWTATO_COIN_PHOENIX_FEATHER>, arg6: 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>, arg7: vector<0x2::object::ID>, arg8: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg9: &mut ToolUpgrades, arg10: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg11: &0x2::random::Random, arg12: &mut 0x2::tx_context::TxContext) {
        validate_upgrade_preconditions(arg9, &arg7);
        let v0 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_staked_tool_for_upgrading_with_cap(0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg9.pawtato_package_cap), arg0, 0x2::tx_context::sender(arg12), arg3);
        let v1 = *0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier(v0);
        let v2 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_legendary();
        assert!(0x1::string::as_bytes(&v1) == &v2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tier());
        let v3 = 10000000000;
        let v4 = 10000000000;
        let v5 = 0x1::vector::length<0x2::object::ID>(&arg7);
        assert!(0x2::coin::value<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(&arg4) >= v3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        assert!(0x2::coin::value<0x6e82bb8cbed21683ac0109171135b4d75187fc74749593163f3dc426ef3b32b4::pawtato_coin_phoenix_feather::PAWTATO_COIN_PHOENIX_FEATHER>(&arg5) >= 1000000000, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        assert!(0x2::coin::value<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>(&arg6) >= calculate_tato_donation_amount(arg9, v4), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(arg8, arg4);
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x6e82bb8cbed21683ac0109171135b4d75187fc74749593163f3dc426ef3b32b4::pawtato_coin_phoenix_feather::PAWTATO_COIN_PHOENIX_FEATHER>(arg8, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>>(arg6, arg9.treasury_address);
        let v6 = if (v5 > 0) {
            0x1::string::utf8(b"tato_sacrifice")
        } else {
            0x1::string::utf8(b"tato")
        };
        if (perform_upgrade_attempt(v0, arg3, v1, 0x1::string::utf8(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_mythic()), v3, 7500, 500, calculate_total_sacrifice_boost(arg1, arg2, &arg7), 10000000000, v6, v4, v5, arg8, arg9, arg11, arg12)) {
            sacrifice_tools_internal(arg9, arg1, arg2, arg10, arg7, arg12);
        };
    }

    public entry fun upgrade_staked_tool_with_dft(arg0: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg5: 0x2::token::Token<0xd72ab42db7dfe82f07858fd4af0d821c939b037b51200554256ed0446b488db::pawtato_coin_divine_favor_token::PAWTATO_COIN_DIVINE_FAVOR_TOKEN>, arg6: vector<0x2::object::ID>, arg7: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg8: &mut ToolUpgrades, arg9: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg10: &0x2::random::Random, arg11: &mut 0x2::tx_context::TxContext) {
        validate_upgrade_preconditions(arg8, &arg6);
        let v0 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_staked_tool_for_upgrading_with_cap(0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg8.pawtato_package_cap), arg0, 0x2::tx_context::sender(arg11), arg3);
        let v1 = *0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier(v0);
        let v2 = 0x1::string::utf8(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_mythic());
        assert!(0x1::string::as_bytes(&v1) != 0x1::string::as_bytes(&v2), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tier());
        let (v3, v4, v5, v6, v7, _) = get_upgrade_params(&v1);
        let v9 = 0x1::vector::length<0x2::object::ID>(&arg6);
        assert!(0x2::coin::value<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(&arg4) >= v3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(arg7, arg4);
        assert!(0xd72ab42db7dfe82f07858fd4af0d821c939b037b51200554256ed0446b488db::pawtato_coin_divine_favor_token::get_token_value(&arg5) >= v5, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        consume_dft_donation(arg5, v5, arg7, arg8, arg11);
        let v10 = if (v9 > 0) {
            0x1::string::utf8(b"dft_sacrifice")
        } else {
            0x1::string::utf8(b"dft")
        };
        if (perform_upgrade_attempt(v0, arg3, v1, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_next_tier(&v1), v3, v4, v6, calculate_total_sacrifice_boost(arg1, arg2, &arg6), v7, v10, v5, v9, arg7, arg8, arg10, arg11)) {
            sacrifice_tools_internal(arg8, arg1, arg2, arg9, arg6, arg11);
        };
    }

    public entry fun upgrade_staked_tool_with_sui(arg0: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: vector<0x2::object::ID>, arg7: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg8: &mut ToolUpgrades, arg9: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg10: &0x2::random::Random, arg11: &mut 0x2::tx_context::TxContext) {
        validate_upgrade_preconditions(arg8, &arg6);
        let v0 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_staked_tool_for_upgrading_with_cap(0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg8.pawtato_package_cap), arg0, 0x2::tx_context::sender(arg11), arg3);
        let v1 = *0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier(v0);
        let v2 = 0x1::string::utf8(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_mythic());
        assert!(0x1::string::as_bytes(&v1) != 0x1::string::as_bytes(&v2), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tier());
        let (v3, v4, v5, v6, v7, _) = get_upgrade_params(&v1);
        let v9 = 0x1::vector::length<0x2::object::ID>(&arg6);
        assert!(0x2::coin::value<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(&arg4) >= v3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(arg7, arg4);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) >= v5, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg5, arg8.treasury_address);
        let v10 = if (v9 > 0) {
            0x1::string::utf8(b"sui_sacrifice")
        } else {
            0x1::string::utf8(b"sui")
        };
        if (perform_upgrade_attempt(v0, arg3, v1, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_next_tier(&v1), v3, v4, v6, calculate_total_sacrifice_boost(arg1, arg2, &arg6), v7, v10, v5, v9, arg7, arg8, arg10, arg11)) {
            sacrifice_tools_internal(arg8, arg1, arg2, arg9, arg6, arg11);
        };
    }

    public entry fun upgrade_staked_tool_with_tato(arg0: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg5: 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>, arg6: vector<0x2::object::ID>, arg7: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg8: &mut ToolUpgrades, arg9: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg10: &0x2::random::Random, arg11: &mut 0x2::tx_context::TxContext) {
        validate_upgrade_preconditions(arg8, &arg6);
        let v0 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_staked_tool_for_upgrading_with_cap(0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg8.pawtato_package_cap), arg0, 0x2::tx_context::sender(arg11), arg3);
        let v1 = *0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier(v0);
        let v2 = 0x1::string::utf8(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_mythic());
        assert!(0x1::string::as_bytes(&v1) != 0x1::string::as_bytes(&v2), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tier());
        let (v3, v4, v5, v6, v7, _) = get_upgrade_params(&v1);
        let v9 = 0x1::vector::length<0x2::object::ID>(&arg6);
        assert!(0x2::coin::value<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(&arg4) >= v3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(arg7, arg4);
        let v10 = calculate_tato_donation_amount(arg8, v5);
        assert!(0x2::coin::value<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>(&arg5) >= v10, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>>(arg5, arg8.treasury_address);
        let v11 = if (v9 > 0) {
            0x1::string::utf8(b"tato_sacrifice")
        } else {
            0x1::string::utf8(b"tato")
        };
        if (perform_upgrade_attempt(v0, arg3, v1, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_next_tier(&v1), v3, v4, v6, calculate_total_sacrifice_boost(arg1, arg2, &arg6), v7, v11, v10, v9, arg7, arg8, arg10, arg11)) {
            sacrifice_tools_internal(arg8, arg1, arg2, arg9, arg6, arg11);
        };
    }

    public entry fun upgrade_tool_basic(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg4: vector<0x2::object::ID>, arg5: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg6: &mut ToolUpgrades, arg7: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg8: &0x2::random::Random, arg9: &mut 0x2::tx_context::TxContext) {
        validate_upgrade_preconditions(arg6, &arg4);
        let (v0, v1, v2, v3, _, _, v6) = prepare_tool_upgrade(arg0, arg1, arg2);
        let v7 = 0x1::vector::length<0x2::object::ID>(&arg4);
        assert!(0x2::coin::value<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(&arg3) >= v2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(arg5, arg3);
        let v8 = 0x2::kiosk::borrow_mut<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(arg0, arg1, arg2);
        let v9 = if (v7 > 0) {
            0x1::string::utf8(b"none_sacrifice")
        } else {
            0x1::string::utf8(b"none")
        };
        if (perform_upgrade_attempt(v8, arg2, v0, v1, v2, v3, 0, calculate_total_sacrifice_boost(arg0, arg1, &arg4), v6, v9, 0, v7, arg5, arg6, arg8, arg9)) {
            sacrifice_tools_internal(arg6, arg0, arg1, arg7, arg4, arg9);
        };
    }

    public entry fun upgrade_tool_urr_epic_to_legendary(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg4: 0x2::coin::Coin<0x30021448e6d54825ced6d2b73f3b763a0da8a28c1c42fd6f0b864323ac60ab45::pawtato_coin_titanium_splinter::PAWTATO_COIN_TITANIUM_SPLINTER>, arg5: vector<0x2::object::ID>, arg6: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg7: &mut ToolUpgrades, arg8: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg9: &0x2::random::Random, arg10: &mut 0x2::tx_context::TxContext) {
        validate_upgrade_preconditions(arg7, &arg5);
        let v0 = *0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier(0x2::kiosk::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(arg0, arg1, arg2));
        let v1 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_epic();
        assert!(0x1::string::as_bytes(&v0) == &v1, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tier());
        let v2 = 5000000000;
        let v3 = 0x1::vector::length<0x2::object::ID>(&arg5);
        assert!(0x2::coin::value<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(&arg3) >= v2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        assert!(0x2::coin::value<0x30021448e6d54825ced6d2b73f3b763a0da8a28c1c42fd6f0b864323ac60ab45::pawtato_coin_titanium_splinter::PAWTATO_COIN_TITANIUM_SPLINTER>(&arg4) >= 1000000000, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(arg6, arg3);
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x30021448e6d54825ced6d2b73f3b763a0da8a28c1c42fd6f0b864323ac60ab45::pawtato_coin_titanium_splinter::PAWTATO_COIN_TITANIUM_SPLINTER>(arg6, arg4);
        let v4 = 0x2::kiosk::borrow_mut<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(arg0, arg1, arg2);
        let v5 = if (v3 > 0) {
            0x1::string::utf8(b"none_sacrifice")
        } else {
            0x1::string::utf8(b"none")
        };
        if (perform_upgrade_attempt(v4, arg2, v0, 0x1::string::utf8(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_legendary()), v2, 7500, 0, calculate_total_sacrifice_boost(arg0, arg1, &arg5), 5000000000, v5, 0, v3, arg6, arg7, arg9, arg10)) {
            sacrifice_tools_internal(arg7, arg0, arg1, arg8, arg5, arg10);
        };
    }

    public entry fun upgrade_tool_urr_epic_to_legendary_with_dft(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg4: 0x2::coin::Coin<0x30021448e6d54825ced6d2b73f3b763a0da8a28c1c42fd6f0b864323ac60ab45::pawtato_coin_titanium_splinter::PAWTATO_COIN_TITANIUM_SPLINTER>, arg5: 0x2::token::Token<0xd72ab42db7dfe82f07858fd4af0d821c939b037b51200554256ed0446b488db::pawtato_coin_divine_favor_token::PAWTATO_COIN_DIVINE_FAVOR_TOKEN>, arg6: vector<0x2::object::ID>, arg7: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg8: &mut ToolUpgrades, arg9: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg10: &0x2::random::Random, arg11: &mut 0x2::tx_context::TxContext) {
        validate_upgrade_preconditions(arg8, &arg6);
        let v0 = *0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier(0x2::kiosk::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(arg0, arg1, arg2));
        let v1 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_epic();
        assert!(0x1::string::as_bytes(&v0) == &v1, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tier());
        let v2 = 5000000000;
        let v3 = 5000000000;
        let v4 = 0x1::vector::length<0x2::object::ID>(&arg6);
        assert!(0x2::coin::value<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(&arg3) >= v2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        assert!(0x2::coin::value<0x30021448e6d54825ced6d2b73f3b763a0da8a28c1c42fd6f0b864323ac60ab45::pawtato_coin_titanium_splinter::PAWTATO_COIN_TITANIUM_SPLINTER>(&arg4) >= 1000000000, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        assert!(0xd72ab42db7dfe82f07858fd4af0d821c939b037b51200554256ed0446b488db::pawtato_coin_divine_favor_token::get_token_value(&arg5) >= v3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(arg7, arg3);
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x30021448e6d54825ced6d2b73f3b763a0da8a28c1c42fd6f0b864323ac60ab45::pawtato_coin_titanium_splinter::PAWTATO_COIN_TITANIUM_SPLINTER>(arg7, arg4);
        consume_dft_donation(arg5, v3, arg7, arg8, arg11);
        let v5 = 0x2::kiosk::borrow_mut<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(arg0, arg1, arg2);
        let v6 = if (v4 > 0) {
            0x1::string::utf8(b"dft_sacrifice")
        } else {
            0x1::string::utf8(b"dft")
        };
        if (perform_upgrade_attempt(v5, arg2, v0, 0x1::string::utf8(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_legendary()), v2, 7500, 1000, calculate_total_sacrifice_boost(arg0, arg1, &arg6), 5000000000, v6, v3, v4, arg7, arg8, arg10, arg11)) {
            sacrifice_tools_internal(arg8, arg0, arg1, arg9, arg6, arg11);
        };
    }

    public entry fun upgrade_tool_urr_epic_to_legendary_with_sui(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg4: 0x2::coin::Coin<0x30021448e6d54825ced6d2b73f3b763a0da8a28c1c42fd6f0b864323ac60ab45::pawtato_coin_titanium_splinter::PAWTATO_COIN_TITANIUM_SPLINTER>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: vector<0x2::object::ID>, arg7: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg8: &mut ToolUpgrades, arg9: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg10: &0x2::random::Random, arg11: &mut 0x2::tx_context::TxContext) {
        validate_upgrade_preconditions(arg8, &arg6);
        let v0 = *0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier(0x2::kiosk::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(arg0, arg1, arg2));
        let v1 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_epic();
        assert!(0x1::string::as_bytes(&v0) == &v1, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tier());
        let v2 = 5000000000;
        let v3 = 5000000000;
        let v4 = 0x1::vector::length<0x2::object::ID>(&arg6);
        assert!(0x2::coin::value<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(&arg3) >= v2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        assert!(0x2::coin::value<0x30021448e6d54825ced6d2b73f3b763a0da8a28c1c42fd6f0b864323ac60ab45::pawtato_coin_titanium_splinter::PAWTATO_COIN_TITANIUM_SPLINTER>(&arg4) >= 1000000000, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) >= v3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(arg7, arg3);
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x30021448e6d54825ced6d2b73f3b763a0da8a28c1c42fd6f0b864323ac60ab45::pawtato_coin_titanium_splinter::PAWTATO_COIN_TITANIUM_SPLINTER>(arg7, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg5, arg8.treasury_address);
        let v5 = 0x2::kiosk::borrow_mut<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(arg0, arg1, arg2);
        let v6 = if (v4 > 0) {
            0x1::string::utf8(b"sui_sacrifice")
        } else {
            0x1::string::utf8(b"sui")
        };
        if (perform_upgrade_attempt(v5, arg2, v0, 0x1::string::utf8(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_legendary()), v2, 7500, 1000, calculate_total_sacrifice_boost(arg0, arg1, &arg6), 5000000000, v6, v3, v4, arg7, arg8, arg10, arg11)) {
            sacrifice_tools_internal(arg8, arg0, arg1, arg9, arg6, arg11);
        };
    }

    public entry fun upgrade_tool_urr_epic_to_legendary_with_tato(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg4: 0x2::coin::Coin<0x30021448e6d54825ced6d2b73f3b763a0da8a28c1c42fd6f0b864323ac60ab45::pawtato_coin_titanium_splinter::PAWTATO_COIN_TITANIUM_SPLINTER>, arg5: 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>, arg6: vector<0x2::object::ID>, arg7: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg8: &mut ToolUpgrades, arg9: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg10: &0x2::random::Random, arg11: &mut 0x2::tx_context::TxContext) {
        validate_upgrade_preconditions(arg8, &arg6);
        let v0 = *0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier(0x2::kiosk::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(arg0, arg1, arg2));
        let v1 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_epic();
        assert!(0x1::string::as_bytes(&v0) == &v1, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tier());
        let v2 = 5000000000;
        let v3 = 5000000000;
        let v4 = 0x1::vector::length<0x2::object::ID>(&arg6);
        assert!(0x2::coin::value<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(&arg3) >= v2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        assert!(0x2::coin::value<0x30021448e6d54825ced6d2b73f3b763a0da8a28c1c42fd6f0b864323ac60ab45::pawtato_coin_titanium_splinter::PAWTATO_COIN_TITANIUM_SPLINTER>(&arg4) >= 1000000000, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        assert!(0x2::coin::value<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>(&arg5) >= calculate_tato_donation_amount(arg8, v3), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(arg7, arg3);
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x30021448e6d54825ced6d2b73f3b763a0da8a28c1c42fd6f0b864323ac60ab45::pawtato_coin_titanium_splinter::PAWTATO_COIN_TITANIUM_SPLINTER>(arg7, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>>(arg5, arg8.treasury_address);
        let v5 = 0x2::kiosk::borrow_mut<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(arg0, arg1, arg2);
        let v6 = if (v4 > 0) {
            0x1::string::utf8(b"tato_sacrifice")
        } else {
            0x1::string::utf8(b"tato")
        };
        if (perform_upgrade_attempt(v5, arg2, v0, 0x1::string::utf8(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_legendary()), v2, 7500, 1000, calculate_total_sacrifice_boost(arg0, arg1, &arg6), 5000000000, v6, v3, v4, arg7, arg8, arg10, arg11)) {
            sacrifice_tools_internal(arg8, arg0, arg1, arg9, arg6, arg11);
        };
    }

    public entry fun upgrade_tool_urr_legendary_to_mythic(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg4: 0x2::coin::Coin<0x6e82bb8cbed21683ac0109171135b4d75187fc74749593163f3dc426ef3b32b4::pawtato_coin_phoenix_feather::PAWTATO_COIN_PHOENIX_FEATHER>, arg5: vector<0x2::object::ID>, arg6: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg7: &mut ToolUpgrades, arg8: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg9: &0x2::random::Random, arg10: &mut 0x2::tx_context::TxContext) {
        validate_upgrade_preconditions(arg7, &arg5);
        let v0 = *0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier(0x2::kiosk::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(arg0, arg1, arg2));
        let v1 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_legendary();
        assert!(0x1::string::as_bytes(&v0) == &v1, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tier());
        let v2 = 10000000000;
        let v3 = 0x1::vector::length<0x2::object::ID>(&arg5);
        assert!(0x2::coin::value<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(&arg3) >= v2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        assert!(0x2::coin::value<0x6e82bb8cbed21683ac0109171135b4d75187fc74749593163f3dc426ef3b32b4::pawtato_coin_phoenix_feather::PAWTATO_COIN_PHOENIX_FEATHER>(&arg4) >= 1000000000, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(arg6, arg3);
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x6e82bb8cbed21683ac0109171135b4d75187fc74749593163f3dc426ef3b32b4::pawtato_coin_phoenix_feather::PAWTATO_COIN_PHOENIX_FEATHER>(arg6, arg4);
        let v4 = 0x2::kiosk::borrow_mut<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(arg0, arg1, arg2);
        let v5 = if (v3 > 0) {
            0x1::string::utf8(b"none_sacrifice")
        } else {
            0x1::string::utf8(b"none")
        };
        if (perform_upgrade_attempt(v4, arg2, v0, 0x1::string::utf8(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_mythic()), v2, 7500, 0, calculate_total_sacrifice_boost(arg0, arg1, &arg5), 10000000000, v5, 0, v3, arg6, arg7, arg9, arg10)) {
            sacrifice_tools_internal(arg7, arg0, arg1, arg8, arg5, arg10);
        };
    }

    public entry fun upgrade_tool_urr_legendary_to_mythic_with_dft(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg4: 0x2::coin::Coin<0x6e82bb8cbed21683ac0109171135b4d75187fc74749593163f3dc426ef3b32b4::pawtato_coin_phoenix_feather::PAWTATO_COIN_PHOENIX_FEATHER>, arg5: 0x2::token::Token<0xd72ab42db7dfe82f07858fd4af0d821c939b037b51200554256ed0446b488db::pawtato_coin_divine_favor_token::PAWTATO_COIN_DIVINE_FAVOR_TOKEN>, arg6: vector<0x2::object::ID>, arg7: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg8: &mut ToolUpgrades, arg9: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg10: &0x2::random::Random, arg11: &mut 0x2::tx_context::TxContext) {
        validate_upgrade_preconditions(arg8, &arg6);
        let v0 = *0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier(0x2::kiosk::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(arg0, arg1, arg2));
        let v1 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_legendary();
        assert!(0x1::string::as_bytes(&v0) == &v1, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tier());
        let v2 = 10000000000;
        let v3 = 10000000000;
        let v4 = 0x1::vector::length<0x2::object::ID>(&arg6);
        assert!(0x2::coin::value<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(&arg3) >= v2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        assert!(0x2::coin::value<0x6e82bb8cbed21683ac0109171135b4d75187fc74749593163f3dc426ef3b32b4::pawtato_coin_phoenix_feather::PAWTATO_COIN_PHOENIX_FEATHER>(&arg4) >= 1000000000, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        assert!(0xd72ab42db7dfe82f07858fd4af0d821c939b037b51200554256ed0446b488db::pawtato_coin_divine_favor_token::get_token_value(&arg5) >= v3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(arg7, arg3);
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x6e82bb8cbed21683ac0109171135b4d75187fc74749593163f3dc426ef3b32b4::pawtato_coin_phoenix_feather::PAWTATO_COIN_PHOENIX_FEATHER>(arg7, arg4);
        consume_dft_donation(arg5, v3, arg7, arg8, arg11);
        let v5 = 0x2::kiosk::borrow_mut<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(arg0, arg1, arg2);
        let v6 = if (v4 > 0) {
            0x1::string::utf8(b"dft_sacrifice")
        } else {
            0x1::string::utf8(b"dft")
        };
        if (perform_upgrade_attempt(v5, arg2, v0, 0x1::string::utf8(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_mythic()), v2, 7500, 500, calculate_total_sacrifice_boost(arg0, arg1, &arg6), 10000000000, v6, v3, v4, arg7, arg8, arg10, arg11)) {
            sacrifice_tools_internal(arg8, arg0, arg1, arg9, arg6, arg11);
        };
    }

    public entry fun upgrade_tool_urr_legendary_to_mythic_with_sui(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg4: 0x2::coin::Coin<0x6e82bb8cbed21683ac0109171135b4d75187fc74749593163f3dc426ef3b32b4::pawtato_coin_phoenix_feather::PAWTATO_COIN_PHOENIX_FEATHER>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: vector<0x2::object::ID>, arg7: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg8: &mut ToolUpgrades, arg9: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg10: &0x2::random::Random, arg11: &mut 0x2::tx_context::TxContext) {
        validate_upgrade_preconditions(arg8, &arg6);
        let v0 = *0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier(0x2::kiosk::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(arg0, arg1, arg2));
        let v1 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_legendary();
        assert!(0x1::string::as_bytes(&v0) == &v1, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tier());
        let v2 = 10000000000;
        let v3 = 10000000000;
        let v4 = 0x1::vector::length<0x2::object::ID>(&arg6);
        assert!(0x2::coin::value<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(&arg3) >= v2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        assert!(0x2::coin::value<0x6e82bb8cbed21683ac0109171135b4d75187fc74749593163f3dc426ef3b32b4::pawtato_coin_phoenix_feather::PAWTATO_COIN_PHOENIX_FEATHER>(&arg4) >= 1000000000, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) >= v3, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(arg7, arg3);
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x6e82bb8cbed21683ac0109171135b4d75187fc74749593163f3dc426ef3b32b4::pawtato_coin_phoenix_feather::PAWTATO_COIN_PHOENIX_FEATHER>(arg7, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg5, arg8.treasury_address);
        let v5 = 0x2::kiosk::borrow_mut<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(arg0, arg1, arg2);
        let v6 = if (v4 > 0) {
            0x1::string::utf8(b"sui_sacrifice")
        } else {
            0x1::string::utf8(b"sui")
        };
        if (perform_upgrade_attempt(v5, arg2, v0, 0x1::string::utf8(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_mythic()), v2, 7500, 500, calculate_total_sacrifice_boost(arg0, arg1, &arg6), 10000000000, v6, v3, v4, arg7, arg8, arg10, arg11)) {
            sacrifice_tools_internal(arg8, arg0, arg1, arg9, arg6, arg11);
        };
    }

    public entry fun upgrade_tool_urr_legendary_to_mythic_with_tato(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg4: 0x2::coin::Coin<0x6e82bb8cbed21683ac0109171135b4d75187fc74749593163f3dc426ef3b32b4::pawtato_coin_phoenix_feather::PAWTATO_COIN_PHOENIX_FEATHER>, arg5: 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>, arg6: vector<0x2::object::ID>, arg7: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg8: &mut ToolUpgrades, arg9: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg10: &0x2::random::Random, arg11: &mut 0x2::tx_context::TxContext) {
        validate_upgrade_preconditions(arg8, &arg6);
        let v0 = *0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier(0x2::kiosk::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(arg0, arg1, arg2));
        let v1 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_legendary();
        assert!(0x1::string::as_bytes(&v0) == &v1, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tier());
        let v2 = 10000000000;
        let v3 = 10000000000;
        let v4 = 0x1::vector::length<0x2::object::ID>(&arg6);
        assert!(0x2::coin::value<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(&arg3) >= v2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        assert!(0x2::coin::value<0x6e82bb8cbed21683ac0109171135b4d75187fc74749593163f3dc426ef3b32b4::pawtato_coin_phoenix_feather::PAWTATO_COIN_PHOENIX_FEATHER>(&arg4) >= 1000000000, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        assert!(0x2::coin::value<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>(&arg5) >= calculate_tato_donation_amount(arg8, v3), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(arg7, arg3);
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x6e82bb8cbed21683ac0109171135b4d75187fc74749593163f3dc426ef3b32b4::pawtato_coin_phoenix_feather::PAWTATO_COIN_PHOENIX_FEATHER>(arg7, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>>(arg5, arg8.treasury_address);
        let v5 = 0x2::kiosk::borrow_mut<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(arg0, arg1, arg2);
        let v6 = if (v4 > 0) {
            0x1::string::utf8(b"tato_sacrifice")
        } else {
            0x1::string::utf8(b"tato")
        };
        if (perform_upgrade_attempt(v5, arg2, v0, 0x1::string::utf8(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_mythic()), v2, 7500, 500, calculate_total_sacrifice_boost(arg0, arg1, &arg6), 10000000000, v6, v3, v4, arg7, arg8, arg10, arg11)) {
            sacrifice_tools_internal(arg8, arg0, arg1, arg9, arg6, arg11);
        };
    }

    public entry fun upgrade_tool_with_dft(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg4: 0x2::token::Token<0xd72ab42db7dfe82f07858fd4af0d821c939b037b51200554256ed0446b488db::pawtato_coin_divine_favor_token::PAWTATO_COIN_DIVINE_FAVOR_TOKEN>, arg5: vector<0x2::object::ID>, arg6: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg7: &mut ToolUpgrades, arg8: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg9: &0x2::random::Random, arg10: &mut 0x2::tx_context::TxContext) {
        validate_upgrade_preconditions(arg7, &arg5);
        let (v0, v1, v2, v3, v4, v5, v6) = prepare_tool_upgrade(arg0, arg1, arg2);
        let v7 = 0x1::vector::length<0x2::object::ID>(&arg5);
        assert!(0x2::coin::value<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(&arg3) >= v2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(arg6, arg3);
        assert!(0xd72ab42db7dfe82f07858fd4af0d821c939b037b51200554256ed0446b488db::pawtato_coin_divine_favor_token::get_token_value(&arg4) >= v4, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        consume_dft_donation(arg4, v4, arg6, arg7, arg10);
        let v8 = 0x2::kiosk::borrow_mut<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(arg0, arg1, arg2);
        let v9 = if (v7 > 0) {
            0x1::string::utf8(b"dft_sacrifice")
        } else {
            0x1::string::utf8(b"dft")
        };
        if (perform_upgrade_attempt(v8, arg2, v0, v1, v2, v3, v5, calculate_total_sacrifice_boost(arg0, arg1, &arg5), v6, v9, v4, v7, arg6, arg7, arg9, arg10)) {
            sacrifice_tools_internal(arg7, arg0, arg1, arg8, arg5, arg10);
        };
    }

    public entry fun upgrade_tool_with_sui(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: vector<0x2::object::ID>, arg6: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg7: &mut ToolUpgrades, arg8: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg9: &0x2::random::Random, arg10: &mut 0x2::tx_context::TxContext) {
        validate_upgrade_preconditions(arg7, &arg5);
        let (v0, v1, v2, v3, v4, v5, v6) = prepare_tool_upgrade(arg0, arg1, arg2);
        let v7 = 0x1::vector::length<0x2::object::ID>(&arg5);
        assert!(0x2::coin::value<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(&arg3) >= v2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(arg6, arg3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= v4, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, arg7.treasury_address);
        let v8 = 0x2::kiosk::borrow_mut<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(arg0, arg1, arg2);
        let v9 = if (v7 > 0) {
            0x1::string::utf8(b"sui_sacrifice")
        } else {
            0x1::string::utf8(b"sui")
        };
        if (perform_upgrade_attempt(v8, arg2, v0, v1, v2, v3, v5, calculate_total_sacrifice_boost(arg0, arg1, &arg5), v6, v9, v4, v7, arg6, arg7, arg9, arg10)) {
            sacrifice_tools_internal(arg7, arg0, arg1, arg8, arg5, arg10);
        };
    }

    public entry fun upgrade_tool_with_tato(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg4: 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>, arg5: vector<0x2::object::ID>, arg6: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg7: &mut ToolUpgrades, arg8: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg9: &0x2::random::Random, arg10: &mut 0x2::tx_context::TxContext) {
        validate_upgrade_preconditions(arg7, &arg5);
        let (v0, v1, v2, v3, v4, v5, v6) = prepare_tool_upgrade(arg0, arg1, arg2);
        let v7 = 0x1::vector::length<0x2::object::ID>(&arg5);
        assert!(0x2::coin::value<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(&arg3) >= v2, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(arg6, arg3);
        let v8 = calculate_tato_donation_amount(arg7, v4);
        assert!(0x2::coin::value<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>(&arg4) >= v8, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_insufficient_payment());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>>(arg4, arg7.treasury_address);
        let v9 = 0x2::kiosk::borrow_mut<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(arg0, arg1, arg2);
        let v10 = if (v7 > 0) {
            0x1::string::utf8(b"tato_sacrifice")
        } else {
            0x1::string::utf8(b"tato")
        };
        if (perform_upgrade_attempt(v9, arg2, v0, v1, v2, v3, v5, calculate_total_sacrifice_boost(arg0, arg1, &arg5), v6, v10, v8, v7, arg6, arg7, arg9, arg10)) {
            sacrifice_tools_internal(arg7, arg0, arg1, arg8, arg5, arg10);
        };
    }

    public entry fun upgrade_version(arg0: &ToolUpgradeAdminCap, arg1: &mut ToolUpgrades, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version < 1, 13906835707646705663);
        arg1.version = 1;
    }

    fun validate_upgrade_preconditions(arg0: &ToolUpgrades, arg1: &vector<0x2::object::ID>) {
        check_version(arg0);
        check_not_paused(arg0);
        assert!(0x1::vector::length<0x2::object::ID>(arg1) <= 6, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_item_invalid_tier());
    }

    // decompiled from Move bytecode v6
}

