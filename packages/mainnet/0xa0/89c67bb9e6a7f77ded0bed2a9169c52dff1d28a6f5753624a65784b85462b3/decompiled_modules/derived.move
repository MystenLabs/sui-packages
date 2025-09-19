module 0xa089c67bb9e6a7f77ded0bed2a9169c52dff1d28a6f5753624a65784b85462b3::derived {
    struct Base has key {
        id: 0x2::object::UID,
    }

    struct Derived has key {
        id: 0x2::object::UID,
    }

    public fun delete_base(arg0: Base) {
        let Base { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun delete_derived(arg0: Derived) {
        let Derived { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = 0;
        while (v1 < 5) {
            let v2 = Derived{id: 0x2::derived_object::claim<u64>(&mut v0, v1)};
            0x2::transfer::share_object<Derived>(v2);
            v1 = v1 + 1;
        };
        let v3 = Base{id: v0};
        0x2::transfer::share_object<Base>(v3);
    }

    // decompiled from Move bytecode v6
}

