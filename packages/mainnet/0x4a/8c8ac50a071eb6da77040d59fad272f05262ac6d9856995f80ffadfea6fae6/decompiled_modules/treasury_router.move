module 0x4a8c8ac50a071eb6da77040d59fad272f05262ac6d9856995f80ffadfea6fae6::treasury_router {
    struct MintSealed has copy, drop {
        user: address,
        kind: u8,
        date_yyyymmdd: u64,
        tvyn_minted: u64,
        reward_eligible: bool,
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

    public entry fun pay_and_mint_v2(arg0: address, arg1: u8, arg2: u64, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x4a8c8ac50a071eb6da77040d59fad272f05262ac6d9856995f80ffadfea6fae6::config_registry::Config, arg8: &mut 0x4a8c8ac50a071eb6da77040d59fad272f05262ac6d9856995f80ffadfea6fae6::pricing_guard::Guard, arg9: &mut 0x4a8c8ac50a071eb6da77040d59fad272f05262ac6d9856995f80ffadfea6fae6::tvyn::MintVault, arg10: &mut 0x4a8c8ac50a071eb6da77040d59fad272f05262ac6d9856995f80ffadfea6fae6::pol_treasury::Treasury, arg11: &mut 0x4a8c8ac50a071eb6da77040d59fad272f05262ac6d9856995f80ffadfea6fae6::daily_mints::DailyMints, arg12: &mut 0x4a8c8ac50a071eb6da77040d59fad272f05262ac6d9856995f80ffadfea6fae6::memory_ledger::MemoryLedger, arg13: &0x4a8c8ac50a071eb6da77040d59fad272f05262ac6d9856995f80ffadfea6fae6::timate_params::TimateParams, arg14: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg15: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 == 0x2::tx_context::sender(arg17), 2);
        0x4a8c8ac50a071eb6da77040d59fad272f05262ac6d9856995f80ffadfea6fae6::daily_mints::record_mint_activity(arg11, arg0, arg1, arg16);
        let v0 = 0x4a8c8ac50a071eb6da77040d59fad272f05262ac6d9856995f80ffadfea6fae6::daily_mints::try_claim_global_reward(arg11, arg0, arg16);
        if (arg1 == 2) {
            assert!(arg2 <= 20171231, 3);
        } else if (arg1 == 1) {
            assert!(arg2 > 20171231, 4);
        };
        0x4a8c8ac50a071eb6da77040d59fad272f05262ac6d9856995f80ffadfea6fae6::pricing_guard::validate_quote(arg8, arg4, arg5, arg16, arg17);
        let v1 = if (arg1 == 1) {
            0x4a8c8ac50a071eb6da77040d59fad272f05262ac6d9856995f80ffadfea6fae6::config_registry::today_fee_usd(arg7)
        } else {
            0x4a8c8ac50a071eb6da77040d59fad272f05262ac6d9856995f80ffadfea6fae6::config_registry::nostalgia_fee_usd(arg7)
        };
        let v2 = 0x4a8c8ac50a071eb6da77040d59fad272f05262ac6d9856995f80ffadfea6fae6::pricing_guard::usd_cents_to_sui_min_coins(arg7, arg14, arg15, arg16, v1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg6) >= v2, 1);
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg6);
        if (v3 > v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg6, v3 - v2, arg17), arg0);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg6, 0x4a8c8ac50a071eb6da77040d59fad272f05262ac6d9856995f80ffadfea6fae6::config_registry::dev_addr(arg7));
        0x4a8c8ac50a071eb6da77040d59fad272f05262ac6d9856995f80ffadfea6fae6::pol_treasury::deposit(arg10, 0x2::coin::split<0x2::sui::SUI>(&mut arg6, 0x2::coin::value<0x2::sui::SUI>(&arg6) * 2500 / 10000, arg17));
        let v4 = 0;
        let v5 = 0x4a8c8ac50a071eb6da77040d59fad272f05262ac6d9856995f80ffadfea6fae6::config_registry::dev_addr(arg7);
        let v6 = 0x4a8c8ac50a071eb6da77040d59fad272f05262ac6d9856995f80ffadfea6fae6::config_registry::dev_tvyn_ratio_bps(arg7);
        if (arg1 == 1) {
            let v7 = if (v0) {
                0x4a8c8ac50a071eb6da77040d59fad272f05262ac6d9856995f80ffadfea6fae6::config_registry::reward_today_immediate(arg7)
            } else {
                0
            };
            if (v7 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x4a8c8ac50a071eb6da77040d59fad272f05262ac6d9856995f80ffadfea6fae6::tvyn::TVYN>>(0x4a8c8ac50a071eb6da77040d59fad272f05262ac6d9856995f80ffadfea6fae6::tvyn::mint_for_protocol(arg9, v7, arg17), arg0);
                v4 = v7;
                let v8 = v7 * v6 / 10000;
                if (v8 > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<0x4a8c8ac50a071eb6da77040d59fad272f05262ac6d9856995f80ffadfea6fae6::tvyn::TVYN>>(0x4a8c8ac50a071eb6da77040d59fad272f05262ac6d9856995f80ffadfea6fae6::tvyn::mint_for_protocol(arg9, v8, arg17), v5);
                };
            };
            let v9 = 0x4a8c8ac50a071eb6da77040d59fad272f05262ac6d9856995f80ffadfea6fae6::anniversary_vault::mint_ticket(arg2, arg3, arg0, 0x4a8c8ac50a071eb6da77040d59fad272f05262ac6d9856995f80ffadfea6fae6::config_registry::default_royalty_bps(arg7), v0, arg16, arg17);
            0x4a8c8ac50a071eb6da77040d59fad272f05262ac6d9856995f80ffadfea6fae6::memory_ledger::note_today(arg12, 0x2::object::id<0x4a8c8ac50a071eb6da77040d59fad272f05262ac6d9856995f80ffadfea6fae6::anniversary_vault::AnniversaryTicket>(&v9), arg0, arg2);
            0x2::transfer::public_transfer<0x4a8c8ac50a071eb6da77040d59fad272f05262ac6d9856995f80ffadfea6fae6::anniversary_vault::AnniversaryTicket>(v9, arg0);
        } else {
            let v10 = if (v0) {
                0x4a8c8ac50a071eb6da77040d59fad272f05262ac6d9856995f80ffadfea6fae6::config_registry::reward_nostalgia_base(arg7)
            } else {
                0
            };
            let v11 = 0x4a8c8ac50a071eb6da77040d59fad272f05262ac6d9856995f80ffadfea6fae6::timate_params::reward_per_mate_tvyn(arg13);
            if (v10 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x4a8c8ac50a071eb6da77040d59fad272f05262ac6d9856995f80ffadfea6fae6::tvyn::TVYN>>(0x4a8c8ac50a071eb6da77040d59fad272f05262ac6d9856995f80ffadfea6fae6::tvyn::mint_for_protocol(arg9, v10, arg17), arg0);
                v4 = v10;
                let v12 = v10 * v6 / 10000;
                if (v12 > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<0x4a8c8ac50a071eb6da77040d59fad272f05262ac6d9856995f80ffadfea6fae6::tvyn::TVYN>>(0x4a8c8ac50a071eb6da77040d59fad272f05262ac6d9856995f80ffadfea6fae6::tvyn::mint_for_protocol(arg9, v12, arg17), v5);
                };
            };
            let v13 = ((arg2 / 10000) as u64);
            0x2::transfer::public_transfer<0x4a8c8ac50a071eb6da77040d59fad272f05262ac6d9856995f80ffadfea6fae6::nostalgia_ticket::NostalgiaTicket>(0x4a8c8ac50a071eb6da77040d59fad272f05262ac6d9856995f80ffadfea6fae6::nostalgia_ticket::mint_ticket((v13 as u16), arg3, arg0, 0x4a8c8ac50a071eb6da77040d59fad272f05262ac6d9856995f80ffadfea6fae6::config_registry::default_royalty_bps(arg7), 0x2::clock::timestamp_ms(arg16), arg17), arg0);
            let v14 = 0x4a8c8ac50a071eb6da77040d59fad272f05262ac6d9856995f80ffadfea6fae6::memory_ledger::pair_or_wait_nostalgia(arg12, arg0, v13);
            if (0x1::option::is_some<address>(&v14)) {
                let v15 = 0x1::option::extract<address>(&mut v14);
                if (v11 > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<0x4a8c8ac50a071eb6da77040d59fad272f05262ac6d9856995f80ffadfea6fae6::tvyn::TVYN>>(0x4a8c8ac50a071eb6da77040d59fad272f05262ac6d9856995f80ffadfea6fae6::tvyn::mint_for_protocol(arg9, v11, arg17), arg0);
                    0x2::transfer::public_transfer<0x2::coin::Coin<0x4a8c8ac50a071eb6da77040d59fad272f05262ac6d9856995f80ffadfea6fae6::tvyn::TVYN>>(0x4a8c8ac50a071eb6da77040d59fad272f05262ac6d9856995f80ffadfea6fae6::tvyn::mint_for_protocol(arg9, v11, arg17), v15);
                    v4 = v4 + v11;
                    let v16 = v11 * 2 * v6 / 10000;
                    if (v16 > 0) {
                        0x2::transfer::public_transfer<0x2::coin::Coin<0x4a8c8ac50a071eb6da77040d59fad272f05262ac6d9856995f80ffadfea6fae6::tvyn::TVYN>>(0x4a8c8ac50a071eb6da77040d59fad272f05262ac6d9856995f80ffadfea6fae6::tvyn::mint_for_protocol(arg9, v16, arg17), v5);
                    };
                };
                let v17 = TimeMateFormed{
                    user  : arg0,
                    mate  : v15,
                    year  : v13,
                    bonus : v11,
                };
                0x2::event::emit<TimeMateFormed>(v17);
            } else {
                let v18 = EnteredWaitingRoom{
                    user : arg0,
                    year : v13,
                };
                0x2::event::emit<EnteredWaitingRoom>(v18);
            };
        };
        let v19 = MintSealed{
            user            : arg0,
            kind            : arg1,
            date_yyyymmdd   : arg2,
            tvyn_minted     : v4,
            reward_eligible : v0,
        };
        0x2::event::emit<MintSealed>(v19);
    }

    // decompiled from Move bytecode v6
}

