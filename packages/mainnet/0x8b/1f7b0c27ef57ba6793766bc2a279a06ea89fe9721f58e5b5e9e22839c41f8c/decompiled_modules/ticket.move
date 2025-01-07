module 0x8b1f7b0c27ef57ba6793766bc2a279a06ea89fe9721f58e5b5e9e22839c41f8c::ticket {
    struct Ticket has key {
        id: 0x2::object::UID,
        count: u64,
        player: address,
    }

    entry fun burn(arg0: Ticket, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == player(&arg0), 1);
        let Ticket {
            id     : v0,
            count  : _,
            player : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun count(arg0: &Ticket) : u64 {
        arg0.count
    }

    public fun get_vrf_input_and_increment(arg0: &mut Ticket) : vector<u8> {
        let v0 = 0x2::object::id_bytes<Ticket>(arg0);
        let v1 = count(arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&v1));
        increment(arg0);
        v0
    }

    fun increment(arg0: &mut Ticket) {
        arg0.count = arg0.count + 1;
    }

    entry fun mint(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Ticket{
            id     : 0x2::object::new(arg0),
            count  : 0,
            player : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::transfer<Ticket>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun player(arg0: &Ticket) : address {
        arg0.player
    }

    // decompiled from Move bytecode v6
}

