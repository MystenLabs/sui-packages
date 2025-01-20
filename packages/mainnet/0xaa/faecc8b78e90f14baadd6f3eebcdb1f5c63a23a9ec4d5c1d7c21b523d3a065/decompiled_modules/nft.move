module 0xaafaecc8b78e90f14baadd6f3eebcdb1f5c63a23a9ec4d5c1d7c21b523d3a065::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct LevelNFT has store, key {
        id: 0x2::object::UID,
        level: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct LevelNFTRoyaltyRule has drop {
        dummy_field: bool,
    }

    struct LevelNFTRoyaltyConfig has drop, store {
        percent: u64,
    }

    struct LevelNFTLockRule has drop {
        dummy_field: bool,
    }

    struct LevelNFTLockConfig has drop, store {
        dummy_field: bool,
    }

    public fun fee_amount(arg0: &0x2::transfer_policy::TransferPolicy<LevelNFT>, arg1: u64) : u64 {
        let v0 = LevelNFTRoyaltyRule{dummy_field: false};
        arg1 * 0x2::transfer_policy::get_rule<LevelNFT, LevelNFTRoyaltyRule, LevelNFTRoyaltyConfig>(v0, arg0).percent / 100
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NFT>(arg0, arg1);
        0x2::display::create_and_keep<LevelNFT>(&v0, arg1);
        let (v1, v2) = 0x2::transfer_policy::new<LevelNFT>(&v0, arg1);
        let v3 = v2;
        let v4 = v1;
        let v5 = LevelNFTRoyaltyRule{dummy_field: false};
        let v6 = LevelNFTRoyaltyConfig{percent: 10};
        0x2::transfer_policy::add_rule<LevelNFT, LevelNFTRoyaltyRule, LevelNFTRoyaltyConfig>(v5, &mut v4, &v3, v6);
        let v7 = LevelNFTLockRule{dummy_field: false};
        let v8 = LevelNFTLockConfig{dummy_field: false};
        0x2::transfer_policy::add_rule<LevelNFT, LevelNFTLockRule, LevelNFTLockConfig>(v7, &mut v4, &v3, v8);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<LevelNFT>>(v4);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<LevelNFT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_level_nft(arg0: 0xf07162d27ad39dacd9a04f48df6e37f0923bd8b1feead1e5787f9891f1533982::level::LevelNFTTemplate<LevelNFT>, arg1: &mut 0x2::tx_context::TxContext) : LevelNFT {
        assert!(0xf07162d27ad39dacd9a04f48df6e37f0923bd8b1feead1e5787f9891f1533982::level::recipient<LevelNFT>(&arg0) == 0x2::tx_context::sender(arg1), 2);
        let v0 = LevelNFT{
            id          : 0x2::object::new(arg1),
            level       : 0xf07162d27ad39dacd9a04f48df6e37f0923bd8b1feead1e5787f9891f1533982::level::level<LevelNFT>(&arg0),
            name        : 0xf07162d27ad39dacd9a04f48df6e37f0923bd8b1feead1e5787f9891f1533982::level::name<LevelNFT>(&arg0),
            description : 0xf07162d27ad39dacd9a04f48df6e37f0923bd8b1feead1e5787f9891f1533982::level::description<LevelNFT>(&arg0),
            image_url   : 0xf07162d27ad39dacd9a04f48df6e37f0923bd8b1feead1e5787f9891f1533982::level::uri<LevelNFT>(&arg0),
            attributes  : 0xf07162d27ad39dacd9a04f48df6e37f0923bd8b1feead1e5787f9891f1533982::level::attributes<LevelNFT>(&arg0),
        };
        0xf07162d27ad39dacd9a04f48df6e37f0923bd8b1feead1e5787f9891f1533982::level::drop_after_minting<LevelNFT>(arg0, &v0);
        v0
    }

    public fun pay_royalty(arg0: &mut 0x2::transfer_policy::TransferPolicy<LevelNFT>, arg1: &mut 0x2::transfer_policy::TransferRequest<LevelNFT>, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == fee_amount(arg0, 0x2::transfer_policy::paid<LevelNFT>(arg1)), 0);
        let v0 = LevelNFTRoyaltyRule{dummy_field: false};
        0x2::transfer_policy::add_to_balance<LevelNFT, LevelNFTRoyaltyRule>(v0, arg0, arg2);
        let v1 = LevelNFTRoyaltyRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<LevelNFT, LevelNFTRoyaltyRule>(v1, arg1);
    }

    public fun prove(arg0: &mut 0x2::transfer_policy::TransferRequest<LevelNFT>, arg1: &0x2::kiosk::Kiosk) {
        let v0 = 0x2::transfer_policy::item<LevelNFT>(arg0);
        assert!(0x2::kiosk::has_item(arg1, v0) && 0x2::kiosk::is_locked(arg1, v0), 1);
        let v1 = LevelNFTLockRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<LevelNFT, LevelNFTLockRule>(v1, arg0);
    }

    public fun update_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::display::Display<LevelNFT>, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>) {
        let v0 = 0x2::vec_map::keys<0x1::string::String, 0x1::string::String>(0x2::display::fields<LevelNFT>(arg1));
        0x1::vector::reverse<0x1::string::String>(&mut v0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&v0)) {
            0x2::display::remove<LevelNFT>(arg1, 0x1::vector::pop_back<0x1::string::String>(&mut v0));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x1::string::String>(v0);
        0x2::display::add_multiple<LevelNFT>(arg1, arg2, arg3);
        0x2::display::update_version<LevelNFT>(arg1);
    }

    public fun update_transfer_policy(arg0: &0x2::package::Publisher, arg1: &mut 0x2::transfer_policy::TransferPolicy<LevelNFT>, arg2: &0x2::transfer_policy::TransferPolicyCap<LevelNFT>, arg3: u64) {
        0x2::transfer_policy::remove_rule<LevelNFT, LevelNFTRoyaltyRule, LevelNFTRoyaltyConfig>(arg1, arg2);
        let v0 = LevelNFTRoyaltyRule{dummy_field: false};
        let v1 = LevelNFTRoyaltyConfig{percent: arg3};
        0x2::transfer_policy::add_rule<LevelNFT, LevelNFTRoyaltyRule, LevelNFTRoyaltyConfig>(v0, arg1, arg2, v1);
    }

    // decompiled from Move bytecode v6
}

