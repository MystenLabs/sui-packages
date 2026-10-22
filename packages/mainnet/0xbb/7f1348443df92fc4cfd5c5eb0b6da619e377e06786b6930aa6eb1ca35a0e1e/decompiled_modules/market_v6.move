module 0xbb7f1348443df92fc4cfd5c5eb0b6da619e377e06786b6930aa6eb1ca35a0e1e::market_v6 {
    struct MARKET_V6 has drop {
        dummy_field: bool,
    }

    struct PackageVersionV6 has key {
        id: 0x2::object::UID,
        version: u64,
        whitelist_id: 0x2::object::ID,
        version_cap: 0x2::object::ID,
        policy_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct TransferPolicyCreated has copy, drop {
        policy_id: 0x2::object::ID,
        admin_id: 0x2::object::ID,
        by: address,
    }

    struct CapRotated has copy, drop {
        kind: u8,
        old_cap: 0x2::object::ID,
        new_cap: 0x2::object::ID,
        recipient: address,
        by: address,
    }

    struct PerExecuteCapUpdated has copy, drop {
        whitelist_id: 0x2::object::ID,
        old_mist: u64,
        new_mist: u64,
        by: address,
    }

    struct PackageMigrated has copy, drop {
        old_version: u64,
        new_version: u64,
    }

    struct UpgradeProposal has copy, drop, store {
        kind: u8,
        digest: vector<u8>,
        policy: u8,
        eta_ms: u64,
    }

    struct UpgradeGovernor has key {
        id: 0x2::object::UID,
        cap: 0x1::option::Option<0x2::package::UpgradeCap>,
        pending: 0x1::option::Option<UpgradeProposal>,
    }

    struct UpgradeCapDeposited has copy, drop {
        governor_id: 0x2::object::ID,
        upgrade_cap_id: 0x2::object::ID,
        package: 0x2::object::ID,
        by: address,
    }

    struct UpgradeProposed has copy, drop {
        kind: u8,
        digest: vector<u8>,
        policy: u8,
        eta_ms: u64,
        by: address,
    }

    struct UpgradeCancelled has copy, drop {
        kind: u8,
        digest: vector<u8>,
        by: address,
    }

    struct UpgradeAuthorized has copy, drop {
        digest: vector<u8>,
        policy: u8,
        by: address,
    }

    struct UpgradeCommitted has copy, drop {
        package: 0x2::object::ID,
        version: u64,
        by: address,
    }

    struct PackageMadeImmutable has copy, drop {
        package: 0x2::object::ID,
        by: address,
    }

    struct UpgradeGuardianCancelled has copy, drop {
        kind: u8,
        digest: vector<u8>,
        by: address,
    }

    struct UpgradePolicyRestricted has copy, drop {
        old_policy: u8,
        new_policy: u8,
        cancelled_pending: bool,
        by: address,
    }

    struct PackageVersionCapV6 has store, key {
        id: 0x2::object::UID,
    }

    struct SecondaryPolicyAdmin has key {
        id: 0x2::object::UID,
        cap: 0x2::transfer_policy::TransferPolicyCap<AgentCredential>,
        policy_id: 0x2::object::ID,
    }

    struct AdminCapV6 has store, key {
        id: 0x2::object::UID,
    }

    struct AgentTemplate has key {
        id: 0x2::object::UID,
        controller: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        category: 0x1::string::String,
        strategy_blob_id: 0x1::string::String,
        strategy_content_root: vector<u8>,
        price_mist: u64,
        max_credentials: u64,
        credentials_sold: u64,
        secondary_royalty_bps: u64,
        max_executes_per_credential: u64,
        max_validity_ms: u64,
        revocable: bool,
        active: bool,
        created_at: u64,
        rev_list_id: 0x1::option::Option<0x2::object::ID>,
        seal_policy_id: 0x1::option::Option<0x2::object::ID>,
        pending_controller_request: 0x1::option::Option<0x2::object::ID>,
    }

    struct AgentCredential has store, key {
        id: 0x2::object::UID,
        template_id: 0x2::object::ID,
        holder: address,
        purchased_at: u64,
        expires_at: u64,
        execute_count: u64,
        max_executes: u64,
        private_config_blob_id: 0x1::string::String,
        private_config_root: vector<u8>,
        transferable: bool,
        revoked: bool,
    }

    struct TemplateCreated has copy, drop {
        template_id: 0x2::object::ID,
        controller: address,
        price_mist: u64,
        max_credentials: u64,
        secondary_royalty_bps: u64,
        max_executes_per_credential: u64,
        max_validity_ms: u64,
        revocable: bool,
    }

    struct CredentialMinted has copy, drop {
        template_id: 0x2::object::ID,
        credential_id: 0x2::object::ID,
        holder: address,
        price_paid_mist: u64,
        expires_at: u64,
        max_executes: u64,
        transferable: bool,
    }

    struct ExecutesCommitted has copy, drop {
        whitelist_id: 0x2::object::ID,
        template_id: 0x2::object::ID,
        credential_id: 0x2::object::ID,
        holder: address,
        pool: address,
        amount_mist: u64,
        batch_size: u64,
        ts_ms: u64,
    }

    struct CredentialRevoked has copy, drop {
        template_id: 0x2::object::ID,
        credential_id: 0x2::object::ID,
        reason_code: u64,
    }

    struct CredentialTransferred has copy, drop {
        template_id: 0x2::object::ID,
        credential_id: 0x2::object::ID,
        from: address,
        to: address,
    }

    struct TemplateDeactivated has copy, drop {
        template_id: 0x2::object::ID,
        by: address,
    }

    struct CredentialTransferableUpdated has copy, drop {
        template_id: 0x2::object::ID,
        credential_id: 0x2::object::ID,
        transferable: bool,
        by: address,
    }

    struct TemplateControllerUpdated has copy, drop {
        template_id: 0x2::object::ID,
        old_controller: address,
        new_controller: address,
    }

    struct PlatformFeeUpdated has copy, drop {
        old_bps: u64,
        new_bps: u64,
        by: address,
    }

    struct PlatformFeeRecipientUpdated has copy, drop {
        old_recipient: address,
        new_recipient: address,
        by: address,
    }

    struct PlatformFeeCollected has copy, drop {
        template_id: 0x2::object::ID,
        buyer: address,
        fee_amount: u64,
        recipient: address,
    }

    struct FeeConfigV6 has key {
        id: 0x2::object::UID,
        fee_bps: u64,
        recipient: address,
    }

    struct PauseConfigV6 has key {
        id: 0x2::object::UID,
        paused: bool,
        pause_cap: 0x2::object::ID,
    }

    struct PauseCapV6 has store, key {
        id: 0x2::object::UID,
    }

    struct Paused has copy, drop {
        by: address,
    }

    struct Unpaused has copy, drop {
        by: address,
    }

    struct SecondaryRule has drop {
        dummy_field: bool,
    }

    struct SecondaryConfig has drop, store {
        platform_bps: u64,
        platform_recipient: address,
    }

    struct SecondarySaleCollected has copy, drop {
        template_id: 0x2::object::ID,
        credential_id: 0x2::object::ID,
        buyer: address,
        price_mist: u64,
        controller_royalty: u64,
        platform_fee: u64,
    }

    struct SecondaryRuleUpdated has copy, drop {
        old_bps: u64,
        new_bps: u64,
        old_recipient: address,
        new_recipient: address,
        by: address,
    }

    struct CredentialDestroyed has copy, drop {
        template_id: 0x2::object::ID,
        credential_id: 0x2::object::ID,
        holder: address,
    }

    struct CredentialRevocations has key {
        id: 0x2::object::UID,
        template_id: 0x2::object::ID,
        revoked: vector<0x2::object::ID>,
    }

    struct RevocationListCreated has copy, drop {
        template_id: 0x2::object::ID,
        list_id: 0x2::object::ID,
    }

    struct ControllerTransferRequest has key {
        id: 0x2::object::UID,
        template_id: 0x2::object::ID,
        old_controller: address,
        new_controller: address,
        expires_at_ms: u64,
    }

    struct ControllerTransferProposed has copy, drop {
        template_id: 0x2::object::ID,
        request_id: 0x2::object::ID,
        old_controller: address,
        new_controller: address,
        expires_at_ms: u64,
    }

    struct ControllerTransferCancelled has copy, drop {
        template_id: 0x2::object::ID,
        request_id: 0x2::object::ID,
        by: address,
    }

    struct SealPolicyV6 has key {
        id: 0x2::object::UID,
        template_id: 0x2::object::ID,
        controller: address,
        seal_nonce: vector<u8>,
    }

    struct SealPolicyCreated has copy, drop {
        policy_id: 0x2::object::ID,
        template_id: 0x2::object::ID,
        controller: address,
    }

    struct StrategyBlobUpdated has copy, drop {
        template_id: 0x2::object::ID,
        blob_id: 0x1::string::String,
    }

    struct AdminBoundWhitelistV6 has key {
        id: 0x2::object::UID,
        pools: vector<address>,
        per_execute_cap_mist: u64,
        admin: 0x2::object::ID,
    }

    struct BoundWhitelistV6Created has copy, drop {
        whitelist_id: 0x2::object::ID,
        admin: 0x2::object::ID,
    }

    struct BoundPoolV6Whitelisted has copy, drop {
        whitelist_id: 0x2::object::ID,
        pool: address,
        by: address,
    }

    struct BoundPoolV6Removed has copy, drop {
        whitelist_id: 0x2::object::ID,
        pool: address,
        by: address,
    }

    public fun authorize_upgrade(arg0: &mut UpgradeGovernor, arg1: &PackageVersionV6, arg2: &PackageVersionCapV6, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::package::UpgradeTicket {
        assert_current_version(arg1);
        assert_version_cap(arg1, arg2);
        assert!(0x1::option::is_some<0x2::package::UpgradeCap>(&arg0.cap), 49);
        assert!(0x1::option::is_some<UpgradeProposal>(&arg0.pending), 51);
        let v0 = 0x1::option::extract<UpgradeProposal>(&mut arg0.pending);
        assert!(v0.kind == 0, 51);
        assert!(v0.digest == arg3, 53);
        assert!(0x2::clock::timestamp_ms(arg4) >= v0.eta_ms, 52);
        let v1 = UpgradeAuthorized{
            digest : arg3,
            policy : v0.policy,
            by     : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<UpgradeAuthorized>(v1);
        0x2::package::authorize_upgrade(0x1::option::borrow_mut<0x2::package::UpgradeCap>(&mut arg0.cap), v0.policy, arg3)
    }

    public fun commit_upgrade(arg0: &mut UpgradeGovernor, arg1: 0x2::package::UpgradeReceipt, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<0x2::package::UpgradeCap>(&arg0.cap), 49);
        let v0 = 0x1::option::borrow_mut<0x2::package::UpgradeCap>(&mut arg0.cap);
        0x2::package::commit_upgrade(v0, arg1);
        let v1 = UpgradeCommitted{
            package : 0x2::package::upgrade_package(v0),
            version : 0x2::package::version(v0),
            by      : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<UpgradeCommitted>(v1);
    }

    public fun make_immutable(arg0: &mut UpgradeGovernor, arg1: &PackageVersionV6, arg2: &PackageVersionCapV6, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_current_version(arg1);
        assert_version_cap(arg1, arg2);
        assert!(0x1::option::is_some<0x2::package::UpgradeCap>(&arg0.cap), 49);
        assert!(0x1::option::is_some<UpgradeProposal>(&arg0.pending), 51);
        let v0 = 0x1::option::extract<UpgradeProposal>(&mut arg0.pending);
        assert!(v0.kind == 1, 51);
        assert!(0x2::clock::timestamp_ms(arg3) >= v0.eta_ms, 52);
        let v1 = 0x1::option::extract<0x2::package::UpgradeCap>(&mut arg0.cap);
        let v2 = PackageMadeImmutable{
            package : 0x2::package::upgrade_package(&v1),
            by      : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<PackageMadeImmutable>(v2);
        0x2::package::make_immutable(v1);
    }

    public fun accept_controller_transfer(arg0: &mut AgentTemplate, arg1: &PackageVersionV6, arg2: &PauseConfigV6, arg3: ControllerTransferRequest, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_not_paused(arg2);
        assert_current_version(arg1);
        let ControllerTransferRequest {
            id             : v0,
            template_id    : v1,
            old_controller : v2,
            new_controller : v3,
            expires_at_ms  : v4,
        } = arg3;
        assert!(v1 == 0x2::object::id<AgentTemplate>(arg0), 15);
        assert!(0x2::tx_context::sender(arg5) == v3, 1);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.pending_controller_request) && *0x1::option::borrow<0x2::object::ID>(&arg0.pending_controller_request) == 0x2::object::id<ControllerTransferRequest>(&arg3), 33);
        assert!(arg0.controller == v2, 33);
        assert!(0x2::clock::timestamp_ms(arg4) <= v4, 34);
        arg0.controller = v3;
        arg0.pending_controller_request = 0x1::option::none<0x2::object::ID>();
        0x2::object::delete(v0);
        let v5 = TemplateControllerUpdated{
            template_id    : v1,
            old_controller : v2,
            new_controller : v3,
        };
        0x2::event::emit<TemplateControllerUpdated>(v5);
    }

    fun add_secondary_rule(arg0: &mut 0x2::transfer_policy::TransferPolicy<AgentCredential>, arg1: &0x2::transfer_policy::TransferPolicyCap<AgentCredential>, arg2: u64, arg3: address) {
        assert!(arg2 <= 1000, 21);
        let v0 = SecondaryRule{dummy_field: false};
        let v1 = SecondaryConfig{
            platform_bps       : arg2,
            platform_recipient : arg3,
        };
        0x2::transfer_policy::add_rule<AgentCredential, SecondaryRule, SecondaryConfig>(v0, arg0, arg1, v1);
    }

    fun assert_buyer_params(arg0: &AgentTemplate, arg1: u64, arg2: u64) {
        assert!(arg1 > 0, 29);
        assert!(arg2 > 0, 29);
        assert!(arg1 <= arg0.max_executes_per_credential, 29);
        assert!(arg2 <= arg0.max_validity_ms, 29);
    }

    fun assert_content_mutable(arg0: &AgentTemplate) {
        assert!(arg0.revocable || arg0.credentials_sold == 0, 35);
    }

    fun assert_current_version(arg0: &PackageVersionV6) {
        assert!(arg0.version == 6, 37);
    }

    fun assert_expected_content(arg0: &AgentTemplate, arg1: &vector<u8>, arg2: 0x2::object::ID) {
        assert!(&arg0.strategy_content_root == arg1, 42);
        assert!(*0x1::option::borrow<0x2::object::ID>(&arg0.seal_policy_id) == arg2, 42);
    }

    fun assert_not_paused(arg0: &PauseConfigV6) {
        assert!(!arg0.paused, 23);
    }

    fun assert_ready(arg0: &AgentTemplate) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.rev_list_id) && 0x1::option::is_some<0x2::object::ID>(&arg0.seal_policy_id), 31);
    }

    fun assert_version_cap(arg0: &PackageVersionV6, arg1: &PackageVersionCapV6) {
        assert!(0x2::object::id<PackageVersionCapV6>(arg1) == arg0.version_cap, 38);
    }

    public fun bound_whitelist_v6_admin(arg0: &AdminBoundWhitelistV6) : 0x2::object::ID {
        arg0.admin
    }

    public fun bound_whitelist_v6_cap_mist(arg0: &AdminBoundWhitelistV6) : u64 {
        arg0.per_execute_cap_mist
    }

    public fun bound_whitelist_v6_pools(arg0: &AdminBoundWhitelistV6) : vector<address> {
        arg0.pools
    }

    public fun cancel_controller_transfer(arg0: &mut AgentTemplate, arg1: &PackageVersionV6, arg2: &mut 0x2::tx_context::TxContext) {
        assert_current_version(arg1);
        assert!(0x2::tx_context::sender(arg2) == arg0.controller, 1);
        if (0x1::option::is_some<0x2::object::ID>(&arg0.pending_controller_request)) {
            let v0 = ControllerTransferCancelled{
                template_id : 0x2::object::id<AgentTemplate>(arg0),
                request_id  : 0x1::option::extract<0x2::object::ID>(&mut arg0.pending_controller_request),
                by          : 0x2::tx_context::sender(arg2),
            };
            0x2::event::emit<ControllerTransferCancelled>(v0);
        };
    }

    public fun cancel_upgrade(arg0: &mut UpgradeGovernor, arg1: &PackageVersionV6, arg2: &PackageVersionCapV6, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version_cap(arg1, arg2);
        assert!(0x1::option::is_some<UpgradeProposal>(&arg0.pending), 51);
        let v0 = 0x1::option::extract<UpgradeProposal>(&mut arg0.pending);
        let v1 = UpgradeCancelled{
            kind   : v0.kind,
            digest : v0.digest,
            by     : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<UpgradeCancelled>(v1);
    }

    public fun commit_execute_batch_v2_b(arg0: &PackageVersionV6, arg1: &AgentTemplate, arg2: &mut AgentCredential, arg3: &CredentialRevocations, arg4: address, arg5: u64, arg6: u64, arg7: &AdminBoundWhitelistV6, arg8: &PauseConfigV6, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert_not_paused(arg8);
        assert!(0x2::tx_context::sender(arg10) == arg2.holder, 12);
        assert!(arg6 > 0, 30);
        assert!(arg6 <= 10000, 20);
        let v0 = credential_status(arg0, arg1, arg2, arg3, arg4, arg7, arg5, arg6, arg9);
        assert!(v0 == 0, v0);
        arg2.execute_count = arg2.execute_count + arg6;
        let v1 = ExecutesCommitted{
            whitelist_id  : 0x2::object::id<AdminBoundWhitelistV6>(arg7),
            template_id   : 0x2::object::id<AgentTemplate>(arg1),
            credential_id : 0x2::object::id<AgentCredential>(arg2),
            holder        : arg2.holder,
            pool          : arg4,
            amount_mist   : arg5,
            batch_size    : arg6,
            ts_ms         : 0x2::clock::timestamp_ms(arg9),
        };
        0x2::event::emit<ExecutesCommitted>(v1);
    }

    fun create_policy_with_admin(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let (v0, v1) = 0x2::transfer_policy::new<AgentCredential>(arg0, arg1);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        add_secondary_rule(v4, &v2, 30, 0x2::tx_context::sender(arg1));
        let v5 = 0x2::object::id<0x2::transfer_policy::TransferPolicy<AgentCredential>>(&v3);
        let v6 = SecondaryPolicyAdmin{
            id        : 0x2::object::new(arg1),
            cap       : v2,
            policy_id : v5,
        };
        let v7 = TransferPolicyCreated{
            policy_id : v5,
            admin_id  : 0x2::object::id<SecondaryPolicyAdmin>(&v6),
            by        : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<TransferPolicyCreated>(v7);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<AgentCredential>>(v3);
        0x2::transfer::share_object<SecondaryPolicyAdmin>(v6);
        v5
    }

    public fun create_revocation_list(arg0: &mut AgentTemplate, arg1: &PackageVersionV6, arg2: &mut 0x2::tx_context::TxContext) {
        assert_current_version(arg1);
        assert!(0x2::tx_context::sender(arg2) == arg0.controller, 1);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.rev_list_id), 27);
        let v0 = CredentialRevocations{
            id          : 0x2::object::new(arg2),
            template_id : 0x2::object::id<AgentTemplate>(arg0),
            revoked     : 0x1::vector::empty<0x2::object::ID>(),
        };
        let v1 = 0x2::object::id<CredentialRevocations>(&v0);
        let v2 = RevocationListCreated{
            template_id : 0x2::object::id<AgentTemplate>(arg0),
            list_id     : v1,
        };
        0x2::event::emit<RevocationListCreated>(v2);
        arg0.rev_list_id = 0x1::option::some<0x2::object::ID>(v1);
        0x2::transfer::share_object<CredentialRevocations>(v0);
    }

    public fun create_seal_policy(arg0: &mut AgentTemplate, arg1: &PackageVersionV6, arg2: &PauseConfigV6, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert_not_paused(arg2);
        assert_current_version(arg1);
        assert!(0x2::tx_context::sender(arg4) == arg0.controller, 1);
        assert_content_mutable(arg0);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 18);
        let v0 = SealPolicyV6{
            id          : 0x2::object::new(arg4),
            template_id : 0x2::object::id<AgentTemplate>(arg0),
            controller  : arg0.controller,
            seal_nonce  : arg3,
        };
        let v1 = 0x2::object::id<SealPolicyV6>(&v0);
        let v2 = SealPolicyCreated{
            policy_id   : v1,
            template_id : 0x2::object::id<AgentTemplate>(arg0),
            controller  : arg0.controller,
        };
        0x2::event::emit<SealPolicyCreated>(v2);
        arg0.seal_policy_id = 0x1::option::some<0x2::object::ID>(v1);
        0x2::transfer::share_object<SealPolicyV6>(v0);
    }

    public fun create_template(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: bool, arg11: &PackageVersionV6, arg12: &PauseConfigV6, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert_not_paused(arg12);
        assert_current_version(arg11);
        assert!(0x1::string::is_empty(&arg3) == false, 5);
        assert!(arg6 > 0 && arg6 <= 100000, 25);
        assert!(arg7 <= 5000, 7);
        assert!(arg8 > 0, 25);
        assert!(arg9 > 0, 25);
        assert!(arg5 > 0, 41);
        let v0 = AgentTemplate{
            id                          : 0x2::object::new(arg14),
            controller                  : 0x2::tx_context::sender(arg14),
            name                        : arg0,
            description                 : arg1,
            category                    : arg2,
            strategy_blob_id            : arg3,
            strategy_content_root       : arg4,
            price_mist                  : arg5,
            max_credentials             : arg6,
            credentials_sold            : 0,
            secondary_royalty_bps       : arg7,
            max_executes_per_credential : arg8,
            max_validity_ms             : arg9,
            revocable                   : arg10,
            active                      : true,
            created_at                  : 0x2::clock::timestamp_ms(arg13),
            rev_list_id                 : 0x1::option::none<0x2::object::ID>(),
            seal_policy_id              : 0x1::option::none<0x2::object::ID>(),
            pending_controller_request  : 0x1::option::none<0x2::object::ID>(),
        };
        let v1 = TemplateCreated{
            template_id                 : 0x2::object::id<AgentTemplate>(&v0),
            controller                  : v0.controller,
            price_mist                  : arg5,
            max_credentials             : arg6,
            secondary_royalty_bps       : arg7,
            max_executes_per_credential : arg8,
            max_validity_ms             : arg9,
            revocable                   : arg10,
        };
        0x2::event::emit<TemplateCreated>(v1);
        0x2::transfer::share_object<AgentTemplate>(v0);
    }

    public fun credential_execute_count(arg0: &AgentCredential) : u64 {
        arg0.execute_count
    }

    public fun credential_expires_at(arg0: &AgentCredential) : u64 {
        arg0.expires_at
    }

    public fun credential_holder(arg0: &AgentCredential) : address {
        arg0.holder
    }

    fun credential_is_exhausted(arg0: &AgentCredential) : bool {
        arg0.max_executes != 18446744073709551615 && arg0.execute_count >= arg0.max_executes
    }

    fun credential_is_expired(arg0: &AgentCredential, arg1: &0x2::clock::Clock) : bool {
        arg0.expires_at != 18446744073709551615 && 0x2::clock::timestamp_ms(arg1) > arg0.expires_at
    }

    public fun credential_max_executes(arg0: &AgentCredential) : u64 {
        arg0.max_executes
    }

    public fun credential_revoked(arg0: &AgentCredential) : bool {
        arg0.revoked
    }

    fun credential_status(arg0: &PackageVersionV6, arg1: &AgentTemplate, arg2: &AgentCredential, arg3: &CredentialRevocations, arg4: address, arg5: &AdminBoundWhitelistV6, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) : u64 {
        if (arg0.version != 6) {
            return 37
        };
        if (0x2::object::id<AdminBoundWhitelistV6>(arg5) != arg0.whitelist_id) {
            return 32
        };
        if (!template_usable(arg1)) {
            return 2
        };
        if (arg2.template_id != 0x2::object::id<AgentTemplate>(arg1)) {
            return 15
        };
        if (arg3.template_id != 0x2::object::id<AgentTemplate>(arg1)) {
            return 15
        };
        if (0x1::option::is_none<0x2::object::ID>(&arg1.rev_list_id) || *0x1::option::borrow<0x2::object::ID>(&arg1.rev_list_id) != 0x2::object::id<CredentialRevocations>(arg3)) {
            return 15
        };
        if (arg2.revoked) {
            return 8
        };
        let v0 = 0x2::object::id<AgentCredential>(arg2);
        if (0x1::vector::contains<0x2::object::ID>(&arg3.revoked, &v0)) {
            return 8
        };
        if (arg2.expires_at != 18446744073709551615 && 0x2::clock::timestamp_ms(arg8) > arg2.expires_at) {
            return 9
        };
        if (arg2.max_executes != 18446744073709551615) {
            if (arg2.execute_count >= arg2.max_executes) {
                return 10
            };
            if (arg7 > arg2.max_executes - arg2.execute_count) {
                return 10
            };
        };
        if (!0x1::vector::contains<address>(&arg5.pools, &arg4)) {
            return 14
        };
        if (arg6 > arg5.per_execute_cap_mist) {
            return 13
        };
        0
    }

    public fun credential_status_v2_b(arg0: &PackageVersionV6, arg1: &AgentTemplate, arg2: &AgentCredential, arg3: &CredentialRevocations, arg4: address, arg5: &AdminBoundWhitelistV6, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) : u64 {
        credential_status(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun credential_template_id(arg0: &AgentCredential) : 0x2::object::ID {
        arg0.template_id
    }

    public fun credential_transferable(arg0: &AgentCredential) : bool {
        arg0.transferable
    }

    public fun deactivate_template(arg0: &mut AgentTemplate, arg1: &PackageVersionV6, arg2: &mut 0x2::tx_context::TxContext) {
        assert_current_version(arg1);
        assert!(0x2::tx_context::sender(arg2) == arg0.controller, 1);
        arg0.active = false;
        let v0 = TemplateDeactivated{
            template_id : 0x2::object::id<AgentTemplate>(arg0),
            by          : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<TemplateDeactivated>(v0);
    }

    public fun deposit_upgrade_cap(arg0: &mut UpgradeGovernor, arg1: &PackageVersionV6, arg2: &PackageVersionCapV6, arg3: 0x2::package::UpgradeCap, arg4: &mut 0x2::tx_context::TxContext) {
        assert_current_version(arg1);
        assert_version_cap(arg1, arg2);
        assert!(0x1::option::is_none<0x2::package::UpgradeCap>(&arg0.cap), 48);
        let v0 = 0x2::package::upgrade_package(&arg3);
        assert!(0x2::object::id_to_address(&v0) == self_package_address(), 50);
        let v1 = UpgradeCapDeposited{
            governor_id    : 0x2::object::id<UpgradeGovernor>(arg0),
            upgrade_cap_id : 0x2::object::id<0x2::package::UpgradeCap>(&arg3),
            package        : v0,
            by             : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<UpgradeCapDeposited>(v1);
        0x1::option::fill<0x2::package::UpgradeCap>(&mut arg0.cap, arg3);
    }

    public fun destroy_controller_request(arg0: ControllerTransferRequest) {
        let ControllerTransferRequest {
            id             : v0,
            template_id    : _,
            old_controller : _,
            new_controller : _,
            expires_at_ms  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun destroy_credential(arg0: AgentCredential, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.holder == 0x2::tx_context::sender(arg2), 12);
        assert!(credential_is_expired(&arg0, arg1) || credential_is_exhausted(&arg0), 44);
        let AgentCredential {
            id                     : v0,
            template_id            : v1,
            holder                 : v2,
            purchased_at           : _,
            expires_at             : _,
            execute_count          : _,
            max_executes           : _,
            private_config_blob_id : _,
            private_config_root    : _,
            transferable           : _,
            revoked                : _,
        } = arg0;
        0x2::object::delete(v0);
        let v11 = CredentialDestroyed{
            template_id   : v1,
            credential_id : 0x2::object::id<AgentCredential>(&arg0),
            holder        : v2,
        };
        0x2::event::emit<CredentialDestroyed>(v11);
    }

    fun expiry_of(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 18446744073709551615) {
            18446744073709551615
        } else {
            arg0 + arg1
        }
    }

    public fun governor_has_cap(arg0: &UpgradeGovernor) : bool {
        0x1::option::is_some<0x2::package::UpgradeCap>(&arg0.cap)
    }

    public fun governor_pending_eta(arg0: &UpgradeGovernor) : 0x1::option::Option<u64> {
        if (0x1::option::is_some<UpgradeProposal>(&arg0.pending)) {
            0x1::option::some<u64>(0x1::option::borrow<UpgradeProposal>(&arg0.pending).eta_ms)
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun governor_upgrade_policy(arg0: &UpgradeGovernor) : u8 {
        assert!(0x1::option::is_some<0x2::package::UpgradeCap>(&arg0.cap), 49);
        0x2::package::upgrade_policy(0x1::option::borrow<0x2::package::UpgradeCap>(&arg0.cap))
    }

    public fun guardian_cancel_upgrade(arg0: &mut UpgradeGovernor, arg1: &PauseConfigV6, arg2: &PauseCapV6, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<PauseCapV6>(arg2) == arg1.pause_cap, 38);
        assert!(0x1::option::is_some<UpgradeProposal>(&arg0.pending), 51);
        let v0 = 0x1::option::extract<UpgradeProposal>(&mut arg0.pending);
        let v1 = UpgradeGuardianCancelled{
            kind   : v0.kind,
            digest : v0.digest,
            by     : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<UpgradeGuardianCancelled>(v1);
        let v2 = UpgradeCancelled{
            kind   : v0.kind,
            digest : v0.digest,
            by     : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<UpgradeCancelled>(v2);
    }

    fun init(arg0: MARKET_V6, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = new_bound_whitelist(arg1);
        let v1 = PackageVersionCapV6{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<PackageVersionCapV6>(v1, 0x2::tx_context::sender(arg1));
        let v2 = FeeConfigV6{
            id        : 0x2::object::new(arg1),
            fee_bps   : 30,
            recipient : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<FeeConfigV6>(v2);
        let v3 = 0x2::package::claim<MARKET_V6>(arg0, arg1);
        let v4 = create_policy_with_admin(&v3, arg1);
        0x2::package::burn_publisher(v3);
        let v5 = PackageVersionV6{
            id           : 0x2::object::new(arg1),
            version      : 6,
            whitelist_id : v0,
            version_cap  : 0x2::object::id<PackageVersionCapV6>(&v1),
            policy_id    : 0x1::option::some<0x2::object::ID>(v4),
        };
        0x2::transfer::share_object<PackageVersionV6>(v5);
        share_pause_with_cap(arg1);
        share_upgrade_governor(arg1);
    }

    public fun is_credential_revoked(arg0: &CredentialRevocations, arg1: 0x2::object::ID) : bool {
        0x1::vector::contains<0x2::object::ID>(&arg0.revoked, &arg1)
    }

    public fun is_paused(arg0: &PauseConfigV6) : bool {
        arg0.paused
    }

    public fun migrate(arg0: &mut PackageVersionV6, arg1: &PackageVersionCapV6) {
        assert_version_cap(arg0, arg1);
        assert!(arg0.version < 6, 36);
        arg0.version = 6;
        let v0 = PackageMigrated{
            old_version : arg0.version,
            new_version : 6,
        };
        0x2::event::emit<PackageMigrated>(v0);
    }

    fun new_bound_whitelist(arg0: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = AdminCapV6{id: 0x2::object::new(arg0)};
        let v1 = 0x2::object::id<AdminCapV6>(&v0);
        let v2 = AdminBoundWhitelistV6{
            id                   : 0x2::object::new(arg0),
            pools                : vector[],
            per_execute_cap_mist : 1000000000,
            admin                : v1,
        };
        let v3 = 0x2::object::id<AdminBoundWhitelistV6>(&v2);
        let v4 = BoundWhitelistV6Created{
            whitelist_id : v3,
            admin        : v1,
        };
        0x2::event::emit<BoundWhitelistV6Created>(v4);
        0x2::transfer::public_transfer<AdminCapV6>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<AdminBoundWhitelistV6>(v2);
        v3
    }

    public fun package_policy_id(arg0: &PackageVersionV6) : 0x1::option::Option<0x2::object::ID> {
        arg0.policy_id
    }

    public fun package_version(arg0: &PackageVersionV6) : u64 {
        arg0.version
    }

    public fun package_version_cap_id(arg0: &PackageVersionV6) : 0x2::object::ID {
        arg0.version_cap
    }

    public fun package_whitelist_id(arg0: &PackageVersionV6) : 0x2::object::ID {
        arg0.whitelist_id
    }

    public fun pause(arg0: &mut PauseConfigV6, arg1: &PauseCapV6, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<PauseCapV6>(arg1) == arg0.pause_cap, 38);
        arg0.paused = true;
        let v0 = Paused{by: 0x2::tx_context::sender(arg2)};
        0x2::event::emit<Paused>(v0);
    }

    public fun pause_cap_id(arg0: &PauseConfigV6) : 0x2::object::ID {
        arg0.pause_cap
    }

    public fun pay_secondary(arg0: &0x2::transfer_policy::TransferPolicy<AgentCredential>, arg1: &mut 0x2::transfer_policy::TransferRequest<AgentCredential>, arg2: &mut AgentCredential, arg3: &AgentTemplate, arg4: &CredentialRevocations, arg5: &PackageVersionV6, arg6: &PauseConfigV6, arg7: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert_not_paused(arg6);
        assert_current_version(arg5);
        assert!(arg2.transferable, 22);
        assert!(arg2.template_id == 0x2::object::id<AgentTemplate>(arg3), 15);
        assert!(arg4.template_id == 0x2::object::id<AgentTemplate>(arg3), 15);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg3.rev_list_id) && *0x1::option::borrow<0x2::object::ID>(&arg3.rev_list_id) == 0x2::object::id<CredentialRevocations>(arg4), 15);
        assert!(!arg2.revoked, 8);
        let v0 = 0x2::object::id<AgentCredential>(arg2);
        assert!(!0x1::vector::contains<0x2::object::ID>(&arg4.revoked, &v0), 8);
        assert!(!credential_is_expired(arg2, arg9), 9);
        assert!(!credential_is_exhausted(arg2), 10);
        assert!(template_usable(arg3), 2);
        assert!(0x2::transfer_policy::item<AgentCredential>(arg1) == 0x2::object::id<AgentCredential>(arg2), 28);
        let v1 = 0x2::transfer_policy::paid<AgentCredential>(arg1);
        let v2 = SecondaryRule{dummy_field: false};
        let v3 = 0x2::transfer_policy::get_rule<AgentCredential, SecondaryRule, SecondaryConfig>(v2, arg0);
        let v4 = arg3.secondary_royalty_bps;
        let v5 = v1 / 10000 * v4 + v1 % 10000 * v4 / 10000;
        let v6 = v3.platform_bps;
        assert!(v6 <= arg8, 45);
        let v7 = v1 / 10000 * v6 + v1 % 10000 * v6 / 10000;
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg7, v5, arg10), arg3.controller);
        };
        if (v7 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg7, v7, arg10), v3.platform_recipient);
        };
        let v8 = SecondaryRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<AgentCredential, SecondaryRule>(v8, arg1);
        arg2.holder = 0x2::tx_context::sender(arg10);
        let v9 = CredentialTransferred{
            template_id   : arg2.template_id,
            credential_id : 0x2::object::id<AgentCredential>(arg2),
            from          : arg2.holder,
            to            : 0x2::tx_context::sender(arg10),
        };
        0x2::event::emit<CredentialTransferred>(v9);
        let v10 = SecondarySaleCollected{
            template_id        : 0x2::object::id<AgentTemplate>(arg3),
            credential_id      : 0x2::object::id<AgentCredential>(arg2),
            buyer              : 0x2::tx_context::sender(arg10),
            price_mist         : v1,
            controller_royalty : v5,
            platform_fee       : v7,
        };
        0x2::event::emit<SecondarySaleCollected>(v10);
    }

    public fun platform_fee_bps(arg0: &FeeConfigV6) : u64 {
        arg0.fee_bps
    }

    public fun platform_fee_recipient(arg0: &FeeConfigV6) : address {
        arg0.recipient
    }

    fun propose(arg0: &mut UpgradeGovernor, arg1: u8, arg2: vector<u8>, arg3: u8, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<0x2::package::UpgradeCap>(&arg0.cap), 49);
        let v0 = 0x2::clock::timestamp_ms(arg4) + 172800000;
        if (0x1::option::is_some<UpgradeProposal>(&arg0.pending)) {
            let v1 = 0x1::option::extract<UpgradeProposal>(&mut arg0.pending);
            let v2 = UpgradeCancelled{
                kind   : v1.kind,
                digest : v1.digest,
                by     : 0x2::tx_context::sender(arg5),
            };
            0x2::event::emit<UpgradeCancelled>(v2);
        };
        let v3 = UpgradeProposed{
            kind   : arg1,
            digest : arg2,
            policy : arg3,
            eta_ms : v0,
            by     : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<UpgradeProposed>(v3);
        let v4 = UpgradeProposal{
            kind   : arg1,
            digest : arg2,
            policy : arg3,
            eta_ms : v0,
        };
        0x1::option::fill<UpgradeProposal>(&mut arg0.pending, v4);
    }

    public fun propose_controller_transfer(arg0: &mut AgentTemplate, arg1: &PackageVersionV6, arg2: &PauseConfigV6, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_not_paused(arg2);
        assert_current_version(arg1);
        assert!(0x2::tx_context::sender(arg5) == arg0.controller, 1);
        let v0 = 0x2::clock::timestamp_ms(arg4) + 604800000;
        let v1 = ControllerTransferRequest{
            id             : 0x2::object::new(arg5),
            template_id    : 0x2::object::id<AgentTemplate>(arg0),
            old_controller : arg0.controller,
            new_controller : arg3,
            expires_at_ms  : v0,
        };
        let v2 = 0x2::object::id<ControllerTransferRequest>(&v1);
        arg0.pending_controller_request = 0x1::option::some<0x2::object::ID>(v2);
        let v3 = ControllerTransferProposed{
            template_id    : 0x2::object::id<AgentTemplate>(arg0),
            request_id     : v2,
            old_controller : arg0.controller,
            new_controller : arg3,
            expires_at_ms  : v0,
        };
        0x2::event::emit<ControllerTransferProposed>(v3);
        0x2::transfer::transfer<ControllerTransferRequest>(v1, arg3);
    }

    public fun propose_make_immutable(arg0: &mut UpgradeGovernor, arg1: &PackageVersionV6, arg2: &PackageVersionCapV6, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_current_version(arg1);
        assert_version_cap(arg1, arg2);
        propose(arg0, 1, b"", 0, arg3, arg4);
    }

    public fun propose_upgrade(arg0: &mut UpgradeGovernor, arg1: &PackageVersionV6, arg2: &PackageVersionCapV6, arg3: vector<u8>, arg4: u8, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_current_version(arg1);
        assert_version_cap(arg1, arg2);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 53);
        let v0 = if (arg4 == 0x2::package::compatible_policy()) {
            true
        } else if (arg4 == 0x2::package::additive_policy()) {
            true
        } else {
            arg4 == 0x2::package::dep_only_policy()
        };
        assert!(v0, 54);
        assert!(0x1::option::is_some<0x2::package::UpgradeCap>(&arg0.cap), 49);
        assert!(arg4 >= 0x2::package::upgrade_policy(0x1::option::borrow<0x2::package::UpgradeCap>(&arg0.cap)), 54);
        propose(arg0, 0, arg3, arg4, arg5, arg6);
    }

    public fun purchase_credential(arg0: &mut AgentTemplate, arg1: &FeeConfigV6, arg2: &PackageVersionV6, arg3: &PauseConfigV6, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: u64, arg7: bool, arg8: vector<u8>, arg9: 0x2::object::ID, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : AgentCredential {
        assert_not_paused(arg3);
        assert_current_version(arg2);
        assert!(arg0.active, 2);
        assert_ready(arg0);
        assert_expected_content(arg0, &arg8, arg9);
        assert!(arg0.credentials_sold < arg0.max_credentials, 3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) == arg0.price_mist, 4);
        assert_buyer_params(arg0, arg5, arg6);
        let v0 = 0x2::clock::timestamp_ms(arg10);
        let v1 = &mut arg4;
        take_platform_fee(arg1, v1, 0x2::object::id<AgentTemplate>(arg0), arg11);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, arg0.controller);
        let v2 = AgentCredential{
            id                     : 0x2::object::new(arg11),
            template_id            : 0x2::object::id<AgentTemplate>(arg0),
            holder                 : 0x2::tx_context::sender(arg11),
            purchased_at           : v0,
            expires_at             : expiry_of(v0, arg6),
            execute_count          : 0,
            max_executes           : arg5,
            private_config_blob_id : 0x1::string::utf8(b""),
            private_config_root    : b"",
            transferable           : arg7,
            revoked                : false,
        };
        arg0.credentials_sold = arg0.credentials_sold + 1;
        let v3 = CredentialMinted{
            template_id     : 0x2::object::id<AgentTemplate>(arg0),
            credential_id   : 0x2::object::id<AgentCredential>(&v2),
            holder          : 0x2::tx_context::sender(arg11),
            price_paid_mist : 0x2::coin::value<0x2::sui::SUI>(&arg4),
            expires_at      : expiry_of(v0, arg6),
            max_executes    : arg5,
            transferable    : arg7,
        };
        0x2::event::emit<CredentialMinted>(v3);
        v2
    }

    public fun purchase_credential_mut(arg0: &mut AgentTemplate, arg1: &FeeConfigV6, arg2: &PackageVersionV6, arg3: &PauseConfigV6, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: u64, arg7: bool, arg8: vector<u8>, arg9: 0x2::object::ID, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : AgentCredential {
        assert_not_paused(arg3);
        assert_current_version(arg2);
        assert!(arg0.active, 2);
        assert_ready(arg0);
        assert_expected_content(arg0, &arg8, arg9);
        assert!(arg0.credentials_sold < arg0.max_credentials, 3);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg4) >= arg0.price_mist, 4);
        assert_buyer_params(arg0, arg5, arg6);
        let v0 = 0x2::coin::split<0x2::sui::SUI>(arg4, arg0.price_mist, arg11);
        let v1 = 0x2::clock::timestamp_ms(arg10);
        let v2 = &mut v0;
        take_platform_fee(arg1, v2, 0x2::object::id<AgentTemplate>(arg0), arg11);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, arg0.controller);
        let v3 = AgentCredential{
            id                     : 0x2::object::new(arg11),
            template_id            : 0x2::object::id<AgentTemplate>(arg0),
            holder                 : 0x2::tx_context::sender(arg11),
            purchased_at           : v1,
            expires_at             : expiry_of(v1, arg6),
            execute_count          : 0,
            max_executes           : arg5,
            private_config_blob_id : 0x1::string::utf8(b""),
            private_config_root    : b"",
            transferable           : arg7,
            revoked                : false,
        };
        arg0.credentials_sold = arg0.credentials_sold + 1;
        let v4 = CredentialMinted{
            template_id     : 0x2::object::id<AgentTemplate>(arg0),
            credential_id   : 0x2::object::id<AgentCredential>(&v3),
            holder          : 0x2::tx_context::sender(arg11),
            price_paid_mist : 0x2::coin::value<0x2::sui::SUI>(&v0),
            expires_at      : expiry_of(v1, arg6),
            max_executes    : arg5,
            transferable    : arg7,
        };
        0x2::event::emit<CredentialMinted>(v4);
        v3
    }

    public fun restrict_upgrade_policy(arg0: &mut UpgradeGovernor, arg1: &PackageVersionV6, arg2: &PackageVersionCapV6, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert_current_version(arg1);
        assert_version_cap(arg1, arg2);
        assert!(0x1::option::is_some<0x2::package::UpgradeCap>(&arg0.cap), 49);
        assert!(arg3 == 0x2::package::additive_policy() || arg3 == 0x2::package::dep_only_policy(), 54);
        let v0 = 0x1::option::borrow_mut<0x2::package::UpgradeCap>(&mut arg0.cap);
        let v1 = 0x2::package::upgrade_policy(v0);
        assert!(arg3 > v1, 55);
        if (arg3 == 0x2::package::additive_policy()) {
            0x2::package::only_additive_upgrades(v0);
        } else {
            0x2::package::only_dep_upgrades(v0);
        };
        let v2 = false;
        if (0x1::option::is_some<UpgradeProposal>(&arg0.pending)) {
            let v3 = 0x1::option::borrow<UpgradeProposal>(&arg0.pending);
            if (v3.kind == 0 && v3.policy < arg3) {
                let v4 = 0x1::option::extract<UpgradeProposal>(&mut arg0.pending);
                let v5 = UpgradeCancelled{
                    kind   : v4.kind,
                    digest : v4.digest,
                    by     : 0x2::tx_context::sender(arg4),
                };
                0x2::event::emit<UpgradeCancelled>(v5);
                v2 = true;
            };
        };
        let v6 = UpgradePolicyRestricted{
            old_policy        : v1,
            new_policy        : arg3,
            cancelled_pending : v2,
            by                : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<UpgradePolicyRestricted>(v6);
    }

    public fun revocation_list_count(arg0: &CredentialRevocations) : u64 {
        0x1::vector::length<0x2::object::ID>(&arg0.revoked)
    }

    public fun revocation_list_revoked(arg0: &CredentialRevocations) : vector<0x2::object::ID> {
        arg0.revoked
    }

    public fun revocation_list_template_id(arg0: &CredentialRevocations) : 0x2::object::ID {
        arg0.template_id
    }

    public fun revoke_credential(arg0: &AgentTemplate, arg1: &PackageVersionV6, arg2: &mut AgentCredential, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_current_version(arg1);
        assert!(0x2::tx_context::sender(arg4) == arg0.controller, 1);
        assert!(!arg2.transferable, 11);
        arg2.revoked = true;
        let v0 = CredentialRevoked{
            template_id   : 0x2::object::id<AgentTemplate>(arg0),
            credential_id : 0x2::object::id<AgentCredential>(arg2),
            reason_code   : arg3,
        };
        0x2::event::emit<CredentialRevoked>(v0);
    }

    public fun revoke_credential_v2(arg0: &AgentTemplate, arg1: &PackageVersionV6, arg2: &mut CredentialRevocations, arg3: 0x2::object::ID, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert_current_version(arg1);
        assert!(0x2::tx_context::sender(arg5) == arg0.controller, 1);
        assert!(arg0.revocable, 26);
        assert!(arg2.template_id == 0x2::object::id<AgentTemplate>(arg0), 15);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.rev_list_id) && *0x1::option::borrow<0x2::object::ID>(&arg0.rev_list_id) == 0x2::object::id<CredentialRevocations>(arg2), 15);
        if (!0x1::vector::contains<0x2::object::ID>(&arg2.revoked, &arg3)) {
            assert!(0x1::vector::length<0x2::object::ID>(&arg2.revoked) < 1000, 24);
            0x1::vector::push_back<0x2::object::ID>(&mut arg2.revoked, arg3);
        };
        let v0 = CredentialRevoked{
            template_id   : 0x2::object::id<AgentTemplate>(arg0),
            credential_id : arg3,
            reason_code   : arg4,
        };
        0x2::event::emit<CredentialRevoked>(v0);
    }

    public fun rotate_pause_cap(arg0: &mut PauseConfigV6, arg1: PauseCapV6, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<PauseCapV6>(&arg1) == arg0.pause_cap, 38);
        let PauseCapV6 { id: v0 } = arg1;
        0x2::object::delete(v0);
        let v1 = PauseCapV6{id: 0x2::object::new(arg3)};
        let v2 = 0x2::object::id<PauseCapV6>(&v1);
        arg0.pause_cap = v2;
        let v3 = CapRotated{
            kind      : 1,
            old_cap   : 0x2::object::id<PauseCapV6>(&arg1),
            new_cap   : v2,
            recipient : arg2,
            by        : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<CapRotated>(v3);
        0x2::transfer::public_transfer<PauseCapV6>(v1, arg2);
    }

    public fun rotate_version_cap(arg0: &mut PackageVersionV6, arg1: PackageVersionCapV6, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version_cap(arg0, &arg1);
        let PackageVersionCapV6 { id: v0 } = arg1;
        0x2::object::delete(v0);
        let v1 = PackageVersionCapV6{id: 0x2::object::new(arg3)};
        let v2 = 0x2::object::id<PackageVersionCapV6>(&v1);
        arg0.version_cap = v2;
        let v3 = CapRotated{
            kind      : 2,
            old_cap   : 0x2::object::id<PackageVersionCapV6>(&arg1),
            new_cap   : v2,
            recipient : arg2,
            by        : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<CapRotated>(v3);
        0x2::transfer::public_transfer<PackageVersionCapV6>(v1, arg2);
    }

    public fun rotate_whitelist_admin(arg0: &mut AdminBoundWhitelistV6, arg1: &PackageVersionV6, arg2: AdminCapV6, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert_current_version(arg1);
        assert!(0x2::object::id<AdminBoundWhitelistV6>(arg0) == arg1.whitelist_id, 32);
        assert!(0x2::object::id<AdminCapV6>(&arg2) == arg0.admin, 19);
        let AdminCapV6 { id: v0 } = arg2;
        0x2::object::delete(v0);
        let v1 = AdminCapV6{id: 0x2::object::new(arg4)};
        let v2 = 0x2::object::id<AdminCapV6>(&v1);
        arg0.admin = v2;
        let v3 = CapRotated{
            kind      : 0,
            old_cap   : 0x2::object::id<AdminCapV6>(&arg2),
            new_cap   : v2,
            recipient : arg3,
            by        : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<CapRotated>(v3);
        0x2::transfer::public_transfer<AdminCapV6>(v1, arg3);
    }

    entry fun seal_approve_v6(arg0: vector<u8>, arg1: &PackageVersionV6, arg2: &AgentCredential, arg3: &AgentTemplate, arg4: &SealPolicyV6, arg5: &CredentialRevocations, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert!(arg1.version == 6, 37);
        assert!(arg4.template_id == 0x2::object::id<AgentTemplate>(arg3), 16);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg3.seal_policy_id) && *0x1::option::borrow<0x2::object::ID>(&arg3.seal_policy_id) == 0x2::object::id<SealPolicyV6>(arg4), 16);
        assert!(arg2.template_id == 0x2::object::id<AgentTemplate>(arg3), 15);
        assert!(arg2.holder == 0x2::tx_context::sender(arg7), 12);
        assert!(!arg2.revoked, 8);
        assert!(arg5.template_id == 0x2::object::id<AgentTemplate>(arg3), 15);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg3.rev_list_id) && *0x1::option::borrow<0x2::object::ID>(&arg3.rev_list_id) == 0x2::object::id<CredentialRevocations>(arg5), 15);
        let v0 = 0x2::object::id<AgentCredential>(arg2);
        assert!(!0x1::vector::contains<0x2::object::ID>(&arg5.revoked, &v0), 8);
        assert!(arg2.expires_at == 18446744073709551615 || 0x2::clock::timestamp_ms(arg6) <= arg2.expires_at, 9);
        assert!(template_usable(arg3), 2);
        let v1 = 0x2::object::id<AgentTemplate>(arg3);
        let v2 = 0x2::object::id_to_bytes(&v1);
        0x1::vector::append<u8>(&mut v2, arg4.seal_nonce);
        assert!(arg0 == v2, 17);
    }

    public fun seal_policy_nonce(arg0: &SealPolicyV6) : vector<u8> {
        arg0.seal_nonce
    }

    public fun seal_policy_template_id(arg0: &SealPolicyV6) : 0x2::object::ID {
        arg0.template_id
    }

    public fun secondary_admin_policy_id(arg0: &SecondaryPolicyAdmin) : 0x2::object::ID {
        arg0.policy_id
    }

    public fun secondary_platform_bps(arg0: &0x2::transfer_policy::TransferPolicy<AgentCredential>) : u64 {
        let v0 = SecondaryRule{dummy_field: false};
        0x2::transfer_policy::get_rule<AgentCredential, SecondaryRule, SecondaryConfig>(v0, arg0).platform_bps
    }

    public fun secondary_platform_recipient(arg0: &0x2::transfer_policy::TransferPolicy<AgentCredential>) : address {
        let v0 = SecondaryRule{dummy_field: false};
        0x2::transfer_policy::get_rule<AgentCredential, SecondaryRule, SecondaryConfig>(v0, arg0).platform_recipient
    }

    fun self_package_address() : address {
        let v0 = 0x1::type_name::with_original_ids<MARKET_V6>();
        let v1 = 0x1::type_name::address_string(&v0);
        0x2::address::from_ascii_bytes(0x1::ascii::as_bytes(&v1))
    }

    public fun set_per_execute_cap(arg0: &mut AdminBoundWhitelistV6, arg1: &PackageVersionV6, arg2: u64, arg3: &AdminCapV6, arg4: &mut 0x2::tx_context::TxContext) {
        assert_current_version(arg1);
        assert!(0x2::object::id<AdminBoundWhitelistV6>(arg0) == arg1.whitelist_id, 32);
        assert!(0x2::object::id<AdminCapV6>(arg3) == arg0.admin, 19);
        assert!(arg2 > 0 && arg2 <= 1000000000000, 40);
        arg0.per_execute_cap_mist = arg2;
        let v0 = PerExecuteCapUpdated{
            whitelist_id : 0x2::object::id<AdminBoundWhitelistV6>(arg0),
            old_mist     : arg0.per_execute_cap_mist,
            new_mist     : arg2,
            by           : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<PerExecuteCapUpdated>(v0);
    }

    public fun set_platform_fee(arg0: &mut FeeConfigV6, arg1: &PackageVersionCapV6, arg2: &PackageVersionV6, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_current_version(arg2);
        assert_version_cap(arg2, arg1);
        assert!(arg3 <= 1000, 21);
        arg0.fee_bps = arg3;
        let v0 = PlatformFeeUpdated{
            old_bps : arg0.fee_bps,
            new_bps : arg3,
            by      : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<PlatformFeeUpdated>(v0);
    }

    public fun set_platform_fee_recipient(arg0: &mut FeeConfigV6, arg1: &PackageVersionCapV6, arg2: &PackageVersionV6, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert_current_version(arg2);
        assert_version_cap(arg2, arg1);
        assert!(arg3 != @0x0, 47);
        arg0.recipient = arg3;
        let v0 = PlatformFeeRecipientUpdated{
            old_recipient : arg0.recipient,
            new_recipient : arg3,
            by            : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<PlatformFeeRecipientUpdated>(v0);
    }

    public fun set_secondary_rule(arg0: &mut 0x2::transfer_policy::TransferPolicy<AgentCredential>, arg1: &SecondaryPolicyAdmin, arg2: &PackageVersionV6, arg3: &PackageVersionCapV6, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert_current_version(arg2);
        assert_version_cap(arg2, arg3);
        assert!(0x2::object::id<0x2::transfer_policy::TransferPolicy<AgentCredential>>(arg0) == arg1.policy_id, 46);
        let v0 = &arg1.cap;
        assert!(arg4 <= 1000, 21);
        assert!(arg5 != @0x0, 47);
        let v1 = SecondaryRule{dummy_field: false};
        let v2 = 0x2::transfer_policy::get_rule<AgentCredential, SecondaryRule, SecondaryConfig>(v1, arg0);
        0x2::transfer_policy::remove_rule<AgentCredential, SecondaryRule, SecondaryConfig>(arg0, v0);
        let v3 = SecondaryRule{dummy_field: false};
        let v4 = SecondaryConfig{
            platform_bps       : arg4,
            platform_recipient : arg5,
        };
        0x2::transfer_policy::add_rule<AgentCredential, SecondaryRule, SecondaryConfig>(v3, arg0, v0, v4);
        let v5 = SecondaryRuleUpdated{
            old_bps       : v2.platform_bps,
            new_bps       : arg4,
            old_recipient : v2.platform_recipient,
            new_recipient : arg5,
            by            : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<SecondaryRuleUpdated>(v5);
    }

    public fun set_transferable(arg0: &AgentTemplate, arg1: &PackageVersionV6, arg2: &mut AgentCredential, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        assert_current_version(arg1);
        assert!(0x2::tx_context::sender(arg4) == arg0.controller, 1);
        arg2.transferable = arg3;
        let v0 = CredentialTransferableUpdated{
            template_id   : 0x2::object::id<AgentTemplate>(arg0),
            credential_id : 0x2::object::id<AgentCredential>(arg2),
            transferable  : arg3,
            by            : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<CredentialTransferableUpdated>(v0);
    }

    fun share_pause_with_cap(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PauseCapV6{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<PauseCapV6>(v0, 0x2::tx_context::sender(arg0));
        let v1 = PauseConfigV6{
            id        : 0x2::object::new(arg0),
            paused    : false,
            pause_cap : 0x2::object::id<PauseCapV6>(&v0),
        };
        0x2::transfer::share_object<PauseConfigV6>(v1);
    }

    fun share_upgrade_governor(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = UpgradeGovernor{
            id      : 0x2::object::new(arg0),
            cap     : 0x1::option::none<0x2::package::UpgradeCap>(),
            pending : 0x1::option::none<UpgradeProposal>(),
        };
        0x2::transfer::share_object<UpgradeGovernor>(v0);
    }

    fun take_platform_fee(arg0: &FeeConfigV6, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(arg1);
        let v1 = arg0.fee_bps;
        let v2 = v0 / 10000 * v1 + v0 % 10000 * v1 / 10000;
        if (v2 == 0) {
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg1, v2, arg3), arg0.recipient);
        let v3 = PlatformFeeCollected{
            template_id : arg2,
            buyer       : 0x2::tx_context::sender(arg3),
            fee_amount  : v2,
            recipient   : arg0.recipient,
        };
        0x2::event::emit<PlatformFeeCollected>(v3);
    }

    public fun template_active(arg0: &AgentTemplate) : bool {
        arg0.active
    }

    public fun template_category(arg0: &AgentTemplate) : 0x1::string::String {
        arg0.category
    }

    public fun template_controller(arg0: &AgentTemplate) : address {
        arg0.controller
    }

    public fun template_credentials_sold(arg0: &AgentTemplate) : u64 {
        arg0.credentials_sold
    }

    public fun template_description(arg0: &AgentTemplate) : 0x1::string::String {
        arg0.description
    }

    public fun template_max_credentials(arg0: &AgentTemplate) : u64 {
        arg0.max_credentials
    }

    public fun template_max_executes_per_credential(arg0: &AgentTemplate) : u64 {
        arg0.max_executes_per_credential
    }

    public fun template_max_validity_ms(arg0: &AgentTemplate) : u64 {
        arg0.max_validity_ms
    }

    public fun template_name(arg0: &AgentTemplate) : 0x1::string::String {
        arg0.name
    }

    public fun template_price(arg0: &AgentTemplate) : u64 {
        arg0.price_mist
    }

    public fun template_rev_list_id(arg0: &AgentTemplate) : 0x1::option::Option<0x2::object::ID> {
        arg0.rev_list_id
    }

    public fun template_revocable(arg0: &AgentTemplate) : bool {
        arg0.revocable
    }

    public fun template_seal_policy_id(arg0: &AgentTemplate) : 0x1::option::Option<0x2::object::ID> {
        arg0.seal_policy_id
    }

    public fun template_secondary_royalty_bps(arg0: &AgentTemplate) : u64 {
        arg0.secondary_royalty_bps
    }

    public fun template_strategy_blob_id(arg0: &AgentTemplate) : 0x1::string::String {
        arg0.strategy_blob_id
    }

    public fun template_strategy_content_root(arg0: &AgentTemplate) : vector<u8> {
        arg0.strategy_content_root
    }

    fun template_usable(arg0: &AgentTemplate) : bool {
        arg0.active || !arg0.revocable
    }

    public fun unpause(arg0: &mut PauseConfigV6, arg1: &PauseCapV6, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<PauseCapV6>(arg1) == arg0.pause_cap, 38);
        arg0.paused = false;
        let v0 = Unpaused{by: 0x2::tx_context::sender(arg2)};
        0x2::event::emit<Unpaused>(v0);
    }

    public fun unwhitelist_pool_v6b(arg0: &mut AdminBoundWhitelistV6, arg1: &PackageVersionV6, arg2: address, arg3: &AdminCapV6, arg4: &mut 0x2::tx_context::TxContext) {
        assert_current_version(arg1);
        assert!(0x2::object::id<AdminBoundWhitelistV6>(arg0) == arg1.whitelist_id, 32);
        assert!(0x2::object::id<AdminCapV6>(arg3) == arg0.admin, 19);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.pools, &arg2);
        if (v0) {
            0x1::vector::remove<address>(&mut arg0.pools, v1);
            let v2 = BoundPoolV6Removed{
                whitelist_id : 0x2::object::id<AdminBoundWhitelistV6>(arg0),
                pool         : arg2,
                by           : 0x2::tx_context::sender(arg4),
            };
            0x2::event::emit<BoundPoolV6Removed>(v2);
        };
    }

    public fun update_strategy_blob(arg0: &mut AgentTemplate, arg1: &PackageVersionV6, arg2: &PauseConfigV6, arg3: 0x1::string::String, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert_not_paused(arg2);
        assert_current_version(arg1);
        assert!(0x2::tx_context::sender(arg5) == arg0.controller, 1);
        assert_content_mutable(arg0);
        assert!(0x1::string::is_empty(&arg3) == false, 5);
        arg0.strategy_blob_id = arg3;
        arg0.strategy_content_root = arg4;
        let v0 = StrategyBlobUpdated{
            template_id : 0x2::object::id<AgentTemplate>(arg0),
            blob_id     : arg3,
        };
        0x2::event::emit<StrategyBlobUpdated>(v0);
    }

    public fun upgrade_delay_ms() : u64 {
        172800000
    }

    public fun validate_credential_v2_b(arg0: &PackageVersionV6, arg1: &AgentTemplate, arg2: &AgentCredential, arg3: &CredentialRevocations, arg4: address, arg5: &AdminBoundWhitelistV6, arg6: u64, arg7: &0x2::clock::Clock) : bool {
        credential_status(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 1, arg7) == 0
    }

    public fun whitelist_pool_v6b(arg0: &mut AdminBoundWhitelistV6, arg1: &PackageVersionV6, arg2: &PauseConfigV6, arg3: address, arg4: &AdminCapV6, arg5: &mut 0x2::tx_context::TxContext) {
        assert_not_paused(arg2);
        assert_current_version(arg1);
        assert!(0x2::object::id<AdminBoundWhitelistV6>(arg0) == arg1.whitelist_id, 32);
        assert!(0x2::object::id<AdminCapV6>(arg4) == arg0.admin, 19);
        if (!0x1::vector::contains<address>(&arg0.pools, &arg3)) {
            assert!(0x1::vector::length<address>(&arg0.pools) < 200, 43);
            0x1::vector::push_back<address>(&mut arg0.pools, arg3);
            let v0 = BoundPoolV6Whitelisted{
                whitelist_id : 0x2::object::id<AdminBoundWhitelistV6>(arg0),
                pool         : arg3,
                by           : 0x2::tx_context::sender(arg5),
            };
            0x2::event::emit<BoundPoolV6Whitelisted>(v0);
        };
    }

    // decompiled from Move bytecode v7
}

