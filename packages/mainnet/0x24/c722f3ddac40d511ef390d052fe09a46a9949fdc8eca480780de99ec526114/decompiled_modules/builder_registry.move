module 0x24c722f3ddac40d511ef390d052fe09a46a9949fdc8eca480780de99ec526114::builder_registry {
    struct BuilderRegistry has key {
        id: 0x2::object::UID,
        next_builder_no: u64,
    }

    public fun claim_builder_number(arg0: &mut BuilderRegistry) : u64 {
        let v0 = arg0.next_builder_no;
        arg0.next_builder_no = v0 + 1;
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BuilderRegistry{
            id              : 0x2::object::new(arg0),
            next_builder_no : 1,
        };
        0x2::transfer::share_object<BuilderRegistry>(v0);
    }

    public fun next_builder_number(arg0: &BuilderRegistry) : u64 {
        arg0.next_builder_no
    }

    // decompiled from Move bytecode v7
}

