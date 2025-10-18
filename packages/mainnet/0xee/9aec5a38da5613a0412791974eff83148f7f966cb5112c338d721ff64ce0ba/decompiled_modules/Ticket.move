module 0xee9aec5a38da5613a0412791974eff83148f7f966cb5112c338d721ff64ce0ba::Ticket {
    struct TicketPrice has store, key {
        id: 0x2::object::UID,
        goldPrice: u64,
        sliverPrice: u64,
        bronzePrice: u64,
    }

    struct Ticket has store, key {
        id: 0x2::object::UID,
        price: u64,
        buyTime: u64,
        level: 0x1::string::String,
    }

    struct TicketAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BuyTicket has copy, drop {
        buyer: address,
        time: u64,
        level: 0x1::string::String,
    }

    entry fun buyTicket(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &TicketPrice, arg2: &mut 0xee9aec5a38da5613a0412791974eff83148f7f966cb5112c338d721ff64ce0ba::prizePool::PrizePool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) > 0, 1);
        let v0 = 0xee9aec5a38da5613a0412791974eff83148f7f966cb5112c338d721ff64ce0ba::prizePool::getPoolLevel(arg2);
        if (v0 == 0x1::string::utf8(b"gold")) {
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == arg1.goldPrice, 2);
            let v1 = Ticket{
                id      : 0x2::object::new(arg4),
                price   : 0x2::coin::value<0x2::sui::SUI>(&arg0),
                buyTime : 0x2::clock::timestamp_ms(arg3),
                level   : 0x1::string::utf8(b"gold"),
            };
            0x2::transfer::public_transfer<Ticket>(v1, 0x2::tx_context::sender(arg4));
        } else if (v0 == 0x1::string::utf8(b"sliver")) {
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == arg1.sliverPrice, 3);
            let v2 = Ticket{
                id      : 0x2::object::new(arg4),
                price   : 0x2::coin::value<0x2::sui::SUI>(&arg0),
                buyTime : 0x2::clock::timestamp_ms(arg3),
                level   : 0x1::string::utf8(b"sliver"),
            };
            0x2::transfer::public_transfer<Ticket>(v2, 0x2::tx_context::sender(arg4));
        } else if (v0 == 0x1::string::utf8(b"bronze")) {
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == arg1.bronzePrice, 4);
            let v3 = Ticket{
                id      : 0x2::object::new(arg4),
                price   : 0x2::coin::value<0x2::sui::SUI>(&arg0),
                buyTime : 0x2::clock::timestamp_ms(arg3),
                level   : 0x1::string::utf8(b"bronze"),
            };
            0x2::transfer::public_transfer<Ticket>(v3, 0x2::tx_context::sender(arg4));
        };
        0xee9aec5a38da5613a0412791974eff83148f7f966cb5112c338d721ff64ce0ba::prizePool::updateBalance(arg2, arg0);
        let v4 = BuyTicket{
            buyer : 0x2::tx_context::sender(arg4),
            time  : 0x2::clock::timestamp_ms(arg3),
            level : v0,
        };
        0x2::event::emit<BuyTicket>(v4);
    }

    public fun delTicket(arg0: Ticket) {
        let Ticket {
            id      : v0,
            price   : _,
            buyTime : _,
            level   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun getPrice(arg0: &TicketPrice) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        0x1::vector::push_back<u64>(v1, arg0.goldPrice);
        0x1::vector::push_back<u64>(v1, arg0.sliverPrice);
        0x1::vector::push_back<u64>(v1, arg0.bronzePrice);
        v0
    }

    public fun getTicketLevel(arg0: &Ticket) : 0x1::string::String {
        arg0.level
    }

    public fun getTicketPrice(arg0: &Ticket) : u64 {
        arg0.price
    }

    public fun getTicketTime(arg0: &Ticket) : u64 {
        arg0.buyTime
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TicketPrice{
            id          : 0x2::object::new(arg0),
            goldPrice   : 1000000000,
            sliverPrice : 500000000,
            bronzePrice : 100000000,
        };
        0x2::transfer::public_share_object<TicketPrice>(v0);
        let v1 = TicketAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<TicketAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun updatePrice(arg0: &TicketAdminCap, arg1: &mut TicketPrice, arg2: u64, arg3: u64, arg4: u64) {
        arg1.goldPrice = arg2;
        arg1.sliverPrice = arg3;
        arg1.bronzePrice = arg4;
    }

    // decompiled from Move bytecode v6
}

