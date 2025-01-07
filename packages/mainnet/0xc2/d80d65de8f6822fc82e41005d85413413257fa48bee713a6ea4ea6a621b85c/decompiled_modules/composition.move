module 0xc2d80d65de8f6822fc82e41005d85413413257fa48bee713a6ea4ea6a621b85c::composition {
    struct Composition<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
        limits: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    struct AddCompositionEvent has copy, drop {
        collection: 0x2::object::ID,
        nft_type: 0x1::type_name::TypeName,
        composition: 0x2::object::ID,
    }

    struct RemoveCompositionEvent has copy, drop {
        collection: 0x2::object::ID,
        nft_type: 0x1::type_name::TypeName,
        composition: 0x2::object::ID,
    }

    struct AddLimitEvent has copy, drop {
        composition: 0x2::object::ID,
        child_nft_type: 0x1::type_name::TypeName,
        limit_amount: u64,
    }

    struct RemoveLimitEvent has copy, drop {
        composition: 0x2::object::ID,
        child_nft_type: 0x1::type_name::TypeName,
    }

    struct ComposeEvent has copy, drop {
        composition: 0x2::object::ID,
        parent_nft: 0x2::object::ID,
        child_nft: 0x2::object::ID,
    }

    struct DeComposeEvent has copy, drop {
        composition: 0x2::object::ID,
        parent_nft: 0x2::object::ID,
        child_nft: 0x2::object::ID,
    }

    public fun add_composition<T0>(arg0: &mut 0x2::object::UID, arg1: Composition<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(&arg1);
        assert_no_composition<T0>(arg0);
        0xdd09401d8178ebc3404a308d3e3454f2b7d1998a537bd08259dcf5bbf007205::bucket::put<Composition<T0>>(arg0, arg1, arg2);
        let v0 = AddCompositionEvent{
            collection  : 0x2::object::uid_to_inner(arg0),
            nft_type    : 0x1::type_name::get<T0>(),
            composition : 0xdd09401d8178ebc3404a308d3e3454f2b7d1998a537bd08259dcf5bbf007205::bucket::get_object_id<Composition<T0>>(arg0, 0),
        };
        0x2::event::emit<AddCompositionEvent>(v0);
    }

    public fun add_limit<T0, T1>(arg0: &mut Composition<T0>, arg1: u64) {
        assert_version<T0>(arg0);
        let v0 = 0x1::type_name::get<T1>();
        assert!(!has_child_type<T0>(arg0, &v0), 10006);
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.limits, v0, arg1);
        let v1 = AddLimitEvent{
            composition    : 0x2::object::uid_to_inner(&arg0.id),
            child_nft_type : 0x1::type_name::get<T1>(),
            limit_amount   : arg1,
        };
        0x2::event::emit<AddLimitEvent>(v1);
    }

    fun assert_composable<T0>(arg0: &Composition<T0>, arg1: &0x1::type_name::TypeName) {
        assert!(has_child_type<T0>(arg0, arg1), 10005);
    }

    fun assert_composition<T0>(arg0: &0x2::object::UID) {
        assert!(0xdd09401d8178ebc3404a308d3e3454f2b7d1998a537bd08259dcf5bbf007205::bucket::size<Composition<T0>>(arg0) > 0, 10003);
    }

    fun assert_empty_composition<T0>(arg0: &Composition<T0>) {
        assert!(0x2::vec_map::is_empty<0x1::type_name::TypeName, u64>(&arg0.limits), 10008);
    }

    fun assert_insertable<T0, T1: store + key>(arg0: &Composition<T0>, arg1: u64) {
        let v0 = 0x1::type_name::get<T1>();
        assert!(arg1 < get_limit<T0>(arg0, &v0), 10007);
    }

    fun assert_no_composition<T0>(arg0: &0x2::object::UID) {
        if (0xdd09401d8178ebc3404a308d3e3454f2b7d1998a537bd08259dcf5bbf007205::bucket::exists_bucket<Composition<T0>>(arg0)) {
            assert!(0xdd09401d8178ebc3404a308d3e3454f2b7d1998a537bd08259dcf5bbf007205::bucket::size<Composition<T0>>(arg0) == 0, 10004);
        };
    }

    fun assert_version<T0>(arg0: &Composition<T0>) {
        assert!(arg0.version == 1, 10001);
    }

    public fun borrow_limit_mut<T0>(arg0: &mut Composition<T0>, arg1: &0x1::type_name::TypeName) : &mut u64 {
        assert_version<T0>(arg0);
        assert_composable<T0>(arg0, arg1);
        0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.limits, arg1)
    }

    public fun borrow_limits<T0>(arg0: &Composition<T0>) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, u64> {
        &arg0.limits
    }

    public fun borrow_version<T0>(arg0: &Composition<T0>) : &u64 {
        &arg0.version
    }

    public fun compose<T0, T1: store + key>(arg0: &Composition<T0>, arg1: &mut 0x2::object::UID, arg2: T1, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        let v0 = 0x1::type_name::get<T1>();
        assert_composable<T0>(arg0, &v0);
        let v1 = 0;
        if (0xdd09401d8178ebc3404a308d3e3454f2b7d1998a537bd08259dcf5bbf007205::bucket::exists_bucket<T1>(arg1)) {
            v1 = 0xdd09401d8178ebc3404a308d3e3454f2b7d1998a537bd08259dcf5bbf007205::bucket::size<T1>(arg1);
        };
        assert_insertable<T0, T1>(arg0, v1);
        0xdd09401d8178ebc3404a308d3e3454f2b7d1998a537bd08259dcf5bbf007205::bucket::put<T1>(arg1, arg2, arg3);
        let v2 = ComposeEvent{
            composition : 0x2::object::uid_to_inner(&arg0.id),
            parent_nft  : 0x2::object::uid_to_inner(arg1),
            child_nft   : 0xdd09401d8178ebc3404a308d3e3454f2b7d1998a537bd08259dcf5bbf007205::bucket::get_object_id<T1>(arg1, 0xdd09401d8178ebc3404a308d3e3454f2b7d1998a537bd08259dcf5bbf007205::bucket::size<T1>(arg1) - 1),
        };
        0x2::event::emit<ComposeEvent>(v2);
    }

    public fun decompose<T0, T1: store + key>(arg0: &Composition<T0>, arg1: &mut 0x2::object::UID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : T1 {
        assert_version<T0>(arg0);
        let v0 = 0x1::type_name::get<T1>();
        assert_composable<T0>(arg0, &v0);
        0xdd09401d8178ebc3404a308d3e3454f2b7d1998a537bd08259dcf5bbf007205::bucket::assert_exists_bucket<T1>(arg1);
        if (0xdd09401d8178ebc3404a308d3e3454f2b7d1998a537bd08259dcf5bbf007205::bucket::is_empty<T1>(arg1)) {
            0xdd09401d8178ebc3404a308d3e3454f2b7d1998a537bd08259dcf5bbf007205::bucket::drop<T1>(arg1);
        };
        let v1 = DeComposeEvent{
            composition : 0x2::object::uid_to_inner(&arg0.id),
            parent_nft  : 0x2::object::uid_to_inner(arg1),
            child_nft   : arg2,
        };
        0x2::event::emit<DeComposeEvent>(v1);
        0xdd09401d8178ebc3404a308d3e3454f2b7d1998a537bd08259dcf5bbf007205::bucket::take<T1>(arg1, arg2, arg3)
    }

    public fun delete_composition<T0>(arg0: Composition<T0>) {
        assert_version<T0>(&arg0);
        assert_empty_composition<T0>(&arg0);
        let Composition {
            id      : v0,
            version : _,
            limits  : v2,
        } = arg0;
        0x2::vec_map::destroy_empty<0x1::type_name::TypeName, u64>(v2);
        0x2::object::delete(v0);
    }

    public fun drop_limit<T0, T1>(arg0: &mut Composition<T0>) {
        assert_version<T0>(arg0);
        let v0 = 0x1::type_name::get<T1>();
        assert_composable<T0>(arg0, &v0);
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut arg0.limits, &v0);
        let v3 = RemoveLimitEvent{
            composition    : 0x2::object::uid_to_inner(&arg0.id),
            child_nft_type : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<RemoveLimitEvent>(v3);
    }

    public fun get_limit<T0>(arg0: &Composition<T0>, arg1: &0x1::type_name::TypeName) : u64 {
        assert_composable<T0>(arg0, arg1);
        *0x2::vec_map::get<0x1::type_name::TypeName, u64>(borrow_limits<T0>(arg0), arg1)
    }

    public fun has_child_type<T0>(arg0: &Composition<T0>, arg1: &0x1::type_name::TypeName) : bool {
        0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.limits, arg1)
    }

    public fun init_composition<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = new_composition<T0>(arg1);
        add_composition<T0>(arg0, v0, arg1);
    }

    public entry fun migrate<T0>(arg0: &mut Composition<T0>) {
        assert!(arg0.version < 1, 10002);
        arg0.version = 1;
    }

    public fun new_composition<T0>(arg0: &mut 0x2::tx_context::TxContext) : Composition<T0> {
        Composition<T0>{
            id      : 0x2::object::new(arg0),
            version : 1,
            limits  : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
        }
    }

    public fun remove_composition<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) : Composition<T0> {
        assert_composition<T0>(arg0);
        let v0 = 0xdd09401d8178ebc3404a308d3e3454f2b7d1998a537bd08259dcf5bbf007205::bucket::take<Composition<T0>>(arg0, 0xdd09401d8178ebc3404a308d3e3454f2b7d1998a537bd08259dcf5bbf007205::bucket::get_object_id<Composition<T0>>(arg0, 0), arg1);
        assert_version<T0>(&v0);
        let v1 = RemoveCompositionEvent{
            collection  : 0x2::object::uid_to_inner(arg0),
            nft_type    : 0x1::type_name::get<T0>(),
            composition : 0x2::object::uid_to_inner(&v0.id),
        };
        0x2::event::emit<RemoveCompositionEvent>(v1);
        v0
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

