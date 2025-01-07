module 0x7db2d08896f064c8abac8cab1c06df82e8b939a85e89bded6b8031754d4601e5::boat_ticket {
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
        balance_SUI: 0x2::balance::Balance<0x2::sui::SUI>,
        bought_list: 0x2::table::Table<address, bool>,
        creator: address,
        num: u64,
        version: u64,
    }

    public entry fun buy_ticket(arg0: &mut BoatTicketGlobal, arg1: &mut 0x7db2d08896f064c8abac8cab1c06df82e8b939a85e89bded6b8031754d4601e5::swap::SwapGlobal, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 4);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 100;
        let v2 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2);
        0x2::pay::join_vec<0x2::sui::SUI>(&mut v2, arg2);
        assert!(!0x2::table::contains<address, bool>(&arg0.bought_list, v0), 3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v2) >= v1 * 1000000000, 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance_SUI, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v2, v1 * 1000000000, arg3)));
        if (0x2::coin::value<0x2::sui::SUI>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v2);
        };
        let v3 = BoatTicket{
            id                : 0x2::object::new(arg3),
            name              : 0x1::string::utf8(b"Airship"),
            index             : arg0.num,
            whitelist_claimed : false,
        };
        arg0.num = arg0.num + 1;
        assert!(arg0.num <= 10000, 5);
        0x2::table::add<address, bool>(&mut arg0.bought_list, v0, true);
        0x2::transfer::transfer<BoatTicket>(v3, 0x2::tx_context::sender(arg3));
        0x7db2d08896f064c8abac8cab1c06df82e8b939a85e89bded6b8031754d4601e5::swap::set_whitelist(arg1, arg3);
    }

    public fun change_owner(arg0: &mut BoatTicketGlobal, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 2);
        arg0.creator = arg1;
    }

    public fun get_index(arg0: &BoatTicket) : u64 {
        arg0.index
    }

    public fun get_left_boat_num(arg0: &BoatTicketGlobal) : u64 {
        10000 - arg0.num
    }

    public fun get_name(arg0: &BoatTicket) : 0x1::string::String {
        arg0.name
    }

    public fun increment(arg0: &mut BoatTicketGlobal, arg1: u64) {
        assert!(arg0.version == 0, 4);
        arg0.version = arg1;
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Airship to meta masrs"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://shui.game"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://bafybeibzoi4kzr4gg75zhso5jespxnwespyfyakemrwibqorjczkn23vpi.ipfs.nftstorage.link/NFT-CARD1.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://shui.game/game/#/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"metaGame"));
        let v4 = 0x2::package::claim<BOAT_TICKET>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<BoatTicket>(&v4, v0, v2, arg1);
        0x2::display::update_version<BoatTicket>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<BoatTicket>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = BoatTicketGlobal{
            id          : 0x2::object::new(arg1),
            balance_SUI : 0x2::balance::zero<0x2::sui::SUI>(),
            bought_list : 0x2::table::new<address, bool>(arg1),
            creator     : 0x2::tx_context::sender(arg1),
            num         : 0,
            version     : 0,
        };
        0x2::transfer::share_object<BoatTicketGlobal>(v6);
    }

    public entry fun is_claimed(arg0: &BoatTicket) : bool {
        arg0.whitelist_claimed
    }

    public(friend) fun record_white_list_clamed(arg0: &mut BoatTicket) {
        arg0.whitelist_claimed = true;
    }

    public entry fun withdraw_sui(arg0: &mut BoatTicketGlobal, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x1cb722782ce2440afefff4062fd0bd98021c09b5ef720b7e584e7c071cd417, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance_SUI, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

