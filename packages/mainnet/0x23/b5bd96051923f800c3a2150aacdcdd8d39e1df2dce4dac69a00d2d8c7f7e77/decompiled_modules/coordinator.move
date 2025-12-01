module 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator {
    struct DWalletCoordinator has key {
        id: 0x2::object::UID,
        version: u64,
        package_id: 0x2::object::ID,
        new_package_id: 0x1::option::Option<0x2::object::ID>,
        migration_epoch: 0x1::option::Option<u64>,
    }

    public fun accept_encrypted_user_share(arg0: &mut DWalletCoordinator, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: vector<u8>) {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::accept_encrypted_user_share(inner_mut(arg0), arg1, arg2, arg3);
    }

    public fun advance_epoch(arg0: &mut DWalletCoordinator, arg1: &mut 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::advance_epoch_approver::AdvanceEpochApprover) {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::advance_epoch(inner_mut(arg0), arg1);
    }

    public fun approve_imported_key_message(arg0: &mut DWalletCoordinator, arg1: &0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::ImportedKeyDWalletCap, arg2: u32, arg3: u32, arg4: vector<u8>) : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::ImportedKeyMessageApproval {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::approve_imported_key_message(inner(arg0), arg1, arg2, arg3, arg4)
    }

    public fun approve_message(arg0: &mut DWalletCoordinator, arg1: &0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap, arg2: u32, arg3: u32, arg4: vector<u8>) : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::MessageApproval {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::approve_message(inner(arg0), arg1, arg2, arg3, arg4)
    }

    public fun calculate_pricing_votes(arg0: &mut DWalletCoordinator, arg1: u32, arg2: 0x1::option::Option<u32>, arg3: u32) {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::calculate_pricing_votes(inner_mut(arg0), arg1, arg2, arg3);
    }

    public fun commit_upgrade(arg0: &mut DWalletCoordinator, arg1: &mut 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::upgrade_package_approver::UpgradePackageApprover) {
        if (arg0.package_id == 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::upgrade_package_approver::old_package_id(arg1)) {
            arg0.migration_epoch = 0x1::option::some<u64>(0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::upgrade_package_approver::migration_epoch(arg1));
            arg0.new_package_id = 0x1::option::some<0x2::object::ID>(0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::upgrade_package_approver::approve_upgrade_package_by_witness<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCoordinatorWitness>(arg1, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::dwallet_coordinator_witness()));
        };
    }

    public(friend) fun create(arg0: 0x2::object::ID, arg1: &mut 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::advance_epoch_approver::AdvanceEpochApprover, arg2: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::system_current_status_info::SystemCurrentStatusInfo, arg3: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::pricing::PricingInfo, arg4: 0x2::vec_map::VecMap<u32, 0x2::vec_map::VecMap<u32, vector<u32>>>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = DWalletCoordinator{
            id              : 0x2::object::new(arg5),
            version         : 2,
            package_id      : arg0,
            new_package_id  : 0x1::option::none<0x2::object::ID>(),
            migration_epoch : 0x1::option::none<u64>(),
        };
        0x2::dynamic_field::add<u64, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCoordinatorInner>(&mut v0.id, 2, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::create(arg1, arg2, arg3, arg4, arg5));
        0x2::transfer::share_object<DWalletCoordinator>(v0);
    }

    public fun current_pricing(arg0: &DWalletCoordinator) : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::pricing::PricingInfo {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::current_pricing(inner(arg0))
    }

    public fun get_active_encryption_key(arg0: &DWalletCoordinator, arg1: address) : 0x2::object::ID {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::get_active_encryption_key(inner(arg0), arg1)
    }

    public fun get_dwallet(arg0: &DWalletCoordinator, arg1: 0x2::object::ID) : &0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWallet {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::get_dwallet(inner(arg0), arg1)
    }

    public fun has_dwallet(arg0: &DWalletCoordinator, arg1: 0x2::object::ID) : bool {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::has_dwallet(inner(arg0), arg1)
    }

    public fun initiate_mid_epoch_reconfiguration(arg0: &mut DWalletCoordinator, arg1: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::system_current_status_info::SystemCurrentStatusInfo) {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::initiate_mid_epoch_reconfiguration(inner_mut(arg0), arg1);
    }

    public(friend) fun inner(arg0: &DWalletCoordinator) : &0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCoordinatorInner {
        assert!(arg0.version == 2, 0);
        0x2::dynamic_field::borrow<u64, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCoordinatorInner>(&arg0.id, 2)
    }

    public(friend) fun inner_mut(arg0: &mut DWalletCoordinator) : &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCoordinatorInner {
        assert!(arg0.version == 2, 0);
        0x2::dynamic_field::borrow_mut<u64, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCoordinatorInner>(&mut arg0.id, 2)
    }

    fun inner_without_version_check(arg0: &DWalletCoordinator) : &0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCoordinatorInner {
        0x2::dynamic_field::borrow<u64, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCoordinatorInner>(&arg0.id, arg0.version)
    }

    public fun is_partial_user_signature_valid(arg0: &DWalletCoordinator, arg1: &0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPartialUserSignatureCap) : bool {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::is_partial_user_signature_valid(inner(arg0), arg1)
    }

    public fun is_presign_valid(arg0: &DWalletCoordinator, arg1: &0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap) : bool {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::is_presign_valid(inner(arg0), arg1)
    }

    public fun match_partial_user_signature_with_imported_key_message_approval(arg0: &DWalletCoordinator, arg1: &0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::VerifiedPartialUserSignatureCap, arg2: &0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::ImportedKeyMessageApproval) : bool {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::match_partial_user_signature_with_imported_key_message_approval(inner(arg0), arg1, arg2)
    }

    public fun match_partial_user_signature_with_message_approval(arg0: &DWalletCoordinator, arg1: &0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::VerifiedPartialUserSignatureCap, arg2: &0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::MessageApproval) : bool {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::match_partial_user_signature_with_message_approval(inner(arg0), arg1, arg2)
    }

    public fun process_checkpoint_message_by_cap(arg0: &mut DWalletCoordinator, arg1: vector<u8>, arg2: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::protocol_cap::VerifiedProtocolCap, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::process_checkpoint_message_by_cap(inner_mut(arg0), arg1, arg2, arg3)
    }

    public fun process_checkpoint_message_by_quorum(arg0: &mut DWalletCoordinator, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::process_checkpoint_message_by_quorum(inner_mut(arg0), arg1, arg2, arg3, arg4)
    }

    public fun register_encryption_key(arg0: &mut DWalletCoordinator, arg1: u32, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::register_encryption_key(inner_mut(arg0), arg1, arg2, arg3, arg4, arg5);
    }

    public fun register_session_identifier(arg0: &mut DWalletCoordinator, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::sessions_manager::SessionIdentifier {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::register_session_identifier(inner_mut(arg0), arg1, arg2)
    }

    public fun request_dwallet_dkg(arg0: &mut DWalletCoordinator, arg1: 0x2::object::ID, arg2: u32, arg3: vector<u8>, arg4: vector<u8>, arg5: address, arg6: vector<u8>, arg7: vector<u8>, arg8: 0x1::option::Option<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::SignDuringDKGRequest>, arg9: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::sessions_manager::SessionIdentifier, arg10: &mut 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg11: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg12: &mut 0x2::tx_context::TxContext) : (0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap, 0x1::option::Option<0x2::object::ID>) {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::request_dwallet_dkg(inner_mut(arg0), arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    }

    public fun request_dwallet_dkg_first_round(arg0: &mut DWalletCoordinator, arg1: 0x2::object::ID, arg2: u32, arg3: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::sessions_manager::SessionIdentifier, arg4: &mut 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg5: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap {
        abort 2
    }

    public fun request_dwallet_dkg_second_round(arg0: &mut DWalletCoordinator, arg1: &0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap, arg2: vector<u8>, arg3: vector<u8>, arg4: address, arg5: vector<u8>, arg6: vector<u8>, arg7: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::sessions_manager::SessionIdentifier, arg8: &mut 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg9: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg10: &mut 0x2::tx_context::TxContext) {
        abort 2
    }

    public fun request_dwallet_dkg_with_public_user_secret_key_share(arg0: &mut DWalletCoordinator, arg1: 0x2::object::ID, arg2: u32, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: 0x1::option::Option<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::SignDuringDKGRequest>, arg7: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::sessions_manager::SessionIdentifier, arg8: &mut 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg9: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg10: &mut 0x2::tx_context::TxContext) : (0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap, 0x1::option::Option<0x2::object::ID>) {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::request_dwallet_dkg_with_public_user_secret_key_share(inner_mut(arg0), arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    }

    public fun request_dwallet_network_encryption_key_dkg_by_cap(arg0: &mut DWalletCoordinator, arg1: vector<u8>, arg2: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::protocol_cap::VerifiedProtocolCap, arg3: &mut 0x2::tx_context::TxContext) {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::request_dwallet_network_encryption_key_dkg(inner_mut(arg0), arg1, arg2, arg3);
    }

    public fun request_future_sign(arg0: &mut DWalletCoordinator, arg1: 0x2::object::ID, arg2: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::VerifiedPresignCap, arg3: vector<u8>, arg4: u32, arg5: vector<u8>, arg6: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::sessions_manager::SessionIdentifier, arg7: &mut 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg8: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg9: &mut 0x2::tx_context::TxContext) : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPartialUserSignatureCap {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::request_future_sign(inner_mut(arg0), arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    public fun request_global_presign(arg0: &mut DWalletCoordinator, arg1: 0x2::object::ID, arg2: u32, arg3: u32, arg4: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::sessions_manager::SessionIdentifier, arg5: &mut 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg6: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::request_global_presign(inner_mut(arg0), arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun request_imported_key_dwallet_verification(arg0: &mut DWalletCoordinator, arg1: 0x2::object::ID, arg2: u32, arg3: vector<u8>, arg4: vector<u8>, arg5: address, arg6: vector<u8>, arg7: vector<u8>, arg8: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::sessions_manager::SessionIdentifier, arg9: &mut 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg10: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg11: &mut 0x2::tx_context::TxContext) : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::ImportedKeyDWalletCap {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::request_imported_key_dwallet_verification(inner_mut(arg0), arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
    }

    public fun request_imported_key_sign(arg0: &mut DWalletCoordinator, arg1: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::VerifiedPresignCap, arg2: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::ImportedKeyMessageApproval, arg3: vector<u8>, arg4: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::sessions_manager::SessionIdentifier, arg5: &mut 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg6: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
        request_imported_key_sign_and_return_id(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun request_imported_key_sign_and_return_id(arg0: &mut DWalletCoordinator, arg1: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::VerifiedPresignCap, arg2: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::ImportedKeyMessageApproval, arg3: vector<u8>, arg4: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::sessions_manager::SessionIdentifier, arg5: &mut 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg6: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::request_imported_key_sign(inner_mut(arg0), arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun request_imported_key_sign_with_partial_user_signature(arg0: &mut DWalletCoordinator, arg1: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::VerifiedPartialUserSignatureCap, arg2: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::ImportedKeyMessageApproval, arg3: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::sessions_manager::SessionIdentifier, arg4: &mut 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg5: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        request_imported_key_sign_with_partial_user_signature_and_return_id(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun request_imported_key_sign_with_partial_user_signature_and_return_id(arg0: &mut DWalletCoordinator, arg1: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::VerifiedPartialUserSignatureCap, arg2: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::ImportedKeyMessageApproval, arg3: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::sessions_manager::SessionIdentifier, arg4: &mut 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg5: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::request_imported_key_sign_with_partial_user_signature(inner_mut(arg0), arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun request_lock_epoch_sessions(arg0: &mut DWalletCoordinator, arg1: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::system_current_status_info::SystemCurrentStatusInfo) {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::request_lock_epoch_sessions(inner_mut(arg0), arg1);
    }

    public fun request_make_dwallet_user_secret_key_shares_public(arg0: &mut DWalletCoordinator, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::sessions_manager::SessionIdentifier, arg4: &mut 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg5: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::request_make_dwallet_user_secret_key_share_public(inner_mut(arg0), arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun request_network_encryption_key_mid_epoch_reconfiguration(arg0: &mut DWalletCoordinator, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::request_network_encryption_key_mid_epoch_reconfiguration(inner_mut(arg0), arg1, arg2);
    }

    public fun request_presign(arg0: &mut DWalletCoordinator, arg1: 0x2::object::ID, arg2: u32, arg3: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::sessions_manager::SessionIdentifier, arg4: &mut 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg5: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::request_presign(inner_mut(arg0), arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun request_re_encrypt_user_share_for(arg0: &mut DWalletCoordinator, arg1: 0x2::object::ID, arg2: address, arg3: vector<u8>, arg4: 0x2::object::ID, arg5: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::sessions_manager::SessionIdentifier, arg6: &mut 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg7: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::request_re_encrypt_user_share_for(inner_mut(arg0), arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun request_sign(arg0: &mut DWalletCoordinator, arg1: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::VerifiedPresignCap, arg2: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::MessageApproval, arg3: vector<u8>, arg4: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::sessions_manager::SessionIdentifier, arg5: &mut 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg6: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
        request_sign_and_return_id(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun request_sign_and_return_id(arg0: &mut DWalletCoordinator, arg1: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::VerifiedPresignCap, arg2: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::MessageApproval, arg3: vector<u8>, arg4: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::sessions_manager::SessionIdentifier, arg5: &mut 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg6: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::request_sign(inner_mut(arg0), arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun request_sign_with_partial_user_signature(arg0: &mut DWalletCoordinator, arg1: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::VerifiedPartialUserSignatureCap, arg2: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::MessageApproval, arg3: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::sessions_manager::SessionIdentifier, arg4: &mut 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg5: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        request_sign_with_partial_user_signature_and_return_id(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun request_sign_with_partial_user_signature_and_return_id(arg0: &mut DWalletCoordinator, arg1: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::VerifiedPartialUserSignatureCap, arg2: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::MessageApproval, arg3: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::sessions_manager::SessionIdentifier, arg4: &mut 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg5: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::request_sign_with_partial_user_signature(inner_mut(arg0), arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun set_gas_fee_reimbursement_sui_system_call_value_by_cap(arg0: &mut DWalletCoordinator, arg1: u64, arg2: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::protocol_cap::VerifiedProtocolCap) {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::set_gas_fee_reimbursement_sui_system_call_value_by_cap(inner_mut(arg0), arg1, arg2);
    }

    public fun set_global_presign_config(arg0: &mut DWalletCoordinator, arg1: 0x2::vec_map::VecMap<u32, vector<u32>>, arg2: 0x2::vec_map::VecMap<u32, vector<u32>>, arg3: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::protocol_cap::VerifiedProtocolCap) {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::set_global_presign_config(inner_mut(arg0), arg1, arg2, arg3);
    }

    public fun set_paused_curves_and_signature_algorithms(arg0: &mut DWalletCoordinator, arg1: vector<u32>, arg2: vector<u32>, arg3: vector<u32>, arg4: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::protocol_cap::VerifiedProtocolCap) {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::set_paused_curves_and_signature_algorithms(inner_mut(arg0), arg1, arg2, arg3, arg4);
    }

    public fun set_pricing_vote(arg0: &mut DWalletCoordinator, arg1: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::pricing::PricingInfo, arg2: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::VerifiedValidatorOperationCap) {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::set_pricing_vote(inner_mut(arg0), arg1, arg2);
    }

    public fun set_supported_and_pricing(arg0: &mut DWalletCoordinator, arg1: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::pricing::PricingInfo, arg2: 0x2::vec_map::VecMap<u32, 0x2::vec_map::VecMap<u32, vector<u32>>>, arg3: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::protocol_cap::VerifiedProtocolCap) {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::set_supported_and_pricing(inner_mut(arg0), arg1, arg2, arg3);
    }

    public fun sign_during_dkg_request(arg0: &mut DWalletCoordinator, arg1: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::VerifiedPresignCap, arg2: u32, arg3: vector<u8>, arg4: vector<u8>) : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::SignDuringDKGRequest {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::sign_during_dkg_request(inner_mut(arg0), arg1, arg2, arg3, arg4)
    }

    public fun subsidize_coordinator_with_ika(arg0: &mut DWalletCoordinator, arg1: 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>) {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::subsidize_coordinator_with_ika(inner_mut(arg0), arg1);
    }

    public fun subsidize_coordinator_with_sui(arg0: &mut DWalletCoordinator, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::subsidize_coordinator_with_sui(inner_mut(arg0), arg1);
    }

    public fun try_migrate(arg0: &mut DWalletCoordinator) {
        let v0 = &arg0.migration_epoch;
        assert!(0x1::option::is_some<u64>(v0) && 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::epoch(inner_without_version_check(arg0)) >= *0x1::option::borrow<u64>(v0), 1);
        try_migrate_impl(arg0);
    }

    public fun try_migrate_by_cap(arg0: &mut DWalletCoordinator, arg1: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::protocol_cap::VerifiedProtocolCap) {
        try_migrate_impl(arg0);
    }

    fun try_migrate_impl(arg0: &mut DWalletCoordinator) {
        assert!(arg0.version < 2, 1);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.new_package_id), 1);
        0x2::dynamic_field::add<u64, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCoordinatorInner>(&mut arg0.id, 2, 0x2::dynamic_field::remove<u64, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCoordinatorInner>(&mut arg0.id, arg0.version));
        arg0.version = 2;
        let v0 = inner_mut(arg0);
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::migrate(v0);
        arg0.package_id = 0x1::option::extract<0x2::object::ID>(&mut arg0.new_package_id);
        if (0x1::option::is_some<u64>(&arg0.migration_epoch)) {
            0x1::option::extract<u64>(&mut arg0.migration_epoch);
        };
    }

    public fun verify_partial_user_signature_cap(arg0: &mut DWalletCoordinator, arg1: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPartialUserSignatureCap, arg2: &mut 0x2::tx_context::TxContext) : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::VerifiedPartialUserSignatureCap {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::verify_partial_user_signature_cap(inner_mut(arg0), arg1, arg2)
    }

    public fun verify_presign_cap(arg0: &mut DWalletCoordinator, arg1: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap, arg2: &mut 0x2::tx_context::TxContext) : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::VerifiedPresignCap {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::verify_presign_cap(inner_mut(arg0), arg1, arg2)
    }

    public fun version(arg0: &DWalletCoordinator) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

