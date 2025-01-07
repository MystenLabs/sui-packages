module 0x8391759e544b7a1a3d3cfa3c4dcc47ab1086fc9d9d12f398fbbb64c7d4be2622::merry_christmas_prize {
    struct Ticket has key {
        id: 0x2::object::UID,
        amount: u64,
    }

    struct ClaimItem has key {
        id: 0x2::object::UID,
        amount_vec: vector<u64>,
    }

    struct PrizePool has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    entry fun change_ticket_amount(arg0: &0x2::random::Random, arg1: &ClaimItem, arg2: &mut Ticket, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg0, arg3);
        arg2.amount = *0x1::vector::borrow<u64>(&arg1.amount_vec, (0x2::random::generate_u8_in_range(&mut v0, 0, 5) as u64));
    }

    entry fun claim_ticket(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        let v1 = 0;
        while (v1 < 0x2::random::generate_u8_in_range(&mut v0, 1, 5)) {
            let v2 = Ticket{
                id     : 0x2::object::new(arg1),
                amount : 10000000,
            };
            0x2::transfer::transfer<Ticket>(v2, 0x2::tx_context::sender(arg1));
            v1 = v1 + 1;
        };
    }

    entry fun cliam_sui(arg0: &mut PrizePool, arg1: vector<Ticket>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = 0x2::balance::zero<0x2::sui::SUI>();
        while (v0 < 0x1::vector::length<Ticket>(&arg1)) {
            let Ticket {
                id     : v2,
                amount : v3,
            } = 0x1::vector::pop_back<Ticket>(&mut arg1);
            0x2::object::delete(v2);
            0x2::balance::join<0x2::sui::SUI>(&mut v1, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v3));
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<Ticket>(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun deposit(arg0: &AdminCap, arg1: &mut PrizePool, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PrizePool{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v1 = ClaimItem{
            id         : 0x2::object::new(arg0),
            amount_vec : 0x1::vector::empty<u64>(),
        };
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x1::vector::push_back<u64>(&mut v1.amount_vec, 0);
        0x1::vector::push_back<u64>(&mut v1.amount_vec, 100000);
        0x1::vector::push_back<u64>(&mut v1.amount_vec, 1000000);
        0x1::vector::push_back<u64>(&mut v1.amount_vec, 10000000);
        0x1::vector::push_back<u64>(&mut v1.amount_vec, 20000000);
        0x1::vector::push_back<u64>(&mut v1.amount_vec, 25000000);
        0x2::transfer::share_object<PrizePool>(v0);
        0x2::transfer::share_object<ClaimItem>(v1);
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg0));
    }

    public entry fun withdraw(arg0: &AdminCap, arg1: &mut PrizePool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

