module 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::vault {
    struct VaultIssuance<phantom T0, phantom T1> {
        issuance: 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::Issuance<T0>,
        treasury_cap: 0x2::coin::TreasuryCap<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boost::BlastBoost<T0>>,
        metadata_cap: 0x2::coin_registry::MetadataCap<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boost::BlastBoost<T0>>,
    }

    struct Vault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        state: 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::State<T0>,
        venue_account: 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::venue_account::VenueAccount,
        locked_shares: u64,
        admin_cash: 0x2::balance::Balance<T1>,
        terminal_cash: 0x2::balance::Balance<T1>,
    }

    struct TreasuryKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct MetadataKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun id<T0, T1>(arg0: &Vault<T0, T1>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun state<T0, T1>(arg0: &Vault<T0, T1>) : &0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::State<T0> {
        &arg0.state
    }

    public(friend) fun activate<T0, T1>(arg0: VaultIssuance<T0, T1>, arg1: 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::PositionObservation, arg2: u64, arg3: 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::venue_account::VenueAccount, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (Vault<T0, T1>, u64, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::ActivePosition) {
        let VaultIssuance {
            issuance     : v0,
            treasury_cap : v1,
            metadata_cap : v2,
        } = arg0;
        let v3 = v1;
        let (v4, v5, v6) = 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::activate<T0>(v0, arg1, arg2, arg4);
        let v7 = seed_shares(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boost::BlastBoost<T0>>>(0x2::coin::mint<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boost::BlastBoost<T0>>(&mut v3, v7, arg5), @0x0);
        let v8 = Vault<T0, T1>{
            id            : 0x2::object::new(arg5),
            state         : v4,
            venue_account : arg3,
            locked_shares : v7,
            admin_cash    : 0x2::balance::zero<T1>(),
            terminal_cash : 0x2::balance::zero<T1>(),
        };
        let v9 = TreasuryKey<T0>{dummy_field: false};
        0x2::dynamic_object_field::add<TreasuryKey<T0>, 0x2::coin::TreasuryCap<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boost::BlastBoost<T0>>>(&mut v8.id, v9, v3);
        let v10 = MetadataKey<T0>{dummy_field: false};
        0x2::dynamic_object_field::add<MetadataKey<T0>, 0x2::coin_registry::MetadataCap<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boost::BlastBoost<T0>>>(&mut v8.id, v10, v2);
        (v8, v5, v6)
    }

    public fun begin_shutdown<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::protocol::Protocol, arg2: &0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::acl::AdminWitness<0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::blast_boosts_core::BLAST_BOOSTS_CORE>, arg3: 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::lifecycle::ShutdownReason) {
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::protocol::assert_current(arg1);
        0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::acl::assert_role<0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::blast_boosts_core::BLAST_BOOSTS_CORE>(arg2, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::blast_boosts_core::shutdown_admin_role());
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::begin_shutdown<T0>(&mut arg0.state);
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::events::shutdown_begun<T0>(0x2::object::uid_to_inner(&arg0.id), arg3);
    }

    public fun issue<T0, T1>(arg0: &0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::protocol::Protocol, arg1: &0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::acl::AdminWitness<0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::blast_boosts_core::BLAST_BOOSTS_CORE>, arg2: &mut 0x2::coin_registry::CoinRegistry, arg3: 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::VaultPolicy, arg4: u64, arg5: u64, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: &mut 0x2::tx_context::TxContext) : VaultIssuance<T0, T1> {
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::protocol::assert_current(arg0);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(!0x1::type_name::is_primitive(&v0), 1);
        let (v1, v2) = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boost::new_currency<T0>(arg2, arg6, arg7, arg8, arg9, arg10);
        let v3 = v2;
        let v4 = v1;
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::events::vault_issued<T0>(0x2::object::id<0x2::coin::TreasuryCap<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boost::BlastBoost<T0>>>(&v4), 0x2::object::id<0x2::coin_registry::MetadataCap<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boost::BlastBoost<T0>>>(&v3), arg3, arg4, arg5);
        VaultIssuance<T0, T1>{
            issuance     : 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::issue<T0>(arg1, arg3, arg4, arg5, 9, 6),
            treasury_cap : v4,
            metadata_cap : v3,
        }
    }

    public fun set_fees<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::protocol::Protocol, arg2: &0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::acl::AdminWitness<0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::blast_boosts_core::BLAST_BOOSTS_CORE>, arg3: u64, arg4: u64, arg5: u64) {
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::protocol::assert_current(arg1);
        0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::acl::assert_role<0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::blast_boosts_core::BLAST_BOOSTS_CORE>(arg2, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::blast_boosts_core::risk_admin_role());
        let (v0, v1, v2) = 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::set_fees<T0>(&mut arg0.state, arg3, arg4, arg5);
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::events::fees_updated<T0>(0x2::object::uid_to_inner(&arg0.id), v0, v1, v2, arg3, arg4, arg5);
    }

    public fun set_max_order_notional<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::protocol::Protocol, arg2: &0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::acl::AdminWitness<0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::blast_boosts_core::BLAST_BOOSTS_CORE>, arg3: u64) {
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::protocol::assert_current(arg1);
        0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::acl::assert_role<0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::blast_boosts_core::BLAST_BOOSTS_CORE>(arg2, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::blast_boosts_core::risk_admin_role());
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::events::max_order_notional_updated<T0>(0x2::object::uid_to_inner(&arg0.id), 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::set_max_order_notional<T0>(&mut arg0.state, arg3), arg3);
    }

    public fun set_nav_cap<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::protocol::Protocol, arg2: &0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::acl::AdminWitness<0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::blast_boosts_core::BLAST_BOOSTS_CORE>, arg3: u64) {
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::protocol::assert_current(arg1);
        0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::acl::assert_role<0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::blast_boosts_core::BLAST_BOOSTS_CORE>(arg2, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::blast_boosts_core::risk_admin_role());
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::events::nav_cap_updated<T0>(0x2::object::uid_to_inner(&arg0.id), 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::set_nav_cap<T0>(&mut arg0.state, arg3), arg3);
    }

    public(friend) fun admin_cash_balance<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.admin_cash)
    }

    public(friend) fun burn_redeemed_shares<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boost::BlastBoost<T0>>) : u64 {
        0x2::coin::burn<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boost::BlastBoost<T0>>(treasury_cap_mut<T0, T1>(arg0), arg1)
    }

    public(friend) fun issuance<T0, T1>(arg0: &VaultIssuance<T0, T1>) : &0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::Issuance<T0> {
        &arg0.issuance
    }

    public(friend) fun locked_shares<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.locked_shares
    }

    fun metadata_cap<T0, T1>(arg0: &Vault<T0, T1>) : &0x2::coin_registry::MetadataCap<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boost::BlastBoost<T0>> {
        let v0 = MetadataKey<T0>{dummy_field: false};
        0x2::dynamic_object_field::borrow<MetadataKey<T0>, 0x2::coin_registry::MetadataCap<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boost::BlastBoost<T0>>>(&arg0.id, v0)
    }

    public(friend) fun mint_shares<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boost::BlastBoost<T0>> {
        0x2::coin::mint<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boost::BlastBoost<T0>>(treasury_cap_mut<T0, T1>(arg0), arg1, arg2)
    }

    public fun redeem_shutdown<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::protocol::Protocol, arg2: 0x2::coin::Coin<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boost::BlastBoost<T0>>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::protocol::assert_current(arg1);
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::assert_settled<T0>(&arg0.state);
        assert!(0x2::clock::timestamp_ms(arg5) <= arg4, 28);
        let v0 = 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::shutdown_claim_quote<T0>(&arg0.state, 0x2::balance::value<T1>(&arg0.terminal_cash), total_share_supply<T0, T1>(arg0), arg0.locked_shares, 0x2::coin::value<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boost::BlastBoost<T0>>(&arg2), arg3);
        let v1 = burn_redeemed_shares<T0, T1>(arg0, arg2);
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::events::shutdown_redeemed<T0>(0x2::object::uid_to_inner(&arg0.id), v1, v0, 0x2::balance::value<T1>(&arg0.terminal_cash), total_share_supply<T0, T1>(arg0) - arg0.locked_shares);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.terminal_cash, v0), arg6)
    }

    public(friend) fun retain_admin_cash<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T1>) {
        0x2::balance::join<T1>(&mut arg0.admin_cash, 0x2::coin::into_balance<T1>(arg1));
    }

    public(friend) fun seal_terminal_cash<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64) {
        if (arg2 == 0) {
            retain_admin_cash<T0, T1>(arg0, arg1);
        } else {
            0x2::balance::join<T1>(&mut arg0.terminal_cash, 0x2::coin::into_balance<T1>(arg1));
        };
    }

    fun seed_shares(arg0: u64) : u64 {
        let v0 = 0x1::u64::checked_mul(arg0, 1000);
        if (0x1::option::is_some<u64>(&v0)) {
            return 0x1::option::destroy_some<u64>(v0)
        } else {
            0x1::option::destroy_none<u64>(v0);
            abort 19
        };
    }

    public fun share<T0, T1>(arg0: Vault<T0, T1>) {
        0x2::transfer::share_object<Vault<T0, T1>>(arg0);
    }

    public(friend) fun state_mut<T0, T1>(arg0: &mut Vault<T0, T1>) : &mut 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::State<T0> {
        &mut arg0.state
    }

    public(friend) fun total_share_supply<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::coin::total_supply<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boost::BlastBoost<T0>>(treasury_cap<T0, T1>(arg0))
    }

    fun treasury_cap<T0, T1>(arg0: &Vault<T0, T1>) : &0x2::coin::TreasuryCap<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boost::BlastBoost<T0>> {
        let v0 = TreasuryKey<T0>{dummy_field: false};
        0x2::dynamic_object_field::borrow<TreasuryKey<T0>, 0x2::coin::TreasuryCap<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boost::BlastBoost<T0>>>(&arg0.id, v0)
    }

    public(friend) fun treasury_cap_id<T0, T1>(arg0: &Vault<T0, T1>) : 0x2::object::ID {
        0x2::object::id<0x2::coin::TreasuryCap<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boost::BlastBoost<T0>>>(treasury_cap<T0, T1>(arg0))
    }

    fun treasury_cap_mut<T0, T1>(arg0: &mut Vault<T0, T1>) : &mut 0x2::coin::TreasuryCap<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boost::BlastBoost<T0>> {
        let v0 = TreasuryKey<T0>{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<TreasuryKey<T0>, 0x2::coin::TreasuryCap<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boost::BlastBoost<T0>>>(&mut arg0.id, v0)
    }

    public fun update_metadata<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::protocol::Protocol, arg2: &0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::acl::AdminWitness<0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::blast_boosts_core::BLAST_BOOSTS_CORE>, arg3: &mut 0x2::coin_registry::Currency<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boost::BlastBoost<T0>>, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String) {
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::protocol::assert_current(arg1);
        0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::acl::assert_role<0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::blast_boosts_core::BLAST_BOOSTS_CORE>(arg2, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::blast_boosts_core::vault_issuer_role());
        let v0 = if (0x2::coin_registry::name<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boost::BlastBoost<T0>>(arg3) != arg4) {
            true
        } else if (0x2::coin_registry::description<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boost::BlastBoost<T0>>(arg3) != arg5) {
            true
        } else {
            0x2::coin_registry::icon_url<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boost::BlastBoost<T0>>(arg3) != arg6
        };
        assert!(v0, 36);
        let v1 = metadata_cap<T0, T1>(arg0);
        0x2::coin_registry::set_name<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boost::BlastBoost<T0>>(arg3, v1, arg4);
        0x2::coin_registry::set_description<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boost::BlastBoost<T0>>(arg3, v1, arg5);
        0x2::coin_registry::set_icon_url<0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boost::BlastBoost<T0>>(arg3, v1, arg6);
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::events::metadata_updated<T0>(0x2::object::uid_to_inner(&arg0.id), arg4, arg5, arg6);
    }

    public(friend) fun venue<T0, T1>(arg0: &Vault<T0, T1>) : &0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::venue_account::VenueAccount {
        &arg0.venue_account
    }

    public(friend) fun venue_mut<T0, T1>(arg0: &mut Vault<T0, T1>) : &mut 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::venue_account::VenueAccount {
        &mut arg0.venue_account
    }

    public fun withdraw_admin_fees<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::protocol::Protocol, arg2: &0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::acl::AdminWitness<0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::blast_boosts_core::BLAST_BOOSTS_CORE>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::protocol::assert_current(arg1);
        0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::acl::assert_role<0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::blast_boosts_core::BLAST_BOOSTS_CORE>(arg2, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::blast_boosts_core::risk_admin_role());
        assert!(arg3 > 0, 21);
        let v0 = 0x2::balance::value<T1>(&arg0.admin_cash);
        assert!(arg3 <= v0, 22);
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::events::admin_fees_withdrawn<T0>(0x2::object::uid_to_inner(&arg0.id), arg3, v0 - arg3);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.admin_cash, arg3), arg4)
    }

    // decompiled from Move bytecode v7
}

