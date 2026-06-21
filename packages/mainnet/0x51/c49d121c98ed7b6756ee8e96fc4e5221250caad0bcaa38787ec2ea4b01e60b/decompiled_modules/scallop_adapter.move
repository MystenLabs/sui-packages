module 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::scallop_adapter {
    struct ScallopPosition<phantom T0> has store, key {
        id: 0x2::object::UID,
        scoin: 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>,
    }

    public fun owner_redeem<T0>(arg0: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::Treasury<T0>, arg1: &0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::OwnerCap<T0>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let ScallopPosition {
            id    : v0,
            scoin : v1,
        } = 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::owner_take_receipt<T0, ScallopPosition<T0>>(arg0, arg1, 1);
        0x2::object::delete(v0);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg2, arg3, 0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(v1, arg5), arg4, arg5)
    }

    public fun supply_and_custody<T0>(arg0: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::Treasury<T0>, arg1: &0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::AgentCap<T0>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        if (0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::has_position<T0>(arg0, 1)) {
            0x2::balance::join<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::borrow_receipt_mut<T0, ScallopPosition<T0>>(arg0, 1).scoin, 0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg2, arg3, 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::release_for_action<T0>(arg0, arg1, arg4, arg5, arg6), arg5, arg6)));
        } else {
            let v0 = ScallopPosition<T0>{
                id    : 0x2::object::new(arg6),
                scoin : 0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg2, arg3, 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::release_for_action<T0>(arg0, arg1, arg4, arg5, arg6), arg5, arg6)),
            };
            0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::custody_receipt<T0, ScallopPosition<T0>>(arg0, 1, v0);
        };
    }

    // decompiled from Move bytecode v7
}

