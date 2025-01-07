module 0x8bdc95e99e393fea9b0e010353ef27109ca6b93d96c57090d7ab61fc9ca4d78d::loyalty {
    struct Witness has drop {
        dummy_field: bool,
    }

    struct LOYALTY has drop {
        dummy_field: bool,
    }

    struct Box has key {
        id: 0x2::object::UID,
        type: u64,
        name: 0x1::string::String,
        infinity_credits: u64,
        attributes: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::Attributes,
    }

    struct Ticket has store, key {
        id: 0x2::object::UID,
        type: u64,
        name: 0x1::string::String,
        infinity_credits: u64,
        attributes: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::Attributes,
    }

    struct BoxCreated has copy, drop {
        id: 0x2::object::ID,
        nonce: u64,
        type: u64,
        name: 0x1::string::String,
        infinity_credits: u64,
        recipient: address,
    }

    struct BoxLoyaltyPointsSynced has copy, drop {
        id: 0x2::object::ID,
        nonce: u64,
        infinity_credits: u64,
        by: address,
    }

    struct BoxLoyaltyPointsUpdated has copy, drop {
        id: 0x2::object::ID,
        infinity_credits: u64,
        by: address,
    }

    struct TicketCreated has copy, drop {
        id: 0x2::object::ID,
        box_id: 0x2::object::ID,
        nonce: u64,
        type: u64,
        name: 0x1::string::String,
        infinity_credits: u64,
        recipient: address,
    }

    struct TicketApplied has copy, drop {
        box_id: 0x2::object::ID,
        ticket_id: 0x2::object::ID,
        nonce: u64,
        applied_infinity_credits: u64,
        by: address,
    }

    entry fun apply_loyalty_ticket(arg0: &mut 0x8bdc95e99e393fea9b0e010353ef27109ca6b93d96c57090d7ab61fc9ca4d78d::utility::Config, arg1: &mut Box, arg2: Ticket, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        0x8bdc95e99e393fea9b0e010353ef27109ca6b93d96c57090d7ab61fc9ca4d78d::utility::assert_version(arg0);
        0x8bdc95e99e393fea9b0e010353ef27109ca6b93d96c57090d7ab61fc9ca4d78d::utility::assert_nonce(arg0, &arg3);
        let v0 = Witness{dummy_field: false};
        let Ticket {
            id               : v1,
            type             : v2,
            name             : _,
            infinity_credits : v4,
            attributes       : _,
        } = arg2;
        let v6 = v1;
        assert!(arg1.type == v2, 0);
        let v7 = 0x2::address::to_bytes(0x2::tx_context::sender(arg5));
        0x1::vector::append<u8>(&mut v7, 0x2::bcs::to_bytes<u64>(&arg3));
        let v8 = 0x2::hash::keccak256(&v7);
        0x8bdc95e99e393fea9b0e010353ef27109ca6b93d96c57090d7ab61fc9ca4d78d::utility::assert_signature(arg0, &arg4, &v8);
        0x8bdc95e99e393fea9b0e010353ef27109ca6b93d96c57090d7ab61fc9ca4d78d::utility::mark_nonce_used(arg0, arg3);
        arg1.infinity_credits = arg1.infinity_credits + v4;
        let v9 = TicketApplied{
            box_id                   : 0x2::object::uid_to_inner(&arg1.id),
            ticket_id                : 0x2::object::uid_to_inner(&v6),
            nonce                    : arg3,
            applied_infinity_credits : v4,
            by                       : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<TicketApplied>(v9);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_burn<Ticket>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::start_burn<Ticket>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Ticket, Witness>(v0), &arg2), 0x8bdc95e99e393fea9b0e010353ef27109ca6b93d96c57090d7ab61fc9ca4d78d::utility::collection_id_by_name(arg0, b"loyalty_ticket"), v6);
    }

    fun box_col_wit() : 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<Box> {
        let v0 = Witness{dummy_field: false};
        0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Box, Witness>(v0)
    }

    entry fun change_ticket_collection_desc(arg0: &0x8bdc95e99e393fea9b0e010353ef27109ca6b93d96c57090d7ab61fc9ca4d78d::utility::AdminCap, arg1: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Ticket>, arg2: vector<u8>) {
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::change_description<Witness, Ticket>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::borrow_uid_mut<Ticket>(ticket_col_wit(), arg1), 0x1::string::utf8(arg2));
    }

    entry fun change_ticket_collection_name(arg0: &0x8bdc95e99e393fea9b0e010353ef27109ca6b93d96c57090d7ab61fc9ca4d78d::utility::AdminCap, arg1: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Ticket>, arg2: vector<u8>) {
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::change_name<Witness, Ticket>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::borrow_uid_mut<Ticket>(ticket_col_wit(), arg1), 0x1::string::utf8(arg2));
    }

    entry fun claim_box(arg0: &mut 0x8bdc95e99e393fea9b0e010353ef27109ca6b93d96c57090d7ab61fc9ca4d78d::utility::Config, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: u64, arg5: vector<0x1::ascii::String>, arg6: vector<0x1::ascii::String>, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        0x8bdc95e99e393fea9b0e010353ef27109ca6b93d96c57090d7ab61fc9ca4d78d::utility::assert_version(arg0);
        0x8bdc95e99e393fea9b0e010353ef27109ca6b93d96c57090d7ab61fc9ca4d78d::utility::assert_nonce(arg0, &arg1);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::address::to_bytes(v0);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg4));
        let v2 = 0x2::hash::keccak256(&v1);
        0x8bdc95e99e393fea9b0e010353ef27109ca6b93d96c57090d7ab61fc9ca4d78d::utility::assert_signature(arg0, &arg7, &v2);
        0x8bdc95e99e393fea9b0e010353ef27109ca6b93d96c57090d7ab61fc9ca4d78d::utility::mark_nonce_used(arg0, arg1);
        let v3 = 0x1::string::utf8(arg3);
        let v4 = Box{
            id               : 0x2::object::new(arg8),
            type             : arg2,
            name             : v3,
            infinity_credits : arg4,
            attributes       : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::from_vec(arg5, arg6),
        };
        let v5 = BoxCreated{
            id               : 0x2::object::uid_to_inner(&v4.id),
            nonce            : arg1,
            type             : arg2,
            name             : v3,
            infinity_credits : arg4,
            recipient        : v0,
        };
        0x2::event::emit<BoxCreated>(v5);
        0x2::transfer::transfer<Box>(v4, v0);
    }

    fun create_box_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<Box> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"infinity_credits"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{infinity_credits}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://worldsbeyondnft.com/loyalty-boxes/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://cdn.worldsbeyondnft.com/nft/loyalty-boxes/{type}.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"The Infinity Passport is a loyalty program that rewards players for playing games in our ecosystem. Players earn Infinity Credits on their Infinity Passports for playing Worlds Beyond games, winning competitions, completing challenges and more. These Infinity Credits can be redeemed for a variety of rewards, including WBITS mining keys, in-game items, exclusive content, and real-world prizes. Be sure to follow news in our Discord and Twitter for the most updated information."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://worldsbeyondnft.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Worlds Beyond Creator"));
        let v4 = 0x2::display::new_with_fields<Box>(arg0, v0, v2, arg1);
        0x2::display::update_version<Box>(&mut v4);
        v4
    }

    fun create_ticket_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<Ticket> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"infinity_credits"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{infinity_credits}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://worldsbeyondnft.com/loyalty-tickets/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://cdn.worldsbeyondnft.com/loyalty-tickets/{type}.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Infinity Tickets are tradeable tickets that contain tradeable balances of Infinity Credits. Once purchased, a user must apply an Infinity Ticket before Infinity Credits can be applied to the user's account. Players earn Infinity Credits on their Infinity Passports for playing Worlds Beyond games, winning competitions, completing challenges and more. These Infinity Credits can be redeemed for a variety of rewards, including WBITS mining keys, in-game items, exclusive content, and real-world prizes. Be sure to follow news in our Discord and Twitter for the most updated information."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://worldsbeyondnft.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Worlds Beyond Creator"));
        let v4 = 0x2::display::new_with_fields<Ticket>(arg0, v0, v2, arg1);
        0x2::display::update_version<Ticket>(&mut v4);
        v4
    }

    public fun infinity_credits(arg0: &Box) : u64 {
        arg0.infinity_credits
    }

    fun init(arg0: LOYALTY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<LOYALTY, Ticket>(&arg0, 0x1::option::none<u64>(), arg1);
        let v3 = v1;
        let v4 = 0x2::package::claim<LOYALTY>(arg0, arg1);
        let v5 = create_box_display(&v4, arg1);
        0x2::transfer::public_transfer<0x2::display::Display<Box>>(v5, v0);
        let v6 = create_ticket_display(&v4, arg1);
        0x2::transfer::public_transfer<0x2::display::Display<Ticket>>(v6, v0);
        let v7 = Witness{dummy_field: false};
        let v8 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Ticket, Witness>(v7);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Ticket, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(v8, &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(0x1::string::utf8(b"Worlds Beyond Infinity Tickets Collection"), 0x1::string::utf8(b"Worlds Beyond Infinity Tickets")));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::create_domain_and_add_strategy<Ticket>(v8, &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty::from_address(v0, arg1), 500, arg1);
        let (v9, v10) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<Ticket>(&v4, arg1);
        let v11 = v10;
        let v12 = v9;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::enforce<Ticket>(&mut v12, &v11);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Ticket>>(v12);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Ticket>>(v11, v0);
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Ticket>>(v2, v0);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Ticket>>(v3);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v0);
    }

    entry fun issue_loyalty_ticket(arg0: &mut 0x8bdc95e99e393fea9b0e010353ef27109ca6b93d96c57090d7ab61fc9ca4d78d::utility::Config, arg1: &mut Box, arg2: u64, arg3: vector<u8>, arg4: address, arg5: u64, arg6: vector<0x1::ascii::String>, arg7: vector<0x1::ascii::String>, arg8: vector<u8>, arg9: &mut 0x2::tx_context::TxContext) {
        0x8bdc95e99e393fea9b0e010353ef27109ca6b93d96c57090d7ab61fc9ca4d78d::utility::assert_version(arg0);
        0x8bdc95e99e393fea9b0e010353ef27109ca6b93d96c57090d7ab61fc9ca4d78d::utility::assert_nonce(arg0, &arg2);
        assert!(arg5 <= arg1.infinity_credits, 1);
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x2::address::to_bytes(v0);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v1, 0x2::address::to_bytes(arg4));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg5));
        let v2 = 0x2::hash::keccak256(&v1);
        0x8bdc95e99e393fea9b0e010353ef27109ca6b93d96c57090d7ab61fc9ca4d78d::utility::assert_signature(arg0, &arg8, &v2);
        0x8bdc95e99e393fea9b0e010353ef27109ca6b93d96c57090d7ab61fc9ca4d78d::utility::mark_nonce_used(arg0, arg2);
        arg1.infinity_credits = arg1.infinity_credits - arg5;
        let v3 = BoxLoyaltyPointsUpdated{
            id               : 0x2::object::uid_to_inner(&arg1.id),
            infinity_credits : arg1.infinity_credits,
            by               : v0,
        };
        0x2::event::emit<BoxLoyaltyPointsUpdated>(v3);
        let v4 = Ticket{
            id               : 0x2::object::new(arg9),
            type             : arg1.type,
            name             : 0x1::string::utf8(arg3),
            infinity_credits : arg5,
            attributes       : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::from_vec(arg6, arg7),
        };
        let v5 = TicketCreated{
            id               : 0x2::object::uid_to_inner(&v4.id),
            box_id           : 0x2::object::uid_to_inner(&arg1.id),
            nonce            : arg2,
            type             : v4.type,
            name             : v4.name,
            infinity_credits : arg1.infinity_credits,
            recipient        : arg4,
        };
        0x2::event::emit<TicketCreated>(v5);
        let v6 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<Ticket>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Ticket, Witness>(v6), 0x8bdc95e99e393fea9b0e010353ef27109ca6b93d96c57090d7ab61fc9ca4d78d::utility::collection_id_by_name(arg0, b"loyalty_ticket"), &v4);
        0x2::transfer::public_transfer<Ticket>(v4, arg4);
    }

    entry fun mint_box_for(arg0: &0x8bdc95e99e393fea9b0e010353ef27109ca6b93d96c57090d7ab61fc9ca4d78d::utility::AdminCap, arg1: u64, arg2: vector<u8>, arg3: u64, arg4: vector<0x1::ascii::String>, arg5: vector<0x1::ascii::String>, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = Box{
            id               : 0x2::object::new(arg7),
            type             : arg1,
            name             : 0x1::string::utf8(arg2),
            infinity_credits : arg3,
            attributes       : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::from_vec(arg4, arg5),
        };
        0x2::transfer::transfer<Box>(v0, arg6);
    }

    public fun name(arg0: &Box) : &0x1::string::String {
        &arg0.name
    }

    entry fun sync(arg0: &mut 0x8bdc95e99e393fea9b0e010353ef27109ca6b93d96c57090d7ab61fc9ca4d78d::utility::Config, arg1: &mut Box, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        0x8bdc95e99e393fea9b0e010353ef27109ca6b93d96c57090d7ab61fc9ca4d78d::utility::assert_version(arg0);
        0x8bdc95e99e393fea9b0e010353ef27109ca6b93d96c57090d7ab61fc9ca4d78d::utility::assert_nonce(arg0, &arg2);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::address::to_bytes(v0);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg3));
        let v2 = 0x2::hash::keccak256(&v1);
        0x8bdc95e99e393fea9b0e010353ef27109ca6b93d96c57090d7ab61fc9ca4d78d::utility::assert_signature(arg0, &arg4, &v2);
        0x8bdc95e99e393fea9b0e010353ef27109ca6b93d96c57090d7ab61fc9ca4d78d::utility::mark_nonce_used(arg0, arg2);
        arg1.infinity_credits = arg1.infinity_credits + arg3;
        let v3 = BoxLoyaltyPointsSynced{
            id               : 0x2::object::uid_to_inner(&arg1.id),
            nonce            : arg2,
            infinity_credits : arg1.infinity_credits,
            by               : v0,
        };
        0x2::event::emit<BoxLoyaltyPointsSynced>(v3);
    }

    public fun test_mint_box_for(arg0: &0x8bdc95e99e393fea9b0e010353ef27109ca6b93d96c57090d7ab61fc9ca4d78d::utility::AdminCap, arg1: u64, arg2: vector<u8>, arg3: u64, arg4: vector<0x1::ascii::String>, arg5: vector<0x1::ascii::String>, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        mint_box_for(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    fun ticket_col_wit() : 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<Ticket> {
        let v0 = Witness{dummy_field: false};
        0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Ticket, Witness>(v0)
    }

    public fun ticket_infinity_credits(arg0: &Ticket) : u64 {
        arg0.infinity_credits
    }

    public fun type(arg0: &Box) : u64 {
        arg0.type
    }

    public(friend) fun use_infinity_credits(arg0: &mut Box, arg1: u64) {
        assert!(arg0.infinity_credits >= arg1, 1);
        arg0.infinity_credits = arg0.infinity_credits - arg1;
    }

    // decompiled from Move bytecode v6
}

