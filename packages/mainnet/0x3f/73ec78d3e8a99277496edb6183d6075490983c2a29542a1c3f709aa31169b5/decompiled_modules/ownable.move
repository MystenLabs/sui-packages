module 0x3f73ec78d3e8a99277496edb6183d6075490983c2a29542a1c3f709aa31169b5::ownable {
    struct OWNABLE has drop {
        dummy_field: bool,
    }

    struct OwnerCap<phantom T0> has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: OWNABLE, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<OWNABLE>(&arg0), 0);
        let v0 = OwnerCap<OWNABLE>{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<OwnerCap<OWNABLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun transfer_ownership<T0>(arg0: OwnerCap<T0>, arg1: address) {
        0x2::transfer::transfer<OwnerCap<T0>>(arg0, arg1);
    }

    public fun version() : 0x1::string::String {
        0x3f73ec78d3e8a99277496edb6183d6075490983c2a29542a1c3f709aa31169b5::version::with_module(b"Ownable")
    }

    // decompiled from Move bytecode v6
}

