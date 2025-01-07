module 0x4b36c63ae68fdb933598150bf96d1f963809e9ceb7418967f32097c81443e0::object {
    struct Object has key {
        id: 0x2::object::UID,
        custom_field: u64,
        child_obj: ChildObject,
        nested_obj: AnotherObject,
    }

    struct ChildObject has store {
        a_field: bool,
    }

    struct AnotherObject has store, key {
        id: 0x2::object::UID,
    }

    public fun transfer(arg0: Object, arg1: address) {
        assert!(some_conditional_logic(), 0);
        0x2::transfer::transfer<Object>(arg0, arg1);
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) : Object {
        let v0 = ChildObject{a_field: false};
        let v1 = AnotherObject{id: 0x2::object::new(arg0)};
        Object{
            id           : 0x2::object::new(arg0),
            custom_field : 0,
            child_obj    : v0,
            nested_obj   : v1,
        }
    }

    public entry fun main(arg0: &Object, arg1: &mut Object, arg2: Object, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        write_field(arg1, read_field(arg0) + arg3);
        transfer(arg2, arg4);
        let v0 = 0x2::tx_context::sender(arg5);
        0x2::transfer::transfer<Object>(create(arg5), v0);
    }

    public fun read_field(arg0: &Object) : u64 {
        arg0.custom_field
    }

    fun some_conditional_logic() : bool {
        true
    }

    public fun write_field(arg0: &mut Object, arg1: u64) {
        if (some_conditional_logic()) {
            arg0.custom_field = arg1;
        };
    }

    // decompiled from Move bytecode v6
}

