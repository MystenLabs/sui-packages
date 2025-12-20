module 0x67b49498b9e3d942c9ba3c5442fc85aa2011abcdc1a2edf73d83cb4af46f46e0::pawtato_repairs {
    struct RepairQueue has key {
        id: 0x2::object::UID,
        treasury_address: address,
        users: 0x2::table::Table<address, vector<RepairDetails>>,
        repairers: vector<address>,
        kiosk: 0x2::kiosk::Kiosk,
        kiosk_owner_cap: 0x2::kiosk::KioskOwnerCap,
        version: u64,
        paused: bool,
        pawtato_package_cap: 0x1::option::Option<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>,
        total_repairs_started: u64,
        total_repairs_completed: u64,
        total_crystal_spent: u64,
        total_instant_fees_collected: u64,
    }

    struct RepairDetails has drop, store {
        tool_id: 0x2::object::ID,
        item_type: u8,
        started: u64,
        duration: u64,
    }

    struct ToolRepairStarted has copy, drop {
        user: address,
        tool_id: 0x2::object::ID,
        item_type: u8,
        duration: u64,
        crystal_cost: u64,
    }

    struct ToolRepairCompleted has copy, drop {
        user: address,
        tool_id: 0x2::object::ID,
        item_type: u8,
    }

    struct ToolRepairInstant has copy, drop {
        user: address,
        tool_id: 0x2::object::ID,
        item_type: u8,
        sui_fee_paid: u64,
        crystal_spent: u64,
    }

    public entry fun add_pawtato_package_cap(arg0: &0x67b49498b9e3d942c9ba3c5442fc85aa2011abcdc1a2edf73d83cb4af46f46e0::pawtato_tool_upgrades::ToolUpgradeAdminCap, arg1: &mut RepairQueue, arg2: 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap) {
        0x1::option::fill<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&mut arg1.pawtato_package_cap, arg2);
    }

    fun calculate_instant_fee_sui(arg0: u64) : u64 {
        let v0 = arg0 / 3600000;
        let v1 = v0;
        if (arg0 % 3600000 > 0) {
            v1 = v0 + 1;
        };
        v1 * 50000000
    }

    fun calculate_instant_fee_tato(arg0: &RepairQueue, arg1: u64) : u64 {
        let v0 = arg1 / 3600000;
        let v1 = v0;
        if (arg1 % 3600000 > 0) {
            v1 = v0 + 1;
        };
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"tato_instant_fee_per_hour")) {
            v1 * *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"tato_instant_fee_per_hour")
        } else {
            0
        }
    }

    fun check_not_mythic(arg0: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL) {
        let v0 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_mythic();
        assert!(0x1::string::as_bytes(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier(arg0)) != &v0, 206);
    }

    fun check_not_paused(arg0: &RepairQueue) {
        assert!(!arg0.paused, 202);
    }

    fun check_version(arg0: &RepairQueue) {
        assert!(arg0.version == 1, 201);
    }

    public entry fun complete_repair(arg0: &mut RepairQueue, arg1: &0x2::clock::Clock, arg2: u64, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x2::table::contains<address, vector<RepairDetails>>(&arg0.users, v0), 203);
        let v1 = 0x2::table::borrow<address, vector<RepairDetails>>(&arg0.users, v0);
        assert!(arg2 < 0x1::vector::length<RepairDetails>(v1), 203);
        let v2 = 0x1::vector::borrow<RepairDetails>(v1, arg2);
        assert!(0x2::clock::timestamp_ms(arg1) >= v2.started + v2.duration, 204);
        internal_complete_repair(arg0, arg2, arg3, arg4, arg5, arg6);
    }

    fun get_crafting_costs_for_item_type(arg0: u8, arg1: u64) : vector<u64> {
        let v0 = 0x67b49498b9e3d942c9ba3c5442fc85aa2011abcdc1a2edf73d83cb4af46f46e0::pawtato_tool_crafting_v2::get_tool_resource_costs(arg0);
        let v1 = vector[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x67b49498b9e3d942c9ba3c5442fc85aa2011abcdc1a2edf73d83cb4af46f46e0::pawtato_tool_crafting_v2::ToolResourceCost>(&v0)) {
            let v3 = 0x1::vector::borrow<0x67b49498b9e3d942c9ba3c5442fc85aa2011abcdc1a2edf73d83cb4af46f46e0::pawtato_tool_crafting_v2::ToolResourceCost>(&v0, v2);
            let v4 = 0x67b49498b9e3d942c9ba3c5442fc85aa2011abcdc1a2edf73d83cb4af46f46e0::pawtato_tool_crafting_v2::get_resource_type(v3);
            if (v4 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_wood()) {
                *0x1::vector::borrow_mut<u64>(&mut v1, 0) = 0x67b49498b9e3d942c9ba3c5442fc85aa2011abcdc1a2edf73d83cb4af46f46e0::pawtato_tool_crafting_v2::get_amount(v3) * arg1 / 10000;
            } else if (v4 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_stone()) {
                *0x1::vector::borrow_mut<u64>(&mut v1, 1) = 0x67b49498b9e3d942c9ba3c5442fc85aa2011abcdc1a2edf73d83cb4af46f46e0::pawtato_tool_crafting_v2::get_amount(v3) * arg1 / 10000;
            } else if (v4 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_water()) {
                *0x1::vector::borrow_mut<u64>(&mut v1, 2) = 0x67b49498b9e3d942c9ba3c5442fc85aa2011abcdc1a2edf73d83cb4af46f46e0::pawtato_tool_crafting_v2::get_amount(v3) * arg1 / 10000;
            } else if (v4 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_coal()) {
                *0x1::vector::borrow_mut<u64>(&mut v1, 3) = 0x67b49498b9e3d942c9ba3c5442fc85aa2011abcdc1a2edf73d83cb4af46f46e0::pawtato_tool_crafting_v2::get_amount(v3) * arg1 / 10000;
            } else if (v4 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_iron()) {
                *0x1::vector::borrow_mut<u64>(&mut v1, 4) = 0x67b49498b9e3d942c9ba3c5442fc85aa2011abcdc1a2edf73d83cb4af46f46e0::pawtato_tool_crafting_v2::get_amount(v3) * arg1 / 10000;
            } else if (v4 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_gold()) {
                *0x1::vector::borrow_mut<u64>(&mut v1, 5) = 0x67b49498b9e3d942c9ba3c5442fc85aa2011abcdc1a2edf73d83cb4af46f46e0::pawtato_tool_crafting_v2::get_amount(v3) * arg1 / 10000;
            } else if (v4 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_crystal()) {
                *0x1::vector::borrow_mut<u64>(&mut v1, 6) = 0x67b49498b9e3d942c9ba3c5442fc85aa2011abcdc1a2edf73d83cb4af46f46e0::pawtato_tool_crafting_v2::get_amount(v3) * arg1 / 10000;
            } else if (v4 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_wooden_plank()) {
                *0x1::vector::borrow_mut<u64>(&mut v1, 7) = 0x67b49498b9e3d942c9ba3c5442fc85aa2011abcdc1a2edf73d83cb4af46f46e0::pawtato_tool_crafting_v2::get_amount(v3) * arg1 / 10000;
            } else if (v4 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_stone_block()) {
                *0x1::vector::borrow_mut<u64>(&mut v1, 8) = 0x67b49498b9e3d942c9ba3c5442fc85aa2011abcdc1a2edf73d83cb4af46f46e0::pawtato_tool_crafting_v2::get_amount(v3) * arg1 / 10000;
            } else if (v4 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_iron_bar()) {
                *0x1::vector::borrow_mut<u64>(&mut v1, 9) = 0x67b49498b9e3d942c9ba3c5442fc85aa2011abcdc1a2edf73d83cb4af46f46e0::pawtato_tool_crafting_v2::get_amount(v3) * arg1 / 10000;
            } else if (v4 == 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::resource_type_gold_bar()) {
                *0x1::vector::borrow_mut<u64>(&mut v1, 10) = 0x67b49498b9e3d942c9ba3c5442fc85aa2011abcdc1a2edf73d83cb4af46f46e0::pawtato_tool_crafting_v2::get_amount(v3) * arg1 / 10000;
            };
            v2 = v2 + 1;
        };
        v1
    }

    fun get_repair_costs(arg0: &0x1::string::String, arg1: u8) : (u64, u64, vector<u64>) {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_common();
        let v2 = if (v0 == &v1) {
            3600000
        } else {
            let v3 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_uncommon();
            if (v0 == &v3) {
                10800000
            } else {
                let v4 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_rare();
                if (v0 == &v4) {
                    21600000
                } else {
                    let v5 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_epic();
                    if (v0 == &v5) {
                        43200000
                    } else {
                        let v6 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_legendary();
                        assert!(v0 == &v6, 206);
                        86400000
                    }
                }
            }
        };
        let v7 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_common();
        let v8 = if (v0 == &v7) {
            0
        } else {
            let v9 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_uncommon();
            if (v0 == &v9) {
                0
            } else {
                let v10 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_rare();
                if (v0 == &v10) {
                    0
                } else {
                    let v11 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_epic();
                    if (v0 == &v11) {
                        1000000000
                    } else {
                        let v12 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_legendary();
                        if (v0 == &v12) {
                            3000000000
                        } else {
                            0
                        }
                    }
                }
            }
        };
        let v13 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_common();
        let v14 = if (v0 == &v13) {
            2000
        } else {
            let v15 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_uncommon();
            if (v0 == &v15) {
                3000
            } else {
                let v16 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_rare();
                if (v0 == &v16) {
                    5000
                } else {
                    let v17 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_epic();
                    if (v0 == &v17) {
                        8000
                    } else {
                        let v18 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier_legendary();
                        if (v0 == &v18) {
                            10000
                        } else {
                            0
                        }
                    }
                }
            }
        };
        (v2, v8, get_crafting_costs_for_item_type(arg1, v14))
    }

    public fun get_user_repairs(arg0: &RepairQueue, arg1: address) : &vector<RepairDetails> {
        0x2::table::borrow<address, vector<RepairDetails>>(&arg0.users, arg1)
    }

    public entry fun initialize(arg0: &0x67b49498b9e3d942c9ba3c5442fc85aa2011abcdc1a2edf73d83cb4af46f46e0::pawtato_tool_upgrades::ToolUpgradeAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg1);
        let v2 = RepairQueue{
            id                           : 0x2::object::new(arg1),
            treasury_address             : @0x25abcf44fdf2a13e25f8f3d86e168b6869c7b99ec350d0e44ed125df54e5d8fe,
            users                        : 0x2::table::new<address, vector<RepairDetails>>(arg1),
            repairers                    : 0x1::vector::empty<address>(),
            kiosk                        : v0,
            kiosk_owner_cap              : v1,
            version                      : 1,
            paused                       : false,
            pawtato_package_cap          : 0x1::option::none<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(),
            total_repairs_started        : 0,
            total_repairs_completed      : 0,
            total_crystal_spent          : 0,
            total_instant_fees_collected : 0,
        };
        0x2::transfer::share_object<RepairQueue>(v2);
    }

    public entry fun instant_complete_repair(arg0: &mut RepairQueue, arg1: &0x2::clock::Clock, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        assert!(0x2::table::contains<address, vector<RepairDetails>>(&arg0.users, v0), 203);
        let v2 = 0x2::table::borrow<address, vector<RepairDetails>>(&arg0.users, v0);
        assert!(arg2 < 0x1::vector::length<RepairDetails>(v2), 203);
        let v3 = 0x1::vector::borrow<RepairDetails>(v2, arg2);
        let v4 = v3.started + v3.duration;
        if (v1 < v4) {
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= calculate_instant_fee_sui(v4 - v1), 200);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg0.treasury_address);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        };
        internal_complete_repair(arg0, arg2, arg4, arg5, arg6, arg7);
    }

    public entry fun instant_complete_repair_tato(arg0: &mut RepairQueue, arg1: &0x2::clock::Clock, arg2: u64, arg3: 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        assert!(0x2::table::contains<address, vector<RepairDetails>>(&arg0.users, v0), 203);
        let v2 = 0x2::table::borrow<address, vector<RepairDetails>>(&arg0.users, v0);
        assert!(arg2 < 0x1::vector::length<RepairDetails>(v2), 203);
        let v3 = 0x1::vector::borrow<RepairDetails>(v2, arg2);
        let v4 = v3.started + v3.duration;
        if (v1 < v4) {
            assert!(0x2::coin::value<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>(&arg3) >= calculate_instant_fee_tato(arg0, v4 - v1), 200);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>>(arg3, arg0.treasury_address);
        } else {
            0x2::coin::destroy_zero<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>(arg3);
        };
        internal_complete_repair(arg0, arg2, arg4, arg5, arg6, arg7);
    }

    public entry fun instant_repair(arg0: &mut RepairQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: 0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>, arg7: 0x2::coin::Coin<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>, arg8: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg9: 0x2::coin::Coin<0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal::PAWTATO_COIN_COAL>, arg10: 0x2::coin::Coin<0x422d4e84d7eaee54e75c140e2f7ae9503311f516342ef2c6020c8f8be8629024::pawtato_coin_iron::PAWTATO_COIN_IRON>, arg11: 0x2::coin::Coin<0xf9d3566bb782d792a93a16a9db69211808048dee1914b64cb7f96a3582258671::pawtato_coin_gold::PAWTATO_COIN_GOLD>, arg12: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg13: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg14: 0x2::coin::Coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>, arg15: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg16: 0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>, arg17: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_not_paused(arg0);
        let v0 = 0x2::kiosk::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(arg2, arg3, arg4);
        check_not_mythic(v0);
        let v1 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_item_type(v0);
        let (v2, v3, v4) = get_repair_costs(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier(v0), v1);
        let v5 = v4;
        let v6 = calculate_instant_fee_sui(v2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) >= v6, 200);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg5, arg0.treasury_address);
        validate_and_consume_payments(arg1, v3, &v5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17);
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::repair_tool_full_with_cap(0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg0.pawtato_package_cap), 0x2::kiosk::borrow_mut<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(arg2, arg3, arg4));
        arg0.total_crystal_spent = arg0.total_crystal_spent + v3;
        let v7 = ToolRepairInstant{
            user          : 0x2::tx_context::sender(arg17),
            tool_id       : arg4,
            item_type     : v1,
            sui_fee_paid  : v6,
            crystal_spent : v3,
        };
        0x2::event::emit<ToolRepairInstant>(v7);
    }

    public entry fun instant_repair_tato(arg0: &mut RepairQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>, arg6: 0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>, arg7: 0x2::coin::Coin<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>, arg8: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg9: 0x2::coin::Coin<0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal::PAWTATO_COIN_COAL>, arg10: 0x2::coin::Coin<0x422d4e84d7eaee54e75c140e2f7ae9503311f516342ef2c6020c8f8be8629024::pawtato_coin_iron::PAWTATO_COIN_IRON>, arg11: 0x2::coin::Coin<0xf9d3566bb782d792a93a16a9db69211808048dee1914b64cb7f96a3582258671::pawtato_coin_gold::PAWTATO_COIN_GOLD>, arg12: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg13: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg14: 0x2::coin::Coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>, arg15: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg16: 0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>, arg17: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_not_paused(arg0);
        let v0 = 0x2::kiosk::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(arg2, arg3, arg4);
        check_not_mythic(v0);
        let v1 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_item_type(v0);
        let (v2, v3, v4) = get_repair_costs(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier(v0), v1);
        let v5 = v4;
        let v6 = calculate_instant_fee_tato(arg0, v2);
        assert!(0x2::coin::value<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>(&arg5) >= v6, 200);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>>(arg5, arg0.treasury_address);
        validate_and_consume_payments(arg1, v3, &v5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17);
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::repair_tool_full_with_cap(0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg0.pawtato_package_cap), 0x2::kiosk::borrow_mut<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(arg2, arg3, arg4));
        arg0.total_crystal_spent = arg0.total_crystal_spent + v3;
        let v7 = ToolRepairInstant{
            user          : 0x2::tx_context::sender(arg17),
            tool_id       : arg4,
            item_type     : v1,
            sui_fee_paid  : v6,
            crystal_spent : v3,
        };
        0x2::event::emit<ToolRepairInstant>(v7);
    }

    fun internal_complete_repair(arg0: &mut RepairQueue, arg1: u64, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::table::contains<address, vector<RepairDetails>>(&arg0.users, v0), 203);
        let v1 = 0x2::table::borrow_mut<address, vector<RepairDetails>>(&mut arg0.users, v0);
        assert!(arg1 < 0x1::vector::length<RepairDetails>(v1), 203);
        let v2 = 0x1::vector::remove<RepairDetails>(v1, arg1);
        let v3 = v2.tool_id;
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::repair_tool_full_with_cap(0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg0.pawtato_package_cap), 0x2::kiosk::borrow_mut<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(&mut arg0.kiosk, &arg0.kiosk_owner_cap, v3));
        0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_kiosk_helpers::direct_transfer<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(&mut arg0.kiosk, &arg0.kiosk_owner_cap, arg2, arg3, v3, arg4, arg5);
        if (0x1::vector::length<RepairDetails>(v1) == 0) {
            0x2::table::remove<address, vector<RepairDetails>>(&mut arg0.users, v0);
            let v4 = 0;
            while (v4 < 0x1::vector::length<address>(&arg0.repairers)) {
                if (*0x1::vector::borrow<address>(&arg0.repairers, v4) == v0) {
                    0x1::vector::remove<address>(&mut arg0.repairers, v4);
                    break
                };
                v4 = v4 + 1;
            };
        };
        arg0.total_repairs_completed = arg0.total_repairs_completed + 1;
        let v5 = ToolRepairCompleted{
            user      : v0,
            tool_id   : v3,
            item_type : v2.item_type,
        };
        0x2::event::emit<ToolRepairCompleted>(v5);
    }

    public entry fun repair_staked_tool_instant(arg0: &mut RepairQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: 0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>, arg6: 0x2::coin::Coin<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>, arg7: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg8: 0x2::coin::Coin<0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal::PAWTATO_COIN_COAL>, arg9: 0x2::coin::Coin<0x422d4e84d7eaee54e75c140e2f7ae9503311f516342ef2c6020c8f8be8629024::pawtato_coin_iron::PAWTATO_COIN_IRON>, arg10: 0x2::coin::Coin<0xf9d3566bb782d792a93a16a9db69211808048dee1914b64cb7f96a3582258671::pawtato_coin_gold::PAWTATO_COIN_GOLD>, arg11: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg12: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg13: 0x2::coin::Coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>, arg14: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg15: 0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>, arg16: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg16);
        let v1 = 0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg0.pawtato_package_cap);
        let v2 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_staked_tool_for_upgrading_with_cap(v1, arg2, v0, arg3);
        check_not_mythic(v2);
        let v3 = *0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier(v2);
        let v4 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_item_type(v2);
        let (v5, v6, v7) = get_repair_costs(&v3, v4);
        let v8 = v7;
        let v9 = calculate_instant_fee_sui(v5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= v9, 200);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, arg0.treasury_address);
        validate_and_consume_payments(arg1, v6, &v8, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::repair_tool_full_with_cap(v1, v2);
        arg0.total_crystal_spent = arg0.total_crystal_spent + v6;
        let v10 = ToolRepairInstant{
            user          : v0,
            tool_id       : arg3,
            item_type     : v4,
            sui_fee_paid  : v9,
            crystal_spent : v6,
        };
        0x2::event::emit<ToolRepairInstant>(v10);
    }

    public entry fun repair_staked_tool_instant_tato(arg0: &mut RepairQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>, arg5: 0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>, arg6: 0x2::coin::Coin<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>, arg7: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg8: 0x2::coin::Coin<0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal::PAWTATO_COIN_COAL>, arg9: 0x2::coin::Coin<0x422d4e84d7eaee54e75c140e2f7ae9503311f516342ef2c6020c8f8be8629024::pawtato_coin_iron::PAWTATO_COIN_IRON>, arg10: 0x2::coin::Coin<0xf9d3566bb782d792a93a16a9db69211808048dee1914b64cb7f96a3582258671::pawtato_coin_gold::PAWTATO_COIN_GOLD>, arg11: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg12: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg13: 0x2::coin::Coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>, arg14: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg15: 0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>, arg16: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg16);
        let v1 = 0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg0.pawtato_package_cap);
        let v2 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_staked_tool_for_upgrading_with_cap(v1, arg2, v0, arg3);
        check_not_mythic(v2);
        let v3 = *0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier(v2);
        let v4 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_item_type(v2);
        let (v5, v6, v7) = get_repair_costs(&v3, v4);
        let v8 = v7;
        let v9 = calculate_instant_fee_tato(arg0, v5);
        assert!(0x2::coin::value<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>(&arg4) >= v9, 200);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>>(arg4, arg0.treasury_address);
        validate_and_consume_payments(arg1, v6, &v8, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::repair_tool_full_with_cap(v1, v2);
        arg0.total_crystal_spent = arg0.total_crystal_spent + v6;
        let v10 = ToolRepairInstant{
            user          : v0,
            tool_id       : arg3,
            item_type     : v4,
            sui_fee_paid  : v9,
            crystal_spent : v6,
        };
        0x2::event::emit<ToolRepairInstant>(v10);
    }

    public entry fun set_paused(arg0: &0x67b49498b9e3d942c9ba3c5442fc85aa2011abcdc1a2edf73d83cb4af46f46e0::pawtato_tool_upgrades::ToolUpgradeAdminCap, arg1: &mut RepairQueue, arg2: bool) {
        arg1.paused = arg2;
    }

    public entry fun set_tato_instant_fee_per_hour(arg0: &0x67b49498b9e3d942c9ba3c5442fc85aa2011abcdc1a2edf73d83cb4af46f46e0::pawtato_tool_upgrades::ToolUpgradeAdminCap, arg1: &mut RepairQueue, arg2: u64) {
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, b"tato_instant_fee_per_hour")) {
            *0x2::dynamic_field::borrow_mut<vector<u8>, u64>(&mut arg1.id, b"tato_instant_fee_per_hour") = arg2;
        } else {
            0x2::dynamic_field::add<vector<u8>, u64>(&mut arg1.id, b"tato_instant_fee_per_hour", arg2);
        };
    }

    public entry fun set_treasury_address(arg0: &0x67b49498b9e3d942c9ba3c5442fc85aa2011abcdc1a2edf73d83cb4af46f46e0::pawtato_tool_upgrades::ToolUpgradeAdminCap, arg1: &mut RepairQueue, arg2: address) {
        arg1.treasury_address = arg2;
    }

    public entry fun start_repair(arg0: &mut RepairQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: &0x2::clock::Clock, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::object::ID, arg6: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg7: 0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>, arg8: 0x2::coin::Coin<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>, arg9: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg10: 0x2::coin::Coin<0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal::PAWTATO_COIN_COAL>, arg11: 0x2::coin::Coin<0x422d4e84d7eaee54e75c140e2f7ae9503311f516342ef2c6020c8f8be8629024::pawtato_coin_iron::PAWTATO_COIN_IRON>, arg12: 0x2::coin::Coin<0xf9d3566bb782d792a93a16a9db69211808048dee1914b64cb7f96a3582258671::pawtato_coin_gold::PAWTATO_COIN_GOLD>, arg13: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg14: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg15: 0x2::coin::Coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>, arg16: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg17: 0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>, arg18: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_not_paused(arg0);
        0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_kiosk_helpers::direct_transfer<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(arg3, arg4, &mut arg0.kiosk, &arg0.kiosk_owner_cap, arg5, arg6, arg18);
        let v0 = 0x2::tx_context::sender(arg18);
        let v1 = 0x2::kiosk::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>(&arg0.kiosk, &arg0.kiosk_owner_cap, arg5);
        check_not_mythic(v1);
        let v2 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_item_type(v1);
        let (v3, v4, v5) = get_repair_costs(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::get_tier(v1), v2);
        let v6 = v5;
        validate_and_consume_payments(arg1, v4, &v6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18);
        let v7 = RepairDetails{
            tool_id   : arg5,
            item_type : v2,
            started   : 0x2::clock::timestamp_ms(arg2),
            duration  : v3,
        };
        if (!0x2::table::contains<address, vector<RepairDetails>>(&arg0.users, v0)) {
            0x2::table::add<address, vector<RepairDetails>>(&mut arg0.users, v0, 0x1::vector::empty<RepairDetails>());
            0x1::vector::push_back<address>(&mut arg0.repairers, v0);
        };
        0x1::vector::push_back<RepairDetails>(0x2::table::borrow_mut<address, vector<RepairDetails>>(&mut arg0.users, v0), v7);
        arg0.total_repairs_started = arg0.total_repairs_started + 1;
        arg0.total_crystal_spent = arg0.total_crystal_spent + v4;
        let v8 = ToolRepairStarted{
            user         : v0,
            tool_id      : arg5,
            item_type    : v2,
            duration     : v3,
            crystal_cost : v4,
        };
        0x2::event::emit<ToolRepairStarted>(v8);
    }

    public entry fun upgrade_version(arg0: &0x67b49498b9e3d942c9ba3c5442fc85aa2011abcdc1a2edf73d83cb4af46f46e0::pawtato_tool_upgrades::ToolUpgradeAdminCap, arg1: &mut RepairQueue, arg2: u64) {
        arg1.version = arg2;
    }

    fun validate_and_consume_payments(arg0: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg1: u64, arg2: &vector<u64>, arg3: 0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>, arg4: 0x2::coin::Coin<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>, arg5: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg6: 0x2::coin::Coin<0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal::PAWTATO_COIN_COAL>, arg7: 0x2::coin::Coin<0x422d4e84d7eaee54e75c140e2f7ae9503311f516342ef2c6020c8f8be8629024::pawtato_coin_iron::PAWTATO_COIN_IRON>, arg8: 0x2::coin::Coin<0xf9d3566bb782d792a93a16a9db69211808048dee1914b64cb7f96a3582258671::pawtato_coin_gold::PAWTATO_COIN_GOLD>, arg9: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg10: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg11: 0x2::coin::Coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>, arg12: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg13: 0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg14);
        let v1 = arg1 + *0x1::vector::borrow<u64>(arg2, 6);
        if (v1 > 0) {
            assert!(0x2::coin::value<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(&arg9) >= v1, 200);
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(arg0, 0x2::coin::split<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(&mut arg9, v1, arg14));
        };
        if (0x2::coin::value<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(&arg9) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>>(arg9, v0);
        } else {
            0x2::coin::destroy_zero<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(arg9);
        };
        let v2 = *0x1::vector::borrow<u64>(arg2, 0);
        if (v2 > 0) {
            assert!(0x2::coin::value<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>(&arg3) >= v2, 200);
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>(arg0, 0x2::coin::split<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>(&mut arg3, v2, arg14));
        };
        if (0x2::coin::value<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>>(arg3, v0);
        } else {
            0x2::coin::destroy_zero<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>(arg3);
        };
        let v3 = *0x1::vector::borrow<u64>(arg2, 1);
        if (v3 > 0) {
            assert!(0x2::coin::value<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>(&arg4) >= v3, 200);
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>(arg0, 0x2::coin::split<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>(&mut arg4, v3, arg14));
        };
        if (0x2::coin::value<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>(&arg4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>>(arg4, v0);
        } else {
            0x2::coin::destroy_zero<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>(arg4);
        };
        let v4 = *0x1::vector::borrow<u64>(arg2, 2);
        if (v4 > 0) {
            assert!(0x2::coin::value<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(&arg5) >= v4, 200);
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, 0x2::coin::split<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(&mut arg5, v4, arg14));
        };
        if (0x2::coin::value<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(&arg5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>>(arg5, v0);
        } else {
            0x2::coin::destroy_zero<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg5);
        };
        let v5 = *0x1::vector::borrow<u64>(arg2, 3);
        if (v5 > 0) {
            assert!(0x2::coin::value<0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal::PAWTATO_COIN_COAL>(&arg6) >= v5, 200);
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal::PAWTATO_COIN_COAL>(arg0, 0x2::coin::split<0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal::PAWTATO_COIN_COAL>(&mut arg6, v5, arg14));
        };
        if (0x2::coin::value<0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal::PAWTATO_COIN_COAL>(&arg6) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal::PAWTATO_COIN_COAL>>(arg6, v0);
        } else {
            0x2::coin::destroy_zero<0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal::PAWTATO_COIN_COAL>(arg6);
        };
        let v6 = *0x1::vector::borrow<u64>(arg2, 4);
        if (v6 > 0) {
            assert!(0x2::coin::value<0x422d4e84d7eaee54e75c140e2f7ae9503311f516342ef2c6020c8f8be8629024::pawtato_coin_iron::PAWTATO_COIN_IRON>(&arg7) >= v6, 200);
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x422d4e84d7eaee54e75c140e2f7ae9503311f516342ef2c6020c8f8be8629024::pawtato_coin_iron::PAWTATO_COIN_IRON>(arg0, 0x2::coin::split<0x422d4e84d7eaee54e75c140e2f7ae9503311f516342ef2c6020c8f8be8629024::pawtato_coin_iron::PAWTATO_COIN_IRON>(&mut arg7, v6, arg14));
        };
        if (0x2::coin::value<0x422d4e84d7eaee54e75c140e2f7ae9503311f516342ef2c6020c8f8be8629024::pawtato_coin_iron::PAWTATO_COIN_IRON>(&arg7) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x422d4e84d7eaee54e75c140e2f7ae9503311f516342ef2c6020c8f8be8629024::pawtato_coin_iron::PAWTATO_COIN_IRON>>(arg7, v0);
        } else {
            0x2::coin::destroy_zero<0x422d4e84d7eaee54e75c140e2f7ae9503311f516342ef2c6020c8f8be8629024::pawtato_coin_iron::PAWTATO_COIN_IRON>(arg7);
        };
        let v7 = *0x1::vector::borrow<u64>(arg2, 5);
        if (v7 > 0) {
            assert!(0x2::coin::value<0xf9d3566bb782d792a93a16a9db69211808048dee1914b64cb7f96a3582258671::pawtato_coin_gold::PAWTATO_COIN_GOLD>(&arg8) >= v7, 200);
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0xf9d3566bb782d792a93a16a9db69211808048dee1914b64cb7f96a3582258671::pawtato_coin_gold::PAWTATO_COIN_GOLD>(arg0, 0x2::coin::split<0xf9d3566bb782d792a93a16a9db69211808048dee1914b64cb7f96a3582258671::pawtato_coin_gold::PAWTATO_COIN_GOLD>(&mut arg8, v7, arg14));
        };
        if (0x2::coin::value<0xf9d3566bb782d792a93a16a9db69211808048dee1914b64cb7f96a3582258671::pawtato_coin_gold::PAWTATO_COIN_GOLD>(&arg8) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xf9d3566bb782d792a93a16a9db69211808048dee1914b64cb7f96a3582258671::pawtato_coin_gold::PAWTATO_COIN_GOLD>>(arg8, v0);
        } else {
            0x2::coin::destroy_zero<0xf9d3566bb782d792a93a16a9db69211808048dee1914b64cb7f96a3582258671::pawtato_coin_gold::PAWTATO_COIN_GOLD>(arg8);
        };
        let v8 = *0x1::vector::borrow<u64>(arg2, 7);
        if (v8 > 0) {
            assert!(0x2::coin::value<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>(&arg10) >= v8, 200);
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>(arg0, 0x2::coin::split<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>(&mut arg10, v8, arg14));
        };
        if (0x2::coin::value<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>(&arg10) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>>(arg10, v0);
        } else {
            0x2::coin::destroy_zero<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>(arg10);
        };
        let v9 = *0x1::vector::borrow<u64>(arg2, 8);
        if (v9 > 0) {
            assert!(0x2::coin::value<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>(&arg11) >= v9, 200);
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>(arg0, 0x2::coin::split<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>(&mut arg11, v9, arg14));
        };
        if (0x2::coin::value<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>(&arg11) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>>(arg11, v0);
        } else {
            0x2::coin::destroy_zero<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>(arg11);
        };
        let v10 = *0x1::vector::borrow<u64>(arg2, 9);
        if (v10 > 0) {
            assert!(0x2::coin::value<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>(&arg12) >= v10, 200);
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>(arg0, 0x2::coin::split<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>(&mut arg12, v10, arg14));
        };
        if (0x2::coin::value<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>(&arg12) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>>(arg12, v0);
        } else {
            0x2::coin::destroy_zero<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>(arg12);
        };
        let v11 = *0x1::vector::borrow<u64>(arg2, 10);
        if (v11 > 0) {
            assert!(0x2::coin::value<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>(&arg13) >= v11, 200);
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>(arg0, 0x2::coin::split<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>(&mut arg13, v11, arg14));
        };
        if (0x2::coin::value<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>(&arg13) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>>(arg13, v0);
        } else {
            0x2::coin::destroy_zero<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>(arg13);
        };
    }

    // decompiled from Move bytecode v6
}

