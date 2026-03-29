module 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::errors {
    public fun account_blocked_error(arg0: bool) {
        assert!(arg0, 13906834320373055501);
    }

    public fun account_frozen_error(arg0: bool) {
        assert!(arg0, 13906834337553055759);
    }

    public fun account_not_found_error(arg0: bool) {
        assert!(arg0, 13906834303193055243);
    }

    public fun amount_cannot_be_zero_error(arg0: bool) {
        assert!(arg0, 13906834560893059113);
    }

    public fun asset_already_frozen_error(arg0: bool) {
        assert!(arg0, 13906834234473054211);
    }

    public fun asset_not_found_error(arg0: bool) {
        assert!(arg0, 13906834217293053953);
    }

    public fun balance_too_low_error(arg0: bool) {
        assert!(arg0, 13906834354733056017);
    }

    public fun below_min_amount_error(arg0: bool) {
        assert!(arg0, 13906834457813057565);
    }

    public fun bridge_not_opened_error(arg0: bool) {
        assert!(arg0, 13906834612433059887);
    }

    public fun dapp_already_delegated_error(arg0: bool) {
        assert!(arg0, 13906834767053062209);
    }

    public fun dapp_already_initialized_error(arg0: bool) {
        assert!(arg0, 13906834715513061435);
    }

    public fun dapp_already_paused_error(arg0: bool) {
        assert!(arg0, 13906834646793060403);
    }

    public fun dapp_not_been_delegated_error(arg0: bool) {
        assert!(arg0, 13906834749873061951);
    }

    public fun dapp_not_initialized_error(arg0: bool) {
        assert!(arg0, 13906834698333061177);
    }

    public fun insufficient_credit_error(arg0: bool) {
        assert!(arg0, 13906834732693061693);
    }

    public fun invalid_metadata_error(arg0: bool) {
        assert!(arg0, 13906834286013054985);
    }

    public fun invalid_package_id_error(arg0: bool) {
        assert!(arg0, 13906834663973060661);
    }

    public fun invalid_receiver_error(arg0: bool) {
        assert!(arg0, 13906834268833054727);
    }

    public fun invalid_sender_error(arg0: bool) {
        assert!(arg0, 13906834251653054469);
    }

    public fun invalid_version_error(arg0: bool) {
        assert!(arg0, 13906834681153060919);
    }

    public fun less_than_amount_out_min_error(arg0: bool) {
        assert!(arg0, 13906834578073059371);
    }

    public fun liquidity_cannot_be_zero_error(arg0: bool) {
        assert!(arg0, 13906834474993057823);
    }

    public fun more_than_amount_in_max_error(arg0: bool) {
        assert!(arg0, 13906834595253059629);
    }

    public fun more_than_max_swap_path_len_error(arg0: bool) {
        assert!(arg0, 13906834492173058081);
    }

    public fun more_than_reserve_error(arg0: bool) {
        assert!(arg0, 13906834509353058339);
    }

    public fun no_pending_ownership_transfer_error(arg0: bool) {
        assert!(arg0, 13906834784233062467);
    }

    public fun no_permission_error(arg0: bool) {
        assert!(arg0, 13906834389093056533);
    }

    public fun not_burnable_error(arg0: bool) {
        assert!(arg0, 13906834423453057049);
    }

    public fun not_freezable_error(arg0: bool) {
        assert!(arg0, 13906834440633057307);
    }

    public fun not_latest_version_error(arg0: bool) {
        assert!(arg0, 13906834629613060145);
    }

    public fun not_mintable_error(arg0: bool) {
        assert!(arg0, 13906834406273056791);
    }

    public fun overflows_error(arg0: bool) {
        assert!(arg0, 13906834371913056275);
    }

    public fun reserves_cannot_be_zero_error(arg0: bool) {
        assert!(arg0, 13906834543713058855);
    }

    public fun swap_path_too_small_error(arg0: bool) {
        assert!(arg0, 13906834526533058597);
    }

    // decompiled from Move bytecode v6
}

