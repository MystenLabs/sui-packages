module 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::workspace {
    struct WorkspaceCreated has copy, drop {
        workspace_id: 0x2::object::ID,
        browser_address: address,
        mobile_address: address,
        mobile_cap: 0x2::object::ID,
    }

    struct MpcTransactionRequested<T0: copy + drop + store> has copy, drop {
        workspace_id: 0x2::object::ID,
        vault_id: u16,
        tx_id: u64,
        initiator: u16,
        requires_quorum_approval: bool,
        require_specific_approval_users: 0x2::vec_set::VecSet<u16>,
        specific_approval_threshold: u16,
        memo: 0x1::string::String,
        initial_status: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::MpcTxStatus,
        effects: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::TxEffects<T0>,
    }

    struct ConfigTransactionRequested has copy, drop {
        workspace_id: 0x2::object::ID,
        tx_id: u64,
        initial_status_variant_index: u8,
        initiator: u16,
        tx_types: vector<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::ConfigTxType>,
    }

    struct ProcessedModuleActionResult<T0: copy + drop + store> has copy, drop {
        workspace_id: 0x2::object::ID,
        vault_id: u16,
        tx_id: u64,
        network_id: 0x1::string::String,
        module_event: T0,
    }

    struct RetrievedUserCapsEvent has copy, drop {
        workspace_id: 0x2::object::ID,
        registration_holder: 0x2::object::ID,
        init_cap_holder_address: address,
        approve_cap_holder_address: address,
        approve_cap_holder_public_key: vector<u8>,
        recovery_cap_holder_address_opt: 0x1::option::Option<address>,
    }

    struct AeonPauseCap has store, key {
        id: 0x2::object::UID,
    }

    struct Workspace has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        vaults: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::vault::Vaults,
        users: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::Users,
        address_book: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::address_book::AddressBook,
        policy: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::policy::Policy,
        transactions: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::Transactions,
        settings: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::settings::WorkspaceSettings,
    }

    struct MpcSignatureRequest has copy, drop {
        workspace_id: 0x2::object::ID,
        vault_id: u16,
        approve_cap_id: 0x2::object::ID,
        tx_id: u64,
        tx_signable: vector<vector<u8>>,
    }

    public fun approve_config_proposal(arg0: &mut Workspace, arg1: u64, arg2: &0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::UserCap) {
        assert!(0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::settings::is_operational(&arg0.settings), 2);
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::approve_config_proposal(&arg0.users, &mut arg0.transactions, arg1, 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::authorize_user(&arg0.users, arg2, 0x1::vector::singleton<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::Permission>(0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::get_admin_quorum_permission()), true), 0x2::object::uid_to_inner(&arg0.id));
    }

    public fun approve_mpc_proposal<T0: copy + drop + store>(arg0: &mut Workspace, arg1: u64, arg2: &0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::UserCap) {
        assert!(0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::settings::is_operational(&arg0.settings), 2);
        assert!(!0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::settings::is_paused(&arg0.settings), 11);
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::approve_mpc_proposal<T0>(&arg0.users, &mut arg0.transactions, arg1, 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::authorize_user(&arg0.users, arg2, 0x1::vector::singleton<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::Permission>(0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::get_vote_mpc_proposal_permission()), true), 0x2::object::uid_to_inner(&arg0.id));
    }

    public fun reject_config_proposal(arg0: &mut Workspace, arg1: u64, arg2: &0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::UserCap) {
        assert!(0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::settings::is_operational(&arg0.settings), 2);
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::reject_config_proposal(&arg0.users, &mut arg0.transactions, arg1, 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::authorize_user(&arg0.users, arg2, 0x1::vector::singleton<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::Permission>(0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::get_admin_quorum_permission()), true), 0x2::object::uid_to_inner(&arg0.id));
    }

    public fun reject_mpc_proposal<T0: copy + drop + store>(arg0: &mut Workspace, arg1: u64, arg2: &0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::UserCap) {
        assert!(0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::settings::is_operational(&arg0.settings), 2);
        assert!(!0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::settings::is_paused(&arg0.settings), 11);
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::reject_mpc_proposal<T0>(&arg0.users, &mut arg0.transactions, arg1, 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::authorize_user(&arg0.users, arg2, 0x1::vector::singleton<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::Permission>(0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::get_vote_mpc_proposal_permission()), true), 0x2::object::uid_to_inner(&arg0.id));
    }

    public fun registration_holder_submit_commitment(arg0: &mut Workspace, arg1: &mut 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::RegistrationHolder, arg2: vector<u8>, arg3: &0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::UserCap) {
        assert!(0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::settings::is_operational(&arg0.settings), 2);
        assert!(!0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::settings::is_paused(&arg0.settings), 11);
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::registration_holder_submit_commitment(0x2::object::id<Workspace>(arg0), 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::authorize_user(&arg0.users, arg3, 0x1::vector::singleton<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::Permission>(0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::get_admin_quorum_permission()), true), arg1, arg2);
    }

    public fun add_init_cap(arg0: &mut Workspace, arg1: &0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::UserCap, arg2: &mut 0x2::tx_context::TxContext) : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::UserCap {
        assert!(0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::settings::is_operational(&arg0.settings), 2);
        assert!(!0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::settings::is_paused(&arg0.settings), 11);
        let v0 = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::get_user_by_cap_id(&arg0.users, arg1);
        assert!(0x1::option::is_some<u16>(&v0), 4);
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::add_init_cap_users(&mut arg0.users, 0x2::object::id<Workspace>(arg0), 0x1::option::extract<u16>(&mut v0), arg2)
    }

    public fun approve_mpc_tx_proposal_cancel<T0: copy + drop + store>(arg0: &mut Workspace, arg1: u64, arg2: &0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::UserCap) {
        assert!(0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::settings::is_operational(&arg0.settings), 2);
        assert!(!0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::settings::is_paused(&arg0.settings), 11);
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::approve_mpc_cancel_proposal<T0>(&arg0.users, &mut arg0.transactions, arg1, 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::authorize_user(&arg0.users, arg2, 0x1::vector::singleton<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::Permission>(0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::get_admin_quorum_permission()), true), 0x2::object::uid_to_inner(&arg0.id));
    }

    public fun cancel_config_transaction(arg0: &mut Workspace, arg1: u64, arg2: &0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::UserCap) {
        assert!(0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::settings::is_operational(&arg0.settings), 2);
        assert!(!0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::settings::is_paused(&arg0.settings), 11);
        let v0 = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::get_user_by_cap_id(&arg0.users, arg2);
        assert!(0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::is_user_initiator_config_tx(&arg0.transactions, arg1, 0x1::option::extract<u16>(&mut v0)), 1);
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::update_config_tx_status_cancelled(&mut arg0.transactions, &arg0.users, arg1, 0x2::object::uid_to_inner(&arg0.id));
    }

    public fun create_pause_cap(arg0: &mut 0x2::tx_context::TxContext) : AeonPauseCap {
        AeonPauseCap{id: 0x2::object::new(arg0)}
    }

    public fun execute_config_tx(arg0: &mut Workspace, arg1: u64, arg2: &0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::UserCap, arg3: vector<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::ConfigTxExecutionInput>, arg4: &mut 0x2::tx_context::TxContext) : vector<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::ConfigTxReturnTypes> {
        assert!(0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::settings::is_operational(&arg0.settings), 2);
        let (_, v1) = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::view_config_tx(&arg0.transactions, arg1);
        let v2 = v1;
        assert!(!0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::settings::is_paused(&arg0.settings) || 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::is_unpause_workspace_tx(&v2), 11);
        let v3 = 0x1::vector::empty<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::Permission>();
        0x1::vector::reverse<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::ConfigTxType>(&mut v2);
        while (!0x1::vector::is_empty<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::ConfigTxType>(&v2)) {
            let v4 = v3;
            0x1::vector::push_back<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::Permission>(&mut v4, 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::get_required_role_config_tx(0x1::vector::pop_back<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::ConfigTxType>(&mut v2)));
            v3 = v4;
        };
        0x1::vector::destroy_empty<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::ConfigTxType>(v2);
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::update_config_tx_status_executed(&mut arg0.transactions, &arg0.users, arg1, 0x2::object::uid_to_inner(&arg0.id));
        let v5 = 0x1::vector::empty<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::ConfigTxReturnTypes>();
        let v6 = 0;
        while (v6 < 0x1::vector::length<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::ConfigTxType>(&v2)) {
            0x1::vector::push_back<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::ConfigTxReturnTypes>(&mut v5, 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::execute_config_tx_internal(&mut arg0.users, &mut arg0.vaults, &mut arg0.policy, &mut arg0.address_book, &mut arg0.settings, 0x2::object::id<Workspace>(arg0), 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::authorize_user(&arg0.users, arg2, v3, true), *0x1::vector::borrow<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::ConfigTxType>(&v2, v6), 0x1::vector::remove<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::ConfigTxExecutionInput>(&mut arg3, 0), arg4));
            v6 = v6 + 1;
        };
        0x1::vector::destroy_empty<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::ConfigTxExecutionInput>(arg3);
        v5
    }

    public fun execute_recover_account(arg0: &mut Workspace, arg1: &0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::UserCap, arg2: address, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::settings::is_operational(&arg0.settings), 2);
        assert!(!0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::settings::is_paused(&arg0.settings), 11);
        let v0 = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::get_user_by_recovery_cap_id(&arg0.users, arg1);
        assert!(0x1::option::is_some<u16>(&v0), 0);
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::execute_config_recover_account(&mut arg0.users, 0x2::object::uid_to_inner(&arg0.id), 0x1::option::extract<u16>(&mut v0), arg2, arg3, arg4);
    }

    public fun execute_revert_eject(arg0: &mut Workspace, arg1: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::workspace_registry::EjectWrapper, arg2: &0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::UserCap) {
        assert!(!0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::settings::is_operational(&arg0.settings), 8);
        assert!(0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::workspace_registry::get_originating_workspace_cap_id(&arg1) == 0x2::object::id<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::workspace_registry::WorkspaceCap>(0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::settings::borrow_workspace_cap(&arg0.settings)), 5);
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::authorize_user(&arg0.users, arg2, 0x1::vector::singleton<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::Permission>(0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::get_admin_quorum_permission()), true);
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::settings::set_operational(&mut arg0.settings);
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::vault::execute_config_revert_eject_approve_caps(&mut arg0.vaults, 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::workspace_registry::revert_eject(arg1, 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::settings::borrow_workspace_cap(&arg0.settings)));
    }

    public fun finalize_mpc_tx<T0: copy + drop + store>(arg0: &mut Workspace, arg1: u64, arg2: &0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::UserCap) : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleActionRequest<T0> {
        assert!(0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::settings::is_operational(&arg0.settings), 2);
        assert!(!0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::settings::is_paused(&arg0.settings), 11);
        assert!(0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::is_user_initiator_mpc_tx<T0>(&arg0.transactions, arg1, 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::authorize_user(&arg0.users, arg2, 0x1::vector::singleton<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::Permission>(0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::get_sign_mpc_tx_permission()), true)), 1);
        let (_, v1, v2, v3, v4, v5) = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::view_mpc_transaction<T0>(&arg0.transactions, arg1);
        assert!(0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::is_mpc_transaction_approved(v2), 6);
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_module_action_request<T0>(0x2::object::id<Workspace>(arg0), v3, 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::vault::get_vault_address(&arg0.vaults, v3, v1), v5, v1, arg1, v4, false)
    }

    public fun get_workspace_fields(arg0: &Workspace) : (0x2::object::ID, 0x1::string::String, &0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::vault::Vaults, &0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::Users, &0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::address_book::AddressBook, &0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::policy::Policy, &0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::Transactions, &0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::settings::WorkspaceSettings) {
        (0x2::object::id<Workspace>(arg0), arg0.name, &arg0.vaults, &arg0.users, &arg0.address_book, &arg0.policy, &arg0.transactions, &arg0.settings)
    }

    public fun init_workspace(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: address, arg3: address, arg4: vector<u8>, arg5: vector<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::ConfigTxType>, arg6: vector<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::ConfigTxExecutionInput>, arg7: 0x1::option::Option<0x2::object::ID>, arg8: &mut 0x2::tx_context::TxContext) : (0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::UserCap, vector<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::ConfigTxReturnTypes>) {
        let v0 = Workspace{
            id           : 0x2::object::new(arg8),
            name         : arg1,
            vaults       : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::vault::init_vaults(),
            users        : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::init_users(1),
            address_book : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::address_book::init_address_book(),
            policy       : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::policy::init_policy(),
            transactions : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::init_transactions(arg8),
            settings     : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::settings::init_workspace_settings(arg1, arg7, arg8),
        };
        let v1 = 0x2::object::id<Workspace>(&v0);
        let (v2, v3, v4) = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::add_first_admin(&mut v0.users, v1, arg0, arg2, arg4, arg3, arg8);
        let v5 = 0x1::vector::empty<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::ConfigTxReturnTypes>();
        let v6 = 0;
        while (v6 < 0x1::vector::length<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::ConfigTxType>(&arg5)) {
            0x1::vector::push_back<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::ConfigTxReturnTypes>(&mut v5, 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::execute_config_tx_internal(&mut v0.users, &mut v0.vaults, &mut v0.policy, &mut v0.address_book, &mut v0.settings, v1, v2, *0x1::vector::borrow<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::ConfigTxType>(&arg5, v6), 0x1::vector::remove<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::ConfigTxExecutionInput>(&mut arg6, 0), arg8));
            v6 = v6 + 1;
        };
        0x1::vector::destroy_empty<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::ConfigTxExecutionInput>(arg6);
        let v7 = WorkspaceCreated{
            workspace_id    : 0x2::object::id<Workspace>(&v0),
            browser_address : 0x2::tx_context::sender(arg8),
            mobile_address  : arg2,
            mobile_cap      : v4,
        };
        0x2::event::emit<WorkspaceCreated>(v7);
        0x2::transfer::share_object<Workspace>(v0);
        (v3, v5)
    }

    public fun process_module_action_result<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut Workspace, arg1: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleActionResult<T1>) {
        let (v0, _, v2, v3, v4, v5, v6) = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::consume_module_action_result<T1>(arg1);
        assert!(0x2::object::id<Workspace>(arg0) == v0, 7);
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::update_mpc_tx_status_ready_signing<T0>(&mut arg0.transactions, &arg0.users, v3, v5, v0);
        let v7 = ProcessedModuleActionResult<T1>{
            workspace_id : v0,
            vault_id     : v2,
            tx_id        : v3,
            network_id   : v4,
            module_event : v6,
        };
        0x2::event::emit<ProcessedModuleActionResult<T1>>(v7);
    }

    public fun reject_mpc_tx_proposal_cancel<T0: copy + drop + store>(arg0: &mut Workspace, arg1: u64, arg2: &0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::UserCap) {
        assert!(0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::settings::is_operational(&arg0.settings), 2);
        assert!(!0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::settings::is_paused(&arg0.settings), 11);
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::reject_mpc_cancel_proposal<T0>(&arg0.users, &mut arg0.transactions, arg1, 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::authorize_user(&arg0.users, arg2, 0x1::vector::singleton<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::Permission>(0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::get_admin_quorum_permission()), true), 0x2::object::uid_to_inner(&arg0.id));
    }

    public fun request_cancel_mpc_transaction<T0: copy + drop + store>(arg0: &mut Workspace, arg1: u64, arg2: &0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::UserCap) {
        assert!(0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::settings::is_operational(&arg0.settings), 2);
        assert!(!0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::settings::is_paused(&arg0.settings), 11);
        let v0 = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::get_user_by_cap_id(&arg0.users, arg2);
        if (0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::is_user_initiator_mpc_tx<T0>(&arg0.transactions, arg1, 0x1::option::extract<u16>(&mut v0))) {
            0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::update_mpc_tx_status_cancelled_by_initiator<T0>(&mut arg0.transactions, &arg0.users, arg1, 0x2::object::uid_to_inner(&arg0.id));
        } else {
            0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::authorize_user(&arg0.users, arg2, 0x1::vector::singleton<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::Permission>(0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::get_admin_quorum_permission()), false);
            0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::update_mpc_tx_status_pending_mpc_tx_cancellation_quorum<T0>(&mut arg0.transactions, &arg0.users, arg1, 0x2::object::uid_to_inner(&arg0.id));
        };
    }

    public fun request_config_transaction(arg0: &mut Workspace, arg1: vector<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::ConfigTxType>, arg2: &0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::UserCap) : u64 {
        assert!(0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::settings::is_operational(&arg0.settings), 2);
        let v0 = 0x1::vector::empty<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::Permission>();
        0x1::vector::reverse<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::ConfigTxType>(&mut arg1);
        while (!0x1::vector::is_empty<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::ConfigTxType>(&arg1)) {
            let v1 = v0;
            0x1::vector::push_back<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::Permission>(&mut v1, 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::get_required_role_config_tx(0x1::vector::pop_back<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::ConfigTxType>(&mut arg1)));
            v0 = v1;
        };
        0x1::vector::destroy_empty<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::ConfigTxType>(arg1);
        let v2 = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::authorize_user(&arg0.users, arg2, v0, false);
        if (0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::is_config_tx_admin_approval_required(arg1)) {
            let v4 = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::create_config_tx_pending_approval_quorum(&mut arg0.transactions, arg1, v2);
            let v5 = ConfigTransactionRequested{
                workspace_id                 : 0x2::object::id<Workspace>(arg0),
                tx_id                        : v4,
                initial_status_variant_index : 0,
                initiator                    : v2,
                tx_types                     : arg1,
            };
            0x2::event::emit<ConfigTransactionRequested>(v5);
            v4
        } else {
            let v6 = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::create_config_tx_bypass_quorum(&mut arg0.transactions, arg1, v2);
            let v7 = ConfigTransactionRequested{
                workspace_id                 : 0x2::object::id<Workspace>(arg0),
                tx_id                        : v6,
                initial_status_variant_index : 1,
                initiator                    : v2,
                tx_types                     : arg1,
            };
            0x2::event::emit<ConfigTransactionRequested>(v7);
            v6
        }
    }

    public fun request_mpc_transaction<T0: copy + drop + store>(arg0: &mut Workspace, arg1: u16, arg2: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::TxEffectsResult<T0>, arg3: &0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::UserCap, arg4: 0x1::string::String, arg5: &0x2::clock::Clock) : u64 {
        assert!(0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::settings::is_operational(&arg0.settings), 2);
        assert!(!0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::settings::is_paused(&arg0.settings), 11);
        let v0 = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::authorize_user(&arg0.users, arg3, 0x1::vector::singleton<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::Permission>(0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::get_init_mpc_tx_permission()), false);
        let v1 = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::consume_tx_effect_result<T0>(arg2);
        let (v2, v3, v4, v5, v6, _, _, v9) = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::view_tx_effects<T0>(&v1);
        assert!(0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::vault::is_tx_authorized_vault(&arg0.vaults, arg1, v2, v5, v6, v3, v4), 3);
        let v10 = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::policy::apply_policy<T0>(&arg0.vaults, &arg0.users, &arg0.address_book, &arg0.settings, &mut arg0.policy, &v1, v0, arg1, arg5);
        let v11 = 0x2::vec_set::empty<u16>();
        let v12 = false;
        let v13 = 0;
        let (v14, v15) = if (0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::policy::is_policy_result_auto_approve(&v10)) {
            0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::create_mpc_transaction_auto_approved<T0>(&mut arg0.transactions, v0, v5, arg1, v9, v4, arg4)
        } else if (0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::policy::is_policy_result_quorum_approval_required(&v10)) {
            let (v16, v17) = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::create_mpc_transaction_pending_approval_quorum<T0>(&mut arg0.transactions, v0, v5, arg1, v9, v4, arg4);
            v12 = true;
            (v16, v17)
        } else if (0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::policy::is_policy_result_specific_approval_required(&v10)) {
            let (v18, v19) = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::policy::policy_result_get_params_specific_approval(&v10);
            v13 = v19;
            v11 = v18;
            0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::create_mpc_transaction_pending_approval_specific<T0>(&mut arg0.transactions, v0, v5, arg1, v9, v4, arg4, v18, v19)
        } else {
            assert!(0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::policy::is_policy_result_block(&v10), 9);
            0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::create_mpc_transaction_blocked<T0>(&mut arg0.transactions, v0, v5, arg1, v9, v4, arg4)
        };
        let v20 = MpcTransactionRequested<T0>{
            workspace_id                    : 0x2::object::id<Workspace>(arg0),
            vault_id                        : arg1,
            tx_id                           : v14,
            initiator                       : v0,
            requires_quorum_approval        : v12,
            require_specific_approval_users : v11,
            specific_approval_threshold     : v13,
            memo                            : arg4,
            initial_status                  : v15,
            effects                         : v1,
        };
        0x2::event::emit<MpcTransactionRequested<T0>>(v20);
        v14
    }

    public fun request_update_mpc_transaction<T0: copy + drop + store>(arg0: &mut Workspace, arg1: u64, arg2: &0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::UserCap) : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleActionRequest<T0> {
        assert!(0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::settings::is_operational(&arg0.settings), 2);
        assert!(!0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::settings::is_paused(&arg0.settings), 11);
        let (v0, v1, _, v3, v4, v5) = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::view_mpc_transaction<T0>(&arg0.transactions, arg1);
        assert!(0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::authorize_user(&arg0.users, arg2, 0x1::vector::singleton<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::Permission>(0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::get_sign_mpc_tx_permission()), true) == v0, 1);
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::update_mpc_tx_status_update_requested<T0>(&mut arg0.transactions, &arg0.users, arg1, 0x2::object::uid_to_inner(&arg0.id));
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_module_action_request<T0>(0x2::object::uid_to_inner(&arg0.id), v3, 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::vault::get_vault_address(&arg0.vaults, v3, v1), v5, v1, arg1, v4, true)
    }

    public fun retrieve_user_caps_cap_and_secret(arg0: &mut Workspace, arg1: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::RegistrationHolder, arg2: address, arg3: address, arg4: vector<u8>, arg5: 0x1::option::Option<address>, arg6: vector<u8>, arg7: &0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::RegistrationCap) {
        assert!(0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::settings::is_operational(&arg0.settings), 2);
        assert!(!0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::settings::is_paused(&arg0.settings), 11);
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::retrieve_user_caps_internal_cap_and_secret(&mut arg0.users, arg1, 0x2::object::id<Workspace>(arg0), arg2, arg3, arg4, arg5, arg6, 0x2::object::id<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::RegistrationCap>(arg7));
        let v0 = RetrievedUserCapsEvent{
            workspace_id                    : 0x2::object::id<Workspace>(arg0),
            registration_holder             : 0x2::object::id<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::RegistrationHolder>(&arg1),
            init_cap_holder_address         : arg2,
            approve_cap_holder_address      : arg3,
            approve_cap_holder_public_key   : arg4,
            recovery_cap_holder_address_opt : arg5,
        };
        0x2::event::emit<RetrievedUserCapsEvent>(v0);
    }

    public fun retrieve_user_caps_evm(arg0: &mut Workspace, arg1: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::RegistrationHolder, arg2: address, arg3: address, arg4: vector<u8>, arg5: 0x1::option::Option<address>, arg6: u64, arg7: vector<u8>, arg8: &0x2::clock::Clock) {
        assert!(0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::settings::is_operational(&arg0.settings), 2);
        assert!(!0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::settings::is_paused(&arg0.settings), 11);
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::retrieve_user_caps_internal_evm(&mut arg0.users, arg1, 0x2::object::id<Workspace>(arg0), arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v0 = RetrievedUserCapsEvent{
            workspace_id                    : 0x2::object::id<Workspace>(arg0),
            registration_holder             : 0x2::object::id<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::RegistrationHolder>(&arg1),
            init_cap_holder_address         : arg2,
            approve_cap_holder_address      : arg3,
            approve_cap_holder_public_key   : arg4,
            recovery_cap_holder_address_opt : arg5,
        };
        0x2::event::emit<RetrievedUserCapsEvent>(v0);
    }

    public fun sign_mpc_tx<T0: copy + drop + store>(arg0: &mut Workspace, arg1: u64, arg2: &0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::UserCap) : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::approve_interface::ApproveRequest {
        assert!(0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::settings::is_operational(&arg0.settings), 2);
        assert!(!0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::settings::is_paused(&arg0.settings), 11);
        let v0 = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::authorize_user(&arg0.users, arg2, 0x1::vector::singleton<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::Permission>(0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::user::get_sign_mpc_tx_permission()), true);
        let (v1, _, _, v4, _, _) = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::view_mpc_transaction<T0>(&arg0.transactions, arg1);
        assert!(v0 == v1, 1);
        let v7 = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::view_mpc_ready_signing_tx_signable<T0>(&arg0.transactions, arg1);
        if (0x1::vector::length<vector<u8>>(&v7) > 0) {
            let v8 = &v7;
            let v9 = 0;
            let v10;
            while (v9 < 0x1::vector::length<vector<u8>>(v8)) {
                if (!(0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(v8, v9)) > 0)) {
                    v10 = false;
                    /* label 14 */
                    /* label 15 */
                    assert!(v10, 10);
                    0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::transaction::update_mpc_tx_status_signing_requested<T0>(&mut arg0.transactions, &arg0.users, arg1, 0x2::object::uid_to_inner(&arg0.id));
                    let v11 = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::vault::borrow_approve_cap(&mut arg0.vaults, v4);
                    let v12 = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::approve_interface::create_approve_request(v11, 0x2::object::id<Workspace>(arg0), v4, v0, v7);
                    let v13 = MpcSignatureRequest{
                        workspace_id   : 0x2::object::id<Workspace>(arg0),
                        vault_id       : v4,
                        approve_cap_id : 0x2::object::id<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::approve_interface::ApproveCap>(v11),
                        tx_id          : arg1,
                        tx_signable    : v7,
                    };
                    0x2::event::emit<MpcSignatureRequest>(v13);
                    return v12
                };
                v9 = v9 + 1;
            };
            v10 = true;
            /* goto 14 */
        } else {
            /* goto 15 */
        };
    }

    public fun trigger_pause_workspace(arg0: &mut Workspace, arg1: &AeonPauseCap) {
        let v0 = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::settings::get_admin_pause_cap_id(&arg0.settings);
        let v1 = 0x2::object::id<AeonPauseCap>(arg1);
        assert!(&v1 == 0x1::option::borrow<0x2::object::ID>(&v0), 4);
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::settings::execute_config_trigger_pause_workspace(&mut arg0.settings);
    }

    // decompiled from Move bytecode v6
}

