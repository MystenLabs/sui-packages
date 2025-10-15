module 0xec0a684bf4afb505a5d601b9262fcf0efa24b20872178932ab826db34508738d::name {
    struct Name has copy, drop {
        name: 0x1::ascii::String,
    }

    public fun get_name<T0>() {
        let v0 = Name{name: 0x1::type_name::into_string(0x1::type_name::get<T0>())};
        0x2::event::emit<Name>(v0);
    }

    // decompiled from Move bytecode v6
}

