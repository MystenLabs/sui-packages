module 0xe90dd338db0146249bf6d73852040b517beb1765b6d323e56b943c9d83ded821::receiving {
    struct Parent has store, key {
        id: 0x2::object::UID,
        creator: address,
    }

    public entry fun reclaim_attacker_gated(arg0: &mut Parent, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<0x2::sui::SUI>>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::transfer::public_receive<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, arg1), arg0.creator);
    }

    public entry fun reclaim_to_owner(arg0: &mut Parent, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<0x2::sui::SUI>>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::transfer::public_receive<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, arg1), 0x2::tx_context::sender(arg2));
    }

    public entry fun stash_and_send(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Parent{
            id      : 0x2::object::new(arg2),
            creator : 0x2::tx_context::sender(arg2),
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::object::uid_to_address(&v0.id));
        0x2::transfer::public_transfer<Parent>(v0, arg1);
    }

    // decompiled from Move bytecode v7
}

