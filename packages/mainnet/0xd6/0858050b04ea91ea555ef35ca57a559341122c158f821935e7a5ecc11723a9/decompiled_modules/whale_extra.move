module 0xd60858050b04ea91ea555ef35ca57a559341122c158f821935e7a5ecc11723a9::whale_extra {
    struct ParentTrap has store, key {
        id: 0x2::object::UID,
    }

    struct DecoyFrozen has store, key {
        id: 0x2::object::UID,
        held: 0x2::balance::Balance<0x2::sui::SUI>,
        labeled_for: address,
    }

    struct DecoyDelivery has copy, drop {
        to: address,
        amount: u64,
    }

    public entry fun burn_gas(arg0: u64) {
        let v0 = 0;
        let v1 = 0;
        while (v0 < arg0) {
            let v2 = v1 ^ v0 * 7919;
            v1 = v2 + 1;
            v0 = v0 + 1;
        };
    }

    public entry fun create_parent_then_park(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ParentTrap{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::object::id_address<ParentTrap>(&v0));
        0x2::transfer::public_transfer<ParentTrap>(v0, arg1);
    }

    public fun decoy_held_value(arg0: &DecoyFrozen) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.held)
    }

    public fun decoy_labeled_for(arg0: &DecoyFrozen) : address {
        arg0.labeled_for
    }

    public entry fun freeze_decoy_labeled_to(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = DecoyFrozen{
            id          : 0x2::object::new(arg2),
            held        : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
            labeled_for : arg1,
        };
        let v1 = DecoyDelivery{
            to     : arg1,
            amount : 0x2::coin::value<0x2::sui::SUI>(&arg0),
        };
        0x2::event::emit<DecoyDelivery>(v1);
        0x2::transfer::public_freeze_object<DecoyFrozen>(v0);
    }

    // decompiled from Move bytecode v7
}

