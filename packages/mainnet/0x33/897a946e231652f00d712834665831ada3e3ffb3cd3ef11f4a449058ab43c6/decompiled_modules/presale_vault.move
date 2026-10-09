module 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::presale_vault {
    struct PositionKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct Vault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        presale_id: 0x2::object::ID,
        presale_cap_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        fee_split: 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale::FeeSplit,
        protocol_fees: 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::fee_policy::ProtocolFees,
        partner_id: 0x1::option::Option<0x2::object::ID>,
        unpaid_protocol_meme: 0x2::balance::Balance<T0>,
        unpaid_protocol_quote: 0x2::balance::Balance<T1>,
        migration_meme_residual: 0x2::balance::Balance<T0>,
        migration_quote_residual: 0x2::balance::Balance<T1>,
        holder_rewards_meme: 0x2::balance::Balance<T0>,
        holder_rewards_quote: 0x2::balance::Balance<T1>,
        next_round: u64,
        last_checkpoint: 0x1::option::Option<u64>,
    }

    struct VaultCreated<phantom T0, phantom T1, phantom T2> has copy, drop {
        vault_id: 0x2::object::ID,
        presale_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        liquidity: u128,
        fee_recipients: vector<address>,
        fee_recipient_bps: vector<u64>,
        holder_rewards_bps: u64,
        protocol_lp_fee_meme_bps: u64,
        protocol_lp_fee_quote_bps: u64,
        migration_meme_residual: u64,
        migration_quote_residual: u64,
    }

    struct FeesCollected<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        gross_meme: u64,
        gross_quote: u64,
        protocol_destination: 0x1::option::Option<address>,
        protocol_meme: u64,
        protocol_quote: u64,
        fee_recipient_meme: vector<u64>,
        fee_recipient_quote: vector<u64>,
        holder_rewards_meme: u64,
        holder_rewards_quote: u64,
    }

    struct MigrationResidualsClaimed<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        meme: u64,
        quote: u64,
    }

    struct ProtocolLpFeesPaid<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        protocol_destination: address,
        protocol_meme: u64,
        protocol_quote: u64,
        partner_meme: u64,
        partner_quote: u64,
    }

    struct ProtocolLpFeesChanged<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        protocol_lp_fee_meme_bps: u64,
        protocol_lp_fee_quote_bps: u64,
    }

    public(friend) fun assert_cap<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale::PresaleCap) {
        assert!(0x2::object::id<0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale::PresaleCap>(arg1) == arg0.presale_cap_id, 13835622104747474949);
    }

    public fun claim_migration_residuals<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale::PresaleCap, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert_cap<T0, T1>(arg0, arg1);
        assert!(0x2::balance::value<T0>(&arg0.migration_meme_residual) > 0 || 0x2::balance::value<T1>(&arg0.migration_quote_residual) > 0, 13835058282915430401);
        let v0 = 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.migration_meme_residual), arg2);
        let v1 = 0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.migration_quote_residual), arg2);
        let v2 = MigrationResidualsClaimed<T0, T1>{
            vault_id : 0x2::object::uid_to_inner(&arg0.id),
            meme     : 0x2::coin::value<T0>(&v0),
            quote    : 0x2::coin::value<T1>(&v1),
        };
        0x2::event::emit<MigrationResidualsClaimed<T0, T1>>(v2);
        (v0, v1)
    }

    public(friend) fun create<T0, T1, T2, T3: store + key>(arg0: &0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale::Presale<T0, T1>, arg1: &T2, arg2: 0x2::object::ID, arg3: T3, arg4: u128, arg5: 0x2::balance::Balance<T0>, arg6: 0x2::balance::Balance<T1>, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4) = 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale::vault_config<T0, T1>(arg0);
        share_new<T0, T1, T2, T3>(v0, v1, v2, v3, v4, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public(friend) fun create_without_presale<T0, T1, T2, T3: store + key>(arg0: 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale::FeeSplit, arg1: 0x1::option::Option<0x2::object::ID>, arg2: &0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::creation_policy::CreationPolicy, arg3: &0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::fee_policy::FeePolicy, arg4: &0x2::clock::Clock, arg5: &T2, arg6: 0x2::object::ID, arg7: T3, arg8: u128, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = &arg1;
        if (0x1::option::is_some<0x2::object::ID>(v0)) {
            0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::creation_policy::assert_partner(arg2, *0x1::option::borrow<0x2::object::ID>(v0), 0x2::clock::timestamp_ms(arg4));
        };
        share_new<T0, T1, T2, T3>(0x2::object::id_from_address(@0x0), 0x2::object::id_from_address(@0x0), arg0, 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::fee_policy::fees(arg3), arg1, arg5, arg6, arg7, arg8, 0x2::balance::zero<T0>(), 0x2::balance::zero<T1>(), arg9);
    }

    fun fee_amounts<T0, T1>(arg0: &Vault<T0, T1>, arg1: u64) : (vector<u64>, u64) {
        let v0 = 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale::apportion_fee(&arg0.fee_split, arg1);
        (v0, 0x1::vector::pop_back<u64>(&mut v0))
    }

    public(friend) fun fund_round<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: u64, arg3: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        arg0.next_round = arg0.next_round + 1;
        arg0.last_checkpoint = 0x1::option::some<u64>(arg1);
        (0x2::balance::split<T0>(&mut arg0.holder_rewards_meme, arg2), 0x2::balance::split<T1>(&mut arg0.holder_rewards_quote, arg3))
    }

    public(friend) fun holder_rewards_balances<T0, T1>(arg0: &Vault<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.holder_rewards_meme), 0x2::balance::value<T1>(&arg0.holder_rewards_quote))
    }

    public(friend) fun last_checkpoint<T0, T1>(arg0: &Vault<T0, T1>) : 0x1::option::Option<u64> {
        arg0.last_checkpoint
    }

    public(friend) fun next_round<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.next_round
    }

    fun pay_all<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale::pay<T0>(&mut arg0, 0x2::balance::value<T0>(&arg0), arg1, arg2);
        0x2::balance::destroy_zero<T0>(arg0);
    }

    fun pay_or_hold_protocol_lp_fees<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::fee_policy::FeePolicy, arg4: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<address> {
        if (0x1::option::is_some<0x2::object::ID>(&arg0.partner_id)) {
            0x2::balance::join<T0>(&mut arg0.unpaid_protocol_meme, arg1);
            0x2::balance::join<T1>(&mut arg0.unpaid_protocol_quote, arg2);
            return 0x1::option::none<address>()
        };
        let v0 = 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::fee_policy::destination(arg3);
        pay_all<T0>(arg1, v0, arg4);
        pay_all<T1>(arg2, v0, arg4);
        0x1::option::some<address>(v0)
    }

    public fun pay_protocol_lp_fees_with_partner<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::fee_policy::FeePolicy, arg2: &0x96fbe2db7337dea5ef6926203d32cf602e527d5e2dcae176fbbc3e3d2a30d94f::blast_partners::Partner, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x96fbe2db7337dea5ef6926203d32cf602e527d5e2dcae176fbbc3e3d2a30d94f::blast_partners::Partner>(arg2);
        assert!(0x1::option::contains<0x2::object::ID>(&arg0.partner_id, &v0), 13836184380391292937);
        if (0x2::balance::value<T0>(&arg0.unpaid_protocol_meme) == 0 && 0x2::balance::value<T1>(&arg0.unpaid_protocol_quote) == 0) {
            return
        };
        let v1 = 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::fee_policy::destination(arg1);
        let v2 = 0x2::balance::withdraw_all<T0>(&mut arg0.unpaid_protocol_meme);
        let v3 = 0x2::balance::withdraw_all<T1>(&mut arg0.unpaid_protocol_quote);
        pay_all<T0>(v2, v1, arg4);
        pay_all<T1>(v3, v1, arg4);
        let v4 = ProtocolLpFeesPaid<T0, T1>{
            vault_id             : 0x2::object::uid_to_inner(&arg0.id),
            protocol_destination : v1,
            protocol_meme        : 0x2::balance::value<T0>(&v2),
            protocol_quote       : 0x2::balance::value<T1>(&v3),
            partner_meme         : 0x96fbe2db7337dea5ef6926203d32cf602e527d5e2dcae176fbbc3e3d2a30d94f::blast_partners::pay<T0>(arg2, &mut v2, arg3),
            partner_quote        : 0x96fbe2db7337dea5ef6926203d32cf602e527d5e2dcae176fbbc3e3d2a30d94f::blast_partners::pay<T1>(arg2, &mut v3, arg3),
        };
        0x2::event::emit<ProtocolLpFeesPaid<T0, T1>>(v4);
    }

    public(friend) fun pool_id<T0, T1>(arg0: &Vault<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    public(friend) fun position_mut<T0, T1, T2, T3: store + key>(arg0: &mut Vault<T0, T1>, arg1: &T2) : &mut T3 {
        let v0 = PositionKey<T2>{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<PositionKey<T2>, T3>(&mut arg0.id, v0)
    }

    public(friend) fun restore_holder_rewards<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T0>(&mut arg0.holder_rewards_meme, arg1);
        0x2::balance::join<T1>(&mut arg0.holder_rewards_quote, arg2);
    }

    public fun set_protocol_lp_fees<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x726fb49b880faa89719b95c6ef3a91be794f771ed3560fe5894d0a605c8469f9::blast_acl::AdminWitness<0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale_domain::FeeAdmin>, arg2: 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::bps::Bps, arg3: 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::bps::Bps) {
        let v0 = 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::fee_policy::with_lp_fees(arg0.protocol_fees, arg2, arg3);
        assert!(v0 != arg0.protocol_fees, 13835902810925170695);
        arg0.protocol_fees = v0;
        let v1 = ProtocolLpFeesChanged<T0, T1>{
            vault_id                  : 0x2::object::uid_to_inner(&arg0.id),
            protocol_lp_fee_meme_bps  : 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::bps::value(arg2),
            protocol_lp_fee_quote_bps : 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::bps::value(arg3),
        };
        0x2::event::emit<ProtocolLpFeesChanged<T0, T1>>(v1);
    }

    fun share_new<T0, T1, T2, T3: store + key>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale::FeeSplit, arg3: 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::fee_policy::ProtocolFees, arg4: 0x1::option::Option<0x2::object::ID>, arg5: &T2, arg6: 0x2::object::ID, arg7: T3, arg8: u128, arg9: 0x2::balance::Balance<T0>, arg10: 0x2::balance::Balance<T1>, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg8 > 0, 13835340891763638275);
        let v0 = Vault<T0, T1>{
            id                       : 0x2::object::new(arg11),
            presale_id               : arg0,
            presale_cap_id           : arg1,
            pool_id                  : arg6,
            fee_split                : arg2,
            protocol_fees            : arg3,
            partner_id               : arg4,
            unpaid_protocol_meme     : 0x2::balance::zero<T0>(),
            unpaid_protocol_quote    : 0x2::balance::zero<T1>(),
            migration_meme_residual  : arg9,
            migration_quote_residual : arg10,
            holder_rewards_meme      : 0x2::balance::zero<T0>(),
            holder_rewards_quote     : 0x2::balance::zero<T1>(),
            next_round               : 0,
            last_checkpoint          : 0x1::option::none<u64>(),
        };
        let v1 = VaultCreated<T0, T1, T2>{
            vault_id                  : 0x2::object::uid_to_inner(&v0.id),
            presale_id                : arg0,
            pool_id                   : arg6,
            position_id               : 0x2::object::id<T3>(&arg7),
            liquidity                 : arg8,
            fee_recipients            : 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale::recipients_of(0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale::fee_recipients(&arg2)),
            fee_recipient_bps         : 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale::bps_of(0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale::fee_recipients(&arg2)),
            holder_rewards_bps        : 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::bps::value(0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale::holder_rewards_bps(&arg2)),
            protocol_lp_fee_meme_bps  : 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::bps::value(0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::fee_policy::lp_fee_meme_bps(&arg3)),
            protocol_lp_fee_quote_bps : 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::bps::value(0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::fee_policy::lp_fee_quote_bps(&arg3)),
            migration_meme_residual   : 0x2::balance::value<T0>(&v0.migration_meme_residual),
            migration_quote_residual  : 0x2::balance::value<T1>(&v0.migration_quote_residual),
        };
        0x2::event::emit<VaultCreated<T0, T1, T2>>(v1);
        let v2 = PositionKey<T2>{dummy_field: false};
        0x2::dynamic_object_field::add<PositionKey<T2>, T3>(&mut v0.id, v2, arg7);
        0x2::transfer::share_object<Vault<T0, T1>>(v0);
    }

    public(friend) fun split_fees<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::fee_policy::FeePolicy, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg2);
        let v1 = 0x2::balance::value<T1>(&arg3);
        if (v0 == 0 && v1 == 0) {
            0x2::balance::destroy_zero<T0>(arg2);
            0x2::balance::destroy_zero<T1>(arg3);
            return
        };
        let v2 = 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::bps::apply_up(0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::fee_policy::lp_fee_meme_bps(&arg0.protocol_fees), v0);
        let v3 = 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::bps::apply_up(0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::fee_policy::lp_fee_quote_bps(&arg0.protocol_fees), v1);
        let (v4, v5) = fee_amounts<T0, T1>(arg0, v0 - v2);
        let v6 = v4;
        let (v7, v8) = fee_amounts<T0, T1>(arg0, v1 - v3);
        let v9 = v7;
        let v10 = 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale::recipients_of(0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale::fee_recipients(&arg0.fee_split));
        let v11 = pay_or_hold_protocol_lp_fees<T0, T1>(arg0, 0x2::balance::split<T0>(&mut arg2, v2), 0x2::balance::split<T1>(&mut arg3, v3), arg1, arg4);
        let v12 = 0;
        while (v12 < 0x1::vector::length<address>(&v10)) {
            0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale::pay<T0>(&mut arg2, *0x1::vector::borrow<u64>(&v6, v12), *0x1::vector::borrow<address>(&v10, v12), arg4);
            0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale::pay<T1>(&mut arg3, *0x1::vector::borrow<u64>(&v9, v12), *0x1::vector::borrow<address>(&v10, v12), arg4);
            v12 = v12 + 1;
        };
        0x2::balance::join<T0>(&mut arg0.holder_rewards_meme, arg2);
        0x2::balance::join<T1>(&mut arg0.holder_rewards_quote, arg3);
        let v13 = FeesCollected<T0, T1>{
            vault_id             : 0x2::object::uid_to_inner(&arg0.id),
            gross_meme           : v0,
            gross_quote          : v1,
            protocol_destination : v11,
            protocol_meme        : v2,
            protocol_quote       : v3,
            fee_recipient_meme   : v6,
            fee_recipient_quote  : v9,
            holder_rewards_meme  : v5,
            holder_rewards_quote : v8,
        };
        0x2::event::emit<FeesCollected<T0, T1>>(v13);
    }

    // decompiled from Move bytecode v7
}

