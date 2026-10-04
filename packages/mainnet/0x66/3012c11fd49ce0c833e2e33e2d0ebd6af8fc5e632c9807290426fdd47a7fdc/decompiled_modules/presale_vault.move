module 0x663012c11fd49ce0c833e2e33e2d0ebd6af8fc5e632c9807290426fdd47a7fdc::presale_vault {
    struct PositionKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct PresaleVault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        presale_id: 0x2::object::ID,
        presale_cap_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        fee_recipients: vector<0x663012c11fd49ce0c833e2e33e2d0ebd6af8fc5e632c9807290426fdd47a7fdc::blast_presale::RecipientShare>,
        holder_rewards_bps: 0x663012c11fd49ce0c833e2e33e2d0ebd6af8fc5e632c9807290426fdd47a7fdc::bps::Bps,
        protocol_fees: 0x663012c11fd49ce0c833e2e33e2d0ebd6af8fc5e632c9807290426fdd47a7fdc::fee_policy::ProtocolFees,
        migration_meme_residual: 0x2::balance::Balance<T0>,
        migration_quote_residual: 0x2::balance::Balance<T1>,
        holder_rewards_meme: 0x2::balance::Balance<T0>,
        holder_rewards_quote: 0x2::balance::Balance<T1>,
        next_round: u64,
        last_checkpoint: 0x1::option::Option<u64>,
    }

    struct PresaleVaultCreated<phantom T0, phantom T1, phantom T2> has copy, drop {
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
        protocol_destination: address,
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

    struct ProtocolLpFeesChanged<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        protocol_lp_fee_meme_bps: u64,
        protocol_lp_fee_quote_bps: u64,
    }

    public(friend) fun assert_cap<T0, T1>(arg0: &PresaleVault<T0, T1>, arg1: &0x663012c11fd49ce0c833e2e33e2d0ebd6af8fc5e632c9807290426fdd47a7fdc::blast_presale::PresaleCap) {
        assert!(0x2::object::id<0x663012c11fd49ce0c833e2e33e2d0ebd6af8fc5e632c9807290426fdd47a7fdc::blast_presale::PresaleCap>(arg1) == arg0.presale_cap_id, 13835621855639371781);
    }

    public fun claim_migration_residuals<T0, T1>(arg0: &mut PresaleVault<T0, T1>, arg1: &0x663012c11fd49ce0c833e2e33e2d0ebd6af8fc5e632c9807290426fdd47a7fdc::blast_presale::PresaleCap, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert_cap<T0, T1>(arg0, arg1);
        assert!(0x2::balance::value<T0>(&arg0.migration_meme_residual) > 0 || 0x2::balance::value<T1>(&arg0.migration_quote_residual) > 0, 13835058252850659329);
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

    public(friend) fun create<T0, T1, T2, T3: store + key>(arg0: &0x663012c11fd49ce0c833e2e33e2d0ebd6af8fc5e632c9807290426fdd47a7fdc::blast_presale::Presale<T0, T1>, arg1: &T2, arg2: 0x2::object::ID, arg3: T3, arg4: u128, arg5: 0x2::balance::Balance<T0>, arg6: 0x2::balance::Balance<T1>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 0, 13835339946870833155);
        let (v0, v1, v2, v3, v4) = 0x663012c11fd49ce0c833e2e33e2d0ebd6af8fc5e632c9807290426fdd47a7fdc::blast_presale::vault_config<T0, T1>(arg0);
        let v5 = v4;
        let v6 = PresaleVault<T0, T1>{
            id                       : 0x2::object::new(arg7),
            presale_id               : v0,
            presale_cap_id           : v1,
            pool_id                  : arg2,
            fee_recipients           : v2,
            holder_rewards_bps       : v3,
            protocol_fees            : v5,
            migration_meme_residual  : arg5,
            migration_quote_residual : arg6,
            holder_rewards_meme      : 0x2::balance::zero<T0>(),
            holder_rewards_quote     : 0x2::balance::zero<T1>(),
            next_round               : 0,
            last_checkpoint          : 0x1::option::none<u64>(),
        };
        let v7 = PresaleVaultCreated<T0, T1, T2>{
            vault_id                  : 0x2::object::uid_to_inner(&v6.id),
            presale_id                : v0,
            pool_id                   : arg2,
            position_id               : 0x2::object::id<T3>(&arg3),
            liquidity                 : arg4,
            fee_recipients            : 0x663012c11fd49ce0c833e2e33e2d0ebd6af8fc5e632c9807290426fdd47a7fdc::blast_presale::recipients_of(&v6.fee_recipients),
            fee_recipient_bps         : 0x663012c11fd49ce0c833e2e33e2d0ebd6af8fc5e632c9807290426fdd47a7fdc::blast_presale::bps_of(&v6.fee_recipients),
            holder_rewards_bps        : 0x663012c11fd49ce0c833e2e33e2d0ebd6af8fc5e632c9807290426fdd47a7fdc::bps::value(v3),
            protocol_lp_fee_meme_bps  : 0x663012c11fd49ce0c833e2e33e2d0ebd6af8fc5e632c9807290426fdd47a7fdc::bps::value(0x663012c11fd49ce0c833e2e33e2d0ebd6af8fc5e632c9807290426fdd47a7fdc::fee_policy::lp_fee_meme_bps(&v5)),
            protocol_lp_fee_quote_bps : 0x663012c11fd49ce0c833e2e33e2d0ebd6af8fc5e632c9807290426fdd47a7fdc::bps::value(0x663012c11fd49ce0c833e2e33e2d0ebd6af8fc5e632c9807290426fdd47a7fdc::fee_policy::lp_fee_quote_bps(&v5)),
            migration_meme_residual   : 0x2::balance::value<T0>(&v6.migration_meme_residual),
            migration_quote_residual  : 0x2::balance::value<T1>(&v6.migration_quote_residual),
        };
        0x2::event::emit<PresaleVaultCreated<T0, T1, T2>>(v7);
        let v8 = PositionKey<T2>{dummy_field: false};
        0x2::dynamic_object_field::add<PositionKey<T2>, T3>(&mut v6.id, v8, arg3);
        0x2::transfer::share_object<PresaleVault<T0, T1>>(v6);
    }

    fun fee_shares<T0, T1>(arg0: &PresaleVault<T0, T1>, arg1: u64) : (vector<u64>, u64) {
        let v0 = 0x663012c11fd49ce0c833e2e33e2d0ebd6af8fc5e632c9807290426fdd47a7fdc::blast_presale::apportion_fee(&arg0.fee_recipients, arg0.holder_rewards_bps, arg1);
        (v0, 0x1::vector::pop_back<u64>(&mut v0))
    }

    public(friend) fun fund_round<T0, T1>(arg0: &mut PresaleVault<T0, T1>, arg1: u64, arg2: u64, arg3: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        arg0.next_round = arg0.next_round + 1;
        arg0.last_checkpoint = 0x1::option::some<u64>(arg1);
        (0x2::balance::split<T0>(&mut arg0.holder_rewards_meme, arg2), 0x2::balance::split<T1>(&mut arg0.holder_rewards_quote, arg3))
    }

    public(friend) fun holder_rewards_balances<T0, T1>(arg0: &PresaleVault<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.holder_rewards_meme), 0x2::balance::value<T1>(&arg0.holder_rewards_quote))
    }

    public(friend) fun last_checkpoint<T0, T1>(arg0: &PresaleVault<T0, T1>) : 0x1::option::Option<u64> {
        arg0.last_checkpoint
    }

    public(friend) fun next_round<T0, T1>(arg0: &PresaleVault<T0, T1>) : u64 {
        arg0.next_round
    }

    public(friend) fun pool_id<T0, T1>(arg0: &PresaleVault<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    public(friend) fun position_mut<T0, T1, T2, T3: store + key>(arg0: &mut PresaleVault<T0, T1>, arg1: &T2) : &mut T3 {
        let v0 = PositionKey<T2>{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<PositionKey<T2>, T3>(&mut arg0.id, v0)
    }

    public(friend) fun restore_holder_rewards<T0, T1>(arg0: &mut PresaleVault<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T0>(&mut arg0.holder_rewards_meme, arg1);
        0x2::balance::join<T1>(&mut arg0.holder_rewards_quote, arg2);
    }

    public fun set_protocol_lp_fees<T0, T1>(arg0: &mut PresaleVault<T0, T1>, arg1: &0x663012c11fd49ce0c833e2e33e2d0ebd6af8fc5e632c9807290426fdd47a7fdc::blast_presale_admin::AdminRegistry, arg2: &0x663012c11fd49ce0c833e2e33e2d0ebd6af8fc5e632c9807290426fdd47a7fdc::blast_presale_admin::AdminCap, arg3: 0x663012c11fd49ce0c833e2e33e2d0ebd6af8fc5e632c9807290426fdd47a7fdc::bps::Bps, arg4: 0x663012c11fd49ce0c833e2e33e2d0ebd6af8fc5e632c9807290426fdd47a7fdc::bps::Bps) {
        0x663012c11fd49ce0c833e2e33e2d0ebd6af8fc5e632c9807290426fdd47a7fdc::blast_presale_admin::assert_admin_cap(arg1, arg2);
        let v0 = 0x663012c11fd49ce0c833e2e33e2d0ebd6af8fc5e632c9807290426fdd47a7fdc::fee_policy::with_lp_fees(arg0.protocol_fees, arg3, arg4);
        assert!(v0 != arg0.protocol_fees, 13835902789450334215);
        arg0.protocol_fees = v0;
        let v1 = ProtocolLpFeesChanged<T0, T1>{
            vault_id                  : 0x2::object::uid_to_inner(&arg0.id),
            protocol_lp_fee_meme_bps  : 0x663012c11fd49ce0c833e2e33e2d0ebd6af8fc5e632c9807290426fdd47a7fdc::bps::value(arg3),
            protocol_lp_fee_quote_bps : 0x663012c11fd49ce0c833e2e33e2d0ebd6af8fc5e632c9807290426fdd47a7fdc::bps::value(arg4),
        };
        0x2::event::emit<ProtocolLpFeesChanged<T0, T1>>(v1);
    }

    public(friend) fun split_fees<T0, T1>(arg0: &mut PresaleVault<T0, T1>, arg1: &0x663012c11fd49ce0c833e2e33e2d0ebd6af8fc5e632c9807290426fdd47a7fdc::fee_policy::FeePolicy, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg2);
        let v1 = 0x2::balance::value<T1>(&arg3);
        if (v0 == 0 && v1 == 0) {
            0x2::balance::destroy_zero<T0>(arg2);
            0x2::balance::destroy_zero<T1>(arg3);
            return
        };
        let v2 = 0x663012c11fd49ce0c833e2e33e2d0ebd6af8fc5e632c9807290426fdd47a7fdc::bps::apply_up(0x663012c11fd49ce0c833e2e33e2d0ebd6af8fc5e632c9807290426fdd47a7fdc::fee_policy::lp_fee_meme_bps(&arg0.protocol_fees), v0);
        let v3 = 0x663012c11fd49ce0c833e2e33e2d0ebd6af8fc5e632c9807290426fdd47a7fdc::bps::apply_up(0x663012c11fd49ce0c833e2e33e2d0ebd6af8fc5e632c9807290426fdd47a7fdc::fee_policy::lp_fee_quote_bps(&arg0.protocol_fees), v1);
        let v4 = 0x663012c11fd49ce0c833e2e33e2d0ebd6af8fc5e632c9807290426fdd47a7fdc::fee_policy::destination(arg1);
        let (v5, v6) = fee_shares<T0, T1>(arg0, v0 - v2);
        let v7 = v5;
        let (v8, v9) = fee_shares<T0, T1>(arg0, v1 - v3);
        let v10 = v8;
        let v11 = 0x663012c11fd49ce0c833e2e33e2d0ebd6af8fc5e632c9807290426fdd47a7fdc::blast_presale::recipients_of(&arg0.fee_recipients);
        0x663012c11fd49ce0c833e2e33e2d0ebd6af8fc5e632c9807290426fdd47a7fdc::blast_presale::pay<T0>(&mut arg2, v2, v4, arg4);
        0x663012c11fd49ce0c833e2e33e2d0ebd6af8fc5e632c9807290426fdd47a7fdc::blast_presale::pay<T1>(&mut arg3, v3, v4, arg4);
        let v12 = 0;
        while (v12 < 0x1::vector::length<address>(&v11)) {
            0x663012c11fd49ce0c833e2e33e2d0ebd6af8fc5e632c9807290426fdd47a7fdc::blast_presale::pay<T0>(&mut arg2, *0x1::vector::borrow<u64>(&v7, v12), *0x1::vector::borrow<address>(&v11, v12), arg4);
            0x663012c11fd49ce0c833e2e33e2d0ebd6af8fc5e632c9807290426fdd47a7fdc::blast_presale::pay<T1>(&mut arg3, *0x1::vector::borrow<u64>(&v10, v12), *0x1::vector::borrow<address>(&v11, v12), arg4);
            v12 = v12 + 1;
        };
        0x2::balance::join<T0>(&mut arg0.holder_rewards_meme, arg2);
        0x2::balance::join<T1>(&mut arg0.holder_rewards_quote, arg3);
        let v13 = FeesCollected<T0, T1>{
            vault_id             : 0x2::object::uid_to_inner(&arg0.id),
            gross_meme           : v0,
            gross_quote          : v1,
            protocol_destination : v4,
            protocol_meme        : v2,
            protocol_quote       : v3,
            fee_recipient_meme   : v7,
            fee_recipient_quote  : v10,
            holder_rewards_meme  : v6,
            holder_rewards_quote : v9,
        };
        0x2::event::emit<FeesCollected<T0, T1>>(v13);
    }

    // decompiled from Move bytecode v7
}

