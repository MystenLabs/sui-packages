module 0xdd59a0e210585ec38da6d966d2936c7476b9e08b3cc2f785ca998d084bf24c81::error {
    public fun coin_type_change_not_ready(arg0: bool) {
        assert!(arg0, 13906834505058091043);
    }

    public fun dapp_already_initialized(arg0: bool) {
        assert!(arg0, 13906834298898087947);
    }

    public fun dapp_key_mismatch(arg0: bool) {
        assert!(arg0, 13906834367618088979);
    }

    public fun dapp_paused(arg0: bool) {
        assert!(arg0, 13906834247358087173);
    }

    public fun division_by_zero(arg0: bool) {
        assert!(arg0, 13906834848658096203);
    }

    public fun entity_id_already_exists(arg0: bool) {
        assert!(arg0, 13906834625318092849);
    }

    public fun entity_not_found(arg0: bool) {
        assert!(arg0, 13906834608138092591);
    }

    public fun insufficient_balance(arg0: bool) {
        assert!(arg0, 13906834642498093107);
    }

    public fun insufficient_credit(arg0: bool) {
        assert!(arg0, 13906834316078088205);
    }

    public fun insufficient_payment(arg0: bool) {
        assert!(arg0, 13906834883018096719);
    }

    public fun invalid_evm_address(arg0: bool) {
        assert!(arg0, 13906834797118095429);
    }

    public fun invalid_key(arg0: bool) {
        assert!(arg0, 13906834762758094913);
    }

    public fun invalid_package_id(arg0: bool) {
        assert!(arg0, 13906834264538087431);
    }

    public fun invalid_session_duration(arg0: bool) {
        assert!(arg0, 13906834453518090269);
    }

    public fun invalid_session_key(arg0: bool) {
        assert!(arg0, 13906834436338090011);
    }

    public fun invalid_solana_address(arg0: bool) {
        assert!(arg0, 13906834814298095687);
    }

    public fun invalid_version(arg0: bool) {
        assert!(arg0, 13906834281718087689);
    }

    public fun invalid_window_size(arg0: bool) {
        assert!(arg0, 13906834865838096461);
    }

    public fun invitation_expired(arg0: bool) {
        assert!(arg0, 13906834745578094655);
    }

    public fun item_already_owned(arg0: bool) {
        assert!(arg0, 13906834900198096977);
    }

    public fun length_mismatch(arg0: bool) {
        assert!(arg0, 13906834779938095171);
    }

    public fun marketplace_fee_exceeds_max(arg0: bool) {
        assert!(arg0, 13906834711218094139);
    }

    public fun math_overflow(arg0: bool) {
        assert!(arg0, 13906834831478095945);
    }

    public fun no_active_session(arg0: bool) {
        assert!(arg0, 13906834384798089237);
    }

    public fun no_pending_coin_type_change(arg0: bool) {
        assert!(arg0, 13906834487878090785);
    }

    public fun no_pending_ownership_transfer(arg0: bool) {
        assert!(arg0, 13906834333258088463);
    }

    public fun no_permission(arg0: bool) {
        assert!(arg0, 13906834212998086657);
    }

    public fun no_revenue_to_withdraw(arg0: bool) {
        assert!(arg0, 13906834556598091817);
    }

    public fun not_canonical_owner(arg0: bool) {
        assert!(arg0, 13906834401978089495);
    }

    public fun not_latest_version(arg0: bool) {
        assert!(arg0, 13906834230178086915);
    }

    public fun not_participant(arg0: bool) {
        assert!(arg0, 13906834728398094397);
    }

    public fun not_scene_participant(arg0: bool) {
        assert!(arg0, 13906834590958092333);
    }

    public fun participants_still_present(arg0: bool) {
        assert!(arg0, 13906834659678093365);
    }

    public fun revenue_share_exceeds_max(arg0: bool) {
        assert!(arg0, 13906834539418091559);
    }

    public fun scene_expired(arg0: bool) {
        assert!(arg0, 13906834573778092075);
    }

    public fun scene_full(arg0: bool) {
        assert!(arg0, 13906834694038093881);
    }

    public fun user_debt_limit_exceeded(arg0: bool) {
        assert!(arg0, 13906834350438088721);
    }

    public fun user_storage_already_exists(arg0: bool) {
        assert!(arg0, 13906834419158089753);
    }

    public fun write_limit_out_of_range(arg0: bool) {
        assert!(arg0, 13906834676858093623);
    }

    public fun wrong_payment_coin_type(arg0: bool) {
        assert!(arg0, 13906834470698090527);
    }

    public fun wrong_settlement_mode(arg0: bool) {
        assert!(arg0, 13906834522238091301);
    }

    // decompiled from Move bytecode v6
}

