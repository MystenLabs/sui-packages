module 0x394dc15d46d9c14d9defbb941589691f03c90d5de8fd82ebeab6c5b242a79fa9::treasury_router {
    struct MintSealed has copy, drop {
        user: address,
        kind: u8,
        date_yyyymmdd: u64,
        tvyn_minted: u64,
        reward_eligible: bool,
        collectible: bool,
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

    public entry fun pay_and_mint_v2(arg0: address, arg1: u8, arg2: u64, arg3: vector<u8>, arg4: bool, arg5: u64, arg6: u64, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &0x394dc15d46d9c14d9defbb941589691f03c90d5de8fd82ebeab6c5b242a79fa9::config_registry::Config, arg9: &mut 0x394dc15d46d9c14d9defbb941589691f03c90d5de8fd82ebeab6c5b242a79fa9::pricing_guard::Guard, arg10: &mut 0x394dc15d46d9c14d9defbb941589691f03c90d5de8fd82ebeab6c5b242a79fa9::tvyn::MintVault, arg11: &mut 0x394dc15d46d9c14d9defbb941589691f03c90d5de8fd82ebeab6c5b242a79fa9::pol_treasury::Treasury, arg12: &mut 0x394dc15d46d9c14d9defbb941589691f03c90d5de8fd82ebeab6c5b242a79fa9::daily_mints::DailyMints, arg13: &mut 0x394dc15d46d9c14d9defbb941589691f03c90d5de8fd82ebeab6c5b242a79fa9::memory_ledger::MemoryLedger, arg14: &0x394dc15d46d9c14d9defbb941589691f03c90d5de8fd82ebeab6c5b242a79fa9::timate_params::TimateParams, arg15: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg16: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 == 0x2::tx_context::sender(arg18), 2);
        0x394dc15d46d9c14d9defbb941589691f03c90d5de8fd82ebeab6c5b242a79fa9::daily_mints::record_mint_activity(arg12, arg0, arg1, arg17);
        let v0 = 0x394dc15d46d9c14d9defbb941589691f03c90d5de8fd82ebeab6c5b242a79fa9::daily_mints::try_claim_global_reward(arg12, arg0, arg17);
        if (arg1 == 2) {
            assert!(arg2 <= 20171231, 3);
        } else if (arg1 == 1) {
            assert!(arg2 > 20171231, 4);
        };
        0x394dc15d46d9c14d9defbb941589691f03c90d5de8fd82ebeab6c5b242a79fa9::pricing_guard::validate_quote(arg9, arg5, arg6, arg17, arg18);
        let v1 = if (arg1 == 1) {
            0x394dc15d46d9c14d9defbb941589691f03c90d5de8fd82ebeab6c5b242a79fa9::config_registry::today_fee_usd(arg8)
        } else {
            0x394dc15d46d9c14d9defbb941589691f03c90d5de8fd82ebeab6c5b242a79fa9::config_registry::nostalgia_fee_usd(arg8)
        };
        let v2 = 0x394dc15d46d9c14d9defbb941589691f03c90d5de8fd82ebeab6c5b242a79fa9::pricing_guard::usd_cents_to_sui_min_coins(arg8, arg15, arg16, arg17, v1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg7) >= v2, 1);
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg7);
        if (v3 > v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg7, v3 - v2, arg18), arg0);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg7, 0x394dc15d46d9c14d9defbb941589691f03c90d5de8fd82ebeab6c5b242a79fa9::config_registry::dev_addr(arg8));
        0x394dc15d46d9c14d9defbb941589691f03c90d5de8fd82ebeab6c5b242a79fa9::pol_treasury::deposit(arg11, 0x2::coin::split<0x2::sui::SUI>(&mut arg7, 0x2::coin::value<0x2::sui::SUI>(&arg7) * 2500 / 10000, arg18));
        let v4 = 0;
        let v5 = 0x394dc15d46d9c14d9defbb941589691f03c90d5de8fd82ebeab6c5b242a79fa9::config_registry::dev_addr(arg8);
        let v6 = 0x394dc15d46d9c14d9defbb941589691f03c90d5de8fd82ebeab6c5b242a79fa9::config_registry::dev_tvyn_ratio_bps(arg8);
        if (arg1 == 1) {
            let v7 = if (v0) {
                0x394dc15d46d9c14d9defbb941589691f03c90d5de8fd82ebeab6c5b242a79fa9::config_registry::reward_today_immediate(arg8)
            } else {
                0
            };
            if (v7 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x394dc15d46d9c14d9defbb941589691f03c90d5de8fd82ebeab6c5b242a79fa9::tvyn::TVYN>>(0x394dc15d46d9c14d9defbb941589691f03c90d5de8fd82ebeab6c5b242a79fa9::tvyn::mint_for_protocol(arg10, v7, arg18), arg0);
                v4 = v7;
                let v8 = v7 * v6 / 10000;
                if (v8 > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<0x394dc15d46d9c14d9defbb941589691f03c90d5de8fd82ebeab6c5b242a79fa9::tvyn::TVYN>>(0x394dc15d46d9c14d9defbb941589691f03c90d5de8fd82ebeab6c5b242a79fa9::tvyn::mint_for_protocol(arg10, v8, arg18), v5);
                };
            };
            if (arg4) {
                let v9 = 0x394dc15d46d9c14d9defbb941589691f03c90d5de8fd82ebeab6c5b242a79fa9::anniversary_vault::mint_ticket(arg2, arg3, arg0, 0x394dc15d46d9c14d9defbb941589691f03c90d5de8fd82ebeab6c5b242a79fa9::config_registry::default_royalty_bps(arg8), v0, arg17, arg18);
                0x394dc15d46d9c14d9defbb941589691f03c90d5de8fd82ebeab6c5b242a79fa9::memory_ledger::note_today(arg13, 0x2::object::id<0x394dc15d46d9c14d9defbb941589691f03c90d5de8fd82ebeab6c5b242a79fa9::anniversary_vault::AnniversaryTicket>(&v9), arg0, arg2);
                0x2::transfer::public_transfer<0x394dc15d46d9c14d9defbb941589691f03c90d5de8fd82ebeab6c5b242a79fa9::anniversary_vault::AnniversaryTicket>(v9, arg0);
            };
        } else {
            let v10 = if (v0) {
                0x394dc15d46d9c14d9defbb941589691f03c90d5de8fd82ebeab6c5b242a79fa9::config_registry::reward_nostalgia_base(arg8)
            } else {
                0
            };
            let v11 = 0x394dc15d46d9c14d9defbb941589691f03c90d5de8fd82ebeab6c5b242a79fa9::timate_params::reward_per_mate_tvyn(arg14);
            if (v10 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x394dc15d46d9c14d9defbb941589691f03c90d5de8fd82ebeab6c5b242a79fa9::tvyn::TVYN>>(0x394dc15d46d9c14d9defbb941589691f03c90d5de8fd82ebeab6c5b242a79fa9::tvyn::mint_for_protocol(arg10, v10, arg18), arg0);
                v4 = v10;
                let v12 = v10 * v6 / 10000;
                if (v12 > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<0x394dc15d46d9c14d9defbb941589691f03c90d5de8fd82ebeab6c5b242a79fa9::tvyn::TVYN>>(0x394dc15d46d9c14d9defbb941589691f03c90d5de8fd82ebeab6c5b242a79fa9::tvyn::mint_for_protocol(arg10, v12, arg18), v5);
                };
            };
            let v13 = ((arg2 / 10000) as u64);
            if (arg4) {
                0x2::transfer::public_transfer<0x394dc15d46d9c14d9defbb941589691f03c90d5de8fd82ebeab6c5b242a79fa9::nostalgia_ticket::NostalgiaTicket>(0x394dc15d46d9c14d9defbb941589691f03c90d5de8fd82ebeab6c5b242a79fa9::nostalgia_ticket::mint_ticket((v13 as u16), arg3, arg0, 0x394dc15d46d9c14d9defbb941589691f03c90d5de8fd82ebeab6c5b242a79fa9::config_registry::default_royalty_bps(arg8), 0x2::clock::timestamp_ms(arg17), arg18), arg0);
            };
            let v14 = 0x394dc15d46d9c14d9defbb941589691f03c90d5de8fd82ebeab6c5b242a79fa9::memory_ledger::pair_or_wait_nostalgia(arg13, arg0, v13);
            if (0x1::option::is_some<address>(&v14)) {
                let v15 = 0x1::option::extract<address>(&mut v14);
                if (v11 > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<0x394dc15d46d9c14d9defbb941589691f03c90d5de8fd82ebeab6c5b242a79fa9::tvyn::TVYN>>(0x394dc15d46d9c14d9defbb941589691f03c90d5de8fd82ebeab6c5b242a79fa9::tvyn::mint_for_protocol(arg10, v11, arg18), arg0);
                    0x2::transfer::public_transfer<0x2::coin::Coin<0x394dc15d46d9c14d9defbb941589691f03c90d5de8fd82ebeab6c5b242a79fa9::tvyn::TVYN>>(0x394dc15d46d9c14d9defbb941589691f03c90d5de8fd82ebeab6c5b242a79fa9::tvyn::mint_for_protocol(arg10, v11, arg18), v15);
                    v4 = v4 + v11;
                    let v16 = v11 * 2 * v6 / 10000;
                    if (v16 > 0) {
                        0x2::transfer::public_transfer<0x2::coin::Coin<0x394dc15d46d9c14d9defbb941589691f03c90d5de8fd82ebeab6c5b242a79fa9::tvyn::TVYN>>(0x394dc15d46d9c14d9defbb941589691f03c90d5de8fd82ebeab6c5b242a79fa9::tvyn::mint_for_protocol(arg10, v16, arg18), v5);
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
            collectible     : arg4,
        };
        0x2::event::emit<MintSealed>(v19);
    }

    // decompiled from Move bytecode v6
}

