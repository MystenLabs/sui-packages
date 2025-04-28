module 0x4b7cb24338e32681bcde8e39a913cd3e9142a723bd98b46db09cd2248b43ed59::basecamp25_badge {
    struct Badge has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        link: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        project_url: 0x1::string::String,
        creator: 0x1::string::String,
        key: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct BadgeMinted has copy, drop {
        badge_id: 0x2::object::ID,
        recipient: address,
        key: 0x1::string::String,
    }

    public fun attributes(arg0: &Badge) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        arg0.attributes
    }

    public fun creator(arg0: &Badge) : 0x1::string::String {
        arg0.creator
    }

    public fun description(arg0: &Badge) : 0x1::string::String {
        arg0.description
    }

    public fun id(arg0: &Badge) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun image_url(arg0: &Badge) : 0x1::string::String {
        arg0.image_url
    }

    public fun key(arg0: &Badge) : 0x1::string::String {
        arg0.key
    }

    public fun link(arg0: &Badge) : 0x1::string::String {
        arg0.link
    }

    public fun mint(arg0: &0x4b7cb24338e32681bcde8e39a913cd3e9142a723bd98b46db09cd2248b43ed59::registry::WhiteListMintRegistry, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x4b7cb24338e32681bcde8e39a913cd3e9142a723bd98b46db09cd2248b43ed59::registry::is_whitelisted(arg0, 0x2::tx_context::sender(arg10)), 0);
        let v0 = 0x2::object::new(arg10);
        let v1 = BadgeMinted{
            badge_id  : 0x2::object::uid_to_inner(&v0),
            recipient : arg1,
            key       : arg8,
        };
        0x2::event::emit<BadgeMinted>(v1);
        let v2 = Badge{
            id          : v0,
            name        : arg2,
            link        : arg3,
            image_url   : arg4,
            description : arg5,
            project_url : arg6,
            creator     : arg7,
            key         : arg8,
            attributes  : arg9,
        };
        0x2::transfer::transfer<Badge>(v2, arg1);
    }

    public fun name(arg0: &Badge) : 0x1::string::String {
        arg0.name
    }

    public fun project_url(arg0: &Badge) : 0x1::string::String {
        arg0.project_url
    }

    // decompiled from Move bytecode v6
}

