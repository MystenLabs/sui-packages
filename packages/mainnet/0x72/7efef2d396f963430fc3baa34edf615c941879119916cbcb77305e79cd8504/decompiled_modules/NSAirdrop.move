module 0x727efef2d396f963430fc3baa34edf615c941879119916cbcb77305e79cd8504::NSAirdrop {
    struct Ticket has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        img_url: 0x1::string::String,
    }

    struct NSAIRDROP has drop {
        dummy_field: bool,
    }

    public entry fun claim_ticket(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Ticket{
            id      : 0x2::object::new(arg3),
            name    : arg0,
            img_url : arg1,
        };
        0x2::transfer::transfer<Ticket>(v0, arg2);
    }

    fun init(arg0: NSAIRDROP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"suins.xyz"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{img_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"The NS token is the native token of the SuiNS protocol, the naming service on the Sui blockchain. Holders of this NFT have previously claimed the NS tokens."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"suins.xyz"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"suins.xyz"));
        let v4 = 0x2::package::claim<NSAIRDROP>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Ticket>(&v4, v0, v2, arg1);
        0x2::display::update_version<Ticket>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Ticket>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

