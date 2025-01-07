module 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::ticket {
    struct TICKET has drop {
        dummy_field: bool,
    }

    struct TicketKey<phantom T0> has copy, drop, store {
        epoch: u64,
        ticket_number: u64,
    }

    struct Ticket<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        epoch: u64,
        ticket_number: u64,
        buyer_address: address,
        lottery_number: vector<u8>,
        price: u64,
        reward: u64,
        claimed: bool,
    }

    struct TicketValue<phantom T0> has drop, store {
        ticket_id: 0x2::object::ID,
        lottery_number: vector<u8>,
        buyer_address: address,
        price: u64,
    }

    struct PurchaseTicketEvent has copy, drop {
        ticket_id: 0x2::object::ID,
        sender: address,
        epoch: u64,
        ticket_number: u64,
        lottery_number: vector<u8>,
        price: u64,
        pool: 0x1::string::String,
    }

    public(friend) fun display<T0>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"epoch"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"ticket_number"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"buyer_address"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"lottery_number"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"price"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"reward"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"claimed"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://app.pandorafi.xyz/games/the-lottery"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{epoch}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{ticket_number}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{buyer_address}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{lottery_number}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{price}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{reward}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{claimed}"));
        let v4 = 0x2::display::new_with_fields<Ticket<T0>>(arg0, v0, v2, arg1);
        0x2::display::update_version<Ticket<T0>>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<Ticket<T0>>>(v4, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun new<T0>(arg0: address, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: u64, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) : (Ticket<T0>, TicketValue<T0>) {
        let v0 = Ticket<T0>{
            id             : 0x2::object::new(arg6),
            name           : 0x1::string::utf8(b"Pandora Lottery Ticket"),
            description    : 0x1::string::utf8(b"Pandora Lottery Ticket"),
            image_url      : 0x2::url::new_unsafe_from_bytes(b""),
            epoch          : arg1,
            ticket_number  : arg2,
            buyer_address  : arg0,
            lottery_number : arg3,
            price          : arg4,
            reward         : 0,
            claimed        : false,
        };
        let v1 = TicketValue<T0>{
            ticket_id      : 0x2::object::uid_to_inner(&v0.id),
            lottery_number : arg3,
            buyer_address  : arg0,
            price          : arg4,
        };
        let v2 = PurchaseTicketEvent{
            ticket_id      : 0x2::object::uid_to_inner(&v0.id),
            sender         : arg0,
            epoch          : arg1,
            ticket_number  : arg2,
            lottery_number : arg3,
            price          : arg4,
            pool           : arg5,
        };
        0x2::event::emit<PurchaseTicketEvent>(v2);
        (v0, v1)
    }

    public(friend) fun burn<T0>(arg0: Ticket<T0>) {
        let Ticket {
            id             : v0,
            name           : _,
            description    : _,
            image_url      : _,
            epoch          : _,
            ticket_number  : _,
            buyer_address  : _,
            lottery_number : _,
            price          : _,
            reward         : _,
            claimed        : _,
        } = arg0;
        0x2::object::delete(v0);
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

    public fun get_price<T0>(arg0: &Ticket<T0>) : u64 {
        arg0.price
    }

    public fun get_ticket_info<T0>(arg0: &Ticket<T0>) : (u64, vector<u8>, bool, u64, address) {
        (arg0.ticket_number, arg0.lottery_number, arg0.claimed, arg0.epoch, arg0.buyer_address)
    }

    public fun get_ticket_number<T0>(arg0: &Ticket<T0>) : u64 {
        arg0.ticket_number
    }

    fun init(arg0: TICKET, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<TICKET>(arg0, arg1);
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

