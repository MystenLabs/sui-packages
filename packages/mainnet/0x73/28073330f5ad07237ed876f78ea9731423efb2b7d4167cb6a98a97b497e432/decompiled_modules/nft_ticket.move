module 0x7328073330f5ad07237ed876f78ea9731423efb2b7d4167cb6a98a97b497e432::nft_ticket {
    struct LotteryTicket has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        numbers: vector<u8>,
    }

    struct NFT_TICKET has drop {
        dummy_field: bool,
    }

    fun init(arg0: NFT_TICKET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<NFT_TICKET>(arg0, arg1);
        let v2 = 0x2::display::new<LotteryTicket>(&v1, arg1);
        0x2::display::add<LotteryTicket>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<LotteryTicket>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<LotteryTicket>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<LotteryTicket>(&mut v2, 0x1::string::utf8(b"numbers"), 0x1::string::utf8(b"{numbers}"));
        0x2::display::update_version<LotteryTicket>(&mut v2);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
        0x2::transfer::public_transfer<0x2::display::Display<LotteryTicket>>(v2, v0);
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg0) == 6, 0);
        let v0 = 0;
        while (v0 < 6) {
            let v1 = *0x1::vector::borrow<u8>(&arg0, v0);
            assert!(v1 >= 1 && v1 <= 49, 1);
            v0 = v0 + 1;
        };
        let v2 = LotteryTicket{
            id          : 0x2::object::new(arg2),
            name        : 0x1::string::utf8(b"Lotto Ticket"),
            description : 0x1::string::utf8(b"A unique lottery ticket NFT"),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg1),
            numbers     : arg0,
        };
        0x2::transfer::public_transfer<LotteryTicket>(v2, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

