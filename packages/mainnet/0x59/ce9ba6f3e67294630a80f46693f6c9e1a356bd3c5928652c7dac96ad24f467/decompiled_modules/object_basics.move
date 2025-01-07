module 0x59ce9ba6f3e67294630a80f46693f6c9e1a356bd3c5928652c7dac96ad24f467::object_basics {
    struct Object has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    struct Wrapper has key {
        id: 0x2::object::UID,
        o: Object,
    }

    struct NewValueEvent has copy, drop {
        new_value: u64,
    }

    public entry fun delete(arg0: Object) {
        let Object {
            id    : v0,
            value : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun transfer(arg0: Object, arg1: address) {
        0x2::transfer::public_transfer<Object>(arg0, arg1);
    }

    public entry fun create(arg0: u64, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Object{
            id    : 0x2::object::new(arg2),
            value : arg0,
        };
        0x2::transfer::public_transfer<Object>(v0, arg1);
    }

    public entry fun freeze_object(arg0: Object) {
        0x2::transfer::public_freeze_object<Object>(arg0);
    }

    public entry fun set_value(arg0: &mut Object, arg1: u64) {
        arg0.value = arg1;
    }

    public entry fun unwrap(arg0: Wrapper, arg1: &mut 0x2::tx_context::TxContext) {
        let Wrapper {
            id : v0,
            o  : v1,
        } = arg0;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<Object>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun update(arg0: &mut Object, arg1: &Object) {
        arg0.value = arg1.value;
        let v0 = NewValueEvent{new_value: arg1.value};
        0x2::event::emit<NewValueEvent>(v0);
    }

    public entry fun wrap(arg0: Object, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Wrapper{
            id : 0x2::object::new(arg1),
            o  : arg0,
        };
        0x2::transfer::transfer<Wrapper>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

