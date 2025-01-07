module 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::governance_action {
    struct GovernanceAction has copy, drop {
        value: u8,
    }

    public fun from_u8(arg0: u8) : GovernanceAction {
        assert!(0 <= arg0 && arg0 <= 5, 6);
        GovernanceAction{value: arg0}
    }

    public fun get_value(arg0: GovernanceAction) : u8 {
        arg0.value
    }

    public fun new_contract_upgrade() : GovernanceAction {
        GovernanceAction{value: 0}
    }

    public fun new_set_data_sources() : GovernanceAction {
        GovernanceAction{value: 2}
    }

    public fun new_set_fee_recipient() : GovernanceAction {
        GovernanceAction{value: 5}
    }

    public fun new_set_governance_data_source() : GovernanceAction {
        GovernanceAction{value: 1}
    }

    public fun new_set_stale_price_threshold() : GovernanceAction {
        GovernanceAction{value: 4}
    }

    public fun new_set_update_fee() : GovernanceAction {
        GovernanceAction{value: 3}
    }

    // decompiled from Move bytecode v6
}

