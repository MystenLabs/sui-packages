module 0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version {
    struct Publication<phantom T0: drop> has key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
        valid_pause_bits: u8,
        package_witness: 0x1::type_name::TypeName,
    }

    struct PackageVersion<phantom T0: drop> has key {
        id: 0x2::object::UID,
        valid_pause_bits: u8,
        paused: u8,
        package_witness: 0x1::type_name::TypeName,
        version: u64,
    }

    public fun paused<T0: drop>(arg0: &PackageVersion<T0>) : u8 {
        arg0.paused
    }

    public(friend) fun advance<T0: drop>(arg0: &mut PackageVersion<T0>) {
        let v0 = arg0.version;
        arg0.version = v0 + 1;
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::blast_admin_events::version_advanced<T0>(0x2::object::uid_to_inner(&arg0.id), 0x1::type_name::original_id<T0>(), v0, arg0.version);
    }

    public fun assert_current<T0: drop>(arg0: &PackageVersion<T0>, arg1: u64) {
        assert!(arg0.version == arg1, 9);
    }

    public fun assert_not_paused<T0: drop>(arg0: &PackageVersion<T0>, arg1: u8) {
        assert!(!is_paused<T0>(arg0, arg1), 21);
    }

    public(friend) fun assert_package_witness<T0: drop, T1: drop>(arg0: &PackageVersion<T0>) {
        assert!(0x1::type_name::with_defining_ids<T1>() == arg0.package_witness, 26);
    }

    public(friend) fun assert_unpause_witness<T0: drop, T1: drop>(arg0: &PackageVersion<T0>) {
        assert!(0x1::type_name::with_defining_ids<T1>() == arg0.package_witness, 25);
    }

    fun assert_valid_pause_bits<T0: drop>(arg0: &PackageVersion<T0>, arg1: u8) {
        assert!(arg1 != 0 && arg1 & arg0.valid_pause_bits == arg1, 19);
    }

    public(friend) fun clear_pause_bits<T0: drop>(arg0: &mut PackageVersion<T0>, arg1: u8) {
        assert_valid_pause_bits<T0>(arg0, arg1);
        assert!(arg0.paused & arg1 != 0, 20);
        arg0.paused = arg0.paused ^ arg0.paused & arg1;
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::blast_admin_events::unpaused<T0>(0x2::object::uid_to_inner(&arg0.id), arg1, arg0.paused);
    }

    public(friend) fun into_version<T0: drop>(arg0: Publication<T0>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::package::Publisher, PackageVersion<T0>) {
        let Publication {
            id               : v0,
            publisher        : v1,
            valid_pause_bits : v2,
            package_witness  : v3,
        } = arg0;
        0x2::object::delete(v0);
        let v4 = PackageVersion<T0>{
            id               : 0x2::object::new(arg1),
            valid_pause_bits : v2,
            paused           : v2,
            package_witness  : v3,
            version          : 1,
        };
        (v1, v4)
    }

    public fun is_paused<T0: drop>(arg0: &PackageVersion<T0>, arg1: u8) : bool {
        arg0.paused & arg1 != 0
    }

    public fun keep<T0: drop>(arg0: Publication<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<Publication<T0>>(arg0, 0x2::tx_context::sender(arg1));
    }

    public fun new_publication<T0: drop, T1: drop>(arg0: T0, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : Publication<T0> {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = if (!0x1::type_name::is_primitive(&v0)) {
            if (0x1::type_name::original_id<T1>() == 0x1::type_name::original_id<T0>()) {
                v0 != 0x1::type_name::with_defining_ids<T0>()
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 24);
        Publication<T0>{
            id               : 0x2::object::new(arg2),
            publisher        : 0x2::package::claim<T0>(arg0, arg2),
            valid_pause_bits : arg1,
            package_witness  : v0,
        }
    }

    public fun package_witness<T0: drop>(arg0: &PackageVersion<T0>) : 0x1::type_name::TypeName {
        arg0.package_witness
    }

    public fun publication_package_witness<T0: drop>(arg0: &Publication<T0>) : 0x1::type_name::TypeName {
        arg0.package_witness
    }

    public fun publication_publisher_id<T0: drop>(arg0: &Publication<T0>) : 0x2::object::ID {
        0x2::object::id<0x2::package::Publisher>(&arg0.publisher)
    }

    public fun publication_valid_pause_bits<T0: drop>(arg0: &Publication<T0>) : u8 {
        arg0.valid_pause_bits
    }

    public(friend) fun set_pause_bits<T0: drop>(arg0: &mut PackageVersion<T0>, arg1: u8) {
        assert_valid_pause_bits<T0>(arg0, arg1);
        assert!(arg0.paused | arg1 != arg0.paused, 20);
        arg0.paused = arg0.paused | arg1;
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::blast_admin_events::paused<T0>(0x2::object::uid_to_inner(&arg0.id), arg1, arg0.paused);
    }

    public(friend) fun share<T0: drop>(arg0: PackageVersion<T0>, arg1: 0x2::object::ID) {
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::blast_admin_events::package_version_created<T0>(0x2::object::uid_to_inner(&arg0.id), arg1, arg0.valid_pause_bits, arg0.paused, arg0.package_witness, arg0.version);
        0x2::transfer::share_object<PackageVersion<T0>>(arg0);
    }

    public fun valid_pause_bits<T0: drop>(arg0: &PackageVersion<T0>) : u8 {
        arg0.valid_pause_bits
    }

    public fun version<T0: drop>(arg0: &PackageVersion<T0>) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

