module 0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::ticket {
    struct TICKET has drop {
        dummy_field: bool,
    }

    struct NftRepository has key {
        id: 0x2::object::UID,
        nfts_per_ticket_type: 0x2::vec_map::VecMap<address, 0x2::vec_map::VecMap<address, 0x2::vec_map::VecMap<0x1::string::String, NftTicketDetails>>>,
        nfts_per_event: 0x2::vec_map::VecMap<address, 0x2::vec_map::VecMap<0x1::string::String, NftTicketDetails>>,
    }

    struct NftTicketDetails has copy, drop, store {
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_uri: 0x1::string::String,
        properties: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct NftTicket has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_uri: 0x1::string::String,
        properties: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct CNT has key {
        id: 0x2::object::UID,
        owner: address,
        event_id: address,
        ticket_type_id: address,
        name: 0x1::string::String,
        payment_info: PaymentInfo,
        seat_index: 0x1::string::String,
        seat_name: 0x1::string::String,
        attended: bool,
        attached_nfts: 0x2::object_bag::ObjectBag,
    }

    struct PaymentInfo has store {
        coin_type: 0x1::option::Option<0x1::ascii::String>,
        paid: u64,
    }

    public(friend) fun transfer(arg0: &mut CNT, arg1: address) {
        arg0.owner = arg1;
    }

    fun create_and_attach_ticket(arg0: &NftTicketDetails, arg1: &mut CNT, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v1 = 0x2::vec_map::keys<0x1::string::String, 0x1::string::String>(&arg0.properties);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::string::String>(&v1)) {
            let v3 = 0x1::vector::borrow<0x1::string::String>(&v1, v2);
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, *v3, *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&arg0.properties, v3));
            v2 = v2 + 1;
        };
        let v4 = NftTicket{
            id          : 0x2::object::new(arg2),
            name        : arg0.name,
            description : arg0.description,
            image_uri   : arg0.image_uri,
            properties  : v0,
        };
        0x2::object_bag::add<NftTicketDetails, NftTicket>(&mut arg1.attached_nfts, *arg0, v4);
    }

    fun create_nft_details(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: &0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::event::EventOrganizerCap) : (address, NftTicketDetails) {
        let v0 = 0x1::vector::length<0x1::string::String>(&arg3);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg4), 0);
        let v1 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v2 = 0;
        while (v2 < v0) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1, 0x1::vector::pop_back<0x1::string::String>(&mut arg3), 0x1::vector::pop_back<0x1::string::String>(&mut arg4));
            v2 = v2 + 1;
        };
        let v3 = NftTicketDetails{
            name        : arg0,
            description : arg1,
            image_uri   : arg2,
            properties  : v1,
        };
        (0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::event::get_event_organizer_cap_event_id(arg5), v3)
    }

    public fun get_cnt_event_id(arg0: &CNT) : address {
        arg0.event_id
    }

    public fun get_cnt_id(arg0: &CNT) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun get_cnt_owner(arg0: &CNT) : address {
        arg0.owner
    }

    public fun get_cnt_ticket_type_id(arg0: &CNT) : address {
        arg0.ticket_type_id
    }

    public fun get_paid_amount(arg0: &CNT) : (0x1::option::Option<0x1::ascii::String>, u64) {
        (arg0.payment_info.coin_type, arg0.payment_info.paid)
    }

    fun init(arg0: TICKET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Price"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Seat Index"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Seat Name"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://app.ticketland/events/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{paid}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{seat_index}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{seat_name}"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Name"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Description"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Image Uri"));
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{image_uri}"));
        let v8 = 0x2::package::claim<TICKET>(arg0, arg1);
        let v9 = 0x2::display::new_with_fields<CNT>(&v8, v0, v2, arg1);
        let v10 = 0x2::display::new_with_fields<NftTicket>(&v8, v4, v6, arg1);
        0x2::display::update_version<CNT>(&mut v9);
        0x2::display::update_version<NftTicket>(&mut v10);
        let v11 = NftRepository{
            id                   : 0x2::object::new(arg1),
            nfts_per_ticket_type : 0x2::vec_map::empty<address, 0x2::vec_map::VecMap<address, 0x2::vec_map::VecMap<0x1::string::String, NftTicketDetails>>>(),
            nfts_per_event       : 0x2::vec_map::empty<address, 0x2::vec_map::VecMap<0x1::string::String, NftTicketDetails>>(),
        };
        0x2::transfer::public_transfer<0x2::package::Publisher>(v8, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<CNT>>(v9, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NftTicket>>(v10, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<NftRepository>(v11);
    }

    fun init_nfts_per_event(arg0: address, arg1: &mut NftRepository) : &mut 0x2::vec_map::VecMap<0x1::string::String, NftTicketDetails> {
        if (0x2::vec_map::contains<address, 0x2::vec_map::VecMap<0x1::string::String, NftTicketDetails>>(&arg1.nfts_per_event, &arg0)) {
            0x2::vec_map::get_mut<address, 0x2::vec_map::VecMap<0x1::string::String, NftTicketDetails>>(&mut arg1.nfts_per_event, &arg0)
        } else {
            0x2::vec_map::insert<address, 0x2::vec_map::VecMap<0x1::string::String, NftTicketDetails>>(&mut arg1.nfts_per_event, arg0, 0x2::vec_map::empty<0x1::string::String, NftTicketDetails>());
            0x2::vec_map::get_mut<address, 0x2::vec_map::VecMap<0x1::string::String, NftTicketDetails>>(&mut arg1.nfts_per_event, &arg0)
        }
    }

    fun init_nfts_per_ticket_type(arg0: address, arg1: address, arg2: &mut NftRepository) : &mut 0x2::vec_map::VecMap<0x1::string::String, NftTicketDetails> {
        if (0x2::vec_map::contains<address, 0x2::vec_map::VecMap<address, 0x2::vec_map::VecMap<0x1::string::String, NftTicketDetails>>>(&arg2.nfts_per_ticket_type, &arg0)) {
            let v1 = 0x2::vec_map::get_mut<address, 0x2::vec_map::VecMap<address, 0x2::vec_map::VecMap<0x1::string::String, NftTicketDetails>>>(&mut arg2.nfts_per_ticket_type, &arg0);
            if (!0x2::vec_map::contains<address, 0x2::vec_map::VecMap<0x1::string::String, NftTicketDetails>>(v1, &arg1)) {
                0x2::vec_map::insert<address, 0x2::vec_map::VecMap<0x1::string::String, NftTicketDetails>>(v1, arg1, 0x2::vec_map::empty<0x1::string::String, NftTicketDetails>());
            };
            0x2::vec_map::get_mut<address, 0x2::vec_map::VecMap<0x1::string::String, NftTicketDetails>>(0x2::vec_map::get_mut<address, 0x2::vec_map::VecMap<address, 0x2::vec_map::VecMap<0x1::string::String, NftTicketDetails>>>(&mut arg2.nfts_per_ticket_type, &arg0), &arg1)
        } else {
            let v2 = 0x2::vec_map::empty<address, 0x2::vec_map::VecMap<0x1::string::String, NftTicketDetails>>();
            0x2::vec_map::insert<address, 0x2::vec_map::VecMap<0x1::string::String, NftTicketDetails>>(&mut v2, arg1, 0x2::vec_map::empty<0x1::string::String, NftTicketDetails>());
            0x2::vec_map::insert<address, 0x2::vec_map::VecMap<address, 0x2::vec_map::VecMap<0x1::string::String, NftTicketDetails>>>(&mut arg2.nfts_per_ticket_type, arg0, v2);
            0x2::vec_map::get_mut<address, 0x2::vec_map::VecMap<0x1::string::String, NftTicketDetails>>(0x2::vec_map::get_mut<address, 0x2::vec_map::VecMap<address, 0x2::vec_map::VecMap<0x1::string::String, NftTicketDetails>>>(&mut arg2.nfts_per_ticket_type, &arg0), &arg1)
        }
    }

    public(friend) fun mint_cnt(arg0: address, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::option::Option<0x1::ascii::String>, arg6: u64, arg7: address, arg8: &mut 0x2::tx_context::TxContext) : address {
        let v0 = 0x2::object::new(arg8);
        let v1 = PaymentInfo{
            coin_type : arg5,
            paid      : arg6,
        };
        let v2 = CNT{
            id             : v0,
            owner          : arg7,
            event_id       : arg0,
            ticket_type_id : arg1,
            name           : arg2,
            payment_info   : v1,
            seat_index     : arg3,
            seat_name      : arg4,
            attended       : false,
            attached_nfts  : 0x2::object_bag::new(arg8),
        };
        0x2::transfer::share_object<CNT>(v2);
        0x2::object::uid_to_address(&v0)
    }

    public entry fun mint_nft_for_event(arg0: address, arg1: 0x1::string::String, arg2: &mut NftRepository, arg3: &mut CNT, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.event_id == arg0, 2);
        create_and_attach_ticket(0x2::vec_map::get<0x1::string::String, NftTicketDetails>(0x2::vec_map::get<address, 0x2::vec_map::VecMap<0x1::string::String, NftTicketDetails>>(&arg2.nfts_per_event, &arg0), &arg1), arg3, arg4);
    }

    public entry fun mint_nft_ticket_for_ticket_type(arg0: address, arg1: address, arg2: 0x1::string::String, arg3: &mut NftRepository, arg4: &mut CNT, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg4.event_id == arg0, 2);
        assert!(arg4.ticket_type_id == arg1, 1);
        create_and_attach_ticket(0x2::vec_map::get<0x1::string::String, NftTicketDetails>(0x2::vec_map::get<address, 0x2::vec_map::VecMap<0x1::string::String, NftTicketDetails>>(0x2::vec_map::get<address, 0x2::vec_map::VecMap<address, 0x2::vec_map::VecMap<0x1::string::String, NftTicketDetails>>>(&arg3.nfts_per_ticket_type, &arg0), &arg1), &arg2), arg4, arg5);
    }

    public entry fun register_nft_ticket_per_event(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: &mut NftRepository, arg7: &0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::event::EventOrganizerCap) {
        let (v0, v1) = create_nft_details(arg1, arg2, arg3, arg4, arg5, arg7);
        0x2::vec_map::insert<0x1::string::String, NftTicketDetails>(init_nfts_per_event(v0, arg6), arg0, v1);
    }

    public entry fun register_nft_ticket_per_ticket_type(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>, arg7: &mut NftRepository, arg8: &0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::event::Event, arg9: &0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::event::EventOrganizerCap) {
        assert!(0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::event::is_event_ticket_type(arg8, arg0), 3);
        let (v0, v1) = create_nft_details(arg2, arg3, arg4, arg5, arg6, arg9);
        0x2::vec_map::insert<0x1::string::String, NftTicketDetails>(init_nfts_per_ticket_type(v0, arg0, arg7), arg1, v1);
    }

    public(friend) fun set_attended(arg0: &mut CNT) {
        arg0.attended = true;
    }

    // decompiled from Move bytecode v6
}

