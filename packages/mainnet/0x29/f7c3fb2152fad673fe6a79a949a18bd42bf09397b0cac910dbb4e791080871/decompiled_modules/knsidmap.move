module 0x29f7c3fb2152fad673fe6a79a949a18bd42bf09397b0cac910dbb4e791080871::knsidmap {
    struct KNSRegistryTable has key {
        id: 0x2::object::UID,
        idmap: 0x2::table::Table<0x2::object::ID, vector<0x2::object::ID>>,
    }

    struct UpdatedEvent has copy, drop {
        key: 0x2::object::ID,
        value: vector<0x2::object::ID>,
    }

    struct RemovedEvent has copy, drop {
        key: 0x2::object::ID,
    }

    public fun add<T0: key>(arg0: &mut KNSRegistryTable, arg1: &T0, arg2: vector<0x2::object::ID>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<T0>(arg1);
        0x2::table::add<0x2::object::ID, vector<0x2::object::ID>>(&mut arg0.idmap, v0, arg2);
        let v1 = UpdatedEvent{
            key   : v0,
            value : arg2,
        };
        0x2::event::emit<UpdatedEvent>(v1);
    }

    public fun remove<T0: key>(arg0: &mut KNSRegistryTable, arg1: &T0, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<T0>(arg1);
        0x2::table::remove<0x2::object::ID, vector<0x2::object::ID>>(&mut arg0.idmap, v0);
        let v1 = RemovedEvent{key: v0};
        0x2::event::emit<RemovedEvent>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = KNSRegistryTable{
            id    : 0x2::object::new(arg0),
            idmap : 0x2::table::new<0x2::object::ID, vector<0x2::object::ID>>(arg0),
        };
        0x2::transfer::share_object<KNSRegistryTable>(v0);
    }

    public fun update<T0: key>(arg0: &mut KNSRegistryTable, arg1: &T0, arg2: vector<0x2::object::ID>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<T0>(arg1);
        *0x2::table::borrow_mut<0x2::object::ID, vector<0x2::object::ID>>(&mut arg0.idmap, v0) = arg2;
        let v1 = UpdatedEvent{
            key   : v0,
            value : arg2,
        };
        0x2::event::emit<UpdatedEvent>(v1);
    }

    public fun upsert<T0: key>(arg0: &mut KNSRegistryTable, arg1: &T0, arg2: vector<0x2::object::ID>, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<0x2::object::ID, vector<0x2::object::ID>>(&arg0.idmap, 0x2::object::id<T0>(arg1))) {
            add<T0>(arg0, arg1, arg2, arg3);
        } else {
            update<T0>(arg0, arg1, arg2, arg3);
        };
    }

    public fun value(arg0: &KNSRegistryTable, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : vector<0x2::object::ID> {
        *0x2::table::borrow<0x2::object::ID, vector<0x2::object::ID>>(&arg0.idmap, arg1)
    }

    // decompiled from Move bytecode v6
}

