module 0x923f7af12f2e94b104f198d8c017423890f1057df2e5e605a85bb349649eea4c::num {
    struct Num has store, key {
        id: 0x2::object::UID,
        n: u64,
    }

    struct NumIssuerCap has key {
        id: 0x2::object::UID,
        supply: u64,
        issued_counter: u64,
    }

    public fun burn(arg0: &mut NumIssuerCap, arg1: Num) {
        let Num {
            id : v0,
            n  : _,
        } = arg1;
        arg0.supply = arg0.supply - 1;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NumIssuerCap{
            id             : 0x2::object::new(arg0),
            supply         : 0,
            issued_counter : 0,
        };
        0x2::transfer::transfer<NumIssuerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun mint(arg0: &mut NumIssuerCap, arg1: &mut 0x2::tx_context::TxContext) : Num {
        let v0 = arg0.issued_counter;
        arg0.issued_counter = v0 + 1;
        arg0.supply = arg0.supply + 1;
        assert!(v0 <= 10, 0);
        Num{
            id : 0x2::object::new(arg1),
            n  : v0,
        }
    }

    // decompiled from Move bytecode v6
}

