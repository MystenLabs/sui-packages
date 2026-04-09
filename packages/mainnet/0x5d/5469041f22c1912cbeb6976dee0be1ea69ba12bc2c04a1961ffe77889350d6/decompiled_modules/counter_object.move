module 0x5d5469041f22c1912cbeb6976dee0be1ea69ba12bc2c04a1961ffe77889350d6::counter_object {
    struct Counter has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    public fun add(arg0: &mut Counter, arg1: u64) {
        arg0.value = arg0.value + arg1;
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Counter{
            id    : 0x2::object::new(arg0),
            value : 0,
        };
        0x2::transfer::transfer<Counter>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun inc(arg0: &mut Counter) {
        arg0.value = arg0.value + 1;
    }

    public fun inc_by(arg0: &mut Counter, arg1: u64) {
        arg0.value = arg0.value + arg1;
    }

    public fun value(arg0: &Counter) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

