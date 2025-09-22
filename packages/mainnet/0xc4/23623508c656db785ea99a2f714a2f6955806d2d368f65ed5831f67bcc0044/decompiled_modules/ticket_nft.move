module 0xc423623508c656db785ea99a2f714a2f6955806d2d368f65ed5831f67bcc0044::ticket_nft {
    struct TICKET_NFT has drop {
        dummy_field: bool,
    }

    struct TicketNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        event_id: 0x2::object::UID,
        user_id: address,
        price_paid: u64,
        image_url: 0x1::string::String,
    }

    public fun has_available_ticket() : bool {
        true
    }

    public fun id(arg0: &TicketNFT) : &0x2::object::UID {
        &arg0.id
    }

    fun init(arg0: TICKET_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<TICKET_NFT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"event_id"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"user_id"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"price_paid"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{event_id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{user_id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{price_paid}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        let v5 = 0x2::display::new_with_fields<TicketNFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<TicketNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<TicketNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x2::object::UID, arg3: address, arg4: u64, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) : TicketNFT {
        TicketNFT{
            id          : 0x2::object::new(arg6),
            name        : arg0,
            description : arg1,
            event_id    : arg2,
            user_id     : arg3,
            price_paid  : arg4,
            image_url   : arg5,
        }
    }

    public fun transfer_to_user() {
    }

    // decompiled from Move bytecode v6
}

