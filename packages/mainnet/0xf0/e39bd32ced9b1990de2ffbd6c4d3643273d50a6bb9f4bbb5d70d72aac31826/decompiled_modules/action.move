module 0xf0e39bd32ced9b1990de2ffbd6c4d3643273d50a6bb9f4bbb5d70d72aac31826::action {
    struct TicketTable has store, key {
        id: 0x2::object::UID,
        tickets: 0x2::table::Table<0x1::string::String, Ticket>,
    }

    struct Ticket has copy, drop, store {
        ticket_id: 0x1::string::String,
        recipient: address,
        amount: u64,
    }

    struct MintEvent has copy, drop {
        sender: 0x1::string::String,
        recipient: 0x1::string::String,
        minted_amount: u64,
    }

    struct MintTicketEvent has copy, drop {
        ticket_id: 0x1::string::String,
        sender: 0x1::string::String,
        recipient: 0x1::string::String,
        minted_amount: u64,
    }

    struct CollectFeeEvent has copy, drop {
        sender: 0x1::string::String,
        recipient: 0x1::string::String,
        fee_coin_id: 0x1::string::String,
        fee_amount: u64,
    }

    struct BurnEvent has copy, drop {
        sender: 0x1::string::String,
        recipient: 0x1::string::String,
        burned_coin_id: 0x1::string::String,
        burned_amount: u64,
    }

    struct RedeemEvent has copy, drop {
        target_chain_id: 0x1::string::String,
        token_id: 0x1::string::String,
        sender: 0x1::string::String,
        receiver: 0x1::string::String,
        amount: u64,
        action: 0x1::string::String,
        memo: 0x1::option::Option<0x1::string::String>,
    }

    struct PortOwnerCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun burn_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x2::coin::Coin<T0>>(&arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        let v1 = BurnEvent{
            sender         : 0x2::address::to_string(0x2::tx_context::sender(arg2)),
            recipient      : 0x2::address::to_string(arg1),
            burned_coin_id : 0x2::address::to_string(0x2::object::id_to_address(&v0)),
            burned_amount  : 0x2::coin::value<T0>(&arg0),
        };
        0x2::event::emit<BurnEvent>(v1);
    }

    public entry fun collect_fee<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x2::coin::Coin<T0>>(&arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        let v1 = CollectFeeEvent{
            sender      : 0x2::address::to_string(0x2::tx_context::sender(arg2)),
            recipient   : 0x2::address::to_string(arg1),
            fee_coin_id : 0x2::address::to_string(0x2::object::id_to_address(&v0)),
            fee_amount  : 0x2::coin::value<T0>(&arg0),
        };
        0x2::event::emit<CollectFeeEvent>(v1);
    }

    entry fun create_ticket_table(arg0: &PortOwnerCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = TicketTable{
            id      : 0x2::object::new(arg2),
            tickets : 0x2::table::new<0x1::string::String, Ticket>(arg2),
        };
        0x2::transfer::transfer<TicketTable>(v0, arg1);
    }

    entry fun drop_ticket_table(arg0: &PortOwnerCap, arg1: TicketTable) {
        let TicketTable {
            id      : v0,
            tickets : v1,
        } = arg1;
        0x2::table::drop<0x1::string::String, Ticket>(v1);
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PortOwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<PortOwnerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun mint<T0>(arg0: &PortOwnerCap, arg1: address, arg2: u64, arg3: &mut 0x2::coin::TreasuryCap<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<T0>(arg3, arg2, arg1, arg4);
        let v0 = MintEvent{
            sender        : 0x2::address::to_string(0x2::tx_context::sender(arg4)),
            recipient     : 0x2::address::to_string(arg1),
            minted_amount : arg2,
        };
        0x2::event::emit<MintEvent>(v0);
    }

    entry fun mint_with_ticket<T0>(arg0: &PortOwnerCap, arg1: &mut TicketTable, arg2: 0x1::string::String, arg3: address, arg4: u64, arg5: &mut 0x2::coin::TreasuryCap<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::string::String, Ticket>(&arg1.tickets, arg2) == false, 1);
        0x2::coin::mint_and_transfer<T0>(arg5, arg4, arg3, arg6);
        let v0 = Ticket{
            ticket_id : arg2,
            recipient : arg3,
            amount    : arg4,
        };
        0x2::table::add<0x1::string::String, Ticket>(&mut arg1.tickets, arg2, v0);
        let v1 = MintTicketEvent{
            ticket_id     : arg2,
            sender        : 0x2::address::to_string(0x2::tx_context::sender(arg6)),
            recipient     : 0x2::address::to_string(arg3),
            minted_amount : arg4,
        };
        0x2::event::emit<MintTicketEvent>(v1);
    }

    entry fun minted_ticket(arg0: &TicketTable, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, Ticket>(&arg0.tickets, arg1)
    }

    entry fun redeem(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: 0x1::option::Option<0x1::string::String>, arg5: &0x2::tx_context::TxContext) {
        let v0 = RedeemEvent{
            target_chain_id : arg0,
            token_id        : arg1,
            sender          : 0x2::address::to_string(0x2::tx_context::sender(arg5)),
            receiver        : arg2,
            amount          : arg3,
            action          : 0x1::string::utf8(b"Redeem"),
            memo            : arg4,
        };
        0x2::event::emit<RedeemEvent>(v0);
    }

    entry fun remove_ticket(arg0: &PortOwnerCap, arg1: &mut TicketTable, arg2: 0x1::string::String) {
        0x2::table::remove<0x1::string::String, Ticket>(&mut arg1.tickets, arg2);
    }

    // decompiled from Move bytecode v6
}

