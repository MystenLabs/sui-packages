module 0xada641833477e0eb497b9be90f0e633bbfa50d72d57d054f2c89f10ac69c177b::player_profile {
    struct GameAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Scoreboard has key {
        id: 0x2::object::UID,
        ledger: 0x2::table::Table<address, u64>,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GameAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<GameAdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Scoreboard{
            id     : 0x2::object::new(arg0),
            ledger : 0x2::table::new<address, u64>(arg0),
        };
        0x2::transfer::share_object<Scoreboard>(v1);
    }

    public entry fun spend_stars_for_crate(arg0: &mut Scoreboard, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, u64>(&arg0.ledger, v0), 0);
        let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.ledger, v0);
        assert!(*v1 >= arg1, 0);
        *v1 = *v1 - arg1;
    }

    public entry fun update_score(arg0: &GameAdminCap, arg1: &mut Scoreboard, arg2: address, arg3: u64) {
        if (0x2::table::contains<address, u64>(&arg1.ledger, arg2)) {
            let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg1.ledger, arg2);
            *v0 = *v0 + arg3;
        } else {
            0x2::table::add<address, u64>(&mut arg1.ledger, arg2, arg3);
        };
    }

    // decompiled from Move bytecode v7
}

