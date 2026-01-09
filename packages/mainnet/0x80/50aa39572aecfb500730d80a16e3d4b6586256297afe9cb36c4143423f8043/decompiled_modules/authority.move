module 0x8050aa39572aecfb500730d80a16e3d4b6586256297afe9cb36c4143423f8043::authority {
    struct ADMIN {
        dummy_field: bool,
    }

    struct ASSISTANT {
        dummy_field: bool,
    }

    struct Capability<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun create_assistant_cap(arg0: &mut 0x2::tx_context::TxContext) : Capability<ASSISTANT> {
        Capability<ASSISTANT>{id: 0x2::object::new(arg0)}
    }

    public(friend) fun delete_assistant_cap(arg0: Capability<ASSISTANT>) {
        let Capability { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Capability<ADMIN>{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Capability<ADMIN>>(v1, v0);
        let v2 = Capability<ASSISTANT>{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Capability<ASSISTANT>>(v2, v0);
    }

    // decompiled from Move bytecode v6
}

