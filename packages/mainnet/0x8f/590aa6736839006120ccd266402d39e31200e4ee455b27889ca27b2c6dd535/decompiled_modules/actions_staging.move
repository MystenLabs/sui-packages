module 0x8f590aa6736839006120ccd266402d39e31200e4ee455b27889ca27b2c6dd535::actions_staging {
    struct ActionsIntent has copy, drop {
        dummy_field: bool,
    }

    fun assert_not_config_change(arg0: &0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::account::Account, arg1: 0x1::string::String) {
        assert!(!0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::account::has_managed_data<0x8f590aa6736839006120ccd266402d39e31200e4ee455b27889ca27b2c6dd535::multisig::ProposedConfigKey>(arg0, 0x8f590aa6736839006120ccd266402d39e31200e4ee455b27889ca27b2c6dd535::multisig::new_proposed_config_key(arg1)), 0);
    }

    public fun cancel_expired_actions(arg0: &mut 0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::account::Account, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_not_config_change(arg0, arg1);
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::intents::drain_and_destroy_expired(0x8f590aa6736839006120ccd266402d39e31200e4ee455b27889ca27b2c6dd535::multisig::cancel_expired_intent(arg0, arg1, arg2, arg3));
    }

    public fun cancel_pending_actions(arg0: &mut 0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::account::Account, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert_not_config_change(arg0, arg1);
        let v0 = 0x8f590aa6736839006120ccd266402d39e31200e4ee455b27889ca27b2c6dd535::multisig::cancel_pending_intent(arg0, arg1, arg2);
        if (0x1::option::is_some<0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::intents::Expired>(&v0)) {
            0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::intents::drain_and_destroy_expired(0x1::option::extract<0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::intents::Expired>(&mut v0));
        };
        0x1::option::destroy_none<0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::intents::Expired>(v0);
    }

    public fun cancel_rejected_actions(arg0: &mut 0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::account::Account, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert_not_config_change(arg0, arg1);
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::intents::drain_and_destroy_expired(0x8f590aa6736839006120ccd266402d39e31200e4ee455b27889ca27b2c6dd535::multisig::cancel_rejected_intent(arg0, arg1, arg2));
    }

    public fun cancel_stale_actions(arg0: &mut 0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::account::Account, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert_not_config_change(arg0, arg1);
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::intents::drain_and_destroy_expired(0x8f590aa6736839006120ccd266402d39e31200e4ee455b27889ca27b2c6dd535::multisig::cancel_stale_intent(arg0, arg1, arg2));
    }

    public fun request_actions(arg0: 0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::account::Auth, arg1: &mut 0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::account::Account, arg2: &0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::package_registry::PackageRegistry, arg3: 0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::intents::Params, arg4: vector<0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::intents::ActionSpec>, arg5: &mut 0x2::tx_context::TxContext) {
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::account::verify(arg1, arg0);
        0x8f590aa6736839006120ccd266402d39e31200e4ee455b27889ca27b2c6dd535::multisig::assert_sender_can_propose(arg1, 0x2::tx_context::sender(arg5));
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::intents::assert_single_execution(&arg3);
        let v0 = ActionsIntent{dummy_field: false};
        let v1 = 0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::account::create_intent<0x8f590aa6736839006120ccd266402d39e31200e4ee455b27889ca27b2c6dd535::multisig::Approvals, ActionsIntent>(arg1, arg2, arg3, 0x8f590aa6736839006120ccd266402d39e31200e4ee455b27889ca27b2c6dd535::multisig::new_outcome(arg1), 0x8f590aa6736839006120ccd266402d39e31200e4ee455b27889ca27b2c6dd535::version::current(), v0, arg5);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::intents::ActionSpec>(&arg4)) {
            assert!(!0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_validation::is_action_type<0x8f590aa6736839006120ccd266402d39e31200e4ee455b27889ca27b2c6dd535::config::ConfigChange>(0x1::vector::borrow<0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::intents::ActionSpec>(&arg4, v2)), 1);
            0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::intents::add_existing_action_spec<0x8f590aa6736839006120ccd266402d39e31200e4ee455b27889ca27b2c6dd535::multisig::Approvals, ActionsIntent>(&mut v1, *0x1::vector::borrow<0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::intents::ActionSpec>(&arg4, v2), v0);
            v2 = v2 + 1;
        };
        0x8f590aa6736839006120ccd266402d39e31200e4ee455b27889ca27b2c6dd535::multisig::stage_intent<ActionsIntent>(arg1, arg2, v1, 0x8f590aa6736839006120ccd266402d39e31200e4ee455b27889ca27b2c6dd535::version::current(), v0, arg5);
        0x8f590aa6736839006120ccd266402d39e31200e4ee455b27889ca27b2c6dd535::multisig::emit_intent_created(arg1, 0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::intents::params_key(&arg3), 0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::intents::params_description(&arg3), 0x2::tx_context::sender(arg5));
    }

    public fun witness() : ActionsIntent {
        ActionsIntent{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

