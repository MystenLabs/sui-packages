module 0xef782eaff542b871310847189c71635b89f8fc3d32efd33e2d985713a5252a53::nft_ticket {
    struct LotteryTicket has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
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
        0x2::display::update_version<LotteryTicket>(&mut v2);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
        0x2::transfer::public_transfer<0x2::display::Display<LotteryTicket>>(v2, v0);
    }

    public entry fun mint(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LotteryTicket{
            id          : 0x2::object::new(arg0),
            name        : 0x1::string::utf8(b"Lotto ticket no#1"),
            description : 0x1::string::utf8(b"This is a unique NFT that represents my first creation."),
            image_url   : 0x2::url::new_unsafe_from_bytes(b"https://color-jump.xyz/nfts/nft_1.json"),
        };
        0x2::transfer::public_transfer<LotteryTicket>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

