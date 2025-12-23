module 0x96e62a01d934f9dd33a61f68c1457b177019d1296e21841e399ee0b0cf0f759f::rollify_tickets {
    struct ROLLIFY_TICKETS has drop {
        dummy_field: bool,
    }

    struct RollifyTicket has key {
        id: 0x2::object::UID,
        number: 0x1::string::String,
        image_url: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct Whitelist has key {
        id: 0x2::object::UID,
        addresses: 0x2::vec_map::VecMap<address, bool>,
    }

    struct Supply has key {
        id: 0x2::object::UID,
        total_minted: u64,
        max_supply: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AirdropEvent has copy, drop, store {
        recipient: address,
        nft_id: address,
        number: 0x1::string::String,
    }

    struct BurnEvent has copy, drop, store {
        owner: address,
        nft_id: address,
        number: 0x1::string::String,
    }

    public fun add_to_whitelist(arg0: &AdminCap, arg1: &mut Whitelist, arg2: vector<address>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            if (!0x2::vec_map::contains<address, bool>(&arg1.addresses, &v1)) {
                0x2::vec_map::insert<address, bool>(&mut arg1.addresses, v1, false);
            };
            v0 = v0 + 1;
        };
    }

    public fun airdrop(arg0: &AdminCap, arg1: &mut Whitelist, arg2: &mut Supply, arg3: address, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<0x1::string::String>, arg7: vector<0x1::string::String>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_map::contains<address, bool>(&arg1.addresses, &arg3), 0);
        assert!(!*0x2::vec_map::get<address, bool>(&arg1.addresses, &arg3), 1);
        assert!(arg2.total_minted < arg2.max_supply, 3);
        let v0 = RollifyTicket{
            id         : 0x2::object::new(arg8),
            number     : arg4,
            image_url  : arg5,
            attributes : 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg6, arg7),
        };
        arg2.total_minted = arg2.total_minted + 1;
        *0x2::vec_map::get_mut<address, bool>(&mut arg1.addresses, &arg3) = true;
        let v1 = AirdropEvent{
            recipient : arg3,
            nft_id    : 0x2::object::uid_to_address(&v0.id),
            number    : arg4,
        };
        0x2::event::emit<AirdropEvent>(v1);
        0x2::transfer::transfer<RollifyTicket>(v0, arg3);
    }

    public fun batch_airdrop(arg0: &AdminCap, arg1: &mut Whitelist, arg2: &mut Supply, arg3: vector<address>, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: vector<vector<0x1::string::String>>, arg7: vector<vector<0x1::string::String>>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<address>(&arg3) == 0x1::vector::length<0x1::string::String>(&arg4), 2);
        assert!(0x1::vector::length<address>(&arg3) == 0x1::vector::length<0x1::string::String>(&arg5), 2);
        assert!(0x1::vector::length<address>(&arg3) == 0x1::vector::length<vector<0x1::string::String>>(&arg6), 2);
        assert!(0x1::vector::length<address>(&arg3) == 0x1::vector::length<vector<0x1::string::String>>(&arg7), 2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg3)) {
            let v1 = *0x1::vector::borrow<address>(&arg3, v0);
            let v2 = *0x1::vector::borrow<0x1::string::String>(&arg4, v0);
            if (0x2::vec_map::contains<address, bool>(&arg1.addresses, &v1)) {
                if (!*0x2::vec_map::get<address, bool>(&arg1.addresses, &v1)) {
                    assert!(arg2.total_minted < arg2.max_supply, 3);
                    let v3 = RollifyTicket{
                        id         : 0x2::object::new(arg8),
                        number     : v2,
                        image_url  : *0x1::vector::borrow<0x1::string::String>(&arg5, v0),
                        attributes : 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(*0x1::vector::borrow<vector<0x1::string::String>>(&arg6, v0), *0x1::vector::borrow<vector<0x1::string::String>>(&arg7, v0)),
                    };
                    arg2.total_minted = arg2.total_minted + 1;
                    *0x2::vec_map::get_mut<address, bool>(&mut arg1.addresses, &v1) = true;
                    let v4 = AirdropEvent{
                        recipient : v1,
                        nft_id    : 0x2::object::uid_to_address(&v3.id),
                        number    : v2,
                    };
                    0x2::event::emit<AirdropEvent>(v4);
                    0x2::transfer::transfer<RollifyTicket>(v3, v1);
                };
            };
            v0 = v0 + 1;
        };
    }

    public fun burn(arg0: RollifyTicket, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<RollifyTicket>(&arg0);
        let RollifyTicket {
            id         : v1,
            number     : _,
            image_url  : _,
            attributes : _,
        } = arg0;
        let v5 = BurnEvent{
            owner  : 0x2::tx_context::sender(arg1),
            nft_id : 0x2::object::id_to_address(&v0),
            number : arg0.number,
        };
        0x2::event::emit<BurnEvent>(v5);
        0x2::object::delete(v1);
    }

    public fun has_received_airdrop(arg0: &Whitelist, arg1: address) : bool {
        0x2::vec_map::contains<address, bool>(&arg0.addresses, &arg1) && *0x2::vec_map::get<address, bool>(&arg0.addresses, &arg1)
    }

    fun init(arg0: ROLLIFY_TICKETS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<ROLLIFY_TICKETS>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Rollify Ticket #{number}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Airdropped Rollify Ticket to whitelisted user"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://example.com/ticket/{id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://example.com"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Rollify Tickets System"));
        let v5 = 0x2::display::new_with_fields<RollifyTicket>(&v0, v1, v3, arg1);
        0x2::display::update_version<RollifyTicket>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<RollifyTicket>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = Whitelist{
            id        : 0x2::object::new(arg1),
            addresses : 0x2::vec_map::empty<address, bool>(),
        };
        0x2::transfer::share_object<Whitelist>(v6);
        let v7 = Supply{
            id           : 0x2::object::new(arg1),
            total_minted : 0,
            max_supply   : 50000,
        };
        0x2::transfer::share_object<Supply>(v7);
        let v8 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v8, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun is_whitelisted(arg0: &Whitelist, arg1: address) : bool {
        0x2::vec_map::contains<address, bool>(&arg0.addresses, &arg1)
    }

    public fun max_supply(arg0: &Supply) : u64 {
        arg0.max_supply
    }

    public fun new_admin(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<AdminCap>(v0, arg1);
    }

    public fun remaining_supply(arg0: &Supply) : u64 {
        if (arg0.max_supply > arg0.total_minted) {
            arg0.max_supply - arg0.total_minted
        } else {
            0
        }
    }

    public fun remove_from_whitelist(arg0: &AdminCap, arg1: &mut Whitelist, arg2: vector<address>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            if (0x2::vec_map::contains<address, bool>(&arg1.addresses, &v1)) {
                let (_, _) = 0x2::vec_map::remove<address, bool>(&mut arg1.addresses, &v1);
            };
            v0 = v0 + 1;
        };
    }

    public fun total_minted(arg0: &Supply) : u64 {
        arg0.total_minted
    }

    // decompiled from Move bytecode v6
}

