module 0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::vault {
    struct VaultIssuance<phantom T0, phantom T1> {
        issuance: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::Issuance<T0>,
        treasury_cap: 0x2::coin::TreasuryCap<0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::blast_boost::BlastBoost<T0>>,
        metadata_cap: 0x2::coin_registry::MetadataCap<0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::blast_boost::BlastBoost<T0>>,
    }

    struct Vault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        state: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::State<T0>,
        venue_account: 0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::venue_account::VenueAccount,
        locked_shares: u64,
        admin_cash: 0x2::balance::Balance<T1>,
        terminal_cash: 0x2::balance::Balance<T1>,
        protected_cash: 0x2::balance::Balance<T1>,
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

    public(friend) fun activate<T0, T1>(arg0: VaultIssuance<T0, T1>, arg1: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::PositionObservation, arg2: u64, arg3: 0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::venue_account::VenueAccount, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (Vault<T0, T1>, u64, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::ActivePosition) {
        let VaultIssuance {
            issuance     : v0,
            treasury_cap : v1,
            metadata_cap : v2,
        } = arg0;
        let v3 = v1;
        let (v4, v5, v6) = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::activate<T0>(v0, arg1, arg2, arg4);
        let v7 = seed_shares(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::blast_boost::BlastBoost<T0>>>(0x2::coin::mint<0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::blast_boost::BlastBoost<T0>>(&mut v3, v7, arg5), @0x0);
        let v8 = Vault<T0, T1>{
            id             : 0x2::object::new(arg5),
            state          : v4,
            venue_account  : arg3,
            locked_shares  : v7,
            admin_cash     : 0x2::balance::zero<T1>(),
            terminal_cash  : 0x2::balance::zero<T1>(),
            protected_cash : 0x2::balance::zero<T1>(),
        };
        let v9 = TreasuryKey<T0>{dummy_field: false};
        0x2::dynamic_object_field::add<TreasuryKey<T0>, 0x2::coin::TreasuryCap<0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::blast_boost::BlastBoost<T0>>>(&mut v8.id, v9, v3);
        let v10 = MetadataKey<T0>{dummy_field: false};
        0x2::dynamic_object_field::add<MetadataKey<T0>, 0x2::coin_registry::MetadataCap<0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::blast_boost::BlastBoost<T0>>>(&mut v8.id, v10, v2);
        (v8, v5, v6)
    }

    public(friend) fun state<T0, T1>(arg0: &Vault<T0, T1>) : &0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::State<T0> {
        &arg0.state
    }

    public(friend) fun admin_cash_balance<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.admin_cash)
    }

    public fun begin_shutdown<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::blast_boosts_aftermath::Protocol, arg2: &0x59f4f4f31d2a3290019f81bd4b794523f5d840659372e1bbda328965be3f5288::blast_acl::AdminWitness<0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::blast_boosts_core::ShutdownAdmin>, arg3: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::lifecycle::ShutdownReason, arg4: &0x2::clock::Clock) {
        0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::blast_boosts_aftermath::assert_current(arg1);
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::begin_shutdown<T0>(&mut arg0.state, 0x2::clock::timestamp_ms(arg4));
        0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::events::shutdown_begun<T0>(0x2::object::uid_to_inner(&arg0.id), arg3);
    }

    public(friend) fun burn_redeemed_shares<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::blast_boost::BlastBoost<T0>>) : u64 {
        0x2::coin::burn<0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::blast_boost::BlastBoost<T0>>(treasury_cap_mut<T0, T1>(arg0), arg1)
    }

    public(friend) fun issuance<T0, T1>(arg0: &VaultIssuance<T0, T1>) : &0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::Issuance<T0> {
        &arg0.issuance
    }

    public fun issue<T0, T1>(arg0: &0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::blast_boosts_aftermath::Protocol, arg1: &0x59f4f4f31d2a3290019f81bd4b794523f5d840659372e1bbda328965be3f5288::blast_acl::AdminWitness<0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::blast_boosts_core::VaultIssuer>, arg2: &mut 0x2::coin_registry::CoinRegistry, arg3: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::VaultPolicy, arg4: u64, arg5: u64, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: &mut 0x2::tx_context::TxContext) : VaultIssuance<T0, T1> {
        0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::blast_boosts_aftermath::assert_current(arg0);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(!0x1::type_name::is_primitive(&v0), 1);
        let (v1, v2) = 0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::blast_boost::new_currency<T0>(arg2, arg6, arg7, arg8, arg9, arg10);
        let v3 = v2;
        let v4 = v1;
        0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::events::vault_issued<T0>(0x2::object::id<0x2::coin::TreasuryCap<0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::blast_boost::BlastBoost<T0>>>(&v4), 0x2::object::id<0x2::coin_registry::MetadataCap<0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::blast_boost::BlastBoost<T0>>>(&v3), arg3, arg4, arg5);
        VaultIssuance<T0, T1>{
            issuance     : 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::issue<T0>(arg1, arg3, arg4, arg5, 9, 6),
            treasury_cap : v4,
            metadata_cap : v3,
        }
    }

    public(friend) fun locked_shares<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.locked_shares
    }

    fun metadata_cap<T0, T1>(arg0: &Vault<T0, T1>) : &0x2::coin_registry::MetadataCap<0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::blast_boost::BlastBoost<T0>> {
        let v0 = MetadataKey<T0>{dummy_field: false};
        0x2::dynamic_object_field::borrow<MetadataKey<T0>, 0x2::coin_registry::MetadataCap<0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::blast_boost::BlastBoost<T0>>>(&arg0.id, v0)
    }

    public(friend) fun mint_shares<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::blast_boost::BlastBoost<T0>> {
        0x2::coin::mint<0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::blast_boost::BlastBoost<T0>>(treasury_cap_mut<T0, T1>(arg0), arg1, arg2)
    }

    public fun redeem_shutdown<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::blast_boosts_aftermath::Protocol, arg2: 0x2::coin::Coin<0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::blast_boost::BlastBoost<T0>>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::blast_boosts_aftermath::assert_current(arg1);
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::assert_settled<T0>(&arg0.state);
        assert!(0x2::clock::timestamp_ms(arg5) <= arg4, 26);
        let v0 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::shutdown_claim_quote<T0>(&arg0.state, 0x2::balance::value<T1>(&arg0.terminal_cash), total_share_supply<T0, T1>(arg0), arg0.locked_shares, 0x2::coin::value<0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::blast_boost::BlastBoost<T0>>(&arg2), arg3);
        let v1 = burn_redeemed_shares<T0, T1>(arg0, arg2);
        0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::events::shutdown_redeemed<T0>(0x2::object::uid_to_inner(&arg0.id), v1, v0, 0x2::balance::value<T1>(&arg0.terminal_cash), total_share_supply<T0, T1>(arg0) - arg0.locked_shares);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.terminal_cash, v0), arg6)
    }

    public(friend) fun retain_admin_cash<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T1>(&mut arg0.admin_cash, arg1);
    }

    public(friend) fun seal_terminal_cash<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = 0x2::coin::into_balance<T1>(arg1);
        let v1 = arg3 + arg4;
        if (v1 > 0) {
            0x2::balance::join<T1>(&mut arg0.protected_cash, 0x2::balance::split<T1>(&mut v0, v1));
        };
        if (arg2 == 0) {
            retain_admin_cash<T0, T1>(arg0, v0);
        } else {
            0x2::balance::join<T1>(&mut arg0.terminal_cash, v0);
        };
    }

    fun seed_shares(arg0: u64) : u64 {
        let v0 = 0x1::u64::checked_mul(arg0, 1000);
        if (0x1::option::is_some<u64>(&v0)) {
            return 0x1::option::destroy_some<u64>(v0)
        } else {
            0x1::option::destroy_none<u64>(v0);
            abort 17
        };
    }

    public fun set_fees<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::blast_boosts_aftermath::Protocol, arg2: &0x59f4f4f31d2a3290019f81bd4b794523f5d840659372e1bbda328965be3f5288::blast_acl::AdminWitness<0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::blast_boosts_core::RiskAdmin>, arg3: u64, arg4: u64, arg5: u64) {
        0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::blast_boosts_aftermath::assert_current(arg1);
        let (v0, v1, v2) = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::set_fees<T0>(&mut arg0.state, arg3, arg4, arg5);
        0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::events::fees_updated<T0>(0x2::object::uid_to_inner(&arg0.id), v0, v1, v2, arg3, arg4, arg5);
    }

    public(friend) fun set_max_order_notional<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::blast_boosts_aftermath::Protocol, arg2: &0x59f4f4f31d2a3290019f81bd4b794523f5d840659372e1bbda328965be3f5288::blast_acl::AdminWitness<0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::blast_boosts_core::RiskAdmin>, arg3: u64, arg4: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::PriceObservation, arg5: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::PriceObservation, arg6: u64, arg7: u64) {
        0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::blast_boosts_aftermath::assert_current(arg1);
        0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::events::max_order_notional_updated<T0>(0x2::object::uid_to_inner(&arg0.id), 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::set_max_order_notional<T0>(&mut arg0.state, arg3, arg4, arg5, arg6, arg7), arg3);
    }

    public fun set_nav_cap<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::blast_boosts_aftermath::Protocol, arg2: &0x59f4f4f31d2a3290019f81bd4b794523f5d840659372e1bbda328965be3f5288::blast_acl::AdminWitness<0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::blast_boosts_core::RiskAdmin>, arg3: u64) {
        0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::blast_boosts_aftermath::assert_current(arg1);
        0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::events::nav_cap_updated<T0>(0x2::object::uid_to_inner(&arg0.id), 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::set_nav_cap<T0>(&mut arg0.state, arg3), arg3);
    }

    public fun share<T0, T1>(arg0: Vault<T0, T1>) {
        0x2::transfer::share_object<Vault<T0, T1>>(arg0);
    }

    public(friend) fun state_mut<T0, T1>(arg0: &mut Vault<T0, T1>) : &mut 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::State<T0> {
        &mut arg0.state
    }

    public(friend) fun take_admin_cash<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64) : 0x2::balance::Balance<T1> {
        0x2::balance::split<T1>(&mut arg0.admin_cash, arg1)
    }

    public(friend) fun total_share_supply<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::coin::total_supply<0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::blast_boost::BlastBoost<T0>>(treasury_cap<T0, T1>(arg0))
    }

    fun treasury_cap<T0, T1>(arg0: &Vault<T0, T1>) : &0x2::coin::TreasuryCap<0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::blast_boost::BlastBoost<T0>> {
        let v0 = TreasuryKey<T0>{dummy_field: false};
        0x2::dynamic_object_field::borrow<TreasuryKey<T0>, 0x2::coin::TreasuryCap<0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::blast_boost::BlastBoost<T0>>>(&arg0.id, v0)
    }

    public(friend) fun treasury_cap_id<T0, T1>(arg0: &Vault<T0, T1>) : 0x2::object::ID {
        0x2::object::id<0x2::coin::TreasuryCap<0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::blast_boost::BlastBoost<T0>>>(treasury_cap<T0, T1>(arg0))
    }

    fun treasury_cap_mut<T0, T1>(arg0: &mut Vault<T0, T1>) : &mut 0x2::coin::TreasuryCap<0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::blast_boost::BlastBoost<T0>> {
        let v0 = TreasuryKey<T0>{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<TreasuryKey<T0>, 0x2::coin::TreasuryCap<0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::blast_boost::BlastBoost<T0>>>(&mut arg0.id, v0)
    }

    public fun update_metadata<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::blast_boosts_aftermath::Protocol, arg2: &0x59f4f4f31d2a3290019f81bd4b794523f5d840659372e1bbda328965be3f5288::blast_acl::AdminWitness<0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::blast_boosts_core::VaultIssuer>, arg3: &mut 0x2::coin_registry::Currency<0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::blast_boost::BlastBoost<T0>>, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String) {
        0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::blast_boosts_aftermath::assert_current(arg1);
        let v0 = if (0x2::coin_registry::name<0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::blast_boost::BlastBoost<T0>>(arg3) != arg4) {
            true
        } else if (0x2::coin_registry::description<0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::blast_boost::BlastBoost<T0>>(arg3) != arg5) {
            true
        } else {
            0x2::coin_registry::icon_url<0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::blast_boost::BlastBoost<T0>>(arg3) != arg6
        };
        assert!(v0, 34);
        let v1 = metadata_cap<T0, T1>(arg0);
        0x2::coin_registry::set_name<0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::blast_boost::BlastBoost<T0>>(arg3, v1, arg4);
        0x2::coin_registry::set_description<0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::blast_boost::BlastBoost<T0>>(arg3, v1, arg5);
        0x2::coin_registry::set_icon_url<0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::blast_boost::BlastBoost<T0>>(arg3, v1, arg6);
        0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::events::metadata_updated<T0>(0x2::object::uid_to_inner(&arg0.id), arg4, arg5, arg6);
    }

    public(friend) fun venue<T0, T1>(arg0: &Vault<T0, T1>) : &0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::venue_account::VenueAccount {
        &arg0.venue_account
    }

    public(friend) fun venue_mut<T0, T1>(arg0: &mut Vault<T0, T1>) : &mut 0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::venue_account::VenueAccount {
        &mut arg0.venue_account
    }

    public fun withdraw_admin_fees<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::blast_boosts_aftermath::Protocol, arg2: &0x59f4f4f31d2a3290019f81bd4b794523f5d840659372e1bbda328965be3f5288::blast_acl::AdminWitness<0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::blast_boosts_core::RiskAdmin>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::blast_boosts_aftermath::assert_current(arg1);
        assert!(arg3 > 0, 19);
        let v0 = 0x2::balance::value<T1>(&arg0.admin_cash);
        assert!(arg3 <= v0, 20);
        0xce9ac6b78559ce4fdd41222d985b780169936571bd88f2b86c4f690264dcee87::events::admin_fees_withdrawn<T0>(0x2::object::uid_to_inner(&arg0.id), arg3, v0 - arg3);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.admin_cash, arg3), arg4)
    }

    // decompiled from Move bytecode v7
}

