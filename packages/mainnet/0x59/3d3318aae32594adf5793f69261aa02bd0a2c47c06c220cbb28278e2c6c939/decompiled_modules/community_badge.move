module 0x593d3318aae32594adf5793f69261aa02bd0a2c47c06c220cbb28278e2c6c939::community_badge {
    struct CommunityBadge has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct IssueCap has store, key {
        id: 0x2::object::UID,
    }

    struct COMMUNITY_BADGE has drop {
        dummy_field: bool,
    }

    public fun get_description(arg0: &CommunityBadge) : &0x1::string::String {
        &arg0.description
    }

    public fun get_id(arg0: &CommunityBadge) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun get_image_url(arg0: &CommunityBadge) : &0x1::string::String {
        &arg0.image_url
    }

    public fun get_name(arg0: &CommunityBadge) : &0x1::string::String {
        &arg0.name
    }

    fun init(arg0: COMMUNITY_BADGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        let v4 = 0x2::package::claim<COMMUNITY_BADGE>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<CommunityBadge>(&v4, v0, v2, arg1);
        0x2::display::update_version<CommunityBadge>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<CommunityBadge>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = IssueCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<IssueCap>(v6, 0x2::tx_context::sender(arg1));
    }

    public fun issue(arg0: &IssueCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = CommunityBadge{
            id          : 0x2::object::new(arg5),
            name        : arg1,
            description : arg2,
            image_url   : arg3,
        };
        0x2::transfer::transfer<CommunityBadge>(v0, arg4);
    }

    // decompiled from Move bytecode v6
}

