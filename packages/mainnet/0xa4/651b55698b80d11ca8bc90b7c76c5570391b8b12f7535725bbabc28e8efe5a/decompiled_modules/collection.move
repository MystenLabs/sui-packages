module 0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::collection {
    struct Witness has drop {
        dummy_field: bool,
    }

    struct Collection<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct MintCollectionEvent has copy, drop {
        collection_id: 0x2::object::ID,
        type_name: 0x1::type_name::TypeName,
    }

    public entry fun delete<T0>(arg0: Collection<T0>) {
        let Collection {
            id      : v0,
            version : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun new_display<T0: store + key>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::frozen_publisher::FrozenPublisher, arg2: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<Collection<T0>> {
        let v0 = Witness{dummy_field: false};
        let v1 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::frozen_publisher::new_display<Witness, Collection<T0>>(v0, arg1, arg2);
        0x2::display::add<Collection<T0>>(&mut v1, 0x1::string::utf8(b"type"), 0x1::string::utf8(b"Collection"));
        v1
    }

    public fun add_domain<T0, T1: store>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut Collection<T0>, arg2: T1) {
        assert_version_and_upgrade<T0>(arg1);
        assert_no_domain<T0, T1>(arg1);
        0x2::dynamic_field::add<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<T1>, T1>(borrow_uid_mut<T0>(arg0, arg1), 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<T1>(), arg2);
    }

    public fun assert_domain<T0, T1: store>(arg0: &Collection<T0>) {
        assert!(has_domain<T0, T1>(arg0), 1);
    }

    public fun assert_no_domain<T0, T1: store>(arg0: &Collection<T0>) {
        assert!(!has_domain<T0, T1>(arg0), 2);
    }

    fun assert_version<T0>(arg0: &Collection<T0>) {
        assert!(arg0.version == 2, 1000);
    }

    fun assert_version_and_upgrade<T0>(arg0: &mut Collection<T0>) {
        if (arg0.version < 2) {
            arg0.version = 2;
        };
        assert_version<T0>(arg0);
    }

    public fun borrow_domain<T0, T1: store>(arg0: &Collection<T0>) : &T1 {
        assert_domain<T0, T1>(arg0);
        0x2::dynamic_field::borrow<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<T1>, T1>(&arg0.id, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<T1>())
    }

    public fun borrow_domain_mut<T0, T1: store>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T1>, arg1: &mut Collection<T0>) : &mut T1 {
        assert_version_and_upgrade<T0>(arg1);
        assert_domain<T0, T1>(arg1);
        0x2::dynamic_field::borrow_mut<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<T1>, T1>(&mut arg1.id, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<T1>())
    }

    public fun borrow_uid<T0>(arg0: &Collection<T0>) : &0x2::object::UID {
        &arg0.id
    }

    public fun borrow_uid_mut<T0>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut Collection<T0>) : &mut 0x2::object::UID {
        assert_version_and_upgrade<T0>(arg1);
        &mut arg1.id
    }

    public fun create<T0>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut 0x2::tx_context::TxContext) : Collection<T0> {
        create_<T0>(arg1)
    }

    fun create_<T0>(arg0: &mut 0x2::tx_context::TxContext) : Collection<T0> {
        let v0 = 0x2::object::new(arg0);
        let v1 = MintCollectionEvent{
            collection_id : 0x2::object::uid_to_inner(&v0),
            type_name     : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<MintCollectionEvent>(v1);
        Collection<T0>{
            id      : v0,
            version : 2,
        }
    }

    public fun create_from_otw<T0: drop, T1>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) : Collection<T1> {
        0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::assert_same_module<T0, T1>();
        create_<T1>(arg1)
    }

    public fun create_with_mint_cap<T0: drop, T1>(arg0: &T0, arg1: 0x1::option::Option<u64>, arg2: &mut 0x2::tx_context::TxContext) : (Collection<T1>, 0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::mint_cap::MintCap<T1>) {
        let v0 = create_from_otw<T0, T1>(arg0, arg2);
        (v0, 0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::mint_cap::new<T0, T1>(arg0, 0x2::object::id<Collection<T1>>(&v0), arg1, arg2))
    }

    public fun has_domain<T0, T1: store>(arg0: &Collection<T0>) : bool {
        0x2::dynamic_field::exists_with_type<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<T1>, T1>(&arg0.id, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<T1>())
    }

    public fun init_collection<T0>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = create<T0>(arg0, arg1);
        0x2::transfer::public_share_object<Collection<T0>>(v0);
        0x2::object::id<Collection<T0>>(&v0)
    }

    entry fun migrate_as_creator<T0: store + key>(arg0: &mut Collection<T0>, arg1: &0x2::package::Publisher) {
        assert!(0x2::package::from_package<T0>(arg1), 0);
        arg0.version = 2;
    }

    public fun remove_domain<T0, T1: store>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut Collection<T0>) : T1 {
        assert_version_and_upgrade<T0>(arg1);
        assert_domain<T0, T1>(arg1);
        0x2::dynamic_field::remove<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<T1>, T1>(&mut arg1.id, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<T1>())
    }

    // decompiled from Move bytecode v6
}

