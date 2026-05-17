module 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::treasury_router {
    struct MintSealed has copy, drop {
        user: address,
        kind: u8,
        date_yyyymmdd: u64,
        tvyn_minted: u64,
        reward_eligible: bool,
        collectible: bool,
        mint_object_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct TimeMateFormed has copy, drop, store {
        user: address,
        mate: address,
        year: u64,
        bonus: u64,
    }

    struct EnteredWaitingRoom has copy, drop, store {
        user: address,
        year: u64,
    }

    struct AddLP has copy, drop {
        growth_catalyst: address,
        catalyst_role: vector<u8>,
        kind: u8,
        date_yyyymmdd: u64,
        sui_accum: u64,
        lp_threshold_sui: u64,
        timestamp_ms: u64,
    }

    struct DoBuyback has copy, drop {
        growth_catalyst: address,
        catalyst_role: vector<u8>,
        kind: u8,
        date_yyyymmdd: u64,
        buyback_accum: u64,
        buyback_threshold_sui: u64,
        buyback_floor_price_mist: u64,
        timestamp_ms: u64,
    }

    fun emit_maintenance_ready_events(arg0: address, arg1: u8, arg2: u64, arg3: &0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::Config, arg4: &0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::pol_treasury::Treasury, arg5: u64) {
        if (0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::pool_registered(arg3) && 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::pol_treasury::is_lp_ready(arg4, arg3)) {
            let v0 = AddLP{
                growth_catalyst  : arg0,
                catalyst_role    : b"GrowthCatalyst",
                kind             : arg1,
                date_yyyymmdd    : arg2,
                sui_accum        : 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::pol_treasury::sui_accum_value(arg4),
                lp_threshold_sui : 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::lp_threshold_sui(arg3),
                timestamp_ms     : arg5,
            };
            0x2::event::emit<AddLP>(v0);
        };
        if (0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::pool_registered(arg3) && 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::pol_treasury::is_buyback_reserve_ready(arg4, arg3)) {
            let v1 = DoBuyback{
                growth_catalyst          : arg0,
                catalyst_role            : b"GrowthCatalyst",
                kind                     : arg1,
                date_yyyymmdd            : arg2,
                buyback_accum            : 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::pol_treasury::buyback_accum_value(arg4),
                buyback_threshold_sui    : 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::buyback_max_per_run_sui(arg3),
                buyback_floor_price_mist : 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::buyback_floor_price_mist(arg3),
                timestamp_ms             : arg5,
            };
            0x2::event::emit<DoBuyback>(v1);
        };
    }

    public entry fun pay_and_mint(arg0: address, arg1: u8, arg2: u64, arg3: vector<u8>, arg4: bool, arg5: vector<u8>, arg6: vector<u8>, arg7: address, arg8: u64, arg9: u64, arg10: 0x2::coin::Coin<0x2::sui::SUI>, arg11: &0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::Config, arg12: &mut 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::pricing_guard::Guard, arg13: &mut 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::tvyn::MintVault, arg14: &mut 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::pol_treasury::Treasury, arg15: &mut 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::daily_mints::DailyMints, arg16: &mut 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::memory_ledger::MemoryLedger, arg17: &0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::timate_params::TimateParams, arg18: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg19: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg7 == @0x0) {
            arg0
        } else {
            arg7
        };
        pay_and_mint_internal(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v0, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21);
    }

    fun pay_and_mint_internal(arg0: address, arg1: u8, arg2: u64, arg3: vector<u8>, arg4: bool, arg5: vector<u8>, arg6: vector<u8>, arg7: address, arg8: u64, arg9: u64, arg10: 0x2::coin::Coin<0x2::sui::SUI>, arg11: &0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::Config, arg12: &mut 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::pricing_guard::Guard, arg13: &mut 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::tvyn::MintVault, arg14: &mut 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::pol_treasury::Treasury, arg15: &mut 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::daily_mints::DailyMints, arg16: &mut 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::memory_ledger::MemoryLedger, arg17: &0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::timate_params::TimateParams, arg18: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg19: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 == 0x2::tx_context::sender(arg21), 2);
        assert!(arg1 == 1 || arg1 == 2, 5);
        assert!(0x2::object::id<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::tvyn::MintVault>(arg13) == 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::mint_vault_id(arg11), 6);
        assert!(0x2::object::id<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::pol_treasury::Treasury>(arg14) == 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::treasury_id(arg11), 6);
        assert!(0x2::object::id<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::pricing_guard::Guard>(arg12) == 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::guard_id(arg11), 6);
        assert!(0x2::object::id<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::daily_mints::DailyMints>(arg15) == 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::daily_mints_id(arg11), 6);
        assert!(0x2::object::id<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::memory_ledger::MemoryLedger>(arg16) == 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::memory_ledger_id(arg11), 6);
        assert!(0x2::object::id<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::timate_params::TimateParams>(arg17) == 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::timate_params_id(arg11), 6);
        0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::daily_mints::record_mint_activity(arg15, arg0, arg1, arg20);
        let v0 = 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::daily_mints::try_claim_global_reward(arg15, arg0, arg20);
        if (arg1 == 2) {
            assert!(arg2 <= 20251231, 3);
        } else if (arg1 == 1) {
            assert!(arg2 > 20251231, 4);
        };
        0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::pricing_guard::validate_quote(arg12, arg8, arg9, arg20, arg21);
        let v1 = if (arg1 == 1) {
            0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::today_fee_usd(arg11)
        } else {
            0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::nostalgia_fee_usd(arg11)
        };
        let v2 = 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::pricing_guard::usd_cents_to_sui_min_coins(arg11, arg18, arg19, arg20, v1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg10) >= v2, 1);
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg10);
        if (v3 > v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg10, v3 - v2, arg21), arg0);
        };
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&arg10);
        let (v5, v6) = if (arg1 == 1) {
            let (v7, v8, v9) = 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::today_ratios(arg11);
            let _ = v7;
            (v8, v9)
        } else {
            let (v11, v12, v13) = 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::nostalgia_ratios(arg11);
            let _ = v11;
            (v12, v13)
        };
        let v14 = v4 * v5 / 10000;
        let v15 = v4 * v6 / 10000;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg10) == v4 - v14 - v15, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg10, 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::dev_addr(arg11));
        0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::pol_treasury::deposit(arg14, 0x2::coin::split<0x2::sui::SUI>(&mut arg10, v14, arg21));
        0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::pol_treasury::deposit_buyback(arg14, 0x2::coin::split<0x2::sui::SUI>(&mut arg10, v15, arg21));
        let v16 = 0;
        let v17 = 0x2::clock::timestamp_ms(arg20);
        emit_maintenance_ready_events(arg0, arg1, arg2, arg11, arg14, v17);
        let v18 = 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::dev_addr(arg11);
        let v19 = 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::dev_tvyn_ratio_bps(arg11);
        0x1::option::none<0x2::object::ID>();
        let v20 = if (arg1 == 1) {
            let v21 = if (v0) {
                0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::reward_today_immediate(arg11)
            } else {
                0
            };
            if (v21 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::tvyn::TVYN>>(0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::tvyn::mint_for_protocol(arg13, v21, arg21), arg0);
                v16 = v21;
                let v22 = v21 * v19 / 10000;
                if (v22 > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::tvyn::TVYN>>(0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::tvyn::mint_for_protocol(arg13, v22, arg21), v18);
                };
            };
            if (arg4) {
                let v23 = 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::anniversary_vault::mint_ticket(arg2, arg3, arg5, arg6, arg7, 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::default_royalty_bps(arg11), v0, arg20, arg21);
                let v24 = 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::anniversary_vault::ticket_id(&v23);
                0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::memory_ledger::note_today(arg16, v24, arg7, arg2);
                0x2::transfer::public_transfer<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::anniversary_vault::Today365>(v23, arg7);
                0x1::option::some<0x2::object::ID>(v24)
            } else {
                let v25 = 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::ghost_memory::mint(v17, arg7, 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::default_royalty_bps(arg11), arg21);
                0x2::transfer::public_transfer<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::ghost_memory::GhostMemory>(v25, arg7);
                0x1::option::some<0x2::object::ID>(0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::ghost_memory::id(&v25))
            }
        } else {
            let v26 = if (v0) {
                0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::reward_nostalgia_base(arg11)
            } else {
                0
            };
            let v27 = 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::timate_params::reward_per_mate_tvyn(arg17);
            if (v26 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::tvyn::TVYN>>(0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::tvyn::mint_for_protocol(arg13, v26, arg21), arg0);
                v16 = v26;
                let v28 = v26 * v19 / 10000;
                if (v28 > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::tvyn::TVYN>>(0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::tvyn::mint_for_protocol(arg13, v28, arg21), v18);
                };
            };
            let v29 = ((arg2 / 10000) as u64);
            let v20 = if (arg4) {
                let v30 = 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::nostalgia_ticket::mint_ticket((v29 as u16), arg3, arg5, arg6, arg7, 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::default_royalty_bps(arg11), v17, arg21);
                0x2::transfer::public_transfer<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::nostalgia_ticket::NostalgiaTicket>(v30, arg7);
                0x1::option::some<0x2::object::ID>(0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::nostalgia_ticket::ticket_id(&v30))
            } else {
                let v31 = 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::ghost_memory::mint(v17, arg7, 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::default_royalty_bps(arg11), arg21);
                0x2::transfer::public_transfer<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::ghost_memory::GhostMemory>(v31, arg7);
                0x1::option::some<0x2::object::ID>(0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::ghost_memory::id(&v31))
            };
            let v32 = 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::memory_ledger::pair_or_wait_nostalgia(arg16, arg0, v29);
            if (0x1::option::is_some<address>(&v32)) {
                let v33 = 0x1::option::extract<address>(&mut v32);
                if (v27 > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::tvyn::TVYN>>(0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::tvyn::mint_for_protocol(arg13, v27, arg21), arg0);
                    0x2::transfer::public_transfer<0x2::coin::Coin<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::tvyn::TVYN>>(0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::tvyn::mint_for_protocol(arg13, v27, arg21), v33);
                    v16 = v16 + v27;
                    let v34 = v27 * 2 * v19 / 10000;
                    if (v34 > 0) {
                        0x2::transfer::public_transfer<0x2::coin::Coin<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::tvyn::TVYN>>(0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::tvyn::mint_for_protocol(arg13, v34, arg21), v18);
                    };
                };
                let v35 = TimeMateFormed{
                    user  : arg0,
                    mate  : v33,
                    year  : v29,
                    bonus : v27,
                };
                0x2::event::emit<TimeMateFormed>(v35);
            } else {
                let v36 = EnteredWaitingRoom{
                    user : arg0,
                    year : v29,
                };
                0x2::event::emit<EnteredWaitingRoom>(v36);
            };
            v20
        };
        let v37 = MintSealed{
            user            : arg0,
            kind            : arg1,
            date_yyyymmdd   : arg2,
            tvyn_minted     : v16,
            reward_eligible : v0,
            collectible     : arg4,
            mint_object_id  : v20,
        };
        0x2::event::emit<MintSealed>(v37);
    }

    // decompiled from Move bytecode v7
}

