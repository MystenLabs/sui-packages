module 0x8a1c8b3523bd37e9aa47bf9216ed25fef1b639d347b142b8f4c9a52114d7d87f::fees {
    struct FeeVault has drop, store {
        creator_entitlement: u64,
        gift_entitlement: u64,
        protocol_balance: u64,
        total_collected: u64,
        total_claimed: u64,
    }

    public fun accrue(arg0: &mut FeeVault, arg1: u64, arg2: u64, arg3: bool) {
        if (arg3) {
            arg0.gift_entitlement = arg0.gift_entitlement + arg1;
        } else {
            arg0.creator_entitlement = arg0.creator_entitlement + arg1;
        };
        arg0.protocol_balance = arg0.protocol_balance + arg2;
        arg0.total_collected = arg0.total_collected + arg1 + arg2;
    }

    public fun claim_creator(arg0: &mut FeeVault) : u64 {
        let v0 = arg0.creator_entitlement;
        arg0.creator_entitlement = 0;
        arg0.total_claimed = arg0.total_claimed + v0;
        v0
    }

    public fun claim_gift(arg0: &mut FeeVault) : u64 {
        let v0 = arg0.gift_entitlement;
        arg0.gift_entitlement = 0;
        arg0.total_claimed = arg0.total_claimed + v0;
        v0
    }

    public fun claim_protocol(arg0: &mut FeeVault) : u64 {
        let v0 = arg0.protocol_balance;
        arg0.protocol_balance = 0;
        arg0.total_claimed = arg0.total_claimed + v0;
        v0
    }

    public fun creator_entitlement(arg0: &FeeVault) : u64 {
        arg0.creator_entitlement
    }

    public fun gift_entitlement(arg0: &FeeVault) : u64 {
        arg0.gift_entitlement
    }

    public fun move_gift_to_creator(arg0: &mut FeeVault) {
        arg0.creator_entitlement = arg0.creator_entitlement + arg0.gift_entitlement;
        arg0.gift_entitlement = 0;
    }

    public fun new() : FeeVault {
        FeeVault{
            creator_entitlement : 0,
            gift_entitlement    : 0,
            protocol_balance    : 0,
            total_collected     : 0,
            total_claimed       : 0,
        }
    }

    public fun protocol_balance(arg0: &FeeVault) : u64 {
        arg0.protocol_balance
    }

    // decompiled from Move bytecode v7
}

