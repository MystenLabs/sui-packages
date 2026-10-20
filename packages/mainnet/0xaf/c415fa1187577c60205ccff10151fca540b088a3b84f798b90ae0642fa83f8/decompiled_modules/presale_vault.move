module 0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::presale_vault {
    struct PositionKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct Vault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        presale_id: 0x2::object::ID,
        presale_cap_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        fee_split: 0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::blast_presale::FeeSplit,
        protocol_fees: 0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::fee_policy::ProtocolFees,
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

    struct HolderMemePaid<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        treasury: address,
        meme_amount: u64,
        unallocated_meme_remaining: u64,
    }

    public(friend) fun new<T0, T1>(arg0: &0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::blast_presale::Presale<T0, T1>, arg1: 0x2::object::ID, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: &mut 0x2::tx_context::TxContext) : Vault<T0, T1> {
        let (v0, v1, v2, v3, v4) = 0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::blast_presale::vault_config<T0, T1>(arg0);
        build<T0, T1>(v0, v1, v2, v3, v4, arg1, arg2, arg3, arg4)
    }

    public(friend) fun assert_cap<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::blast_presale::PresaleCap) {
        assert!(0x2::object::id<0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::blast_presale::PresaleCap>(arg1) == arg0.presale_cap_id, 13835622353855578117);
    }

    fun attach<T0, T1, T2, T3: store + key>(arg0: &mut Vault<T0, T1>, arg1: &T2, arg2: T3, arg3: u128) {
        assert!(arg3 > 0, 13835341235361021955);
        let v0 = PositionKey<T2>{dummy_field: false};
        0x2::dynamic_object_field::add<PositionKey<T2>, T3>(&mut arg0.id, v0, arg2);
        let v1 = VaultCreated<T0, T1, T2>{
            vault_id                  : 0x2::object::uid_to_inner(&arg0.id),
            presale_id                : arg0.presale_id,
            pool_id                   : arg0.pool_id,
            position_id               : 0x2::object::id<T3>(&arg2),
            liquidity                 : arg3,
            fee_recipients            : 0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::blast_presale::recipients_of(0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::blast_presale::fee_recipients(&arg0.fee_split)),
            fee_recipient_bps         : 0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::blast_presale::bps_of(0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::blast_presale::fee_recipients(&arg0.fee_split)),
            holder_rewards_bps        : 0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::bps::value(0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::blast_presale::holder_rewards_bps(&arg0.fee_split)),
            protocol_lp_fee_meme_bps  : 0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::bps::value(0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::fee_policy::lp_fee_meme_bps(&arg0.protocol_fees)),
            protocol_lp_fee_quote_bps : 0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::bps::value(0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::fee_policy::lp_fee_quote_bps(&arg0.protocol_fees)),
            migration_meme_residual   : 0x2::balance::value<T0>(&arg0.migration_meme_residual),
            migration_quote_residual  : 0x2::balance::value<T1>(&arg0.migration_quote_residual),
        };
        0x2::event::emit<VaultCreated<T0, T1, T2>>(v1);
    }

    fun build<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::blast_presale::FeeSplit, arg3: 0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::fee_policy::ProtocolFees, arg4: 0x1::option::Option<0x2::object::ID>, arg5: 0x2::object::ID, arg6: 0x2::balance::Balance<T0>, arg7: 0x2::balance::Balance<T1>, arg8: &mut 0x2::tx_context::TxContext) : Vault<T0, T1> {
        Vault<T0, T1>{
            id                       : 0x2::object::new(arg8),
            presale_id               : arg0,
            presale_cap_id           : arg1,
            pool_id                  : arg5,
            fee_split                : arg2,
            protocol_fees            : arg3,
            partner_id               : arg4,
            unpaid_protocol_meme     : 0x2::balance::zero<T0>(),
            unpaid_protocol_quote    : 0x2::balance::zero<T1>(),
            migration_meme_residual  : arg6,
            migration_quote_residual : arg7,
            holder_rewards_meme      : 0x2::balance::zero<T0>(),
            holder_rewards_quote     : 0x2::balance::zero<T1>(),
            next_round               : 0,
            last_checkpoint          : 0x1::option::none<u64>(),
        }
    }

    public fun claim_migration_residuals<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::blast_presale_package::PackageVersion, arg2: &0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::blast_presale::PresaleCap, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::blast_presale_package::assert_current(arg1);
        assert_cap<T0, T1>(arg0, arg2);
        assert!(0x2::balance::value<T0>(&arg0.migration_meme_residual) > 0 || 0x2::balance::value<T1>(&arg0.migration_quote_residual) > 0, 13835058321570136065);
        let v0 = 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.migration_meme_residual), arg3);
        let v1 = 0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.migration_quote_residual), arg3);
        let v2 = MigrationResidualsClaimed<T0, T1>{
            vault_id : 0x2::object::uid_to_inner(&arg0.id),
            meme     : 0x2::coin::value<T0>(&v0),
            quote    : 0x2::coin::value<T1>(&v1),
        };
        0x2::event::emit<MigrationResidualsClaimed<T0, T1>>(v2);
        (v0, v1)
    }

    public(friend) fun create<T0, T1, T2, T3: store + key>(arg0: &0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::blast_presale::Presale<T0, T1>, arg1: &T2, arg2: 0x2::object::ID, arg3: T3, arg4: u128, arg5: 0x2::balance::Balance<T0>, arg6: 0x2::balance::Balance<T1>, arg7: &mut 0x2::tx_context::TxContext) {
        share_with_position<T0, T1, T2, T3>(new<T0, T1>(arg0, arg2, arg5, arg6, arg7), arg1, arg3, arg4);
    }

    public(friend) fun create_without_presale<T0, T1, T2, T3: store + key>(arg0: 0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::blast_presale::FeeSplit, arg1: 0x1::option::Option<0x2::object::ID>, arg2: &0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::creation_policy::CreationPolicy, arg3: &0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::fee_policy::FeePolicy, arg4: &0x2::clock::Clock, arg5: &T2, arg6: 0x2::object::ID, arg7: T3, arg8: u128, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = &arg1;
        if (0x1::option::is_some<0x2::object::ID>(v0)) {
            0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::creation_policy::assert_partner(arg2, *0x1::option::borrow<0x2::object::ID>(v0), 0x2::clock::timestamp_ms(arg4));
        };
        share_with_position<T0, T1, T2, T3>(build<T0, T1>(0x2::object::id_from_address(@0x0), 0x2::object::id_from_address(@0x0), arg0, 0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::fee_policy::fees(arg3), arg1, arg6, 0x2::balance::zero<T0>(), 0x2::balance::zero<T1>(), arg9), arg5, arg7, arg8);
    }

    fun fee_amounts<T0, T1>(arg0: &Vault<T0, T1>, arg1: u64) : (vector<u64>, u64) {
        let v0 = 0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::blast_presale::apportion_fee(&arg0.fee_split, arg1);
        (v0, 0x1::vector::pop_back<u64>(&mut v0))
    }

    public(friend) fun fund_round<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: u64, arg3: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        arg0.next_round = arg0.next_round + 1;
        arg0.last_checkpoint = 0x1::option::some<u64>(arg1);
        (0x2::balance::split<T0>(&mut arg0.holder_rewards_meme, arg2), 0x2::balance::split<T1>(&mut arg0.holder_rewards_quote, arg3))
    }

    public(friend) fun has_position<T0, T1, T2>(arg0: &Vault<T0, T1>, arg1: &T2) : bool {
        let v0 = PositionKey<T2>{dummy_field: false};
        0x2::dynamic_object_field::exists<PositionKey<T2>>(&arg0.id, v0)
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
        0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::blast_presale::pay<T0>(&mut arg0, 0x2::balance::value<T0>(&arg0), arg1, arg2);
        0x2::balance::destroy_zero<T0>(arg0);
    }

    fun pay_or_hold_protocol_lp_fees<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: &0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::fee_policy::FeePolicy, arg4: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<address> {
        if (0x1::option::is_some<0x2::object::ID>(&arg0.partner_id)) {
            0x2::balance::join<T0>(&mut arg0.unpaid_protocol_meme, arg1);
            0x2::balance::join<T1>(&mut arg0.unpaid_protocol_quote, arg2);
            return 0x1::option::none<address>()
        };
        let v0 = 0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::fee_policy::destination(arg3);
        pay_all<T0>(arg1, v0, arg4);
        pay_all<T1>(arg2, v0, arg4);
        0x1::option::some<address>(v0)
    }

    public fun pay_protocol_lp_fees_with_partner<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::blast_presale_package::PackageVersion, arg2: &0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::fee_policy::FeePolicy, arg3: &0x50c4a1b68af8c4fa0438ad8b02e49d484d46ab38e85ac4d001ea13449aa20dbd::blast_partners::Partner, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::blast_presale_package::assert_current(arg1);
        let v0 = 0x2::object::id<0x50c4a1b68af8c4fa0438ad8b02e49d484d46ab38e85ac4d001ea13449aa20dbd::blast_partners::Partner>(arg3);
        assert!(0x1::option::contains<0x2::object::ID>(&arg0.partner_id, &v0), 13836184444815802377);
        if (0x2::balance::value<T0>(&arg0.unpaid_protocol_meme) == 0 && 0x2::balance::value<T1>(&arg0.unpaid_protocol_quote) == 0) {
            return
        };
        let v1 = 0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::fee_policy::destination(arg2);
        let v2 = 0x2::balance::withdraw_all<T0>(&mut arg0.unpaid_protocol_meme);
        let v3 = 0x2::balance::withdraw_all<T1>(&mut arg0.unpaid_protocol_quote);
        let v4 = 0x50c4a1b68af8c4fa0438ad8b02e49d484d46ab38e85ac4d001ea13449aa20dbd::blast_partners::pay<T0>(arg3, &mut v2, arg4, arg5);
        let v5 = 0x50c4a1b68af8c4fa0438ad8b02e49d484d46ab38e85ac4d001ea13449aa20dbd::blast_partners::pay<T1>(arg3, &mut v3, arg4, arg5);
        pay_all<T0>(v2, v1, arg5);
        pay_all<T1>(v3, v1, arg5);
        let v6 = ProtocolLpFeesPaid<T0, T1>{
            vault_id             : 0x2::object::uid_to_inner(&arg0.id),
            protocol_destination : v1,
            protocol_meme        : 0x2::balance::value<T0>(&v2),
            protocol_quote       : 0x2::balance::value<T1>(&v3),
            partner_meme         : v4,
            partner_quote        : v5,
        };
        0x2::event::emit<ProtocolLpFeesPaid<T0, T1>>(v6);
    }

    public(friend) fun pool_id<T0, T1>(arg0: &Vault<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    public(friend) fun position_mut<T0, T1, T2, T3: store + key>(arg0: &mut Vault<T0, T1>, arg1: &T2) : &mut T3 {
        let v0 = PositionKey<T2>{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<PositionKey<T2>, T3>(&mut arg0.id, v0)
    }

    public(friend) fun receive_fee<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T2>>) : 0x2::coin::Coin<T2> {
        0x2::transfer::public_receive<0x2::coin::Coin<T2>>(&mut arg0.id, arg1)
    }

    public(friend) fun restore_holder_rewards<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T0>(&mut arg0.holder_rewards_meme, arg1);
        0x2::balance::join<T1>(&mut arg0.holder_rewards_quote, arg2);
    }

    public fun set_protocol_lp_fees<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::blast_presale_package::PackageVersion, arg2: &0x726fb49b880faa89719b95c6ef3a91be794f771ed3560fe5894d0a605c8469f9::blast_acl::AdminWitness<0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::blast_presale_domain::FeeAdmin>, arg3: 0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::bps::Bps, arg4: 0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::bps::Bps) {
        0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::blast_presale_package::assert_current(arg1);
        let v0 = 0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::fee_policy::with_lp_fees(arg0.protocol_fees, arg3, arg4);
        assert!(v0 != arg0.protocol_fees, 13835902862464778247);
        arg0.protocol_fees = v0;
        let v1 = ProtocolLpFeesChanged<T0, T1>{
            vault_id                  : 0x2::object::uid_to_inner(&arg0.id),
            protocol_lp_fee_meme_bps  : 0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::bps::value(arg3),
            protocol_lp_fee_quote_bps : 0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::bps::value(arg4),
        };
        0x2::event::emit<ProtocolLpFeesChanged<T0, T1>>(v1);
    }

    public(friend) fun share_with_position<T0, T1, T2, T3: store + key>(arg0: Vault<T0, T1>, arg1: &T2, arg2: T3, arg3: u128) {
        let v0 = &mut arg0;
        attach<T0, T1, T2, T3>(v0, arg1, arg2, arg3);
        0x2::transfer::share_object<Vault<T0, T1>>(arg0);
    }

    public(friend) fun split_fees<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::fee_policy::FeePolicy, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg2);
        let v1 = 0x2::balance::value<T1>(&arg3);
        if (v0 == 0 && v1 == 0) {
            0x2::balance::destroy_zero<T0>(arg2);
            0x2::balance::destroy_zero<T1>(arg3);
            return
        };
        let v2 = 0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::bps::apply_up(0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::fee_policy::lp_fee_meme_bps(&arg0.protocol_fees), v0);
        let v3 = 0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::bps::apply_up(0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::fee_policy::lp_fee_quote_bps(&arg0.protocol_fees), v1);
        let (v4, v5) = fee_amounts<T0, T1>(arg0, v0 - v2);
        let v6 = v4;
        let (v7, v8) = fee_amounts<T0, T1>(arg0, v1 - v3);
        let v9 = v7;
        let v10 = 0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::blast_presale::recipients_of(0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::blast_presale::fee_recipients(&arg0.fee_split));
        let v11 = pay_or_hold_protocol_lp_fees<T0, T1>(arg0, 0x2::balance::split<T0>(&mut arg2, v2), 0x2::balance::split<T1>(&mut arg3, v3), arg1, arg4);
        let v12 = 0;
        while (v12 < 0x1::vector::length<address>(&v10)) {
            0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::blast_presale::pay<T0>(&mut arg2, *0x1::vector::borrow<u64>(&v6, v12), *0x1::vector::borrow<address>(&v10, v12), arg4);
            0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::blast_presale::pay<T1>(&mut arg3, *0x1::vector::borrow<u64>(&v9, v12), *0x1::vector::borrow<address>(&v10, v12), arg4);
            v12 = v12 + 1;
        };
        let v13 = 0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::fee_policy::destination(arg1);
        pay_all<T0>(arg2, v13, arg4);
        0x2::balance::join<T1>(&mut arg0.holder_rewards_quote, arg3);
        let v14 = FeesCollected<T0, T1>{
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
        0x2::event::emit<FeesCollected<T0, T1>>(v14);
        if (v5 > 0) {
            let v15 = HolderMemePaid<T0, T1>{
                vault_id                   : 0x2::object::uid_to_inner(&arg0.id),
                treasury                   : v13,
                meme_amount                : v5,
                unallocated_meme_remaining : 0x2::balance::value<T0>(&arg0.holder_rewards_meme),
            };
            0x2::event::emit<HolderMemePaid<T0, T1>>(v15);
        };
    }

    // decompiled from Move bytecode v7
}

