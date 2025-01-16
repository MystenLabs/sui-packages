module 0x27df51ef6874ac97cb461443b19b59d856e925d138ad8aaa426a152aee11f45b::ticket {
    struct Ticket has key {
        id: 0x2::object::UID,
        launchpad_id: 0x2::object::ID,
        name: 0x1::string::String,
        image_url: 0x2::url::Url,
        amount: u64,
        unlock_at: u64,
    }

    struct TicketMintedEvent has copy, drop {
        id: 0x2::object::ID,
        launchpad_id: 0x2::object::ID,
        sender: address,
        name: 0x1::string::String,
        image_url: 0x2::url::Url,
        amount: u64,
        unlock_at: u64,
    }

    struct TicketBurnedEvent has copy, drop {
        id: 0x2::object::ID,
        launchpad_id: 0x2::object::ID,
        sender: address,
        name: 0x1::string::String,
        amount: u64,
    }

    struct TICKET has drop {
        dummy_field: bool,
    }

    public(friend) fun transfer(arg0: Ticket, arg1: address) {
        0x2::transfer::transfer<Ticket>(arg0, arg1);
    }

    public(friend) fun burn_ticket_and_emit(arg0: Ticket, arg1: &0x2::tx_context::TxContext) {
        let v0 = TicketBurnedEvent{
            id           : 0x2::object::id<Ticket>(&arg0),
            launchpad_id : arg0.launchpad_id,
            sender       : 0x2::tx_context::sender(arg1),
            name         : arg0.name,
            amount       : arg0.amount,
        };
        0x2::event::emit<TicketBurnedEvent>(v0);
        let Ticket {
            id           : v1,
            launchpad_id : _,
            name         : _,
            image_url    : _,
            amount       : _,
            unlock_at    : _,
        } = arg0;
        0x2::object::delete(v1);
    }

    public(friend) fun get_launchpad_id(arg0: &Ticket) : 0x2::object::ID {
        arg0.launchpad_id
    }

    public(friend) fun get_unlock_time(arg0: &Ticket) : u64 {
        arg0.unlock_at
    }

    fun init(arg0: TICKET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Suidaos Launchpad Ticket NFT"));
        let v4 = 0x2::package::claim<TICKET>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Ticket>(&v4, v0, v2, arg1);
        0x2::display::update_version<Ticket>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Ticket>>(v5, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun mint_ticket_and_emit(arg0: 0x2::object::ID, arg1: &0x27df51ef6874ac97cb461443b19b59d856e925d138ad8aaa426a152aee11f45b::metadata::Metadata, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : Ticket {
        let (v0, v1, _, _, _, _, _, _, _, _) = 0x27df51ef6874ac97cb461443b19b59d856e925d138ad8aaa426a152aee11f45b::metadata::get_metadata_props(arg1);
        let v10 = Ticket{
            id           : 0x2::object::new(arg4),
            launchpad_id : arg0,
            name         : v0,
            image_url    : 0x2::url::new_unsafe_from_bytes(v1),
            amount       : arg2,
            unlock_at    : arg3,
        };
        let v11 = TicketMintedEvent{
            id           : 0x2::object::id<Ticket>(&v10),
            launchpad_id : arg0,
            sender       : 0x2::tx_context::sender(arg4),
            name         : v0,
            image_url    : v10.image_url,
            amount       : arg2,
            unlock_at    : arg3,
        };
        0x2::event::emit<TicketMintedEvent>(v11);
        v10
    }

    // decompiled from Move bytecode v6
}

