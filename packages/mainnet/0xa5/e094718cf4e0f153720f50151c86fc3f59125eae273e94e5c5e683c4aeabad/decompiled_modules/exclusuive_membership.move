module 0xa5e094718cf4e0f153720f50151c86fc3f59125eae273e94e5c5e683c4aeabad::exclusuive_membership {
    struct MembershipType has copy, drop, store {
        community_id: 0x2::object::ID,
        membership_name: 0x1::string::String,
        membership_description: 0x1::string::String,
        allow_user_mint: bool,
        allow_transfer: bool,
        version: u64,
    }

    struct Membership has store, key {
        id: 0x2::object::UID,
        community_id: 0x2::object::ID,
        membership_name: 0x1::string::String,
        membership_description: 0x1::string::String,
        allow_user_mint: bool,
        allow_transfer: bool,
        image_url: 0x1::string::String,
        version: u64,
    }

    struct MembershipTypeKey<phantom T0: copy + drop + store> has copy, drop, store {
        community_id: 0x2::object::ID,
        membership_name: 0x1::string::String,
    }

    struct EXCLUSUIVE_MEMBERSHIP has drop {
        dummy_field: bool,
    }

    struct MembershipMinted has copy, drop {
        id: 0x2::object::ID,
        membership_name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    public fun transfer(arg0: Membership, arg1: address) {
        assert!(arg0.allow_transfer, 1);
        0x2::transfer::public_transfer<Membership>(arg0, arg1);
    }

    public(friend) fun community_id(arg0: &Membership) : 0x2::object::ID {
        arg0.community_id
    }

    public fun get_membership_name(arg0: &Membership) : 0x1::string::String {
        arg0.membership_name
    }

    public(friend) fun get_mut_uid_membership(arg0: &mut Membership) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun get_uid_membership(arg0: &Membership) : &0x2::object::UID {
        &arg0.id
    }

    fun init(arg0: EXCLUSUIVE_MEMBERSHIP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{membership_name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{membership_description}"));
        let v4 = 0x2::package::claim<EXCLUSUIVE_MEMBERSHIP>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Membership>(&v4, v0, v2, arg1);
        0x2::display::update_version<Membership>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Membership>>(v5, 0x2::tx_context::sender(arg1));
    }

    entry fun mint_membership(arg0: &mut 0xa5e094718cf4e0f153720f50151c86fc3f59125eae273e94e5c5e683c4aeabad::community::Community, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<Membership>(new_membership(arg0, arg1, arg2, arg4), arg3);
    }

    public fun new_membership(arg0: &mut 0xa5e094718cf4e0f153720f50151c86fc3f59125eae273e94e5c5e683c4aeabad::community::Community, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : Membership {
        let v0 = MembershipTypeKey<MembershipType>{
            community_id    : 0x2::object::id<0xa5e094718cf4e0f153720f50151c86fc3f59125eae273e94e5c5e683c4aeabad::community::Community>(arg0),
            membership_name : arg1,
        };
        assert!(0x2::dynamic_field::exists_<MembershipTypeKey<MembershipType>>(0xa5e094718cf4e0f153720f50151c86fc3f59125eae273e94e5c5e683c4aeabad::community::get_uid(arg0), v0), 3);
        let v1 = MembershipTypeKey<MembershipType>{
            community_id    : 0x2::object::id<0xa5e094718cf4e0f153720f50151c86fc3f59125eae273e94e5c5e683c4aeabad::community::Community>(arg0),
            membership_name : arg1,
        };
        let v2 = 0x2::dynamic_field::borrow<MembershipTypeKey<MembershipType>, MembershipType>(0xa5e094718cf4e0f153720f50151c86fc3f59125eae273e94e5c5e683c4aeabad::community::get_uid(arg0), v1);
        assert!(0xa5e094718cf4e0f153720f50151c86fc3f59125eae273e94e5c5e683c4aeabad::community::has_permission<0xa5e094718cf4e0f153720f50151c86fc3f59125eae273e94e5c5e683c4aeabad::community::MembershipManager>(arg0, 0x2::tx_context::sender(arg3)) || v2.allow_user_mint, 1);
        let v3 = 0x2::object::new(arg3);
        let v4 = MembershipMinted{
            id              : 0x2::object::uid_to_inner(&v3),
            membership_name : arg1,
            image_url       : arg2,
        };
        0x2::event::emit<MembershipMinted>(v4);
        Membership{
            id                     : v3,
            community_id           : 0x2::object::id<0xa5e094718cf4e0f153720f50151c86fc3f59125eae273e94e5c5e683c4aeabad::community::Community>(arg0),
            membership_name        : arg1,
            membership_description : v2.membership_description,
            allow_user_mint        : v2.allow_user_mint,
            allow_transfer         : v2.allow_transfer,
            image_url              : arg2,
            version                : 0,
        }
    }

    public fun new_membership_type(arg0: &mut 0xa5e094718cf4e0f153720f50151c86fc3f59125eae273e94e5c5e683c4aeabad::community::Community, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: bool, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0xa5e094718cf4e0f153720f50151c86fc3f59125eae273e94e5c5e683c4aeabad::community::Community>(arg0);
        assert!(0xa5e094718cf4e0f153720f50151c86fc3f59125eae273e94e5c5e683c4aeabad::community::has_permission<0xa5e094718cf4e0f153720f50151c86fc3f59125eae273e94e5c5e683c4aeabad::community::MembershipManager>(arg0, 0x2::tx_context::sender(arg5)), 1);
        let v1 = MembershipTypeKey<MembershipType>{
            community_id    : v0,
            membership_name : arg1,
        };
        assert!(!0x2::dynamic_field::exists_<MembershipTypeKey<MembershipType>>(0xa5e094718cf4e0f153720f50151c86fc3f59125eae273e94e5c5e683c4aeabad::community::get_uid(arg0), v1), 2);
        let v2 = MembershipTypeKey<MembershipType>{
            community_id    : v0,
            membership_name : arg1,
        };
        let v3 = MembershipType{
            community_id           : v0,
            membership_name        : arg1,
            membership_description : arg2,
            allow_user_mint        : arg3,
            allow_transfer         : arg4,
            version                : 0,
        };
        0x2::dynamic_field::add<MembershipTypeKey<MembershipType>, MembershipType>(0xa5e094718cf4e0f153720f50151c86fc3f59125eae273e94e5c5e683c4aeabad::community::get_mut_uid(arg0), v2, v3);
        0xa5e094718cf4e0f153720f50151c86fc3f59125eae273e94e5c5e683c4aeabad::community::update_version(arg0);
    }

    public fun update_membership(arg0: &mut 0xa5e094718cf4e0f153720f50151c86fc3f59125eae273e94e5c5e683c4aeabad::community::Community, arg1: &mut Membership, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xa5e094718cf4e0f153720f50151c86fc3f59125eae273e94e5c5e683c4aeabad::community::has_permission<0xa5e094718cf4e0f153720f50151c86fc3f59125eae273e94e5c5e683c4aeabad::community::MembershipManager>(arg0, 0x2::tx_context::sender(arg2)), 1);
        let v0 = MembershipTypeKey<MembershipType>{
            community_id    : 0x2::object::id<0xa5e094718cf4e0f153720f50151c86fc3f59125eae273e94e5c5e683c4aeabad::community::Community>(arg0),
            membership_name : arg1.membership_name,
        };
        assert!(0x2::dynamic_field::exists_<MembershipTypeKey<MembershipType>>(0xa5e094718cf4e0f153720f50151c86fc3f59125eae273e94e5c5e683c4aeabad::community::get_uid(arg0), v0), 3);
        let v1 = MembershipTypeKey<MembershipType>{
            community_id    : 0x2::object::id<0xa5e094718cf4e0f153720f50151c86fc3f59125eae273e94e5c5e683c4aeabad::community::Community>(arg0),
            membership_name : arg1.membership_name,
        };
        let v2 = 0x2::dynamic_field::borrow<MembershipTypeKey<MembershipType>, MembershipType>(0xa5e094718cf4e0f153720f50151c86fc3f59125eae273e94e5c5e683c4aeabad::community::get_uid(arg0), v1);
        arg1.allow_user_mint = v2.allow_user_mint;
        arg1.membership_description = v2.membership_description;
        arg1.allow_transfer = v2.allow_transfer;
        arg1.version = v2.version;
    }

    public fun update_membership_type(arg0: &mut 0xa5e094718cf4e0f153720f50151c86fc3f59125eae273e94e5c5e683c4aeabad::community::Community, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: bool, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0xa5e094718cf4e0f153720f50151c86fc3f59125eae273e94e5c5e683c4aeabad::community::Community>(arg0);
        assert!(0xa5e094718cf4e0f153720f50151c86fc3f59125eae273e94e5c5e683c4aeabad::community::has_permission<0xa5e094718cf4e0f153720f50151c86fc3f59125eae273e94e5c5e683c4aeabad::community::MembershipManager>(arg0, 0x2::tx_context::sender(arg5)), 1);
        let v1 = MembershipTypeKey<MembershipType>{
            community_id    : v0,
            membership_name : arg1,
        };
        assert!(0x2::dynamic_field::exists_<MembershipTypeKey<MembershipType>>(0xa5e094718cf4e0f153720f50151c86fc3f59125eae273e94e5c5e683c4aeabad::community::get_uid(arg0), v1), 3);
        let v2 = MembershipTypeKey<MembershipType>{
            community_id    : v0,
            membership_name : arg1,
        };
        let v3 = 0x2::dynamic_field::borrow_mut<MembershipTypeKey<MembershipType>, MembershipType>(0xa5e094718cf4e0f153720f50151c86fc3f59125eae273e94e5c5e683c4aeabad::community::get_mut_uid(arg0), v2);
        v3.allow_user_mint = arg3;
        v3.membership_description = arg2;
        v3.allow_transfer = arg4;
        v3.version = v3.version + 1;
        0xa5e094718cf4e0f153720f50151c86fc3f59125eae273e94e5c5e683c4aeabad::community::update_version(arg0);
    }

    // decompiled from Move bytecode v6
}

