module 0xf3e4c9a883263b26f7b03626dd2317d23eddbfd2c4f0b6f3d480ff22d8a320a1::authority {
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

