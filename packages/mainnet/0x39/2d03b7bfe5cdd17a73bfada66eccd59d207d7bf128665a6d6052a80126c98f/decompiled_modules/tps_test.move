module 0x392d03b7bfe5cdd17a73bfada66eccd59d207d7bf128665a6d6052a80126c98f::tps_test {
    struct Counter has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    struct GlobalState has key {
        id: 0x2::object::UID,
        total_created: u64,
        registry: 0x2::table::Table<u64, 0x2::object::ID>,
    }

    struct NewCounterEvent has copy, drop {
        key: u64,
        object_id: 0x2::object::ID,
    }

    public fun create_counter(arg0: &mut GlobalState, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.total_created;
        let v1 = Counter{
            id    : 0x2::object::new(arg1),
            value : 0,
        };
        let v2 = 0x2::object::id<Counter>(&v1);
        0x2::table::add<u64, 0x2::object::ID>(&mut arg0.registry, v0, v2);
        arg0.total_created = v0 + 1;
        let v3 = NewCounterEvent{
            key       : v0,
            object_id : v2,
        };
        0x2::event::emit<NewCounterEvent>(v3);
        0x2::transfer::share_object<Counter>(v1);
    }

    public fun get_counter_id(arg0: &GlobalState, arg1: u64) : 0x2::object::ID {
        *0x2::table::borrow<u64, 0x2::object::ID>(&arg0.registry, arg1)
    }

    public fun get_total_created(arg0: &GlobalState) : u64 {
        arg0.total_created
    }

    public fun get_value(arg0: &Counter) : u64 {
        arg0.value
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalState{
            id            : 0x2::object::new(arg0),
            total_created : 0,
            registry      : 0x2::table::new<u64, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<GlobalState>(v0);
    }

    public fun operate(arg0: &mut Counter, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.value = arg0.value + 1;
    }

    // decompiled from Move bytecode v6
}

