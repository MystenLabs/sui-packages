module 0x9346bb5562cd221640e4ad431797149c7cab60bb5b90f8bf19e7079c51cc557b::allowlist {
    struct Allowlist has store, key {
        id: 0x2::object::UID,
        version: u64,
        admin_witness: 0x1::option::Option<0x1::type_name::TypeName>,
        authorities: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct AllowlistOwnerCap has store, key {
        id: 0x2::object::UID,
        for: 0x2::object::ID,
    }

    struct CollectionKey {
        type_name: 0x1::type_name::TypeName,
    }

    struct ALLOWLIST has drop {
        dummy_field: bool,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : (Allowlist, AllowlistOwnerCap) {
        new_with_authorities(0x2::vec_set::empty<0x1::type_name::TypeName>(), arg0)
    }

    public fun assert_admin_witness<T0: drop>(arg0: &Allowlist) {
        assert!(0x1::option::is_some<0x1::type_name::TypeName>(&arg0.admin_witness), 1);
        let v0 = 0x1::type_name::get<T0>();
        assert!(&v0 == 0x1::option::borrow<0x1::type_name::TypeName>(&arg0.admin_witness), 1);
    }

    public fun assert_authority(arg0: &Allowlist, arg1: &0x1::type_name::TypeName) {
        assert!(contains_authority(arg0, arg1), 4);
    }

    public fun assert_cap(arg0: &Allowlist, arg1: &AllowlistOwnerCap) {
        let v0 = 0x2::object::id<Allowlist>(arg0);
        assert!(&arg1.for == &v0, 1);
    }

    public fun assert_collection(arg0: &Allowlist, arg1: 0x1::type_name::TypeName) {
        assert!(contains_collection(arg0, arg1), 2);
    }

    public fun assert_publisher<T0>(arg0: &0x2::package::Publisher) {
        assert!(0x2::package::from_package<T0>(arg0), 0);
    }

    public fun assert_transferable(arg0: &Allowlist, arg1: 0x1::type_name::TypeName, arg2: &0x1::type_name::TypeName) {
        assert_collection(arg0, arg1);
        assert_authority(arg0, arg2);
    }

    fun assert_version(arg0: &Allowlist) {
        assert!(arg0.version == 1, 1000);
    }

    public fun borrow_authorities(arg0: &Allowlist) : &0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        &arg0.authorities
    }

    public fun clone(arg0: &Allowlist, arg1: &mut 0x2::tx_context::TxContext) : (Allowlist, AllowlistOwnerCap) {
        new_with_authorities(*borrow_authorities(arg0), arg1)
    }

    public fun contains_authority(arg0: &Allowlist, arg1: &0x1::type_name::TypeName) : bool {
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.authorities, arg1)
    }

    public fun contains_collection(arg0: &Allowlist, arg1: 0x1::type_name::TypeName) : bool {
        0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, arg1)
    }

    public entry fun delete_allowlist(arg0: Allowlist) {
        assert_version(&arg0);
        let Allowlist {
            id            : v0,
            version       : _,
            admin_witness : _,
            authorities   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun delete_owner_cap(arg0: AllowlistOwnerCap) {
        let AllowlistOwnerCap {
            id  : v0,
            for : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: ALLOWLIST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<ALLOWLIST>(arg0, arg1);
        let v1 = 0x2::display::new<Allowlist>(&v0, arg1);
        0x2::display::add<Allowlist>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Transfer Allowlist"));
        0x2::display::add<Allowlist>(&mut v1, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://docs.originbyte.io"));
        0x2::display::add<Allowlist>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Defines which contracts are allowed to transfer collections"));
        0x2::display::update_version<Allowlist>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<Allowlist>>(v1, 0x2::tx_context::sender(arg1));
        0x2::package::burn_publisher(v0);
    }

    public fun init_allowlist(arg0: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::object::ID) {
        let (v0, v1) = new(arg0);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<AllowlistOwnerCap>(v2, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_share_object<Allowlist>(v3);
        (0x2::object::id<Allowlist>(&v3), 0x2::object::id<AllowlistOwnerCap>(&v2))
    }

    public fun init_cloned(arg0: &Allowlist, arg1: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::object::ID) {
        let (v0, v1) = new_with_authorities(*borrow_authorities(arg0), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<AllowlistOwnerCap>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<Allowlist>(v3);
        (0x2::object::id<Allowlist>(&v3), 0x2::object::id<AllowlistOwnerCap>(&v2))
    }

    public entry fun insert_authority<T0>(arg0: &AllowlistOwnerCap, arg1: &mut Allowlist) {
        assert_version(arg1);
        assert_cap(arg1, arg0);
        insert_authority_<T0>(arg1);
    }

    fun insert_authority_<T0>(arg0: &mut Allowlist) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(!contains_authority(arg0, &v0), 5);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.authorities, v0);
    }

    public fun insert_authority_with_witness<T0: drop, T1>(arg0: T0, arg1: &mut Allowlist) {
        assert_version(arg1);
        assert_admin_witness<T0>(arg1);
        insert_authority_<T1>(arg1);
    }

    public entry fun insert_collection<T0>(arg0: &mut Allowlist, arg1: &0x2::package::Publisher) {
        assert_version(arg0);
        assert_publisher<T0>(arg1);
        insert_collection_<T0>(arg0);
    }

    fun insert_collection_<T0>(arg0: &mut Allowlist) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(!contains_collection(arg0, v0), 3);
        0x2::dynamic_field::add<0x1::type_name::TypeName, bool>(&mut arg0.id, v0, true);
    }

    entry fun migrate(arg0: &mut Allowlist, arg1: &AllowlistOwnerCap) {
        assert_cap(arg0, arg1);
        assert!(arg0.version < 1, 999);
        arg0.version = 1;
    }

    public fun new_embedded<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : Allowlist {
        new_embedded_with_authorities<T0>(arg0, 0x2::vec_set::empty<0x1::type_name::TypeName>(), arg1)
    }

    public fun new_embedded_with_authorities<T0: drop>(arg0: T0, arg1: 0x2::vec_set::VecSet<0x1::type_name::TypeName>, arg2: &mut 0x2::tx_context::TxContext) : Allowlist {
        Allowlist{
            id            : 0x2::object::new(arg2),
            version       : 1,
            admin_witness : 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::get<T0>()),
            authorities   : arg1,
        }
    }

    public fun new_with_authorities(arg0: 0x2::vec_set::VecSet<0x1::type_name::TypeName>, arg1: &mut 0x2::tx_context::TxContext) : (Allowlist, AllowlistOwnerCap) {
        let v0 = 0x2::object::new(arg1);
        let v1 = AllowlistOwnerCap{
            id  : 0x2::object::new(arg1),
            for : 0x2::object::uid_to_inner(&v0),
        };
        let v2 = Allowlist{
            id            : v0,
            version       : 1,
            admin_witness : 0x1::option::none<0x1::type_name::TypeName>(),
            authorities   : arg0,
        };
        (v2, v1)
    }

    public entry fun remove_authority<T0>(arg0: &AllowlistOwnerCap, arg1: &mut Allowlist) {
        assert_version(arg1);
        assert_cap(arg1, arg0);
        remove_authority_<T0>(arg1);
    }

    fun remove_authority_<T0>(arg0: &mut Allowlist) {
        let v0 = 0x1::type_name::get<T0>();
        assert_authority(arg0, &v0);
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.authorities, &v0);
    }

    public fun remove_authority_with_witness<T0: drop, T1>(arg0: T0, arg1: &mut Allowlist) {
        assert_version(arg1);
        assert_admin_witness<T0>(arg1);
        remove_authority_<T1>(arg1);
    }

    public entry fun remove_collection<T0>(arg0: &mut Allowlist, arg1: &0x2::package::Publisher) {
        assert_version(arg0);
        assert_publisher<T0>(arg1);
        remove_collection_<T0>(arg0);
    }

    public entry fun remove_collection_<T0>(arg0: &mut Allowlist) {
        assert_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        assert_collection(arg0, v0);
        0x2::dynamic_field::remove<0x1::type_name::TypeName, bool>(&mut arg0.id, v0);
    }

    // decompiled from Move bytecode v6
}

