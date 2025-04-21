module 0x3d4be8ba1c1a1ff8cdd41e0bdb04da961a96ccfdfbe7b8ebe7e4fe1eda72d55d::static_collectible {
    struct StaticCollectible has store {
        creator: address,
        number: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        parent_type: 0x1::type_name::TypeName,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        image: 0x1::string::String,
        animation_url: 0x1::string::String,
        external_url: 0x1::string::String,
    }

    struct StaticCollectibleCreatedEvent has copy, drop {
        parent_type: 0x1::type_name::TypeName,
        collectible_number: u64,
    }

    struct StaticCollectibleDestroyedEvent has copy, drop {
        parent_type: 0x1::type_name::TypeName,
        collectible_number: u64,
    }

    struct StaticCollectibleRevealedEvent has copy, drop {
        parent_type: 0x1::type_name::TypeName,
        collectible_number: u64,
        attribute_keys: vector<0x1::string::String>,
        attribute_values: vector<0x1::string::String>,
    }

    public fun animation_url(arg0: &StaticCollectible) : 0x1::string::String {
        arg0.animation_url
    }

    public fun attributes(arg0: &StaticCollectible) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        arg0.attributes
    }

    public fun creator(arg0: &StaticCollectible) : address {
        arg0.creator
    }

    public fun description(arg0: &StaticCollectible) : 0x1::string::String {
        arg0.description
    }

    public fun destroy(arg0: StaticCollectible) {
        let StaticCollectible {
            creator       : _,
            number        : v1,
            name          : _,
            description   : _,
            parent_type   : v4,
            attributes    : _,
            image         : _,
            animation_url : _,
            external_url  : _,
        } = arg0;
        let v9 = StaticCollectibleDestroyedEvent{
            parent_type        : v4,
            collectible_number : v1,
        };
        0x2::event::emit<StaticCollectibleDestroyedEvent>(v9);
    }

    public fun external_url(arg0: &StaticCollectible) : 0x1::string::String {
        arg0.external_url
    }

    public fun image(arg0: &StaticCollectible) : 0x1::string::String {
        arg0.image
    }

    public fun name(arg0: &StaticCollectible) : 0x1::string::String {
        arg0.name
    }

    public fun new<T0>(arg0: &0x2::package::Publisher, arg1: address, arg2: 0x1::string::String, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String) : StaticCollectible {
        assert!(0x2::package::from_module<T0>(arg0), 10000);
        let v0 = StaticCollectible{
            creator       : arg1,
            number        : arg3,
            name          : arg2,
            description   : arg4,
            parent_type   : 0x1::type_name::get<T0>(),
            attributes    : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
            image         : arg5,
            animation_url : arg6,
            external_url  : arg7,
        };
        let v1 = StaticCollectibleCreatedEvent{
            parent_type        : v0.parent_type,
            collectible_number : v0.number,
        };
        0x2::event::emit<StaticCollectibleCreatedEvent>(v1);
        v0
    }

    public fun number(arg0: &StaticCollectible) : u64 {
        arg0.number
    }

    public fun parent_type(arg0: &StaticCollectible) : 0x1::type_name::TypeName {
        arg0.parent_type
    }

    public fun reveal(arg0: &mut StaticCollectible, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>) {
        assert!(0x1::vector::length<0x1::string::String>(&arg1) == 0x1::vector::length<0x1::string::String>(&arg2), 20000);
        let v0 = StaticCollectibleRevealedEvent{
            parent_type        : arg0.parent_type,
            collectible_number : arg0.number,
            attribute_keys     : arg1,
            attribute_values   : arg2,
        };
        0x2::event::emit<StaticCollectibleRevealedEvent>(v0);
        arg0.attributes = 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

