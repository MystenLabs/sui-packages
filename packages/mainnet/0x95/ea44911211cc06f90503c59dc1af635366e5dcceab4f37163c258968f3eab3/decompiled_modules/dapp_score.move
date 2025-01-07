module 0x95ea44911211cc06f90503c59dc1af635366e5dcceab4f37163c258968f3eab3::dapp_score {
    struct AddSuperAdminEvent has copy, drop {
        new_admin: address,
        by: address,
    }

    struct RemoveSuperAdminEvent has copy, drop {
        admin: address,
        by: address,
    }

    struct AddUpdaterEvent has copy, drop {
        object_id: 0x2::object::ID,
        updater: address,
        by: address,
    }

    struct RemoveUpdaterEvent has copy, drop {
        object_id: 0x2::object::ID,
        updater: address,
        by: address,
    }

    struct CreateDappConfigEvent has copy, drop {
        dapp: 0x1::string::String,
        object_id: 0x2::object::ID,
        display_name: 0x1::string::String,
        data: 0x1::string::String,
        image_url: 0x1::string::String,
        by: address,
    }

    struct AddDappAdminEvent has copy, drop {
        dapp: 0x1::string::String,
        admin: address,
        by: address,
    }

    struct RemoveDappAdminEvent has copy, drop {
        dapp: 0x1::string::String,
        admin: address,
        by: address,
    }

    struct UpdateDappDisplayNameEvent has copy, drop {
        dapp: 0x1::string::String,
        display_name: 0x1::string::String,
        by: address,
    }

    struct UpdateDappDataEvent has copy, drop {
        dapp: 0x1::string::String,
        data: 0x1::string::String,
        by: address,
    }

    struct UpdateDappImageUrlEvent has copy, drop {
        dapp: 0x1::string::String,
        image_url: 0x1::string::String,
        by: address,
    }

    struct AddDappScoreTargetEvent has copy, drop {
        dapp: 0x1::string::String,
        target: 0x1::string::String,
        weight: u256,
        weight_is_negative: bool,
        weight_is_immutable: bool,
        data: 0x1::string::String,
        by: address,
    }

    struct EditTargetWeightEvent has copy, drop {
        dapp: 0x1::string::String,
        target: 0x1::string::String,
        weight: u256,
        by: address,
    }

    struct EditTargetDataEvent has copy, drop {
        dapp: 0x1::string::String,
        target: 0x1::string::String,
        data: 0x1::string::String,
        by: address,
    }

    struct EditTargetSignEvent has copy, drop {
        dapp: 0x1::string::String,
        target: 0x1::string::String,
        weight_is_negative: bool,
        by: address,
    }

    struct MakeTargetWeightImmutableEvent has copy, drop {
        dapp: 0x1::string::String,
        target: 0x1::string::String,
        by: address,
    }

    struct NewDappScoreObjectEvent has copy, drop {
        object_id: 0x2::object::ID,
        user: address,
        dapp: 0x1::string::String,
        referrer: 0x1::option::Option<address>,
    }

    struct UpdateDappScoreObjectEvent has copy, drop {
        user: address,
        dapp: 0x1::string::String,
        target: 0x1::string::String,
        new_score: u256,
        score_change: u256,
        is_decrease: bool,
        is_by_admin: bool,
        is_by_admin_cap: bool,
    }

    struct UpdateRequestCreatedEvent has copy, drop {
        dapp_score_update_request_object_id: 0x2::object::ID,
        user: address,
        dapp: 0x1::string::String,
        referrer: 0x1::option::Option<address>,
        updater: address,
    }

    struct UpdateRequestDeletedEvent has copy, drop {
        dapp_score_update_request_object_id: 0x2::object::ID,
        user: address,
        dapp: 0x1::string::String,
        updater: address,
    }

    struct UserReferralEvent has copy, drop {
        user: address,
        dapp: 0x1::string::String,
        referrer: address,
    }

    struct DappScoreManager has store, key {
        id: 0x2::object::UID,
        admins: vector<address>,
        creator: address,
        dapp_config_map: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
        updater_configs: vector<0x2::object::ID>,
        user_dapp_score_object_map: 0x2::table::Table<address, DappScoreObjectMapWrapper>,
        dapp_user_score_object_map: 0x2::table::Table<0x1::string::String, UserScoreObjectMapWrapper>,
        admin_dapp_map: 0x2::table::Table<address, AdminDappMapWrapper>,
        version: u64,
    }

    struct AdminDappMapWrapper has store {
        dapps: vector<0x1::string::String>,
    }

    struct DappScoreObjectMapWrapper has store {
        dapp_score_objects_map: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
    }

    struct UserScoreObjectMapWrapper has store {
        user_score_objects_map: 0x2::table::Table<address, 0x2::object::ID>,
    }

    struct UpdaterConfig has store, key {
        id: 0x2::object::UID,
        updater: address,
        valid: bool,
    }

    struct ScoreTableItem has store {
        score: u256,
    }

    struct TargetConfig has store {
        weight: u256,
        weight_is_negative: bool,
        weight_is_immutable: bool,
        data: 0x1::string::String,
    }

    struct UserDappScore has store, key {
        id: 0x2::object::UID,
        index: u64,
        user: address,
        dapp: 0x1::string::String,
        score_table: 0x2::table::Table<0x1::string::String, ScoreTableItem>,
        referrer: 0x1::option::Option<address>,
    }

    struct DappConfig has store, key {
        id: 0x2::object::UID,
        dapp: 0x1::string::String,
        targets: 0x2::table_vec::TableVec<0x1::string::String>,
        targets_config: 0x2::table::Table<0x1::string::String, TargetConfig>,
        display_name: 0x1::string::String,
        data: 0x1::string::String,
        image_url: 0x1::string::String,
        admins: vector<address>,
    }

    struct DappScoreUpadteRequest has store, key {
        id: 0x2::object::UID,
        user: address,
        referrer: 0x1::option::Option<address>,
        dapp: 0x1::string::String,
        proof: vector<u8>,
    }

    struct DappAdminCap has drop, store {
        dapp: 0x1::string::String,
        dappConfigId: 0x2::object::ID,
    }

    public fun add_dapp_admin(arg0: &mut DappScoreManager, arg1: &mut DappConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        check_dapp_score_manager_version(arg0);
        assert_is_dapp_admin(arg1, 0x2::tx_context::sender(arg3));
        assert!(!0x1::vector::contains<address>(&arg1.admins, &arg2), 0x95ea44911211cc06f90503c59dc1af635366e5dcceab4f37163c258968f3eab3::error::duplicated_error());
        0x1::vector::push_back<address>(&mut arg1.admins, arg2);
        internal_add_admin_dapp_map(arg0, arg2, arg1.dapp);
        let v0 = AddDappAdminEvent{
            dapp  : arg1.dapp,
            admin : arg2,
            by    : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<AddDappAdminEvent>(v0);
    }

    public fun add_dapp_score_target(arg0: &mut DappConfig, arg1: 0x1::string::String, arg2: u256, arg3: 0x1::string::String, arg4: bool, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        assert_target_name_is_not_reserved(&arg1);
        assert_is_dapp_admin(arg0, 0x2::tx_context::sender(arg6));
        assert_target_not_exist(arg0, arg1);
        internal_add_dapp_score_target(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v0 = 0x1::string::utf8(b"referral__");
        0x1::string::append(&mut v0, arg1);
        internal_add_dapp_score_target(arg0, v0, 0, 0x1::string::utf8(b""), false, false, arg6);
    }

    fun add_referral_score(arg0: address, arg1: &mut UserDappScore, arg2: 0x1::string::String) {
        internal_update_user_dapp_score_object(arg1, arg2, 0x1::string::utf8(b"referral"), 1, false, false, false);
        let v0 = UserReferralEvent{
            user     : arg0,
            dapp     : arg2,
            referrer : arg1.user,
        };
        0x2::event::emit<UserReferralEvent>(v0);
    }

    public fun add_super_admin(arg0: &mut DappScoreManager, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        check_dapp_score_manager_version(arg0);
        assert_is_super_admin(arg0, 0x2::tx_context::sender(arg2));
        assert!(!0x1::vector::contains<address>(&arg0.admins, &arg1), 0x95ea44911211cc06f90503c59dc1af635366e5dcceab4f37163c258968f3eab3::error::duplicated_error());
        0x1::vector::push_back<address>(&mut arg0.admins, arg1);
        let v0 = AddSuperAdminEvent{
            new_admin : arg1,
            by        : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<AddSuperAdminEvent>(v0);
    }

    public fun add_updater(arg0: &mut DappScoreManager, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        check_dapp_score_manager_version(arg0);
        assert_is_super_admin(arg0, 0x2::tx_context::sender(arg2));
        let v0 = UpdaterConfig{
            id      : 0x2::object::new(arg2),
            updater : arg1,
            valid   : true,
        };
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.updater_configs, 0x2::object::id<UpdaterConfig>(&v0));
        let v1 = AddUpdaterEvent{
            object_id : 0x2::object::id<UpdaterConfig>(&v0),
            updater   : arg1,
            by        : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<AddUpdaterEvent>(v1);
        0x2::transfer::public_share_object<UpdaterConfig>(v0);
    }

    public fun assert_is_dapp_admin(arg0: &DappConfig, arg1: address) {
        assert!(is_dapp_admin(arg0, arg1), 0x95ea44911211cc06f90503c59dc1af635366e5dcceab4f37163c258968f3eab3::error::not_authorized_error());
    }

    public fun assert_is_super_admin(arg0: &DappScoreManager, arg1: address) {
        assert!(is_super_admin(arg0, &arg1), 0x95ea44911211cc06f90503c59dc1af635366e5dcceab4f37163c258968f3eab3::error::not_authorized_error());
    }

    public fun assert_target_exist(arg0: &DappConfig, arg1: 0x1::string::String) {
        assert!(target_exist(arg0, arg1), 0x95ea44911211cc06f90503c59dc1af635366e5dcceab4f37163c258968f3eab3::error::target_not_exist_error());
    }

    public fun assert_target_name_is_not_reserved(arg0: &0x1::string::String) {
        assert!(0x1::string::length(arg0) < 9 || 0x1::string::sub_string(arg0, 0, 10) != 0x1::string::utf8(b"referral__"), 0x95ea44911211cc06f90503c59dc1af635366e5dcceab4f37163c258968f3eab3::error::not_authorized_error());
    }

    public fun assert_target_not_exist(arg0: &DappConfig, arg1: 0x1::string::String) {
        assert!(!target_exist(arg0, arg1), 0x95ea44911211cc06f90503c59dc1af635366e5dcceab4f37163c258968f3eab3::error::duplicated_error());
    }

    public fun assert_user_dapp_score_object_exist(arg0: &DappScoreManager, arg1: address, arg2: 0x1::string::String) {
        assert!(is_user_dapp_score_object_exist(arg0, arg1, arg2), 0x95ea44911211cc06f90503c59dc1af635366e5dcceab4f37163c258968f3eab3::error::not_exist_error());
    }

    public fun assert_user_dapp_score_object_not_exist(arg0: &DappScoreManager, arg1: address, arg2: 0x1::string::String) {
        assert!(!is_user_dapp_score_object_exist(arg0, arg1, arg2), 0x95ea44911211cc06f90503c59dc1af635366e5dcceab4f37163c258968f3eab3::error::has_exist_error());
    }

    public fun assert_valid_updater(arg0: &UpdaterConfig, arg1: address) {
        assert!(arg0.valid, 0x95ea44911211cc06f90503c59dc1af635366e5dcceab4f37163c258968f3eab3::error::updater_expired_error());
        assert!(is_updater(arg0, arg1), 0x95ea44911211cc06f90503c59dc1af635366e5dcceab4f37163c258968f3eab3::error::not_authorized_error());
    }

    fun assert_weight_is_not_immutable(arg0: &DappConfig, arg1: 0x1::string::String) {
        assert!(!weight_is_immutable(arg0, arg1), 0x95ea44911211cc06f90503c59dc1af635366e5dcceab4f37163c258968f3eab3::error::not_authorized_error());
    }

    public fun borrow_dapp_targets(arg0: &DappConfig) : &0x2::table_vec::TableVec<0x1::string::String> {
        &arg0.targets
    }

    public fun borrow_dapp_targets_config(arg0: &DappConfig) : &0x2::table::Table<0x1::string::String, TargetConfig> {
        &arg0.targets_config
    }

    public fun borrow_dapp_user_score_objects_table(arg0: &DappScoreManager, arg1: 0x1::string::String) : &0x2::table::Table<address, 0x2::object::ID> {
        &0x2::table::borrow<0x1::string::String, UserScoreObjectMapWrapper>(&arg0.dapp_user_score_object_map, arg1).user_score_objects_map
    }

    public fun borrow_user_dapp_score_objects_by_user(arg0: &DappScoreManager, arg1: address) : &0x2::table::Table<0x1::string::String, 0x2::object::ID> {
        &0x2::table::borrow<address, DappScoreObjectMapWrapper>(&arg0.user_dapp_score_object_map, arg1).dapp_score_objects_map
    }

    public fun borrow_user_dapp_score_table(arg0: &UserDappScore) : &0x2::table::Table<0x1::string::String, ScoreTableItem> {
        &arg0.score_table
    }

    public fun calculate_user_total_score(arg0: &DappConfig, arg1: &UserDappScore) : u256 {
        let (v0, v1) = internal_calculate_user_total_score(arg0, arg1);
        if (v1 > v0) {
            return 0
        };
        v0 - v1
    }

    public fun calculate_user_total_score_negative_sign(arg0: &DappConfig, arg1: &UserDappScore) : u256 {
        let (v0, v1) = internal_calculate_user_total_score(arg0, arg1);
        if (v1 > v0) {
            return v1 - v0
        };
        0
    }

    public fun change_updater(arg0: &DappScoreManager, arg1: &mut UpdaterConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        check_dapp_score_manager_version(arg0);
        assert_is_super_admin(arg0, 0x2::tx_context::sender(arg3));
        arg1.updater = arg2;
        let v0 = RemoveUpdaterEvent{
            object_id : 0x2::object::id<UpdaterConfig>(arg1),
            updater   : arg1.updater,
            by        : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<RemoveUpdaterEvent>(v0);
        let v1 = AddUpdaterEvent{
            object_id : 0x2::object::id<UpdaterConfig>(arg1),
            updater   : arg2,
            by        : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<AddUpdaterEvent>(v1);
    }

    fun check_dapp_score_manager_version(arg0: &DappScoreManager) {
        assert!(arg0.version == 1, 0x95ea44911211cc06f90503c59dc1af635366e5dcceab4f37163c258968f3eab3::error::wrong_version_error());
    }

    public fun create_dapp_admin_cap_by_admin(arg0: &DappConfig, arg1: &0x2::tx_context::TxContext) : DappAdminCap {
        assert_is_dapp_admin(arg0, 0x2::tx_context::sender(arg1));
        DappAdminCap{
            dapp         : arg0.dapp,
            dappConfigId : 0x2::object::id<DappConfig>(arg0),
        }
    }

    public fun create_dapp_config(arg0: &mut DappScoreManager, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        check_dapp_score_manager_version(arg0);
        0x2::transfer::public_share_object<DappConfig>(internal_create_dapp_config(arg0, arg1, arg2, arg3, arg4, arg5));
    }

    public fun create_dapp_config_and_get_admin_cap(arg0: &mut DappScoreManager, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) : DappAdminCap {
        let v0 = internal_create_dapp_config(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_share_object<DappConfig>(v0);
        create_dapp_admin_cap_by_admin(&v0, arg5)
    }

    public fun create_dapp_score_update_request(arg0: &UpdaterConfig, arg1: 0x1::string::String, arg2: 0x1::option::Option<address>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.valid, 0x95ea44911211cc06f90503c59dc1af635366e5dcceab4f37163c258968f3eab3::error::updater_expired_error());
        let v0 = 0x2::tx_context::sender(arg4);
        internal_create_dapp_score_update_request(arg0, v0, arg1, arg2, arg3, arg4);
    }

    public fun create_dapp_score_update_request_for_user_by_admin(arg0: &DappConfig, arg1: &UpdaterConfig, arg2: address, arg3: 0x1::option::Option<address>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert_is_dapp_admin(arg0, 0x2::tx_context::sender(arg5));
        internal_create_dapp_score_update_request(arg1, arg2, arg0.dapp, arg3, arg4, arg5);
    }

    public fun create_referrer_dapp_score_object_by_updater(arg0: &UpdaterConfig, arg1: &mut DappScoreManager, arg2: &DappScoreUpadteRequest, arg3: &mut 0x2::tx_context::TxContext) : UserDappScore {
        assert_valid_updater(arg0, 0x2::tx_context::sender(arg3));
        assert!(arg2.referrer != 0x1::option::none<address>(), 0x95ea44911211cc06f90503c59dc1af635366e5dcceab4f37163c258968f3eab3::error::not_authorized_error());
        internal_create_user_dapp_score_object(arg1, *0x1::option::borrow<address>(&arg2.referrer), arg2.dapp, 0x1::option::none<address>(), arg3)
    }

    public fun create_user_dapp_score_object_by_admin(arg0: &mut DappScoreManager, arg1: &DappConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : UserDappScore {
        check_dapp_score_manager_version(arg0);
        assert_is_dapp_admin(arg1, 0x2::tx_context::sender(arg3));
        internal_create_user_dapp_score_object(arg0, arg2, arg1.dapp, 0x1::option::none<address>(), arg3)
    }

    public fun create_user_dapp_score_object_by_admin_cap(arg0: &DappAdminCap, arg1: &mut DappScoreManager, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : UserDappScore {
        internal_create_user_dapp_score_object(arg1, arg2, arg0.dapp, 0x1::option::none<address>(), arg3)
    }

    public fun create_user_dapp_score_object_by_updater(arg0: &UpdaterConfig, arg1: &mut DappScoreManager, arg2: &DappScoreUpadteRequest, arg3: &mut 0x2::tx_context::TxContext) : UserDappScore {
        assert_valid_updater(arg0, 0x2::tx_context::sender(arg3));
        assert!(0x1::option::some<address>(arg2.user) == arg2.referrer || arg2.referrer == 0x1::option::none<address>(), 0x95ea44911211cc06f90503c59dc1af635366e5dcceab4f37163c258968f3eab3::error::not_authorized_error());
        internal_create_user_dapp_score_object(arg1, arg2.user, arg2.dapp, arg2.referrer, arg3)
    }

    public fun create_user_dapp_score_object_with_referrer_by_admin_cap(arg0: &DappAdminCap, arg1: &mut DappScoreManager, arg2: address, arg3: &mut UserDappScore, arg4: &mut 0x2::tx_context::TxContext) : UserDappScore {
        add_referral_score(arg2, arg3, arg0.dapp);
        internal_create_user_dapp_score_object(arg1, arg2, arg0.dapp, 0x1::option::some<address>(arg3.user), arg4)
    }

    public fun create_user_dapp_score_object_with_referrer_by_updater(arg0: &UpdaterConfig, arg1: &mut DappScoreManager, arg2: &DappScoreUpadteRequest, arg3: &mut UserDappScore, arg4: &mut 0x2::tx_context::TxContext) : UserDappScore {
        assert_valid_updater(arg0, 0x2::tx_context::sender(arg4));
        assert!(arg2.referrer == 0x1::option::some<address>(arg3.user), 0x95ea44911211cc06f90503c59dc1af635366e5dcceab4f37163c258968f3eab3::error::not_authorized_error());
        add_referral_score(arg2.user, arg3, arg2.dapp);
        internal_create_user_dapp_score_object(arg1, arg2.user, arg2.dapp, arg2.referrer, arg4)
    }

    public fun decrease_user_dapp_score_object_by_admin_cap(arg0: &DappAdminCap, arg1: &mut UserDappScore, arg2: 0x1::string::String, arg3: u256) {
        internal_update_user_dapp_score_object(arg1, arg0.dapp, arg2, arg3, true, false, true);
    }

    public fun delete_dapp_score_update_request_by_updater(arg0: &UpdaterConfig, arg1: DappScoreUpadteRequest, arg2: &mut 0x2::tx_context::TxContext) {
        assert_valid_updater(arg0, 0x2::tx_context::sender(arg2));
        let DappScoreUpadteRequest {
            id       : v0,
            user     : v1,
            referrer : _,
            dapp     : v3,
            proof    : _,
        } = arg1;
        let v5 = UpdateRequestDeletedEvent{
            dapp_score_update_request_object_id : 0x2::object::id<DappScoreUpadteRequest>(&arg1),
            user                                : v1,
            dapp                                : v3,
            updater                             : arg0.updater,
        };
        0x2::event::emit<UpdateRequestDeletedEvent>(v5);
        0x2::object::delete(v0);
    }

    public fun edit_dapp_score_target_data(arg0: &mut DappConfig, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert_is_dapp_admin(arg0, 0x2::tx_context::sender(arg3));
        assert_target_exist(arg0, arg1);
        0x2::table::borrow_mut<0x1::string::String, TargetConfig>(&mut arg0.targets_config, arg1).data = arg2;
        let v0 = EditTargetDataEvent{
            dapp   : arg0.dapp,
            target : arg1,
            data   : arg2,
            by     : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<EditTargetDataEvent>(v0);
    }

    public fun edit_dapp_score_target_sign(arg0: &mut DappConfig, arg1: 0x1::string::String, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert_is_dapp_admin(arg0, 0x2::tx_context::sender(arg3));
        assert_target_exist(arg0, arg1);
        assert_weight_is_not_immutable(arg0, arg1);
        0x2::table::borrow_mut<0x1::string::String, TargetConfig>(&mut arg0.targets_config, arg1).weight_is_negative = arg2;
        let v0 = EditTargetSignEvent{
            dapp               : arg0.dapp,
            target             : arg1,
            weight_is_negative : arg2,
            by                 : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<EditTargetSignEvent>(v0);
    }

    public fun edit_dapp_score_target_weight(arg0: &mut DappConfig, arg1: 0x1::string::String, arg2: u256, arg3: &mut 0x2::tx_context::TxContext) {
        assert_is_dapp_admin(arg0, 0x2::tx_context::sender(arg3));
        assert_target_exist(arg0, arg1);
        assert_weight_is_not_immutable(arg0, arg1);
        0x2::table::borrow_mut<0x1::string::String, TargetConfig>(&mut arg0.targets_config, arg1).weight = arg2;
        let v0 = EditTargetWeightEvent{
            dapp   : arg0.dapp,
            target : arg1,
            weight : arg2,
            by     : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<EditTargetWeightEvent>(v0);
    }

    public fun get_dapp(arg0: &UserDappScore) : 0x1::string::String {
        arg0.dapp
    }

    public fun get_dapp_admins(arg0: &DappConfig) : vector<address> {
        arg0.admins
    }

    public fun get_dapp_data(arg0: &DappConfig) : 0x1::string::String {
        arg0.data
    }

    public fun get_dapp_display_name(arg0: &DappConfig) : 0x1::string::String {
        arg0.display_name
    }

    public fun get_dapp_image_url(arg0: &DappConfig) : 0x1::string::String {
        arg0.image_url
    }

    public fun get_referrer(arg0: &UserDappScore) : 0x1::option::Option<address> {
        arg0.referrer
    }

    public fun get_score(arg0: &UserDappScore, arg1: 0x1::string::String) : u256 {
        if (!0x2::table::contains<0x1::string::String, ScoreTableItem>(&arg0.score_table, arg1)) {
            return 0
        };
        0x2::table::borrow<0x1::string::String, ScoreTableItem>(&arg0.score_table, arg1).score
    }

    public fun get_target_weight(arg0: &DappConfig, arg1: 0x1::string::String) : u256 {
        if (!target_exist(arg0, arg1)) {
            return 0
        };
        0x2::table::borrow<0x1::string::String, TargetConfig>(&arg0.targets_config, arg1).weight
    }

    public fun get_user(arg0: &UserDappScore) : address {
        arg0.user
    }

    public fun get_user_dapp_score_index(arg0: &UserDappScore) : u64 {
        arg0.index
    }

    public fun get_user_dapp_score_object_id(arg0: &DappScoreManager, arg1: address, arg2: 0x1::string::String) : 0x2::object::ID {
        *0x2::table::borrow<0x1::string::String, 0x2::object::ID>(&0x2::table::borrow<address, DappScoreObjectMapWrapper>(&arg0.user_dapp_score_object_map, arg1).dapp_score_objects_map, arg2)
    }

    public fun increase_user_dapp_score_by_updater(arg0: &UpdaterConfig, arg1: &mut UserDappScore, arg2: &DappScoreUpadteRequest, arg3: 0x1::string::String, arg4: u256, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.referrer == 0x1::option::some<address>(arg1.user) || arg2.referrer == 0x1::option::none<address>(), 0x95ea44911211cc06f90503c59dc1af635366e5dcceab4f37163c258968f3eab3::error::not_authorized_error());
        assert_valid_updater(arg0, 0x2::tx_context::sender(arg5));
        assert!(arg1.user == arg2.user, 0x95ea44911211cc06f90503c59dc1af635366e5dcceab4f37163c258968f3eab3::error::not_authorized_error());
        internal_update_user_dapp_score_object(arg1, arg2.dapp, arg3, arg4, false, false, false);
    }

    public fun increase_user_dapp_score_object_by_admin_cap(arg0: &DappAdminCap, arg1: &mut UserDappScore, arg2: 0x1::string::String, arg3: u256) {
        internal_update_user_dapp_score_object(arg1, arg0.dapp, arg2, arg3, false, false, true);
    }

    public fun increase_user_dapp_score_with_referrer_by_updater(arg0: &UpdaterConfig, arg1: &mut UserDappScore, arg2: &mut UserDappScore, arg3: &DappScoreUpadteRequest, arg4: 0x1::string::String, arg5: u256, arg6: &mut 0x2::tx_context::TxContext) {
        assert_valid_updater(arg0, 0x2::tx_context::sender(arg6));
        assert!(arg3.referrer == 0x1::option::some<address>(arg2.user) && arg1.user != arg2.user, 0x95ea44911211cc06f90503c59dc1af635366e5dcceab4f37163c258968f3eab3::error::not_authorized_error());
        assert!(arg1.user == arg3.user, 0x95ea44911211cc06f90503c59dc1af635366e5dcceab4f37163c258968f3eab3::error::not_authorized_error());
        internal_update_user_dapp_score_object(arg1, arg3.dapp, arg4, arg5, false, false, false);
        let v0 = 0x1::string::utf8(b"referral__");
        0x1::string::append(&mut v0, arg4);
        internal_update_user_dapp_score_object(arg2, arg3.dapp, v0, arg5, false, false, false);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, 0x2::tx_context::sender(arg0));
        let v1 = DappScoreManager{
            id                         : 0x2::object::new(arg0),
            admins                     : v0,
            creator                    : 0x2::tx_context::sender(arg0),
            dapp_config_map            : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg0),
            updater_configs            : 0x1::vector::empty<0x2::object::ID>(),
            user_dapp_score_object_map : 0x2::table::new<address, DappScoreObjectMapWrapper>(arg0),
            dapp_user_score_object_map : 0x2::table::new<0x1::string::String, UserScoreObjectMapWrapper>(arg0),
            admin_dapp_map             : 0x2::table::new<address, AdminDappMapWrapper>(arg0),
            version                    : 1,
        };
        0x2::transfer::share_object<DappScoreManager>(v1);
    }

    fun internal_add_admin_dapp_map(arg0: &mut DappScoreManager, arg1: address, arg2: 0x1::string::String) {
        if (0x2::table::contains<address, AdminDappMapWrapper>(&arg0.admin_dapp_map, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, AdminDappMapWrapper>(&mut arg0.admin_dapp_map, arg1);
            assert!(!0x1::vector::contains<0x1::string::String>(&v0.dapps, &arg2), 0x95ea44911211cc06f90503c59dc1af635366e5dcceab4f37163c258968f3eab3::error::duplicated_error());
            0x1::vector::push_back<0x1::string::String>(&mut v0.dapps, arg2);
        } else {
            let v1 = 0x1::vector::empty<0x1::string::String>();
            0x1::vector::push_back<0x1::string::String>(&mut v1, arg2);
            let v2 = AdminDappMapWrapper{dapps: v1};
            0x2::table::add<address, AdminDappMapWrapper>(&mut arg0.admin_dapp_map, arg1, v2);
        };
    }

    fun internal_add_dapp_score_target(arg0: &mut DappConfig, arg1: 0x1::string::String, arg2: u256, arg3: 0x1::string::String, arg4: bool, arg5: bool, arg6: &0x2::tx_context::TxContext) {
        0x2::table_vec::push_back<0x1::string::String>(&mut arg0.targets, arg1);
        let v0 = TargetConfig{
            weight              : arg2,
            weight_is_negative  : arg4,
            weight_is_immutable : arg5,
            data                : arg3,
        };
        0x2::table::add<0x1::string::String, TargetConfig>(&mut arg0.targets_config, arg1, v0);
        let v1 = AddDappScoreTargetEvent{
            dapp                : arg0.dapp,
            target              : arg1,
            weight              : arg2,
            weight_is_negative  : arg4,
            weight_is_immutable : arg5,
            data                : arg3,
            by                  : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<AddDappScoreTargetEvent>(v1);
    }

    fun internal_calculate_user_total_score(arg0: &DappConfig, arg1: &UserDappScore) : (u256, u256) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        loop {
            if (v2 >= 0x2::table_vec::length<0x1::string::String>(&arg0.targets)) {
                break
            };
            let v3 = 0x2::table_vec::borrow<0x1::string::String>(&arg0.targets, v2);
            let v4 = 0x2::table::borrow<0x1::string::String, TargetConfig>(&arg0.targets_config, *v3);
            if (v4.weight_is_negative) {
                v1 = v1 + get_score(arg1, *v3) * v4.weight;
            } else {
                v0 = v0 + get_score(arg1, *v3) * v4.weight;
            };
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    fun internal_create_dapp_config(arg0: &mut DappScoreManager, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) : DappConfig {
        check_dapp_score_manager_version(arg0);
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, 0x2::tx_context::sender(arg5));
        internal_add_admin_dapp_map(arg0, 0x2::tx_context::sender(arg5), arg1);
        let v1 = DappConfig{
            id             : 0x2::object::new(arg5),
            dapp           : arg1,
            targets        : 0x2::table_vec::empty<0x1::string::String>(arg5),
            targets_config : 0x2::table::new<0x1::string::String, TargetConfig>(arg5),
            display_name   : arg2,
            data           : arg3,
            image_url      : arg4,
            admins         : v0,
        };
        let v2 = &mut v1;
        internal_add_dapp_score_target(v2, 0x1::string::utf8(b"referral"), 0, 0x1::string::utf8(b""), false, false, arg5);
        let v3 = &mut v1;
        internal_add_dapp_score_target(v3, 0x1::string::utf8(b"pure_increase"), 1, 0x1::string::utf8(b""), false, true, arg5);
        let v4 = &mut v1;
        internal_add_dapp_score_target(v4, 0x1::string::utf8(b"pure_decrease"), 1, 0x1::string::utf8(b""), true, true, arg5);
        assert!(!0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.dapp_config_map, arg1), 0x95ea44911211cc06f90503c59dc1af635366e5dcceab4f37163c258968f3eab3::error::duplicated_error());
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg0.dapp_config_map, arg1, 0x2::object::id<DappConfig>(&v1));
        let v5 = CreateDappConfigEvent{
            dapp         : arg1,
            object_id    : 0x2::object::id<DappConfig>(&v1),
            display_name : arg2,
            data         : arg3,
            image_url    : arg4,
            by           : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<CreateDappConfigEvent>(v5);
        let v6 = AddDappAdminEvent{
            dapp  : arg1,
            admin : 0x2::tx_context::sender(arg5),
            by    : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<AddDappAdminEvent>(v6);
        v1
    }

    fun internal_create_dapp_score_update_request(arg0: &UpdaterConfig, arg1: address, arg2: 0x1::string::String, arg3: 0x1::option::Option<address>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = DappScoreUpadteRequest{
            id       : 0x2::object::new(arg5),
            user     : arg1,
            referrer : arg3,
            dapp     : arg2,
            proof    : arg4,
        };
        0x2::transfer::public_transfer<DappScoreUpadteRequest>(v0, arg0.updater);
        let v1 = UpdateRequestCreatedEvent{
            dapp_score_update_request_object_id : 0x2::object::id<DappScoreUpadteRequest>(&v0),
            user                                : arg1,
            dapp                                : arg2,
            referrer                            : arg3,
            updater                             : arg0.updater,
        };
        0x2::event::emit<UpdateRequestCreatedEvent>(v1);
    }

    fun internal_create_user_dapp_score_object(arg0: &mut DappScoreManager, arg1: address, arg2: 0x1::string::String, arg3: 0x1::option::Option<address>, arg4: &mut 0x2::tx_context::TxContext) : UserDappScore {
        check_dapp_score_manager_version(arg0);
        assert!(!is_user_dapp_score_object_exist(arg0, arg1, arg2), 0x95ea44911211cc06f90503c59dc1af635366e5dcceab4f37163c258968f3eab3::error::duplicated_user_dapp_score_object_error());
        let v0 = UserDappScore{
            id          : 0x2::object::new(arg4),
            index       : 0x2::table::length<address, DappScoreObjectMapWrapper>(&arg0.user_dapp_score_object_map),
            user        : arg1,
            dapp        : arg2,
            score_table : 0x2::table::new<0x1::string::String, ScoreTableItem>(arg4),
            referrer    : arg3,
        };
        let v1 = NewDappScoreObjectEvent{
            object_id : 0x2::object::id<UserDappScore>(&v0),
            user      : v0.user,
            dapp      : v0.dapp,
            referrer  : v0.referrer,
        };
        0x2::event::emit<NewDappScoreObjectEvent>(v1);
        if (!0x2::table::contains<address, DappScoreObjectMapWrapper>(&arg0.user_dapp_score_object_map, arg1)) {
            let v2 = 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg4);
            0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut v2, arg2, 0x2::object::id<UserDappScore>(&v0));
            let v3 = DappScoreObjectMapWrapper{dapp_score_objects_map: v2};
            0x2::table::add<address, DappScoreObjectMapWrapper>(&mut arg0.user_dapp_score_object_map, arg1, v3);
        } else {
            0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut 0x2::table::borrow_mut<address, DappScoreObjectMapWrapper>(&mut arg0.user_dapp_score_object_map, arg1).dapp_score_objects_map, arg2, 0x2::object::id<UserDappScore>(&v0));
        };
        if (!0x2::table::contains<0x1::string::String, UserScoreObjectMapWrapper>(&arg0.dapp_user_score_object_map, arg2)) {
            let v4 = 0x2::table::new<address, 0x2::object::ID>(arg4);
            0x2::table::add<address, 0x2::object::ID>(&mut v4, arg1, 0x2::object::id<UserDappScore>(&v0));
            let v5 = UserScoreObjectMapWrapper{user_score_objects_map: v4};
            0x2::table::add<0x1::string::String, UserScoreObjectMapWrapper>(&mut arg0.dapp_user_score_object_map, arg2, v5);
        } else {
            0x2::table::add<address, 0x2::object::ID>(&mut 0x2::table::borrow_mut<0x1::string::String, UserScoreObjectMapWrapper>(&mut arg0.dapp_user_score_object_map, arg2).user_score_objects_map, arg1, 0x2::object::id<UserDappScore>(&v0));
        };
        v0
    }

    fun internal_remove_admin_dapp_map(arg0: &mut DappScoreManager, arg1: address, arg2: 0x1::string::String) {
        let v0 = 0x2::table::borrow_mut<address, AdminDappMapWrapper>(&mut arg0.admin_dapp_map, arg1);
        let (v1, v2) = 0x1::vector::index_of<0x1::string::String>(&v0.dapps, &arg2);
        assert!(v1, 0x95ea44911211cc06f90503c59dc1af635366e5dcceab4f37163c258968f3eab3::error::not_exist_error());
        0x1::vector::swap_remove<0x1::string::String>(&mut v0.dapps, v2);
    }

    fun internal_update_user_dapp_score_object(arg0: &mut UserDappScore, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u256, arg4: bool, arg5: bool, arg6: bool) {
        assert!(arg0.dapp == arg1, 0x95ea44911211cc06f90503c59dc1af635366e5dcceab4f37163c258968f3eab3::error::not_authorized_error());
        let v0 = if (!0x2::table::contains<0x1::string::String, ScoreTableItem>(&arg0.score_table, arg2)) {
            assert!(!arg4, 0x95ea44911211cc06f90503c59dc1af635366e5dcceab4f37163c258968f3eab3::error::target_not_exist_error());
            let v1 = ScoreTableItem{score: arg3};
            0x2::table::add<0x1::string::String, ScoreTableItem>(&mut arg0.score_table, arg2, v1);
            arg3
        } else {
            let v2 = 0x2::table::borrow_mut<0x1::string::String, ScoreTableItem>(&mut arg0.score_table, arg2);
            let v0 = if (arg4) {
                assert!(v2.score >= arg3, 0x95ea44911211cc06f90503c59dc1af635366e5dcceab4f37163c258968f3eab3::error::score_under_zero_error());
                v2.score - arg3
            } else {
                v2.score + arg3
            };
            v2.score = v0;
            v0
        };
        let v3 = UpdateDappScoreObjectEvent{
            user            : arg0.user,
            dapp            : arg0.dapp,
            target          : arg2,
            new_score       : v0,
            score_change    : arg3,
            is_decrease     : arg4,
            is_by_admin     : arg5,
            is_by_admin_cap : arg6,
        };
        0x2::event::emit<UpdateDappScoreObjectEvent>(v3);
    }

    public fun is_dapp_admin(arg0: &DappConfig, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.admins, &arg1)
    }

    public fun is_super_admin(arg0: &DappScoreManager, arg1: &address) : bool {
        0x1::vector::contains<address>(&arg0.admins, arg1)
    }

    public fun is_updater(arg0: &UpdaterConfig, arg1: address) : bool {
        arg0.updater == arg1
    }

    public fun is_user_dapp_score_object_exist(arg0: &DappScoreManager, arg1: address, arg2: 0x1::string::String) : bool {
        if (!0x2::table::contains<address, DappScoreObjectMapWrapper>(&arg0.user_dapp_score_object_map, arg1)) {
            return false
        };
        0x2::table::contains<0x1::string::String, 0x2::object::ID>(&0x2::table::borrow<address, DappScoreObjectMapWrapper>(&arg0.user_dapp_score_object_map, arg1).dapp_score_objects_map, arg2)
    }

    public fun make_weight_immutable(arg0: &mut DappConfig, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_dapp_admin(arg0, 0x2::tx_context::sender(arg2));
        assert_target_exist(arg0, arg1);
        0x2::table::borrow_mut<0x1::string::String, TargetConfig>(&mut arg0.targets_config, arg1).weight_is_immutable = true;
        let v0 = MakeTargetWeightImmutableEvent{
            dapp   : arg0.dapp,
            target : arg1,
            by     : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<MakeTargetWeightImmutableEvent>(v0);
    }

    public fun remove_dapp_admin(arg0: &mut DappScoreManager, arg1: &mut DappConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        check_dapp_score_manager_version(arg0);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg1.admins, &arg2);
        assert_is_dapp_admin(arg1, 0x2::tx_context::sender(arg3));
        assert!(0x1::vector::length<address>(&arg1.admins) > 1 && v0, 0x95ea44911211cc06f90503c59dc1af635366e5dcceab4f37163c258968f3eab3::error::not_authorized_error());
        0x1::vector::swap_remove<address>(&mut arg1.admins, v1);
        internal_remove_admin_dapp_map(arg0, arg2, arg1.dapp);
        let v2 = RemoveDappAdminEvent{
            dapp  : arg1.dapp,
            admin : arg2,
            by    : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<RemoveDappAdminEvent>(v2);
    }

    public fun remove_super_admin(arg0: &mut DappScoreManager, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        check_dapp_score_manager_version(arg0);
        assert_is_super_admin(arg0, 0x2::tx_context::sender(arg2));
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.admins, &arg1);
        assert!(v0 && 0x1::vector::length<address>(&arg0.admins) > 1, 0x95ea44911211cc06f90503c59dc1af635366e5dcceab4f37163c258968f3eab3::error::not_authorized_error());
        0x1::vector::swap_remove<address>(&mut arg0.admins, v1);
        let v2 = RemoveSuperAdminEvent{
            admin : arg1,
            by    : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<RemoveSuperAdminEvent>(v2);
    }

    public fun remove_updater(arg0: &mut DappScoreManager, arg1: &mut UpdaterConfig, arg2: &mut 0x2::tx_context::TxContext) {
        check_dapp_score_manager_version(arg0);
        assert_is_super_admin(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x2::object::id<UpdaterConfig>(arg1);
        let (v1, v2) = 0x1::vector::index_of<0x2::object::ID>(&arg0.updater_configs, &v0);
        assert!(v1, 0x95ea44911211cc06f90503c59dc1af635366e5dcceab4f37163c258968f3eab3::error::not_exist_error());
        0x1::vector::swap_remove<0x2::object::ID>(&mut arg0.updater_configs, v2);
        arg1.valid = false;
        let v3 = RemoveUpdaterEvent{
            object_id : 0x2::object::id<UpdaterConfig>(arg1),
            updater   : arg1.updater,
            by        : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<RemoveUpdaterEvent>(v3);
    }

    public fun reset_user_dapp_score_object_by_admin(arg0: &DappScoreManager, arg1: &DappConfig, arg2: &mut UserDappScore, arg3: 0x1::string::String, arg4: u256, arg5: &mut 0x2::tx_context::TxContext) {
        check_dapp_score_manager_version(arg0);
        assert_is_dapp_admin(arg1, 0x2::tx_context::sender(arg5));
        assert_target_exist(arg1, arg3);
        let v0 = 0x2::table::borrow_mut<0x1::string::String, ScoreTableItem>(&mut arg2.score_table, arg3);
        let v1 = v0.score > arg4;
        let v2 = if (v1) {
            v0.score - arg4
        } else {
            arg4 - v0.score
        };
        internal_update_user_dapp_score_object(arg2, arg1.dapp, arg3, v2, v1, true, false);
    }

    public fun target_exist(arg0: &DappConfig, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, TargetConfig>(&arg0.targets_config, arg1)
    }

    public fun transfer_user_dapp_score_object_to_public_share(arg0: UserDappScore) {
        0x2::transfer::public_share_object<UserDappScore>(arg0);
    }

    public fun update_dapp_data(arg0: &mut DappConfig, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_dapp_admin(arg0, 0x2::tx_context::sender(arg2));
        arg0.data = arg1;
        let v0 = UpdateDappDataEvent{
            dapp : arg0.dapp,
            data : arg1,
            by   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<UpdateDappDataEvent>(v0);
    }

    public fun update_dapp_display_name(arg0: &mut DappConfig, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_dapp_admin(arg0, 0x2::tx_context::sender(arg2));
        arg0.display_name = arg1;
        let v0 = UpdateDappDisplayNameEvent{
            dapp         : arg0.dapp,
            display_name : arg1,
            by           : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<UpdateDappDisplayNameEvent>(v0);
    }

    public fun update_dapp_image_url(arg0: &mut DappConfig, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_dapp_admin(arg0, 0x2::tx_context::sender(arg2));
        arg0.image_url = arg1;
        let v0 = UpdateDappImageUrlEvent{
            dapp      : arg0.dapp,
            image_url : arg1,
            by        : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<UpdateDappImageUrlEvent>(v0);
    }

    public fun update_user_dapp_score_object_by_admin(arg0: &DappScoreManager, arg1: &DappConfig, arg2: &mut UserDappScore, arg3: 0x1::string::String, arg4: u256, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        check_dapp_score_manager_version(arg0);
        assert_is_dapp_admin(arg1, 0x2::tx_context::sender(arg6));
        assert_target_exist(arg1, arg3);
        internal_update_user_dapp_score_object(arg2, arg1.dapp, arg3, arg4, arg5, true, false);
    }

    fun weight_is_immutable(arg0: &DappConfig, arg1: 0x1::string::String) : bool {
        0x2::table::borrow<0x1::string::String, TargetConfig>(&arg0.targets_config, arg1).weight_is_immutable
    }

    // decompiled from Move bytecode v6
}

