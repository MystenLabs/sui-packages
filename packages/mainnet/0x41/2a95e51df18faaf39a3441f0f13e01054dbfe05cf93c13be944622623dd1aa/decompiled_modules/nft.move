module 0x412a95e51df18faaf39a3441f0f13e01054dbfe05cf93c13be944622623dd1aa::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct TicketNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct MintEvent has copy, drop {
        creator: address,
        nft_id: 0x2::object::ID,
    }

    public entry fun burn_nft(arg0: TicketNFT, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0x44979f6f65d8c35a2e10c2ec62419db75ea76ddcf7a3c6e9dbe4ff43a7499058, 1);
        let TicketNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
            image_url   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NFT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{url}"));
        let v5 = 0x2::display::new_with_fields<TicketNFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<TicketNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<TicketNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::tx_context::sender(arg3) != @0x44979f6f65d8c35a2e10c2ec62419db75ea76ddcf7a3c6e9dbe4ff43a7499058) {
            abort 1
        };
        let v0 = TicketNFT{
            id          : 0x2::object::new(arg3),
            name        : arg0,
            description : arg1,
            url         : arg2,
            image_url   : arg2,
        };
        let v1 = MintEvent{
            creator : 0x2::tx_context::sender(arg3),
            nft_id  : 0x2::object::id<TicketNFT>(&v0),
        };
        0x2::event::emit<MintEvent>(v1);
        0x2::transfer::public_transfer<TicketNFT>(v0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

