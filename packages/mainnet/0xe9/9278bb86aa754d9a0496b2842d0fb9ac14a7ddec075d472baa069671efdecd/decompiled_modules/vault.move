module 0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault {
    struct VaultKey has copy, drop, store {
        package_witness: 0x1::type_name::TypeName,
        origin: 0x2::object::ID,
    }

    struct PositionKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct AutoLpPositionKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct FeeSplitKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ProtocolBpsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RoundPublicationKey has copy, drop, store {
        dummy_field: bool,
    }

    struct VaultWitness has drop {
        dummy_field: bool,
    }

    struct BuybackReceipt {
        vault_id: 0x2::object::ID,
        taken_quote: u64,
    }

    struct AutoLpReceipt {
        vault_id: 0x2::object::ID,
        taken_meme: u64,
        taken_quote: u64,
    }

    struct ProtocolBps has copy, drop, store {
        meme_bps: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps,
        quote_bps: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps,
    }

    struct RoundTerms has copy, drop, store {
        number: u64,
        start_checkpoint: u64,
        end_checkpoint: u64,
        root: vector<u8>,
        manifest_digest: vector<u8>,
        leaf_count: u64,
        meme_amount: u64,
        quote_amount: u64,
        gas_reserve_amount: u64,
        claim_window_duration_ms: u64,
        expected_treasury: address,
    }

    struct Vault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        terms: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::migration::VaultTerms,
        venue: 0x1::type_name::TypeName,
        pool_id: 0x2::object::ID,
        fee_split: 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::Delayed<FeeSplitKey, 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::fee_split::FeeSplit>,
        protocol_bps: 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::Delayed<ProtocolBpsKey, ProtocolBps>,
        protocol: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::protocol_fees::Ledger<T0, T1>,
        owner_meme: 0x2::balance::Balance<T0>,
        owner_quote: 0x2::balance::Balance<T1>,
        auto_lp_meme: 0x2::balance::Balance<T0>,
        auto_lp_quote: 0x2::balance::Balance<T1>,
        rewards_meme: 0x2::balance::Balance<T0>,
        rewards_quote: 0x2::balance::Balance<T1>,
        burn_quote: 0x2::balance::Balance<T1>,
        next_round: u64,
        last_checkpoint: 0x1::option::Option<u64>,
        round_publication: 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_action::DelayedAction<RoundPublicationKey, RoundTerms>,
    }

    public fun new<T0, T1, T2>(arg0: &mut 0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::VaultRegistry, arg1: &T2, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>, arg3: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::migration::VaultTerms, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) : Vault<T0, T1> {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>(arg2, 1);
        0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::assert_venue<T2>(arg0);
        0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::assert_package_witness(arg0, 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::migration::package_witness(&arg3));
        let (v0, v1) = 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::migration::protocol_bps(&arg3);
        let v2 = ProtocolBps{
            meme_bps  : v0,
            quote_bps : v1,
        };
        let v3 = VaultKey{
            package_witness : 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::migration::package_witness(&arg3),
            origin          : 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::migration::origin(&arg3),
        };
        let v4 = 0x2::derived_object::claim<VaultKey>(0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::uid_mut(arg0), v3);
        let v5 = FeeSplitKey{dummy_field: false};
        let v6 = ProtocolBpsKey{dummy_field: false};
        let v7 = RoundPublicationKey{dummy_field: false};
        let v8 = VaultWitness{dummy_field: false};
        Vault<T0, T1>{
            id                : v4,
            terms             : arg3,
            venue             : 0x1::type_name::with_original_ids<T2>(),
            pool_id           : arg4,
            fee_split         : 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::new<FeeSplitKey, 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::fee_split::FeeSplit>(v5, &v4, 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::migration::fee_split(&arg3), 172800000),
            protocol_bps      : 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::new<ProtocolBpsKey, ProtocolBps>(v6, &v4, v2, 172800000),
            protocol          : 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::protocol_fees::new<T0, T1, VaultWitness>(v8, &v4, 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::migration::partner_id(&arg3)),
            owner_meme        : 0x2::balance::zero<T0>(),
            owner_quote       : 0x2::balance::zero<T1>(),
            auto_lp_meme      : 0x2::balance::zero<T0>(),
            auto_lp_quote     : 0x2::balance::zero<T1>(),
            rewards_meme      : 0x2::balance::zero<T0>(),
            rewards_quote     : 0x2::balance::zero<T1>(),
            burn_quote        : 0x2::balance::zero<T1>(),
            next_round        : 0,
            last_checkpoint   : 0x1::option::none<u64>(),
            round_publication : 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_action::new<RoundPublicationKey, RoundTerms>(v7, &v4, 7200000),
        }
    }

    public fun apply_fee_split<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &T2, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>, arg3: &0x2::clock::Clock) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>(arg2, 1);
        assert_position<T0, T1, T2>(arg0);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::apply<FeeSplitKey, 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::fee_split::FeeSplit>(&mut arg0.fee_split, arg3);
    }

    public fun apply_protocol_bps<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>, arg2: &0x2::clock::Clock) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>(arg1, 1);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_not_paused<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>(arg1, 1);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::apply<ProtocolBpsKey, ProtocolBps>(&mut arg0.protocol_bps, arg2);
    }

    public(friend) fun apply_round_publication_delay<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2::clock::Clock) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_action::apply_delay<RoundPublicationKey, RoundTerms>(&mut arg0.round_publication, arg1);
    }

    public fun assert_fee_split_ready<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x2::clock::Clock) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::assert_ready<FeeSplitKey, 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::fee_split::FeeSplit>(&arg0.fee_split, arg1);
    }

    fun assert_position<T0, T1, T2>(arg0: &Vault<T0, T1>) {
        let v0 = PositionKey<T2>{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists<PositionKey<T2>>(&arg0.id, v0), 5);
    }

    public fun attach_auto_lp_position<T0, T1, T2, T3: store + key>(arg0: &mut Vault<T0, T1>, arg1: &T2, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>, arg3: T3) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>(arg2, 1);
        assert_position<T0, T1, T2>(arg0);
        let v0 = AutoLpPositionKey<T2>{dummy_field: false};
        0x2::dynamic_object_field::add<AutoLpPositionKey<T2>, T3>(&mut arg0.id, v0, arg3);
        0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_events::auto_lp_position_opened<T0, T1>(0x2::object::uid_to_inner(&arg0.id), 0x2::object::id<T3>(&arg3));
    }

    public fun auto_lp_position<T0, T1, T2, T3: store + key>(arg0: &Vault<T0, T1>, arg1: &T2) : &T3 {
        let v0 = AutoLpPositionKey<T2>{dummy_field: false};
        0x2::dynamic_object_field::borrow<AutoLpPositionKey<T2>, T3>(&arg0.id, v0)
    }

    public fun auto_lp_position_mut<T0, T1, T2, T3: store + key>(arg0: &mut Vault<T0, T1>, arg1: &T2, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>) : &mut T3 {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>(arg2, 1);
        let v0 = AutoLpPositionKey<T2>{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<AutoLpPositionKey<T2>, T3>(&mut arg0.id, v0)
    }

    fun burn<T0>(arg0: &mut 0x2::coin_registry::Currency<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin_registry::is_supply_burn_only<T0>(arg0)) {
            0x2::coin_registry::burn_balance<T0>(arg0, arg1);
            return
        };
        0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::payout::pay_all<T0>(arg1, @0x0, arg2);
    }

    public fun burn_buyback<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &T2, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>, arg3: BuybackReceipt, arg4: &mut 0x2::coin_registry::Currency<T0>, arg5: 0x2::balance::Balance<T0>, arg6: 0x2::balance::Balance<T1>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>(arg2, 1);
        assert_position<T0, T1, T2>(arg0);
        let BuybackReceipt {
            vault_id    : v0,
            taken_quote : v1,
        } = arg3;
        assert!(v0 == 0x2::object::uid_to_inner(&arg0.id), 29);
        assert!(0x2::balance::value<T1>(&arg6) <= v1, 34);
        let v2 = 0x2::balance::value<T0>(&arg5);
        assert!(v2 >= arg7, 8);
        burn<T0>(arg4, arg5, arg8);
        0x2::balance::join<T1>(&mut arg0.burn_quote, arg6);
        0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_events::buyback_burned<T0, T1>(0x2::object::uid_to_inner(&arg0.id), v1 - 0x2::balance::value<T1>(&arg6), v2, 0x2::balance::value<T1>(&arg0.burn_quote));
    }

    public fun cancel_fee_split<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::owner_proof::OwnerProof, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>(arg2, 1);
        0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::owner_proof::assert_terms(arg1, &arg0.terms);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::cancel<FeeSplitKey, 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::fee_split::FeeSplit>(&mut arg0.fee_split);
    }

    public fun cancel_protocol_bps<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_acl::AdminWitness<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::blast_domain::CancelAdmin>, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>(arg2, 1);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::cancel<ProtocolBpsKey, ProtocolBps>(&mut arg0.protocol_bps);
    }

    public(friend) fun cancel_round_publication<T0, T1>(arg0: &mut Vault<T0, T1>) {
        let v0 = 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_action::pending<RoundPublicationKey, RoundTerms>(&arg0.round_publication);
        let v1 = &v0;
        let v2 = if (0x1::option::is_none<0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::Proposal<0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_action::Change<RoundTerms>>>(v1)) {
            true
        } else {
            let v3 = 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::proposal_value<0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_action::Change<RoundTerms>>(0x1::option::borrow<0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::Proposal<0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_action::Change<RoundTerms>>>(v1));
            let v4 = 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_action::action<RoundTerms>(&v3);
            0x1::option::is_some<RoundTerms>(&v4)
        };
        assert!(v2, 20);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_action::cancel<RoundPublicationKey, RoundTerms>(&mut arg0.round_publication);
    }

    public(friend) fun cancel_round_publication_delay<T0, T1>(arg0: &mut Vault<T0, T1>) {
        let v0 = 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_action::pending<RoundPublicationKey, RoundTerms>(&arg0.round_publication);
        let v1 = &v0;
        let v2 = if (0x1::option::is_none<0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::Proposal<0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_action::Change<RoundTerms>>>(v1)) {
            true
        } else {
            let v3 = 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::proposal_value<0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_action::Change<RoundTerms>>(0x1::option::borrow<0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::Proposal<0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_action::Change<RoundTerms>>>(v1));
            let v4 = 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_action::action<RoundTerms>(&v3);
            0x1::option::is_none<RoundTerms>(&v4)
        };
        assert!(v2, 20);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_action::cancel<RoundPublicationKey, RoundTerms>(&mut arg0.round_publication);
    }

    public fun claim_owner_balances<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::owner_proof::OwnerProof, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>(arg2, 1);
        0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::owner_proof::assert_terms(arg1, &arg0.terms);
        assert!(0x2::balance::value<T0>(&arg0.owner_meme) > 0 || 0x2::balance::value<T1>(&arg0.owner_quote) > 0, 6);
        let v0 = 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.owner_meme), arg3);
        let v1 = 0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.owner_quote), arg3);
        0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_events::owner_balances_claimed<T0, T1>(0x2::object::uid_to_inner(&arg0.id), 0x2::coin::value<T0>(&v0), 0x2::coin::value<T1>(&v1));
        (v0, v1)
    }

    public(friend) fun claim_window_duration_ms(arg0: &RoundTerms) : u64 {
        arg0.claim_window_duration_ms
    }

    public(friend) fun end_checkpoint(arg0: &RoundTerms) : u64 {
        arg0.end_checkpoint
    }

    public(friend) fun expected_treasury(arg0: &RoundTerms) : address {
        arg0.expected_treasury
    }

    public(friend) fun fund_round<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: u64, arg3: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        arg0.next_round = arg0.next_round + 1;
        arg0.last_checkpoint = 0x1::option::some<u64>(arg1);
        (0x2::balance::split<T0>(&mut arg0.rewards_meme, arg2), 0x2::balance::split<T1>(&mut arg0.rewards_quote, arg3))
    }

    public(friend) fun gas_reserve_amount(arg0: &RoundTerms) : u64 {
        arg0.gas_reserve_amount
    }

    public fun has_auto_lp_position<T0, T1, T2>(arg0: &Vault<T0, T1>, arg1: &T2) : bool {
        let v0 = AutoLpPositionKey<T2>{dummy_field: false};
        0x2::dynamic_object_field::exists<AutoLpPositionKey<T2>>(&arg0.id, v0)
    }

    public fun keep_auto_lp<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &T2, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>, arg3: AutoLpReceipt, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<T1>) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>(arg2, 1);
        assert_position<T0, T1, T2>(arg0);
        let AutoLpReceipt {
            vault_id    : v0,
            taken_meme  : v1,
            taken_quote : v2,
        } = arg3;
        assert!(v0 == 0x2::object::uid_to_inner(&arg0.id), 29);
        assert!(0x2::balance::value<T0>(&arg4) <= v1 && 0x2::balance::value<T1>(&arg5) <= v2, 34);
        let v3 = v1 - 0x2::balance::value<T0>(&arg4);
        let v4 = v2 - 0x2::balance::value<T1>(&arg5);
        0x2::balance::join<T0>(&mut arg0.auto_lp_meme, arg4);
        0x2::balance::join<T1>(&mut arg0.auto_lp_quote, arg5);
        if (v3 == 0 && v4 == 0) {
            return
        };
        0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_events::auto_liquidity_added<T0, T1>(0x2::object::uid_to_inner(&arg0.id), v3, v4, 0x2::balance::value<T0>(&arg0.auto_lp_meme), 0x2::balance::value<T1>(&arg0.auto_lp_quote));
    }

    public(friend) fun last_checkpoint<T0, T1>(arg0: &Vault<T0, T1>) : 0x1::option::Option<u64> {
        arg0.last_checkpoint
    }

    public(friend) fun leaf_count(arg0: &RoundTerms) : u64 {
        arg0.leaf_count
    }

    public(friend) fun manifest_digest(arg0: &RoundTerms) : vector<u8> {
        arg0.manifest_digest
    }

    public(friend) fun meme_amount(arg0: &RoundTerms) : u64 {
        arg0.meme_amount
    }

    fun new_protocol_bps(arg0: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps, arg1: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps) : ProtocolBps {
        assert!(0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::value(arg0) <= 3000 && 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::value(arg1) <= 3000, 3);
        ProtocolBps{
            meme_bps  : arg0,
            quote_bps : arg1,
        }
    }

    public(friend) fun new_round_terms(arg0: u64, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: address) : RoundTerms {
        assert!(0x1::vector::length<u8>(&arg3) == 32 && 0x1::vector::length<u8>(&arg4) == 32, 9);
        assert!(arg5 > 0 && arg5 <= 65536, 10);
        assert!(arg6 > 0 || arg7 > 0, 11);
        assert!(arg1 < arg2, 12);
        let v0 = 0x1::u64::checked_add(arg7, arg8);
        assert!(0x1::option::is_some<u64>(&v0), 13);
        assert!((arg8 as u128) * 10000 <= (arg7 as u128) * 1000, 14);
        assert!(arg10 != @0x0, 15);
        assert!(arg9 > 0, 16);
        RoundTerms{
            number                   : arg0,
            start_checkpoint         : arg1,
            end_checkpoint           : arg2,
            root                     : arg3,
            manifest_digest          : arg4,
            leaf_count               : arg5,
            meme_amount              : arg6,
            quote_amount             : arg7,
            gas_reserve_amount       : arg8,
            claim_window_duration_ms : arg9,
            expected_treasury        : arg10,
        }
    }

    public(friend) fun next_round<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.next_round
    }

    public(friend) fun number(arg0: &RoundTerms) : u64 {
        arg0.number
    }

    public fun pay_protocol_fees_with_partner<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>, arg2: &0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::blast_treasury::Treasury, arg3: &0x2998c10c91e46082548b2f3205f84f09377bbbedf2b0f617f70575a09ec69a54::blast_partners::Partner, arg4: &mut 0x2::tx_context::TxContext) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>(arg1, 1);
        0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::protocol_fees::pay_with_partner<T0, T1>(&mut arg0.protocol, arg2, arg3, arg4);
    }

    public fun pool_id<T0, T1>(arg0: &Vault<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun position_mut<T0, T1, T2, T3: store + key>(arg0: &mut Vault<T0, T1>, arg1: &T2, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>) : &mut T3 {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>(arg2, 1);
        let v0 = PositionKey<T2>{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<PositionKey<T2>, T3>(&mut arg0.id, v0)
    }

    public(friend) fun quote_amount(arg0: &RoundTerms) : u64 {
        arg0.quote_amount
    }

    public(friend) fun restore_rewards<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T0>(&mut arg0.rewards_meme, arg1);
        0x2::balance::join<T1>(&mut arg0.rewards_quote, arg2);
    }

    public(friend) fun rewards_balances<T0, T1>(arg0: &Vault<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.rewards_meme), 0x2::balance::value<T1>(&arg0.rewards_quote))
    }

    public(friend) fun root(arg0: &RoundTerms) : vector<u8> {
        arg0.root
    }

    fun route_fees<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::fee_split::Destination, arg2: &mut 0x2::coin_registry::Currency<T0>, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::fee_split::address_of(&arg1);
        if (0x1::option::is_some<address>(&v0)) {
            let v1 = 0x1::option::destroy_some<address>(v0);
            0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::payout::pay_all<T0>(arg3, v1, arg5);
            0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::payout::pay_all<T1>(arg4, v1, arg5);
        } else if (0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::fee_split::is_owner(&arg1)) {
            0x2::balance::join<T0>(&mut arg0.owner_meme, arg3);
            0x2::balance::join<T1>(&mut arg0.owner_quote, arg4);
        } else if (0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::fee_split::is_auto_lp(&arg1)) {
            0x2::balance::join<T0>(&mut arg0.auto_lp_meme, arg3);
            0x2::balance::join<T1>(&mut arg0.auto_lp_quote, arg4);
        } else if (0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::fee_split::is_holder_rewards(&arg1)) {
            0x2::balance::join<T0>(&mut arg0.rewards_meme, arg3);
            0x2::balance::join<T1>(&mut arg0.rewards_quote, arg4);
        } else {
            burn<T0>(arg2, arg3, arg5);
            0x2::balance::join<T1>(&mut arg0.burn_quote, arg4);
        };
    }

    public fun schedule_fee_split<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::owner_proof::OwnerProof, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>, arg3: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::fee_split::FeeSplit, arg4: &0x2::clock::Clock) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>(arg2, 1);
        0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::owner_proof::assert_terms(arg1, &arg0.terms);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::schedule_value<FeeSplitKey, 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::fee_split::FeeSplit>(&mut arg0.fee_split, arg3, arg4);
    }

    public fun schedule_protocol_bps<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_acl::AdminWitness<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::blast_domain::FeeAdmin>, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>, arg3: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps, arg4: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps, arg5: &0x2::clock::Clock) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>(arg2, 1);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_not_paused<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>(arg2, 1);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::schedule_value<ProtocolBpsKey, ProtocolBps>(&mut arg0.protocol_bps, new_protocol_bps(arg3, arg4), arg5);
    }

    public(friend) fun schedule_round_publication<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: RoundTerms, arg2: &0x2::clock::Clock) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_action::schedule<RoundPublicationKey, RoundTerms>(&mut arg0.round_publication, arg1, arg2);
    }

    public(friend) fun schedule_round_publication_delay<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_action::schedule_delay<RoundPublicationKey, RoundTerms>(&mut arg0.round_publication, arg1, arg2);
    }

    public fun share_with_position<T0, T1, T2, T3: store + key>(arg0: Vault<T0, T1>, arg1: &T2, arg2: &0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::blast_treasury::Treasury, arg3: T3, arg4: u128, arg5: 0x2::balance::Balance<T0>, arg6: 0x2::balance::Balance<T1>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.venue == 0x1::type_name::with_original_ids<T2>(), 5);
        assert!(arg4 > 0, 4);
        let v0 = PositionKey<T2>{dummy_field: false};
        0x2::dynamic_object_field::add<PositionKey<T2>, T3>(&mut arg0.id, v0, arg3);
        let v1 = 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::migration::residuals(&arg0.terms);
        if (0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::migration::is_protocol(&v1)) {
            0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::protocol_fees::accrue<T0, T1>(&mut arg0.protocol, arg5, arg6);
            let v2 = 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::migration::partner_id(&arg0.terms);
            if (0x1::option::is_none<0x2::object::ID>(&v2)) {
                0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::protocol_fees::pay<T0, T1>(&mut arg0.protocol, arg2, arg7);
            };
        } else {
            0x2::balance::join<T0>(&mut arg0.owner_meme, arg5);
            0x2::balance::join<T1>(&mut arg0.owner_quote, arg6);
        };
        0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_events::vault_created<T0, T1, T2>(0x2::object::uid_to_inner(&arg0.id), arg0.pool_id, 0x2::object::id<T3>(&arg3), arg4, arg0.terms, 0x2::balance::value<T0>(&arg5), 0x2::balance::value<T1>(&arg6));
        0x2::transfer::share_object<Vault<T0, T1>>(arg0);
    }

    public fun split_fees<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &T2, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>, arg3: &0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::blast_treasury::Treasury, arg4: &mut 0x2::coin_registry::Currency<T0>, arg5: 0x2::balance::Balance<T0>, arg6: 0x2::balance::Balance<T1>, arg7: &mut 0x2::tx_context::TxContext) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>(arg2, 1);
        assert_position<T0, T1, T2>(arg0);
        let v0 = 0x2::balance::value<T0>(&arg5);
        let v1 = 0x2::balance::value<T1>(&arg6);
        if (v0 == 0 && v1 == 0) {
            0x2::balance::destroy_zero<T0>(arg5);
            0x2::balance::destroy_zero<T1>(arg6);
            return
        };
        let ProtocolBps {
            meme_bps  : v2,
            quote_bps : v3,
        } = 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::value<ProtocolBpsKey, ProtocolBps>(&arg0.protocol_bps);
        let (v4, v5) = 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::protocol_fees::take_cut<T0, T1>(&mut arg0.protocol, &mut arg5, &mut arg6, v2, v3);
        let v6 = 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::migration::partner_id(&arg0.terms);
        if (0x1::option::is_none<0x2::object::ID>(&v6)) {
            0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::protocol_fees::pay<T0, T1>(&mut arg0.protocol, arg3, arg7);
        };
        let v7 = 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::value<FeeSplitKey, 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::fee_split::FeeSplit>(&arg0.fee_split);
        let v8 = 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::fee_split::apportion(&v7, 0x2::balance::value<T0>(&arg5));
        let v9 = 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::fee_split::apportion(&v7, 0x2::balance::value<T1>(&arg6));
        let v10 = 0;
        while (v10 < 0x1::vector::length<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::fee_split::Route>(0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::fee_split::routes(&v7))) {
            route_fees<T0, T1>(arg0, 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::fee_split::destination(0x1::vector::borrow<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::fee_split::Route>(0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::fee_split::routes(&v7), v10)), arg4, 0x2::balance::split<T0>(&mut arg5, *0x1::vector::borrow<u64>(&v8, v10)), 0x2::balance::split<T1>(&mut arg6, *0x1::vector::borrow<u64>(&v9, v10)), arg7);
            v10 = v10 + 1;
        };
        0x2::balance::destroy_zero<T0>(arg5);
        0x2::balance::destroy_zero<T1>(arg6);
        0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_events::fees_collected<T0, T1>(0x2::object::uid_to_inner(&arg0.id), v0, v1, v4, v5, v8, v9);
    }

    public(friend) fun start_checkpoint(arg0: &RoundTerms) : u64 {
        arg0.start_checkpoint
    }

    public fun take_auto_lp<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &T2, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, AutoLpReceipt) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>(arg2, 1);
        assert_position<T0, T1, T2>(arg0);
        let v0 = 0x2::balance::withdraw_all<T0>(&mut arg0.auto_lp_meme);
        let v1 = 0x2::balance::withdraw_all<T1>(&mut arg0.auto_lp_quote);
        let v2 = AutoLpReceipt{
            vault_id    : 0x2::object::uid_to_inner(&arg0.id),
            taken_meme  : 0x2::balance::value<T0>(&v0),
            taken_quote : 0x2::balance::value<T1>(&v1),
        };
        (v0, v1, v2)
    }

    public fun take_buyback_quote<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &T2, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_acl::AdminWitness<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::blast_domain::BuybackAdmin>, arg3: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>, arg4: u64) : (0x2::balance::Balance<T1>, BuybackReceipt) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>(arg3, 1);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_not_paused<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>(arg3, 1);
        assert_position<T0, T1, T2>(arg0);
        assert!(arg4 > 0 && arg4 <= 0x2::balance::value<T1>(&arg0.burn_quote), 7);
        let v0 = BuybackReceipt{
            vault_id    : 0x2::object::uid_to_inner(&arg0.id),
            taken_quote : arg4,
        };
        (0x2::balance::split<T1>(&mut arg0.burn_quote, arg4), v0)
    }

    public(friend) fun take_round_publication<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2::clock::Clock) : RoundTerms {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_action::take_action<RoundPublicationKey, RoundTerms>(&mut arg0.round_publication, arg1)
    }

    // decompiled from Move bytecode v7
}

