module 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi {
    struct Hashi has key {
        id: 0x2::object::UID,
        committee_set: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::CommitteeSet,
        config: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::Config,
        epoch_config: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::Config,
        versioning: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::Versioning,
        treasury: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::treasury::Treasury,
        proposals: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::proposals::Proposals,
        tob: 0x2::bag::Bag,
        presig_allocator: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::mpc_signing::PresigAllocator,
    }

    public(friend) fun committee_set(arg0: &Hashi) : &0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::CommitteeSet {
        &arg0.committee_set
    }

    public(friend) fun current_committee(arg0: &Hashi) : &0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::Committee {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::current_committee(&arg0.committee_set)
    }

    public(friend) fun config(arg0: &Hashi) : &0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::Config {
        &arg0.config
    }

    public(friend) fun allocate_presigs(arg0: &mut Hashi, arg1: u64) : vector<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::mpc_signing::Presig> {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::mpc_signing::allocate(&mut arg0.presig_allocator, arg1)
    }

    public(friend) fun assert_not_reconfiguring(arg0: &Hashi) {
        assert!(!0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::is_reconfiguring(committee_set(arg0)), 13906834874423181315);
        assert!(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::has_committee(committee_set(arg0), 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::epoch(committee_set(arg0))), 13906834883013246981);
    }

    public(friend) fun assert_unpaused(arg0: &Hashi) {
        assert!(!0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::paused(config(arg0)), 13906834736984096769);
    }

    public(friend) fun bitcoin(arg0: &Hashi) : &0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::BitcoinState {
        0x2::dynamic_field::borrow<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::BitcoinStateKey, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::BitcoinState>(&arg0.id, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::key())
    }

    public(friend) fun bitcoin_mut(arg0: &mut Hashi) : &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::BitcoinState {
        0x2::dynamic_field::borrow_mut<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::BitcoinStateKey, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::BitcoinState>(&mut arg0.id, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::key())
    }

    public(friend) fun committee_set_mut(arg0: &mut Hashi) : &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::CommitteeSet {
        &mut arg0.committee_set
    }

    public(friend) fun config_mut(arg0: &mut Hashi) : &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::Config {
        &mut arg0.config
    }

    public(friend) fun epoch_certs(arg0: &mut Hashi, arg1: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::tob::TobKey, arg2: &mut 0x2::tx_context::TxContext) : &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::tob::EpochCertsV1 {
        if (!0x2::bag::contains<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::tob::TobKey>(&arg0.tob, arg1)) {
            0x2::bag::add<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::tob::TobKey, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::tob::EpochCertsV1>(&mut arg0.tob, arg1, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::tob::create(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::tob::epoch(&arg1), 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::tob::protocol_type(&arg1), arg2));
        };
        0x2::bag::borrow_mut<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::tob::TobKey, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::tob::EpochCertsV1>(&mut arg0.tob, arg1)
    }

    public(friend) fun epoch_config(arg0: &Hashi) : &0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::Config {
        &arg0.epoch_config
    }

    public(friend) fun epoch_config_mut(arg0: &mut Hashi) : &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::Config {
        &mut arg0.epoch_config
    }

    entry fun finish_publish(arg0: &mut Hashi, arg1: 0x2::package::UpgradeCap, arg2: address, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<u8>, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<u64>, arg8: &mut 0x2::coin_registry::CoinRegistry, arg9: &mut 0x2::tx_context::TxContext) {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::assert_version_enabled(&arg0.versioning);
        assert!(0x2::package::upgrade_package(&arg1) == 0x2::object::id_from_address(0x1::type_name::original_id<Hashi>()), 13906834582365667335);
        let v0 = versioning_mut(arg0);
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::set_upgrade_cap(v0, arg1);
        let v1 = config_mut(arg0);
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::btc_config::set_bitcoin_chain_id(v1, arg2);
        let v2 = config_mut(arg0);
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::set_guardian_url(v2, arg3);
        let v3 = config_mut(arg0);
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::set_guardian_node_url(v3, arg4);
        let v4 = config_mut(arg0);
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::set_guardian_btc_public_key(v4, arg5);
        if (0x1::option::is_some<u64>(&arg6)) {
            let v5 = config_mut(arg0);
            0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::btc_config::set_bitcoin_confirmation_threshold(v5, 0x1::option::destroy_some<u64>(arg6));
        } else {
            0x1::option::destroy_none<u64>(arg6);
        };
        if (0x1::option::is_some<u64>(&arg7)) {
            let v6 = config_mut(arg0);
            0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::btc_config::set_bitcoin_deposit_time_delay_ms(v6, 0x1::option::destroy_some<u64>(arg7));
        } else {
            0x1::option::destroy_none<u64>(arg7);
        };
        let (v7, v8) = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::btc::create(arg8, arg9);
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::treasury::register_treasury_cap<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::btc::BTC>(&mut arg0.treasury, v7);
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::treasury::register_metadata_cap<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::btc::BTC>(&mut arg0.treasury, v8);
    }

    public(friend) fun id(arg0: &Hashi) : &0x2::object::UID {
        &arg0.id
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::create();
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::btc_config::init_defaults(&mut v0);
        let v1 = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::empty();
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::mpc_config::init_defaults(&mut v1);
        let v2 = Hashi{
            id               : 0x2::object::new(arg0),
            committee_set    : 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::create(arg0),
            config           : v0,
            epoch_config     : v1,
            versioning       : 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::create(),
            treasury         : 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::treasury::create(arg0),
            proposals        : 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::proposals::create(arg0),
            tob              : 0x2::bag::new(arg0),
            presig_allocator : 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::mpc_signing::new_allocator(),
        };
        0x2::dynamic_field::add<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::BitcoinStateKey, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::BitcoinState>(&mut v2.id, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::key(), 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::new(arg0));
        0x2::transfer::share_object<Hashi>(v2);
    }

    public(friend) fun proposals(arg0: &Hashi) : &0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::proposals::Proposals {
        &arg0.proposals
    }

    public(friend) fun proposals_mut(arg0: &mut Hashi) : &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::proposals::Proposals {
        &mut arg0.proposals
    }

    public(friend) fun reset_presig_allocator(arg0: &mut Hashi) {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::mpc_signing::reset(&mut arg0.presig_allocator);
    }

    public(friend) fun tob_mut(arg0: &mut Hashi) : &mut 0x2::bag::Bag {
        &mut arg0.tob
    }

    public(friend) fun treasury(arg0: &Hashi) : &0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::treasury::Treasury {
        &arg0.treasury
    }

    public(friend) fun treasury_mut(arg0: &mut Hashi) : &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::treasury::Treasury {
        &mut arg0.treasury
    }

    public(friend) fun verify<T0>(arg0: &Hashi, arg1: u16, arg2: T0, arg3: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeSignature) : 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CertifiedMessage<T0> {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::verify_certificate<T0>(current_committee(arg0), 0x2::object::uid_to_address(&arg0.id), arg1, arg2, arg3, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::threshold::certificate_threshold(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::total_weight(current_committee(arg0))))
    }

    public(friend) fun verify_with_committee<T0>(arg0: &Hashi, arg1: &0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::Committee, arg2: u16, arg3: T0, arg4: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeSignature) : 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CertifiedMessage<T0> {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::verify_certificate<T0>(arg1, 0x2::object::uid_to_address(&arg0.id), arg2, arg3, arg4, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::threshold::certificate_threshold(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::total_weight(arg1)))
    }

    public(friend) fun versioning(arg0: &Hashi) : &0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::Versioning {
        &arg0.versioning
    }

    public(friend) fun versioning_mut(arg0: &mut Hashi) : &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::Versioning {
        &mut arg0.versioning
    }

    // decompiled from Move bytecode v7
}

