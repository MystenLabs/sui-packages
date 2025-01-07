module 0xaa644104d5b63baf73e7f7a1148f7fb062f0e882862f01917b7be823426deb25::access_control {
    struct ACCESS_CONTROL has drop {
        dummy_field: bool,
    }

    struct AuthCap has store, key {
        id: 0x2::object::UID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct Auth<phantom T0> has key {
        id: 0x2::object::UID,
        authorized: 0x2::vec_set::VecSet<address>,
        version: u8,
    }

    struct AuthorizationProof<phantom T0> has drop {
        dummy_field: bool,
    }

    public fun authorize<T0>(arg0: &mut Auth<T0>, arg1: &AuthCap, arg2: address) {
        assert!(arg0.version == 1, 0);
        assert!(!0x2::vec_set::contains<address>(&arg0.authorized, &arg2), 4);
        0x2::vec_set::insert<address>(&mut arg0.authorized, arg2);
    }

    public fun bump_registry_version(arg0: &mut Registry, arg1: &AuthCap) {
        assert!(0 > arg0.version, 1);
        arg0.version = 0;
    }

    public fun deauthorize<T0>(arg0: &mut Auth<T0>, arg1: &AuthCap, arg2: address) {
        assert!(arg0.version == 1, 0);
        assert!(0x2::vec_set::contains<address>(&arg0.authorized, &arg2), 3);
        0x2::vec_set::remove<address>(&mut arg0.authorized, &arg2);
    }

    public fun deauthorize_self<T0>(arg0: &mut Auth<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_set::contains<address>(&arg0.authorized, &v0), 3);
        let v1 = 0x2::tx_context::sender(arg1);
        0x2::vec_set::remove<address>(&mut arg0.authorized, &v1);
    }

    public fun get_proof<T0>(arg0: &Auth<T0>, arg1: &0x2::tx_context::TxContext) : AuthorizationProof<T0> {
        assert!(arg0.version == 1, 0);
        assert!(arg0.version == 1, 0);
        assert!(is_authorized<T0>(arg0, arg1), 2);
        AuthorizationProof<T0>{dummy_field: false}
    }

    fun init(arg0: ACCESS_CONTROL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<ACCESS_CONTROL>(arg0, arg1);
        let v0 = Registry{
            id      : 0x2::object::new(arg1),
            version : 0,
        };
        let v1 = AuthCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AuthCap>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun is_authorized<T0>(arg0: &Auth<T0>, arg1: &0x2::tx_context::TxContext) : bool {
        assert!(arg0.version == 1, 0);
        let v0 = 0x2::tx_context::sender(arg1);
        0x2::vec_set::contains<address>(&arg0.authorized, &v0)
    }

    public fun is_valid_version(arg0: &Registry) : bool {
        arg0.version == 0
    }

    public fun new_auth<T0>(arg0: &AuthCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Auth<T0>{
            id         : 0x2::object::new(arg1),
            authorized : 0x2::vec_set::empty<address>(),
            version    : 1,
        };
        0x2::transfer::share_object<Auth<T0>>(v0);
    }

    public fun set_version<T0>(arg0: &mut Auth<T0>, arg1: &AuthCap, arg2: u8) {
        arg0.version = arg2;
    }

    // decompiled from Move bytecode v6
}

