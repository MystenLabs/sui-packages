module 0xf211dbbacdd09e8244687fbfced90bdf4a48f7b7865cfb6434e21e6a564786b8::TESTY {
    struct TestNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        nft_id: u64,
    }

    struct TestTicket has store, key {
        id: 0x2::object::UID,
        ticket_type: u8,
        expiration: u64,
        mint_price: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
    }

    struct TestCollection has key {
        id: 0x2::object::UID,
        minted: u64,
        regular_ticket_reserved: u64,
        discount_ticket_reserved: u64,
        regular_ticket_minted: u64,
        discount_ticket_minted: u64,
        public_minted: u64,
        available_ids: vector<u64>,
        preset_attributes: 0x2::table::Table<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>,
        preset_urls: 0x2::table::Table<u64, 0x2::url::Url>,
        preset_ticket_urls: 0x2::table::Table<u8, 0x2::url::Url>,
        minting_start: u64,
        public_mint_price: u64,
        admin_address: address,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        Test_id: u64,
        minter: address,
    }

    struct TicketCreated has copy, drop {
        ticket_id: 0x2::object::ID,
        ticket_type: u8,
        recipient: address,
        mint_price: u64,
    }

    struct PriceUpdated has copy, drop {
        new_price: u64,
    }

    struct AdminUpdated has copy, drop {
        new_admin: address,
    }

    struct TESTY has drop {
        dummy_field: bool,
    }

    public entry fun burn_nft(arg0: TestNFT, arg1: &mut TestCollection) {
        let TestNFT {
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

    public entry fun create_discount_tickets(arg0: &AdminCap, arg1: &mut TestCollection, arg2: vector<address>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 < arg1.public_mint_price, 11);
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(arg1.discount_ticket_minted + v0 <= arg1.discount_ticket_reserved, 1);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<address>(&arg2, v1);
            let v3 = TestTicket{
                id          : 0x2::object::new(arg5),
                ticket_type : 1,
                expiration  : arg3 + 259200000,
                mint_price  : arg4,
                name        : 0x1::string::utf8(b"Test Discount Ticket"),
                description : 0x1::string::utf8(b"This ticket lets you mint a Test at a discount."),
                image_url   : 0x2::url::new_unsafe_from_bytes(b"https://hsui.mypinata.cloud/ipfs/bafybeidaw4vqcnaz5f4sxnfrsdjpg2lefxooqzmskbdqbj3bsxc6tzqzku"),
            };
            0x2::transfer::transfer<TestTicket>(v3, v2);
            let v4 = TicketCreated{
                ticket_id   : 0x2::object::id<TestTicket>(&v3),
                ticket_type : 1,
                recipient   : v2,
                mint_price  : arg4,
            };
            0x2::event::emit<TicketCreated>(v4);
            v1 = v1 + 1;
        };
    }

    fun create_nft(arg0: &TestCollection, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : TestNFT {
        let v0 = if (0x2::table::contains<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg0.preset_attributes, arg1)) {
            *0x2::table::borrow<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg0.preset_attributes, arg1)
        } else {
            0x2::vec_map::empty<0x1::string::String, 0x1::string::String>()
        };
        let v1 = if (0x2::table::contains<u64, 0x2::url::Url>(&arg0.preset_urls, arg1)) {
            *0x2::table::borrow<u64, 0x2::url::Url>(&arg0.preset_urls, arg1)
        } else {
            let v2 = 0x1::string::utf8(b"https://default-nft-image.com");
            0x2::url::new_unsafe_from_bytes(*0x1::string::as_bytes(&v2))
        };
        let v3 = 0x1::string::utf8(b"Test #");
        0x1::string::append(&mut v3, u64_to_string(arg1));
        TestNFT{
            id          : 0x2::object::new(arg2),
            name        : v3,
            description : 0x1::string::utf8(b"The Culture Layer of Sui"),
            image_url   : v1,
            attributes  : v0,
            nft_id      : arg1,
        }
    }

    public entry fun create_regular_tickets(arg0: &AdminCap, arg1: &mut TestCollection, arg2: vector<address>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(arg1.regular_ticket_minted + v0 <= arg1.regular_ticket_reserved, 1);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<address>(&arg2, v1);
            let v3 = TestTicket{
                id          : 0x2::object::new(arg5),
                ticket_type : 0,
                expiration  : arg3 + 432000000,
                mint_price  : arg4,
                name        : 0x1::string::utf8(b"Test Free Ticket"),
                description : 0x1::string::utf8(b"This ticket lets you mint a Test for free."),
                image_url   : 0x2::url::new_unsafe_from_bytes(b"https://hsui.mypinata.cloud/ipfs/bafybeidaw4vqcnaz5f4sxnfrsdjpg2lefxooqzmskbdqbj3bsxc6tzqzku"),
            };
            0x2::transfer::transfer<TestTicket>(v3, v2);
            let v4 = TicketCreated{
                ticket_id   : 0x2::object::id<TestTicket>(&v3),
                ticket_type : 0,
                recipient   : v2,
                mint_price  : arg4,
            };
            0x2::event::emit<TicketCreated>(v4);
            v1 = v1 + 1;
        };
    }

    public fun get_admin_address(arg0: &TestCollection) : address {
        arg0.admin_address
    }

    public fun get_available_public_nfts(arg0: &TestCollection, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 3333 - arg0.regular_ticket_reserved - arg0.discount_ticket_reserved;
        let v2 = v1;
        if (v0 > arg0.minting_start + 432000000) {
            v2 = v1 + arg0.regular_ticket_reserved - arg0.regular_ticket_minted;
        };
        if (v0 > arg0.minting_start + 259200000) {
            v2 = v2 + arg0.discount_ticket_reserved - arg0.discount_ticket_minted;
        };
        v2 - arg0.public_minted
    }

    public fun get_discount_ticket_minted(arg0: &TestCollection) : u64 {
        arg0.discount_ticket_minted
    }

    public fun get_minted(arg0: &TestCollection) : u64 {
        arg0.minted
    }

    public fun get_nft_id(arg0: &TestNFT) : u64 {
        arg0.nft_id
    }

    public fun get_public_mint_price(arg0: &TestCollection) : u64 {
        arg0.public_mint_price
    }

    public fun get_public_minted(arg0: &TestCollection) : u64 {
        arg0.public_minted
    }

    public fun get_regular_ticket_minted(arg0: &TestCollection) : u64 {
        arg0.regular_ticket_minted
    }

    public fun get_remaining_nfts(arg0: &TestCollection) : u64 {
        0x1::vector::length<u64>(&arg0.available_ids)
    }

    public fun get_total_supply() : u64 {
        3333
    }

    fun init(arg0: TESTY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<TESTY>(arg0, arg1);
        let v1 = TestCollection{
            id                       : 0x2::object::new(arg1),
            minted                   : 0,
            regular_ticket_reserved  : 0,
            discount_ticket_reserved : 0,
            regular_ticket_minted    : 0,
            discount_ticket_minted   : 0,
            public_minted            : 0,
            available_ids            : 0x1::vector::empty<u64>(),
            preset_attributes        : 0x2::table::new<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(arg1),
            preset_urls              : 0x2::table::new<u64, 0x2::url::Url>(arg1),
            preset_ticket_urls       : 0x2::table::new<u8, 0x2::url::Url>(arg1),
            minting_start            : 0,
            public_mint_price        : 10000000000,
            admin_address            : @0xa3a46a24c5ec03a3620df4bebcd38226d91f747366301eca089cca7fb034bf69,
        };
        let v2 = 1;
        while (v2 <= 3333) {
            0x1::vector::push_back<u64>(&mut v1.available_ids, v2);
            v2 = v2 + 1;
        };
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        let v4 = 0x2::display::new<TestNFT>(&v0, arg1);
        0x2::display::add<TestNFT>(&mut v4, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<TestNFT>(&mut v4, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<TestNFT>(&mut v4, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<TestNFT>(&mut v4, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::update_version<TestNFT>(&mut v4);
        let v5 = 0x2::display::new<TestTicket>(&v0, arg1);
        0x2::display::add<TestTicket>(&mut v5, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<TestTicket>(&mut v5, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<TestTicket>(&mut v5, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::update_version<TestTicket>(&mut v5);
        let (v6, v7) = 0x2::transfer_policy::new<TestNFT>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<TestNFT>>(v6);
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<TestNFT>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<TestTicket>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<TestNFT>>(v7, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<TestCollection>(v1);
    }

    public fun is_minting_active(arg0: &TestCollection, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.minting_start
    }

    public fun is_nft_minted(arg0: &TestCollection, arg1: u64) : bool {
        !0x1::vector::contains<u64>(&arg0.available_ids, &arg1)
    }

    public fun is_ticket_valid(arg0: &TestTicket, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) <= arg0.expiration
    }

    public entry fun mint_admin(arg0: &AdminCap, arg1: &mut TestCollection, arg2: &0x2::transfer_policy::TransferPolicy<TestNFT>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v0, 23);
        0x1::vector::push_back<u64>(&mut v0, 33);
        0x1::vector::push_back<u64>(&mut v0, 235);
        0x1::vector::push_back<u64>(&mut v0, 281);
        0x1::vector::push_back<u64>(&mut v0, 395);
        0x1::vector::push_back<u64>(&mut v0, 681);
        0x1::vector::push_back<u64>(&mut v0, 838);
        0x1::vector::push_back<u64>(&mut v0, 1219);
        0x1::vector::push_back<u64>(&mut v0, 2059);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&v0)) {
            let v2 = remove_specific_id(arg1, *0x1::vector::borrow<u64>(&v0, v1));
            let v3 = create_nft(arg1, v2, arg5);
            arg1.minted = arg1.minted + 1;
            0x2::kiosk::lock<TestNFT>(arg3, arg4, arg2, v3);
            let v4 = NFTMinted{
                nft_id  : 0x2::object::id<TestNFT>(&v3),
                Test_id : v2,
                minter  : 0x2::tx_context::sender(arg5),
            };
            0x2::event::emit<NFTMinted>(v4);
            v1 = v1 + 1;
        };
    }

    public entry fun mint_public(arg0: &mut TestCollection, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::transfer_policy::TransferPolicy<TestNFT>, arg3: &0x2::clock::Clock, arg4: &0x2::random::Random, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= arg0.minting_start, 2);
        assert!(arg0.minted < 3333, 1);
        assert!(arg7 > 0 && arg7 <= 5, 0);
        let v1 = arg0.public_mint_price * arg7;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v1, 9);
        let v2 = 3333 - arg0.regular_ticket_reserved - arg0.discount_ticket_reserved;
        let v3 = v2;
        if (v0 > arg0.minting_start + 432000000) {
            v3 = v2 + arg0.regular_ticket_reserved - arg0.regular_ticket_minted;
        };
        if (v0 > arg0.minting_start + 259200000) {
            v3 = v3 + arg0.discount_ticket_reserved - arg0.discount_ticket_minted;
        };
        assert!(arg0.public_minted + arg7 <= v3, 1);
        let v4 = 0;
        while (v4 < arg7) {
            let v5 = select_random_id(arg0, arg4, arg8);
            let v6 = create_nft(arg0, v5, arg8);
            arg0.minted = arg0.minted + 1;
            arg0.public_minted = arg0.public_minted + 1;
            0x2::kiosk::lock<TestNFT>(arg5, arg6, arg2, v6);
            let v7 = NFTMinted{
                nft_id  : 0x2::object::id<TestNFT>(&v6),
                Test_id : v5,
                minter  : 0x2::tx_context::sender(arg8),
            };
            0x2::event::emit<NFTMinted>(v7);
            v4 = v4 + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v1, arg8), arg0.admin_address);
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg8));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
    }

    public entry fun mint_with_ticket(arg0: &mut TestCollection, arg1: TestTicket, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::transfer_policy::TransferPolicy<TestNFT>, arg4: &0x2::clock::Clock, arg5: &0x2::random::Random, arg6: &mut 0x2::kiosk::Kiosk, arg7: &0x2::kiosk::KioskOwnerCap, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 >= arg0.minting_start, 2);
        assert!(v0 <= arg1.expiration, 8);
        assert!(arg0.minted < 3333, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg1.mint_price, 9);
        if (arg1.ticket_type == 0) {
            assert!(v0 <= arg0.minting_start + 432000000 || arg0.regular_ticket_minted < arg0.regular_ticket_reserved, 2);
            arg0.regular_ticket_minted = arg0.regular_ticket_minted + 1;
        } else {
            assert!(v0 <= arg0.minting_start + 259200000 || arg0.discount_ticket_minted < arg0.discount_ticket_reserved, 2);
            arg0.discount_ticket_minted = arg0.discount_ticket_minted + 1;
        };
        let TestTicket {
            id          : v1,
            ticket_type : _,
            expiration  : _,
            mint_price  : v4,
            name        : _,
            description : _,
            image_url   : _,
        } = arg1;
        0x2::object::delete(v1);
        let v8 = select_random_id(arg0, arg5, arg8);
        let v9 = create_nft(arg0, v8, arg8);
        arg0.minted = arg0.minted + 1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v4, arg8), arg0.admin_address);
        0x2::kiosk::lock<TestNFT>(arg6, arg7, arg3, v9);
        let v10 = NFTMinted{
            nft_id  : 0x2::object::id<TestNFT>(&v9),
            Test_id : v8,
            minter  : 0x2::tx_context::sender(arg8),
        };
        0x2::event::emit<NFTMinted>(v10);
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg8));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
    }

    public entry fun pause_minting(arg0: &AdminCap, arg1: &mut TestCollection) {
        arg1.minting_start = 18446744073709551615;
    }

    fun remove_specific_id(arg0: &mut TestCollection, arg1: u64) : u64 {
        let (v0, v1) = 0x1::vector::index_of<u64>(&arg0.available_ids, &arg1);
        assert!(v0, 6);
        0x1::vector::remove<u64>(&mut arg0.available_ids, v1)
    }

    public entry fun resume_minting(arg0: &AdminCap, arg1: &mut TestCollection, arg2: u64) {
        arg1.minting_start = arg2;
    }

    fun select_random_id(arg0: &mut TestCollection, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(!0x1::vector::is_empty<u64>(&arg0.available_ids), 6);
        let v0 = 0x2::random::new_generator(arg1, arg2);
        0x1::vector::swap_remove<u64>(&mut arg0.available_ids, (0x2::random::generate_u64_in_range(&mut v0, 0, (0x1::vector::length<u64>(&arg0.available_ids) as u64)) as u64))
    }

    public entry fun set_bulk_nft_attributes(arg0: &AdminCap, arg1: &mut TestCollection, arg2: vector<u64>, arg3: vector<vector<0x1::string::String>>, arg4: vector<vector<0x1::string::String>>) {
        let v0 = 0;
        let v1 = 0x1::vector::length<u64>(&arg2);
        assert!(v1 == 0x1::vector::length<vector<0x1::string::String>>(&arg3) && v1 == 0x1::vector::length<vector<0x1::string::String>>(&arg4), 0);
        while (v0 < v1) {
            set_nft_attributes(arg0, arg1, *0x1::vector::borrow<u64>(&arg2, v0), *0x1::vector::borrow<vector<0x1::string::String>>(&arg3, v0), *0x1::vector::borrow<vector<0x1::string::String>>(&arg4, v0));
            v0 = v0 + 1;
        };
    }

    public entry fun set_bulk_nft_urls(arg0: &AdminCap, arg1: &mut TestCollection, arg2: vector<u64>, arg3: vector<vector<u8>>) {
        let v0 = 0;
        let v1 = 0x1::vector::length<u64>(&arg2);
        assert!(v1 == 0x1::vector::length<vector<u8>>(&arg3), 0);
        while (v0 < v1) {
            set_nft_url(arg0, arg1, *0x1::vector::borrow<u64>(&arg2, v0), *0x1::vector::borrow<vector<u8>>(&arg3, v0));
            v0 = v0 + 1;
        };
    }

    public entry fun set_nft_attributes(arg0: &AdminCap, arg1: &mut TestCollection, arg2: u64, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>) {
        assert!(arg2 > 0 && arg2 <= 3333, 7);
        assert!(0x1::vector::length<0x1::string::String>(&arg3) == 0x1::vector::length<0x1::string::String>(&arg4), 0);
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg3)) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, *0x1::vector::borrow<0x1::string::String>(&arg3, v1), *0x1::vector::borrow<0x1::string::String>(&arg4, v1));
            v1 = v1 + 1;
        };
        0x2::table::add<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&mut arg1.preset_attributes, arg2, v0);
    }

    public entry fun set_nft_url(arg0: &AdminCap, arg1: &mut TestCollection, arg2: u64, arg3: vector<u8>) {
        assert!(arg2 > 0 && arg2 <= 3333, 7);
        0x2::table::add<u64, 0x2::url::Url>(&mut arg1.preset_urls, arg2, 0x2::url::new_unsafe_from_bytes(arg3));
    }

    public entry fun set_reserved_amounts(arg0: &AdminCap, arg1: &mut TestCollection, arg2: u64, arg3: u64) {
        assert!(arg2 + arg3 < 3333, 12);
        arg1.regular_ticket_reserved = arg2;
        arg1.discount_ticket_reserved = arg3;
    }

    public entry fun set_ticket_image(arg0: &AdminCap, arg1: &mut TestCollection, arg2: u8, arg3: vector<u8>) {
        assert!(arg2 <= 1, 7);
        0x2::table::add<u8, 0x2::url::Url>(&mut arg1.preset_ticket_urls, arg2, 0x2::url::new_unsafe_from_bytes(arg3));
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

    public entry fun update_admin_address(arg0: &AdminCap, arg1: &mut TestCollection, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.admin_address, 4);
        arg1.admin_address = arg2;
        let v0 = AdminUpdated{new_admin: arg2};
        0x2::event::emit<AdminUpdated>(v0);
    }

    public entry fun update_mint_price(arg0: &AdminCap, arg1: &mut TestCollection, arg2: u64) {
        assert!(arg2 > 0, 10);
        arg1.public_mint_price = arg2;
        let v0 = PriceUpdated{new_price: arg2};
        0x2::event::emit<PriceUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

