module 0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::treasury_router {
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

    public entry fun pay_and_mint_v2(arg0: address, arg1: u8, arg2: u64, arg3: vector<u8>, arg4: bool, arg5: vector<u8>, arg6: vector<u8>, arg7: u64, arg8: u64, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: &0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::config_registry::Config, arg11: &mut 0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::pricing_guard::Guard, arg12: &mut 0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::tvyn::MintVault, arg13: &mut 0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::pol_treasury::Treasury, arg14: &mut 0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::daily_mints::DailyMints, arg15: &mut 0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::memory_ledger::MemoryLedger, arg16: &0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::timate_params::TimateParams, arg17: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg18: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 == 0x2::tx_context::sender(arg20), 2);
        0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::daily_mints::record_mint_activity(arg14, arg0, arg1, arg19);
        let v0 = 0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::daily_mints::try_claim_global_reward(arg14, arg0, arg19);
        if (arg1 == 2) {
            assert!(arg2 <= 20171231, 3);
        } else if (arg1 == 1) {
            assert!(arg2 > 20171231, 4);
        };
        0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::pricing_guard::validate_quote(arg11, arg7, arg8, arg19, arg20);
        let v1 = if (arg1 == 1) {
            0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::config_registry::today_fee_usd(arg10)
        } else {
            0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::config_registry::nostalgia_fee_usd(arg10)
        };
        let v2 = 0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::pricing_guard::usd_cents_to_sui_min_coins(arg10, arg17, arg18, arg19, v1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg9) >= v2, 1);
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg9);
        if (v3 > v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg9, v3 - v2, arg20), arg0);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg9, 0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::config_registry::dev_addr(arg10));
        0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::pol_treasury::deposit(arg13, 0x2::coin::split<0x2::sui::SUI>(&mut arg9, 0x2::coin::value<0x2::sui::SUI>(&arg9) * 2500 / 10000, arg20));
        let v4 = 0;
        let v5 = 0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::config_registry::dev_addr(arg10);
        let v6 = 0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::config_registry::dev_tvyn_ratio_bps(arg10);
        0x1::option::none<0x2::object::ID>();
        let v7 = if (arg1 == 1) {
            let v8 = if (v0) {
                0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::config_registry::reward_today_immediate(arg10)
            } else {
                0
            };
            if (v8 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::tvyn::TVYN>>(0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::tvyn::mint_for_protocol(arg12, v8, arg20), arg0);
                v4 = v8;
                let v9 = v8 * v6 / 10000;
                if (v9 > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::tvyn::TVYN>>(0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::tvyn::mint_for_protocol(arg12, v9, arg20), v5);
                };
            };
            if (arg4) {
                let v10 = 0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::anniversary_vault::mint_ticket(arg2, arg3, arg5, arg6, arg0, 0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::config_registry::default_royalty_bps(arg10), v0, arg19, arg20);
                let v11 = 0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::anniversary_vault::ticket_id(&v10);
                0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::memory_ledger::note_today(arg15, v11, arg0, arg2);
                0x2::transfer::public_transfer<0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::anniversary_vault::Today365>(v10, arg0);
                0x1::option::some<0x2::object::ID>(v11)
            } else {
                let v12 = 0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::simple_memory::mint(0x2::clock::timestamp_ms(arg19), arg0, 0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::config_registry::default_royalty_bps(arg10), arg20);
                0x2::transfer::public_transfer<0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::simple_memory::SimpleMemory>(v12, arg0);
                0x1::option::some<0x2::object::ID>(0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::simple_memory::id(&v12))
            }
        } else {
            let v13 = if (v0) {
                0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::config_registry::reward_nostalgia_base(arg10)
            } else {
                0
            };
            let v14 = 0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::timate_params::reward_per_mate_tvyn(arg16);
            if (v13 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::tvyn::TVYN>>(0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::tvyn::mint_for_protocol(arg12, v13, arg20), arg0);
                v4 = v13;
                let v15 = v13 * v6 / 10000;
                if (v15 > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::tvyn::TVYN>>(0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::tvyn::mint_for_protocol(arg12, v15, arg20), v5);
                };
            };
            let v16 = ((arg2 / 10000) as u64);
            let v7 = if (arg4) {
                let v17 = 0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::nostalgia_ticket::mint_ticket((v16 as u16), arg3, arg5, arg6, arg0, 0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::config_registry::default_royalty_bps(arg10), 0x2::clock::timestamp_ms(arg19), arg20);
                0x2::transfer::public_transfer<0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::nostalgia_ticket::NostalgiaTicket>(v17, arg0);
                0x1::option::some<0x2::object::ID>(0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::nostalgia_ticket::ticket_id(&v17))
            } else {
                let v18 = 0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::simple_memory::mint(0x2::clock::timestamp_ms(arg19), arg0, 0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::config_registry::default_royalty_bps(arg10), arg20);
                0x2::transfer::public_transfer<0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::simple_memory::SimpleMemory>(v18, arg0);
                0x1::option::some<0x2::object::ID>(0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::simple_memory::id(&v18))
            };
            let v19 = 0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::memory_ledger::pair_or_wait_nostalgia(arg15, arg0, v16);
            if (0x1::option::is_some<address>(&v19)) {
                let v20 = 0x1::option::extract<address>(&mut v19);
                if (v14 > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::tvyn::TVYN>>(0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::tvyn::mint_for_protocol(arg12, v14, arg20), arg0);
                    0x2::transfer::public_transfer<0x2::coin::Coin<0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::tvyn::TVYN>>(0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::tvyn::mint_for_protocol(arg12, v14, arg20), v20);
                    v4 = v4 + v14;
                    let v21 = v14 * 2 * v6 / 10000;
                    if (v21 > 0) {
                        0x2::transfer::public_transfer<0x2::coin::Coin<0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::tvyn::TVYN>>(0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::tvyn::mint_for_protocol(arg12, v21, arg20), v5);
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

