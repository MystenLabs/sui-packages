module 0x1cdf9026d6ba0fc7cf7896e21c52f906a0e0319cb1fb56806cab5c056ad5828d::event_nft {
    struct EVENT_NFT has drop {
        dummy_field: bool,
    }

    struct EventNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        thumbnail: 0x1::string::String,
        event_date: u64,
        links: vector<0x1::string::String>,
        total_capacity: u64,
        tickets_available: u64,
        price: u64,
        organizer: address,
    }

    public(friend) fun decrease_tickets_available(arg0: &mut EventNFT, arg1: u64) {
        assert!(arg0.tickets_available >= arg1, 0);
        arg0.tickets_available = arg0.tickets_available - arg1;
    }

    public fun has_available_ticket(arg0: &EventNFT) : bool {
        arg0.tickets_available > 0
    }

    public fun id(arg0: &EventNFT) : &0x2::object::UID {
        &arg0.id
    }

    fun init(arg0: EVENT_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<EVENT_NFT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"event_date"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"total_capacity"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"price"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"organizer"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Event: {name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{event_date}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{total_capacity}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{price}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{organizer}"));
        let v5 = 0x2::display::new_with_fields<EventNFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<EventNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<EventNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: vector<0x1::string::String>, arg5: u64, arg6: u64, arg7: address, arg8: &mut 0x2::tx_context::TxContext) : EventNFT {
        EventNFT{
            id                : 0x2::object::new(arg8),
            name              : arg0,
            description       : arg1,
            thumbnail         : arg2,
            event_date        : arg3,
            links             : arg4,
            total_capacity    : arg5,
            tickets_available : arg5,
            price             : arg6,
            organizer         : arg7,
        }
    }

    public fun update_description(arg0: &mut EventNFT, arg1: 0x1::string::String) {
        arg0.description = arg1;
    }

    public fun update_name(arg0: &mut EventNFT, arg1: 0x1::string::String) {
        arg0.name = arg1;
    }

    public fun update_thumbnail(arg0: &mut EventNFT, arg1: 0x1::string::String) {
        arg0.thumbnail = arg1;
    }

    // decompiled from Move bytecode v6
}

