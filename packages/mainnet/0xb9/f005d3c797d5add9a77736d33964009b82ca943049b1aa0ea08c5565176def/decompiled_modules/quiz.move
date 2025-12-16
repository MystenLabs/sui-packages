module 0xb9f005d3c797d5add9a77736d33964009b82ca943049b1aa0ea08c5565176def::quiz {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Badge has store, key {
        id: 0x2::object::UID,
        name: vector<u8>,
        score: u8,
        total: u8,
    }

    struct BadgeMinted has copy, drop {
        recipient: address,
        score: u8,
        total: u8,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun mint_badge(arg0: &AdminCap, arg1: address, arg2: u8, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= arg3, 1);
        let v0 = Badge{
            id    : 0x2::object::new(arg4),
            name  : b"Sui Savvy",
            score : arg2,
            total : arg3,
        };
        0x2::transfer::transfer<Badge>(v0, arg1);
        let v1 = BadgeMinted{
            recipient : arg1,
            score     : arg2,
            total     : arg3,
        };
        0x2::event::emit<BadgeMinted>(v1);
    }

    // decompiled from Move bytecode v6
}

