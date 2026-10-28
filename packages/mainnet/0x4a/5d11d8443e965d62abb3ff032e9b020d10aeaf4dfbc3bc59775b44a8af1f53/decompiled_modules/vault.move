module 0x4a5d11d8443e965d62abb3ff032e9b020d10aeaf4dfbc3bc59775b44a8af1f53::vault {
    struct PositionKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct AutoLpPositionKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct LpVault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        partner_id: 0x1::option::Option<0x2::object::ID>,
        protocol_meme_residual: 0x2::balance::Balance<T0>,
        protocol_quote_residual: 0x2::balance::Balance<T1>,
        unpaid_protocol_meme: 0x2::balance::Balance<T0>,
        unpaid_protocol_quote: 0x2::balance::Balance<T1>,
        fee_split: 0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::allocation::FeeSplit,
        creator_meme: 0x2::balance::Balance<T0>,
        creator_quote: 0x2::balance::Balance<T1>,
        auto_lp_meme: 0x2::balance::Balance<T0>,
        auto_lp_quote: 0x2::balance::Balance<T1>,
        rewards_meme: 0x2::balance::Balance<T0>,
        rewards_quote: 0x2::balance::Balance<T1>,
        burn_quote: 0x2::balance::Balance<T1>,
        next_round: u64,
        last_checkpoint: 0x1::option::Option<u64>,
    }

    fun new<T0, T1, T2, T3: store + key>(arg0: &0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::launch::Launch<T0, T1>, arg1: &T2, arg2: 0x2::object::ID, arg3: T3, arg4: u128, arg5: 0x2::balance::Balance<T0>, arg6: 0x2::balance::Balance<T1>, arg7: &mut 0x2::tx_context::TxContext) : LpVault<T0, T1> {
        assert!(arg4 > 0, 13835904511732219911);
        let v0 = LpVault<T0, T1>{
            id                      : 0x2::object::new(arg7),
            pool_id                 : arg2,
            partner_id              : 0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::launch::partner_id<T0, T1>(arg0),
            protocol_meme_residual  : arg5,
            protocol_quote_residual : arg6,
            unpaid_protocol_meme    : 0x2::balance::zero<T0>(),
            unpaid_protocol_quote   : 0x2::balance::zero<T1>(),
            fee_split               : 0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::launch::lp_fee_split<T0, T1>(arg0),
            creator_meme            : 0x2::balance::zero<T0>(),
            creator_quote           : 0x2::balance::zero<T1>(),
            auto_lp_meme            : 0x2::balance::zero<T0>(),
            auto_lp_quote           : 0x2::balance::zero<T1>(),
            rewards_meme            : 0x2::balance::zero<T0>(),
            rewards_quote           : 0x2::balance::zero<T1>(),
            burn_quote              : 0x2::balance::zero<T1>(),
            next_round              : 0,
            last_checkpoint         : 0x1::option::none<u64>(),
        };
        let v1 = PositionKey<T2>{dummy_field: false};
        0x2::dynamic_object_field::add<PositionKey<T2>, T3>(&mut v0.id, v1, arg3);
        0x4a5d11d8443e965d62abb3ff032e9b020d10aeaf4dfbc3bc59775b44a8af1f53::blast_events::vault_created<T0, T1, T2>(0x2::object::uid_to_inner(&v0.id), arg2, 0x2::object::id<T3>(&arg3), 0x2::balance::value<T0>(&v0.protocol_meme_residual), 0x2::balance::value<T1>(&v0.protocol_quote_residual), arg4, v0.fee_split);
        v0
    }

    public(friend) fun pay<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(arg0, arg1), arg3), arg2);
        };
    }

    public(friend) fun assert_fee_split_update<T0, T1>(arg0: &LpVault<T0, T1>, arg1: &0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::launch::Launch<T0, T1>, arg2: &0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::creator_authority::CurveFeeCap<T0>, arg3: 0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::allocation::FeeSplit) {
        0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::launch::assert_curve_fee_cap<T0, T1>(arg1, arg2);
        assert!(arg3 != arg0.fee_split, 13835341132281806851);
    }

    public(friend) fun attach_auto_lp_position<T0, T1, T2, T3: store + key>(arg0: &mut LpVault<T0, T1>, arg1: &T2, arg2: T3) {
        let v0 = AutoLpPositionKey<T2>{dummy_field: false};
        0x2::dynamic_object_field::add<AutoLpPositionKey<T2>, T3>(&mut arg0.id, v0, arg2);
        0x4a5d11d8443e965d62abb3ff032e9b020d10aeaf4dfbc3bc59775b44a8af1f53::blast_events::auto_lp_position_opened(0x2::object::uid_to_inner(&arg0.id), 0x2::object::id<T3>(&arg2));
    }

    public(friend) fun auto_lp_position<T0, T1, T2, T3: store + key>(arg0: &LpVault<T0, T1>, arg1: &T2) : &T3 {
        let v0 = AutoLpPositionKey<T2>{dummy_field: false};
        0x2::dynamic_object_field::borrow<AutoLpPositionKey<T2>, T3>(&arg0.id, v0)
    }

    public(friend) fun auto_lp_position_mut<T0, T1, T2, T3: store + key>(arg0: &mut LpVault<T0, T1>, arg1: &T2) : &mut T3 {
        let v0 = AutoLpPositionKey<T2>{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<AutoLpPositionKey<T2>, T3>(&mut arg0.id, v0)
    }

    fun burn<T0>(arg0: &mut 0x2::coin_registry::Currency<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin_registry::is_supply_burn_only<T0>(arg0)) {
            0x2::coin_registry::burn_balance<T0>(arg0, arg1);
            return
        };
        let v0 = &mut arg1;
        pay<T0>(v0, 0x2::balance::value<T0>(&arg1), @0x0, arg2);
        0x2::balance::destroy_zero<T0>(arg1);
    }

    public(friend) fun burn_buyback<T0, T1>(arg0: &mut LpVault<T0, T1>, arg1: &mut 0x2::coin_registry::Currency<T0>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg2);
        assert!(v0 >= arg5, 13836466813145841675);
        burn<T0>(arg1, arg2, arg6);
        0x2::balance::join<T1>(&mut arg0.burn_quote, arg3);
        0x4a5d11d8443e965d62abb3ff032e9b020d10aeaf4dfbc3bc59775b44a8af1f53::blast_events::buyback_burned(0x2::object::uid_to_inner(&arg0.id), arg4 - 0x2::balance::value<T1>(&arg3), v0, 0x2::balance::value<T1>(&arg0.burn_quote));
    }

    public fun claim_creator_fees<T0, T1>(arg0: &mut LpVault<T0, T1>, arg1: &0x4a5d11d8443e965d62abb3ff032e9b020d10aeaf4dfbc3bc59775b44a8af1f53::blast_fun_migrators::PackageVersion, arg2: &0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::launch::Launch<T0, T1>, arg3: &0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::creator_authority::CurveFeeCap<T0>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x4a5d11d8443e965d62abb3ff032e9b020d10aeaf4dfbc3bc59775b44a8af1f53::blast_fun_migrators::assert_current(arg1);
        0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::launch::assert_curve_fee_cap<T0, T1>(arg2, arg3);
        assert!(0x2::balance::value<T0>(&arg0.creator_meme) > 0 || 0x2::balance::value<T1>(&arg0.creator_quote) > 0, 13835621542106759173);
        let v0 = 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.creator_meme), arg4);
        let v1 = 0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.creator_quote), arg4);
        0x4a5d11d8443e965d62abb3ff032e9b020d10aeaf4dfbc3bc59775b44a8af1f53::blast_events::creator_fees_claimed(0x2::object::uid_to_inner(&arg0.id), 0x2::coin::value<T0>(&v0), 0x2::coin::value<T1>(&v1));
        (v0, v1)
    }

    public fun claim_protocol_fees<T0, T1>(arg0: &mut LpVault<T0, T1>, arg1: &0x4a5d11d8443e965d62abb3ff032e9b020d10aeaf4dfbc3bc59775b44a8af1f53::blast_fun_migrators::PackageVersion, arg2: &0x4a27d816998b2ff015cf897a249c069c34859a09e789e56ad3a38992cf00d7ac::blast_acl::AdminWitness<0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::blast_fun_domain::TreasuryAdmin>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x4a5d11d8443e965d62abb3ff032e9b020d10aeaf4dfbc3bc59775b44a8af1f53::blast_fun_migrators::assert_current(arg1);
        assert!(0x2::balance::value<T0>(&arg0.protocol_meme_residual) > 0 || 0x2::balance::value<T1>(&arg0.protocol_quote_residual) > 0, 13835058321570136065);
        let v0 = 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.protocol_meme_residual), arg3);
        let v1 = 0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.protocol_quote_residual), arg3);
        0x4a5d11d8443e965d62abb3ff032e9b020d10aeaf4dfbc3bc59775b44a8af1f53::blast_events::protocol_fees_claimed<T0, T1>(0x2::object::uid_to_inner(&arg0.id), 0x2::tx_context::sender(arg3), 0x2::coin::value<T0>(&v0), 0x2::coin::value<T1>(&v1));
        (v0, v1)
    }

    public fun claim_protocol_lp_fees_with_partner<T0, T1>(arg0: &mut LpVault<T0, T1>, arg1: &0x4a5d11d8443e965d62abb3ff032e9b020d10aeaf4dfbc3bc59775b44a8af1f53::blast_fun_migrators::PackageVersion, arg2: &0x4a5d11d8443e965d62abb3ff032e9b020d10aeaf4dfbc3bc59775b44a8af1f53::lp_fee_policy::LpFeePolicy, arg3: &0x163a96aa9b88afe77e51febc195a9e0fa8534a6122bc09c6bd46d176c91a99f9::blast_partners::Partner, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x4a5d11d8443e965d62abb3ff032e9b020d10aeaf4dfbc3bc59775b44a8af1f53::blast_fun_migrators::assert_current(arg1);
        let v0 = 0x2::object::id<0x163a96aa9b88afe77e51febc195a9e0fa8534a6122bc09c6bd46d176c91a99f9::blast_partners::Partner>(arg3);
        assert!(0x1::option::contains<0x2::object::ID>(&arg0.partner_id, &v0), 13836747295985238029);
        if (0x2::balance::value<T0>(&arg0.unpaid_protocol_meme) == 0 && 0x2::balance::value<T1>(&arg0.unpaid_protocol_quote) == 0) {
            return
        };
        let v1 = 0x4a5d11d8443e965d62abb3ff032e9b020d10aeaf4dfbc3bc59775b44a8af1f53::lp_fee_policy::protocol_destination(arg2);
        let v2 = 0x2::balance::withdraw_all<T0>(&mut arg0.unpaid_protocol_meme);
        let v3 = 0x2::balance::withdraw_all<T1>(&mut arg0.unpaid_protocol_quote);
        let v4 = 0x163a96aa9b88afe77e51febc195a9e0fa8534a6122bc09c6bd46d176c91a99f9::blast_partners::pay<T0>(arg3, &mut v2, arg4, arg5);
        let v5 = 0x163a96aa9b88afe77e51febc195a9e0fa8534a6122bc09c6bd46d176c91a99f9::blast_partners::pay<T1>(arg3, &mut v3, arg4, arg5);
        pay_all<T0>(v2, v1, arg5);
        pay_all<T1>(v3, v1, arg5);
        0x4a5d11d8443e965d62abb3ff032e9b020d10aeaf4dfbc3bc59775b44a8af1f53::blast_events::protocol_lp_fees_claimed(0x2::object::uid_to_inner(&arg0.id), v1, 0x2::balance::value<T0>(&v2), 0x2::balance::value<T1>(&v3), v4, v5);
    }

    public(friend) fun create<T0, T1, T2, T3: store + key>(arg0: &0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::launch::Launch<T0, T1>, arg1: &T2, arg2: 0x2::object::ID, arg3: T3, arg4: u128, arg5: 0x2::balance::Balance<T0>, arg6: 0x2::balance::Balance<T1>, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<LpVault<T0, T1>>(new<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7));
    }

    public(friend) fun fund_round<T0, T1>(arg0: &mut LpVault<T0, T1>, arg1: u64, arg2: u64, arg3: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        arg0.next_round = arg0.next_round + 1;
        arg0.last_checkpoint = 0x1::option::some<u64>(arg1);
        (0x2::balance::split<T0>(&mut arg0.rewards_meme, arg2), 0x2::balance::split<T1>(&mut arg0.rewards_quote, arg3))
    }

    public(friend) fun has_auto_lp_position<T0, T1, T2>(arg0: &LpVault<T0, T1>, arg1: &T2) : bool {
        let v0 = AutoLpPositionKey<T2>{dummy_field: false};
        0x2::dynamic_object_field::exists<AutoLpPositionKey<T2>>(&arg0.id, v0)
    }

    public(friend) fun keep_auto_lp<T0, T1>(arg0: &mut LpVault<T0, T1>, arg1: u64, arg2: u64, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T0>(&mut arg0.auto_lp_meme, arg3);
        0x2::balance::join<T1>(&mut arg0.auto_lp_quote, arg4);
        if (arg1 == 0 && arg2 == 0) {
            return
        };
        0x4a5d11d8443e965d62abb3ff032e9b020d10aeaf4dfbc3bc59775b44a8af1f53::blast_events::auto_liquidity_added(0x2::object::uid_to_inner(&arg0.id), arg1, arg2, 0x2::balance::value<T0>(&arg0.auto_lp_meme), 0x2::balance::value<T1>(&arg0.auto_lp_quote));
    }

    public(friend) fun last_checkpoint<T0, T1>(arg0: &LpVault<T0, T1>) : 0x1::option::Option<u64> {
        arg0.last_checkpoint
    }

    public(friend) fun next_round<T0, T1>(arg0: &LpVault<T0, T1>) : u64 {
        arg0.next_round
    }

    fun pay_all<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0;
        pay<T0>(v0, 0x2::balance::value<T0>(&arg0), arg1, arg2);
        0x2::balance::destroy_zero<T0>(arg0);
    }

    fun pay_or_hold_protocol_lp_fees<T0, T1>(arg0: &mut LpVault<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: &0x4a5d11d8443e965d62abb3ff032e9b020d10aeaf4dfbc3bc59775b44a8af1f53::lp_fee_policy::LpFeePolicy, arg4: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<address> {
        if (0x1::option::is_some<0x2::object::ID>(&arg0.partner_id)) {
            0x2::balance::join<T0>(&mut arg0.unpaid_protocol_meme, arg1);
            0x2::balance::join<T1>(&mut arg0.unpaid_protocol_quote, arg2);
            return 0x1::option::none<address>()
        };
        let v0 = 0x4a5d11d8443e965d62abb3ff032e9b020d10aeaf4dfbc3bc59775b44a8af1f53::lp_fee_policy::protocol_destination(arg3);
        pay_all<T0>(arg1, v0, arg4);
        pay_all<T1>(arg2, v0, arg4);
        0x1::option::some<address>(v0)
    }

    public(friend) fun pool_id<T0, T1>(arg0: &LpVault<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    public(friend) fun position_mut<T0, T1, T2, T3: store + key>(arg0: &mut LpVault<T0, T1>, arg1: &T2) : &mut T3 {
        let v0 = PositionKey<T2>{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<PositionKey<T2>, T3>(&mut arg0.id, v0)
    }

    public(friend) fun rewards_balances<T0, T1>(arg0: &LpVault<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.rewards_meme), 0x2::balance::value<T1>(&arg0.rewards_quote))
    }

    public(friend) fun split_fees<T0, T1>(arg0: &mut LpVault<T0, T1>, arg1: &0x4a5d11d8443e965d62abb3ff032e9b020d10aeaf4dfbc3bc59775b44a8af1f53::lp_fee_policy::LpFeePolicy, arg2: &mut 0x2::coin_registry::Currency<T0>, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg3);
        let v1 = 0x2::balance::value<T1>(&arg4);
        if (v0 == 0 && v1 == 0) {
            0x2::balance::destroy_zero<T0>(arg3);
            0x2::balance::destroy_zero<T1>(arg4);
            return
        };
        let (v2, v3) = 0x4a5d11d8443e965d62abb3ff032e9b020d10aeaf4dfbc3bc59775b44a8af1f53::lp_fee_policy::shares<T0>(arg1);
        let v4 = 0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::bps::apply_up(v2, v0);
        let v5 = 0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::bps::apply_up(v3, v1);
        let (v6, v7, v8, v9, v10) = 0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::allocation::apportion_fee_split(&arg0.fee_split, v0 - v4);
        let v11 = v10;
        let (v12, v13, v14, v15, v16) = 0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::allocation::apportion_fee_split(&arg0.fee_split, v1 - v5);
        let v17 = v16;
        let v18 = *0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::allocation::recipients(&arg0.fee_split);
        let v19 = pay_or_hold_protocol_lp_fees<T0, T1>(arg0, 0x2::balance::split<T0>(&mut arg3, v4), 0x2::balance::split<T1>(&mut arg4, v5), arg1, arg5);
        0x2::balance::join<T0>(&mut arg0.creator_meme, 0x2::balance::split<T0>(&mut arg3, v6));
        0x2::balance::join<T1>(&mut arg0.creator_quote, 0x2::balance::split<T1>(&mut arg4, v12));
        0x2::balance::join<T0>(&mut arg0.auto_lp_meme, 0x2::balance::split<T0>(&mut arg3, v7));
        0x2::balance::join<T1>(&mut arg0.auto_lp_quote, 0x2::balance::split<T1>(&mut arg4, v13));
        0x2::balance::join<T0>(&mut arg0.rewards_meme, 0x2::balance::split<T0>(&mut arg3, v8));
        0x2::balance::join<T1>(&mut arg0.rewards_quote, 0x2::balance::split<T1>(&mut arg4, v14));
        burn<T0>(arg2, 0x2::balance::split<T0>(&mut arg3, v9), arg5);
        0x2::balance::join<T1>(&mut arg0.burn_quote, 0x2::balance::split<T1>(&mut arg4, v15));
        let v20 = 0;
        while (v20 < 0x1::vector::length<0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::allocation::Route>(&v18)) {
            let v21 = &mut arg3;
            pay<T0>(v21, *0x1::vector::borrow<u64>(&v11, v20), 0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::allocation::destination(0x1::vector::borrow<0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::allocation::Route>(&v18, v20)), arg5);
            let v22 = &mut arg4;
            pay<T1>(v22, *0x1::vector::borrow<u64>(&v17, v20), 0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::allocation::destination(0x1::vector::borrow<0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::allocation::Route>(&v18, v20)), arg5);
            v20 = v20 + 1;
        };
        0x2::balance::destroy_zero<T0>(arg3);
        0x2::balance::destroy_zero<T1>(arg4);
        0x4a5d11d8443e965d62abb3ff032e9b020d10aeaf4dfbc3bc59775b44a8af1f53::blast_events::fees_collected(0x2::object::uid_to_inner(&arg0.id), v0, v1, v19, v4, v5, v6, v12, v7, v13, v8, v14, v9, v15, v11, v17);
    }

    public(friend) fun take_auto_lp<T0, T1>(arg0: &mut LpVault<T0, T1>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        (0x2::balance::withdraw_all<T0>(&mut arg0.auto_lp_meme), 0x2::balance::withdraw_all<T1>(&mut arg0.auto_lp_quote))
    }

    public(friend) fun take_buyback_quote<T0, T1>(arg0: &mut LpVault<T0, T1>, arg1: &0x4a27d816998b2ff015cf897a249c069c34859a09e789e56ad3a38992cf00d7ac::blast_acl::AdminWitness<0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::blast_fun_domain::BuybackAdmin>, arg2: u64) : 0x2::balance::Balance<T1> {
        assert!(arg2 > 0 && arg2 <= 0x2::balance::value<T1>(&arg0.burn_quote), 13836185265154555913);
        0x2::balance::split<T1>(&mut arg0.burn_quote, arg2)
    }

    public(friend) fun update_fee_split<T0, T1>(arg0: &mut LpVault<T0, T1>, arg1: 0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::allocation::FeeSplit) {
        arg0.fee_split = arg1;
        0x4a5d11d8443e965d62abb3ff032e9b020d10aeaf4dfbc3bc59775b44a8af1f53::blast_events::fee_split_changed(0x2::object::uid_to_inner(&arg0.id), arg0.fee_split, arg1);
    }

    // decompiled from Move bytecode v7
}

