module 0x46d3c9bac58fe067efd1e1358bb1c545994aae7697db89791f1f8934623f3331::authlist {
    struct Authlist has store, key {
        id: 0x2::object::UID,
        version: u64,
        admin_witness: 0x1::option::Option<0x1::type_name::TypeName>,
        names: 0x2::vec_map::VecMap<vector<u8>, 0x1::string::String>,
        authorities: 0x2::vec_set::VecSet<vector<u8>>,
    }

    struct AuthlistOwnerCap has store, key {
        id: 0x2::object::UID,
        for: 0x2::object::ID,
    }

    struct CollectionKey {
        type_name: 0x1::type_name::TypeName,
    }

    struct AUTHLIST has drop {
        dummy_field: bool,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : (Authlist, AuthlistOwnerCap) {
        new_with_authorities(0x2::vec_set::empty<vector<u8>>(), arg0)
    }

    public fun address_to_bytes(arg0: address) : vector<u8> {
        let v0 = 0x2::object::id_from_address(arg0);
        0x2::object::id_to_bytes(&v0)
    }

    public fun assert_admin_witness<T0: drop>(arg0: &Authlist) {
        assert!(0x1::option::is_some<0x1::type_name::TypeName>(&arg0.admin_witness), 2);
        let v0 = 0x1::type_name::get<T0>();
        assert!(&v0 == 0x1::option::borrow<0x1::type_name::TypeName>(&arg0.admin_witness), 2);
    }

    public fun assert_authority(arg0: &Authlist, arg1: &vector<u8>) {
        assert!(contains_authority(arg0, arg1), 5);
    }

    public fun assert_cap(arg0: &Authlist, arg1: &AuthlistOwnerCap) {
        let v0 = 0x2::object::id<Authlist>(arg0);
        assert!(&arg1.for == &v0, 2);
    }

    public fun assert_collection(arg0: &Authlist, arg1: 0x1::type_name::TypeName) {
        assert!(contains_collection(arg0, arg1), 3);
    }

    public fun assert_publisher<T0>(arg0: &0x2::package::Publisher) {
        assert!(0x2::package::from_package<T0>(arg0), 1);
    }

    public fun assert_transferable(arg0: &Authlist, arg1: 0x1::type_name::TypeName, arg2: &vector<u8>, arg3: &vector<u8>, arg4: &vector<u8>) {
        assert_collection(arg0, arg1);
        assert_authority(arg0, arg2);
        assert!(0x2::ed25519::ed25519_verify(arg4, arg2, arg3), 8);
    }

    fun assert_version(arg0: &Authlist) {
        assert!(arg0.version == 1, 1000);
    }

    public fun borrow_authorities(arg0: &Authlist) : &0x2::vec_set::VecSet<vector<u8>> {
        &arg0.authorities
    }

    public fun borrow_names(arg0: &Authlist) : &0x2::vec_map::VecMap<vector<u8>, 0x1::string::String> {
        &arg0.names
    }

    public fun clone(arg0: &Authlist, arg1: &mut 0x2::tx_context::TxContext) : (Authlist, AuthlistOwnerCap) {
        new_with_authorities(*borrow_authorities(arg0), arg1)
    }

    public fun contains_authority(arg0: &Authlist, arg1: &vector<u8>) : bool {
        0x2::vec_set::contains<vector<u8>>(&arg0.authorities, arg1)
    }

    public fun contains_collection(arg0: &Authlist, arg1: 0x1::type_name::TypeName) : bool {
        0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, arg1)
    }

    public fun contains_name(arg0: &Authlist, arg1: &vector<u8>) : bool {
        0x2::vec_map::contains<vector<u8>, 0x1::string::String>(&arg0.names, arg1)
    }

    public entry fun delete_authlist(arg0: Authlist) {
        let Authlist {
            id            : v0,
            version       : _,
            admin_witness : _,
            names         : _,
            authorities   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun delete_owner_cap(arg0: AuthlistOwnerCap) {
        let AuthlistOwnerCap {
            id  : v0,
            for : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: AUTHLIST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<AUTHLIST>(arg0, arg1);
        let v1 = 0x2::display::new<Authlist>(&v0, arg1);
        0x2::display::add<Authlist>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Transfer Authlist"));
        0x2::display::add<Authlist>(&mut v1, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://docs.originbyte.io"));
        0x2::display::add<Authlist>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Defines which pubkeys are allowed to perform protected actions on collections."));
        0x2::display::update_version<Authlist>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<Authlist>>(v1, 0x2::tx_context::sender(arg1));
        0x2::package::burn_publisher(v0);
    }

    public fun init_authlist(arg0: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::object::ID) {
        let (v0, v1) = new(arg0);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<AuthlistOwnerCap>(v2, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_share_object<Authlist>(v3);
        (0x2::object::id<Authlist>(&v3), 0x2::object::id<AuthlistOwnerCap>(&v2))
    }

    public entry fun init_cloned(arg0: &Authlist, arg1: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::object::ID) {
        let (v0, v1) = clone(arg0, arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<AuthlistOwnerCap>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<Authlist>(v3);
        (0x2::object::id<Authlist>(&v3), 0x2::object::id<AuthlistOwnerCap>(&v2))
    }

    public entry fun insert_authority(arg0: &AuthlistOwnerCap, arg1: &mut Authlist, arg2: vector<u8>) {
        assert_version(arg1);
        assert_cap(arg1, arg0);
        insert_authority_(arg1, arg2);
    }

    fun insert_authority_(arg0: &mut Authlist, arg1: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 7);
        assert!(!contains_authority(arg0, &arg1), 6);
        0x2::vec_set::insert<vector<u8>>(&mut arg0.authorities, arg1);
    }

    public fun insert_authority_with_witness<T0: drop>(arg0: T0, arg1: &mut Authlist, arg2: vector<u8>) {
        assert_version(arg1);
        assert_admin_witness<T0>(arg1);
        insert_authority_(arg1, arg2);
    }

    public entry fun insert_collection<T0>(arg0: &mut Authlist, arg1: &0x2::package::Publisher) {
        assert_version(arg0);
        assert_publisher<T0>(arg1);
        insert_collection_<T0>(arg0);
    }

    fun insert_collection_<T0>(arg0: &mut Authlist) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(!contains_collection(arg0, v0), 4);
        0x2::dynamic_field::add<0x1::type_name::TypeName, bool>(&mut arg0.id, v0, true);
    }

    entry fun migrate(arg0: &mut Authlist, arg1: &AuthlistOwnerCap) {
        assert_cap(arg0, arg1);
        assert!(arg0.version < 1, 999);
        arg0.version = 1;
    }

    public fun new_embedded<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : Authlist {
        new_embedded_with_authorities<T0>(arg0, 0x2::vec_set::empty<vector<u8>>(), 0x2::vec_map::empty<vector<u8>, 0x1::string::String>(), arg1)
    }

    public fun new_embedded_with_authorities<T0: drop>(arg0: T0, arg1: 0x2::vec_set::VecSet<vector<u8>>, arg2: 0x2::vec_map::VecMap<vector<u8>, 0x1::string::String>, arg3: &mut 0x2::tx_context::TxContext) : Authlist {
        Authlist{
            id            : 0x2::object::new(arg3),
            version       : 1,
            admin_witness : 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::get<T0>()),
            names         : arg2,
            authorities   : arg1,
        }
    }

    public fun new_with_authorities(arg0: 0x2::vec_set::VecSet<vector<u8>>, arg1: &mut 0x2::tx_context::TxContext) : (Authlist, AuthlistOwnerCap) {
        let v0 = 0x2::object::new(arg1);
        let v1 = AuthlistOwnerCap{
            id  : 0x2::object::new(arg1),
            for : 0x2::object::uid_to_inner(&v0),
        };
        let v2 = Authlist{
            id            : v0,
            version       : 1,
            admin_witness : 0x1::option::none<0x1::type_name::TypeName>(),
            names         : 0x2::vec_map::empty<vector<u8>, 0x1::string::String>(),
            authorities   : arg0,
        };
        (v2, v1)
    }

    public entry fun remove_authority(arg0: &AuthlistOwnerCap, arg1: &mut Authlist, arg2: vector<u8>) {
        assert_version(arg1);
        assert_cap(arg1, arg0);
        remove_authority_(arg1, &arg2);
    }

    fun remove_authority_(arg0: &mut Authlist, arg1: &vector<u8>) {
        assert_authority(arg0, arg1);
        0x2::vec_set::remove<vector<u8>>(&mut arg0.authorities, arg1);
        if (contains_name(arg0, arg1)) {
            let (_, _) = 0x2::vec_map::remove<vector<u8>, 0x1::string::String>(&mut arg0.names, arg1);
        };
    }

    public fun remove_authority_with_witness<T0: drop>(arg0: T0, arg1: &mut Authlist, arg2: &vector<u8>) {
        assert_version(arg1);
        assert_admin_witness<T0>(arg1);
        remove_authority_(arg1, arg2);
    }

    public entry fun remove_collection<T0>(arg0: &mut Authlist, arg1: &0x2::package::Publisher) {
        assert_version(arg0);
        assert_publisher<T0>(arg1);
        remove_collection_<T0>(arg0);
    }

    public entry fun remove_collection_<T0>(arg0: &mut Authlist) {
        assert_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        assert_collection(arg0, v0);
        0x2::dynamic_field::remove<0x1::type_name::TypeName, bool>(&mut arg0.id, v0);
    }

    public entry fun set_name(arg0: &AuthlistOwnerCap, arg1: &mut Authlist, arg2: vector<u8>, arg3: 0x1::string::String) {
        assert_version(arg1);
        assert_cap(arg1, arg0);
        set_name_(arg1, &arg2, arg3);
    }

    fun set_name_(arg0: &mut Authlist, arg1: &vector<u8>, arg2: 0x1::string::String) {
        assert_authority(arg0, arg1);
        if (contains_name(arg0, arg1)) {
            *0x2::vec_map::get_mut<vector<u8>, 0x1::string::String>(&mut arg0.names, arg1) = arg2;
        } else {
            0x2::vec_map::insert<vector<u8>, 0x1::string::String>(&mut arg0.names, *arg1, arg2);
        };
    }

    public fun set_name_with_witness<T0: drop>(arg0: T0, arg1: &mut Authlist, arg2: &vector<u8>, arg3: 0x1::string::String) {
        assert_version(arg1);
        assert_admin_witness<T0>(arg1);
        set_name_(arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

