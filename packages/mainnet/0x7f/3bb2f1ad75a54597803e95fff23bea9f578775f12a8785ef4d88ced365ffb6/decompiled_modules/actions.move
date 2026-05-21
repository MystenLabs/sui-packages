module 0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::actions {
    struct UnstakeTicketCreated has copy, drop {
        market_core_id: 0x2::object::ID,
        owner: address,
        operation: u8,
        hasui_amount: u64,
        expected_sui_amount: u64,
    }

    fun assert_adapter(arg0: &0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::MarketCore<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg1: &0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter::HaedalHasuiAdapter) {
        assert!(0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::adapter_id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg0) == 0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter::id(arg1), 65);
        0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter::assert_asset<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg1);
    }

    fun assert_min_sui_out(arg0: u64, arg1: u64) {
        assert!(arg0 >= arg1, 66);
    }

    fun assert_treasury(arg0: &0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::MarketCore<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg1: &0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::treasury::Treasury<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>) {
        assert!(0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::treasury_id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg0) == 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::treasury::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg1), 176);
    }

    public fun claim_yield(arg0: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::YTObject, arg1: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::SplitEscrow<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg2: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::MarketCore<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: &0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::treasury::Treasury<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg4: &mut 0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter::HaedalHasuiAdapter, arg5: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg6: &0x2::clock::Clock, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert_adapter(arg2, arg4);
        assert_treasury(arg2, arg3);
        let v0 = 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg1);
        assert!(0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::escrow_id(arg0) == v0, 67);
        let v1 = refresh_and_observe(arg4, arg5, arg6);
        let v2 = 0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter::mint_auth();
        let (v3, v4, v5, v6) = if (0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::is_pt_consumed<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg1)) {
            let v7 = 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::drain_yt_after_pt_closed<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter::HAEDAL_AUTH>(arg1, arg2, &v2);
            let v8 = 0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v7);
            (v7, v8, v8, false)
        } else {
            0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::yield_out_into_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::realize_yield_capped<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter::HAEDAL_AUTH>(arg1, arg2, &v2, v1, arg6))
        };
        let v9 = v3;
        let (_, v11) = realize_ticket(arg2, arg4, v9, arg5, arg6, 2, arg7, arg8);
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::set_yield_debt<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter::HAEDAL_AUTH>(arg0, arg2, &v2, v1);
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::emit_yield_claimed_for_adapter<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter::HAEDAL_AUTH>(arg2, &v2, v0, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::id(arg0), 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::yield_debt(arg0), v1, 0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v9), v11, v5, v4, v6, 0);
    }

    public fun collect_yield_begin<T0>(arg0: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::YTVault<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T0>, arg1: &0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::MarketCore<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg2: &mut 0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter::HaedalHasuiAdapter, arg3: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::CollectReceipt<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        assert_adapter(arg1, arg2);
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::assert_registered_yt_vault<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg1, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T0>(arg0));
        let v0 = 0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter::mint_auth();
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::begin_collect_yield<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T0, 0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter::HAEDAL_AUTH>(arg0, arg1, &v0, arg4, refresh_and_observe(arg2, arg3, arg4), arg5)
    }

    public fun collect_yield_cancel<T0>(arg0: 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::CollectReceipt<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg1: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::YTVault<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T0>, arg2: &0x2::clock::Clock) {
        let v0 = 0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter::mint_auth();
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::cancel_collect_yield<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T0, 0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter::HAEDAL_AUTH>(arg0, arg1, &v0, arg2);
    }

    public fun collect_yield_finalize<T0>(arg0: 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::CollectReceipt<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg1: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::YTVault<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T0>, arg2: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::MarketCore<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: &0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::treasury::Treasury<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg4: &mut 0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter::HaedalHasuiAdapter, arg5: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg6: &0x2::clock::Clock, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        abort 193
    }

    public fun collect_yield_step<T0>(arg0: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::CollectReceipt<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg1: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::YTVault<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T0>, arg2: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::MarketCore<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::SplitEscrow<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock) {
        let v0 = 0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter::mint_auth();
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::assert_registered_yt_vault<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg2, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T0>(arg1));
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::collect_step<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T0, 0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter::HAEDAL_AUTH>(arg0, arg1, arg2, arg3, arg4, &v0, arg5);
    }

    public fun combine(arg0: 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_object::PTObject, arg1: 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::YTObject, arg2: 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::SplitEscrow<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::MarketCore<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg4: &0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::treasury::Treasury<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg5: &mut 0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter::HaedalHasuiAdapter, arg6: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg7: &0x2::clock::Clock, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        assert_adapter(arg3, arg5);
        assert_treasury(arg3, arg4);
        let v0 = refresh_and_observe(arg5, arg6, arg7);
        let v1 = 0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter::mint_auth();
        let (v2, v3) = 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::combine::combine<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter::HAEDAL_AUTH>(arg2, arg3, arg0, arg1, &v1, v0, arg7);
        let v4 = v2;
        let (_, v6) = realize_ticket(arg3, arg5, v3, arg6, arg7, 1, arg8, arg9);
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::emit_combine_for_adapter<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter::HAEDAL_AUTH>(arg3, &v1, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&arg2), 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_object::id(&arg0), 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::id(&arg1), 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_object::notional(&arg0), v6, 0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v4), 0);
        0x2::coin::from_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v4, arg9)
    }

    public fun deposit_yt<T0>(arg0: 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::YTObject, arg1: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::SplitEscrow<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg2: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::YTVault<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T0>, arg3: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::MarketCore<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg4: &0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::treasury::Treasury<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg5: &mut 0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter::HaedalHasuiAdapter, arg6: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg7: &0x2::clock::Clock, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::VaultShare<T0> {
        assert_adapter(arg3, arg5);
        assert_treasury(arg3, arg4);
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::assert_registered_yt_vault<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg3, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T0>(arg2));
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::assert_entry_open<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg3, 0x2::clock::timestamp_ms(arg7));
        assert!(0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::escrow_id(&arg0) == 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg1), 67);
        let v0 = refresh_and_observe(arg5, arg6, arg7);
        let v1 = 0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter::mint_auth();
        let (v2, _, _, _) = 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::yield_out_into_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::realize_yield_capped<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter::HAEDAL_AUTH>(arg1, arg3, &v1, v0, arg7));
        let (_, v7) = realize_ticket(arg3, arg5, v2, arg6, arg7, 5, arg8, arg9);
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::set_yield_debt<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter::HAEDAL_AUTH>(&mut arg0, arg3, &v1, v0);
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::deposit_yt_primitive<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T0, 0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter::HAEDAL_AUTH>(arg0, arg1, arg2, arg3, v7, 0, &v1, arg7, arg9)
    }

    public fun destroy_spent_yt(arg0: 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::YTObject, arg1: &0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::SplitEscrow<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg2: &0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::MarketCore<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>) {
        assert!(0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::market_core_id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg1) == 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg2), 68);
        assert!(0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::market_core_id(&arg0) == 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg2), 68);
        assert!(0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::escrow_id(&arg0) == 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg1), 67);
        assert!(0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::is_yt_consumed<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg1), 69);
        let v0 = 0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter::mint_auth();
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::destroy<0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter::HAEDAL_AUTH>(arg0, &v0);
    }

    fun realize_ticket(arg0: &0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::MarketCore<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg1: &0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter::HaedalHasuiAdapter, arg2: 0x2::balance::Balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg4: &0x2::clock::Clock, arg5: u8, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let (v0, v1) = 0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter::request_unstake_delay_internal(arg1, arg2, arg3, arg4, arg7);
        assert_min_sui_out(v1, arg6);
        if (v0 > 0 && v1 > 0) {
            let v2 = UnstakeTicketCreated{
                market_core_id      : 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg0),
                owner               : 0x2::tx_context::sender(arg7),
                operation           : arg5,
                hasui_amount        : v0,
                expected_sui_amount : v1,
            };
            0x2::event::emit<UnstakeTicketCreated>(v2);
        };
        (v0, v1)
    }

    public fun redeem_pt_direct(arg0: 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_object::PTObject, arg1: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::SplitEscrow<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg2: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::MarketCore<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: &0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::treasury::Treasury<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg4: &mut 0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter::HaedalHasuiAdapter, arg5: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg6: &0x2::clock::Clock, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert_adapter(arg2, arg4);
        assert_treasury(arg2, arg3);
        let v0 = 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg1);
        assert!(0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_object::escrow_id(&arg0) == v0, 67);
        let v1 = refresh_and_observe(arg4, arg5, arg6);
        let v2 = 0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter::mint_auth();
        let (_, v4) = realize_ticket(arg2, arg4, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::close_pt_side<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter::HAEDAL_AUTH>(arg1, arg2, &v2, arg6, v1), arg5, arg6, 3, arg7, arg8);
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_object::destroy<0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter::HAEDAL_AUTH>(arg0, &v2);
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::emit_pt_redeemed_direct_for_adapter<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter::HAEDAL_AUTH>(arg2, &v2, v0, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_object::id(&arg0), v4, 0);
    }

    public fun redeem_pt_vault_step<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_vault::PTVault<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T0>, arg2: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::SplitEscrow<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::MarketCore<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg4: &0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::treasury::Treasury<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg5: &mut 0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter::HaedalHasuiAdapter, arg6: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg7: &0x2::clock::Clock, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert_adapter(arg3, arg5);
        assert_treasury(arg3, arg4);
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::assert_registered_pt_vault<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg3, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_vault::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T0>(arg1));
        let v0 = refresh_and_observe(arg5, arg6, arg7);
        let v1 = 0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter::mint_auth();
        let v2 = 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_vault::redeem_step<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T0, 0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter::HAEDAL_AUTH>(arg0, arg1, arg3, arg2, &v1, arg7, v0, arg9);
        let (_, v4) = realize_ticket(arg3, arg5, v2, arg6, arg7, 4, arg8, arg9);
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::emit_pt_redeemed_from_vault_for_adapter<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter::HAEDAL_AUTH>(arg3, &v1, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_vault::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T0>(arg1), 0x2::coin::value<T0>(arg0) - 0x2::coin::value<T0>(arg0), 0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v2), 1, v4, 0);
    }

    fun refresh_and_observe(arg0: &mut 0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter::HaedalHasuiAdapter, arg1: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: &0x2::clock::Clock) : u128 {
        0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter::refresh_yield_index(arg0, arg1, arg2);
        0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter::observe_yield_index(arg0, arg2)
    }

    public fun split(arg0: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::MarketCore<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg1: &mut 0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter::HaedalHasuiAdapter, arg2: 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_object::PTObject, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::YTObject) {
        assert_adapter(arg0, arg1);
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::assert_entry_open<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg0, 0x2::clock::timestamp_ms(arg4));
        let v0 = refresh_and_observe(arg1, arg3, arg4);
        let v1 = 0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter::mint_auth();
        let v2 = 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::new<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter::HAEDAL_AUTH>(arg0, &v1, 0x2::coin::into_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg2), v0, arg5);
        let v3 = 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v2);
        let v4 = 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::notional<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v2);
        let v5 = 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_object::new<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter::HAEDAL_AUTH>(arg0, &v1, v3, v4, v0, arg5);
        let v6 = 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::new<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter::HAEDAL_AUTH>(arg0, &v1, v3, v4, v0, arg5);
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::emit_split_for_adapter<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter::HAEDAL_AUTH>(arg0, &v1, v3, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_object::id(&v5), 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::id(&v6), v4, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::max_yield_extractable_sy<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v2), v0);
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::split_escrow::share<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v2);
        (v5, v6)
    }

    // decompiled from Move bytecode v7
}

