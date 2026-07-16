module 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::events {
    struct DeployerAdded has copy, drop {
        deployer: address,
    }

    struct DeployerRemoved has copy, drop {
        deployer: address,
    }

    struct AdminSwitched has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    struct Issue<phantom T0> has copy, drop {
        to: address,
        value: u64,
        value_locked: u64,
    }

    struct Burn<phantom T0> has copy, drop {
        burner: address,
        value: u64,
        reason: 0x1::string::String,
    }

    struct Seize<phantom T0> has copy, drop {
        from: address,
        to: address,
        value: u64,
        reason: 0x1::string::String,
    }

    struct Transfer<phantom T0> has copy, drop {
        from: address,
        to: address,
        value: u64,
    }

    struct Pause<phantom T0> has copy, drop {
        pauser: address,
    }

    struct Unpause<phantom T0> has copy, drop {
        pauser: address,
    }

    struct NameUpdated<phantom T0> has copy, drop {
        old_name: 0x1::string::String,
        new_name: 0x1::string::String,
    }

    struct DescriptionUpdated<phantom T0> has copy, drop {
        old_description: 0x1::string::String,
        new_description: 0x1::string::String,
    }

    struct IconUriUpdated<phantom T0> has copy, drop {
        old_icon_uri: 0x1::string::String,
        new_icon_uri: 0x1::string::String,
    }

    struct DSTrustServiceRoleAdded<phantom T0> has copy, drop {
        target_address: address,
        role: 0x1::type_name::TypeName,
        sender: address,
    }

    struct DSTrustServiceRoleRemoved<phantom T0> has copy, drop {
        target_address: address,
        role: 0x1::type_name::TypeName,
        sender: address,
    }

    struct DSRegistryServiceInvestorAdded<phantom T0> has copy, drop {
        investor_id: 0x1::string::String,
        sender: address,
    }

    struct DSRegistryServiceInvestorRemoved<phantom T0> has copy, drop {
        investor_id: 0x1::string::String,
        sender: address,
    }

    struct DSRegistryServiceInvestorCountryChanged<phantom T0> has copy, drop {
        investor_id: 0x1::string::String,
        country: 0x1::string::String,
        sender: address,
    }

    struct DSRegistryServiceInvestorAttributeChanged<phantom T0> has copy, drop {
        investor_id: 0x1::string::String,
        attribute_id: u64,
        value: u64,
        expiry: u64,
        sender: address,
    }

    struct DSRegistryServiceWalletAdded<phantom T0> has copy, drop {
        wallet: address,
        investor_id: 0x1::string::String,
        sender: address,
    }

    struct DSRegistryServiceWalletRemoved<phantom T0> has copy, drop {
        wallet: address,
        investor_id: 0x1::string::String,
        sender: address,
    }

    struct DSComplianceRuleAdded<phantom T0> has copy, drop {
        rule_type: 0x1::type_name::TypeName,
    }

    struct DSComplianceRuleRemoved<phantom T0> has copy, drop {
        rule_type: 0x1::type_name::TypeName,
    }

    struct DSComplianceTransferRecorded<phantom T0> has copy, drop {
        from: address,
        to: address,
        amount: u64,
    }

    struct DSComplianceIssuanceRecorded<phantom T0> has copy, drop {
        to: address,
        amount: u64,
    }

    struct DSComplianceBurnRecorded<phantom T0> has copy, drop {
        from: address,
        amount: u64,
    }

    struct DSComplianceSeizeRecorded<phantom T0> has copy, drop {
        from: address,
        amount: u64,
    }

    struct InvestorFullyLocked<phantom T0> has copy, drop {
        investor_id: 0x1::string::String,
    }

    struct InvestorFullyUnlocked<phantom T0> has copy, drop {
        investor_id: 0x1::string::String,
    }

    struct InvestorLiquidateOnlySet<phantom T0> has copy, drop {
        investor_id: 0x1::string::String,
        enabled: bool,
    }

    struct HolderLocked<phantom T0> has copy, drop {
        holder_id: 0x1::string::String,
        value: u64,
        reason: u64,
        reason_string: 0x1::string::String,
        release_time_ms: u64,
    }

    struct HolderUnlocked<phantom T0> has copy, drop {
        holder_id: 0x1::string::String,
        value: u64,
        reason: u64,
        reason_string: 0x1::string::String,
        release_time_ms: u64,
    }

    struct DSWalletManagerSpecialWalletAdded<phantom T0> has copy, drop {
        wallet: address,
        wallet_type: u64,
        caller: address,
    }

    struct DSWalletManagerSpecialWalletRemoved<phantom T0> has copy, drop {
        wallet: address,
        old_type: u64,
        caller: address,
    }

    struct DSComplianceUIntRuleSet<phantom T0> has copy, drop {
        rule_name: 0x1::string::String,
        prev_value: u64,
        new_value: u64,
    }

    struct DSComplianceBoolRuleSet<phantom T0> has copy, drop {
        rule_name: 0x1::string::String,
        prev_value: bool,
        new_value: bool,
    }

    struct DSComplianceStringToUIntMapRuleSet<phantom T0> has copy, drop {
        rule_name: 0x1::string::String,
        key_value: 0x1::string::String,
        prev_value: u64,
        new_value: u64,
    }

    public(friend) fun emit_admin_switched_event(arg0: address, arg1: address) {
        let v0 = AdminSwitched{
            old_admin : arg0,
            new_admin : arg1,
        };
        0x2::event::emit<AdminSwitched>(v0);
    }

    public(friend) fun emit_bool_rule_set_event<T0>(arg0: 0x1::string::String, arg1: bool, arg2: bool) {
        let v0 = DSComplianceBoolRuleSet<T0>{
            rule_name  : arg0,
            prev_value : arg1,
            new_value  : arg2,
        };
        0x2::event::emit<DSComplianceBoolRuleSet<T0>>(v0);
    }

    public(friend) fun emit_burn_event<T0>(arg0: address, arg1: u64, arg2: 0x1::string::String) {
        let v0 = Burn<T0>{
            burner : arg0,
            value  : arg1,
            reason : arg2,
        };
        0x2::event::emit<Burn<T0>>(v0);
    }

    public(friend) fun emit_compliance_burn_recorded_event<T0>(arg0: address, arg1: u64) {
        let v0 = DSComplianceBurnRecorded<T0>{
            from   : arg0,
            amount : arg1,
        };
        0x2::event::emit<DSComplianceBurnRecorded<T0>>(v0);
    }

    public(friend) fun emit_compliance_issuance_recorded_event<T0>(arg0: address, arg1: u64) {
        let v0 = DSComplianceIssuanceRecorded<T0>{
            to     : arg0,
            amount : arg1,
        };
        0x2::event::emit<DSComplianceIssuanceRecorded<T0>>(v0);
    }

    public(friend) fun emit_compliance_rule_added_event<T0>(arg0: 0x1::type_name::TypeName) {
        let v0 = DSComplianceRuleAdded<T0>{rule_type: arg0};
        0x2::event::emit<DSComplianceRuleAdded<T0>>(v0);
    }

    public(friend) fun emit_compliance_rule_removed_event<T0>(arg0: 0x1::type_name::TypeName) {
        let v0 = DSComplianceRuleRemoved<T0>{rule_type: arg0};
        0x2::event::emit<DSComplianceRuleRemoved<T0>>(v0);
    }

    public(friend) fun emit_compliance_seize_recorded_event<T0>(arg0: address, arg1: u64) {
        let v0 = DSComplianceSeizeRecorded<T0>{
            from   : arg0,
            amount : arg1,
        };
        0x2::event::emit<DSComplianceSeizeRecorded<T0>>(v0);
    }

    public(friend) fun emit_compliance_transfer_recorded_event<T0>(arg0: address, arg1: address, arg2: u64) {
        let v0 = DSComplianceTransferRecorded<T0>{
            from   : arg0,
            to     : arg1,
            amount : arg2,
        };
        0x2::event::emit<DSComplianceTransferRecorded<T0>>(v0);
    }

    public(friend) fun emit_deployer_added_event(arg0: address) {
        let v0 = DeployerAdded{deployer: arg0};
        0x2::event::emit<DeployerAdded>(v0);
    }

    public(friend) fun emit_deployer_removed_event(arg0: address) {
        let v0 = DeployerRemoved{deployer: arg0};
        0x2::event::emit<DeployerRemoved>(v0);
    }

    public(friend) fun emit_description_updated_event<T0>(arg0: 0x1::string::String, arg1: 0x1::string::String) {
        let v0 = DescriptionUpdated<T0>{
            old_description : arg0,
            new_description : arg1,
        };
        0x2::event::emit<DescriptionUpdated<T0>>(v0);
    }

    public(friend) fun emit_icon_uri_updated_event<T0>(arg0: 0x1::string::String, arg1: 0x1::string::String) {
        let v0 = IconUriUpdated<T0>{
            old_icon_uri : arg0,
            new_icon_uri : arg1,
        };
        0x2::event::emit<IconUriUpdated<T0>>(v0);
    }

    public(friend) fun emit_investor_added_event<T0>(arg0: 0x1::string::String, arg1: address) {
        let v0 = DSRegistryServiceInvestorAdded<T0>{
            investor_id : arg0,
            sender      : arg1,
        };
        0x2::event::emit<DSRegistryServiceInvestorAdded<T0>>(v0);
    }

    public(friend) fun emit_investor_attribute_changed_event<T0>(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: u64, arg4: address) {
        let v0 = DSRegistryServiceInvestorAttributeChanged<T0>{
            investor_id  : arg0,
            attribute_id : arg1,
            value        : arg2,
            expiry       : arg3,
            sender       : arg4,
        };
        0x2::event::emit<DSRegistryServiceInvestorAttributeChanged<T0>>(v0);
    }

    public(friend) fun emit_investor_country_changed_event<T0>(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: address) {
        let v0 = DSRegistryServiceInvestorCountryChanged<T0>{
            investor_id : arg0,
            country     : arg1,
            sender      : arg2,
        };
        0x2::event::emit<DSRegistryServiceInvestorCountryChanged<T0>>(v0);
    }

    public(friend) fun emit_investor_fully_locked_event<T0>(arg0: 0x1::string::String) {
        let v0 = InvestorFullyLocked<T0>{investor_id: arg0};
        0x2::event::emit<InvestorFullyLocked<T0>>(v0);
    }

    public(friend) fun emit_investor_fully_unlocked_event<T0>(arg0: 0x1::string::String) {
        let v0 = InvestorFullyUnlocked<T0>{investor_id: arg0};
        0x2::event::emit<InvestorFullyUnlocked<T0>>(v0);
    }

    public(friend) fun emit_investor_removed_event<T0>(arg0: 0x1::string::String, arg1: address) {
        let v0 = DSRegistryServiceInvestorRemoved<T0>{
            investor_id : arg0,
            sender      : arg1,
        };
        0x2::event::emit<DSRegistryServiceInvestorRemoved<T0>>(v0);
    }

    public(friend) fun emit_issue_event<T0>(arg0: address, arg1: u64, arg2: u64) {
        let v0 = Issue<T0>{
            to           : arg0,
            value        : arg1,
            value_locked : arg2,
        };
        0x2::event::emit<Issue<T0>>(v0);
    }

    public(friend) fun emit_liquidate_only_set_event<T0>(arg0: 0x1::string::String, arg1: bool) {
        let v0 = InvestorLiquidateOnlySet<T0>{
            investor_id : arg0,
            enabled     : arg1,
        };
        0x2::event::emit<InvestorLiquidateOnlySet<T0>>(v0);
    }

    public(friend) fun emit_lock_added_event<T0>(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: 0x1::string::String, arg4: u64) {
        let v0 = HolderLocked<T0>{
            holder_id       : arg0,
            value           : arg1,
            reason          : arg2,
            reason_string   : arg3,
            release_time_ms : arg4,
        };
        0x2::event::emit<HolderLocked<T0>>(v0);
    }

    public(friend) fun emit_lock_removed_event<T0>(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: 0x1::string::String, arg4: u64) {
        let v0 = HolderUnlocked<T0>{
            holder_id       : arg0,
            value           : arg1,
            reason          : arg2,
            reason_string   : arg3,
            release_time_ms : arg4,
        };
        0x2::event::emit<HolderUnlocked<T0>>(v0);
    }

    public(friend) fun emit_name_updated_event<T0>(arg0: 0x1::string::String, arg1: 0x1::string::String) {
        let v0 = NameUpdated<T0>{
            old_name : arg0,
            new_name : arg1,
        };
        0x2::event::emit<NameUpdated<T0>>(v0);
    }

    public(friend) fun emit_pause_event<T0>(arg0: address) {
        let v0 = Pause<T0>{pauser: arg0};
        0x2::event::emit<Pause<T0>>(v0);
    }

    public(friend) fun emit_role_added_event<T0>(arg0: address, arg1: 0x1::type_name::TypeName, arg2: address) {
        let v0 = DSTrustServiceRoleAdded<T0>{
            target_address : arg0,
            role           : arg1,
            sender         : arg2,
        };
        0x2::event::emit<DSTrustServiceRoleAdded<T0>>(v0);
    }

    public(friend) fun emit_role_removed_event<T0>(arg0: address, arg1: 0x1::type_name::TypeName, arg2: address) {
        let v0 = DSTrustServiceRoleRemoved<T0>{
            target_address : arg0,
            role           : arg1,
            sender         : arg2,
        };
        0x2::event::emit<DSTrustServiceRoleRemoved<T0>>(v0);
    }

    public(friend) fun emit_seize_event<T0>(arg0: address, arg1: address, arg2: u64, arg3: 0x1::string::String) {
        let v0 = Seize<T0>{
            from   : arg0,
            to     : arg1,
            value  : arg2,
            reason : arg3,
        };
        0x2::event::emit<Seize<T0>>(v0);
    }

    public(friend) fun emit_special_wallet_added_event<T0>(arg0: address, arg1: u64, arg2: address) {
        let v0 = DSWalletManagerSpecialWalletAdded<T0>{
            wallet      : arg0,
            wallet_type : arg1,
            caller      : arg2,
        };
        0x2::event::emit<DSWalletManagerSpecialWalletAdded<T0>>(v0);
    }

    public(friend) fun emit_special_wallet_removed_event<T0>(arg0: address, arg1: u64, arg2: address) {
        let v0 = DSWalletManagerSpecialWalletRemoved<T0>{
            wallet   : arg0,
            old_type : arg1,
            caller   : arg2,
        };
        0x2::event::emit<DSWalletManagerSpecialWalletRemoved<T0>>(v0);
    }

    public(friend) fun emit_string_to_uint_map_rule_set_event<T0>(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64, arg3: u64) {
        let v0 = DSComplianceStringToUIntMapRuleSet<T0>{
            rule_name  : arg0,
            key_value  : arg1,
            prev_value : arg2,
            new_value  : arg3,
        };
        0x2::event::emit<DSComplianceStringToUIntMapRuleSet<T0>>(v0);
    }

    public(friend) fun emit_transfer_event<T0>(arg0: address, arg1: address, arg2: u64) {
        let v0 = Transfer<T0>{
            from  : arg0,
            to    : arg1,
            value : arg2,
        };
        0x2::event::emit<Transfer<T0>>(v0);
    }

    public(friend) fun emit_uint_rule_set_event<T0>(arg0: 0x1::string::String, arg1: u64, arg2: u64) {
        let v0 = DSComplianceUIntRuleSet<T0>{
            rule_name  : arg0,
            prev_value : arg1,
            new_value  : arg2,
        };
        0x2::event::emit<DSComplianceUIntRuleSet<T0>>(v0);
    }

    public(friend) fun emit_unpause_event<T0>(arg0: address) {
        let v0 = Unpause<T0>{pauser: arg0};
        0x2::event::emit<Unpause<T0>>(v0);
    }

    public(friend) fun emit_wallet_added_event<T0>(arg0: address, arg1: 0x1::string::String, arg2: address) {
        let v0 = DSRegistryServiceWalletAdded<T0>{
            wallet      : arg0,
            investor_id : arg1,
            sender      : arg2,
        };
        0x2::event::emit<DSRegistryServiceWalletAdded<T0>>(v0);
    }

    public(friend) fun emit_wallet_removed_event<T0>(arg0: address, arg1: 0x1::string::String, arg2: address) {
        let v0 = DSRegistryServiceWalletRemoved<T0>{
            wallet      : arg0,
            investor_id : arg1,
            sender      : arg2,
        };
        0x2::event::emit<DSRegistryServiceWalletRemoved<T0>>(v0);
    }

    // decompiled from Move bytecode v7
}

