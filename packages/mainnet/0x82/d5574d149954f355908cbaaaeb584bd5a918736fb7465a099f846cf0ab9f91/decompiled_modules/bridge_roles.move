module 0x82d5574d149954f355908cbaaaeb584bd5a918736fb7465a099f846cf0ab9f91::bridge_roles {
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
        safe_id: 0x2::object::ID,
    }

    struct BridgeWitness has drop {
        dummy_field: bool,
    }

    public(friend) fun new<T0>(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : Roles<T0> {
        let v0 = 0x2::bag::new(arg1);
        let v1 = OwnerKey{dummy_field: false};
        let v2 = OwnerRole<T0>{dummy_field: false};
        0x2::bag::add<OwnerKey, 0x82d5574d149954f355908cbaaaeb584bd5a918736fb7465a099f846cf0ab9f91::two_step_role::TwoStepRole<OwnerRole<T0>>>(&mut v0, v1, 0x82d5574d149954f355908cbaaaeb584bd5a918736fb7465a099f846cf0ab9f91::two_step_role::new<OwnerRole<T0>>(v2, arg0));
        Roles<T0>{data: v0}
    }

    public(friend) fun bridge_cap_safe_id(arg0: &BridgeCap) : 0x2::object::ID {
        arg0.safe_id
    }

    public(friend) fun grant_witness() : BridgeWitness {
        BridgeWitness{dummy_field: false}
    }

    public fun owner<T0>(arg0: &Roles<T0>) : address {
        0x82d5574d149954f355908cbaaaeb584bd5a918736fb7465a099f846cf0ab9f91::two_step_role::active_address<OwnerRole<T0>>(owner_role<T0>(arg0))
    }

    public(friend) fun owner_role<T0>(arg0: &Roles<T0>) : &0x82d5574d149954f355908cbaaaeb584bd5a918736fb7465a099f846cf0ab9f91::two_step_role::TwoStepRole<OwnerRole<T0>> {
        let v0 = OwnerKey{dummy_field: false};
        0x2::bag::borrow<OwnerKey, 0x82d5574d149954f355908cbaaaeb584bd5a918736fb7465a099f846cf0ab9f91::two_step_role::TwoStepRole<OwnerRole<T0>>>(&arg0.data, v0)
    }

    public(friend) fun owner_role_mut<T0>(arg0: &mut Roles<T0>) : &mut 0x82d5574d149954f355908cbaaaeb584bd5a918736fb7465a099f846cf0ab9f91::two_step_role::TwoStepRole<OwnerRole<T0>> {
        let v0 = OwnerKey{dummy_field: false};
        0x2::bag::borrow_mut<OwnerKey, 0x82d5574d149954f355908cbaaaeb584bd5a918736fb7465a099f846cf0ab9f91::two_step_role::TwoStepRole<OwnerRole<T0>>>(&mut arg0.data, v0)
    }

    public fun pending_owner<T0>(arg0: &Roles<T0>) : 0x1::option::Option<address> {
        0x82d5574d149954f355908cbaaaeb584bd5a918736fb7465a099f846cf0ab9f91::two_step_role::pending_address<OwnerRole<T0>>(owner_role<T0>(arg0))
    }

    public(friend) fun publish_caps(arg0: BridgeWitness, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : BridgeCap {
        BridgeCap{
            id      : 0x2::object::new(arg2),
            safe_id : arg1,
        }
    }

    public(friend) fun transfer_bridge_capability(arg0: BridgeCap, arg1: address) {
        assert!(arg1 != @0x0, 0);
        0x2::transfer::public_transfer<BridgeCap>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

