module 0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct OperatorCap has store, key {
        id: 0x2::object::UID,
    }

    struct GuardianCap has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = mint_caps(arg0);
        let v3 = 0x2::tx_context::sender(arg0);
        0x2::transfer::public_transfer<AdminCap>(v0, v3);
        0x2::transfer::public_transfer<OperatorCap>(v1, v3);
        0x2::transfer::public_transfer<GuardianCap>(v2, v3);
    }

    public(friend) fun mint_caps(arg0: &mut 0x2::tx_context::TxContext) : (AdminCap, OperatorCap, GuardianCap) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = OperatorCap{id: 0x2::object::new(arg0)};
        let v2 = GuardianCap{id: 0x2::object::new(arg0)};
        (v0, v1, v2)
    }

    public fun transfer_admin(arg0: AdminCap, arg1: address) {
        0x2::transfer::public_transfer<AdminCap>(arg0, arg1);
    }

    public fun transfer_guardian(arg0: GuardianCap, arg1: address) {
        0x2::transfer::public_transfer<GuardianCap>(arg0, arg1);
    }

    public fun transfer_operator(arg0: OperatorCap, arg1: address) {
        0x2::transfer::public_transfer<OperatorCap>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

