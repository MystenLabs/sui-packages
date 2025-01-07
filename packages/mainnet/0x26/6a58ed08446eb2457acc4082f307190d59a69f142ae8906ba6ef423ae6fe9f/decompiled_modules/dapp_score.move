module 0x266a58ed08446eb2457acc4082f307190d59a69f142ae8906ba6ef423ae6fe9f::dapp_score {
    struct AddAdminEvent has copy, drop {
        new_admin: address,
        by: address,
    }

    struct RemoveAdminEvent has copy, drop {
        admin: address,
        by: address,
    }

    struct ChangeUpdaterEvent has copy, drop {
        new_updater: address,
        by: address,
    }

    struct CreateDappEvent has copy, drop {
        dapp_index: u64,
        name: 0x1::string::String,
        data: 0x1::string::String,
        image_url: 0x1::string::String,
        by: address,
    }

    struct AddDappAdminEvent has copy, drop {
        dapp_index: u64,
        admin: address,
        by: address,
    }

    struct RemoveDappAdminEvent has copy, drop {
        dapp_index: u64,
        admin: address,
        by: address,
    }

    struct UpdateDappNameEvent has copy, drop {
        dapp_index: u64,
        old_name: 0x1::string::String,
        name: 0x1::string::String,
        by: address,
    }

    struct UpdateDappDataEvent has copy, drop {
        dapp_index: u64,
        old_data: 0x1::string::String,
        data: 0x1::string::String,
        by: address,
    }

    struct UpdateDappImageUrlEvent has copy, drop {
        dapp_index: u64,
        old_image_url: 0x1::string::String,
        image_url: 0x1::string::String,
        by: address,
    }

    struct UpdateUserOffchainScoreByUpdater has copy, drop {
        dapp_index: u64,
        user: address,
        old_score: u64,
        new_score: u64,
        score_increase: u64,
        by: address,
    }

    struct IncreaseUserScoreByAdminEvent has copy, drop {
        dapp_index: u64,
        user: address,
        old_score: u64,
        new_score: u64,
        score_increase: u64,
        by: address,
    }

    struct DecreaseUserScoreByAdminEvent has copy, drop {
        dapp_index: u64,
        user: address,
        old_score: u64,
        new_score: u64,
        score_decrease: u64,
        by: address,
    }

    struct IncreaseScoreByAdminCapEvent has copy, drop {
        dapp_index: u64,
        user: address,
        old_score: u64,
        new_score: u64,
        score_increase: u64,
        by: address,
    }

    struct DecreaseScoreByAdminCapEvent has copy, drop {
        dapp_index: u64,
        user: address,
        old_score: u64,
        new_score: u64,
        score_decrease: u64,
        by: address,
    }

    struct CreateDappScoreUpdateRequestEvent has copy, drop {
        id: 0x2::object::ID,
        updater: address,
        dapp_index: u64,
        user: address,
        referrer: 0x1::option::Option<address>,
        proof: vector<u8>,
    }

    struct DeleteDappScoreUpdateRequestEvent has copy, drop {
        id: 0x2::object::ID,
        user: address,
        dapp_index: u64,
        by: address,
    }

    struct DappScoreManager has store, key {
        id: 0x2::object::UID,
        admins: vector<address>,
        creator: address,
        dapps: 0x2::table::Table<u64, Dapp>,
        users: 0x2::table::Table<address, User>,
        next_dapp_index: u64,
        updater: address,
        version: u64,
    }

    struct Dapp has store {
        index: u64,
        name: 0x1::string::String,
        admins: vector<address>,
        users: 0x2::table::Table<address, DappUser>,
        data: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct DappUser has store {
        offchain_score: u64,
        addition_by_admin_cap: u64,
        deduction_by_admin_cap: u64,
        addition_by_admin: u64,
        deduction_by_admin: u64,
        referrer: 0x1::option::Option<address>,
    }

    struct User has store {
        dapp_indexes: vector<u64>,
        admin_dapp_indexes: vector<u64>,
    }

    struct DappAdminCap has drop, store {
        dapp_index: u64,
    }

    struct DappScoreUpadteRequest has store, key {
        id: 0x2::object::UID,
        user: address,
        referrer: 0x1::option::Option<address>,
        dapp_index: u64,
        proof: vector<u8>,
    }

    public fun add_dapp_admin(arg0: &mut DappScoreManager, arg1: u64, arg2: address, arg3: &0x2::tx_context::TxContext) {
        internal_add_dapp_admin(arg0, arg1, arg2, arg3);
    }

    public fun add_super_admin(arg0: &mut DappScoreManager, arg1: address, arg2: &0x2::tx_context::TxContext) {
        internal_add_super_admin(arg0, arg1, arg2);
    }

    public fun change_updater(arg0: &mut DappScoreManager, arg1: address, arg2: &0x2::tx_context::TxContext) {
        check_is_super_admin(arg0, arg2);
        arg0.updater = arg1;
        let v0 = ChangeUpdaterEvent{
            new_updater : arg1,
            by          : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ChangeUpdaterEvent>(v0);
    }

    public fun check_is_dapp_admin(arg0: &Dapp, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::vector::contains<address>(&arg0.admins, &v0) || 0x1::vector::length<address>(&arg0.admins) == 0, 0x266a58ed08446eb2457acc4082f307190d59a69f142ae8906ba6ef423ae6fe9f::error::not_authorized_error());
    }

    fun check_is_super_admin(arg0: &DappScoreManager, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::vector::contains<address>(&arg0.admins, &v0) || arg0.creator == 0x2::tx_context::sender(arg1), 0x266a58ed08446eb2457acc4082f307190d59a69f142ae8906ba6ef423ae6fe9f::error::not_authorized_error());
    }

    public fun check_is_updater(arg0: &DappScoreManager, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.updater == 0x2::tx_context::sender(arg1), 0x266a58ed08446eb2457acc4082f307190d59a69f142ae8906ba6ef423ae6fe9f::error::not_authorized_error());
    }

    public fun create_dapp(arg0: &mut DappScoreManager, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Dapp{
            index     : arg0.next_dapp_index,
            name      : arg1,
            admins    : 0x1::vector::empty<address>(),
            users     : 0x2::table::new<address, DappUser>(arg4),
            data      : arg2,
            image_url : arg3,
        };
        arg0.next_dapp_index = arg0.next_dapp_index + 1;
        let v1 = CreateDappEvent{
            dapp_index : v0.index,
            name       : arg1,
            data       : arg2,
            image_url  : arg3,
            by         : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<CreateDappEvent>(v1);
        0x2::table::add<u64, Dapp>(&mut arg0.dapps, v0.index, v0);
        internal_add_dapp_admin(arg0, v0.index, 0x2::tx_context::sender(arg4), arg4);
    }

    public fun create_dapp_score_update_request(arg0: address, arg1: u64, arg2: 0x1::option::Option<address>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = DappScoreUpadteRequest{
            id         : 0x2::object::new(arg4),
            user       : 0x2::tx_context::sender(arg4),
            referrer   : arg2,
            dapp_index : arg1,
            proof      : arg3,
        };
        let v1 = CreateDappScoreUpdateRequestEvent{
            id         : 0x2::object::uid_to_inner(&v0.id),
            updater    : arg0,
            dapp_index : arg1,
            user       : v0.user,
            referrer   : arg2,
            proof      : arg3,
        };
        0x2::event::emit<CreateDappScoreUpdateRequestEvent>(v1);
        0x2::transfer::transfer<DappScoreUpadteRequest>(v0, arg0);
    }

    public fun decrease_score_by_admin_cap(arg0: &mut DappScoreManager, arg1: DappAdminCap, arg2: address, arg3: 0x1::option::Option<address>, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<u64, Dapp>(&mut arg0.dapps, arg1.dapp_index);
        let v1 = v0;
        if (!0x2::table::contains<address, DappUser>(&v0.users, arg2)) {
            internal_create_dapp_user_score_profile(arg0, arg1.dapp_index, arg2, arg3);
            v1 = 0x2::table::borrow_mut<u64, Dapp>(&mut arg0.dapps, arg1.dapp_index);
        };
        let v2 = 0x2::table::borrow_mut<address, DappUser>(&mut v1.users, arg2);
        let v3 = DecreaseScoreByAdminCapEvent{
            dapp_index     : arg1.dapp_index,
            user           : arg2,
            old_score      : v2.deduction_by_admin_cap,
            new_score      : v2.deduction_by_admin_cap + arg4,
            score_decrease : arg4,
            by             : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<DecreaseScoreByAdminCapEvent>(v3);
        v2.deduction_by_admin_cap = v2.deduction_by_admin_cap + arg4;
    }

    public fun decrease_user_score_by_admin(arg0: &mut DappScoreManager, arg1: u64, arg2: address, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<u64, Dapp>(&mut arg0.dapps, arg1);
        let v1 = v0;
        check_is_dapp_admin(v0, arg4);
        if (!0x2::table::contains<address, DappUser>(&v0.users, arg2)) {
            internal_create_dapp_user_score_profile(arg0, arg1, arg2, 0x1::option::none<address>());
            v1 = 0x2::table::borrow_mut<u64, Dapp>(&mut arg0.dapps, arg1);
        };
        let v2 = 0x2::table::borrow_mut<address, DappUser>(&mut v1.users, arg2);
        let v3 = DecreaseUserScoreByAdminEvent{
            dapp_index     : arg1,
            user           : arg2,
            old_score      : v2.deduction_by_admin,
            new_score      : v2.deduction_by_admin + arg3,
            score_decrease : arg3,
            by             : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<DecreaseUserScoreByAdminEvent>(v3);
        v2.deduction_by_admin = v2.deduction_by_admin + arg3;
    }

    public fun delete_dapp_score_update_request(arg0: &DappScoreManager, arg1: DappScoreUpadteRequest, arg2: &0x2::tx_context::TxContext) {
        check_is_updater(arg0, arg2);
        let DappScoreUpadteRequest {
            id         : v0,
            user       : v1,
            referrer   : _,
            dapp_index : v3,
            proof      : _,
        } = arg1;
        let v5 = v0;
        let v6 = DeleteDappScoreUpdateRequestEvent{
            id         : 0x2::object::uid_to_inner(&v5),
            user       : v1,
            dapp_index : v3,
            by         : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<DeleteDappScoreUpdateRequestEvent>(v6);
        0x2::object::delete(v5);
    }

    public fun get_admin_cap(arg0: &DappScoreManager, arg1: u64, arg2: &0x2::tx_context::TxContext) : DappAdminCap {
        check_is_dapp_admin(0x2::table::borrow<u64, Dapp>(&arg0.dapps, arg1), arg2);
        DappAdminCap{dapp_index: arg1}
    }

    public fun get_dapp_admins(arg0: &DappScoreManager, arg1: u64) : vector<address> {
        0x2::table::borrow<u64, Dapp>(&arg0.dapps, arg1).admins
    }

    public fun get_dapp_data(arg0: &DappScoreManager, arg1: u64) : 0x1::string::String {
        0x2::table::borrow<u64, Dapp>(&arg0.dapps, arg1).data
    }

    public fun get_dapp_image_url(arg0: &DappScoreManager, arg1: u64) : 0x1::string::String {
        0x2::table::borrow<u64, Dapp>(&arg0.dapps, arg1).image_url
    }

    public fun get_dapp_name(arg0: &DappScoreManager, arg1: u64) : 0x1::string::String {
        0x2::table::borrow<u64, Dapp>(&arg0.dapps, arg1).name
    }

    public fun get_user_dapps(arg0: &DappScoreManager, arg1: address) : vector<u64> {
        0x2::table::borrow<address, User>(&arg0.users, arg1).dapp_indexes
    }

    public fun get_user_referrer(arg0: &DappScoreManager, arg1: u64, arg2: address) : 0x1::option::Option<address> {
        0x2::table::borrow<address, DappUser>(&0x2::table::borrow<u64, Dapp>(&arg0.dapps, arg1).users, arg2).referrer
    }

    public fun get_user_score(arg0: &DappScoreManager, arg1: u64, arg2: address) : u64 {
        let v0 = 0x2::table::borrow<address, DappUser>(&0x2::table::borrow<u64, Dapp>(&arg0.dapps, arg1).users, arg2);
        if (v0.deduction_by_admin + v0.deduction_by_admin_cap > v0.offchain_score + v0.addition_by_admin + v0.addition_by_admin_cap) {
            return 0
        };
        v0.offchain_score + v0.addition_by_admin + v0.addition_by_admin_cap - v0.deduction_by_admin - v0.deduction_by_admin_cap
    }

    public fun increase_score_by_admin_cap(arg0: &mut DappScoreManager, arg1: DappAdminCap, arg2: address, arg3: 0x1::option::Option<address>, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<u64, Dapp>(&mut arg0.dapps, arg1.dapp_index);
        let v1 = v0;
        if (!0x2::table::contains<address, DappUser>(&v0.users, arg2)) {
            internal_create_dapp_user_score_profile(arg0, arg1.dapp_index, arg2, arg3);
            v1 = 0x2::table::borrow_mut<u64, Dapp>(&mut arg0.dapps, arg1.dapp_index);
        };
        let v2 = 0x2::table::borrow_mut<address, DappUser>(&mut v1.users, arg2);
        let v3 = IncreaseScoreByAdminCapEvent{
            dapp_index     : arg1.dapp_index,
            user           : arg2,
            old_score      : v2.addition_by_admin_cap,
            new_score      : v2.addition_by_admin_cap + arg4,
            score_increase : arg4,
            by             : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<IncreaseScoreByAdminCapEvent>(v3);
        v2.addition_by_admin_cap = v2.addition_by_admin_cap + arg4;
    }

    public fun increase_user_score_by_admin(arg0: &mut DappScoreManager, arg1: u64, arg2: address, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<u64, Dapp>(&mut arg0.dapps, arg1);
        let v1 = v0;
        check_is_dapp_admin(v0, arg4);
        if (!0x2::table::contains<address, DappUser>(&v0.users, arg2)) {
            internal_create_dapp_user_score_profile(arg0, arg1, arg2, 0x1::option::none<address>());
            v1 = 0x2::table::borrow_mut<u64, Dapp>(&mut arg0.dapps, arg1);
        };
        let v2 = 0x2::table::borrow_mut<address, DappUser>(&mut v1.users, arg2);
        let v3 = IncreaseUserScoreByAdminEvent{
            dapp_index     : arg1,
            user           : arg2,
            old_score      : v2.addition_by_admin,
            new_score      : v2.addition_by_admin + arg3,
            score_increase : arg3,
            by             : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<IncreaseUserScoreByAdminEvent>(v3);
        v2.addition_by_admin = v2.addition_by_admin + arg3;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DappScoreManager{
            id              : 0x2::object::new(arg0),
            admins          : 0x1::vector::empty<address>(),
            creator         : 0x2::tx_context::sender(arg0),
            dapps           : 0x2::table::new<u64, Dapp>(arg0),
            users           : 0x2::table::new<address, User>(arg0),
            next_dapp_index : 0,
            updater         : @0xd71bceb881f839dd871b6d655ceec19a3332f6b30535ccd5a53bbb2c907f9003,
            version         : 1,
        };
        let v1 = &mut v0;
        internal_add_super_admin(v1, 0x2::tx_context::sender(arg0), arg0);
        0x2::transfer::share_object<DappScoreManager>(v0);
    }

    fun internal_add_dapp_admin(arg0: &mut DappScoreManager, arg1: u64, arg2: address, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<u64, Dapp>(&mut arg0.dapps, arg1);
        check_is_dapp_admin(v0, arg3);
        if (!0x2::table::contains<address, User>(&arg0.users, arg2)) {
            let v1 = User{
                dapp_indexes       : 0x1::vector::empty<u64>(),
                admin_dapp_indexes : 0x1::vector::empty<u64>(),
            };
            0x2::table::add<address, User>(&mut arg0.users, arg2, v1);
        };
        let v2 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, arg2);
        assert!(!0x1::vector::contains<address>(&v0.admins, &arg2), 0x266a58ed08446eb2457acc4082f307190d59a69f142ae8906ba6ef423ae6fe9f::error::duplicated_error());
        0x1::vector::push_back<u64>(&mut v2.admin_dapp_indexes, v0.index);
        0x1::vector::push_back<address>(&mut v0.admins, arg2);
        let v3 = AddDappAdminEvent{
            dapp_index : v0.index,
            admin      : arg2,
            by         : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<AddDappAdminEvent>(v3);
    }

    fun internal_add_super_admin(arg0: &mut DappScoreManager, arg1: address, arg2: &0x2::tx_context::TxContext) {
        check_is_super_admin(arg0, arg2);
        0x1::vector::push_back<address>(&mut arg0.admins, arg1);
        let v0 = AddAdminEvent{
            new_admin : arg1,
            by        : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<AddAdminEvent>(v0);
    }

    fun internal_create_dapp_user_score_profile(arg0: &mut DappScoreManager, arg1: u64, arg2: address, arg3: 0x1::option::Option<address>) {
        let v0 = 0x2::table::borrow_mut<u64, Dapp>(&mut arg0.dapps, arg1);
        let v1 = DappUser{
            offchain_score         : 0,
            addition_by_admin_cap  : 0,
            deduction_by_admin_cap : 0,
            addition_by_admin      : 0,
            deduction_by_admin     : 0,
            referrer               : arg3,
        };
        0x2::table::add<address, DappUser>(&mut v0.users, arg2, v1);
        if (0x2::table::contains<address, User>(&arg0.users, arg2)) {
            0x1::vector::push_back<u64>(&mut 0x2::table::borrow_mut<address, User>(&mut arg0.users, arg2).dapp_indexes, v0.index);
        } else {
            let v2 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v2, v0.index);
            let v3 = User{
                dapp_indexes       : v2,
                admin_dapp_indexes : 0x1::vector::empty<u64>(),
            };
            0x2::table::add<address, User>(&mut arg0.users, arg2, v3);
        };
    }

    fun internal_remove_dapp_admin(arg0: &mut DappScoreManager, arg1: u64, arg2: address, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<u64, Dapp>(&mut arg0.dapps, arg1);
        let v1 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, arg2);
        check_is_dapp_admin(v0, arg3);
        let (v2, v3) = 0x1::vector::index_of<address>(&v0.admins, &arg2);
        let (v4, v5) = 0x1::vector::index_of<u64>(&v1.admin_dapp_indexes, &v0.index);
        assert!(v2 && v4, 0x266a58ed08446eb2457acc4082f307190d59a69f142ae8906ba6ef423ae6fe9f::error::not_authorized_error());
        0x1::vector::remove<address>(&mut v0.admins, v3);
        assert!(0x1::vector::length<address>(&v0.admins) > 0, 0x266a58ed08446eb2457acc4082f307190d59a69f142ae8906ba6ef423ae6fe9f::error::not_authorized_error());
        0x1::vector::remove<u64>(&mut v1.admin_dapp_indexes, v5);
        let v6 = RemoveDappAdminEvent{
            dapp_index : v0.index,
            admin      : arg2,
            by         : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<RemoveDappAdminEvent>(v6);
    }

    fun internal_remove_super_admin(arg0: &mut DappScoreManager, arg1: address, arg2: &0x2::tx_context::TxContext) {
        check_is_super_admin(arg0, arg2);
        let (_, v1) = 0x1::vector::index_of<address>(&arg0.admins, &arg1);
        0x1::vector::remove<address>(&mut arg0.admins, v1);
        assert!(0x1::vector::length<address>(&arg0.admins) > 0, 0x266a58ed08446eb2457acc4082f307190d59a69f142ae8906ba6ef423ae6fe9f::error::not_authorized_error());
        let v2 = RemoveAdminEvent{
            admin : arg1,
            by    : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<RemoveAdminEvent>(v2);
    }

    public fun remove_dapp_admin(arg0: &mut DappScoreManager, arg1: u64, arg2: address, arg3: &0x2::tx_context::TxContext) {
        internal_remove_dapp_admin(arg0, arg1, arg2, arg3);
    }

    public fun remove_super_admin(arg0: &mut DappScoreManager, arg1: address, arg2: &0x2::tx_context::TxContext) {
        internal_remove_super_admin(arg0, arg1, arg2);
    }

    public fun update_dapp_data(arg0: &mut DappScoreManager, arg1: u64, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<u64, Dapp>(&mut arg0.dapps, arg1);
        check_is_dapp_admin(v0, arg3);
        let v1 = UpdateDappDataEvent{
            dapp_index : arg1,
            old_data   : v0.data,
            data       : arg2,
            by         : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<UpdateDappDataEvent>(v1);
        v0.data = arg2;
    }

    public fun update_dapp_image_url(arg0: &mut DappScoreManager, arg1: u64, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<u64, Dapp>(&mut arg0.dapps, arg1);
        check_is_dapp_admin(v0, arg3);
        let v1 = UpdateDappImageUrlEvent{
            dapp_index    : arg1,
            old_image_url : v0.image_url,
            image_url     : arg2,
            by            : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<UpdateDappImageUrlEvent>(v1);
        v0.image_url = arg2;
    }

    public fun update_dapp_name(arg0: &mut DappScoreManager, arg1: u64, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<u64, Dapp>(&mut arg0.dapps, arg1);
        check_is_dapp_admin(v0, arg3);
        let v1 = UpdateDappNameEvent{
            dapp_index : arg1,
            old_name   : v0.name,
            name       : arg2,
            by         : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<UpdateDappNameEvent>(v1);
        v0.name = arg2;
    }

    public fun update_user_offchain_score(arg0: &mut DappScoreManager, arg1: u64, arg2: address, arg3: 0x1::option::Option<address>, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        check_is_updater(arg0, arg5);
        let v0 = 0x2::table::borrow_mut<u64, Dapp>(&mut arg0.dapps, arg1);
        let v1 = v0;
        if (!0x2::table::contains<address, DappUser>(&v0.users, arg2)) {
            internal_create_dapp_user_score_profile(arg0, arg1, arg2, arg3);
            v1 = 0x2::table::borrow_mut<u64, Dapp>(&mut arg0.dapps, arg1);
        };
        let v2 = 0x2::table::borrow_mut<address, DappUser>(&mut v1.users, arg2);
        let v3 = UpdateUserOffchainScoreByUpdater{
            dapp_index     : arg1,
            user           : arg2,
            old_score      : v2.offchain_score,
            new_score      : arg4,
            score_increase : arg4 - v2.offchain_score,
            by             : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<UpdateUserOffchainScoreByUpdater>(v3);
        v2.offchain_score = v2.offchain_score + arg4;
    }

    // decompiled from Move bytecode v6
}

