module 0x53202d65e8a0cd251a4f275b1650ec1d38243301bd8c04fc4633ca11a459955d::ticket_nft {
    struct TICKET_NFT has drop {
        dummy_field: bool,
    }

    struct TicketNFT has store, key {
        id: 0x2::object::UID,
        event_id: 0x2::object::ID,
        owner: address,
        price_paid: u64,
        image_url: 0x1::string::String,
    }

    public fun id(arg0: &TicketNFT) : &0x2::object::UID {
        &arg0.id
    }

    fun init(arg0: TICKET_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<TICKET_NFT>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public(friend) fun mint(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : TicketNFT {
        TicketNFT{
            id         : 0x2::object::new(arg4),
            event_id   : arg0,
            owner      : arg1,
            price_paid : arg2,
            image_url  : arg3,
        }
    }

    public fun owner(arg0: &TicketNFT) : address {
        arg0.owner
    }

    // decompiled from Move bytecode v6
}

