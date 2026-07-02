module 0x9bf74cf02a8b1810b254bbbedd8f502ab911a663bd92e72629b70324d84408b8::misomosa_market {
    struct MISOMOSA_MARKET has drop {
        dummy_field: bool,
    }

    struct RoyaltyRule has drop {
        dummy_field: bool,
    }

    struct RoyaltyConfig has drop, store {
        bps: u16,
        treasury: address,
    }

    public fun delist<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID) {
        0x2::kiosk::delist<T0>(arg0, arg1, arg2);
    }

    public fun place_and_list<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: T0, arg3: u64) {
        0x2::kiosk::place_and_list<T0>(arg0, arg1, arg2, arg3);
    }

    public fun buy<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::transfer_policy::TransferPolicy<T0>, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) : T0 {
        let (v0, v1) = 0x2::kiosk::purchase<T0>(arg0, arg2, arg3);
        let v2 = v1;
        let v3 = &mut v2;
        pay_royalty<T0>(arg1, v3, arg4, arg5);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg1, v2);
        v0
    }

    public fun buy_and_keep<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::transfer_policy::TransferPolicy<T0>, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = buy<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg5));
    }

    fun init(arg0: MISOMOSA_MARKET, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<MISOMOSA_MARKET>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun open_kiosk(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v0);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun pay_royalty<T0>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = RoyaltyRule{dummy_field: false};
        let v1 = 0x2::transfer_policy::get_rule<T0, RoyaltyRule, RoyaltyConfig>(v0, arg0);
        let v2 = royalty_due(0x2::transfer_policy::paid<T0>(arg1), v1.bps);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v2, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v2, arg3), v1.treasury);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg3));
        let v3 = RoyaltyRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, RoyaltyRule>(v3, arg1);
    }

    public fun register_display<T0: key>(arg0: &0x2::package::Publisher, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::display::new_with_fields<T0>(arg0, arg1, arg2, arg3);
        0x2::display::update_version<T0>(&mut v0);
        0x2::transfer::public_transfer<0x2::display::Display<T0>>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun register_display_drop(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"misomosa Monthly Drop #{serial}"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Limited monthly drop collectible from the misomosa ecosystem."));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"https://misomosa.xyz"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"misomosa / Against the Grain"));
        register_display<0x9bf74cf02a8b1810b254bbbedd8f502ab911a663bd92e72629b70324d84408b8::limited_monthly_drop::DropNFT>(arg0, std_keys(), v0, arg1);
    }

    public fun register_display_exclusive(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"misomosa Exclusive Content Pass #{serial}"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"{tier_name} access to the {content_collection}. Utility/access only, not a security."));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"https://misomosa.xyz"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"misomosa / Against the Grain"));
        register_display<0x9bf74cf02a8b1810b254bbbedd8f502ab911a663bd92e72629b70324d84408b8::exclusive_content_nft::ExclusiveContentPass>(arg0, std_keys(), v0, arg1);
    }

    public fun register_display_genesis(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"misomosa Genesis VIP Pass #{serial}"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"{tier_name} tier Genesis access pass for the misomosa ecosystem. Utility/access only, not a security."));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"https://misomosa.xyz"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"misomosa / Against the Grain"));
        register_display<0x9bf74cf02a8b1810b254bbbedd8f502ab911a663bd92e72629b70324d84408b8::genesis_vip_pass::GenesisVIPPass>(arg0, std_keys(), v0, arg1);
    }

    public fun register_display_music(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"misomosa Music NFT #{serial}"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Against the Grain music collectible. Utility/access only, not a security."));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"https://misomosa.xyz"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Against the Grain"));
        register_display<0x9bf74cf02a8b1810b254bbbedd8f502ab911a663bd92e72629b70324d84408b8::stretch_gang_music_nft::MusicNFT>(arg0, std_keys(), v0, arg1);
    }

    public fun register_display_platinum(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"misomosa Platinum Controller Pass #{serial}"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Premium Stretch Gang controller pass. Utility/access only, not a security."));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"https://misomosa.xyz"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"misomosa / Stretch Gang"));
        register_display<0x9bf74cf02a8b1810b254bbbedd8f502ab911a663bd92e72629b70324d84408b8::platinum_controller_pass::PlatinumPass>(arg0, std_keys(), v0, arg1);
    }

    public fun royalty_due(arg0: u64, arg1: u16) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 10000) as u64)
    }

    public fun setup_policy<T0>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::transfer_policy::new<T0>(arg0, arg1);
        let v2 = v1;
        let v3 = v0;
        let v4 = RoyaltyRule{dummy_field: false};
        let v5 = RoyaltyConfig{
            bps      : 500,
            treasury : @0xb735145d8976ab7b26e868a88c2d789dbda9b5ace13e956889a7d03c1927fcf0,
        };
        0x2::transfer_policy::add_rule<T0, RoyaltyRule, RoyaltyConfig>(v4, &mut v3, &v2, v5);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<T0>>(v3);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<T0>>(v2, 0x2::tx_context::sender(arg1));
    }

    fun std_keys() : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        v0
    }

    // decompiled from Move bytecode v7
}

