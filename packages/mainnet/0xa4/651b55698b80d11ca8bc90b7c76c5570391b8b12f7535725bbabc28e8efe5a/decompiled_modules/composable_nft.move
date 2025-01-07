module 0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::composable_nft {
    struct Key<phantom T0> has drop, store {
        dummy_field: bool,
    }

    struct Composition<phantom T0> has store {
        limits: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    public fun borrow_domain<T0>(arg0: &0x2::object::UID) : &Composition<T0> {
        assert_composition<T0>(arg0);
        0x2::dynamic_field::borrow<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<Composition<T0>>, Composition<T0>>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<Composition<T0>>())
    }

    public fun add_domain<T0>(arg0: &mut 0x2::object::UID, arg1: Composition<T0>) {
        assert_no_composition<T0>(arg0);
        0x2::dynamic_field::add<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<Composition<T0>>, Composition<T0>>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<Composition<T0>>(), arg1);
    }

    public fun add_new_composition<T0>(arg0: &mut 0x2::object::UID) {
        add_domain<T0>(arg0, new_composition<T0>());
    }

    public fun add_relationship<T0, T1>(arg0: &mut Composition<T0>, arg1: u64) {
        let v0 = 0x1::type_name::get<T1>();
        assert!(!has_child<T0>(arg0, &v0), 4);
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.limits, v0, arg1);
    }

    public fun assert_composable<T0>(arg0: &Composition<T0>, arg1: &0x1::type_name::TypeName) {
        assert!(has_child<T0>(arg0, arg1), 3);
    }

    public fun assert_composition<T0>(arg0: &0x2::object::UID) {
        assert!(has_domain<T0>(arg0), 1);
    }

    fun assert_insertable<T0, T1: store + key>(arg0: &Composition<T0>, arg1: u64) {
        let v0 = 0x1::type_name::get<T1>();
        assert!(arg1 <= get_limit<T0>(arg0, &v0), 5);
    }

    public fun assert_no_composition<T0>(arg0: &0x2::object::UID) {
        assert!(!has_domain<T0>(arg0), 2);
    }

    public fun borrow_domain_mut<T0>(arg0: &mut 0x2::object::UID) : &mut Composition<T0> {
        assert_composition<T0>(arg0);
        0x2::dynamic_field::borrow_mut<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<Composition<T0>>, Composition<T0>>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<Composition<T0>>())
    }

    public fun borrow_limit_mut<T0>(arg0: &mut Composition<T0>, arg1: &0x1::type_name::TypeName) : &mut u64 {
        assert_composable<T0>(arg0, arg1);
        0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.limits, arg1)
    }

    public fun borrow_limits<T0>(arg0: &Composition<T0>) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, u64> {
        &arg0.limits
    }

    public fun compose<T0, T1: store + key>(arg0: &Composition<T0>, arg1: &mut 0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::nft_bag::NftBag, arg2: T1) {
        assert_insertable<T0, T1>(arg0, compose_<T1>(arg1, arg2));
    }

    fun compose_<T0: store + key>(arg0: &mut 0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::nft_bag::NftBag, arg1: T0) : u64 {
        let v0 = Key<T0>{dummy_field: false};
        0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::nft_bag::compose<T0, Key<T0>>(v0, arg0, arg1);
        0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::nft_bag::count<Key<T0>>(arg0)
    }

    public fun compose_into_nft<T0, T1: store + key>(arg0: &Composition<T0>, arg1: &mut 0x2::object::UID, arg2: T1) {
        let v0 = 0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::nft_bag::borrow_domain_mut(arg1);
        compose<T0, T1>(arg0, v0, arg2);
    }

    public fun compose_with_collection_schema<T0, T1, T2: store + key>(arg0: &0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::collection::Collection<T0>, arg1: &mut 0x2::object::UID, arg2: T2) {
        let v0 = 0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::nft_bag::borrow_domain_mut(arg1);
        compose<T1, T2>(0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::collection::borrow_domain<T0, Composition<T1>>(arg0), v0, arg2);
    }

    public fun compose_with_nft_schema<T0, T1: store + key>(arg0: &mut 0x2::object::UID, arg1: T1) {
        let v0 = 0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::nft_bag::borrow_domain_mut(arg0);
        assert_insertable<T0, T1>(borrow_domain<T0>(arg0), compose_<T1>(v0, arg1));
    }

    public fun decompose<T0, T1: store + key>(arg0: &Composition<T0>, arg1: &mut 0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::nft_bag::NftBag, arg2: 0x2::object::ID) : T1 {
        let v0 = 0x1::type_name::get<T1>();
        assert_composable<T0>(arg0, &v0);
        decompose_<T1>(arg1, arg2)
    }

    fun decompose_<T0: store + key>(arg0: &mut 0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::nft_bag::NftBag, arg1: 0x2::object::ID) : T0 {
        let v0 = Key<T0>{dummy_field: false};
        0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::nft_bag::decompose<T0, Key<T0>>(v0, arg0, arg1)
    }

    public fun decompose_from_nft<T0, T1: store + key>(arg0: &Composition<T0>, arg1: &mut 0x2::object::UID, arg2: 0x2::object::ID) : T1 {
        let v0 = 0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::nft_bag::borrow_domain_mut(arg1);
        decompose<T0, T1>(arg0, v0, arg2)
    }

    public fun decompose_with_collection_schema<T0, T1, T2: store + key>(arg0: &0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::collection::Collection<T0>, arg1: &mut 0x2::object::UID, arg2: 0x2::object::ID) : T2 {
        let v0 = 0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::nft_bag::borrow_domain_mut(arg1);
        decompose<T1, T2>(0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::collection::borrow_domain<T0, Composition<T1>>(arg0), v0, arg2)
    }

    public fun decompose_with_nft_schema<T0, T1: store + key>(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID) : T1 {
        let v0 = 0x1::type_name::get<T1>();
        assert_composable<T0>(borrow_domain<T0>(arg0), &v0);
        let v1 = 0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::nft_bag::borrow_domain_mut(arg0);
        decompose_<T1>(v1, arg1)
    }

    public fun delete<T0>(arg0: Composition<T0>) {
        let Composition {  } = arg0;
    }

    public fun drop_relationship<T0, T1>(arg0: &mut Composition<T0>) {
        let v0 = 0x1::type_name::get<T1>();
        assert_composable<T0>(arg0, &v0);
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut arg0.limits, &v0);
    }

    public fun get_limit<T0>(arg0: &Composition<T0>, arg1: &0x1::type_name::TypeName) : u64 {
        assert_composable<T0>(arg0, arg1);
        *0x2::vec_map::get<0x1::type_name::TypeName, u64>(borrow_limits<T0>(arg0), arg1)
    }

    public fun has_child<T0>(arg0: &Composition<T0>, arg1: &0x1::type_name::TypeName) : bool {
        0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.limits, arg1)
    }

    public fun has_domain<T0>(arg0: &0x2::object::UID) : bool {
        0x2::dynamic_field::exists_with_type<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<Composition<T0>>, Composition<T0>>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<Composition<T0>>())
    }

    public fun new_composition<T0>() : Composition<T0> {
        Composition<T0>{limits: 0x2::vec_map::empty<0x1::type_name::TypeName, u64>()}
    }

    public fun remove_domain<T0>(arg0: &mut 0x2::object::UID) : Composition<T0> {
        assert_composition<T0>(arg0);
        0x2::dynamic_field::remove<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<Composition<T0>>, Composition<T0>>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<Composition<T0>>())
    }

    // decompiled from Move bytecode v6
}

