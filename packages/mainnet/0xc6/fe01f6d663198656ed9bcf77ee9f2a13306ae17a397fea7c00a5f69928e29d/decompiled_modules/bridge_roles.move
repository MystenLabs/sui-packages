module 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles {
    struct BridgeSafeTag has drop {
        dummy_field: bool,
    }

    struct Roles<phantom T0> has store {
        data: 0x2::bag::Bag,
    }

    struct OwnerRole<phantom T0> has drop {
        dummy_field: bool,
    }

    struct OwnerKey has copy, drop, store {
        dummy_field: bool,
    }

    struct BridgeCap has store, key {
        id: 0x2::object::UID,
    }

    struct BridgeWitness has drop {
        dummy_field: bool,
    }

    public(friend) fun new<T0>(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : Roles<T0> {
        let v0 = 0x2::bag::new(arg1);
        let v1 = OwnerKey{dummy_field: false};
        let v2 = OwnerRole<T0>{dummy_field: false};
        0x2::bag::add<OwnerKey, 0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::TwoStepRole<OwnerRole<T0>>>(&mut v0, v1, 0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::new<OwnerRole<T0>>(v2, arg0));
        Roles<T0>{data: v0}
    }

    public(friend) fun grant_witness() : BridgeWitness {
        BridgeWitness{dummy_field: false}
    }

    public fun owner<T0>(arg0: &Roles<T0>) : address {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::active_address<OwnerRole<T0>>(owner_role<T0>(arg0))
    }

    public(friend) fun owner_role<T0>(arg0: &Roles<T0>) : &0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::TwoStepRole<OwnerRole<T0>> {
        let v0 = OwnerKey{dummy_field: false};
        0x2::bag::borrow<OwnerKey, 0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::TwoStepRole<OwnerRole<T0>>>(&arg0.data, v0)
    }

    public(friend) fun owner_role_mut<T0>(arg0: &mut Roles<T0>) : &mut 0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::TwoStepRole<OwnerRole<T0>> {
        let v0 = OwnerKey{dummy_field: false};
        0x2::bag::borrow_mut<OwnerKey, 0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::TwoStepRole<OwnerRole<T0>>>(&mut arg0.data, v0)
    }

    public fun pending_owner<T0>(arg0: &Roles<T0>) : 0x1::option::Option<address> {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::pending_address<OwnerRole<T0>>(owner_role<T0>(arg0))
    }

    public(friend) fun publish_caps(arg0: BridgeWitness, arg1: &mut 0x2::tx_context::TxContext) : BridgeCap {
        BridgeCap{id: 0x2::object::new(arg1)}
    }

    public(friend) fun transfer_bridge_capability(arg0: BridgeCap, arg1: address) {
        assert!(arg1 != @0x0, 0);
        0x2::transfer::public_transfer<BridgeCap>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

