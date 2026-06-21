module 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::mock_supply {
    struct MockPosition<phantom T0> has store, key {
        id: 0x2::object::UID,
        deposited: 0x2::balance::Balance<T0>,
    }

    public fun owner_redeem<T0>(arg0: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::Treasury<T0>, arg1: &0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::OwnerCap<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let MockPosition {
            id        : v0,
            deposited : v1,
        } = 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::owner_take_receipt<T0, MockPosition<T0>>(arg0, arg1, 255);
        0x2::object::delete(v0);
        0x2::coin::from_balance<T0>(v1, arg2)
    }

    public fun supply_and_custody<T0>(arg0: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::Treasury<T0>, arg1: &0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::AgentCap<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::has_position<T0>(arg0, 255)) {
            0x2::balance::join<T0>(&mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::borrow_receipt_mut<T0, MockPosition<T0>>(arg0, 255).deposited, 0x2::coin::into_balance<T0>(0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::release_for_action<T0>(arg0, arg1, arg2, arg3, arg4)));
        } else {
            let v0 = MockPosition<T0>{
                id        : 0x2::object::new(arg4),
                deposited : 0x2::coin::into_balance<T0>(0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::release_for_action<T0>(arg0, arg1, arg2, arg3, arg4)),
            };
            0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::custody_receipt<T0, MockPosition<T0>>(arg0, 255, v0);
        };
    }

    // decompiled from Move bytecode v7
}

