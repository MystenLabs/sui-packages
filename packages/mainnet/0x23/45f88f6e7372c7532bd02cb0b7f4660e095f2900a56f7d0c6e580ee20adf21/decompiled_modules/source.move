module 0x2345f88f6e7372c7532bd02cb0b7f4660e095f2900a56f7d0c6e580ee20adf21::source {
    struct SourceObjectKey has copy, drop, store {
        pos0: u16,
    }

    struct Source<phantom T0> has store, key {
        id: 0x2::object::UID,
        source_cap: 0x2345f88f6e7372c7532bd02cb0b7f4660e095f2900a56f7d0c6e580ee20adf21::authority::SourceCap,
        version: u64,
    }

    public fun source_id<T0>(arg0: &Source<T0>) : u16 {
        0x2345f88f6e7372c7532bd02cb0b7f4660e095f2900a56f7d0c6e580ee20adf21::authority::source_id(&arg0.source_cap)
    }

    public fun borrow_mut_id<T0: drop>(arg0: &mut Source<T0>, arg1: T0) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun set_authorized<T0, T1>(arg0: &mut Source<T0>, arg1: &0x2345f88f6e7372c7532bd02cb0b7f4660e095f2900a56f7d0c6e580ee20adf21::config::Config, arg2: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x2345f88f6e7372c7532bd02cb0b7f4660e095f2900a56f7d0c6e580ee20adf21::authority::PACKAGE, T1>, arg3: bool) {
        0x2345f88f6e7372c7532bd02cb0b7f4660e095f2900a56f7d0c6e580ee20adf21::config::set_authorized<T1>(arg1, arg2, &mut arg0.source_cap, arg3);
    }

    public fun assert_version<T0>(arg0: &Source<T0>, arg1: u64) {
        if (arg0.version > arg1) {
            abort 13835059086074314753
        };
    }

    public fun borrow_source_cap<T0: drop>(arg0: &Source<T0>, arg1: T0) : &0x2345f88f6e7372c7532bd02cb0b7f4660e095f2900a56f7d0c6e580ee20adf21::authority::SourceCap {
        &arg0.source_cap
    }

    public fun child_exists<T0, T1: copy + drop + store>(arg0: &Source<T0>, arg1: T1) : bool {
        0x2::derived_object::exists<T1>(&arg0.id, arg1)
    }

    public fun child_id<T0, T1: copy + drop + store>(arg0: &Source<T0>, arg1: T1) : 0x2::object::ID {
        0x2::object::id_from_address(0x2::derived_object::derive_address<T1>(0x2::object::uid_to_inner(&arg0.id), arg1))
    }

    public fun create<T0, T1>(arg0: &mut 0x2345f88f6e7372c7532bd02cb0b7f4660e095f2900a56f7d0c6e580ee20adf21::config::Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x2345f88f6e7372c7532bd02cb0b7f4660e095f2900a56f7d0c6e580ee20adf21::authority::PACKAGE, T1>, arg2: &T0, arg3: u64) : Source<T0> {
        let v0 = 0x2345f88f6e7372c7532bd02cb0b7f4660e095f2900a56f7d0c6e580ee20adf21::config::new_source_id<T0, T1>(arg0, arg1);
        let v1 = 0x2345f88f6e7372c7532bd02cb0b7f4660e095f2900a56f7d0c6e580ee20adf21::authority::source_id(&v0);
        let v2 = SourceObjectKey{pos0: v1};
        let v3 = Source<T0>{
            id         : 0x2::derived_object::claim<SourceObjectKey>(0x2345f88f6e7372c7532bd02cb0b7f4660e095f2900a56f7d0c6e580ee20adf21::config::borrow_mut_id(arg0), v2),
            source_cap : v0,
            version    : arg3,
        };
        0x2345f88f6e7372c7532bd02cb0b7f4660e095f2900a56f7d0c6e580ee20adf21::events::emit_created_source(v1, 0x2::object::uid_to_inner(&v3.id));
        v3
    }

    public fun derived_id(arg0: &0x2345f88f6e7372c7532bd02cb0b7f4660e095f2900a56f7d0c6e580ee20adf21::config::Config, arg1: u16) : 0x2::object::ID {
        let v0 = SourceObjectKey{pos0: arg1};
        0x2::object::id_from_address(0x2::derived_object::derive_address<SourceObjectKey>(0x2345f88f6e7372c7532bd02cb0b7f4660e095f2900a56f7d0c6e580ee20adf21::config::id(arg0), v0))
    }

    public fun object_id<T0>(arg0: &Source<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun upgrade_version<T0, T1>(arg0: &mut Source<T0>, arg1: &0x2345f88f6e7372c7532bd02cb0b7f4660e095f2900a56f7d0c6e580ee20adf21::config::Config, arg2: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x2345f88f6e7372c7532bd02cb0b7f4660e095f2900a56f7d0c6e580ee20adf21::authority::PACKAGE, T1>, arg3: u64) {
        assert!(arg0.version < arg3, 13835058639397715969);
        0x2345f88f6e7372c7532bd02cb0b7f4660e095f2900a56f7d0c6e580ee20adf21::config::assert_package_version(arg1);
        0x2345f88f6e7372c7532bd02cb0b7f4660e095f2900a56f7d0c6e580ee20adf21::authority::assert_is_admin_or_assistant<T1>();
        0x2345f88f6e7372c7532bd02cb0b7f4660e095f2900a56f7d0c6e580ee20adf21::config::assert_package_authority_cap_is_valid<T1>(arg1, arg2);
        arg0.version = arg3;
        0x2345f88f6e7372c7532bd02cb0b7f4660e095f2900a56f7d0c6e580ee20adf21::events::emit_upgraded_source_version(0x2345f88f6e7372c7532bd02cb0b7f4660e095f2900a56f7d0c6e580ee20adf21::authority::source_id(&arg0.source_cap), arg3);
    }

    public fun version<T0>(arg0: &Source<T0>) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

