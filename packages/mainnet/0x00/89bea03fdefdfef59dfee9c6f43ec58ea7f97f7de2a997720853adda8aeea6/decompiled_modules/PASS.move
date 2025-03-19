module 0xd4a5357803533dcc0577f9ccc918a121b52f1fac65e89e1d7a23dc9c22298cd7::PASS {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct AdminUpdated has copy, drop {
        new_admin: address,
    }

    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        sweeb_id: u64,
        minter: address,
    }

    struct PriceUpdated has copy, drop {
        new_price: u64,
    }

    struct PASS has drop {
        dummy_field: bool,
    }

    struct OathCollection has key {
        id: 0x2::object::UID,
        minted: u64,
        discount_ticket_reserved: u64,
        discount_ticket_minted: u64,
        public_minted: u64,
        available_ids: vector<u64>,
        preset_urls: 0x2::table::Table<u64, 0x2::url::Url>,
        preset_ticket_urls: 0x2::table::Table<u8, 0x2::url::Url>,
        minting_start: u64,
        public_mint_price: u64,
        discount_price: u64,
        admin_address: address,
    }

    struct OathNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        nft_id: u64,
    }

    struct OathTicket has store, key {
        id: 0x2::object::UID,
        expiration: u64,
        mint_price: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
    }

    struct TicketCreated has copy, drop {
        ticket_id: 0x2::object::ID,
        ticket_type: u8,
        recipient: address,
        mint_price: u64,
    }

    public entry fun burn_nft(arg0: OathNFT, arg1: &mut OathCollection) {
        let OathNFT {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
            nft_id      : v4,
        } = arg0;
        0x2::object::delete(v0);
        0x1::vector::push_back<u64>(&mut arg1.available_ids, v4);
        arg1.minted = arg1.minted - 1;
    }

    public entry fun create_discount_tickets(arg0: &AdminCap, arg1: &mut OathCollection, arg2: vector<address>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 < arg1.public_mint_price, 11);
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(arg1.discount_ticket_minted + v0 <= arg1.discount_ticket_reserved, 1);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<address>(&arg2, v1);
            let v3 = OathTicket{
                id          : 0x2::object::new(arg5),
                expiration  : arg3 + 3600000,
                mint_price  : arg4,
                name        : 0x1::string::utf8(b"The Oath Whitelist Pass"),
                description : 0x1::string::utf8(b"This is your Whitelist ticket for minting The Oath Pass. Holding The Oath Pass signifies your commitment and early support for The Order. More information can be found on Twitter: @theordersui and at: https://theorder.site/"),
                image_url   : 0x2::url::new_unsafe_from_bytes(b"https://theorder.mypinata.cloud/ipfs/bafybeieg65uhpmpcwsq7b4spo65lqaetz57kcjuubpx74ubayg4puxdrrq"),
            };
            0x2::transfer::transfer<OathTicket>(v3, v2);
            let v4 = TicketCreated{
                ticket_id   : 0x2::object::id<OathTicket>(&v3),
                ticket_type : 1,
                recipient   : v2,
                mint_price  : arg4,
            };
            0x2::event::emit<TicketCreated>(v4);
            v1 = v1 + 1;
        };
    }

    fun create_nft(arg0: &OathCollection, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : OathNFT {
        let v0 = 0x1::string::utf8(b"https://theorder.mypinata.cloud/ipfs/bafybeiazh27gs4iofzoij27p5rmplivbnbpizsmvb7d3pdhojmotoktnbq");
        OathNFT{
            id          : 0x2::object::new(arg2),
            name        : 0x1::string::utf8(b"Oath Pass"),
            description : 0x1::string::utf8(b"With the Oath Pass, you have sworn allegiance to The Order, joining an elite circle of 666 seekers. Embark on a journey shrouded in mystery, where truths are revealed only to the devoted. www.theorder.site"),
            image_url   : 0x2::url::new_unsafe_from_bytes(*0x1::string::as_bytes(&v0)),
            nft_id      : arg1,
        }
    }

    public fun get_admin_address(arg0: &OathCollection) : address {
        arg0.admin_address
    }

    public fun get_available_public_nfts(arg0: &OathCollection, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 616 - arg0.discount_ticket_reserved;
        let v1 = v0;
        if (0x2::clock::timestamp_ms(arg1) > arg0.minting_start + 3600000) {
            v1 = v0 + arg0.discount_ticket_reserved - arg0.discount_ticket_minted;
        };
        v1 - arg0.public_minted
    }

    public fun get_discount_ticket_minted(arg0: &OathCollection) : u64 {
        arg0.discount_ticket_minted
    }

    public fun get_minted(arg0: &OathCollection) : u64 {
        arg0.minted
    }

    fun get_next_id(arg0: &mut OathCollection) : u64 {
        assert!(!0x1::vector::is_empty<u64>(&arg0.available_ids), 6);
        0x1::vector::remove<u64>(&mut arg0.available_ids, 0)
    }

    public fun get_nft_id(arg0: &OathNFT) : u64 {
        arg0.nft_id
    }

    public fun get_public_mint_price(arg0: &OathCollection) : u64 {
        arg0.public_mint_price
    }

    public fun get_public_minted(arg0: &OathCollection) : u64 {
        arg0.public_minted
    }

    public fun get_remaining_nfts(arg0: &OathCollection) : u64 {
        0x1::vector::length<u64>(&arg0.available_ids)
    }

    public fun get_total_supply() : u64 {
        666
    }

    fun init(arg0: PASS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<PASS>(arg0, arg1);
        let v1 = OathCollection{
            id                       : 0x2::object::new(arg1),
            minted                   : 0,
            discount_ticket_reserved : 0,
            discount_ticket_minted   : 0,
            public_minted            : 0,
            available_ids            : 0x1::vector::empty<u64>(),
            preset_urls              : 0x2::table::new<u64, 0x2::url::Url>(arg1),
            preset_ticket_urls       : 0x2::table::new<u8, 0x2::url::Url>(arg1),
            minting_start            : 0,
            public_mint_price        : 2000000000,
            discount_price           : 1000000000,
            admin_address            : @0xee845ec4a75948d54ae60e126aaab86afa383ff7a9af945ec8e55292e77abe36,
        };
        let v2 = 1;
        while (v2 <= 666) {
            0x1::vector::push_back<u64>(&mut v1.available_ids, v2);
            v2 = v2 + 1;
        };
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        let v4 = 0x2::display::new<OathNFT>(&v0, arg1);
        0x2::display::add<OathNFT>(&mut v4, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<OathNFT>(&mut v4, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<OathNFT>(&mut v4, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::update_version<OathNFT>(&mut v4);
        let v5 = 0x2::display::new<OathTicket>(&v0, arg1);
        0x2::display::add<OathTicket>(&mut v5, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<OathTicket>(&mut v5, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<OathTicket>(&mut v5, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::update_version<OathTicket>(&mut v5);
        let (v6, v7) = 0x2::transfer_policy::new<OathNFT>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<OathNFT>>(v6);
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<OathNFT>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<OathTicket>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<OathNFT>>(v7, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<OathCollection>(v1);
    }

    public fun is_minting_active(arg0: &OathCollection, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.minting_start
    }

    public fun is_nft_minted(arg0: &OathCollection, arg1: u64) : bool {
        !0x1::vector::contains<u64>(&arg0.available_ids, &arg1)
    }

    public fun is_ticket_valid(arg0: &OathTicket, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) <= arg0.expiration
    }

    public entry fun mint_admin(arg0: &AdminCap, arg1: &mut OathCollection, arg2: &0x2::transfer_policy::TransferPolicy<OathNFT>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 50) {
            let v1 = get_next_id(arg1);
            let v2 = create_nft(arg1, v1, arg5);
            arg1.minted = arg1.minted + 1;
            0x2::kiosk::lock<OathNFT>(arg3, arg4, arg2, v2);
            let v3 = NFTMinted{
                nft_id   : 0x2::object::id<OathNFT>(&v2),
                sweeb_id : v1,
                minter   : 0x2::tx_context::sender(arg5),
            };
            0x2::event::emit<NFTMinted>(v3);
            v0 = v0 + 1;
        };
    }

    public entry fun mint_public(arg0: &mut OathCollection, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::transfer_policy::TransferPolicy<OathNFT>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= arg0.minting_start, 2);
        assert!(arg0.minted < 666, 1);
        assert!(arg6 > 0 && arg6 <= 5, 0);
        let v1 = arg0.public_mint_price * arg6;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v1, 9);
        let v2 = 616 - arg0.discount_ticket_reserved;
        let v3 = v2;
        if (v0 > arg0.minting_start + 3600000) {
            v3 = v2 + arg0.discount_ticket_reserved - arg0.discount_ticket_minted;
        };
        assert!(arg0.public_minted + arg6 <= v3, 1);
        let v4 = 0;
        while (v4 < arg6) {
            let v5 = get_next_id(arg0);
            let v6 = create_nft(arg0, v5, arg7);
            arg0.minted = arg0.minted + 1;
            arg0.public_minted = arg0.public_minted + 1;
            0x2::kiosk::lock<OathNFT>(arg4, arg5, arg2, v6);
            let v7 = NFTMinted{
                nft_id   : 0x2::object::id<OathNFT>(&v6),
                sweeb_id : v5,
                minter   : 0x2::tx_context::sender(arg7),
            };
            0x2::event::emit<NFTMinted>(v7);
            v4 = v4 + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v1, arg7), arg0.admin_address);
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg7));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
    }

    public entry fun mint_with_ticket(arg0: &mut OathCollection, arg1: OathTicket, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::transfer_policy::TransferPolicy<OathNFT>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 >= arg0.minting_start, 2);
        assert!(v0 <= arg1.expiration, 8);
        assert!(arg0.minted < 666, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg1.mint_price, 9);
        assert!(v0 <= arg0.minting_start + 3600000 || arg0.discount_ticket_minted < arg0.discount_ticket_reserved, 2);
        arg0.discount_ticket_minted = arg0.discount_ticket_minted + 1;
        let OathTicket {
            id          : v1,
            expiration  : _,
            mint_price  : v3,
            name        : _,
            description : _,
            image_url   : _,
        } = arg1;
        0x2::object::delete(v1);
        let v7 = get_next_id(arg0);
        let v8 = create_nft(arg0, v7, arg7);
        arg0.minted = arg0.minted + 1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v3, arg7), arg0.admin_address);
        0x2::kiosk::lock<OathNFT>(arg5, arg6, arg3, v8);
        let v9 = NFTMinted{
            nft_id   : 0x2::object::id<OathNFT>(&v8),
            sweeb_id : v7,
            minter   : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<NFTMinted>(v9);
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg7));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
    }

    public entry fun pause_minting(arg0: &AdminCap, arg1: &mut OathCollection) {
        arg1.minting_start = 18446744073709551615;
    }

    fun remove_specific_id(arg0: &mut OathCollection, arg1: u64) : u64 {
        let (v0, v1) = 0x1::vector::index_of<u64>(&arg0.available_ids, &arg1);
        assert!(v0, 6);
        0x1::vector::remove<u64>(&mut arg0.available_ids, v1)
    }

    public entry fun resume_minting(arg0: &AdminCap, arg1: &mut OathCollection, arg2: u64) {
        arg1.minting_start = arg2;
    }

    public entry fun set_bulk_nft_urls(arg0: &AdminCap, arg1: &mut OathCollection, arg2: vector<u64>, arg3: vector<vector<u8>>) {
        let v0 = 0;
        let v1 = 0x1::vector::length<u64>(&arg2);
        assert!(v1 == 0x1::vector::length<vector<u8>>(&arg3), 0);
        while (v0 < v1) {
            set_nft_url(arg0, arg1, *0x1::vector::borrow<u64>(&arg2, v0), *0x1::vector::borrow<vector<u8>>(&arg3, v0));
            v0 = v0 + 1;
        };
    }

    public entry fun set_nft_url(arg0: &AdminCap, arg1: &mut OathCollection, arg2: u64, arg3: vector<u8>) {
        assert!(arg2 > 0 && arg2 <= 666, 7);
        0x2::table::add<u64, 0x2::url::Url>(&mut arg1.preset_urls, arg2, 0x2::url::new_unsafe_from_bytes(arg3));
    }

    public entry fun set_reserved_amounts(arg0: &AdminCap, arg1: &mut OathCollection, arg2: u64, arg3: u64) {
        arg1.discount_ticket_reserved = arg3;
    }

    public entry fun set_ticket_image(arg0: &AdminCap, arg1: &mut OathCollection, arg2: u8, arg3: vector<u8>) {
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

    public entry fun update_admin_address(arg0: &AdminCap, arg1: &mut OathCollection, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.admin_address, 4);
        arg1.admin_address = arg2;
        let v0 = AdminUpdated{new_admin: arg2};
        0x2::event::emit<AdminUpdated>(v0);
    }

    public entry fun update_mint_price(arg0: &AdminCap, arg1: &mut OathCollection, arg2: u64) {
        assert!(arg2 > 0, 10);
        arg1.public_mint_price = arg2;
        let v0 = PriceUpdated{new_price: arg2};
        0x2::event::emit<PriceUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

