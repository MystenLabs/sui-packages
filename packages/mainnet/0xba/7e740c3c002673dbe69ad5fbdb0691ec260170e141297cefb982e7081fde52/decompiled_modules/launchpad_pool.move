module 0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::launchpad_pool {
    struct LaunchpadPools has store, key {
        id: 0x2::object::UID,
        pools: 0x2::table::Table<address, Pool>,
    }

    struct MediaInfo has drop, store {
        name: 0x1::string::String,
        link: 0x1::string::String,
    }

    struct Pool has drop, store {
        pool_address: address,
        is_closed: bool,
        show_settle: bool,
        coin_symbol: 0x1::string::String,
        coin_name: 0x1::string::String,
        coin_icon: 0x1::string::String,
        banners: vector<0x1::string::String>,
        introduction: 0x1::string::String,
        website: 0x1::string::String,
        tokenomics: 0x1::string::String,
        social_media: 0x2::vec_map::VecMap<0x1::string::String, MediaInfo>,
        terms: 0x1::string::String,
        white_list_terms: 0x1::string::String,
        regulation: 0x1::string::String,
        project_details: 0x1::string::String,
        extension_fields: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct InitLaunchpadPoolsEvent has copy, drop, store {
        launchpad_pools_id: 0x2::object::ID,
    }

    struct AddPoolEvent has copy, drop, store {
        pool_address: address,
    }

    struct UpdatePoolEvent has copy, drop, store {
        pool_address: address,
    }

    struct RemovePoolEvent has copy, drop, store {
        pool_address: address,
    }

    struct AddMediaToPoolEvent has copy, drop, store {
        pool_address: address,
        name: 0x1::string::String,
        link: 0x1::string::String,
    }

    struct RemoveMediaFromPoolEvent has copy, drop, store {
        pool_address: address,
        name: 0x1::string::String,
    }

    struct ClosePoolEvent has copy, drop, store {
        pool_address: address,
    }

    struct OpenPoolEvent has copy, drop, store {
        pool_address: address,
    }

    struct OpenSettleEvent has copy, drop, store {
        pool_address: address,
    }

    struct CloseSettleEvent has copy, drop, store {
        pool_address: address,
    }

    struct AddExtensionToPoolEvent has copy, drop, store {
        pool_address: address,
        key: 0x1::string::String,
        value: 0x1::string::String,
    }

    struct UpdateExtensionFromPoolEvent has copy, drop, store {
        pool_address: address,
        key: 0x1::string::String,
        old_value: 0x1::string::String,
        new_value: 0x1::string::String,
    }

    struct RemoveExtensionFromPoolEvent has copy, drop, store {
        pool_address: address,
        key: 0x1::string::String,
    }

    public entry fun add_extension_to_pool(arg0: &0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::GlobalConfig, arg1: &mut LaunchpadPools, arg2: address, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::tx_context::TxContext) {
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_package_version(arg0);
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_has_add_role(arg0, 0x2::tx_context::sender(arg5));
        assert!(0x2::table::contains<address, Pool>(&arg1.pools, arg2), 1);
        let v0 = 0x2::table::borrow_mut<address, Pool>(&mut arg1.pools, arg2);
        assert!(!0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&v0.extension_fields, &arg3), 3);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0.extension_fields, arg3, arg4);
        let v1 = AddExtensionToPoolEvent{
            pool_address : arg2,
            key          : arg3,
            value        : arg4,
        };
        0x2::event::emit<AddExtensionToPoolEvent>(v1);
    }

    public entry fun add_launchpad_pool(arg0: &0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::GlobalConfig, arg1: &mut LaunchpadPools, arg2: address, arg3: bool, arg4: bool, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: vector<0x1::string::String>, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: 0x1::string::String, arg15: 0x1::string::String, arg16: &0x2::tx_context::TxContext) {
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_package_version(arg0);
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_has_add_role(arg0, 0x2::tx_context::sender(arg16));
        assert!(!0x2::table::contains<address, Pool>(&arg1.pools, arg2), 0);
        let v0 = Pool{
            pool_address     : arg2,
            is_closed        : arg3,
            show_settle      : arg4,
            coin_symbol      : arg5,
            coin_name        : arg6,
            coin_icon        : arg7,
            banners          : arg8,
            introduction     : arg9,
            website          : arg10,
            tokenomics       : arg11,
            social_media     : 0x2::vec_map::empty<0x1::string::String, MediaInfo>(),
            terms            : arg12,
            white_list_terms : arg13,
            regulation       : arg14,
            project_details  : arg15,
            extension_fields : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
        };
        0x2::table::add<address, Pool>(&mut arg1.pools, arg2, v0);
        let v1 = AddPoolEvent{pool_address: arg2};
        0x2::event::emit<AddPoolEvent>(v1);
    }

    public fun add_media_to_pool(arg0: &0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::GlobalConfig, arg1: &mut LaunchpadPools, arg2: address, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::tx_context::TxContext) {
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_package_version(arg0);
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_has_add_role(arg0, 0x2::tx_context::sender(arg5));
        assert!(0x2::table::contains<address, Pool>(&arg1.pools, arg2), 1);
        let v0 = 0x2::table::borrow_mut<address, Pool>(&mut arg1.pools, arg2);
        assert!(!0x2::vec_map::contains<0x1::string::String, MediaInfo>(&v0.social_media, &arg3), 3);
        let v1 = MediaInfo{
            name : arg3,
            link : arg4,
        };
        0x2::vec_map::insert<0x1::string::String, MediaInfo>(&mut v0.social_media, arg3, v1);
        let v2 = AddMediaToPoolEvent{
            pool_address : arg2,
            name         : arg3,
            link         : arg4,
        };
        0x2::event::emit<AddMediaToPoolEvent>(v2);
    }

    public fun close_launchpad_pool(arg0: &0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::GlobalConfig, arg1: &mut LaunchpadPools, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_package_version(arg0);
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_has_update_role(arg0, 0x2::tx_context::sender(arg3));
        assert!(0x2::table::contains<address, Pool>(&arg1.pools, arg2), 1);
        0x2::table::borrow_mut<address, Pool>(&mut arg1.pools, arg2).is_closed = true;
        let v0 = ClosePoolEvent{pool_address: arg2};
        0x2::event::emit<ClosePoolEvent>(v0);
    }

    public fun close_settle(arg0: &0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::GlobalConfig, arg1: &mut LaunchpadPools, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_package_version(arg0);
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_has_update_role(arg0, 0x2::tx_context::sender(arg3));
        assert!(0x2::table::contains<address, Pool>(&arg1.pools, arg2), 1);
        0x2::table::borrow_mut<address, Pool>(&mut arg1.pools, arg2).show_settle = false;
        let v0 = CloseSettleEvent{pool_address: arg2};
        0x2::event::emit<CloseSettleEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LaunchpadPools{
            id    : 0x2::object::new(arg0),
            pools : 0x2::table::new<address, Pool>(arg0),
        };
        0x2::transfer::share_object<LaunchpadPools>(v0);
        let v1 = InitLaunchpadPoolsEvent{launchpad_pools_id: 0x2::object::id<LaunchpadPools>(&v0)};
        0x2::event::emit<InitLaunchpadPoolsEvent>(v1);
    }

    public fun open_launchpad_pool(arg0: &0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::GlobalConfig, arg1: &mut LaunchpadPools, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_package_version(arg0);
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_has_update_role(arg0, 0x2::tx_context::sender(arg3));
        assert!(0x2::table::contains<address, Pool>(&arg1.pools, arg2), 1);
        0x2::table::borrow_mut<address, Pool>(&mut arg1.pools, arg2).is_closed = false;
        let v0 = OpenPoolEvent{pool_address: arg2};
        0x2::event::emit<OpenPoolEvent>(v0);
    }

    public fun open_settle(arg0: &0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::GlobalConfig, arg1: &mut LaunchpadPools, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_package_version(arg0);
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_has_update_role(arg0, 0x2::tx_context::sender(arg3));
        assert!(0x2::table::contains<address, Pool>(&arg1.pools, arg2), 1);
        0x2::table::borrow_mut<address, Pool>(&mut arg1.pools, arg2).show_settle = true;
        let v0 = OpenSettleEvent{pool_address: arg2};
        0x2::event::emit<OpenSettleEvent>(v0);
    }

    public entry fun remove_extension_from_pool(arg0: &0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::GlobalConfig, arg1: &mut LaunchpadPools, arg2: address, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_package_version(arg0);
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_has_delete_role(arg0, 0x2::tx_context::sender(arg4));
        assert!(0x2::table::contains<address, Pool>(&arg1.pools, arg2), 1);
        let v0 = 0x2::table::borrow_mut<address, Pool>(&mut arg1.pools, arg2);
        assert!(0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&v0.extension_fields, &arg3), 2);
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut v0.extension_fields, &arg3);
        let v3 = RemoveExtensionFromPoolEvent{
            pool_address : arg2,
            key          : arg3,
        };
        0x2::event::emit<RemoveExtensionFromPoolEvent>(v3);
    }

    public fun remove_launchpad_pool(arg0: &0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::GlobalConfig, arg1: &mut LaunchpadPools, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_package_version(arg0);
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_has_delete_role(arg0, 0x2::tx_context::sender(arg3));
        assert!(0x2::table::contains<address, Pool>(&arg1.pools, arg2), 1);
        0x2::table::remove<address, Pool>(&mut arg1.pools, arg2);
        let v0 = RemovePoolEvent{pool_address: arg2};
        0x2::event::emit<RemovePoolEvent>(v0);
    }

    public fun remove_media_from_pool(arg0: &0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::GlobalConfig, arg1: &mut LaunchpadPools, arg2: address, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_package_version(arg0);
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_has_delete_role(arg0, 0x2::tx_context::sender(arg4));
        assert!(0x2::table::contains<address, Pool>(&arg1.pools, arg2), 1);
        let v0 = 0x2::table::borrow_mut<address, Pool>(&mut arg1.pools, arg2);
        assert!(0x2::vec_map::contains<0x1::string::String, MediaInfo>(&v0.social_media, &arg3), 2);
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, MediaInfo>(&mut v0.social_media, &arg3);
        let v3 = RemoveMediaFromPoolEvent{
            pool_address : arg2,
            name         : arg3,
        };
        0x2::event::emit<RemoveMediaFromPoolEvent>(v3);
    }

    public entry fun update_extension_from_pool(arg0: &0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::GlobalConfig, arg1: &mut LaunchpadPools, arg2: address, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::tx_context::TxContext) {
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_package_version(arg0);
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_has_update_role(arg0, 0x2::tx_context::sender(arg5));
        assert!(0x2::table::contains<address, Pool>(&arg1.pools, arg2), 1);
        let v0 = 0x2::table::borrow_mut<address, Pool>(&mut arg1.pools, arg2);
        assert!(0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&v0.extension_fields, &arg3), 2);
        let v1 = 0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut v0.extension_fields, &arg3);
        *v1 = arg4;
        let v2 = UpdateExtensionFromPoolEvent{
            pool_address : arg2,
            key          : arg3,
            old_value    : *v1,
            new_value    : arg4,
        };
        0x2::event::emit<UpdateExtensionFromPoolEvent>(v2);
    }

    public fun update_launchpad_pool(arg0: &0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::GlobalConfig, arg1: &mut LaunchpadPools, arg2: address, arg3: bool, arg4: bool, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: vector<0x1::string::String>, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: 0x1::string::String, arg15: 0x1::string::String, arg16: &0x2::tx_context::TxContext) {
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_package_version(arg0);
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_has_update_role(arg0, 0x2::tx_context::sender(arg16));
        assert!(0x2::table::contains<address, Pool>(&arg1.pools, arg2), 1);
        let v0 = 0x2::table::borrow_mut<address, Pool>(&mut arg1.pools, arg2);
        v0.pool_address = arg2;
        v0.is_closed = arg3;
        v0.show_settle = arg4;
        v0.coin_symbol = arg5;
        v0.coin_name = arg6;
        v0.coin_icon = arg7;
        v0.banners = arg8;
        v0.introduction = arg9;
        v0.website = arg10;
        v0.tokenomics = arg11;
        v0.terms = arg12;
        v0.white_list_terms = arg13;
        v0.regulation = arg14;
        v0.project_details = arg15;
        let v1 = UpdatePoolEvent{pool_address: arg2};
        0x2::event::emit<UpdatePoolEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

