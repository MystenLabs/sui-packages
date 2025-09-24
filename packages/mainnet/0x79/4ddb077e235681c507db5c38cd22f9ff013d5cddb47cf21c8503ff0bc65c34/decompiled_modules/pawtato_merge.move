module 0x1cebea2d84221dd8d0529ee072a45ada321c24843b25de4b355ed1c5aeda0edc::pawtato_merge {
    struct MergeInit has copy, drop {
        user: address,
        land_type: 0x1::string::String,
        sky: 0x1::string::String,
        soil: 0x1::string::String,
        wood: 0x1::string::String,
        stone: 0x1::string::String,
        water: 0x1::string::String,
        coal: 0x1::string::String,
        iron: 0x1::string::String,
        gold: 0x1::string::String,
        crystal: 0x1::string::String,
        small_building_slots: 0x1::string::String,
        medium_building_slots: 0x1::string::String,
        large_building_slots: 0x1::string::String,
        new_token_id: 0x1::string::String,
        merged_nft_ids: vector<0x2::object::ID>,
        donation_amount: 0x1::string::String,
        donation_type: 0x1::string::String,
    }

    struct MergeFinalized has copy, drop {
        user: address,
        new_nft_id: 0x2::object::ID,
        new_token_id: 0x1::string::String,
        land_type: 0x1::string::String,
        merged_nft_ids: vector<0x2::object::ID>,
    }

    struct PAWTATO_MERGE has drop {
        dummy_field: bool,
    }

    struct MergeAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MergeQueue has key {
        id: 0x2::object::UID,
        start_time: u64,
        end_time: u64,
        treasury_address: address,
        paused: bool,
        version: u64,
        kiosk: 0x2::kiosk::Kiosk,
        kiosk_cap: 0x2::kiosk::KioskOwnerCap,
        user_merges: 0x2::table::Table<address, vector<PendingMerge>>,
        active_users: vector<address>,
        pending_burned_nft_ids: vector<0x2::object::ID>,
        burned_nft_ids: vector<0x2::object::ID>,
        pawtato_package_cap: 0x1::option::Option<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>,
    }

    struct PendingMerge has store {
        user: address,
        land_type: 0x1::string::String,
        new_token_id: u64,
        merged_land_ids: vector<0x2::object::ID>,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        created_at: u64,
    }

    public entry fun add_pawtato_package_cap(arg0: &MergeAdminCap, arg1: &mut MergeQueue, arg2: 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap) {
        0x1::option::fill<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&mut arg1.pawtato_package_cap, arg2);
    }

    public entry fun burn_all_merged_lands(arg0: &mut MergeQueue, arg1: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::LAND>, arg2: &mut 0x2::transfer_policy::TransferPolicyCap<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::LAND>, arg3: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::NFTCollection, arg4: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        if (0x1::vector::length<0x2::object::ID>(&arg0.pending_burned_nft_ids) == 0) {
            return
        };
        0x2::transfer_policy::remove_rule<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::LAND, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::Rule, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::Config>(arg1, arg2);
        let v0 = 0;
        while (!0x1::vector::is_empty<0x2::object::ID>(&arg0.pending_burned_nft_ids) && v0 < 100) {
            let v1 = 0x1::vector::pop_back<0x2::object::ID>(&mut arg0.pending_burned_nft_ids);
            let (v2, v3) = 0x2::kiosk::purchase_with_cap<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::LAND>(&mut arg0.kiosk, 0x2::kiosk::list_with_purchase_cap<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::LAND>(&mut arg0.kiosk, &arg0.kiosk_cap, v1, 0, arg4), 0x2::coin::zero<0x2::sui::SUI>(arg4));
            let v4 = v3;
            if (0x2::transfer_policy::has_rule<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::LAND, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg1)) {
                0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::LAND>(arg1, &mut v4, 0x2::coin::zero<0x2::sui::SUI>(arg4));
            };
            let (_, _, _) = 0x2::transfer_policy::confirm_request<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::LAND>(arg1, v4);
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::burn_nft(v2, arg3);
            0x1::vector::push_back<0x2::object::ID>(&mut arg0.burned_nft_ids, v1);
            v0 = v0 + 1;
        };
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::LAND>(arg1, arg2);
    }

    fun calculate_merged_traits(arg0: &MergeQueue, arg1: &vector<0x2::object::ID>) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Sky"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Soil"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Wood"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Stone"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Water"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Coal"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Iron"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Gold"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Crystal"));
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::string::String>(&v1)) {
            let v4 = 0x1::vector::borrow<0x1::string::String>(&v1, v3);
            let v5 = 0x1::string::utf8(b"None");
            let v6 = 0;
            while (v6 < 0x1::vector::length<0x2::object::ID>(arg1)) {
                let v7 = *0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::get_attributes(0x2::kiosk::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::LAND>(&arg0.kiosk, &arg0.kiosk_cap, *0x1::vector::borrow<0x2::object::ID>(arg1, v6)));
                let v8 = 0x1::string::utf8(b"Land Type");
                if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&v7, &v8)) {
                    assert!(*0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&v7, &v8) == 0x1::string::utf8(b"Plot"), 611);
                };
                if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&v7, v4)) {
                    let v9 = *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&v7, v4);
                    if (get_trait_priority(&v9) > 0) {
                        v5 = v9;
                    };
                };
                v6 = v6 + 1;
            };
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, *v4, v5);
            v3 = v3 + 1;
        };
        v0
    }

    fun check_not_paused(arg0: &MergeQueue) {
        assert!(!arg0.paused, 609);
    }

    public fun check_version(arg0: &MergeQueue) {
        assert!(arg0.version == 1, 610);
    }

    fun consume_dft_donation(arg0: 0x2::token::Token<0xd72ab42db7dfe82f07858fd4af0d821c939b037b51200554256ed0446b488db::pawtato_coin_divine_favor_token::PAWTATO_COIN_DIVINE_FAVOR_TOKEN>, arg1: u64, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg3: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xd72ab42db7dfe82f07858fd4af0d821c939b037b51200554256ed0446b488db::pawtato_coin_divine_favor_token::get_token_value(&arg0) >= arg1, 607);
        if (0xd72ab42db7dfe82f07858fd4af0d821c939b037b51200554256ed0446b488db::pawtato_coin_divine_favor_token::get_token_value(&arg0) == arg1) {
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_dft_token_with_cap(arg3, arg2, arg0, arg4);
        } else {
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_dft_token_with_cap(arg3, arg2, 0xd72ab42db7dfe82f07858fd4af0d821c939b037b51200554256ed0446b488db::pawtato_coin_divine_favor_token::split_token(&mut arg0, arg1, arg4), arg4);
            if (0xd72ab42db7dfe82f07858fd4af0d821c939b037b51200554256ed0446b488db::pawtato_coin_divine_favor_token::get_token_value(&arg0) > 0) {
                0x2::token::keep<0xd72ab42db7dfe82f07858fd4af0d821c939b037b51200554256ed0446b488db::pawtato_coin_divine_favor_token::PAWTATO_COIN_DIVINE_FAVOR_TOKEN>(arg0, arg4);
            } else {
                0xd72ab42db7dfe82f07858fd4af0d821c939b037b51200554256ed0446b488db::pawtato_coin_divine_favor_token::destroy_zero_token(arg0);
            };
        };
    }

    fun consume_zero_dft_token(arg0: 0x2::token::Token<0xd72ab42db7dfe82f07858fd4af0d821c939b037b51200554256ed0446b488db::pawtato_coin_divine_favor_token::PAWTATO_COIN_DIVINE_FAVOR_TOKEN>) {
        assert!(0xd72ab42db7dfe82f07858fd4af0d821c939b037b51200554256ed0446b488db::pawtato_coin_divine_favor_token::get_token_value(&arg0) == 0, 607);
        0xd72ab42db7dfe82f07858fd4af0d821c939b037b51200554256ed0446b488db::pawtato_coin_divine_favor_token::destroy_zero_token(arg0);
    }

    public entry fun finalize_merge(arg0: &mut MergeQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::NFTCollection, arg3: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::LAND>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        check_version(arg0);
        check_not_paused(arg0);
        assert!(0x2::table::contains<address, vector<PendingMerge>>(&arg0.user_merges, v0), 605);
        let v1 = 0x2::table::borrow_mut<address, vector<PendingMerge>>(&mut arg0.user_merges, v0);
        let v2 = 0;
        let v3 = false;
        let v4 = 0;
        while (v4 < 0x1::vector::length<PendingMerge>(v1)) {
            if (0x1::vector::borrow<PendingMerge>(v1, v4).new_token_id == arg4) {
                v2 = v4;
                v3 = true;
                break
            };
            v4 = v4 + 1;
        };
        assert!(v3, 605);
        if (0x1::vector::is_empty<PendingMerge>(v1)) {
            0x1::vector::destroy_empty<PendingMerge>(0x2::table::remove<address, vector<PendingMerge>>(&mut arg0.user_merges, v0));
            let (v5, v6) = 0x1::vector::index_of<address>(&arg0.active_users, &v0);
            if (v5) {
                0x1::vector::remove<address>(&mut arg0.active_users, v6);
            };
        };
        let PendingMerge {
            user            : _,
            land_type       : v8,
            new_token_id    : _,
            merged_land_ids : v10,
            attributes      : v11,
            created_at      : _,
        } = 0x1::vector::remove<PendingMerge>(v1, v2);
        let v13 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::mint_merged_land(0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg0.pawtato_package_cap), arg2, arg4, 0x1::string::utf8(b"Pawtato Land is a blockchain based roleplaying strategy game where land owners can shape the world players are interacting with."), v11, arg6);
        0x1::vector::append<0x2::object::ID>(&mut arg0.pending_burned_nft_ids, v10);
        let v14 = 0x2::object::id<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::LAND>(&v13);
        0x2::kiosk::lock<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::LAND>(&mut arg0.kiosk, &arg0.kiosk_cap, arg3, v13);
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::stake_land_after_merge(0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg0.pawtato_package_cap), arg1, &mut arg0.kiosk, &arg0.kiosk_cap, v0, v14, arg3, arg5, arg6);
        let v15 = MergeFinalized{
            user           : v0,
            new_nft_id     : v14,
            new_token_id   : 0x1cebea2d84221dd8d0529ee072a45ada321c24843b25de4b355ed1c5aeda0edc::merge_helpers::u64_to_string(arg4),
            land_type      : v8,
            merged_nft_ids : v10,
        };
        0x2::event::emit<MergeFinalized>(v15);
    }

    fun generate_building_slots(arg0: bool, arg1: bool, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v1 = 0x2::random::new_generator(arg2, arg3);
        if (arg0) {
            let v2 = if (arg1) {
                0x2::random::generate_u8_in_range(&mut v1, 3, 4)
            } else {
                0x2::random::generate_u8_in_range(&mut v1, 2, 4)
            };
            let v3 = if (arg1) {
                0x2::random::generate_u8_in_range(&mut v1, 2, 3)
            } else {
                0x2::random::generate_u8_in_range(&mut v1, 1, 3)
            };
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Small Building Slots"), 0x1cebea2d84221dd8d0529ee072a45ada321c24843b25de4b355ed1c5aeda0edc::merge_helpers::u64_to_string((v2 as u64)));
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Medium Building Slots"), 0x1cebea2d84221dd8d0529ee072a45ada321c24843b25de4b355ed1c5aeda0edc::merge_helpers::u64_to_string((v3 as u64)));
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Large Building Slots"), 0x1cebea2d84221dd8d0529ee072a45ada321c24843b25de4b355ed1c5aeda0edc::merge_helpers::u64_to_string((0 as u64)));
        } else {
            let v4 = if (arg1) {
                0x2::random::generate_u8_in_range(&mut v1, 4, 5)
            } else {
                0x2::random::generate_u8_in_range(&mut v1, 3, 5)
            };
            let v5 = if (arg1) {
                0x2::random::generate_u8_in_range(&mut v1, 4, 5)
            } else {
                0x2::random::generate_u8_in_range(&mut v1, 3, 5)
            };
            let v6 = if (arg1) {
                0x2::random::generate_u8_in_range(&mut v1, 2, 3)
            } else {
                0x2::random::generate_u8_in_range(&mut v1, 1, 3)
            };
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Small Building Slots"), 0x1cebea2d84221dd8d0529ee072a45ada321c24843b25de4b355ed1c5aeda0edc::merge_helpers::u64_to_string((v4 as u64)));
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Medium Building Slots"), 0x1cebea2d84221dd8d0529ee072a45ada321c24843b25de4b355ed1c5aeda0edc::merge_helpers::u64_to_string((v5 as u64)));
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Large Building Slots"), 0x1cebea2d84221dd8d0529ee072a45ada321c24843b25de4b355ed1c5aeda0edc::merge_helpers::u64_to_string((v6 as u64)));
        };
        v0
    }

    fun get_trait_priority(arg0: &0x1::string::String) : u8 {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = b"Atomic";
        if (v0 == &v1) {
            8
        } else {
            let v3 = b"Sundown";
            if (v0 == &v3) {
                7
            } else {
                let v4 = b"Daylight";
                if (v0 == &v4) {
                    6
                } else {
                    let v5 = b"Sunrise";
                    if (v0 == &v5) {
                        5
                    } else {
                        let v6 = b"Golden";
                        if (v0 == &v6) {
                            4
                        } else {
                            let v7 = b"Lavender";
                            if (v0 == &v7) {
                                3
                            } else {
                                let v8 = b"Cloudy";
                                if (v0 == &v8) {
                                    2
                                } else {
                                    let v9 = b"Mint";
                                    if (v0 == &v9) {
                                        1
                                    } else {
                                        let v10 = b"Violet";
                                        if (v0 == &v10) {
                                            5
                                        } else {
                                            let v11 = b"Olive";
                                            if (v0 == &v11) {
                                                4
                                            } else {
                                                let v12 = b"Terracotta";
                                                if (v0 == &v12) {
                                                    3
                                                } else {
                                                    let v13 = b"Ochre";
                                                    if (v0 == &v13) {
                                                        2
                                                    } else {
                                                        let v14 = b"Brown";
                                                        if (v0 == &v14) {
                                                            1
                                                        } else {
                                                            let v15 = b"Large";
                                                            if (v0 == &v15) {
                                                                4
                                                            } else {
                                                                let v16 = b"Medium";
                                                                if (v0 == &v16) {
                                                                    3
                                                                } else {
                                                                    let v17 = b"Small";
                                                                    if (v0 == &v17) {
                                                                        2
                                                                    } else {
                                                                        let v18 = b"None";
                                                                        if (v0 == &v18) {
                                                                            1
                                                                        } else {
                                                                            0
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    fun init(arg0: PAWTATO_MERGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MergeAdminCap{id: 0x2::object::new(arg1)};
        let (v1, v2) = 0x2::kiosk::new(arg1);
        let v3 = 1758700800000;
        let v4 = MergeQueue{
            id                     : 0x2::object::new(arg1),
            start_time             : v3,
            end_time               : v3 + 1209600000,
            treasury_address       : @0xa3748a680e98ad18caae5af3161441a476fd67ebbea9d960c34bf9f91727fdeb,
            paused                 : false,
            version                : 1,
            kiosk                  : v1,
            kiosk_cap              : v2,
            user_merges            : 0x2::table::new<address, vector<PendingMerge>>(arg1),
            active_users           : 0x1::vector::empty<address>(),
            pending_burned_nft_ids : 0x1::vector::empty<0x2::object::ID>(),
            burned_nft_ids         : 0x1::vector::empty<0x2::object::ID>(),
            pawtato_package_cap    : 0x1::option::none<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(),
        };
        0x2::transfer::share_object<MergeQueue>(v4);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<PAWTATO_MERGE>(arg0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<MergeAdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun init_merge(arg0: &mut MergeQueue, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg3: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::NFTCollection, arg4: vector<0x2::object::ID>, arg5: 0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>, arg6: 0x2::coin::Coin<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>, arg7: 0x2::coin::Coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>, arg8: 0x2::coin::Coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: 0x2::token::Token<0xd72ab42db7dfe82f07858fd4af0d821c939b037b51200554256ed0446b488db::pawtato_coin_divine_favor_token::PAWTATO_COIN_DIVINE_FAVOR_TOKEN>, arg11: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::LAND>, arg12: &0x2::clock::Clock, arg13: &0x2::random::Random, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg12);
        check_version(arg0);
        check_not_paused(arg0);
        let v1 = 0x2::tx_context::sender(arg14);
        if (v1 != @0x30fa04a11a6e96e34e5a9fb16d126ee6481b8bb65cfbf45c8959d9c56b38abd3) {
            assert!(v0 >= arg0.start_time, 600);
            assert!(v0 <= arg0.end_time, 601);
        };
        let v2 = 0x1::vector::length<0x2::object::ID>(&arg4);
        assert!(v2 == 4 || v2 == 9, 602);
        let v3 = v2 == 4;
        let v4 = if (v3) {
            0x1::string::utf8(b"Estate")
        } else {
            0x1::string::utf8(b"Province")
        };
        if (v3) {
            assert!(0x2::coin::value<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>(&arg5) >= 100000000000, 607);
            assert!(0x2::coin::value<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>(&arg6) >= 100000000000, 607);
            assert!(0x2::coin::value<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>(&arg7) >= 20000000000, 607);
            assert!(0x2::coin::value<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>(&arg8) >= 20000000000, 607);
        } else {
            assert!(0x2::coin::value<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>(&arg5) >= 250000000000, 607);
            assert!(0x2::coin::value<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>(&arg6) >= 250000000000, 607);
            assert!(0x2::coin::value<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>(&arg7) >= 100000000000, 607);
            assert!(0x2::coin::value<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>(&arg8) >= 100000000000, 607);
        };
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>(arg2, arg5);
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>(arg2, arg6);
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x8c683dd440007891ca76e883c80f3ee94141ab11d80028b20b97f62043db6dab::pawtato_coin_wooden_plank::PAWTATO_COIN_WOODEN_PLANK>(arg2, arg7);
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block::PAWTATO_COIN_STONE_BLOCK>(arg2, arg8);
        let v5 = 0x2::coin::value<0x2::sui::SUI>(&arg9);
        let v6 = 0xd72ab42db7dfe82f07858fd4af0d821c939b037b51200554256ed0446b488db::pawtato_coin_divine_favor_token::get_token_value(&arg10);
        let v7 = if (v3) {
            10000000000
        } else {
            25000000000
        };
        let (v8, v9, v10) = if (v5 >= v7) {
            assert!(v6 == 0, 612);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg9, arg0.treasury_address);
            consume_zero_dft_token(arg10);
            (true, v5, 0x1::string::utf8(b"sui"))
        } else if (v6 >= v7) {
            assert!(v5 == 0, 612);
            consume_dft_donation(arg10, v7, arg2, 0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg0.pawtato_package_cap), arg14);
            if (v5 == 0) {
                0x2::coin::destroy_zero<0x2::sui::SUI>(arg9);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg9, v1);
            };
            (true, v6, 0x1::string::utf8(b"dft"))
        } else {
            if (v5 == 0) {
                0x2::coin::destroy_zero<0x2::sui::SUI>(arg9);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg9, v1);
            };
            consume_zero_dft_token(arg10);
            (false, 0, 0x1::string::utf8(b"none"))
        };
        let v11 = 0;
        while (v11 < v2) {
            0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::unstake_land_for_merge(0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg0.pawtato_package_cap), arg1, v1, *0x1::vector::borrow<0x2::object::ID>(&arg4, v11), &mut arg0.kiosk, &arg0.kiosk_cap, arg11, arg14);
            v11 = v11 + 1;
        };
        let v12 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_next_land_token_id(0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg0.pawtato_package_cap), arg3);
        let v13 = calculate_merged_traits(arg0, &arg4);
        let v14 = generate_building_slots(v3, v8, arg13, arg14);
        let v15 = 0x1::string::utf8(b"Small Building Slots");
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v13, 0x1::string::utf8(b"Small Building Slots"), *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&v14, &v15));
        let v16 = 0x1::string::utf8(b"Medium Building Slots");
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v13, 0x1::string::utf8(b"Medium Building Slots"), *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&v14, &v16));
        let v17 = 0x1::string::utf8(b"Large Building Slots");
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v13, 0x1::string::utf8(b"Large Building Slots"), *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&v14, &v17));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v13, 0x1::string::utf8(b"Land Type"), v4);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v13, 0x1::string::utf8(b"Influence"), 0x1::string::utf8(b"0"));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v13, 0x1::string::utf8(b"Tribe"), 0x1::string::utf8(b"None"));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v13, 0x1::string::utf8(b"Coordinates"), 0x1::string::utf8(b"None"));
        let v18 = PendingMerge{
            user            : v1,
            land_type       : v4,
            new_token_id    : v12,
            merged_land_ids : arg4,
            attributes      : v13,
            created_at      : v0,
        };
        if (0x2::table::contains<address, vector<PendingMerge>>(&arg0.user_merges, v1)) {
            0x1::vector::push_back<PendingMerge>(0x2::table::borrow_mut<address, vector<PendingMerge>>(&mut arg0.user_merges, v1), v18);
        } else {
            0x2::table::add<address, vector<PendingMerge>>(&mut arg0.user_merges, v1, 0x1::vector::singleton<PendingMerge>(v18));
            0x1::vector::push_back<address>(&mut arg0.active_users, v1);
        };
        let v19 = 0x1::string::utf8(b"Sky");
        let v20 = 0x1::string::utf8(b"Soil");
        let v21 = 0x1::string::utf8(b"Wood");
        let v22 = 0x1::string::utf8(b"Stone");
        let v23 = 0x1::string::utf8(b"Water");
        let v24 = 0x1::string::utf8(b"Coal");
        let v25 = 0x1::string::utf8(b"Iron");
        let v26 = 0x1::string::utf8(b"Gold");
        let v27 = 0x1::string::utf8(b"Crystal");
        let v28 = 0x1::string::utf8(b"Small Building Slots");
        let v29 = 0x1::string::utf8(b"Medium Building Slots");
        let v30 = 0x1::string::utf8(b"Large Building Slots");
        let v31 = MergeInit{
            user                  : v1,
            land_type             : v4,
            sky                   : *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&v13, &v19),
            soil                  : *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&v13, &v20),
            wood                  : *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&v13, &v21),
            stone                 : *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&v13, &v22),
            water                 : *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&v13, &v23),
            coal                  : *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&v13, &v24),
            iron                  : *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&v13, &v25),
            gold                  : *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&v13, &v26),
            crystal               : *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&v13, &v27),
            small_building_slots  : *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&v13, &v28),
            medium_building_slots : *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&v13, &v29),
            large_building_slots  : *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&v13, &v30),
            new_token_id          : 0x1cebea2d84221dd8d0529ee072a45ada321c24843b25de4b355ed1c5aeda0edc::merge_helpers::u64_to_string(v12),
            merged_nft_ids        : arg4,
            donation_amount       : 0x1cebea2d84221dd8d0529ee072a45ada321c24843b25de4b355ed1c5aeda0edc::merge_helpers::u64_to_string(v9),
            donation_type         : v10,
        };
        0x2::event::emit<MergeInit>(v31);
    }

    public entry fun set_merge_timing(arg0: &MergeAdminCap, arg1: &mut MergeQueue, arg2: u64, arg3: u64) {
        arg1.start_time = arg2;
        arg1.end_time = arg3;
    }

    public entry fun set_paused(arg0: &MergeAdminCap, arg1: &mut MergeQueue, arg2: bool) {
        arg1.paused = arg2;
    }

    public entry fun update_treasury_address(arg0: &MergeAdminCap, arg1: &mut MergeQueue, arg2: address) {
        arg1.treasury_address = arg2;
    }

    public entry fun upgrade_version(arg0: &MergeAdminCap, arg1: &mut MergeQueue) {
        assert!(arg1.version < 1, 610);
        arg1.version = 1;
    }

    // decompiled from Move bytecode v6
}

