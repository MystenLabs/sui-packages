module 0x8bdc95e99e393fea9b0e010353ef27109ca6b93d96c57090d7ab61fc9ca4d78d::utility {
    struct Witness has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has store, key {
        id: 0x2::object::UID,
        version: u64,
        admin: 0x2::object::ID,
        signer: vector<u8>,
        used_nonces: 0x2::table_vec::TableVec<u64>,
        collections: 0x2::vec_map::VecMap<0x1::string::String, 0x2::object::ID>,
    }

    entry fun add_collection(arg0: &AdminCap, arg1: &mut Config, arg2: 0x1::string::String, arg3: 0x2::object::ID) {
        add_collection_internal(arg1, arg2, arg3);
    }

    fun add_collection_internal(arg0: &mut Config, arg1: 0x1::string::String, arg2: 0x2::object::ID) {
        0x2::vec_map::insert<0x1::string::String, 0x2::object::ID>(&mut arg0.collections, arg1, arg2);
    }

    entry fun add_used_nonces_table_dof(arg0: &AdminCap, arg1: &mut Config, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::dynamic_object_field::add<vector<u8>, 0x2::table::Table<u64, bool>>(&mut arg1.id, b"used_nonces", 0x2::table::new<u64, bool>(arg2));
    }

    public fun assert_nonce(arg0: &Config, arg1: &u64) {
        assert!(nonce_used(arg0, arg1) == false, 3);
    }

    public fun assert_signature(arg0: &Config, arg1: &vector<u8>, arg2: &vector<u8>) {
        assert!(signature_valid(arg0, arg1, arg2) == true, 4);
    }

    public fun assert_version(arg0: &Config) {
        assert!(arg0.version == 2, 2);
    }

    public fun collection_id_by_name(arg0: &Config, arg1: vector<u8>) : 0x2::object::ID {
        let v0 = 0x1::string::utf8(arg1);
        *0x2::vec_map::get<0x1::string::String, 0x2::object::ID>(&arg0.collections, &v0)
    }

    fun create_config(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : Config {
        Config{
            id          : 0x2::object::new(arg2),
            version     : 2,
            admin       : arg0,
            signer      : arg1,
            used_nonces : 0x2::table_vec::empty<u64>(arg2),
            collections : 0x2::vec_map::empty<0x1::string::String, 0x2::object::ID>(),
        }
    }

    fun find_nonce_from_table_vec(arg0: &0x2::table_vec::TableVec<u64>, arg1: &u64) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x2::table_vec::length<u64>(arg0)) {
            if (0x2::table_vec::borrow<u64>(arg0, v0) == arg1) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = create_config(0x2::object::id<AdminCap>(&v0), x"b8e5842115f34580cf722e2ee0f54a29ce44a4c3d91de50d170af0d55f72d17f", arg0);
        0x2::transfer::public_share_object<Config>(v1);
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun itoa(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 != 0) {
            0x1::vector::push_back<u8>(&mut v0, ((48 + arg0 % 10) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    public(friend) fun mark_nonce_used(arg0: &mut Config, arg1: u64) {
        0x2::table::add<u64, bool>(0x2::dynamic_object_field::borrow_mut<vector<u8>, 0x2::table::Table<u64, bool>>(&mut arg0.id, b"used_nonces"), arg1, true);
    }

    entry fun migrate(arg0: &AdminCap, arg1: &mut Config) {
        assert!(arg1.admin == 0x2::object::id<AdminCap>(arg0), 0);
        assert!(arg1.version < 2, 1);
        arg1.version = 2;
    }

    public fun nonce_used(arg0: &Config, arg1: &u64) : bool {
        0x2::table::contains<u64, bool>(0x2::dynamic_object_field::borrow<vector<u8>, 0x2::table::Table<u64, bool>>(&arg0.id, b"used_nonces"), *arg1)
    }

    entry fun set_signer(arg0: &AdminCap, arg1: &mut Config, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.signer = arg2;
    }

    public fun signature_valid(arg0: &Config, arg1: &vector<u8>, arg2: &vector<u8>) : bool {
        0x2::ed25519::ed25519_verify(arg1, &arg0.signer, arg2)
    }

    // decompiled from Move bytecode v6
}

