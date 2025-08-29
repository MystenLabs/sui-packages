module 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::order {
    struct OrderAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct CoordinatorCap has store, key {
        id: 0x2::object::UID,
    }

    struct OrderManager<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        admin: 0x2::object::ID,
        note_counter: u64,
        notes: 0x2::table::Table<u64, StoredNote>,
        settlement_infos: 0x2::table::Table<u64, 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::SettlementInfo>,
        taker_locked_balances: 0x2::table::Table<address, u64>,
        maker_locked_balances: 0x2::table::Table<MakerAssetKey, u64>,
        is_note_settled: 0x2::table::Table<u64, bool>,
        vault_order_cap: 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::vault::OrderCap,
        maker_order_cap: 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::maker_vault::MakerOrderCap,
        treasury: address,
        fee_info: 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::FeeInfo,
    }

    struct StoredNote has store {
        note: 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::Note,
        created_at: u64,
    }

    struct MakerAssetKey has copy, drop, store {
        maker: address,
        asset: 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::TradableAsset,
    }

    struct SettlementAction has drop {
        status: 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::NoteStatus,
        payout: u64,
        fee: u64,
        balance_change: u64,
        taker_gains: bool,
    }

    struct NoteCreated has copy, drop {
        note_id: u64,
        taker: address,
        maker: address,
        asset: 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::TradableAsset,
        amount: u64,
        expiry_time: u64,
    }

    struct NoteSettled has copy, drop {
        note_id: u64,
        status: 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::NoteStatus,
        settlement_price: u64,
        payout: u64,
        fee: u64,
    }

    struct TakerFeePercentageChanged has copy, drop {
        taker_fee_percentage: u64,
    }

    struct MakerFeePercentageChanged has copy, drop {
        maker_fee_percentage: u64,
    }

    fun calculate_fee(arg0: u64, arg1: 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::Actor, arg2: &0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::FeeInfo) : u64 {
        if (0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::is_actor_maker(&arg1)) {
            (((arg0 as u256) * (0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::fee_info_maker_percentage(arg2) as u256) / (0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::max_fee_percentage() as u256)) as u64)
        } else {
            (((arg0 as u256) * (0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::fee_info_taker_percentage(arg2) as u256) / (0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::max_fee_percentage() as u256)) as u64)
        }
    }

    public fun create_note<T0, T1>(arg0: &CoordinatorCap, arg1: &mut OrderManager<T0>, arg2: &mut 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::vault::Vault<T0>, arg3: &mut 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::maker_vault::MakerVault<T0, T1>, arg4: 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::Note, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg1.version == 1, 13906835093468151836);
        let v0 = 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::note_amount(&arg4);
        let v1 = 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::note_win_payout(&arg4);
        let v2 = 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::note_expiry_time(&arg4);
        let v3 = 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::note_taker(&arg4);
        let v4 = 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::note_maker(&arg4);
        let v5 = 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::note_asset(&arg4);
        assert!(v0 > 0, 13906835145006186500);
        assert!(v3 != @0x0, 13906835149301153796);
        assert!(v4 != @0x0, 13906835153596121092);
        assert!(v2 > 0x2::clock::timestamp_ms(arg5), 13906835157891874832);
        assert!(v1 > v0, 13906835170776907794);
        assert!(0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::note_refund_payout(&arg4) <= v0, 13906835175071875090);
        let v6 = 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::note_almost_win_payout(&arg4);
        assert!(v6 > 0 && v6 <= v1, 13906835192251744274);
        assert!(0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::note_almost_win_spread(&arg4) <= 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::note_spread(&arg4), 13906835196546973718);
        assert!(0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::note_start_time(&arg4) <= v2, 13906835200841547792);
        let v7 = v1 - v0;
        assert!(taker_withdrawable_balance<T0>(arg1, arg2, v3) >= v0, 13906835230906056716);
        assert!(maker_withdrawable_balance<T0, T1>(arg1, arg3, v4, *v5) >= v7, 13906835235201155086);
        let v8 = arg1.note_counter;
        arg1.note_counter = arg1.note_counter + 1;
        let v9 = StoredNote{
            note       : arg4,
            created_at : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::table::add<u64, StoredNote>(&mut arg1.notes, v8, v9);
        0x2::table::add<u64, bool>(&mut arg1.is_note_settled, v8, false);
        update_taker_locked_balance<T0>(arg1, v3, v0, true);
        update_maker_locked_balance<T0>(arg1, v4, *v5, v7, true);
        let v10 = NoteCreated{
            note_id     : v8,
            taker       : v3,
            maker       : v4,
            asset       : *v5,
            amount      : v0,
            expiry_time : v2,
        };
        0x2::event::emit<NoteCreated>(v10);
        v8
    }

    fun determine_settlement_outcome(arg0: &0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::Note, arg1: u64, arg2: &0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::FeeInfo) : SettlementAction {
        let v0 = 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::note_starting_price(arg0);
        let v1 = 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::note_direction(arg0);
        let v2 = 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::note_amount(arg0);
        let v3 = 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::note_win_payout(arg0);
        let v4 = 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::note_almost_win_payout(arg0);
        let (v5, v6) = if (0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::is_direction_up(&v1)) {
            if (arg1 > v0 + 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::note_spread(arg0)) {
                (0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::note_status_win(), v3)
            } else if (arg1 > v0 + 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::note_almost_win_spread(arg0)) {
                (0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::note_status_almost_win(), v4)
            } else if (arg1 > v0) {
                (0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::note_status_loss(), v2)
            } else {
                (0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::note_status_refund(), 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::note_refund_payout(arg0))
            }
        } else if (arg1 < v0 - 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::note_spread(arg0)) {
            (0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::note_status_win(), v3)
        } else {
            let (v7, v8) = if (arg1 < v0 - 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::note_almost_win_spread(arg0)) {
                (v4, 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::note_status_almost_win())
            } else {
                let (v9, v10) = if (arg1 < v0) {
                    (0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::note_status_loss(), v2)
                } else {
                    (0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::note_status_refund(), 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::note_refund_payout(arg0))
                };
                (v10, v9)
            };
            (v8, v7)
        };
        let v11 = v5;
        if (0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::is_note_status_win(&v11)) {
            let v13 = v3 - v2;
            SettlementAction{status: v11, payout: v6, fee: calculate_fee(v13, 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::actor_taker(), arg2), balance_change: v13, taker_gains: true}
        } else if (0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::is_note_status_loss(&v11)) {
            SettlementAction{status: v11, payout: v6, fee: calculate_fee(v2, 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::actor_maker(), arg2), balance_change: v2, taker_gains: false}
        } else if (0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::is_note_status_almost_win(&v11)) {
            if (v4 > v2) {
                let v14 = v4 - v2;
                SettlementAction{status: v11, payout: v6, fee: calculate_fee(v14, 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::actor_taker(), arg2), balance_change: v14, taker_gains: true}
            } else {
                let v15 = v2 - v4;
                SettlementAction{status: v11, payout: v6, fee: calculate_fee(v15, 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::actor_maker(), arg2), balance_change: v15, taker_gains: false}
            }
        } else {
            let v16 = if (v2 > v6) {
                v2 - v6
            } else {
                0
            };
            SettlementAction{status: v11, payout: v6, fee: 0, balance_change: v16, taker_gains: false}
        }
    }

    public fun get_note<T0>(arg0: &OrderManager<T0>, arg1: u64) : &0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::Note {
        assert!(0x2::table::contains<u64, StoredNote>(&arg0.notes, arg1), 13906836132848795654);
        &0x2::table::borrow<u64, StoredNote>(&arg0.notes, arg1).note
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OrderAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OrderAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun initialize<T0>(arg0: &OrderAdminCap, arg1: 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::vault::OrderCap, arg2: 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::maker_vault::MakerOrderCap, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : CoordinatorCap {
        validate_address(arg3);
        let v0 = CoordinatorCap{id: 0x2::object::new(arg4)};
        let v1 = OrderManager<T0>{
            id                    : 0x2::object::new(arg4),
            version               : 1,
            admin                 : 0x2::object::id<OrderAdminCap>(arg0),
            note_counter          : 0,
            notes                 : 0x2::table::new<u64, StoredNote>(arg4),
            settlement_infos      : 0x2::table::new<u64, 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::SettlementInfo>(arg4),
            taker_locked_balances : 0x2::table::new<address, u64>(arg4),
            maker_locked_balances : 0x2::table::new<MakerAssetKey, u64>(arg4),
            is_note_settled       : 0x2::table::new<u64, bool>(arg4),
            vault_order_cap       : arg1,
            maker_order_cap       : arg2,
            treasury              : arg3,
            fee_info              : 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::new_fee_info(0, 0),
        };
        0x2::transfer::share_object<OrderManager<T0>>(v1);
        v0
    }

    public fun is_note_settled<T0>(arg0: &OrderManager<T0>, arg1: u64) : bool {
        0x2::table::contains<u64, bool>(&arg0.is_note_settled, arg1) && *0x2::table::borrow<u64, bool>(&arg0.is_note_settled, arg1)
    }

    public fun maker_locked_balance<T0>(arg0: &OrderManager<T0>, arg1: address, arg2: 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::TradableAsset) : u64 {
        let v0 = MakerAssetKey{
            maker : arg1,
            asset : arg2,
        };
        if (0x2::table::contains<MakerAssetKey, u64>(&arg0.maker_locked_balances, v0)) {
            *0x2::table::borrow<MakerAssetKey, u64>(&arg0.maker_locked_balances, v0)
        } else {
            0
        }
    }

    public fun maker_withdraw<T0, T1>(arg0: &mut OrderManager<T0>, arg1: &mut 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::maker_vault::MakerVault<T0, T1>, arg2: 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::TradableAsset, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.version == 1, 13906835909511938076);
        let v0 = 0x2::tx_context::sender(arg4);
        0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::maker_vault::withdraw_collateral<T0, T1>(&arg0.maker_order_cap, arg1, v0, arg2, maker_locked_balance<T0>(arg0, v0, arg2), arg3, arg4)
    }

    public fun maker_withdrawable_balance<T0, T1>(arg0: &OrderManager<T0>, arg1: &0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::maker_vault::MakerVault<T0, T1>, arg2: address, arg3: 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::TradableAsset) : u64 {
        0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::maker_vault::get_withdrawable_balance_with_locked<T0, T1>(&arg0.maker_order_cap, arg1, arg2, &arg3, maker_locked_balance<T0>(arg0, arg2, arg3))
    }

    entry fun migrate<T0>(arg0: &mut OrderManager<T0>, arg1: &OrderAdminCap) {
        assert!(arg0.admin == 0x2::object::id<OrderAdminCap>(arg1), 13906835651813638168);
        assert!(arg0.version < 1, 13906835656108736538);
        arg0.version = 1;
    }

    public fun note_counter<T0>(arg0: &OrderManager<T0>) : u64 {
        arg0.note_counter
    }

    fun process_settlement<T0, T1>(arg0: &mut OrderManager<T0>, arg1: &mut 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::vault::Vault<T0>, arg2: &mut 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::maker_vault::MakerVault<T0, T1>, arg3: &0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::Note, arg4: SettlementAction, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::note_taker(arg3);
        let v1 = 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::note_maker(arg3);
        let v2 = *0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::note_asset(arg3);
        let v3 = 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::note_amount(arg3);
        update_taker_locked_balance<T0>(arg0, v0, v3, false);
        update_maker_locked_balance<T0>(arg0, v1, v2, 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::note_win_payout(arg3) - v3, false);
        if (arg4.balance_change > 0) {
            if (arg4.taker_gains) {
                0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::vault::adjust_taker_balance<T0>(&arg0.vault_order_cap, arg1, v0, arg4.balance_change, true);
                0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::maker_vault::adjust_maker_balance<T0, T1>(&arg0.maker_order_cap, arg2, v1, v2, arg4.balance_change, false);
                0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::vault::add_funds<T0>(&arg0.vault_order_cap, arg1, 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::maker_vault::transfer_to_taker_vault<T0, T1>(&arg0.maker_order_cap, arg2, arg4.balance_change, arg5));
            } else {
                0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::vault::adjust_taker_balance<T0>(&arg0.vault_order_cap, arg1, v0, arg4.balance_change, false);
                0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::maker_vault::adjust_maker_balance<T0, T1>(&arg0.maker_order_cap, arg2, v1, v2, arg4.balance_change, true);
                0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::maker_vault::add_funds<T0, T1>(&arg0.maker_order_cap, arg2, 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::vault::transfer_to_maker_vault<T0>(&arg0.vault_order_cap, arg1, arg4.balance_change, arg5));
            };
        };
        if (arg4.fee > 0) {
            if (arg4.taker_gains) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::vault::transfer_fee_to_treasury<T0>(&arg0.vault_order_cap, arg1, v0, arg4.fee, arg5), arg0.treasury);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::maker_vault::transfer_fee_to_treasury<T0, T1>(&arg0.maker_order_cap, arg2, v1, v2, arg4.fee, arg5), arg0.treasury);
            };
        };
    }

    public fun set_maker_fee_percentage<T0>(arg0: &OrderAdminCap, arg1: &mut OrderManager<T0>, arg2: u64) {
        assert!(arg1.version == 1, 13906835776367951900);
        assert!(arg2 <= 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::max_fee_percentage(), 13906835780662394900);
        arg1.fee_info = 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::new_fee_info(0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::fee_info_taker_percentage(&arg1.fee_info), arg2);
        let v0 = MakerFeePercentageChanged{maker_fee_percentage: arg2};
        0x2::event::emit<MakerFeePercentageChanged>(v0);
    }

    public fun set_taker_fee_percentage<T0>(arg0: &OrderAdminCap, arg1: &mut OrderManager<T0>, arg2: u64) {
        assert!(arg1.version == 1, 13906835699058540572);
        assert!(arg2 <= 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::max_fee_percentage(), 13906835703352983572);
        arg1.fee_info = 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::new_fee_info(arg2, 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::fee_info_maker_percentage(&arg1.fee_info));
        let v0 = TakerFeePercentageChanged{taker_fee_percentage: arg2};
        0x2::event::emit<TakerFeePercentageChanged>(v0);
    }

    public fun settle_note<T0, T1>(arg0: &CoordinatorCap, arg1: &mut OrderManager<T0>, arg2: &mut 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::vault::Vault<T0>, arg3: &mut 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::maker_vault::MakerVault<T0, T1>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 13906835419885666332);
        assert!(0x2::table::contains<u64, StoredNote>(&arg1.notes, arg4), 13906835424179191814);
        assert!(!*0x2::table::borrow<u64, bool>(&arg1.is_note_settled, arg4), 13906835437064224776);
        let v0 = 0x2::table::borrow<u64, StoredNote>(&arg1.notes, arg4).note;
        assert!(0x2::clock::timestamp_ms(arg6) >= 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::note_expiry_time(&v0), 13906835462834159626);
        let v1 = determine_settlement_outcome(&v0, arg5, &arg1.fee_info);
        0x2::table::remove<u64, bool>(&mut arg1.is_note_settled, arg4);
        0x2::table::add<u64, bool>(&mut arg1.is_note_settled, arg4, true);
        0x2::table::add<u64, 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::SettlementInfo>(&mut arg1.settlement_infos, arg4, 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::new_settlement_info(arg5, 0x2::clock::timestamp_ms(arg6)));
        process_settlement<T0, T1>(arg1, arg2, arg3, &v0, v1, arg7);
        let v2 = NoteSettled{
            note_id          : arg4,
            status           : v1.status,
            settlement_price : arg5,
            payout           : v1.payout,
            fee              : v1.fee,
        };
        0x2::event::emit<NoteSettled>(v2);
    }

    public fun taker_locked_balance<T0>(arg0: &OrderManager<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.taker_locked_balances, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.taker_locked_balances, arg1)
        } else {
            0
        }
    }

    public fun taker_withdraw<T0>(arg0: &mut OrderManager<T0>, arg1: &mut 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::vault::Vault<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.version == 1, 13906835853677363228);
        let v0 = 0x2::tx_context::sender(arg3);
        0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::vault::withdraw<T0>(&arg0.vault_order_cap, arg1, v0, arg2, taker_locked_balance<T0>(arg0, v0), arg3)
    }

    public fun taker_withdrawable_balance<T0>(arg0: &OrderManager<T0>, arg1: &0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::vault::Vault<T0>, arg2: address) : u64 {
        0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::vault::get_withdrawable_balance_with_locked<T0>(&arg0.vault_order_cap, arg1, arg2, taker_locked_balance<T0>(arg0, arg2))
    }

    public fun treasury<T0>(arg0: &OrderManager<T0>) : address {
        arg0.treasury
    }

    fun update_maker_locked_balance<T0>(arg0: &mut OrderManager<T0>, arg1: address, arg2: 0x4f0c9fc1d7b5bfad2217306610d62507c8b2ec83a6ffea8aa20baf5097c07ca8::types::TradableAsset, arg3: u64, arg4: bool) {
        let v0 = MakerAssetKey{
            maker : arg1,
            asset : arg2,
        };
        let v1 = if (0x2::table::contains<MakerAssetKey, u64>(&arg0.maker_locked_balances, v0)) {
            0x2::table::remove<MakerAssetKey, u64>(&mut arg0.maker_locked_balances, v0)
        } else {
            0
        };
        let v2 = if (arg4) {
            v1 + arg3
        } else if (v1 >= arg3) {
            v1 - arg3
        } else {
            0
        };
        if (v2 > 0) {
            0x2::table::add<MakerAssetKey, u64>(&mut arg0.maker_locked_balances, v0, v2);
        };
    }

    fun update_taker_locked_balance<T0>(arg0: &mut OrderManager<T0>, arg1: address, arg2: u64, arg3: bool) {
        let v0 = if (0x2::table::contains<address, u64>(&arg0.taker_locked_balances, arg1)) {
            0x2::table::remove<address, u64>(&mut arg0.taker_locked_balances, arg1)
        } else {
            0
        };
        let v1 = if (arg3) {
            v0 + arg2
        } else if (v0 >= arg2) {
            v0 - arg2
        } else {
            0
        };
        if (v1 > 0) {
            0x2::table::add<address, u64>(&mut arg0.taker_locked_balances, arg1, v1);
        };
    }

    public fun validate_address(arg0: address) {
        assert!(arg0 != @0x0, 13906836253107617794);
    }

    // decompiled from Move bytecode v6
}

