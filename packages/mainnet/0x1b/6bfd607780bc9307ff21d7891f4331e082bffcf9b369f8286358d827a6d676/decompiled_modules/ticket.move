module 0x1b6bfd607780bc9307ff21d7891f4331e082bffcf9b369f8286358d827a6d676::ticket {
    struct Global has key {
        id: 0x2::object::UID,
        version: u64,
        admin: 0x2::object::ID,
        beneficiary: address,
        ticket_price: u64,
        total_ticket_sale: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BuyTicketEvent has copy, drop {
        buy_id: u64,
        buyer: address,
        number_ticket: u64,
        deposit_amount: u64,
    }

    public entry fun buy_ticket(arg0: &mut Global, arg1: u64, arg2: 0x2::coin::Coin<0x36a84eb78e931d5a00879c7670ec61e4bb42d41c98cc6486c8a05a3b4ca7d752::sht::SHT>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0);
        let v0 = 0x2::coin::value<0x36a84eb78e931d5a00879c7670ec61e4bb42d41c98cc6486c8a05a3b4ca7d752::sht::SHT>(&arg2);
        assert!(v0 == arg0.ticket_price * arg1, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x36a84eb78e931d5a00879c7670ec61e4bb42d41c98cc6486c8a05a3b4ca7d752::sht::SHT>>(arg2, arg0.beneficiary);
        arg0.total_ticket_sale = arg0.total_ticket_sale + 1;
        let v1 = BuyTicketEvent{
            buy_id         : arg0.total_ticket_sale,
            buyer          : 0x2::tx_context::sender(arg3),
            number_ticket  : arg1,
            deposit_amount : v0,
        };
        0x2::event::emit<BuyTicketEvent>(v1);
    }

    public entry fun change_beneficiary_address(arg0: &AdminCap, arg1: &mut Global, arg2: address) {
        arg1.beneficiary = arg2;
    }

    public entry fun change_ticket_price(arg0: &AdminCap, arg1: &mut Global, arg2: u64) {
        arg1.ticket_price = arg2;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Global{
            id                : 0x2::object::new(arg0),
            version           : 1,
            admin             : 0x2::object::id<AdminCap>(&v0),
            beneficiary       : @0x1ef7ee718336e1161cb60369149e8c3cf8da58c1765d791f429872ef81ce03a3,
            ticket_price      : 50000000000,
            total_ticket_sale : 0,
        };
        0x2::transfer::share_object<Global>(v1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun ticket_price(arg0: &Global) : u64 {
        arg0.ticket_price
    }

    // decompiled from Move bytecode v6
}

