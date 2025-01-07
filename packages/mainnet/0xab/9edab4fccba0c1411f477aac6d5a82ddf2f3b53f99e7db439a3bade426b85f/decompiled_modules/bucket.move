module 0xab9edab4fccba0c1411f477aac6d5a82ddf2f3b53f99e7db439a3bade426b85f::bucket {
    struct Marker<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct Bucket<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        version: u64,
        ids: 0x2::table::Table<u64, 0x2::object::ID>,
        indexes: 0x2::table::Table<0x2::object::ID, u64>,
        objects: 0x2::table::Table<0x2::object::ID, T0>,
    }

    struct PutEvent<phantom T0> has copy, drop {
        sender: address,
        object_id: 0x2::object::ID,
    }

    struct TakeEvent<phantom T0> has copy, drop {
        sender: address,
        object_id: 0x2::object::ID,
    }

    public fun empty<T0: store + key>(arg0: &mut 0x2::tx_context::TxContext) : Bucket<T0> {
        Bucket<T0>{
            id      : 0x2::object::new(arg0),
            version : 1,
            ids     : 0x2::table::new<u64, 0x2::object::ID>(arg0),
            indexes : 0x2::table::new<0x2::object::ID, u64>(arg0),
            objects : 0x2::table::new<0x2::object::ID, T0>(arg0),
        }
    }

    fun add<T0: store + key>(arg0: &mut Bucket<T0>, arg1: u64, arg2: 0x2::object::ID, arg3: T0) {
        0x2::table::add<u64, 0x2::object::ID>(&mut arg0.ids, arg1, arg2);
        0x2::table::add<0x2::object::ID, u64>(&mut arg0.indexes, arg2, arg1);
        0x2::table::add<0x2::object::ID, T0>(&mut arg0.objects, arg2, arg3);
    }

    fun remove<T0: store + key>(arg0: &mut Bucket<T0>, arg1: u64, arg2: 0x2::object::ID) : T0 {
        0x2::table::remove<u64, 0x2::object::ID>(&mut arg0.ids, arg1);
        0x2::table::remove<0x2::object::ID, u64>(&mut arg0.indexes, arg2);
        0x2::table::remove<0x2::object::ID, T0>(&mut arg0.objects, arg2)
    }

    public fun assert_empty_bucket<T0: store + key>(arg0: &0x2::object::UID) {
        assert!(is_empty<T0>(arg0), 10003);
    }

    public fun assert_exists_bucket<T0>(arg0: &0x2::object::UID) {
        assert!(exists_bucket<T0>(arg0), 10005);
    }

    fun assert_exists_index<T0: store + key>(arg0: &Bucket<T0>, arg1: u64) {
        assert!(0x2::table::contains<u64, 0x2::object::ID>(&arg0.ids, arg1), 10006);
    }

    fun assert_exists_object<T0: store + key>(arg0: &Bucket<T0>, arg1: 0x2::object::ID) {
        assert!(0x2::table::contains<0x2::object::ID, T0>(&arg0.objects, arg1), 10007);
    }

    public fun assert_not_empty_bucket<T0: store + key>(arg0: &0x2::object::UID) {
        assert!(!is_empty<T0>(arg0), 10004);
    }

    fun assert_version<T0: store + key>(arg0: &Bucket<T0>) {
        assert!(arg0.version == 1, 10001);
    }

    public fun borrow_bucket<T0: store + key>(arg0: &0x2::object::UID) : &Bucket<T0> {
        assert_exists_bucket<T0>(arg0);
        internal_borrow_bucket<T0>(arg0)
    }

    public fun borrow_mut_bucket<T0: store + key>(arg0: &mut 0x2::object::UID) : &mut Bucket<T0> {
        assert_exists_bucket<T0>(arg0);
        let v0 = 0x2::dynamic_field::borrow_mut<Marker<T0>, Bucket<T0>>(arg0, marker<T0>());
        assert_version<T0>(v0);
        v0
    }

    public fun borrow_mut_object<T0: store + key>(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID) : &mut T0 {
        assert_exists_bucket<T0>(arg0);
        let v0 = borrow_mut_bucket<T0>(arg0);
        assert_version<T0>(v0);
        assert_exists_object<T0>(v0, arg1);
        internal_borrow_mut_object<T0>(v0, arg1)
    }

    public fun borrow_mut_object_by_index<T0: store + key>(arg0: &mut 0x2::object::UID, arg1: u64) : &mut T0 {
        let v0 = get_object_id<T0>(arg0, arg1);
        borrow_mut_object<T0>(arg0, v0)
    }

    public fun borrow_mut_object_id<T0: store + key>(arg0: &mut 0x2::object::UID, arg1: u64) : &mut 0x2::object::ID {
        assert_exists_bucket<T0>(arg0);
        let v0 = borrow_mut_bucket<T0>(arg0);
        assert_exists_index<T0>(v0, arg1);
        0x2::table::borrow_mut<u64, 0x2::object::ID>(&mut v0.ids, arg1)
    }

    public fun borrow_object<T0: store + key>(arg0: &0x2::object::UID, arg1: 0x2::object::ID) : &T0 {
        assert_exists_bucket<T0>(arg0);
        let v0 = internal_borrow_bucket<T0>(arg0);
        assert_exists_object<T0>(v0, arg1);
        internal_borrow_object<T0>(v0, arg1)
    }

    public fun borrow_object_by_index<T0: store + key>(arg0: &0x2::object::UID, arg1: u64) : &T0 {
        borrow_object<T0>(arg0, get_object_id<T0>(arg0, arg1))
    }

    public fun drop<T0: store + key>(arg0: &mut 0x2::object::UID) {
        assert_exists_bucket<T0>(arg0);
        assert_empty_bucket<T0>(arg0);
        let v0 = Marker<T0>{dummy_field: false};
        let v1 = 0x2::dynamic_field::remove<Marker<T0>, Bucket<T0>>(arg0, v0);
        assert_version<T0>(&mut v1);
        let Bucket {
            id      : v2,
            version : _,
            ids     : v4,
            indexes : v5,
            objects : v6,
        } = v1;
        0x2::object::delete(v2);
        0x2::table::destroy_empty<u64, 0x2::object::ID>(v4);
        0x2::table::destroy_empty<0x2::object::ID, u64>(v5);
        0x2::table::destroy_empty<0x2::object::ID, T0>(v6);
    }

    public fun exists_bucket<T0>(arg0: &0x2::object::UID) : bool {
        0x2::dynamic_field::exists_<Marker<T0>>(arg0, marker<T0>())
    }

    public fun exists_object<T0: store + key>(arg0: &0x2::object::UID, arg1: 0x2::object::ID) : bool {
        assert_exists_bucket<T0>(arg0);
        0x2::table::contains<0x2::object::ID, T0>(&borrow_bucket<T0>(arg0).objects, arg1)
    }

    public fun get_object_id<T0: store + key>(arg0: &0x2::object::UID, arg1: u64) : 0x2::object::ID {
        assert_exists_bucket<T0>(arg0);
        let v0 = borrow_bucket<T0>(arg0);
        assert_exists_index<T0>(v0, arg1);
        *0x2::table::borrow<u64, 0x2::object::ID>(&v0.ids, arg1)
    }

    fun internal_borrow_bucket<T0: store + key>(arg0: &0x2::object::UID) : &Bucket<T0> {
        assert_exists_bucket<T0>(arg0);
        0x2::dynamic_field::borrow<Marker<T0>, Bucket<T0>>(arg0, marker<T0>())
    }

    fun internal_borrow_mut_object<T0: store + key>(arg0: &mut Bucket<T0>, arg1: 0x2::object::ID) : &mut T0 {
        0x2::table::borrow_mut<0x2::object::ID, T0>(&mut arg0.objects, arg1)
    }

    fun internal_borrow_object<T0: store + key>(arg0: &Bucket<T0>, arg1: 0x2::object::ID) : &T0 {
        0x2::table::borrow<0x2::object::ID, T0>(&arg0.objects, arg1)
    }

    public fun is_empty<T0: store + key>(arg0: &0x2::object::UID) : bool {
        size<T0>(arg0) == 0
    }

    fun marker<T0>() : Marker<T0> {
        Marker<T0>{dummy_field: false}
    }

    public entry fun migrate<T0: store + key>(arg0: &mut Bucket<T0>) {
        assert!(arg0.version < 1, 10002);
        arg0.version = 1;
    }

    public fun put<T0: store + key>(arg0: &mut 0x2::object::UID, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = marker<T0>();
        if (!0x2::dynamic_field::exists_<Marker<T0>>(arg0, v0)) {
            let v1 = empty<T0>(arg2);
            0x2::dynamic_field::add<Marker<T0>, Bucket<T0>>(arg0, v0, v1);
        };
        let v2 = borrow_mut_bucket<T0>(arg0);
        put_<T0>(v2, arg1, arg2);
    }

    public fun put_<T0: store + key>(arg0: &mut Bucket<T0>, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        let v0 = 0x2::object::id<T0>(&arg1);
        let v1 = 0x2::table::length<u64, 0x2::object::ID>(&arg0.ids);
        add<T0>(arg0, v1, v0, arg1);
        let v2 = PutEvent<T0>{
            sender    : 0x2::tx_context::sender(arg2),
            object_id : v0,
        };
        0x2::event::emit<PutEvent<T0>>(v2);
    }

    public fun size<T0: store + key>(arg0: &0x2::object::UID) : u64 {
        assert_exists_bucket<T0>(arg0);
        let v0 = Marker<T0>{dummy_field: false};
        0x2::table::length<u64, 0x2::object::ID>(&0x2::dynamic_field::borrow<Marker<T0>, Bucket<T0>>(arg0, v0).ids)
    }

    public fun take<T0: store + key>(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : T0 {
        assert_exists_bucket<T0>(arg0);
        let v0 = borrow_mut_bucket<T0>(arg0);
        take_<T0>(v0, arg1, arg2)
    }

    public fun take_<T0: store + key>(arg0: &mut Bucket<T0>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : T0 {
        assert_version<T0>(arg0);
        assert_exists_object<T0>(arg0, arg1);
        let v0 = 0x2::table::length<0x2::object::ID, u64>(&arg0.indexes) - 1;
        let v1 = *0x2::table::borrow<0x2::object::ID, u64>(&arg0.indexes, arg1);
        let v2 = remove<T0>(arg0, v1, arg1);
        if (v1 < v0) {
            let v3 = *0x2::table::borrow<u64, 0x2::object::ID>(&mut arg0.ids, v0);
            let v4 = remove<T0>(arg0, v0, v3);
            add<T0>(arg0, v1, v3, v4);
        };
        let v5 = TakeEvent<T0>{
            sender    : 0x2::tx_context::sender(arg2),
            object_id : arg1,
        };
        0x2::event::emit<TakeEvent<T0>>(v5);
        v2
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

