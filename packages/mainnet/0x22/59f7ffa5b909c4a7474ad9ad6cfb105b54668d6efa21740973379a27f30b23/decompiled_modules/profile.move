module 0x2259f7ffa5b909c4a7474ad9ad6cfb105b54668d6efa21740973379a27f30b23::profile {
    struct Profile has store, key {
        id: 0x2::object::UID,
        owner: address,
        display_name: 0x1::string::String,
        user_name: 0x1::string::String,
        image_url: 0x1::option::Option<0x1::string::String>,
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
        image_url: 0x1::option::Option<0x1::string::String>,
        url: 0x1::option::Option<0x1::string::String>,
        bio: 0x1::option::Option<0x1::string::String>,
    }

    struct UpdateProfileEvent has copy, drop {
        profile_id: 0x2::object::ID,
        user_name: 0x1::string::String,
        owner: address,
        display_name: 0x1::string::String,
        timestamp: u64,
        image_url: 0x1::option::Option<0x1::string::String>,
        url: 0x1::option::Option<0x1::string::String>,
        bio: 0x1::option::Option<0x1::string::String>,
    }

    public fun archive_profile(arg0: &mut Profile, arg1: &0x2259f7ffa5b909c4a7474ad9ad6cfb105b54668d6efa21740973379a27f30b23::social_layer_config::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x2259f7ffa5b909c4a7474ad9ad6cfb105b54668d6efa21740973379a27f30b23::social_layer_config::assert_interacting_with_most_up_to_date_package(arg1);
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

    public fun bio(arg0: &Profile) : 0x1::option::Option<0x1::string::String> {
        assert!(!arg0.is_archived, 13906834565185404929);
        arg0.bio
    }

    public(friend) fun create_profile(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::option::Option<0x1::string::String>, arg3: 0x1::option::Option<0x1::string::String>, arg4: 0x1::option::Option<0x1::string::String>, arg5: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg6: &0x2259f7ffa5b909c4a7474ad9ad6cfb105b54668d6efa21740973379a27f30b23::social_layer_config::Config, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : Profile {
        0x2259f7ffa5b909c4a7474ad9ad6cfb105b54668d6efa21740973379a27f30b23::social_layer_config::assert_interacting_with_most_up_to_date_package(arg6);
        0x2259f7ffa5b909c4a7474ad9ad6cfb105b54668d6efa21740973379a27f30b23::social_layer_config::assert_display_name_length_is_valid(arg6, &arg1);
        if (0x1::option::is_some<0x1::string::String>(&arg3)) {
            0x2259f7ffa5b909c4a7474ad9ad6cfb105b54668d6efa21740973379a27f30b23::social_layer_config::assert_bio_length_is_valid(arg6, 0x1::option::borrow<0x1::string::String>(&arg3));
        };
        assert!(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain_name(arg5) == arg1, 2);
        let v0 = Profile{
            id           : 0x2::object::new(arg8),
            owner        : 0x2::tx_context::sender(arg8),
            display_name : arg1,
            user_name    : arg0,
            image_url    : arg4,
            url          : arg2,
            bio          : arg3,
            is_archived  : false,
            created_at   : 0x2::clock::timestamp_ms(arg7),
            updated_at   : 0x2::clock::timestamp_ms(arg7),
        };
        let v1 = CreateProfileEvent{
            profile_id   : 0x2::object::id<Profile>(&v0),
            user_name    : v0.user_name,
            owner        : 0x2::tx_context::sender(arg8),
            display_name : v0.display_name,
            timestamp    : 0x2::clock::timestamp_ms(arg7),
            image_url    : arg4,
            url          : arg2,
            bio          : arg3,
        };
        0x2::event::emit<CreateProfileEvent>(v1);
        v0
    }

    public fun delete_profile(arg0: Profile, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        let Profile {
            id           : v0,
            owner        : v1,
            display_name : v2,
            user_name    : v3,
            image_url    : _,
            url          : _,
            bio          : _,
            is_archived  : _,
            created_at   : _,
            updated_at   : _,
        } = arg0;
        let v10 = DeleteProfileEvent{
            user_name    : v3,
            owner        : v1,
            display_name : v2,
            timestamp    : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<DeleteProfileEvent>(v10);
        0x2::object::delete(v0);
    }

    public fun display_name(arg0: &Profile) : 0x1::string::String {
        assert!(!arg0.is_archived, 13906834500760895489);
        arg0.display_name
    }

    fun emit_update_profile_event(arg0: &Profile, arg1: &0x2::clock::Clock) {
        let v0 = UpdateProfileEvent{
            profile_id   : 0x2::object::id<Profile>(arg0),
            user_name    : arg0.user_name,
            owner        : arg0.owner,
            display_name : arg0.display_name,
            timestamp    : 0x2::clock::timestamp_ms(arg1),
            image_url    : arg0.image_url,
            url          : arg0.url,
            bio          : arg0.bio,
        };
        0x2::event::emit<UpdateProfileEvent>(v0);
    }

    public fun image_url(arg0: &Profile) : 0x1::option::Option<0x1::string::String> {
        assert!(!arg0.is_archived, 13906834586660241409);
        arg0.image_url
    }

    public fun is_archived(arg0: &Profile) : bool {
        arg0.is_archived
    }

    public(friend) fun remove_bio(arg0: &mut Profile, arg1: &0x2259f7ffa5b909c4a7474ad9ad6cfb105b54668d6efa21740973379a27f30b23::social_layer_config::Config, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x2259f7ffa5b909c4a7474ad9ad6cfb105b54668d6efa21740973379a27f30b23::social_layer_config::assert_interacting_with_most_up_to_date_package(arg1);
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        arg0.bio = 0x1::option::none<0x1::string::String>();
        arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
        emit_update_profile_event(arg0, arg2);
    }

    public(friend) fun remove_image_url(arg0: &mut Profile, arg1: &0x2259f7ffa5b909c4a7474ad9ad6cfb105b54668d6efa21740973379a27f30b23::social_layer_config::Config, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x2259f7ffa5b909c4a7474ad9ad6cfb105b54668d6efa21740973379a27f30b23::social_layer_config::assert_interacting_with_most_up_to_date_package(arg1);
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        arg0.image_url = 0x1::option::none<0x1::string::String>();
        arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
        emit_update_profile_event(arg0, arg2);
    }

    public(friend) fun remove_url(arg0: &mut Profile, arg1: &0x2259f7ffa5b909c4a7474ad9ad6cfb105b54668d6efa21740973379a27f30b23::social_layer_config::Config, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x2259f7ffa5b909c4a7474ad9ad6cfb105b54668d6efa21740973379a27f30b23::social_layer_config::assert_interacting_with_most_up_to_date_package(arg1);
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        arg0.url = 0x1::option::none<0x1::string::String>();
        arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
        emit_update_profile_event(arg0, arg2);
    }

    public(friend) fun set_bio(arg0: &mut Profile, arg1: 0x1::string::String, arg2: &0x2259f7ffa5b909c4a7474ad9ad6cfb105b54668d6efa21740973379a27f30b23::social_layer_config::Config, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x2259f7ffa5b909c4a7474ad9ad6cfb105b54668d6efa21740973379a27f30b23::social_layer_config::assert_interacting_with_most_up_to_date_package(arg2);
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 1);
        0x2259f7ffa5b909c4a7474ad9ad6cfb105b54668d6efa21740973379a27f30b23::social_layer_config::assert_bio_length_is_valid(arg2, &arg1);
        arg0.bio = 0x1::option::some<0x1::string::String>(arg1);
        arg0.updated_at = 0x2::clock::timestamp_ms(arg3);
        emit_update_profile_event(arg0, arg3);
    }

    public(friend) fun set_display_name(arg0: &mut Profile, arg1: 0x1::string::String, arg2: &0x2259f7ffa5b909c4a7474ad9ad6cfb105b54668d6efa21740973379a27f30b23::social_layer_config::Config, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x2259f7ffa5b909c4a7474ad9ad6cfb105b54668d6efa21740973379a27f30b23::social_layer_config::assert_interacting_with_most_up_to_date_package(arg2);
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 1);
        0x2259f7ffa5b909c4a7474ad9ad6cfb105b54668d6efa21740973379a27f30b23::social_layer_config::assert_display_name_length_is_valid(arg2, &arg1);
        arg0.display_name = arg1;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg3);
        emit_update_profile_event(arg0, arg3);
    }

    public(friend) fun set_image_url(arg0: &mut Profile, arg1: 0x1::string::String, arg2: &0x2259f7ffa5b909c4a7474ad9ad6cfb105b54668d6efa21740973379a27f30b23::social_layer_config::Config, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x2259f7ffa5b909c4a7474ad9ad6cfb105b54668d6efa21740973379a27f30b23::social_layer_config::assert_interacting_with_most_up_to_date_package(arg2);
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 1);
        arg0.image_url = 0x1::option::some<0x1::string::String>(arg1);
        arg0.updated_at = 0x2::clock::timestamp_ms(arg3);
        emit_update_profile_event(arg0, arg3);
    }

    public(friend) fun set_url(arg0: &mut Profile, arg1: 0x1::string::String, arg2: &0x2259f7ffa5b909c4a7474ad9ad6cfb105b54668d6efa21740973379a27f30b23::social_layer_config::Config, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x2259f7ffa5b909c4a7474ad9ad6cfb105b54668d6efa21740973379a27f30b23::social_layer_config::assert_interacting_with_most_up_to_date_package(arg2);
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 1);
        arg0.url = 0x1::option::some<0x1::string::String>(arg1);
        arg0.updated_at = 0x2::clock::timestamp_ms(arg3);
        emit_update_profile_event(arg0, arg3);
    }

    public fun unarchive_profile(arg0: &mut Profile, arg1: &0x2259f7ffa5b909c4a7474ad9ad6cfb105b54668d6efa21740973379a27f30b23::social_layer_config::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x2259f7ffa5b909c4a7474ad9ad6cfb105b54668d6efa21740973379a27f30b23::social_layer_config::assert_interacting_with_most_up_to_date_package(arg1);
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
        assert!(!arg0.is_archived, 13906834543710568449);
        arg0.url
    }

    public fun user_name(arg0: &Profile) : 0x1::string::String {
        assert!(!arg0.is_archived, 13906834522235731969);
        arg0.user_name
    }

    // decompiled from Move bytecode v6
}

