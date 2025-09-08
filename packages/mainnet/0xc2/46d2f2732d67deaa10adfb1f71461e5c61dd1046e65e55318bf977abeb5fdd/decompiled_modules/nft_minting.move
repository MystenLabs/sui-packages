module 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::nft_minting {
    struct ProofOfAttendance has store, key {
        id: 0x2::object::UID,
        event_id: 0x2::object::ID,
        event_name: 0x1::string::String,
        attendee: address,
        check_in_time: u64,
        metadata: NFTMetadata,
    }

    struct NFTOfCompletion has store, key {
        id: 0x2::object::UID,
        event_id: 0x2::object::ID,
        event_name: 0x1::string::String,
        attendee: address,
        check_in_time: u64,
        check_out_time: u64,
        attendance_duration: u64,
        metadata: NFTMetadata,
    }

    struct NFTMetadata has copy, drop, store {
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        location: 0x1::string::String,
        organizer: address,
        attributes: vector<Attribute>,
    }

    struct Attribute has copy, drop, store {
        trait_type: 0x1::string::String,
        value: 0x1::string::String,
    }

    struct NFTRegistry has key {
        id: 0x2::object::UID,
        event_nfts: 0x2::table::Table<0x2::object::ID, EventNFTs>,
        user_nfts: 0x2::table::Table<address, UserNFTs>,
        total_poa_minted: u64,
        total_completion_minted: u64,
    }

    struct EventNFTs has store {
        poa_minted: 0x2::table::Table<address, 0x2::object::ID>,
        completion_minted: 0x2::table::Table<address, 0x2::object::ID>,
        total_poa: u64,
        total_completions: u64,
        event_metadata: EventMetadata,
    }

    struct UserNFTs has store {
        poa_tokens: vector<0x2::object::ID>,
        completion_tokens: vector<0x2::object::ID>,
    }

    struct EventMetadata has copy, drop, store {
        event_name: 0x1::string::String,
        image_url: 0x1::string::String,
        location: 0x1::string::String,
        organizer: address,
    }

    struct NFT_MINTING has drop {
        dummy_field: bool,
    }

    struct PoAMinted has copy, drop {
        nft_id: 0x2::object::ID,
        event_id: 0x2::object::ID,
        attendee: address,
        check_in_time: u64,
    }

    struct CompletionMinted has copy, drop {
        nft_id: 0x2::object::ID,
        event_id: 0x2::object::ID,
        attendee: address,
        attendance_duration: u64,
    }

    fun duration_to_string(arg0: u64) : 0x1::string::String {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = u64_to_string(arg0 / 3600000);
        0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(&v1));
        0x1::vector::append<u8>(&mut v0, b"h ");
        let v2 = u64_to_string(arg0 % 3600000 / 60000);
        0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(&v2));
        0x1::vector::append<u8>(&mut v0, b"m");
        0x1::string::utf8(v0)
    }

    public fun get_event_nft_stats(arg0: 0x2::object::ID, arg1: &NFTRegistry) : (u64, u64) {
        if (!0x2::table::contains<0x2::object::ID, EventNFTs>(&arg1.event_nfts, arg0)) {
            return (0, 0)
        };
        let v0 = 0x2::table::borrow<0x2::object::ID, EventNFTs>(&arg1.event_nfts, arg0);
        (v0.total_poa, v0.total_completions)
    }

    public fun get_user_nfts(arg0: address, arg1: &NFTRegistry) : (vector<0x2::object::ID>, vector<0x2::object::ID>) {
        if (!0x2::table::contains<address, UserNFTs>(&arg1.user_nfts, arg0)) {
            return (0x1::vector::empty<0x2::object::ID>(), 0x1::vector::empty<0x2::object::ID>())
        };
        let v0 = 0x2::table::borrow<address, UserNFTs>(&arg1.user_nfts, arg0);
        (v0.poa_tokens, v0.completion_tokens)
    }

    public fun has_completion_nft(arg0: address, arg1: 0x2::object::ID, arg2: &NFTRegistry) : bool {
        if (!0x2::table::contains<0x2::object::ID, EventNFTs>(&arg2.event_nfts, arg1)) {
            return false
        };
        0x2::table::contains<address, 0x2::object::ID>(&0x2::table::borrow<0x2::object::ID, EventNFTs>(&arg2.event_nfts, arg1).completion_minted, arg0)
    }

    public fun has_proof_of_attendance(arg0: address, arg1: 0x2::object::ID, arg2: &NFTRegistry) : bool {
        if (!0x2::table::contains<0x2::object::ID, EventNFTs>(&arg2.event_nfts, arg1)) {
            return false
        };
        0x2::table::contains<address, 0x2::object::ID>(&0x2::table::borrow<0x2::object::ID, EventNFTs>(&arg2.event_nfts, arg1).poa_minted, arg0)
    }

    fun init(arg0: NFT_MINTING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = NFTRegistry{
            id                      : 0x2::object::new(arg1),
            event_nfts              : 0x2::table::new<0x2::object::ID, EventNFTs>(arg1),
            user_nfts               : 0x2::table::new<address, UserNFTs>(arg1),
            total_poa_minted        : 0,
            total_completion_minted : 0,
        };
        0x2::transfer::share_object<NFTRegistry>(v0);
        let v1 = 0x2::package::claim<NFT_MINTING>(arg0, arg1);
        let v2 = 0x2::display::new<ProofOfAttendance>(&v1, arg1);
        0x2::display::add<ProofOfAttendance>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Proof of Attendance - {event_name}"));
        0x2::display::add<ProofOfAttendance>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{metadata.description}"));
        0x2::display::add<ProofOfAttendance>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{metadata.image_url}"));
        0x2::display::add<ProofOfAttendance>(&mut v2, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://ariyaprotocol.com"));
        0x2::display::update_version<ProofOfAttendance>(&mut v2);
        let v3 = 0x2::display::new<NFTOfCompletion>(&v1, arg1);
        0x2::display::add<NFTOfCompletion>(&mut v3, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Certificate of Completion - {event_name}"));
        0x2::display::add<NFTOfCompletion>(&mut v3, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{metadata.description}"));
        0x2::display::add<NFTOfCompletion>(&mut v3, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{metadata.image_url}"));
        0x2::display::add<NFTOfCompletion>(&mut v3, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://ariyaprotocol.com"));
        0x2::display::update_version<NFTOfCompletion>(&mut v3);
        0x2::transfer::public_transfer<0x2::display::Display<ProofOfAttendance>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFTOfCompletion>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun mint_nft_of_completion(arg0: 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::attendance_verification::MintCompletionCapability, arg1: &mut NFTRegistry, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let (v0, v1, v2, v3, v4) = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::attendance_verification::consume_completion_capability(arg0);
        assert!(0x2::table::contains<0x2::object::ID, EventNFTs>(&arg1.event_nfts, v0), 1);
        let v5 = 0x2::table::borrow_mut<0x2::object::ID, EventNFTs>(&mut arg1.event_nfts, v0);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&v5.completion_minted, v1), 2);
        let v6 = v5.event_metadata;
        let v7 = 0x1::vector::empty<Attribute>();
        let v8 = Attribute{
            trait_type : 0x1::string::utf8(b"Event Type"),
            value      : 0x1::string::utf8(b"Certificate of Completion"),
        };
        0x1::vector::push_back<Attribute>(&mut v7, v8);
        let v9 = Attribute{
            trait_type : 0x1::string::utf8(b"Attendance Duration"),
            value      : duration_to_string(v4),
        };
        0x1::vector::push_back<Attribute>(&mut v7, v9);
        let v10 = Attribute{
            trait_type : 0x1::string::utf8(b"Check-in Time"),
            value      : u64_to_string(v2),
        };
        0x1::vector::push_back<Attribute>(&mut v7, v10);
        let v11 = Attribute{
            trait_type : 0x1::string::utf8(b"Check-out Time"),
            value      : u64_to_string(v3),
        };
        0x1::vector::push_back<Attribute>(&mut v7, v11);
        let v12 = Attribute{
            trait_type : 0x1::string::utf8(b"Location"),
            value      : v6.location,
        };
        0x1::vector::push_back<Attribute>(&mut v7, v12);
        let v13 = NFTMetadata{
            description : 0x1::string::utf8(b"This NFT certifies successful completion of the event"),
            image_url   : v6.image_url,
            location    : v6.location,
            organizer   : v6.organizer,
            attributes  : v7,
        };
        let v14 = NFTOfCompletion{
            id                  : 0x2::object::new(arg2),
            event_id            : v0,
            event_name          : v6.event_name,
            attendee            : v1,
            check_in_time       : v2,
            check_out_time      : v3,
            attendance_duration : v4,
            metadata            : v13,
        };
        let v15 = 0x2::object::id<NFTOfCompletion>(&v14);
        0x2::table::add<address, 0x2::object::ID>(&mut v5.completion_minted, v1, v15);
        v5.total_completions = v5.total_completions + 1;
        arg1.total_completion_minted = arg1.total_completion_minted + 1;
        if (!0x2::table::contains<address, UserNFTs>(&arg1.user_nfts, v1)) {
            let v16 = UserNFTs{
                poa_tokens        : 0x1::vector::empty<0x2::object::ID>(),
                completion_tokens : 0x1::vector::empty<0x2::object::ID>(),
            };
            0x2::table::add<address, UserNFTs>(&mut arg1.user_nfts, v1, v16);
        };
        0x1::vector::push_back<0x2::object::ID>(&mut 0x2::table::borrow_mut<address, UserNFTs>(&mut arg1.user_nfts, v1).completion_tokens, v15);
        0x2::transfer::transfer<NFTOfCompletion>(v14, v1);
        let v17 = CompletionMinted{
            nft_id              : v15,
            event_id            : v0,
            attendee            : v1,
            attendance_duration : v4,
        };
        0x2::event::emit<CompletionMinted>(v17);
        v15
    }

    public fun mint_proof_of_attendance(arg0: 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::attendance_verification::MintPoACapability, arg1: &mut NFTRegistry, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let (v0, v1, v2) = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::attendance_verification::consume_poa_capability(arg0);
        assert!(0x2::table::contains<0x2::object::ID, EventNFTs>(&arg1.event_nfts, v0), 1);
        let v3 = 0x2::table::borrow_mut<0x2::object::ID, EventNFTs>(&mut arg1.event_nfts, v0);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&v3.poa_minted, v1), 2);
        let v4 = v3.event_metadata;
        let v5 = 0x1::vector::empty<Attribute>();
        let v6 = Attribute{
            trait_type : 0x1::string::utf8(b"Event Type"),
            value      : 0x1::string::utf8(b"Proof of Attendance"),
        };
        0x1::vector::push_back<Attribute>(&mut v5, v6);
        let v7 = Attribute{
            trait_type : 0x1::string::utf8(b"Check-in Time"),
            value      : u64_to_string(v2),
        };
        0x1::vector::push_back<Attribute>(&mut v5, v7);
        let v8 = Attribute{
            trait_type : 0x1::string::utf8(b"Location"),
            value      : v4.location,
        };
        0x1::vector::push_back<Attribute>(&mut v5, v8);
        let v9 = NFTMetadata{
            description : 0x1::string::utf8(b"This NFT certifies attendance at the event"),
            image_url   : v4.image_url,
            location    : v4.location,
            organizer   : v4.organizer,
            attributes  : v5,
        };
        let v10 = ProofOfAttendance{
            id            : 0x2::object::new(arg2),
            event_id      : v0,
            event_name    : v4.event_name,
            attendee      : v1,
            check_in_time : v2,
            metadata      : v9,
        };
        let v11 = 0x2::object::id<ProofOfAttendance>(&v10);
        0x2::table::add<address, 0x2::object::ID>(&mut v3.poa_minted, v1, v11);
        v3.total_poa = v3.total_poa + 1;
        arg1.total_poa_minted = arg1.total_poa_minted + 1;
        if (!0x2::table::contains<address, UserNFTs>(&arg1.user_nfts, v1)) {
            let v12 = UserNFTs{
                poa_tokens        : 0x1::vector::empty<0x2::object::ID>(),
                completion_tokens : 0x1::vector::empty<0x2::object::ID>(),
            };
            0x2::table::add<address, UserNFTs>(&mut arg1.user_nfts, v1, v12);
        };
        0x1::vector::push_back<0x2::object::ID>(&mut 0x2::table::borrow_mut<address, UserNFTs>(&mut arg1.user_nfts, v1).poa_tokens, v11);
        0x2::transfer::transfer<ProofOfAttendance>(v10, v1);
        let v13 = PoAMinted{
            nft_id        : v11,
            event_id      : v0,
            attendee      : v1,
            check_in_time : v2,
        };
        0x2::event::emit<PoAMinted>(v13);
        v11
    }

    public fun set_event_metadata(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: address, arg5: &mut NFTRegistry, arg6: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<0x2::object::ID, EventNFTs>(&arg5.event_nfts, arg0)) {
            let v0 = EventMetadata{
                event_name : arg1,
                image_url  : arg2,
                location   : arg3,
                organizer  : arg4,
            };
            let v1 = EventNFTs{
                poa_minted        : 0x2::table::new<address, 0x2::object::ID>(arg6),
                completion_minted : 0x2::table::new<address, 0x2::object::ID>(arg6),
                total_poa         : 0,
                total_completions : 0,
                event_metadata    : v0,
            };
            0x2::table::add<0x2::object::ID, EventNFTs>(&mut arg5.event_nfts, arg0, v1);
        } else {
            let v2 = EventMetadata{
                event_name : arg1,
                image_url  : arg2,
                location   : arg3,
                organizer  : arg4,
            };
            0x2::table::borrow_mut<0x2::object::ID, EventNFTs>(&mut arg5.event_nfts, arg0).event_metadata = v2;
        };
    }

    fun u64_to_string(arg0: u64) : 0x1::string::String {
        let v0 = 0x1::vector::empty<u8>();
        if (arg0 == 0) {
            0x1::vector::push_back<u8>(&mut v0, 48);
        } else {
            let v1 = 0x1::vector::empty<u8>();
            while (arg0 > 0) {
                0x1::vector::push_back<u8>(&mut v1, ((arg0 % 10) as u8) + 48);
                arg0 = arg0 / 10;
            };
            let v2 = 0x1::vector::length<u8>(&v1);
            while (v2 > 0) {
                v2 = v2 - 1;
                0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&v1, v2));
            };
        };
        0x1::string::utf8(v0)
    }

    // decompiled from Move bytecode v6
}

