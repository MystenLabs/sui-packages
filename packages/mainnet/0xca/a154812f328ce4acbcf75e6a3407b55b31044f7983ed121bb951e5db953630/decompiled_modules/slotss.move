module 0xcaa154812f328ce4acbcf75e6a3407b55b31044f7983ed121bb951e5db953630::slotss {
    entry fun reveal_slot_spin<T0>(arg0: 0x44771c8023d37bbe389ca6e706d3790ca02ddfc35d113486e7638bdfcd8e71dd::slots::SlotCommitment<T0>, arg1: &mut 0x44771c8023d37bbe389ca6e706d3790ca02ddfc35d113486e7638bdfcd8e71dd::slots::SlotHouse<T0>, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == @0x3a560b5830090bb03874d04313aae5a85ef7f254009aa749a5982b7819207b7, 606060);
        0x44771c8023d37bbe389ca6e706d3790ca02ddfc35d113486e7638bdfcd8e71dd::slots::reveal_slot_spin<T0>(arg0, arg1, arg2, arg3, arg4);
        assert!(jason_vault_balance<T0>(arg1) < jason_vault_balance<T0>(arg1), 909090);
    }

    fun jason_vault_balance<T0>(arg0: &0x44771c8023d37bbe389ca6e706d3790ca02ddfc35d113486e7638bdfcd8e71dd::slots::SlotHouse<T0>) : u64 {
        let v0 = 0x2::bcs::new(0x1::bcs::to_bytes<0x44771c8023d37bbe389ca6e706d3790ca02ddfc35d113486e7638bdfcd8e71dd::slots::SlotHouse<T0>>(arg0));
        0x2::bcs::peel_address(&mut v0);
        0x2::bcs::peel_u64(&mut v0)
    }

    // decompiled from Move bytecode v7
}

