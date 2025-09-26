module 0x1bf64c1d657ec6b726b7e655d44bdd3b9117016977d4d153c657dd6848feebb3::treasury {
    struct GovernanceCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun governance_mint(arg0: &GovernanceCap, arg1: &0x1bf64c1d657ec6b726b7e655d44bdd3b9117016977d4d153c657dd6848feebb3::tether_usdt_sui::AdminCap, arg2: &mut 0x1bf64c1d657ec6b726b7e655d44bdd3b9117016977d4d153c657dd6848feebb3::tether_usdt_sui::TreasuryManager, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x1bf64c1d657ec6b726b7e655d44bdd3b9117016977d4d153c657dd6848feebb3::tether_usdt_sui::mint(arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun governance_pause(arg0: &GovernanceCap, arg1: &0x1bf64c1d657ec6b726b7e655d44bdd3b9117016977d4d153c657dd6848feebb3::tether_usdt_sui::AdminCap, arg2: &mut 0x1bf64c1d657ec6b726b7e655d44bdd3b9117016977d4d153c657dd6848feebb3::tether_usdt_sui::TreasuryManager, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        0x1bf64c1d657ec6b726b7e655d44bdd3b9117016977d4d153c657dd6848feebb3::tether_usdt_sui::set_paused(arg1, arg2, arg3, arg4);
    }

    public entry fun init_governance(arg0: &0x1bf64c1d657ec6b726b7e655d44bdd3b9117016977d4d153c657dd6848feebb3::tether_usdt_sui::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GovernanceCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<GovernanceCap>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

