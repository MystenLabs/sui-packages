module 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile {
    struct Profile has store, key {
        id: 0x2::object::UID,
        owner: address,
        display_name: 0x1::string::String,
        display_image_url: 0x1::option::Option<0x1::string::String>,
        background_image_url: 0x1::option::Option<0x1::string::String>,
        url: 0x1::option::Option<0x1::string::String>,
        bio: 0x1::option::Option<0x1::string::String>,
        social_accounts: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        wallet_addresses: 0x2::vec_map::VecMap<0x1::string::String, vector<0x1::string::String>>,
        following: 0x2::table::Table<address, bool>,
        block_list: 0x2::table::Table<address, bool>,
        is_archived: bool,
        created_at: u64,
        updated_at: u64,
        last_display_name_change_at: u64,
    }

    struct PROFILE has drop {
        dummy_field: bool,
    }

    struct DeleteProfileEvent has copy, drop {
        owner: address,
        display_name: 0x1::string::String,
        timestamp: u64,
    }

    struct UnarchiveProfileEvent has copy, drop {
        profile_id: 0x2::object::ID,
        owner: address,
        display_name: 0x1::string::String,
        timestamp: u64,
    }

    struct ArchiveProfileEvent has copy, drop {
        profile_id: 0x2::object::ID,
        owner: address,
        display_name: 0x1::string::String,
        timestamp: u64,
    }

    struct CreateProfileEvent has copy, drop {
        profile_id: 0x2::object::ID,
        owner: address,
        display_name: 0x1::string::String,
        timestamp: u64,
        display_image_url: 0x1::option::Option<0x1::string::String>,
        background_image_url: 0x1::option::Option<0x1::string::String>,
        wallet_addresses: 0x2::vec_map::VecMap<0x1::string::String, vector<0x1::string::String>>,
        social_accounts: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        url: 0x1::option::Option<0x1::string::String>,
        bio: 0x1::option::Option<0x1::string::String>,
    }

    struct UpdateProfileEvent has copy, drop {
        profile_id: 0x2::object::ID,
        owner: address,
        display_name: 0x1::string::String,
        timestamp: u64,
        display_image_url: 0x1::option::Option<0x1::string::String>,
        background_image_url: 0x1::option::Option<0x1::string::String>,
        wallet_addresses: 0x2::vec_map::VecMap<0x1::string::String, vector<0x1::string::String>>,
        social_accounts: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        url: 0x1::option::Option<0x1::string::String>,
        bio: 0x1::option::Option<0x1::string::String>,
    }

    struct AddDfToProfileEvent<T0: copy + drop + store, T1: copy + drop> has copy, drop {
        profile_id: 0x2::object::ID,
        owner: address,
        df_key: T0,
        df_value: T1,
        timestamp: u64,
    }

    struct RemoveDfFromProfileEvent<T0: copy + drop + store, T1: store> has copy, drop {
        profile_id: 0x2::object::ID,
        owner: address,
        df_key: T0,
        df_value: T1,
        timestamp: u64,
    }

    struct FollowUserEvent has copy, drop {
        owner: address,
        followed_address: address,
        timestamp: u64,
    }

    struct UnfollowUserEvent has copy, drop {
        owner: address,
        unfollowed_address: address,
        timestamp: u64,
    }

    struct BlockUserEvent has copy, drop {
        timestamp: u64,
        owner: address,
        blocked_address: address,
    }

    struct UnblockUserEvent has copy, drop {
        owner: address,
        unblocked_address: address,
        timestamp: u64,
    }

    public(friend) fun add_df_to_profile<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut Profile, arg1: T0, arg2: T1, arg3: &0x2::clock::Clock) {
        0x2::dynamic_field::add<T0, T1>(&mut arg0.id, arg1, arg2);
        arg0.updated_at = 0x2::clock::timestamp_ms(arg3);
        emit_add_df_to_profile_event<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public(friend) fun add_df_to_profile_no_event<T0: copy + drop + store, T1: drop + store>(arg0: &mut Profile, arg1: T0, arg2: T1, arg3: &0x2::clock::Clock) {
        0x2::dynamic_field::add<T0, T1>(&mut arg0.id, arg1, arg2);
        arg0.updated_at = 0x2::clock::timestamp_ms(arg3);
    }

    public(friend) fun add_wallet_address(arg0: &mut Profile, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::Config, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::assert_interacting_with_most_up_to_date_package(arg3);
        assert!(0x2::tx_context::sender(arg5) == arg0.owner, 1);
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::assert_wallet_key_is_allowed(arg3, &arg1);
        if (0x2::vec_map::contains<0x1::string::String, vector<0x1::string::String>>(&arg0.wallet_addresses, &arg1)) {
            let v0 = 0x2::vec_map::get_mut<0x1::string::String, vector<0x1::string::String>>(&mut arg0.wallet_addresses, &arg1);
            if (!0x1::vector::contains<0x1::string::String>(v0, &arg2)) {
                0x1::vector::push_back<0x1::string::String>(v0, arg2);
            };
        } else {
            let v1 = 0x1::vector::empty<0x1::string::String>();
            0x1::vector::push_back<0x1::string::String>(&mut v1, arg2);
            0x2::vec_map::insert<0x1::string::String, vector<0x1::string::String>>(&mut arg0.wallet_addresses, arg1, v1);
        };
        arg0.updated_at = 0x2::clock::timestamp_ms(arg4);
        emit_update_profile_event(arg0, arg4);
    }

    public(friend) fun archive_profile(arg0: &mut Profile, arg1: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::assert_interacting_with_most_up_to_date_package(arg1);
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        arg0.is_archived = true;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
        let v0 = ArchiveProfileEvent{
            profile_id   : 0x2::object::id<Profile>(arg0),
            owner        : arg0.owner,
            display_name : arg0.display_name,
            timestamp    : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ArchiveProfileEvent>(v0);
    }

    fun assert_display_name_matches_with_suins(arg0: 0x1::string::String, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration) {
        let v0 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain(arg1);
        assert!(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::label(&v0, 1) == &arg0, 3);
    }

    fun assert_display_name_not_taken(arg0: 0x1::string::String, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS) {
        0x1::string::append(&mut arg0, 0x1::string::utf8(b".sui"));
        assert!(!0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::has_record(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::registry<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::Registry>(arg1), 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::new(arg0)), 4);
    }

    public fun background_image_url(arg0: &Profile) : 0x1::option::Option<0x1::string::String> {
        assert!(!arg0.is_archived, 13906834878718017537);
        arg0.background_image_url
    }

    public fun bio(arg0: &Profile) : 0x1::option::Option<0x1::string::String> {
        assert!(!arg0.is_archived, 13906834835768344577);
        arg0.bio
    }

    public(friend) fun block_user(arg0: &mut Profile, arg1: address, arg2: &0x2::clock::Clock) {
        assert!(!arg0.is_archived, 13906837382683951105);
        assert!(arg1 != arg0.owner, 1);
        if (!0x2::table::contains<address, bool>(&arg0.block_list, arg1)) {
            0x2::table::add<address, bool>(&mut arg0.block_list, arg1, true);
            arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
            let v0 = BlockUserEvent{
                timestamp       : 0x2::clock::timestamp_ms(arg2),
                owner           : arg0.owner,
                blocked_address : arg1,
            };
            0x2::event::emit<BlockUserEvent>(v0);
        };
    }

    public(friend) fun create_profile(arg0: 0x1::string::String, arg1: 0x1::option::Option<0x1::string::String>, arg2: 0x1::option::Option<0x1::string::String>, arg3: 0x1::option::Option<0x1::string::String>, arg4: 0x1::option::Option<0x1::string::String>, arg5: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::Config, arg6: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg7: &mut 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_registry::Registry, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : Profile {
        assert_display_name_not_taken(arg0, arg6);
        create_profile_helper(arg0, arg1, arg2, arg3, arg4, arg5, arg7, arg8, arg9)
    }

    public(friend) fun create_profile_helper(arg0: 0x1::string::String, arg1: 0x1::option::Option<0x1::string::String>, arg2: 0x1::option::Option<0x1::string::String>, arg3: 0x1::option::Option<0x1::string::String>, arg4: 0x1::option::Option<0x1::string::String>, arg5: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::Config, arg6: &mut 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_registry::Registry, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : Profile {
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::assert_interacting_with_most_up_to_date_package(arg5);
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::assert_display_name_is_valid(arg5, &arg0);
        if (0x1::option::is_some<0x1::string::String>(&arg2)) {
            0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::assert_bio_length_is_valid(arg5, 0x1::option::borrow<0x1::string::String>(&arg2));
        };
        assert!(!0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_registry::get_entry_display_name_registry(arg6, arg0), 5);
        assert!(!0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_registry::get_entry_address_registry(arg6, 0x2::tx_context::sender(arg8)), 2);
        let v0 = 0x2::clock::timestamp_ms(arg7);
        let v1 = Profile{
            id                          : 0x2::object::new(arg8),
            owner                       : 0x2::tx_context::sender(arg8),
            display_name                : arg0,
            display_image_url           : arg3,
            background_image_url        : arg4,
            url                         : arg1,
            bio                         : arg2,
            social_accounts             : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
            wallet_addresses            : 0x2::vec_map::empty<0x1::string::String, vector<0x1::string::String>>(),
            following                   : 0x2::table::new<address, bool>(arg8),
            block_list                  : 0x2::table::new<address, bool>(arg8),
            is_archived                 : false,
            created_at                  : v0,
            updated_at                  : v0,
            last_display_name_change_at : v0,
        };
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_registry::add_entries(arg6, arg0, v1.owner);
        let v2 = CreateProfileEvent{
            profile_id           : 0x2::object::id<Profile>(&v1),
            owner                : 0x2::tx_context::sender(arg8),
            display_name         : v1.display_name,
            timestamp            : 0x2::clock::timestamp_ms(arg7),
            display_image_url    : arg3,
            background_image_url : arg4,
            wallet_addresses     : 0x2::vec_map::empty<0x1::string::String, vector<0x1::string::String>>(),
            social_accounts      : v1.social_accounts,
            url                  : arg1,
            bio                  : arg2,
        };
        0x2::event::emit<CreateProfileEvent>(v2);
        v1
    }

    public(friend) fun create_profile_with_suins(arg0: 0x1::string::String, arg1: 0x1::option::Option<0x1::string::String>, arg2: 0x1::option::Option<0x1::string::String>, arg3: 0x1::option::Option<0x1::string::String>, arg4: 0x1::option::Option<0x1::string::String>, arg5: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg6: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::Config, arg7: &mut 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_registry::Registry, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : Profile {
        assert_display_name_matches_with_suins(arg0, arg5);
        create_profile_helper(arg0, arg1, arg2, arg3, arg4, arg6, arg7, arg8, arg9)
    }

    public fun created_at(arg0: &Profile) : u64 {
        assert!(!arg0.is_archived, 13906835016156971009);
        arg0.created_at
    }

    public(friend) fun delete_profile(arg0: Profile, arg1: &mut 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_registry::Registry, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_registry::remove_entries(arg1, arg0.display_name, arg0.owner);
        let Profile {
            id                          : v0,
            owner                       : v1,
            display_name                : v2,
            display_image_url           : _,
            background_image_url        : _,
            url                         : _,
            bio                         : _,
            social_accounts             : _,
            wallet_addresses            : _,
            following                   : v9,
            block_list                  : v10,
            is_archived                 : _,
            created_at                  : _,
            updated_at                  : _,
            last_display_name_change_at : _,
        } = arg0;
        0x2::table::drop<address, bool>(v9);
        0x2::table::drop<address, bool>(v10);
        let v15 = DeleteProfileEvent{
            owner        : v1,
            display_name : v2,
            timestamp    : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<DeleteProfileEvent>(v15);
        0x2::object::delete(v0);
    }

    public fun display_image_url(arg0: &Profile) : 0x1::option::Option<0x1::string::String> {
        assert!(!arg0.is_archived, 13906834857243181057);
        arg0.display_image_url
    }

    public fun display_name(arg0: &Profile) : 0x1::string::String {
        assert!(!arg0.is_archived, 13906834792818671617);
        arg0.display_name
    }

    fun emit_add_df_to_profile_event<T0: copy + drop + store, T1: copy + drop + store>(arg0: &Profile, arg1: T0, arg2: T1, arg3: &0x2::clock::Clock) : T1 {
        let v0 = AddDfToProfileEvent<T0, T1>{
            profile_id : 0x2::object::id<Profile>(arg0),
            owner      : arg0.owner,
            df_key     : arg1,
            df_value   : arg2,
            timestamp  : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<AddDfToProfileEvent<T0, T1>>(v0);
        arg2
    }

    fun emit_remove_df_from_profile_event<T0: copy + drop + store, T1: copy + drop + store>(arg0: &Profile, arg1: T0, arg2: T1, arg3: &0x2::clock::Clock) {
        let v0 = RemoveDfFromProfileEvent<T0, T1>{
            profile_id : 0x2::object::id<Profile>(arg0),
            owner      : arg0.owner,
            df_key     : arg1,
            df_value   : arg2,
            timestamp  : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RemoveDfFromProfileEvent<T0, T1>>(v0);
    }

    fun emit_update_profile_event(arg0: &Profile, arg1: &0x2::clock::Clock) {
        let v0 = UpdateProfileEvent{
            profile_id           : 0x2::object::id<Profile>(arg0),
            owner                : arg0.owner,
            display_name         : arg0.display_name,
            timestamp            : 0x2::clock::timestamp_ms(arg1),
            display_image_url    : arg0.display_image_url,
            background_image_url : arg0.background_image_url,
            wallet_addresses     : arg0.wallet_addresses,
            social_accounts      : arg0.social_accounts,
            url                  : arg0.url,
            bio                  : arg0.bio,
        };
        0x2::event::emit<UpdateProfileEvent>(v0);
    }

    public(friend) fun follow_user(arg0: &mut Profile, arg1: address, arg2: &0x2::clock::Clock) {
        assert!(!arg0.is_archived, 13906837249539964929);
        assert!(arg1 != arg0.owner, 1);
        if (!0x2::table::contains<address, bool>(&arg0.following, arg1)) {
            0x2::table::add<address, bool>(&mut arg0.following, arg1, true);
            arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
            let v0 = FollowUserEvent{
                owner            : arg0.owner,
                followed_address : arg1,
                timestamp        : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::event::emit<FollowUserEvent>(v0);
        };
    }

    public fun get_df<T0: copy + drop + store, T1: copy + drop + store>(arg0: &Profile, arg1: T0) : &T1 {
        0x2::dynamic_field::borrow<T0, T1>(&arg0.id, arg1)
    }

    public(friend) fun get_social_account_username(arg0: &Profile, arg1: &0x1::string::String) : 0x1::option::Option<0x1::string::String> {
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.social_accounts, arg1)) {
            0x1::option::some<0x1::string::String>(*0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&arg0.social_accounts, arg1))
        } else {
            0x1::option::none<0x1::string::String>()
        }
    }

    fun init(arg0: PROFILE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<PROFILE>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun is_archived(arg0: &Profile) : bool {
        arg0.is_archived
    }

    public fun is_blocked(arg0: &Profile, arg1: address) : bool {
        assert!(!arg0.is_archived, 13906837537302773761);
        0x2::table::contains<address, bool>(&arg0.block_list, arg1)
    }

    public fun is_following(arg0: &Profile, arg1: address) : bool {
        assert!(!arg0.is_archived, 13906837515827937281);
        0x2::table::contains<address, bool>(&arg0.following, arg1)
    }

    public(friend) fun link_social_account(arg0: &mut Profile, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::Config, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::assert_interacting_with_most_up_to_date_package(arg3);
        assert!(0x2::tx_context::sender(arg5) == arg0.owner, 1);
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::assert_social_platform_is_allowed(arg3, &arg1);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.social_accounts, arg1, arg2);
        arg0.updated_at = 0x2::clock::timestamp_ms(arg4);
        emit_update_profile_event(arg0, arg4);
    }

    public fun owner(arg0: &Profile) : address {
        assert!(!arg0.is_archived, 13906834977502265345);
        arg0.owner
    }

    public(friend) fun remove_background_image_url(arg0: &mut Profile, arg1: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::Config, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::assert_interacting_with_most_up_to_date_package(arg1);
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        arg0.background_image_url = 0x1::option::none<0x1::string::String>();
        arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
        emit_update_profile_event(arg0, arg2);
    }

    public(friend) fun remove_bio(arg0: &mut Profile, arg1: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::Config, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::assert_interacting_with_most_up_to_date_package(arg1);
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        arg0.bio = 0x1::option::none<0x1::string::String>();
        arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
        emit_update_profile_event(arg0, arg2);
    }

    public(friend) fun remove_df_from_profile<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut Profile, arg1: T0, arg2: &0x2::clock::Clock) {
        arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
        emit_remove_df_from_profile_event<T0, T1>(arg0, arg1, 0x2::dynamic_field::remove<T0, T1>(&mut arg0.id, arg1), arg2);
    }

    public(friend) fun remove_df_from_profile_no_event<T0: copy + drop + store, T1: drop + store>(arg0: &mut Profile, arg1: T0, arg2: &0x2::clock::Clock) : T1 {
        arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
        0x2::dynamic_field::remove<T0, T1>(&mut arg0.id, arg1)
    }

    public(friend) fun remove_display_image_url(arg0: &mut Profile, arg1: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::Config, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::assert_interacting_with_most_up_to_date_package(arg1);
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        arg0.display_image_url = 0x1::option::none<0x1::string::String>();
        arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
        emit_update_profile_event(arg0, arg2);
    }

    public(friend) fun remove_url(arg0: &mut Profile, arg1: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::Config, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::assert_interacting_with_most_up_to_date_package(arg1);
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        arg0.url = 0x1::option::none<0x1::string::String>();
        arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
        emit_update_profile_event(arg0, arg2);
    }

    public(friend) fun remove_wallet_address(arg0: &mut Profile, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::Config, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::assert_interacting_with_most_up_to_date_package(arg3);
        assert!(0x2::tx_context::sender(arg5) == arg0.owner, 1);
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::assert_wallet_key_is_allowed(arg3, &arg1);
        assert!(0x2::vec_map::contains<0x1::string::String, vector<0x1::string::String>>(&arg0.wallet_addresses, &arg1), 7);
        let v0 = 0x2::vec_map::get_mut<0x1::string::String, vector<0x1::string::String>>(&mut arg0.wallet_addresses, &arg1);
        let (v1, v2) = 0x1::vector::index_of<0x1::string::String>(v0, &arg2);
        assert!(v1, 7);
        0x1::vector::remove<0x1::string::String>(v0, v2);
        if (0x1::vector::is_empty<0x1::string::String>(v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, vector<0x1::string::String>>(&mut arg0.wallet_addresses, &arg1);
        };
        arg0.updated_at = 0x2::clock::timestamp_ms(arg4);
        emit_update_profile_event(arg0, arg4);
    }

    public(friend) fun set_background_image_url(arg0: &mut Profile, arg1: 0x1::string::String, arg2: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::Config, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::assert_interacting_with_most_up_to_date_package(arg2);
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 1);
        arg0.background_image_url = 0x1::option::some<0x1::string::String>(arg1);
        arg0.updated_at = 0x2::clock::timestamp_ms(arg3);
        emit_update_profile_event(arg0, arg3);
    }

    public(friend) fun set_bio(arg0: &mut Profile, arg1: 0x1::string::String, arg2: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::Config, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::assert_interacting_with_most_up_to_date_package(arg2);
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 1);
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::assert_bio_length_is_valid(arg2, &arg1);
        arg0.bio = 0x1::option::some<0x1::string::String>(arg1);
        arg0.updated_at = 0x2::clock::timestamp_ms(arg3);
        emit_update_profile_event(arg0, arg3);
    }

    public(friend) fun set_display_image_url(arg0: &mut Profile, arg1: 0x1::string::String, arg2: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::Config, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::assert_interacting_with_most_up_to_date_package(arg2);
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 1);
        arg0.display_image_url = 0x1::option::some<0x1::string::String>(arg1);
        arg0.updated_at = 0x2::clock::timestamp_ms(arg3);
        emit_update_profile_event(arg0, arg3);
    }

    public(friend) fun set_display_name(arg0: &mut Profile, arg1: 0x1::string::String, arg2: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg3: &mut 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_registry::Registry, arg4: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::Config, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_display_name_not_taken(arg1, arg2);
        set_display_name_helper(arg0, arg1, arg3, arg4, arg5, arg6);
    }

    public(friend) fun set_display_name_helper(arg0: &mut Profile, arg1: 0x1::string::String, arg2: &mut 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_registry::Registry, arg3: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::Config, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::assert_interacting_with_most_up_to_date_package(arg3);
        assert!(0x2::tx_context::sender(arg5) == arg0.owner, 1);
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::assert_display_name_is_valid(arg3, &arg1);
        assert!(!0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_registry::get_entry_display_name_registry(arg2, arg1), 5);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 - arg0.last_display_name_change_at >= 600000, 8);
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_registry::remove_entry_display_name_registry(arg2, arg0.display_name);
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_registry::add_entry_display_name_registry(arg2, arg1);
        arg0.display_name = arg1;
        arg0.updated_at = v0;
        arg0.last_display_name_change_at = v0;
        emit_update_profile_event(arg0, arg4);
    }

    public(friend) fun set_display_name_with_suins(arg0: &mut Profile, arg1: 0x1::string::String, arg2: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg3: &mut 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_registry::Registry, arg4: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::Config, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_display_name_matches_with_suins(arg1, arg2);
        set_display_name_helper(arg0, arg1, arg3, arg4, arg5, arg6);
    }

    public(friend) fun set_url(arg0: &mut Profile, arg1: 0x1::string::String, arg2: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::Config, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::assert_interacting_with_most_up_to_date_package(arg2);
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 1);
        arg0.url = 0x1::option::some<0x1::string::String>(arg1);
        arg0.updated_at = 0x2::clock::timestamp_ms(arg3);
        emit_update_profile_event(arg0, arg3);
    }

    public fun social_accounts(arg0: &Profile) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        assert!(!arg0.is_archived, 13906834921667690497);
        arg0.social_accounts
    }

    public fun uid(arg0: &Profile) : &0x2::object::UID {
        &arg0.id
    }

    public fun uid_mut(arg0: &mut Profile) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun unarchive_profile(arg0: &mut Profile, arg1: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::Config, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::assert_interacting_with_most_up_to_date_package(arg1);
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        arg0.is_archived = false;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
        let v0 = UnarchiveProfileEvent{
            profile_id   : 0x2::object::id<Profile>(arg0),
            owner        : arg0.owner,
            display_name : arg0.display_name,
            timestamp    : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<UnarchiveProfileEvent>(v0);
    }

    public(friend) fun unblock_user(arg0: &mut Profile, arg1: address, arg2: &0x2::clock::Clock) {
        assert!(!arg0.is_archived, 13906837451403427841);
        if (0x2::table::contains<address, bool>(&arg0.block_list, arg1)) {
            0x2::table::remove<address, bool>(&mut arg0.block_list, arg1);
            arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
            let v0 = UnblockUserEvent{
                owner             : arg0.owner,
                unblocked_address : arg1,
                timestamp         : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::event::emit<UnblockUserEvent>(v0);
        };
    }

    public(friend) fun unfollow_user(arg0: &mut Profile, arg1: address, arg2: &0x2::clock::Clock) {
        assert!(!arg0.is_archived, 13906837318259441665);
        if (0x2::table::contains<address, bool>(&arg0.following, arg1)) {
            0x2::table::remove<address, bool>(&mut arg0.following, arg1);
            arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
            let v0 = UnfollowUserEvent{
                owner              : arg0.owner,
                unfollowed_address : arg1,
                timestamp          : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::event::emit<UnfollowUserEvent>(v0);
        };
    }

    public(friend) fun unlink_social_account(arg0: &mut Profile, arg1: &0x1::string::String, arg2: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::Config, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::assert_interacting_with_most_up_to_date_package(arg2);
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 1);
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::assert_social_platform_is_allowed(arg2, arg1);
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.social_accounts, arg1)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg0.social_accounts, arg1);
            arg0.updated_at = 0x2::clock::timestamp_ms(arg3);
            emit_update_profile_event(arg0, arg3);
        };
    }

    public fun updated_at(arg0: &Profile) : u64 {
        assert!(!arg0.is_archived, 13906835037631807489);
        arg0.updated_at
    }

    public fun url(arg0: &Profile) : 0x1::option::Option<0x1::string::String> {
        assert!(!arg0.is_archived, 13906834814293508097);
        arg0.url
    }

    public fun wallet_addresses(arg0: &Profile) : 0x2::vec_map::VecMap<0x1::string::String, vector<0x1::string::String>> {
        assert!(!arg0.is_archived, 13906834900192854017);
        arg0.wallet_addresses
    }

    // decompiled from Move bytecode v6
}

