module 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::profiles {
    struct ProfilesRegistry has key {
        id: 0x2::object::UID,
    }

    struct ProfileCreated has copy, drop {
        owner: address,
        profile_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct ProfileMetadataUpdated has copy, drop {
        profile_id: 0x2::object::ID,
        owner: address,
        key: 0x1::string::String,
        value: 0x1::string::String,
        timestamp_ms: u64,
    }

    struct ProfileSubdomainSet has copy, drop {
        profile_id: 0x2::object::ID,
        owner: address,
        subdomain_name: 0x1::string::String,
        timestamp_ms: u64,
    }

    struct ProfileSubdomainRemoved has copy, drop {
        profile_id: 0x2::object::ID,
        owner: address,
        subdomain_name: 0x1::string::String,
        timestamp_ms: u64,
        removed_by: address,
    }

    struct RegistryKey has copy, drop, store {
        owner: address,
    }

    struct Profile has key {
        id: 0x2::object::UID,
        owner: address,
        total_usd_micro: u64,
        total_donations_count: u64,
        badge_levels_earned: u16,
        subdomain_name: 0x1::option::Option<0x1::string::String>,
        metadata: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    public(friend) fun add_contribution(arg0: &mut Profile, arg1: u64) {
        if (arg1 == 0) {
            return
        };
        assert!(arg1 <= 18446744073709551615 - arg0.total_usd_micro, 3);
        arg0.total_usd_micro = arg0.total_usd_micro + arg1;
        assert!(arg0.total_donations_count < 18446744073709551615, 3);
        arg0.total_donations_count = arg0.total_donations_count + 1;
    }

    public(friend) fun assert_subdomain_not_set(arg0: &Profile) {
        assert!(0x1::option::is_none<0x1::string::String>(&arg0.subdomain_name), 12);
    }

    fun assert_valid_metadata(arg0: &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>) {
        let v0 = 0;
        let v1 = 0x2::vec_map::length<0x1::string::String, 0x1::string::String>(arg0);
        assert!(v1 <= 100, 11);
        while (v0 < v1) {
            let (v2, v3) = 0x2::vec_map::get_entry_by_idx<0x1::string::String, 0x1::string::String>(arg0, v0);
            let v4 = 0x1::string::length(v2);
            let v5 = 0x1::string::length(v3);
            assert!(v4 > 0, 7);
            assert!(v5 > 0, 8);
            assert!(v4 <= 64, 9);
            assert!(v5 <= 2048, 10);
            v0 = v0 + 1;
        };
    }

    fun assert_valid_metadata_entry(arg0: &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg1: &0x1::string::String, arg2: &0x1::string::String) {
        let v0 = 0x1::string::length(arg1);
        let v1 = 0x1::string::length(arg2);
        assert!(v0 > 0, 7);
        assert!(v1 > 0, 8);
        assert!(v0 <= 64, 9);
        assert!(v1 <= 2048, 10);
        if (!0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(arg0, arg1)) {
            assert!(0x2::vec_map::length<0x1::string::String, 0x1::string::String>(arg0) < 100, 11);
        };
    }

    public fun badge_levels_earned(arg0: &Profile) : u16 {
        arg0.badge_levels_earned
    }

    public(friend) fun clear_subdomain(arg0: &mut Profile) {
        assert!(0x1::option::is_some<0x1::string::String>(&arg0.subdomain_name), 13);
        arg0.subdomain_name = 0x1::option::none<0x1::string::String>();
    }

    public(friend) fun create(arg0: address, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>, arg3: &mut 0x2::tx_context::TxContext) : Profile {
        assert!(0x1::vector::length<0x1::string::String>(&arg1) == 0x1::vector::length<0x1::string::String>(&arg2), 2);
        let v0 = 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg1, arg2);
        assert_valid_metadata(&v0);
        Profile{
            id                    : 0x2::object::new(arg3),
            owner                 : arg0,
            total_usd_micro       : 0,
            total_donations_count : 0,
            badge_levels_earned   : 0,
            subdomain_name        : 0x1::option::none<0x1::string::String>(),
            metadata              : v0,
        }
    }

    public(friend) fun create_for(arg0: &mut ProfilesRegistry, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : Profile {
        assert!(arg1 == 0x2::tx_context::sender(arg3), 1);
        assert!(!exists(arg0, arg1), 6);
        let v0 = create(arg1, 0x1::vector::empty<0x1::string::String>(), 0x1::vector::empty<0x1::string::String>(), arg3);
        let v1 = 0x2::object::id<Profile>(&v0);
        0x2::dynamic_field::add<RegistryKey, 0x2::object::ID>(&mut arg0.id, registry_key(arg1), v1);
        let v2 = ProfileCreated{
            owner        : arg1,
            profile_id   : v1,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ProfileCreated>(v2);
        v0
    }

    public(friend) fun create_or_get_profile_for_sender(arg0: &mut ProfilesRegistry, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::sender(arg2);
        if (exists(arg0, v0)) {
            id_of(arg0, v0)
        } else {
            let v2 = create_for(arg0, v0, arg1, arg2);
            0x2::transfer::transfer<Profile>(v2, v0);
            0x2::object::id<Profile>(&v2)
        }
    }

    entry fun create_profile(arg0: &mut ProfilesRegistry, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        transfer_to(create_profile_for_sender(arg0, arg1, arg2), v0);
    }

    public fun create_profile_for_sender(arg0: &mut ProfilesRegistry, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : Profile {
        let v0 = 0x2::tx_context::sender(arg2);
        create_for(arg0, v0, arg1, arg2)
    }

    public(friend) fun create_registry(arg0: &mut 0x2::tx_context::TxContext) : ProfilesRegistry {
        ProfilesRegistry{id: 0x2::object::new(arg0)}
    }

    public(friend) fun emit_profile_subdomain_removed(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::string::String, arg3: u64, arg4: address) {
        let v0 = ProfileSubdomainRemoved{
            profile_id     : arg0,
            owner          : arg1,
            subdomain_name : arg2,
            timestamp_ms   : arg3,
            removed_by     : arg4,
        };
        0x2::event::emit<ProfileSubdomainRemoved>(v0);
    }

    public(friend) fun emit_profile_subdomain_set(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::string::String, arg3: u64) {
        let v0 = ProfileSubdomainSet{
            profile_id     : arg0,
            owner          : arg1,
            subdomain_name : arg2,
            timestamp_ms   : arg3,
        };
        0x2::event::emit<ProfileSubdomainSet>(v0);
    }

    public fun exists(arg0: &ProfilesRegistry, arg1: address) : bool {
        0x2::dynamic_field::exists_<RegistryKey>(&arg0.id, registry_key(arg1))
    }

    public(friend) fun grant_badge_level(arg0: &mut Profile, arg1: u8) {
        assert!(arg1 > 0 && arg1 <= 5, 4);
        arg0.badge_levels_earned = arg0.badge_levels_earned | 1 << arg1 - 1;
    }

    public(friend) fun grant_badge_levels(arg0: &mut Profile, arg1: u16) {
        assert!(arg1 <= 31, 5);
        arg0.badge_levels_earned = arg0.badge_levels_earned | arg1;
    }

    public fun has_badge_level(arg0: &Profile, arg1: u8) : bool {
        if (arg1 == 0 || arg1 > 5) {
            return false
        };
        arg0.badge_levels_earned & 1 << arg1 - 1 != 0
    }

    public fun id_of(arg0: &ProfilesRegistry, arg1: address) : 0x2::object::ID {
        *0x2::dynamic_field::borrow<RegistryKey, 0x2::object::ID>(&arg0.id, registry_key(arg1))
    }

    fun insert_or_update_metadata(arg0: &mut 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(arg0, &arg1)) {
            *0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(arg0, &arg1) = arg2;
        } else {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(arg0, arg1, arg2);
        };
    }

    public fun metadata(arg0: &Profile) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.metadata
    }

    public(friend) fun not_profile_owner_error_code() : u64 {
        1
    }

    public fun owner(arg0: &Profile) : address {
        arg0.owner
    }

    public(friend) fun profile_exists_error_code() : u64 {
        6
    }

    public fun profile_metadata_updated_key(arg0: &ProfileMetadataUpdated) : 0x1::string::String {
        arg0.key
    }

    public fun profile_metadata_updated_owner(arg0: &ProfileMetadataUpdated) : address {
        arg0.owner
    }

    public fun profile_metadata_updated_profile_id(arg0: &ProfileMetadataUpdated) : 0x2::object::ID {
        arg0.profile_id
    }

    public fun profile_metadata_updated_timestamp_ms(arg0: &ProfileMetadataUpdated) : u64 {
        arg0.timestamp_ms
    }

    public fun profile_metadata_updated_value(arg0: &ProfileMetadataUpdated) : 0x1::string::String {
        arg0.value
    }

    fun registry_key(arg0: address) : RegistryKey {
        RegistryKey{owner: arg0}
    }

    public(friend) fun set_metadata(arg0: &mut Profile, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 1);
        assert!(0x1::vector::length<0x1::string::String>(&arg1) == 0x1::vector::length<0x1::string::String>(&arg2), 2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg1)) {
            let v1 = *0x1::vector::borrow<0x1::string::String>(&arg1, v0);
            let v2 = *0x1::vector::borrow<0x1::string::String>(&arg2, v0);
            assert_valid_metadata_entry(&arg0.metadata, &v1, &v2);
            let v3 = &mut arg0.metadata;
            insert_or_update_metadata(v3, v1, v2);
            v0 = v0 + 1;
        };
    }

    public(friend) fun set_subdomain(arg0: &mut Profile, arg1: 0x1::string::String) {
        assert_subdomain_not_set(arg0);
        arg0.subdomain_name = 0x1::option::some<0x1::string::String>(arg1);
    }

    public(friend) fun share_registry(arg0: ProfilesRegistry) {
        0x2::transfer::share_object<ProfilesRegistry>(arg0);
    }

    public(friend) fun subdomain_already_set_error_code() : u64 {
        12
    }

    public fun subdomain_name(arg0: &Profile) : 0x1::option::Option<0x1::string::String> {
        arg0.subdomain_name
    }

    public(friend) fun subdomain_not_set_error_code() : u64 {
        13
    }

    public fun total_donations_count(arg0: &Profile) : u64 {
        arg0.total_donations_count
    }

    public fun total_usd_micro(arg0: &Profile) : u64 {
        arg0.total_usd_micro
    }

    public fun transfer_profile_to_sender(arg0: Profile, arg1: &0x2::tx_context::TxContext) {
        transfer_to(arg0, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun transfer_to(arg0: Profile, arg1: address) {
        assert!(arg0.owner == arg1, 1);
        0x2::transfer::transfer<Profile>(arg0, arg1);
    }

    entry fun update_profile_metadata(arg0: &mut Profile, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v1, arg2);
        upsert_profile_metadata(arg0, v0, v1, arg3, arg4);
    }

    public fun upsert_profile_metadata(arg0: &mut Profile, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg0.owner == v0, 1);
        assert!(0x1::vector::length<0x1::string::String>(&arg1) == 0x1::vector::length<0x1::string::String>(&arg2), 2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg1)) {
            let v2 = 0x1::vector::borrow<0x1::string::String>(&arg1, v1);
            let v3 = 0x1::vector::borrow<0x1::string::String>(&arg2, v1);
            assert_valid_metadata_entry(&arg0.metadata, v2, v3);
            let v4 = &mut arg0.metadata;
            insert_or_update_metadata(v4, *v2, *v3);
            let v5 = ProfileMetadataUpdated{
                profile_id   : 0x2::object::id<Profile>(arg0),
                owner        : v0,
                key          : *v2,
                value        : *v3,
                timestamp_ms : 0x2::clock::timestamp_ms(arg3),
            };
            0x2::event::emit<ProfileMetadataUpdated>(v5);
            v1 = v1 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

