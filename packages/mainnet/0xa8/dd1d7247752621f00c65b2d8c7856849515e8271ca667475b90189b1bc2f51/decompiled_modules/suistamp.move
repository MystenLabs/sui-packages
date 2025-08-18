module 0xa8dd1d7247752621f00c65b2d8c7856849515e8271ca667475b90189b1bc2f51::suistamp {
    struct Card has key {
        id: 0x2::object::UID,
        stamps: u64,
    }

    struct Badge has key {
        id: 0x2::object::UID,
        stamps_redeemed: u64,
    }

    public fun count(arg0: &Card) : u64 {
        arg0.stamps
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Card{
            id     : 0x2::object::new(arg0),
            stamps : 0,
        };
        0x2::transfer::transfer<Card>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun gift(arg0: Card, arg1: address) {
        0x2::transfer::transfer<Card>(arg0, arg1);
    }

    public fun punch(arg0: &mut Card) {
        assert!(arg0.stamps < 5, 1);
        arg0.stamps = arg0.stamps + 1;
    }

    public fun redeem(arg0: &mut Card, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.stamps >= 5, 2);
        arg0.stamps = 0;
        let v0 = Badge{
            id              : 0x2::object::new(arg1),
            stamps_redeemed : 5,
        };
        0x2::transfer::transfer<Badge>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

