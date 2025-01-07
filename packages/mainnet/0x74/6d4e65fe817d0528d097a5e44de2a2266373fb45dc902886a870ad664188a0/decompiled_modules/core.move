module 0x746d4e65fe817d0528d097a5e44de2a2266373fb45dc902886a870ad664188a0::core {
    struct CORE has drop {
        dummy_field: bool,
    }

    struct ProtectedTreasuryCapAndPolicyCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        token_policy_cap: 0x2::token::TokenPolicyCap<T0>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun add_address_to_record<T0>(arg0: &AdminCap, arg1: &mut ProtectedTreasuryCapAndPolicyCap<T0>, arg2: &mut 0x2::token::TokenPolicy<T0>, arg3: address, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x746d4e65fe817d0528d097a5e44de2a2266373fb45dc902886a870ad664188a0::expired_rule::add_record<T0>(arg2, &mut arg1.token_policy_cap, arg3, arg4, arg5, arg6);
    }

    public fun burn_expired<T0>(arg0: 0x2::token::Token<T0>, arg1: &mut 0x2::token::TokenPolicy<T0>, arg2: &mut ProtectedTreasuryCapAndPolicyCap<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg2.treasury_cap;
        let v1 = &mut arg2.token_policy_cap;
        let (_, _, v4) = 0x746d4e65fe817d0528d097a5e44de2a2266373fb45dc902886a870ad664188a0::expired_rule::get_user_entry<T0>(arg1, 0x2::tx_context::sender(arg3));
        assert!(0x2::token::value<T0>(&arg0) == v4, 1);
        0x2::token::burn<T0>(v0, arg0);
        0x746d4e65fe817d0528d097a5e44de2a2266373fb45dc902886a870ad664188a0::expired_rule::update_expired<T0>(arg1, v1, 0x2::tx_context::sender(arg3), 0);
    }

    public fun create_protected_treasury_policy_caps<T0: drop>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: 0x2::token::TokenPolicyCap<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ProtectedTreasuryCapAndPolicyCap<T0>{
            id               : 0x2::object::new(arg2),
            treasury_cap     : arg0,
            token_policy_cap : arg1,
        };
        0x2::transfer::share_object<ProtectedTreasuryCapAndPolicyCap<T0>>(v0);
    }

    fun init(arg0: CORE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<CORE>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun mint_as_admin<T0>(arg0: &AdminCap, arg1: u64, arg2: &mut ProtectedTreasuryCapAndPolicyCap<T0>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<T0>(&mut arg2.treasury_cap, 0x2::token::transfer<T0>(0x2::token::mint<T0>(&mut arg2.treasury_cap, arg1, arg4), arg3, arg4), arg4);
    }

    public fun remove_address_from_record<T0>(arg0: &AdminCap, arg1: &mut ProtectedTreasuryCapAndPolicyCap<T0>, arg2: &mut 0x2::token::TokenPolicy<T0>, arg3: address) {
        0x746d4e65fe817d0528d097a5e44de2a2266373fb45dc902886a870ad664188a0::expired_rule::remove_record<T0>(arg2, &mut arg1.token_policy_cap, arg3);
    }

    public fun set_rules<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::token::add_rule_for_action<T0, 0x746d4e65fe817d0528d097a5e44de2a2266373fb45dc902886a870ad664188a0::denylist_rule::Denylist>(arg0, arg1, 0x2::token::spend_action(), arg2);
        0x2::token::add_rule_for_action<T0, 0x746d4e65fe817d0528d097a5e44de2a2266373fb45dc902886a870ad664188a0::expired_rule::Expired>(arg0, arg1, 0x2::token::spend_action(), arg2);
        0x2::token::add_rule_for_action<T0, 0x746d4e65fe817d0528d097a5e44de2a2266373fb45dc902886a870ad664188a0::denylist_rule::Denylist>(arg0, arg1, 0x2::token::transfer_action(), arg2);
        0x2::token::add_rule_for_action<T0, 0x746d4e65fe817d0528d097a5e44de2a2266373fb45dc902886a870ad664188a0::expired_rule::Expired>(arg0, arg1, 0x2::token::transfer_action(), arg2);
    }

    public fun update_expiration_for_address<T0>(arg0: &AdminCap, arg1: &mut 0x2::token::TokenPolicy<T0>, arg2: &mut ProtectedTreasuryCapAndPolicyCap<T0>, arg3: address, arg4: u64) {
        0x746d4e65fe817d0528d097a5e44de2a2266373fb45dc902886a870ad664188a0::expired_rule::update_expired<T0>(arg1, &mut arg2.token_policy_cap, arg3, arg4);
    }

    public fun update_level_for_address<T0>(arg0: &AdminCap, arg1: &mut 0x2::token::TokenPolicy<T0>, arg2: &mut ProtectedTreasuryCapAndPolicyCap<T0>, arg3: address, arg4: u64) {
        0x746d4e65fe817d0528d097a5e44de2a2266373fb45dc902886a870ad664188a0::expired_rule::update_level<T0>(arg1, &mut arg2.token_policy_cap, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

