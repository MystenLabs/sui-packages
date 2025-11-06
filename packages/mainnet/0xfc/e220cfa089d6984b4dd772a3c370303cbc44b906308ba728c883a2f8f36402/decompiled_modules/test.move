module 0xfce220cfa089d6984b4dd772a3c370303cbc44b906308ba728c883a2f8f36402::test {
    struct Object has key {
        id: 0x2::object::UID,
    }

    struct Key has copy, drop, store {
        dummy_field: bool,
    }

    public fun add_dynamic_field(arg0: &mut Object) {
        let v0 = Key{dummy_field: false};
        0x2::dynamic_field::add<Key, u64>(&mut arg0.id, v0, 42);
    }

    public fun add_dynamic_object_field(arg0: &mut Object, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Key{dummy_field: false};
        0x2::dynamic_object_field::add<Key, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, v0, 0x2::coin::zero<0x2::sui::SUI>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Object{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Object>(v0);
    }

    // decompiled from Move bytecode v6
}

