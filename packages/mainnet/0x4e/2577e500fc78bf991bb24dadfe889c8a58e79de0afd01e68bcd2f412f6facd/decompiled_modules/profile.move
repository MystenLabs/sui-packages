module 0x4e2577e500fc78bf991bb24dadfe889c8a58e79de0afd01e68bcd2f412f6facd::profile {
    struct PROFILE has drop {
        dummy_field: bool,
    }

    struct ProfileManagerAdminAdded has copy, drop {
        new_admin: address,
        by: address,
    }

    struct ProfileManagerAdminRemoved has copy, drop {
        removed_admin: address,
        by: address,
    }

    struct ProfileCreated has copy, drop {
        profile_id: 0x2::object::ID,
        owner: address,
        by: address,
    }

    struct ProfileDeleted has copy, drop {
        profile_id: 0x2::object::ID,
        owner: address,
        by: address,
    }

    struct ProfileOwnershipTransferred has copy, drop {
        profile_id: 0x2::object::ID,
        old_owner: address,
        new_owner: address,
        by: address,
    }

    struct LinkAddressRequestCreated has copy, drop {
        link_address_request_id: 0x2::object::ID,
        profile_id: 0x2::object::ID,
        requester: address,
        profile_owner: address,
        by: address,
    }

    struct LinkAddressRequestAccepted has copy, drop {
        link_address_request_id: 0x2::object::ID,
        profile_id: 0x2::object::ID,
        requester: address,
        profile_owner: address,
        by: address,
    }

    struct LinkAddressRequestDeclined has copy, drop {
        link_address_request_id: 0x2::object::ID,
        profile_id: 0x2::object::ID,
        requester: address,
        by: address,
    }

    struct LinkAddressRequestDeleted has copy, drop {
        link_address_request_id: 0x2::object::ID,
        profile_id: 0x2::object::ID,
        requester: address,
        by: address,
    }

    struct LinkedAddressRemoved has copy, drop {
        profile_id: 0x2::object::ID,
        linked_address: address,
        by: address,
    }

    struct ProfileManager has store, key {
        id: 0x2::object::UID,
        admins: vector<address>,
        creator: address,
        linked_addresses: 0x2::table::Table<address, LinkedAddressWrapper>,
    }

    struct LinkedAddressWrapper has drop, store {
        profile_id: 0x2::object::ID,
    }

    struct LinkAddressRquest has store, key {
        id: 0x2::object::UID,
        profile_id: 0x2::object::ID,
        requester: address,
    }

    struct Link has copy, drop, store {
        name: 0x1::string::String,
        icon: 0x1::string::String,
        url: 0x1::string::String,
        data: 0x1::string::String,
    }

    struct Profile has key {
        id: 0x2::object::UID,
        owner: address,
        linked_addresses: vector<address>,
        avatar_url: 0x1::string::String,
        background_url: 0x1::string::String,
        display_name: 0x1::string::String,
        description: 0x1::string::String,
        data: 0x1::string::String,
        links: vector<Link>,
        creator: address,
        created_at: u64,
        updated_at: u64,
    }

    public fun accept_link_address_request(arg0: &mut ProfileManager, arg1: LinkAddressRquest, arg2: &mut Profile, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::uid_to_inner(&arg2.id) == arg1.profile_id, 0x4e2577e500fc78bf991bb24dadfe889c8a58e79de0afd01e68bcd2f412f6facd::error::not_authorized_error());
        internal_add_linked_address(arg0, arg2, arg1.requester);
        let v0 = LinkAddressRequestAccepted{
            link_address_request_id : 0x2::object::id<LinkAddressRquest>(&arg1),
            profile_id              : 0x2::object::id<Profile>(arg2),
            requester               : 0x2::tx_context::sender(arg3),
            profile_owner           : arg2.owner,
            by                      : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<LinkAddressRequestAccepted>(v0);
        internal_delete_link_address_request(arg1, arg3);
    }

    public fun add_link_to_profile(arg0: &mut Profile, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = Link{
            name : arg1,
            icon : arg2,
            url  : arg3,
            data : arg4,
        };
        0x1::vector::push_back<Link>(&mut arg0.links, v0);
        arg0.updated_at = 0x2::clock::timestamp_ms(arg5);
    }

    public fun assert_address_profile_not_overlap_with_others(arg0: &ProfileManager, arg1: address, arg2: vector<address>) {
        assert!(!is_address_profile_overlap_with_others(arg0, arg1, arg2), 0x4e2577e500fc78bf991bb24dadfe889c8a58e79de0afd01e68bcd2f412f6facd::error::address_not_belong_to_same_profile_error());
    }

    public fun assert_address_profile_overlap_with_others(arg0: &ProfileManager, arg1: address, arg2: vector<address>) {
        assert!(is_address_profile_overlap_with_others(arg0, arg1, arg2), 0x4e2577e500fc78bf991bb24dadfe889c8a58e79de0afd01e68bcd2f412f6facd::error::address_not_belong_to_same_profile_error());
    }

    public fun assert_is_address_linked(arg0: &ProfileManager, arg1: address) {
        assert!(is_address_linked(arg0, arg1), 0x4e2577e500fc78bf991bb24dadfe889c8a58e79de0afd01e68bcd2f412f6facd::error::address_not_linked_error());
    }

    public fun assert_is_address_not_linked(arg0: &ProfileManager, arg1: address) {
        assert!(!is_address_linked(arg0, arg1), 0x4e2577e500fc78bf991bb24dadfe889c8a58e79de0afd01e68bcd2f412f6facd::error::address_has_linked_error());
    }

    public fun assert_is_addresses_in_same_profile(arg0: &ProfileManager, arg1: address, arg2: address) {
        assert!(is_addresses_in_same_profile(arg0, arg1, arg2), 0x4e2577e500fc78bf991bb24dadfe889c8a58e79de0afd01e68bcd2f412f6facd::error::address_not_belong_to_same_profile_error());
    }

    public fun assert_is_addresses_not_in_same_profile(arg0: &ProfileManager, arg1: address, arg2: address) {
        assert!(!is_addresses_in_same_profile(arg0, arg1, arg2), 0x4e2577e500fc78bf991bb24dadfe889c8a58e79de0afd01e68bcd2f412f6facd::error::address_not_belong_to_same_profile_error());
    }

    public fun assert_is_profile_manager_admin(arg0: &ProfileManager, arg1: address) {
        assert!(is_profile_manager_admin(arg0, arg1), 0x4e2577e500fc78bf991bb24dadfe889c8a58e79de0afd01e68bcd2f412f6facd::error::not_authorized_error());
    }

    public fun borrow_profile_links(arg0: &Profile) : &vector<Link> {
        &arg0.links
    }

    public fun create_link_address_request(arg0: &mut ProfileManager, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_is_address_not_linked(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = LinkAddressRquest{
            id         : 0x2::object::new(arg3),
            profile_id : 0x2::object::id_from_address(arg1),
            requester  : v0,
        };
        let v2 = LinkAddressRequestCreated{
            link_address_request_id : 0x2::object::id<LinkAddressRquest>(&v1),
            profile_id              : 0x2::object::id_from_address(arg1),
            requester               : v0,
            profile_owner           : arg2,
            by                      : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<LinkAddressRequestCreated>(v2);
        0x2::transfer::public_transfer<LinkAddressRquest>(v1, arg2);
    }

    public fun create_profile(arg0: &mut ProfileManager, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = internal_create_profile(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::transfer<Profile>(v0, 0x2::tx_context::sender(arg7));
    }

    public fun create_profile_with_links(arg0: &mut ProfileManager, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<0x1::string::String>, arg7: vector<0x1::string::String>, arg8: vector<0x1::string::String>, arg9: vector<0x1::string::String>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = internal_create_profile(arg0, arg1, arg2, arg3, arg4, arg5, arg10, arg11);
        let v1 = 0;
        loop {
            if (v1 >= 0x1::vector::length<0x1::string::String>(&arg6)) {
                break
            };
            let v2 = Link{
                name : *0x1::vector::borrow<0x1::string::String>(&arg6, v1),
                icon : *0x1::vector::borrow<0x1::string::String>(&arg7, v1),
                url  : *0x1::vector::borrow<0x1::string::String>(&arg8, v1),
                data : *0x1::vector::borrow<0x1::string::String>(&arg9, v1),
            };
            0x1::vector::push_back<Link>(&mut v0.links, v2);
            v1 = v1 + 1;
        };
        0x2::transfer::transfer<Profile>(v0, 0x2::tx_context::sender(arg11));
    }

    public fun decline_link_address_request(arg0: LinkAddressRquest, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = LinkAddressRequestDeclined{
            link_address_request_id : 0x2::object::id<LinkAddressRquest>(&arg0),
            profile_id              : arg0.profile_id,
            requester               : arg0.requester,
            by                      : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<LinkAddressRequestDeclined>(v0);
        internal_delete_link_address_request(arg0, arg1);
    }

    public fun delete_profile(arg0: &mut ProfileManager, arg1: Profile, arg2: &mut 0x2::tx_context::TxContext) {
        internal_delete_profile(arg0, arg1, arg2);
    }

    public fun edit_link_in_profile(arg0: &mut Profile, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::borrow_mut<Link>(&mut arg0.links, arg1);
        v0.name = arg2;
        v0.icon = arg3;
        v0.url = arg4;
        v0.data = arg5;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg6);
    }

    public fun edit_profile_avatar_url(arg0: &mut Profile, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.avatar_url = arg1;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
    }

    public fun edit_profile_background_url(arg0: &mut Profile, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.background_url = arg1;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
    }

    public fun edit_profile_data(arg0: &mut Profile, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.data = arg1;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
    }

    public fun edit_profile_description(arg0: &mut Profile, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.description = arg1;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
    }

    public fun edit_profile_display_name(arg0: &mut Profile, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.display_name = arg1;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
    }

    public fun get_address_linked_profile_id(arg0: &ProfileManager, arg1: address) : 0x2::object::ID {
        assert!(is_address_linked(arg0, arg1), 0x4e2577e500fc78bf991bb24dadfe889c8a58e79de0afd01e68bcd2f412f6facd::error::address_not_linked_error());
        internal_get_address_linked_profile_id(arg0, arg1)
    }

    public fun get_link_data(arg0: &Link) : 0x1::string::String {
        arg0.data
    }

    public fun get_link_icon(arg0: &Link) : 0x1::string::String {
        arg0.icon
    }

    public fun get_link_name(arg0: &Link) : 0x1::string::String {
        arg0.name
    }

    public fun get_link_url(arg0: &Link) : 0x1::string::String {
        arg0.url
    }

    public fun get_profile_avatar_url(arg0: &Profile) : 0x1::string::String {
        arg0.avatar_url
    }

    public fun get_profile_background_url(arg0: &Profile) : 0x1::string::String {
        arg0.background_url
    }

    public fun get_profile_created_at(arg0: &Profile) : u64 {
        arg0.created_at
    }

    public fun get_profile_creator(arg0: &Profile) : address {
        arg0.creator
    }

    public fun get_profile_data(arg0: &Profile) : 0x1::string::String {
        arg0.data
    }

    public fun get_profile_description(arg0: &Profile) : 0x1::string::String {
        arg0.description
    }

    public fun get_profile_display_name(arg0: &Profile) : 0x1::string::String {
        arg0.display_name
    }

    public fun get_profile_linked_addresses(arg0: &Profile) : vector<address> {
        arg0.linked_addresses
    }

    public fun get_profile_manager_admins(arg0: &ProfileManager) : vector<address> {
        arg0.admins
    }

    public fun get_profile_manager_creator(arg0: &ProfileManager) : address {
        arg0.creator
    }

    public fun get_profile_owner(arg0: &Profile) : address {
        arg0.owner
    }

    public fun get_profile_updated_at(arg0: &Profile) : u64 {
        arg0.updated_at
    }

    fun init(arg0: PROFILE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{display_name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://liquidlink.io/api/profile/{id}/image"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{display_name}'s profile at LiquidLink. Check it out at https://liquidlink.io/{id}. Create your own at https://liquidlink.io"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://liquidlink.io"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{creator}"));
        let v4 = 0x2::package::claim<PROFILE>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Profile>(&v4, v0, v2, arg1);
        0x2::display::update_version<Profile>(&mut v5);
        let v6 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v6);
        0x2::transfer::public_transfer<0x2::display::Display<Profile>>(v5, v6);
        let v7 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v7, 0x2::tx_context::sender(arg1));
        let v8 = ProfileManager{
            id               : 0x2::object::new(arg1),
            admins           : v7,
            creator          : 0x2::tx_context::sender(arg1),
            linked_addresses : 0x2::table::new<address, LinkedAddressWrapper>(arg1),
        };
        0x2::transfer::share_object<ProfileManager>(v8);
    }

    fun internal_add_linked_address(arg0: &mut ProfileManager, arg1: &mut Profile, arg2: address) {
        assert_is_address_not_linked(arg0, arg2);
        0x1::vector::push_back<address>(&mut arg1.linked_addresses, arg2);
        let v0 = LinkedAddressWrapper{profile_id: 0x2::object::uid_to_inner(&arg1.id)};
        0x2::table::add<address, LinkedAddressWrapper>(&mut arg0.linked_addresses, arg2, v0);
    }

    fun internal_create_profile(arg0: &mut ProfileManager, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : Profile {
        let v0 = Profile{
            id               : 0x2::object::new(arg7),
            owner            : 0x2::tx_context::sender(arg7),
            linked_addresses : 0x1::vector::empty<address>(),
            avatar_url       : arg1,
            background_url   : arg2,
            display_name     : arg3,
            description      : arg4,
            data             : arg5,
            links            : 0x1::vector::empty<Link>(),
            creator          : 0x2::tx_context::sender(arg7),
            created_at       : 0x2::clock::timestamp_ms(arg6),
            updated_at       : 0x2::clock::timestamp_ms(arg6),
        };
        let v1 = &mut v0;
        internal_add_linked_address(arg0, v1, 0x2::tx_context::sender(arg7));
        let v2 = ProfileCreated{
            profile_id : 0x2::object::id<Profile>(&v0),
            owner      : 0x2::tx_context::sender(arg7),
            by         : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<ProfileCreated>(v2);
        v0
    }

    fun internal_delete_link_address_request(arg0: LinkAddressRquest, arg1: &0x2::tx_context::TxContext) {
        let v0 = LinkAddressRequestDeleted{
            link_address_request_id : 0x2::object::id<LinkAddressRquest>(&arg0),
            profile_id              : arg0.profile_id,
            requester               : arg0.requester,
            by                      : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<LinkAddressRequestDeleted>(v0);
        let LinkAddressRquest {
            id         : v1,
            profile_id : _,
            requester  : _,
        } = arg0;
        0x2::object::delete(v1);
    }

    fun internal_delete_profile(arg0: &mut ProfileManager, arg1: Profile, arg2: &0x2::tx_context::TxContext) {
        let v0 = ProfileDeleted{
            profile_id : 0x2::object::id<Profile>(&arg1),
            owner      : arg1.owner,
            by         : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ProfileDeleted>(v0);
        let v1 = 0;
        loop {
            if (v1 >= 0x1::vector::length<address>(&arg1.linked_addresses)) {
                break
            };
            let v2 = &mut arg1;
            internal_remove_linked_address(arg0, v2, *0x1::vector::borrow<address>(&arg1.linked_addresses, v1));
            v1 = v1 + 1;
        };
        let Profile {
            id               : v3,
            owner            : _,
            linked_addresses : _,
            avatar_url       : _,
            background_url   : _,
            display_name     : _,
            description      : _,
            data             : _,
            links            : _,
            creator          : _,
            created_at       : _,
            updated_at       : _,
        } = arg1;
        0x2::object::delete(v3);
    }

    fun internal_get_address_linked_profile_id(arg0: &ProfileManager, arg1: address) : 0x2::object::ID {
        0x2::table::borrow<address, LinkedAddressWrapper>(&arg0.linked_addresses, arg1).profile_id
    }

    fun internal_remove_linked_address(arg0: &mut ProfileManager, arg1: &mut Profile, arg2: address) {
        assert_is_address_linked(arg0, arg2);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg1.linked_addresses, &arg2);
        assert!(v0, 0x4e2577e500fc78bf991bb24dadfe889c8a58e79de0afd01e68bcd2f412f6facd::error::not_authorized_error());
        0x1::vector::remove<address>(&mut arg1.linked_addresses, v1);
        let v2 = 0x2::table::remove<address, LinkedAddressWrapper>(&mut arg0.linked_addresses, arg2);
        assert!(0x2::object::uid_to_inner(&arg1.id) == v2.profile_id, 0x4e2577e500fc78bf991bb24dadfe889c8a58e79de0afd01e68bcd2f412f6facd::error::not_authorized_error());
    }

    public fun is_address_linked(arg0: &ProfileManager, arg1: address) : bool {
        0x2::table::contains<address, LinkedAddressWrapper>(&arg0.linked_addresses, arg1)
    }

    public fun is_address_profile_overlap_with_others(arg0: &ProfileManager, arg1: address, arg2: vector<address>) : bool {
        let v0 = 0;
        loop {
            if (v0 >= 0x1::vector::length<address>(&arg2)) {
                break
            };
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            if (is_address_linked(arg0, v1) && internal_get_address_linked_profile_id(arg0, arg1) == internal_get_address_linked_profile_id(arg0, v1)) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun is_addresses_in_same_profile(arg0: &ProfileManager, arg1: address, arg2: address) : bool {
        if (is_address_linked(arg0, arg1) == false || is_address_linked(arg0, arg2) == false) {
            return false
        };
        internal_get_address_linked_profile_id(arg0, arg1) == internal_get_address_linked_profile_id(arg0, arg2)
    }

    public fun is_profile_manager_admin(arg0: &ProfileManager, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.admins, &arg1)
    }

    public fun profile_manager_add_admin(arg0: &mut ProfileManager, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_profile_manager_admin(arg0, 0x2::tx_context::sender(arg2));
        assert!(!0x1::vector::contains<address>(&arg0.admins, &arg1), 0x4e2577e500fc78bf991bb24dadfe889c8a58e79de0afd01e68bcd2f412f6facd::error::duplicated_error());
        0x1::vector::push_back<address>(&mut arg0.admins, arg1);
        let v0 = ProfileManagerAdminAdded{
            new_admin : arg1,
            by        : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ProfileManagerAdminAdded>(v0);
    }

    public fun profile_manager_remove_admin(arg0: &mut ProfileManager, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_profile_manager_admin(arg0, 0x2::tx_context::sender(arg2));
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.admins, &arg1);
        assert!(v0 && 0x1::vector::length<address>(&arg0.admins) > 1, 0x4e2577e500fc78bf991bb24dadfe889c8a58e79de0afd01e68bcd2f412f6facd::error::not_authorized_error());
        0x1::vector::swap_remove<address>(&mut arg0.admins, v1);
        let v2 = ProfileManagerAdminRemoved{
            removed_admin : arg1,
            by            : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ProfileManagerAdminRemoved>(v2);
    }

    public fun remove_link_from_profile(arg0: &mut Profile, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x1::vector::remove<Link>(&mut arg0.links, arg1);
    }

    public fun remove_linked_address_from_profile(arg0: &mut ProfileManager, arg1: &mut Profile, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        internal_remove_linked_address(arg0, arg1, arg2);
        let v0 = LinkedAddressRemoved{
            profile_id     : 0x2::object::id<Profile>(arg1),
            linked_address : arg2,
            by             : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<LinkedAddressRemoved>(v0);
    }

    public fun reorder_links_in_prilfe(arg0: &mut Profile, arg1: vector<u64>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<Link>();
        let v1 = 0;
        loop {
            if (v1 >= 0x1::vector::length<Link>(&arg0.links)) {
                break
            };
            0x1::vector::push_back<Link>(&mut v0, *0x1::vector::borrow<Link>(&arg0.links, *0x1::vector::borrow<u64>(&arg1, v1)));
            v1 = v1 + 1;
        };
        arg0.links = v0;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
    }

    public fun replace_links_in_prilfe(arg0: &mut Profile, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<Link>();
        let v1 = 0;
        loop {
            if (v1 >= 0x1::vector::length<0x1::string::String>(&arg1)) {
                break
            };
            let v2 = Link{
                name : *0x1::vector::borrow<0x1::string::String>(&arg1, v1),
                icon : *0x1::vector::borrow<0x1::string::String>(&arg2, v1),
                url  : *0x1::vector::borrow<0x1::string::String>(&arg3, v1),
                data : *0x1::vector::borrow<0x1::string::String>(&arg4, v1),
            };
            0x1::vector::push_back<Link>(&mut v0, v2);
            v1 = v1 + 1;
        };
        arg0.links = v0;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg5);
    }

    public fun transfer_profile_ownership(arg0: Profile, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::contains<address>(&arg0.linked_addresses, &arg1), 0x4e2577e500fc78bf991bb24dadfe889c8a58e79de0afd01e68bcd2f412f6facd::error::not_authorized_error());
        arg0.owner = arg1;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
        let v0 = ProfileOwnershipTransferred{
            profile_id : 0x2::object::id<Profile>(&arg0),
            old_owner  : 0x2::tx_context::sender(arg3),
            new_owner  : arg1,
            by         : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ProfileOwnershipTransferred>(v0);
        0x2::transfer::transfer<Profile>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

