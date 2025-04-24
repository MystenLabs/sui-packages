module 0x8aef2810a3065b29729ab6a293d93ccc44c908f797028db5c953500fa39622ec::drops {
    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        token_id: u64,
        nft_type: 0x1::string::String,
        random_number: u64,
        total_minted: u64,
    }

    struct NumberRedrawn has copy, drop {
        token_id: u64,
        nft_type: 0x1::string::String,
        old_number: u64,
        new_number: u64,
        timestamp_ms: u64,
    }

    struct DROPS has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct MintData has key {
        id: 0x2::object::UID,
        total_minted: u64,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        token_id: u64,
        random_number: u64,
        nft_type: 0x1::string::String,
    }

    fun create_nft(arg0: u64, arg1: u64, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : NFT {
        let v0 = 0x1::string::utf8(b"Doonies Drops #");
        0x1::string::append(&mut v0, u64_to_string(arg0));
        let v1 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1, 0x1::string::utf8(b"Type"), arg2);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1, 0x1::string::utf8(b"Art"), 0x1::string::utf8(b"Nose Grab"));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1, 0x1::string::utf8(b"Number"), 0x1::string::utf8(b"#"));
        let v2 = 0x1::string::utf8(b"Number");
        0x1::string::append(0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut v1, &v2), u64_to_string(arg1));
        let v3 = if (arg2 == 0x1::string::utf8(b"Doonies Deck")) {
            0x1::string::utf8(b"-deHe0N4CfsJk3neq5TtWPhm0bW_FtkgGuJ65rOdIUI")
        } else {
            0x1::string::utf8(b"bk25sKZDSfwoPvHv_e3dXKw5sY4NQdF9ZjFRffikiOc")
        };
        let v4 = v3;
        NFT{
            id            : 0x2::object::new(arg3),
            name          : v0,
            description   : 0x1::string::utf8(b"Doonies Drops - Exclusive NFT Collection"),
            image_url     : 0x2::url::new_unsafe_from_bytes(*0x1::string::as_bytes(&v4)),
            attributes    : v1,
            token_id      : arg0,
            random_number : arg1,
            nft_type      : arg2,
        }
    }

    public fun get_deck_supply() : u64 {
        10
    }

    public fun get_merch_supply() : u64 {
        10
    }

    public fun get_minted_deck(arg0: &MintData) : u64 {
        let v0 = arg0.total_minted;
        if (v0 > 10) {
            10
        } else {
            v0
        }
    }

    public fun get_minted_merch(arg0: &MintData) : u64 {
        if (arg0.total_minted <= 10) {
            0
        } else {
            arg0.total_minted - 10
        }
    }

    public fun get_total_minted(arg0: &MintData) : u64 {
        arg0.total_minted
    }

    public fun get_total_supply() : u64 {
        20
    }

    fun init(arg0: DROPS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<DROPS>(arg0, arg1);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        let v2 = MintData{
            id           : 0x2::object::new(arg1),
            total_minted : 0,
        };
        let v3 = 0x2::display::new<NFT>(&v0, arg1);
        0x2::display::add<NFT>(&mut v3, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<NFT>(&mut v3, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<NFT>(&mut v3, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://walrus.tusky.io/{image_url}"));
        0x2::display::add<NFT>(&mut v3, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::update_version<NFT>(&mut v3);
        let (v4, v5) = 0x2::transfer_policy::new<NFT>(&v0, arg1);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<NFT>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<NFT>>(v4);
        0x2::transfer::share_object<MintData>(v2);
    }

    public entry fun mint_deck_nft(arg0: &AdminCap, arg1: &mut MintData, arg2: &0x2::random::Random, arg3: &0x2::transfer_policy::TransferPolicy<NFT>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg6);
        assert!(arg1.total_minted < 20, 2);
        assert!(get_minted_deck(arg1) < 10, 2);
        let v0 = 0x2::random::new_generator(arg2, arg6);
        let v1 = 0x2::random::generate_u64_in_range(&mut v0, 1, 4444 + 1);
        let v2 = arg1.total_minted + 1;
        let v3 = create_nft(v2, v1, 0x1::string::utf8(b"Doonies Deck"), arg6);
        arg1.total_minted = arg1.total_minted + 1;
        0x2::kiosk::lock<NFT>(arg4, arg5, arg3, v3);
        let v4 = NFTMinted{
            nft_id        : 0x2::object::id<NFT>(&v3),
            token_id      : v2,
            nft_type      : 0x1::string::utf8(b"Doonies Deck"),
            random_number : v1,
            total_minted  : arg1.total_minted,
        };
        0x2::event::emit<NFTMinted>(v4);
    }

    public entry fun mint_merch_nft(arg0: &AdminCap, arg1: &mut MintData, arg2: &0x2::random::Random, arg3: &0x2::transfer_policy::TransferPolicy<NFT>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg6);
        assert!(arg1.total_minted < 20, 2);
        assert!(get_minted_merch(arg1) < 10, 2);
        let v0 = 0x2::random::new_generator(arg2, arg6);
        let v1 = 0x2::random::generate_u64_in_range(&mut v0, 1, 4444 + 1);
        let v2 = arg1.total_minted + 1;
        let v3 = create_nft(v2, v1, 0x1::string::utf8(b"Doonies Merch"), arg6);
        arg1.total_minted = arg1.total_minted + 1;
        0x2::kiosk::lock<NFT>(arg4, arg5, arg3, v3);
        let v4 = NFTMinted{
            nft_id        : 0x2::object::id<NFT>(&v3),
            token_id      : v2,
            nft_type      : 0x1::string::utf8(b"Doonies Merch"),
            random_number : v1,
            total_minted  : arg1.total_minted,
        };
        0x2::event::emit<NFTMinted>(v4);
    }

    public entry fun redraw_number(arg0: &AdminCap, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0 && arg3 <= 20, 3);
        let v0 = 0x2::random::new_generator(arg1, arg5);
        let v1 = if (arg3 <= 10) {
            0x1::string::utf8(b"Doonies Deck")
        } else {
            0x1::string::utf8(b"Doonies Merch")
        };
        let v2 = NumberRedrawn{
            token_id     : arg3,
            nft_type     : v1,
            old_number   : arg4,
            new_number   : 0x2::random::generate_u64_in_range(&mut v0, 1, 4444 + 1),
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<NumberRedrawn>(v2);
    }

    fun u64_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 != 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10 + 48) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    // decompiled from Move bytecode v6
}

