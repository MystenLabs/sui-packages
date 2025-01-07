module 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::event {
    struct Created<phantom T0> has copy, drop {
        id: 0x2::object::ID,
    }

    struct Update<phantom T0> has copy, drop {
        id: 0x2::object::ID,
    }

    struct Delete<phantom T0> has copy, drop {
        id: 0x2::object::ID,
    }

    public fun create<T0>(arg0: 0x2::object::ID) {
        let v0 = Created<T0>{id: arg0};
        0x2::event::emit<Created<T0>>(v0);
    }

    public fun delete<T0>(arg0: 0x2::object::ID) {
        let v0 = Delete<T0>{id: arg0};
        0x2::event::emit<Delete<T0>>(v0);
    }

    public fun update<T0>(arg0: 0x2::object::ID) {
        let v0 = Update<T0>{id: arg0};
        0x2::event::emit<Update<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

