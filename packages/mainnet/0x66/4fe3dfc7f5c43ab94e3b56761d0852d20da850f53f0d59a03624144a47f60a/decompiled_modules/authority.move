module 0x664fe3dfc7f5c43ab94e3b56761d0852d20da850f53f0d59a03624144a47f60a::authority {
    struct Capability<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct ADMIN {
        dummy_field: bool,
    }

    struct ASSISTANT {
        dummy_field: bool,
    }

    public(friend) fun create_assistant_cap(arg0: &mut 0x2::tx_context::TxContext) : Capability<ASSISTANT> {
        Capability<ASSISTANT>{id: 0x2::object::new(arg0)}
    }

    public(friend) fun delete_assistant_cap(arg0: Capability<ASSISTANT>) {
        let Capability { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Capability<ADMIN>{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Capability<ADMIN>>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Capability<ASSISTANT>{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Capability<ASSISTANT>>(v1, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

