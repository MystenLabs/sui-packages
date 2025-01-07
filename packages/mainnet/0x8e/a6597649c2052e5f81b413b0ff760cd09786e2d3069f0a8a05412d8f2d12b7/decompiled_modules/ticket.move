module 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::ticket {
    struct TicketKey<phantom T0> has copy, drop, store {
        epoch: u64,
        ticket_number: u64,
    }

    struct Ticket<phantom T0> has store, key {
        id: 0x2::object::UID,
        epoch: u64,
        ticket_number: u64,
        buyer_address: address,
        lottery_number: vector<u8>,
        reward: u64,
        claimed: bool,
    }

    struct TicketValue<phantom T0> has drop, store {
        ticket_id: 0x2::object::ID,
        lottery_number: vector<u8>,
    }

    struct PurchaseTicketEvent has copy, drop {
        ticket_id: 0x2::object::ID,
        sender: address,
        epoch: u64,
        ticket_number: u64,
        lottery_number: vector<u8>,
        pool: 0x1::string::String,
    }

    public(friend) fun new<T0>(arg0: address, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) : (Ticket<T0>, TicketValue<T0>) {
        let v0 = Ticket<T0>{
            id             : 0x2::object::new(arg5),
            epoch          : arg1,
            ticket_number  : arg2,
            buyer_address  : arg0,
            lottery_number : arg3,
            reward         : 0,
            claimed        : false,
        };
        let v1 = TicketValue<T0>{
            ticket_id      : 0x2::object::uid_to_inner(&v0.id),
            lottery_number : arg3,
        };
        let v2 = PurchaseTicketEvent{
            ticket_id      : 0x2::object::uid_to_inner(&v0.id),
            sender         : arg0,
            epoch          : arg1,
            ticket_number  : arg2,
            lottery_number : arg3,
            pool           : arg4,
        };
        0x2::event::emit<PurchaseTicketEvent>(v2);
        (v0, v1)
    }

    public fun get_epoch<T0>(arg0: &Ticket<T0>) : u64 {
        arg0.epoch
    }

    public fun get_lottery_number<T0>(arg0: &Ticket<T0>) : vector<u8> {
        arg0.lottery_number
    }

    public fun get_lottery_number_value<T0>(arg0: &TicketValue<T0>) : vector<u8> {
        arg0.lottery_number
    }

    public fun get_ticket_info<T0>(arg0: &Ticket<T0>) : (u64, vector<u8>, bool, u64, address) {
        (arg0.ticket_number, arg0.lottery_number, arg0.claimed, arg0.epoch, arg0.buyer_address)
    }

    public fun get_ticket_number<T0>(arg0: &Ticket<T0>) : u64 {
        arg0.ticket_number
    }

    public fun is_claimed<T0>(arg0: &Ticket<T0>) : bool {
        arg0.claimed
    }

    public(friend) fun new_ticket_key<T0>(arg0: u64, arg1: u64) : TicketKey<T0> {
        TicketKey<T0>{
            epoch         : arg0,
            ticket_number : arg1,
        }
    }

    public(friend) fun set_claimed<T0>(arg0: &mut Ticket<T0>, arg1: bool) {
        arg0.claimed = arg1;
    }

    public(friend) fun ticket_claimed<T0>(arg0: &mut Ticket<T0>, arg1: u64, arg2: bool) {
        arg0.claimed = arg2;
        arg0.reward = arg1;
    }

    // decompiled from Move bytecode v6
}

