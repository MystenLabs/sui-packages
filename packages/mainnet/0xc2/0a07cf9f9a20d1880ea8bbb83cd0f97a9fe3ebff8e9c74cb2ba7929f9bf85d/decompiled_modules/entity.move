module 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::entity {
    struct NewEntityEvent has copy, drop {
        resource: 0x1::option::Option<address>,
        target: address,
    }

    struct Ent has copy, drop, store {
        description: 0x1::string::String,
        info: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        resource: 0x1::option::Option<address>,
        like: u32,
        dislike: u32,
        time: u64,
    }

    public fun ENTITY_AVATAR() : vector<u8> {
        b"avatar"
    }

    public fun ENTITY_Dislike() : vector<u8> {
        b"dislike"
    }

    public fun ENTITY_LOCATION() : vector<u8> {
        b"location"
    }

    public fun ENTITY_Like() : vector<u8> {
        b"like"
    }

    public fun ENTITY_NAME() : vector<u8> {
        b"name"
    }

    public fun Ent_description_set(arg0: &mut Ent, arg1: &0x1::string::String) {
        arg0.description = *arg1;
    }

    public fun Ent_dislike(arg0: &Ent) : u32 {
        arg0.dislike
    }

    public fun Ent_dislike_set(arg0: &mut Ent, arg1: bool) : u32 {
        if (arg1) {
            arg0.dislike = arg0.dislike + 1;
        } else if (arg0.dislike != 0) {
            arg0.dislike = arg0.dislike - 1;
        };
        arg0.dislike
    }

    public fun Ent_info_get(arg0: &Ent, arg1: &0x1::string::String) : 0x1::string::String {
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.info, arg1)) {
            return *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&arg0.info, arg1)
        };
        0x1::string::utf8(b"")
    }

    public fun Ent_info_remove(arg0: &mut Ent, arg1: &vector<0x1::string::String>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(arg1)) {
            let v1 = 0x1::vector::borrow<0x1::string::String>(arg1, v0);
            if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.info, v1)) {
                let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg0.info, v1);
            };
            v0 = v0 + 1;
        };
    }

    public fun Ent_info_removeall(arg0: &mut Ent) {
        arg0.info = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
    }

    public fun Ent_info_set(arg0: &mut Ent, arg1: &vector<0x1::string::String>, arg2: &vector<0x1::string::String>) {
        let v0 = &mut arg0.info;
        add_info(v0, arg1, arg2);
    }

    public fun Ent_like(arg0: &Ent) : u32 {
        arg0.like
    }

    public fun Ent_like_set(arg0: &mut Ent, arg1: bool) : u32 {
        if (arg1) {
            arg0.like = arg0.like + 1;
        } else if (arg0.like != 0) {
            arg0.like = arg0.like - 1;
        };
        arg0.like
    }

    public fun Ent_new1(arg0: &0x1::option::Option<address>, arg1: &0x2::clock::Clock) : Ent {
        Ent{
            description : 0x1::string::utf8(b""),
            info        : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
            resource    : *arg0,
            like        : 0,
            dislike     : 0,
            time        : 0x2::clock::timestamp_ms(arg1),
        }
    }

    public fun Ent_new2(arg0: &0x1::option::Option<address>, arg1: &0x1::string::String, arg2: &0x2::clock::Clock) : Ent {
        Ent{
            description : *arg1,
            info        : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
            resource    : *arg0,
            like        : 0,
            dislike     : 0,
            time        : 0x2::clock::timestamp_ms(arg2),
        }
    }

    public fun Ent_new3(arg0: u32, arg1: u32, arg2: &0x2::clock::Clock) : Ent {
        Ent{
            description : 0x1::string::utf8(b""),
            info        : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
            resource    : 0x1::option::none<address>(),
            like        : arg0,
            dislike     : arg1,
            time        : 0x2::clock::timestamp_ms(arg2),
        }
    }

    public fun Ent_new4(arg0: &0x1::option::Option<address>, arg1: &vector<0x1::string::String>, arg2: &vector<0x1::string::String>, arg3: &0x2::clock::Clock) : Ent {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v1 = &mut v0;
        add_info(v1, arg1, arg2);
        Ent{
            description : 0x1::string::utf8(b""),
            info        : v0,
            resource    : *arg0,
            like        : 0,
            dislike     : 0,
            time        : 0x2::clock::timestamp_ms(arg3),
        }
    }

    public fun Ent_resource(arg0: &Ent) : 0x1::option::Option<address> {
        arg0.resource
    }

    public fun Ent_resource_clear(arg0: &mut Ent, arg1: &address) {
        if (0x1::option::is_some<address>(&arg0.resource) && *0x1::option::borrow<address>(&arg0.resource) == *arg1) {
            arg0.resource = 0x1::option::none<address>();
        };
    }

    public fun Ent_resource_set(arg0: &mut Ent, arg1: &0x1::option::Option<address>) {
        arg0.resource = *arg1;
    }

    public fun Ent_size(arg0: &Ent) : u64 {
        0x2::vec_map::size<0x1::string::String, 0x1::string::String>(&arg0.info)
    }

    public fun Ent_time(arg0: &Ent) : u64 {
        arg0.time
    }

    public fun INFO_LENGTH(arg0: u64) {
        assert!(arg0 <= 32, 1302);
    }

    public fun KEY_VALUE_LENGTH_NOT_MATCH(arg0: bool) {
        assert!(arg0, 1301);
    }

    public fun NewEntityEvent_emit(arg0: &0x1::option::Option<address>, arg1: &address) {
        let v0 = NewEntityEvent{
            resource : *arg0,
            target   : *arg1,
        };
        0x2::event::emit<NewEntityEvent>(v0);
    }

    public fun RESOURCE_EXISTED(arg0: &0x1::option::Option<address>) {
        assert!(0x1::option::is_none<address>(arg0), 1300);
    }

    fun add_info(arg0: &mut 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg1: &vector<0x1::string::String>, arg2: &vector<0x1::string::String>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(arg1)) {
            let v1 = 0x1::vector::borrow<0x1::string::String>(arg1, v0);
            let v2 = 0x1::vector::borrow<0x1::string::String>(arg2, v0);
            0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::ASSERT_NAMELEN(v1);
            0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::ASSERT_SERVICE_ITEM_NAME(v2);
            if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(arg0, v1)) {
                *0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(arg0, v1) = *v2;
            } else {
                INFO_LENGTH(0x2::vec_map::size<0x1::string::String, 0x1::string::String>(arg0) + 1);
                0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(arg0, *v1, *v2);
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

