module 0x476e9bc6e3a226ecf62e5c3cb05569ac53ba8e70d8b6ce15870bbbd3ccc4b23c::boat_ticket {
    struct BOAT_TICKET has drop {
        dummy_field: bool,
    }

    struct BoatTicket has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        index: u64,
        whitelist_claimed: bool,
    }

    struct BoatTicketGlobal has key {
        id: 0x2::object::UID,
        balance_SHUI: 0x2::balance::Balance<0x476e9bc6e3a226ecf62e5c3cb05569ac53ba8e70d8b6ce15870bbbd3ccc4b23c::shui::SHUI>,
        creator: address,
        num: u64,
    }

    public entry fun buy_ticket(arg0: &mut BoatTicketGlobal, arg1: vector<0x2::coin::Coin<0x476e9bc6e3a226ecf62e5c3cb05569ac53ba8e70d8b6ce15870bbbd3ccc4b23c::shui::SHUI>>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 25;
        let v1 = 0x1::vector::pop_back<0x2::coin::Coin<0x476e9bc6e3a226ecf62e5c3cb05569ac53ba8e70d8b6ce15870bbbd3ccc4b23c::shui::SHUI>>(&mut arg1);
        assert!(arg0.num < 5000, 6);
        0x2::pay::join_vec<0x476e9bc6e3a226ecf62e5c3cb05569ac53ba8e70d8b6ce15870bbbd3ccc4b23c::shui::SHUI>(&mut v1, arg1);
        assert!(0x2::coin::value<0x476e9bc6e3a226ecf62e5c3cb05569ac53ba8e70d8b6ce15870bbbd3ccc4b23c::shui::SHUI>(&v1) >= v0 * 1000000000, 4);
        0x2::balance::join<0x476e9bc6e3a226ecf62e5c3cb05569ac53ba8e70d8b6ce15870bbbd3ccc4b23c::shui::SHUI>(&mut arg0.balance_SHUI, 0x2::coin::into_balance<0x476e9bc6e3a226ecf62e5c3cb05569ac53ba8e70d8b6ce15870bbbd3ccc4b23c::shui::SHUI>(0x2::coin::split<0x476e9bc6e3a226ecf62e5c3cb05569ac53ba8e70d8b6ce15870bbbd3ccc4b23c::shui::SHUI>(&mut v1, v0 * 1000000000, arg2)));
        if (0x2::coin::value<0x476e9bc6e3a226ecf62e5c3cb05569ac53ba8e70d8b6ce15870bbbd3ccc4b23c::shui::SHUI>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x476e9bc6e3a226ecf62e5c3cb05569ac53ba8e70d8b6ce15870bbbd3ccc4b23c::shui::SHUI>>(v1, 0x2::tx_context::sender(arg2));
        } else {
            0x2::coin::destroy_zero<0x476e9bc6e3a226ecf62e5c3cb05569ac53ba8e70d8b6ce15870bbbd3ccc4b23c::shui::SHUI>(v1);
        };
        arg0.num = arg0.num + 1;
        let v2 = BoatTicket{
            id                : 0x2::object::new(arg2),
            name              : 0x1::string::utf8(b"Shui Meta Ticket"),
            index             : arg0.num,
            whitelist_claimed : false,
        };
        0x2::transfer::transfer<BoatTicket>(v2, 0x2::tx_context::sender(arg2));
    }

    public fun get_boat_num(arg0: &BoatTicketGlobal) : u64 {
        arg0.num
    }

    public fun get_index(arg0: &BoatTicket) : u64 {
        arg0.index
    }

    public fun get_name(arg0: &BoatTicket) : 0x1::string::String {
        arg0.name
    }

    fun init(arg0: BOAT_TICKET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"AirShip to meta masrs"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://shui.game"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://bafybeibzoi4kzr4gg75zhso5jespxnwespyfyakemrwibqorjczkn23vpi.ipfs.nftstorage.link/NFT-CARD1.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://shui.game/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"metaGame"));
        let v4 = 0x2::package::claim<BOAT_TICKET>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<BoatTicket>(&v4, v0, v2, arg1);
        0x2::display::update_version<BoatTicket>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<BoatTicket>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = BoatTicketGlobal{
            id           : 0x2::object::new(arg1),
            balance_SHUI : 0x2::balance::zero<0x476e9bc6e3a226ecf62e5c3cb05569ac53ba8e70d8b6ce15870bbbd3ccc4b23c::shui::SHUI>(),
            creator      : 0x2::tx_context::sender(arg1),
            num          : 0,
        };
        0x2::transfer::share_object<BoatTicketGlobal>(v6);
    }

    public(friend) fun is_claimed(arg0: &BoatTicket) : bool {
        arg0.whitelist_claimed
    }

    public(friend) fun record_white_list_clamed(arg0: &mut BoatTicket) {
        arg0.whitelist_claimed = true;
    }

    public entry fun withdraw_shui(arg0: &mut BoatTicketGlobal, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x476e9bc6e3a226ecf62e5c3cb05569ac53ba8e70d8b6ce15870bbbd3ccc4b23c::shui::SHUI>>(0x2::coin::from_balance<0x476e9bc6e3a226ecf62e5c3cb05569ac53ba8e70d8b6ce15870bbbd3ccc4b23c::shui::SHUI>(0x2::balance::split<0x476e9bc6e3a226ecf62e5c3cb05569ac53ba8e70d8b6ce15870bbbd3ccc4b23c::shui::SHUI>(&mut arg0.balance_SHUI, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

