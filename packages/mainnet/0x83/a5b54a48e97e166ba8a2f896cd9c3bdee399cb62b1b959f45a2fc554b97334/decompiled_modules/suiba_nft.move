module 0x83a5b54a48e97e166ba8a2f896cd9c3bdee399cb62b1b959f45a2fc554b97334::suiba_nft {
    struct SuibaNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        nft_id: u64,
    }

    struct SuibaTicket has store, key {
        id: 0x2::object::UID,
        expiration: u64,
    }

    struct SuibaCollection has key {
        id: 0x2::object::UID,
        minted: u64,
        ticket_minted: u64,
        public_minted: u64,
        available_ids: vector<u64>,
        preset_attributes: 0x2::table::Table<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>,
        preset_urls: 0x2::table::Table<u64, 0x2::url::Url>,
        minting_start: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        suiba_id: u64,
        minter: address,
    }

    struct TicketCreated has copy, drop {
        ticket_id: 0x2::object::ID,
        recipient: address,
    }

    struct PriceUpdated has copy, drop {
        new_price: u64,
    }

    struct SUIBA_NFT has drop {
        dummy_field: bool,
    }

    public entry fun add_more_tickets(arg0: &AdminCap, arg1: &mut SuibaCollection, arg2: u64, arg3: vector<address>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<address>(&arg3) == arg2, 0);
        assert!(arg1.ticket_minted + arg2 <= 1000, 1);
        let v0 = 0;
        while (v0 < arg2) {
            let v1 = *0x1::vector::borrow<address>(&arg3, v0);
            let v2 = SuibaTicket{
                id         : 0x2::object::new(arg5),
                expiration : 0x2::clock::timestamp_ms(arg4) + 604800000,
            };
            0x2::transfer::transfer<SuibaTicket>(v2, v1);
            let v3 = TicketCreated{
                ticket_id : 0x2::object::id<SuibaTicket>(&v2),
                recipient : v1,
            };
            0x2::event::emit<TicketCreated>(v3);
            v0 = v0 + 1;
        };
        arg1.ticket_minted = arg1.ticket_minted + arg2;
    }

    public entry fun burn_nft(arg0: SuibaNFT, arg1: &mut SuibaCollection) {
        let SuibaNFT {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
            attributes  : _,
            nft_id      : v5,
        } = arg0;
        0x2::object::delete(v0);
        0x1::vector::push_back<u64>(&mut arg1.available_ids, v5);
        arg1.minted = arg1.minted - 1;
    }

    public entry fun create_and_airdrop_tickets(arg0: &AdminCap, arg1: &mut SuibaCollection, arg2: vector<address>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = 0x1::vector::length<address>(&arg2);
        assert!(v1 <= 1000, 0);
        while (v0 < v1) {
            let v2 = *0x1::vector::borrow<address>(&arg2, v0);
            let v3 = SuibaTicket{
                id         : 0x2::object::new(arg4),
                expiration : arg3 + 604800000,
            };
            0x2::transfer::transfer<SuibaTicket>(v3, v2);
            let v4 = TicketCreated{
                ticket_id : 0x2::object::id<SuibaTicket>(&v3),
                recipient : v2,
            };
            0x2::event::emit<TicketCreated>(v4);
            v0 = v0 + 1;
        };
        arg1.ticket_minted = v1;
    }

    fun create_nft(arg0: &SuibaCollection, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : SuibaNFT {
        let v0 = if (0x2::table::contains<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg0.preset_attributes, arg1)) {
            *0x2::table::borrow<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg0.preset_attributes, arg1)
        } else {
            0x2::vec_map::empty<0x1::string::String, 0x1::string::String>()
        };
        let v1 = 0x1::string::utf8(b"https://suiba.s3.us-west-2.amazonaws.com/images/");
        let v2 = u64_to_string(arg1);
        0x1::string::append(&mut v1, v2);
        0x1::string::append(&mut v1, 0x1::string::utf8(b".png"));
        let v3 = if (0x2::table::contains<u64, 0x2::url::Url>(&arg0.preset_urls, arg1)) {
            *0x2::table::borrow<u64, 0x2::url::Url>(&arg0.preset_urls, arg1)
        } else {
            0x2::url::new_unsafe_from_bytes(*0x1::string::as_bytes(&v1))
        };
        let v4 = 0x1::string::utf8(b"Suiba #");
        0x1::string::append(&mut v4, v2);
        SuibaNFT{
            id          : 0x2::object::new(arg2),
            name        : v4,
            description : 0x1::string::utf8(b"The coolest dog on Sui."),
            image_url   : v3,
            attributes  : v0,
            nft_id      : arg1,
        }
    }

    public fun get_available_public_nfts(arg0: &SuibaCollection, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 1000 - arg0.public_minted;
        let v1 = v0;
        if (0x2::clock::timestamp_ms(arg1) > arg0.minting_start + 604800000) {
            v1 = v0 + 1000 - arg0.ticket_minted;
        };
        v1
    }

    public fun get_current_phase(arg0: &SuibaCollection, arg1: &0x2::clock::Clock) : u8 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 < arg0.minting_start) {
            0
        } else if (v0 <= arg0.minting_start + 604800000) {
            1
        } else {
            2
        }
    }

    public fun get_mint_price() : u64 {
        20000000000
    }

    public fun get_minted(arg0: &SuibaCollection) : u64 {
        arg0.minted
    }

    public fun get_nft_id(arg0: &SuibaNFT) : u64 {
        arg0.nft_id
    }

    public fun get_public_minted(arg0: &SuibaCollection) : u64 {
        arg0.public_minted
    }

    public fun get_public_supply() : u64 {
        1000
    }

    public fun get_remaining_nfts(arg0: &SuibaCollection) : u64 {
        0x1::vector::length<u64>(&arg0.available_ids)
    }

    public fun get_ticket_minted(arg0: &SuibaCollection) : u64 {
        arg0.ticket_minted
    }

    public fun get_ticket_supply() : u64 {
        1000
    }

    public fun get_total_supply() : u64 {
        2000
    }

    fun init(arg0: SUIBA_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SUIBA_NFT>(arg0, arg1);
        let v1 = SuibaCollection{
            id                : 0x2::object::new(arg1),
            minted            : 0,
            ticket_minted     : 0,
            public_minted     : 0,
            available_ids     : 0x1::vector::empty<u64>(),
            preset_attributes : 0x2::table::new<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(arg1),
            preset_urls       : 0x2::table::new<u64, 0x2::url::Url>(arg1),
            minting_start     : 0,
        };
        let v2 = 1;
        while (v2 <= 2000) {
            0x1::vector::push_back<u64>(&mut v1.available_ids, v2);
            v2 = v2 + 1;
        };
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        let v4 = 0x2::display::new<SuibaNFT>(&v0, arg1);
        0x2::display::add<SuibaNFT>(&mut v4, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<SuibaNFT>(&mut v4, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<SuibaNFT>(&mut v4, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<SuibaNFT>(&mut v4, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://suibacoin.com"));
        0x1::vector::empty<0x1::string::String>();
        0x1::vector::empty<0x1::string::String>();
        0x2::display::add<SuibaNFT>(&mut v4, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::update_version<SuibaNFT>(&mut v4);
        let (v5, v6) = 0x2::transfer_policy::new<SuibaNFT>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<SuibaNFT>>(v5);
        0x2::transfer::transfer<AdminCap>(v3, @0xbf3f7889d1646a4d300bbd110c3bff9b6b3695677a9fb0b8ee0e72e9e529f900);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, @0xbf3f7889d1646a4d300bbd110c3bff9b6b3695677a9fb0b8ee0e72e9e529f900);
        0x2::transfer::public_transfer<0x2::display::Display<SuibaNFT>>(v4, @0xbf3f7889d1646a4d300bbd110c3bff9b6b3695677a9fb0b8ee0e72e9e529f900);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<SuibaNFT>>(v6, @0xbf3f7889d1646a4d300bbd110c3bff9b6b3695677a9fb0b8ee0e72e9e529f900);
        0x2::transfer::share_object<SuibaCollection>(v1);
    }

    public fun is_minting_active(arg0: &SuibaCollection, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.minting_start
    }

    public fun is_nft_minted(arg0: &SuibaCollection, arg1: u64) : bool {
        !0x1::vector::contains<u64>(&arg0.available_ids, &arg1)
    }

    public fun is_ticket_valid(arg0: &SuibaTicket, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) <= arg0.expiration
    }

    entry fun mint_public(arg0: &mut SuibaCollection, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::transfer_policy::TransferPolicy<SuibaNFT>, arg3: &0x2::clock::Clock, arg4: &0x2::random::Random, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= arg0.minting_start, 2);
        assert!(arg0.minted < 2000, 1);
        let v1 = if (v0 > arg0.minting_start + 604800000) {
            1000 + 1000 - arg0.ticket_minted
        } else {
            1000
        };
        assert!(arg0.public_minted < v1, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 20000000000, 9);
        let v2 = select_random_id(arg0, arg4, arg7);
        let v3 = create_nft(arg0, v2, arg7);
        arg0.minted = arg0.minted + 1;
        arg0.public_minted = arg0.public_minted + 1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, 20000000000, arg7), @0xbf3f7889d1646a4d300bbd110c3bff9b6b3695677a9fb0b8ee0e72e9e529f900);
        0x2::kiosk::lock<SuibaNFT>(arg5, arg6, arg2, v3);
        let v4 = NFTMinted{
            nft_id   : 0x2::object::id<SuibaNFT>(&v3),
            suiba_id : v2,
            minter   : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<NFTMinted>(v4);
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg7));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
    }

    entry fun mint_with_ticket(arg0: &mut SuibaCollection, arg1: SuibaTicket, arg2: &0x2::transfer_policy::TransferPolicy<SuibaNFT>, arg3: &0x2::clock::Clock, arg4: &0x2::random::Random, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= arg0.minting_start, 2);
        assert!(v0 <= arg1.expiration, 8);
        assert!(arg0.minted < 2000, 1);
        let SuibaTicket {
            id         : v1,
            expiration : _,
        } = arg1;
        0x2::object::delete(v1);
        let v3 = select_random_id(arg0, arg4, arg7);
        let v4 = create_nft(arg0, v3, arg7);
        arg0.minted = arg0.minted + 1;
        0x2::kiosk::lock<SuibaNFT>(arg5, arg6, arg2, v4);
        let v5 = NFTMinted{
            nft_id   : 0x2::object::id<SuibaNFT>(&v4),
            suiba_id : v3,
            minter   : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<NFTMinted>(v5);
    }

    public entry fun pause_minting(arg0: &AdminCap, arg1: &mut SuibaCollection) {
        arg1.minting_start = 18446744073709551615;
    }

    public entry fun resume_minting(arg0: &AdminCap, arg1: &mut SuibaCollection, arg2: u64) {
        arg1.minting_start = arg2;
    }

    fun select_random_id(arg0: &mut SuibaCollection, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(!0x1::vector::is_empty<u64>(&arg0.available_ids), 6);
        let v0 = 0x2::random::new_generator(arg1, arg2);
        0x1::vector::swap_remove<u64>(&mut arg0.available_ids, (0x2::random::generate_u64_in_range(&mut v0, 0, (0x1::vector::length<u64>(&arg0.available_ids) as u64)) as u64))
    }

    public entry fun set_bulk_nft_attributes(arg0: &AdminCap, arg1: &mut SuibaCollection, arg2: vector<u64>, arg3: vector<vector<0x1::string::String>>, arg4: vector<vector<0x1::string::String>>) {
        let v0 = 0;
        let v1 = 0x1::vector::length<u64>(&arg2);
        assert!(v1 == 0x1::vector::length<vector<0x1::string::String>>(&arg3) && v1 == 0x1::vector::length<vector<0x1::string::String>>(&arg4), 0);
        while (v0 < v1) {
            set_nft_attributes(arg0, arg1, *0x1::vector::borrow<u64>(&arg2, v0), *0x1::vector::borrow<vector<0x1::string::String>>(&arg3, v0), *0x1::vector::borrow<vector<0x1::string::String>>(&arg4, v0));
            v0 = v0 + 1;
        };
    }

    public entry fun set_bulk_nft_urls(arg0: &AdminCap, arg1: &mut SuibaCollection, arg2: vector<u64>, arg3: vector<vector<u8>>) {
        let v0 = 0;
        let v1 = 0x1::vector::length<u64>(&arg2);
        assert!(v1 == 0x1::vector::length<vector<u8>>(&arg3), 0);
        while (v0 < v1) {
            set_nft_url(arg0, arg1, *0x1::vector::borrow<u64>(&arg2, v0), *0x1::vector::borrow<vector<u8>>(&arg3, v0));
            v0 = v0 + 1;
        };
    }

    public entry fun set_minting_start(arg0: &AdminCap, arg1: &mut SuibaCollection, arg2: u64) {
        arg1.minting_start = arg2;
    }

    public entry fun set_nft_attributes(arg0: &AdminCap, arg1: &mut SuibaCollection, arg2: u64, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>) {
        assert!(arg2 > 0 && arg2 <= 2000, 7);
        assert!(0x1::vector::length<0x1::string::String>(&arg3) == 0x1::vector::length<0x1::string::String>(&arg4), 0);
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg3)) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, *0x1::vector::borrow<0x1::string::String>(&arg3, v1), *0x1::vector::borrow<0x1::string::String>(&arg4, v1));
            v1 = v1 + 1;
        };
        0x2::table::add<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&mut arg1.preset_attributes, arg2, v0);
    }

    public entry fun set_nft_url(arg0: &AdminCap, arg1: &mut SuibaCollection, arg2: u64, arg3: vector<u8>) {
        assert!(arg2 > 0 && arg2 <= 2000, 7);
        0x2::table::add<u64, 0x2::url::Url>(&mut arg1.preset_urls, arg2, 0x2::url::new_unsafe_from_bytes(arg3));
    }

    fun u64_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 != 0) {
            0x1::vector::push_back<u8>(&mut v0, ((48 + arg0 % 10) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    // decompiled from Move bytecode v6
}

