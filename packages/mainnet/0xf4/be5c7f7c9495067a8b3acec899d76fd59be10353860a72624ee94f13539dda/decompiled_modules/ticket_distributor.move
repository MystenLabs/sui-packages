module 0xf4be5c7f7c9495067a8b3acec899d76fd59be10353860a72624ee94f13539dda::ticket_distributor {
    struct TICKET_DISTRIBUTOR has drop {
        dummy_field: bool,
    }

    struct TicketDistributor has key {
        id: 0x2::object::UID,
        signer: vector<u8>,
        total_minted: u64,
        admin: address,
        mint_counts: 0x2::table::Table<address, u64>,
    }

    struct Ticket has store, key {
        id: 0x2::object::UID,
        ticket_number: u64,
        minted_at: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
    }

    struct TicketMinted has copy, drop {
        ticket_id: address,
        minter: address,
        ticket_number: u64,
        amount: u64,
        timestamp: u64,
    }

    struct DistributorCreated has copy, drop {
        distributor_id: address,
        admin: address,
    }

    struct TicketBurned has copy, drop {
        ticket_id: address,
        burner: address,
        ticket_number: u64,
        timestamp: u64,
    }

    public fun burn_ticket(arg0: Ticket, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let Ticket {
            id            : v0,
            ticket_number : _,
            minted_at     : _,
            name          : _,
            description   : _,
            image_url     : _,
        } = arg0;
        let v6 = TicketBurned{
            ticket_id     : 0x2::object::uid_to_address(&arg0.id),
            burner        : 0x2::tx_context::sender(arg2),
            ticket_number : arg0.ticket_number,
            timestamp     : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<TicketBurned>(v6);
        0x2::object::delete(v0);
    }

    public fun create_distributor(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::vector::length<u8>(&arg0) == 20, 4);
        let v1 = TicketDistributor{
            id           : 0x2::object::new(arg1),
            signer       : arg0,
            total_minted : 0,
            admin        : v0,
            mint_counts  : 0x2::table::new<address, u64>(arg1),
        };
        let v2 = DistributorCreated{
            distributor_id : 0x2::object::uid_to_address(&v1.id),
            admin          : v0,
        };
        0x2::event::emit<DistributorCreated>(v2);
        0x2::transfer::share_object<TicketDistributor>(v1);
    }

    public fun get_distributor_info(arg0: &TicketDistributor) : (u64, address) {
        (arg0.total_minted, arg0.admin)
    }

    public fun get_mint_count(arg0: &TicketDistributor, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.mint_counts, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.mint_counts, arg1)
        } else {
            0
        }
    }

    public fun get_signer(arg0: &TicketDistributor) : vector<u8> {
        arg0.signer
    }

    public fun get_ticket_info(arg0: &Ticket) : (u64, u64) {
        (arg0.ticket_number, arg0.minted_at)
    }

    fun init(arg0: TICKET_DISTRIBUTOR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://sui-nft-project.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Sui NFT Project"));
        let v4 = 0x2::package::claim<TICKET_DISTRIBUTOR>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Ticket>(&v4, v0, v2, arg1);
        0x2::display::update_version<Ticket>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Ticket>>(v5, 0x2::tx_context::sender(arg1));
    }

    fun mint_ticket_internal(arg0: &mut TicketDistributor, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.total_minted = arg0.total_minted + 1;
        let v0 = Ticket{
            id            : 0x2::object::new(arg2),
            ticket_number : arg0.total_minted,
            minted_at     : arg1,
            name          : 0x1::string::utf8(b"Sui NFT Ticket"),
            description   : 0x1::string::utf8(b"A ticket that can be opened to receive random NFTs"),
            image_url     : 0x2::url::new_unsafe_from_bytes(b"https://sui-nft-project.com/ticket.png"),
        };
        0x2::transfer::public_transfer<Ticket>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun mint_tickets(arg0: &mut TicketDistributor, arg1: vector<u8>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg2 > 0, 2);
        let v2 = if (0x2::table::contains<address, u64>(&arg0.mint_counts, v0)) {
            *0x2::table::borrow<address, u64>(&arg0.mint_counts, v0)
        } else {
            0
        };
        assert!(verify_mint_signature(arg1, arg0.signer, v0, arg2), 1);
        let v3 = if (arg2 > v2) {
            arg2 - v2
        } else {
            0
        };
        assert!(v3 > 0, 5);
        let v4 = 0;
        while (v4 < v3) {
            mint_ticket_internal(arg0, v1, arg4);
            v4 = v4 + 1;
        };
        if (0x2::table::contains<address, u64>(&arg0.mint_counts, v0)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.mint_counts, v0) = arg2;
        } else {
            0x2::table::add<address, u64>(&mut arg0.mint_counts, v0, arg2);
        };
        let v5 = TicketMinted{
            ticket_id     : 0x2::object::uid_to_address(&arg0.id),
            minter        : v0,
            ticket_number : arg0.total_minted,
            amount        : v3,
            timestamp     : v1,
        };
        0x2::event::emit<TicketMinted>(v5);
    }

    public fun update_signer(arg0: &mut TicketDistributor, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 3);
        assert!(0x1::vector::length<u8>(&arg1) == 20, 4);
        arg0.signer = arg1;
    }

    fun verify_mint_signature(arg0: vector<u8>, arg1: vector<u8>, arg2: address, arg3: u64) : bool {
        if (0x1::vector::length<u8>(&arg0) != 65) {
            return false
        };
        let v0 = 0x2::bcs::to_bytes<address>(&arg2);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        let v1 = x"19457468657265756d205369676e6564204d6573736167653a0a3332";
        0x1::vector::append<u8>(&mut v1, 0x2::hash::keccak256(&v0));
        let v2 = 0x2::hash::keccak256(&v1);
        let v3 = *0x1::vector::borrow<u8>(&arg0, 64);
        let v4 = if (v3 >= 27) {
            v3 - 27
        } else {
            v3
        };
        let v5 = 0x1::vector::empty<u8>();
        let v6 = 0;
        while (v6 < 64) {
            0x1::vector::push_back<u8>(&mut v5, *0x1::vector::borrow<u8>(&arg0, v6));
            v6 = v6 + 1;
        };
        let v7 = 0x2::ecdsa_k1::secp256k1_ecrecover(&v5, &v2, v4);
        if (0x1::vector::is_empty<u8>(&v7)) {
            return false
        };
        let v8 = 0x2::hash::keccak256(&v7);
        let v9 = 0x1::vector::empty<u8>();
        let v10 = 12;
        while (v10 < 32) {
            0x1::vector::push_back<u8>(&mut v9, *0x1::vector::borrow<u8>(&v8, v10));
            v10 = v10 + 1;
        };
        v9 == arg1
    }

    // decompiled from Move bytecode v6
}

