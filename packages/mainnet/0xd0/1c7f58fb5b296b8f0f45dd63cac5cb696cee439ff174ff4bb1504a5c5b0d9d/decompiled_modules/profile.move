module 0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::profile {
    struct Profile has store, key {
        id: 0x2::object::UID,
        owner: address,
        display_name: 0x1::string::String,
        user_name: 0x1::string::String,
        display_image_blob_id: 0x1::option::Option<0x1::string::String>,
        background_image_blob_id: 0x1::option::Option<0x1::string::String>,
        walrus_site_id: 0x1::option::Option<0x1::string::String>,
        url: 0x1::option::Option<0x1::string::String>,
        bio: 0x1::option::Option<0x1::string::String>,
        is_archived: bool,
        created_at: u64,
        updated_at: u64,
    }

    struct DeleteProfileEvent has copy, drop {
        user_name: 0x1::string::String,
        owner: address,
        display_name: 0x1::string::String,
        timestamp: u64,
    }

    struct UnarchiveProfileEvent has copy, drop {
        profile_id: 0x2::object::ID,
        user_name: 0x1::string::String,
        owner: address,
        display_name: 0x1::string::String,
        timestamp: u64,
    }

    struct ArchiveProfileEvent has copy, drop {
        profile_id: 0x2::object::ID,
        user_name: 0x1::string::String,
        owner: address,
        display_name: 0x1::string::String,
        timestamp: u64,
    }

    struct CreateProfileEvent has copy, drop {
        profile_id: 0x2::object::ID,
        user_name: 0x1::string::String,
        owner: address,
        display_name: 0x1::string::String,
        timestamp: u64,
        display_image_blob_id: 0x1::option::Option<0x1::string::String>,
        background_image_blob_id: 0x1::option::Option<0x1::string::String>,
        walrus_site_id: 0x1::option::Option<0x1::string::String>,
        url: 0x1::option::Option<0x1::string::String>,
        bio: 0x1::option::Option<0x1::string::String>,
    }

    struct UpdateProfileEvent has copy, drop {
        profile_id: 0x2::object::ID,
        user_name: 0x1::string::String,
        owner: address,
        display_name: 0x1::string::String,
        timestamp: u64,
        display_image_blob_id: 0x1::option::Option<0x1::string::String>,
        background_image_blob_id: 0x1::option::Option<0x1::string::String>,
        walrus_site_id: 0x1::option::Option<0x1::string::String>,
        url: 0x1::option::Option<0x1::string::String>,
        bio: 0x1::option::Option<0x1::string::String>,
    }

    struct AddDFToProfileEvent<T0: copy + drop + store, T1: copy + drop> has copy, drop {
        profile_id: 0x2::object::ID,
        user_name: 0x1::string::String,
        owner: address,
        df_key: T0,
        df_value: T1,
        timestamp: u64,
    }

    struct RemoveDFFromProfileEvent<T0: copy + drop + store, T1: store> has copy, drop {
        profile_id: 0x2::object::ID,
        user_name: 0x1::string::String,
        owner: address,
        df_key: T0,
        df_value: T1,
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

    public(friend) fun archive_profile(arg0: &mut Profile, arg1: &0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::Config, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::assert_interacting_with_most_up_to_date_package(arg1);
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        arg0.is_archived = true;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
        let v0 = ArchiveProfileEvent{
            profile_id   : 0x2::object::id<Profile>(arg0),
            user_name    : arg0.user_name,
            owner        : arg0.owner,
            display_name : arg0.display_name,
            timestamp    : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ArchiveProfileEvent>(v0);
    }

    public fun background_image_blob_id(arg0: &Profile) : 0x1::option::Option<0x1::string::String> {
        assert!(!arg0.is_archived, 13906834715509260289);
        arg0.background_image_blob_id
    }

    public fun bio(arg0: &Profile) : 0x1::option::Option<0x1::string::String> {
        assert!(!arg0.is_archived, 13906834672559587329);
        arg0.bio
    }

    public(friend) fun create_profile(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::option::Option<0x1::string::String>, arg3: 0x1::option::Option<0x1::string::String>, arg4: 0x1::option::Option<0x1::string::String>, arg5: 0x1::option::Option<0x1::string::String>, arg6: 0x1::option::Option<0x1::string::String>, arg7: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg8: &0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::Config, arg9: &mut 0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_registry::Registry, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : Profile {
        0x1::string::append(&mut arg0, 0x1::string::utf8(b".sui"));
        assert!(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain_name(arg7) == arg0, 2);
        create_profile_helper(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8, arg9, arg10, arg11)
    }

    public(friend) fun create_profile_helper(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::option::Option<0x1::string::String>, arg3: 0x1::option::Option<0x1::string::String>, arg4: 0x1::option::Option<0x1::string::String>, arg5: 0x1::option::Option<0x1::string::String>, arg6: 0x1::option::Option<0x1::string::String>, arg7: &0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::Config, arg8: &mut 0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_registry::Registry, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : Profile {
        0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::assert_interacting_with_most_up_to_date_package(arg7);
        0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::assert_display_name_length_is_valid(arg7, &arg1);
        if (0x1::option::is_some<0x1::string::String>(&arg3)) {
            0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::assert_bio_length_is_valid(arg7, 0x1::option::borrow<0x1::string::String>(&arg3));
        };
        assert!(!0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_registry::has_record(arg8, arg0), 3);
        let v0 = Profile{
            id                       : 0x2::object::new(arg10),
            owner                    : 0x2::tx_context::sender(arg10),
            display_name             : arg1,
            user_name                : arg0,
            display_image_blob_id    : arg4,
            background_image_blob_id : arg5,
            walrus_site_id           : arg6,
            url                      : arg2,
            bio                      : arg3,
            is_archived              : false,
            created_at               : 0x2::clock::timestamp_ms(arg9),
            updated_at               : 0x2::clock::timestamp_ms(arg9),
        };
        0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_registry::add_record(arg8, arg0, 0x2::object::id<Profile>(&v0));
        let v1 = CreateProfileEvent{
            profile_id               : 0x2::object::id<Profile>(&v0),
            user_name                : v0.user_name,
            owner                    : 0x2::tx_context::sender(arg10),
            display_name             : v0.display_name,
            timestamp                : 0x2::clock::timestamp_ms(arg9),
            display_image_blob_id    : arg4,
            background_image_blob_id : arg5,
            walrus_site_id           : arg6,
            url                      : arg2,
            bio                      : arg3,
        };
        0x2::event::emit<CreateProfileEvent>(v1);
        v0
    }

    public(friend) fun create_profile_without_suins(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::option::Option<0x1::string::String>, arg3: 0x1::option::Option<0x1::string::String>, arg4: 0x1::option::Option<0x1::string::String>, arg5: 0x1::option::Option<0x1::string::String>, arg6: 0x1::option::Option<0x1::string::String>, arg7: &0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::Config, arg8: &mut 0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_registry::Registry, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : Profile {
        let v0 = 0x1::string::utf8(b"0x");
        0x1::string::append(&mut v0, 0x2::address::to_string(0x2::tx_context::sender(arg10)));
        assert!(v0 == arg0, 2);
        create_profile_helper(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    }

    public(friend) fun delete_profile(arg0: Profile, arg1: &mut 0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_registry::Registry, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_registry::remove_record(arg1, arg0.user_name);
        let Profile {
            id                       : v0,
            owner                    : v1,
            display_name             : v2,
            user_name                : v3,
            display_image_blob_id    : _,
            background_image_blob_id : _,
            walrus_site_id           : _,
            url                      : _,
            bio                      : _,
            is_archived              : _,
            created_at               : _,
            updated_at               : _,
        } = arg0;
        let v12 = DeleteProfileEvent{
            user_name    : v3,
            owner        : v1,
            display_name : v2,
            timestamp    : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<DeleteProfileEvent>(v12);
        0x2::object::delete(v0);
    }

    public fun display_image_blob_id(arg0: &Profile) : 0x1::option::Option<0x1::string::String> {
        assert!(!arg0.is_archived, 13906834694034423809);
        arg0.display_image_blob_id
    }

    public fun display_name(arg0: &Profile) : 0x1::string::String {
        assert!(!arg0.is_archived, 13906834608135077889);
        arg0.display_name
    }

    fun emit_add_df_to_profile_event<T0: copy + drop + store, T1: copy + drop + store>(arg0: &Profile, arg1: T0, arg2: T1, arg3: &0x2::clock::Clock) : T1 {
        let v0 = AddDFToProfileEvent<T0, T1>{
            profile_id : 0x2::object::id<Profile>(arg0),
            user_name  : arg0.user_name,
            owner      : arg0.owner,
            df_key     : arg1,
            df_value   : arg2,
            timestamp  : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<AddDFToProfileEvent<T0, T1>>(v0);
        arg2
    }

    fun emit_remove_df_from_profile_event<T0: copy + drop + store, T1: copy + drop + store>(arg0: &Profile, arg1: T0, arg2: T1, arg3: &0x2::clock::Clock) {
        let v0 = RemoveDFFromProfileEvent<T0, T1>{
            profile_id : 0x2::object::id<Profile>(arg0),
            user_name  : arg0.user_name,
            owner      : arg0.owner,
            df_key     : arg1,
            df_value   : arg2,
            timestamp  : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RemoveDFFromProfileEvent<T0, T1>>(v0);
    }

    fun emit_update_profile_event(arg0: &Profile, arg1: &0x2::clock::Clock) {
        let v0 = UpdateProfileEvent{
            profile_id               : 0x2::object::id<Profile>(arg0),
            user_name                : arg0.user_name,
            owner                    : arg0.owner,
            display_name             : arg0.display_name,
            timestamp                : 0x2::clock::timestamp_ms(arg1),
            display_image_blob_id    : arg0.display_image_blob_id,
            background_image_blob_id : arg0.background_image_blob_id,
            walrus_site_id           : arg0.walrus_site_id,
            url                      : arg0.url,
            bio                      : arg0.bio,
        };
        0x2::event::emit<UpdateProfileEvent>(v0);
    }

    public fun is_archived(arg0: &Profile) : bool {
        arg0.is_archived
    }

    public(friend) fun remove_background_image_blob_id(arg0: &mut Profile, arg1: &0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::Config, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::assert_interacting_with_most_up_to_date_package(arg1);
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        arg0.background_image_blob_id = 0x1::option::none<0x1::string::String>();
        arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
        emit_update_profile_event(arg0, arg2);
    }

    public(friend) fun remove_bio(arg0: &mut Profile, arg1: &0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::Config, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::assert_interacting_with_most_up_to_date_package(arg1);
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

    public(friend) fun remove_display_image_blob_id(arg0: &mut Profile, arg1: &0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::Config, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::assert_interacting_with_most_up_to_date_package(arg1);
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        arg0.display_image_blob_id = 0x1::option::none<0x1::string::String>();
        arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
        emit_update_profile_event(arg0, arg2);
    }

    public(friend) fun remove_url(arg0: &mut Profile, arg1: &0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::Config, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::assert_interacting_with_most_up_to_date_package(arg1);
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        arg0.url = 0x1::option::none<0x1::string::String>();
        arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
        emit_update_profile_event(arg0, arg2);
    }

    public(friend) fun remove_walrus_site_id(arg0: &mut Profile, arg1: &0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::Config, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::assert_interacting_with_most_up_to_date_package(arg1);
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        arg0.walrus_site_id = 0x1::option::none<0x1::string::String>();
        arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
        emit_update_profile_event(arg0, arg2);
    }

    public(friend) fun set_background_image_blob_id(arg0: &mut Profile, arg1: 0x1::string::String, arg2: &0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::Config, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::assert_interacting_with_most_up_to_date_package(arg2);
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 1);
        arg0.background_image_blob_id = 0x1::option::some<0x1::string::String>(arg1);
        arg0.updated_at = 0x2::clock::timestamp_ms(arg3);
        emit_update_profile_event(arg0, arg3);
    }

    public(friend) fun set_bio(arg0: &mut Profile, arg1: 0x1::string::String, arg2: &0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::Config, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::assert_interacting_with_most_up_to_date_package(arg2);
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 1);
        0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::assert_bio_length_is_valid(arg2, &arg1);
        arg0.bio = 0x1::option::some<0x1::string::String>(arg1);
        arg0.updated_at = 0x2::clock::timestamp_ms(arg3);
        emit_update_profile_event(arg0, arg3);
    }

    public(friend) fun set_display_image_blob_id(arg0: &mut Profile, arg1: 0x1::string::String, arg2: &0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::Config, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::assert_interacting_with_most_up_to_date_package(arg2);
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 1);
        arg0.display_image_blob_id = 0x1::option::some<0x1::string::String>(arg1);
        arg0.updated_at = 0x2::clock::timestamp_ms(arg3);
        emit_update_profile_event(arg0, arg3);
    }

    public(friend) fun set_display_name(arg0: &mut Profile, arg1: 0x1::string::String, arg2: &0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::Config, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::assert_interacting_with_most_up_to_date_package(arg2);
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 1);
        0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::assert_display_name_length_is_valid(arg2, &arg1);
        arg0.display_name = arg1;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg3);
        emit_update_profile_event(arg0, arg3);
    }

    public(friend) fun set_url(arg0: &mut Profile, arg1: 0x1::string::String, arg2: &0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::Config, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::assert_interacting_with_most_up_to_date_package(arg2);
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 1);
        arg0.url = 0x1::option::some<0x1::string::String>(arg1);
        arg0.updated_at = 0x2::clock::timestamp_ms(arg3);
        emit_update_profile_event(arg0, arg3);
    }

    public(friend) fun set_walrus_site_id(arg0: &mut Profile, arg1: 0x1::string::String, arg2: &0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::Config, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::assert_interacting_with_most_up_to_date_package(arg2);
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 1);
        arg0.walrus_site_id = 0x1::option::some<0x1::string::String>(arg1);
        arg0.updated_at = 0x2::clock::timestamp_ms(arg3);
        emit_update_profile_event(arg0, arg3);
    }

    public fun uid(arg0: &Profile) : &0x2::object::UID {
        &arg0.id
    }

    public fun uid_mut(arg0: &mut Profile) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun unarchive_profile(arg0: &mut Profile, arg1: &0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::Config, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0xd01c7f58fb5b296b8f0f45dd63cac5cb696cee439ff174ff4bb1504a5c5b0d9d::social_layer_config::assert_interacting_with_most_up_to_date_package(arg1);
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        arg0.is_archived = false;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
        let v0 = UnarchiveProfileEvent{
            profile_id   : 0x2::object::id<Profile>(arg0),
            user_name    : arg0.user_name,
            owner        : arg0.owner,
            display_name : arg0.display_name,
            timestamp    : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<UnarchiveProfileEvent>(v0);
    }

    public fun url(arg0: &Profile) : 0x1::option::Option<0x1::string::String> {
        assert!(!arg0.is_archived, 13906834651084750849);
        arg0.url
    }

    public fun user_name(arg0: &Profile) : 0x1::string::String {
        assert!(!arg0.is_archived, 13906834629609914369);
        arg0.user_name
    }

    public fun walrus_site_id(arg0: &Profile) : 0x1::option::Option<0x1::string::String> {
        assert!(!arg0.is_archived, 13906834736984096769);
        arg0.walrus_site_id
    }

    // decompiled from Move bytecode v6
}

