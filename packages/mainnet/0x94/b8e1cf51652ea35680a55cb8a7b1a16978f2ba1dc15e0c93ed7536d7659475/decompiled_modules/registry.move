module 0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::registry {
    struct REGISTRY has drop {
        dummy_field: bool,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
        kinds: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
        featured: 0x2::table::Table<0x1::type_name::TypeName, Feature>,
    }

    struct Feature has copy, drop, store {
        name: 0x1::string::String,
        url: 0x1::string::String,
        proposer: address,
        approved: bool,
        collection: 0x1::option::Option<0x2::object::ID>,
    }

    public fun remove<T0: key>(arg0: &0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::platform::AdminCap, arg1: &mut Registry) {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Feature>(&arg1.featured, v0), 154);
        0x2::table::remove<0x1::type_name::TypeName, Feature>(&mut arg1.featured, v0);
        0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::events::feature_removed(v0, true);
    }

    public fun feature_approved(arg0: &Feature) : bool {
        arg0.approved
    }

    public(friend) fun add_featured(arg0: &mut Registry, arg1: 0x1::type_name::TypeName, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: address, arg5: 0x1::option::Option<0x2::object::ID>) {
        assert!(!0x2::table::contains<0x1::type_name::TypeName, Feature>(&arg0.featured, arg1), 153);
        let v0 = Feature{
            name       : arg2,
            url        : arg3,
            proposer   : arg4,
            approved   : true,
            collection : arg5,
        };
        0x2::table::add<0x1::type_name::TypeName, Feature>(&mut arg0.featured, arg1, v0);
        0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::events::feature_proposed(arg1, arg4, arg2, arg3, arg5);
        0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::events::feature_approved(arg1);
    }

    public fun amend<T0: key>(arg0: &mut Registry, arg1: &0x2::package::Publisher, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        assert!(0x2::package::from_package<T0>(arg1), 152);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Feature>(&arg0.featured, v0), 154);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, Feature>(&mut arg0.featured, v0);
        v1.name = arg2;
        v1.url = arg3;
        v1.approved = false;
        0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::events::feature_proposed(v0, v1.proposer, arg2, arg3, v1.collection);
    }

    public fun approve<T0: key>(arg0: &0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::platform::AdminCap, arg1: &mut Registry) {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Feature>(&arg1.featured, v0), 154);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, Feature>(&mut arg1.featured, v0);
        assert!(!v1.approved, 155);
        v1.approved = true;
        0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::events::feature_approved(v0);
    }

    public(friend) fun claim_kind<T0>(arg0: &mut Registry, arg1: 0x2::object::ID) {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.kinds, v0), 151);
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.kinds, v0, arg1);
    }

    public fun collection_of<T0>(arg0: &Registry) : 0x1::option::Option<0x2::object::ID> {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.kinds, v0)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.kinds, v0))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun feature<T0>(arg0: &Registry) : 0x1::option::Option<Feature> {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, Feature>(&arg0.featured, v0)) {
            0x1::option::some<Feature>(*0x2::table::borrow<0x1::type_name::TypeName, Feature>(&arg0.featured, v0))
        } else {
            0x1::option::none<Feature>()
        }
    }

    public fun feature_collection(arg0: &Feature) : 0x1::option::Option<0x2::object::ID> {
        arg0.collection
    }

    public fun feature_name(arg0: &Feature) : 0x1::string::String {
        arg0.name
    }

    public fun feature_url(arg0: &Feature) : 0x1::string::String {
        arg0.url
    }

    fun init(arg0: REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id        : 0x2::object::new(arg1),
            publisher : 0x2::package::claim<REGISTRY>(arg0, arg1),
            kinds     : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg1),
            featured  : 0x2::table::new<0x1::type_name::TypeName, Feature>(arg1),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun is_featured<T0>(arg0: &Registry) : bool {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        0x2::table::contains<0x1::type_name::TypeName, Feature>(&arg0.featured, v0) && 0x2::table::borrow<0x1::type_name::TypeName, Feature>(&arg0.featured, v0).approved
    }

    public fun propose<T0: key>(arg0: &mut Registry, arg1: &0x2::package::Publisher, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<T0>(arg1), 152);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, Feature>(&arg0.featured, v0), 153);
        let v1 = Feature{
            name       : arg2,
            url        : arg3,
            proposer   : 0x2::tx_context::sender(arg4),
            approved   : false,
            collection : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::table::add<0x1::type_name::TypeName, Feature>(&mut arg0.featured, v0, v1);
        0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::events::feature_proposed(v0, 0x2::tx_context::sender(arg4), arg2, arg3, 0x1::option::none<0x2::object::ID>());
    }

    public(friend) fun publisher(arg0: &Registry) : &0x2::package::Publisher {
        &arg0.publisher
    }

    public fun withdraw<T0: key>(arg0: &mut Registry, arg1: &0x2::package::Publisher) {
        assert!(0x2::package::from_package<T0>(arg1), 152);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Feature>(&arg0.featured, v0), 154);
        0x2::table::remove<0x1::type_name::TypeName, Feature>(&mut arg0.featured, v0);
        0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::events::feature_removed(v0, false);
    }

    // decompiled from Move bytecode v7
}

