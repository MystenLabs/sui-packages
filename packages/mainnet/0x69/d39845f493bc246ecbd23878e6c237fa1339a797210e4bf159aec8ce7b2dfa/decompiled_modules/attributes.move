module 0x69d39845f493bc246ecbd23878e6c237fa1339a797210e4bf159aec8ce7b2dfa::attributes {
    struct Attribute<T0> has store, key {
        id: 0x2::object::UID,
        image_url: 0x1::option::Option<0x1::string::String>,
        key: 0x1::string::String,
        value: 0x1::string::String,
        meta: 0x1::option::Option<T0>,
        meta_borrowable: bool,
    }

    struct Meta_borrow {
        attribute_id: 0x2::object::ID,
    }

    struct AttributeMinted has copy, drop {
        collection_id: 0x2::object::ID,
        attribute_id: 0x2::object::ID,
        image_url: 0x1::option::Option<0x1::string::String>,
        key: 0x1::string::String,
        value: 0x1::string::String,
    }

    struct AttributeJoined has copy, drop {
        collectible_id: 0x2::object::ID,
        attribute_id: 0x2::object::ID,
    }

    struct AttributeSplit has copy, drop {
        collectible_id: 0x2::object::ID,
        attribute_id: 0x2::object::ID,
    }

    public(friend) fun new<T0: store>(arg0: 0x1::option::Option<0x1::string::String>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x2::object::ID, arg4: 0x1::option::Option<T0>, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : Attribute<T0> {
        let v0 = Attribute<T0>{
            id              : 0x2::object::new(arg6),
            image_url       : arg0,
            key             : arg1,
            value           : arg2,
            meta            : arg4,
            meta_borrowable : arg5,
        };
        let v1 = AttributeMinted{
            collection_id : arg3,
            attribute_id  : 0x2::object::id<Attribute<T0>>(&v0),
            image_url     : arg0,
            key           : arg1,
            value         : arg2,
        };
        0x2::event::emit<AttributeMinted>(v1);
        v0
    }

    public fun borrow_meta<T0: store>(arg0: &mut Attribute<T0>) : (T0, Meta_borrow) {
        let v0 = Meta_borrow{attribute_id: 0x2::object::uid_to_inner(&arg0.id)};
        (0x1::option::extract<T0>(&mut arg0.meta), v0)
    }

    public(friend) fun emit_joined<T0: store>(arg0: &Attribute<T0>, arg1: 0x2::object::ID) {
        let v0 = AttributeJoined{
            collectible_id : arg1,
            attribute_id   : 0x2::object::uid_to_inner(&arg0.id),
        };
        0x2::event::emit<AttributeJoined>(v0);
    }

    public(friend) fun emit_split<T0: store>(arg0: &Attribute<T0>, arg1: 0x2::object::ID) {
        let v0 = AttributeSplit{
            collectible_id : arg1,
            attribute_id   : 0x2::object::uid_to_inner(&arg0.id),
        };
        0x2::event::emit<AttributeSplit>(v0);
    }

    public fun get_attribute_data<T0: store>(arg0: &Attribute<T0>) : (0x1::string::String, 0x1::string::String) {
        (arg0.key, arg0.value)
    }

    public fun get_attribute_image_url<T0: store>(arg0: &Attribute<T0>) : 0x1::option::Option<0x1::string::String> {
        arg0.image_url
    }

    public fun into_key<T0: store>(arg0: &Attribute<T0>) : 0x1::string::String {
        arg0.key
    }

    public fun into_value<T0: store>(arg0: &Attribute<T0>) : 0x1::string::String {
        arg0.value
    }

    public fun return_meta<T0: store>(arg0: &mut Attribute<T0>, arg1: T0, arg2: Meta_borrow) {
        let Meta_borrow { attribute_id: v0 } = arg2;
        assert!(0x2::object::uid_to_inner(&arg0.id) == v0, 0);
        0x1::option::fill<T0>(&mut arg0.meta, arg1);
    }

    // decompiled from Move bytecode v6
}

