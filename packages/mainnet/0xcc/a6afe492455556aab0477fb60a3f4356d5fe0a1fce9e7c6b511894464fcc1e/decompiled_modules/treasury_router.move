module 0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::treasury_router {
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

    public entry fun pay_and_mint_v2(arg0: address, arg1: u8, arg2: u64, arg3: vector<u8>, arg4: bool, arg5: vector<u8>, arg6: u64, arg7: u64, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: &0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::config_registry::Config, arg10: &mut 0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::pricing_guard::Guard, arg11: &mut 0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::tvyn::MintVault, arg12: &mut 0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::pol_treasury::Treasury, arg13: &mut 0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::daily_mints::DailyMints, arg14: &mut 0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::memory_ledger::MemoryLedger, arg15: &0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::timate_params::TimateParams, arg16: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg17: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 == 0x2::tx_context::sender(arg19), 2);
        0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::daily_mints::record_mint_activity(arg13, arg0, arg1, arg18);
        let v0 = 0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::daily_mints::try_claim_global_reward(arg13, arg0, arg18);
        if (arg1 == 2) {
            assert!(arg2 <= 20171231, 3);
        } else if (arg1 == 1) {
            assert!(arg2 > 20171231, 4);
        };
        0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::pricing_guard::validate_quote(arg10, arg6, arg7, arg18, arg19);
        let v1 = if (arg1 == 1) {
            0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::config_registry::today_fee_usd(arg9)
        } else {
            0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::config_registry::nostalgia_fee_usd(arg9)
        };
        let v2 = 0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::pricing_guard::usd_cents_to_sui_min_coins(arg9, arg16, arg17, arg18, v1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg8) >= v2, 1);
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg8);
        if (v3 > v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg8, v3 - v2, arg19), arg0);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg8, 0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::config_registry::dev_addr(arg9));
        0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::pol_treasury::deposit(arg12, 0x2::coin::split<0x2::sui::SUI>(&mut arg8, 0x2::coin::value<0x2::sui::SUI>(&arg8) * 2500 / 10000, arg19));
        let v4 = 0;
        let v5 = 0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::config_registry::dev_addr(arg9);
        let v6 = 0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::config_registry::dev_tvyn_ratio_bps(arg9);
        0x1::option::none<0x2::object::ID>();
        let v7 = if (arg1 == 1) {
            let v8 = if (v0) {
                0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::config_registry::reward_today_immediate(arg9)
            } else {
                0
            };
            if (v8 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::tvyn::TVYN>>(0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::tvyn::mint_for_protocol(arg11, v8, arg19), arg0);
                v4 = v8;
                let v9 = v8 * v6 / 10000;
                if (v9 > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::tvyn::TVYN>>(0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::tvyn::mint_for_protocol(arg11, v9, arg19), v5);
                };
            };
            if (arg4) {
                let v10 = 0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::anniversary_vault::mint_ticket(arg2, arg3, arg5, arg0, 0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::config_registry::default_royalty_bps(arg9), v0, arg18, arg19);
                let v11 = 0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::anniversary_vault::ticket_id(&v10);
                0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::memory_ledger::note_today(arg14, v11, arg0, arg2);
                0x2::transfer::public_transfer<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::anniversary_vault::AnniversaryTicket>(v10, arg0);
                0x1::option::some<0x2::object::ID>(v11)
            } else {
                let v12 = 0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::simple_memory::mint(0x2::clock::timestamp_ms(arg18), arg19);
                0x2::transfer::public_transfer<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::simple_memory::SimpleMemory>(v12, arg0);
                0x1::option::some<0x2::object::ID>(0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::simple_memory::id(&v12))
            }
        } else {
            let v13 = if (v0) {
                0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::config_registry::reward_nostalgia_base(arg9)
            } else {
                0
            };
            let v14 = 0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::timate_params::reward_per_mate_tvyn(arg15);
            if (v13 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::tvyn::TVYN>>(0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::tvyn::mint_for_protocol(arg11, v13, arg19), arg0);
                v4 = v13;
                let v15 = v13 * v6 / 10000;
                if (v15 > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::tvyn::TVYN>>(0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::tvyn::mint_for_protocol(arg11, v15, arg19), v5);
                };
            };
            let v16 = ((arg2 / 10000) as u64);
            let v7 = if (arg4) {
                let v17 = 0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::nostalgia_ticket::mint_ticket((v16 as u16), arg3, arg5, arg0, 0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::config_registry::default_royalty_bps(arg9), 0x2::clock::timestamp_ms(arg18), arg19);
                0x2::transfer::public_transfer<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::nostalgia_ticket::NostalgiaTicket>(v17, arg0);
                0x1::option::some<0x2::object::ID>(0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::nostalgia_ticket::ticket_id(&v17))
            } else {
                let v18 = 0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::simple_memory::mint(0x2::clock::timestamp_ms(arg18), arg19);
                0x2::transfer::public_transfer<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::simple_memory::SimpleMemory>(v18, arg0);
                0x1::option::some<0x2::object::ID>(0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::simple_memory::id(&v18))
            };
            let v19 = 0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::memory_ledger::pair_or_wait_nostalgia(arg14, arg0, v16);
            if (0x1::option::is_some<address>(&v19)) {
                let v20 = 0x1::option::extract<address>(&mut v19);
                if (v14 > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::tvyn::TVYN>>(0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::tvyn::mint_for_protocol(arg11, v14, arg19), arg0);
                    0x2::transfer::public_transfer<0x2::coin::Coin<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::tvyn::TVYN>>(0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::tvyn::mint_for_protocol(arg11, v14, arg19), v20);
                    v4 = v4 + v14;
                    let v21 = v14 * 2 * v6 / 10000;
                    if (v21 > 0) {
                        0x2::transfer::public_transfer<0x2::coin::Coin<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::tvyn::TVYN>>(0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::tvyn::mint_for_protocol(arg11, v21, arg19), v5);
                    };
                };
                let v22 = TimeMateFormed{
                    user  : arg0,
                    mate  : v20,
                    year  : v16,
                    bonus : v14,
                };
                0x2::event::emit<TimeMateFormed>(v22);
            } else {
                let v23 = EnteredWaitingRoom{
                    user : arg0,
                    year : v16,
                };
                0x2::event::emit<EnteredWaitingRoom>(v23);
            };
            v7
        };
        let v24 = MintSealed{
            user            : arg0,
            kind            : arg1,
            date_yyyymmdd   : arg2,
            tvyn_minted     : v4,
            reward_eligible : v0,
            collectible     : arg4,
            mint_object_id  : v7,
        };
        0x2::event::emit<MintSealed>(v24);
    }

    // decompiled from Move bytecode v6
}

