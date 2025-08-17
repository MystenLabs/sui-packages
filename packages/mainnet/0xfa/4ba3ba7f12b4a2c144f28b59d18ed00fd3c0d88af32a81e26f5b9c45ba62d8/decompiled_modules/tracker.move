module 0xfa4ba3ba7f12b4a2c144f28b59d18ed00fd3c0d88af32a81e26f5b9c45ba62d8::tracker {
    struct Habits has store, key {
        id: 0x2::object::UID,
        items: vector<0x1::string::String>,
    }

    public fun length(arg0: &Habits) : u64 {
        0x1::vector::length<0x1::string::String>(&arg0.items)
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : Habits {
        Habits{
            id    : 0x2::object::new(arg0),
            items : 0x1::vector::empty<0x1::string::String>(),
        }
    }

    public fun add(arg0: &mut Habits, arg1: 0x1::string::String) {
        0x1::vector::push_back<0x1::string::String>(&mut arg0.items, arg1);
    }

    public fun destroy(arg0: Habits) {
        let Habits {
            id    : v0,
            items : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

