module 0x872a90dd3950bede23ae091775425f52b6507f3f6bd52da1442037846aa084f3::OnChainPixelDrop {
    struct ONCHAINPIXELDROP has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has store, key {
        id: 0x2::object::UID,
        max_supply: u64,
        mint_count: u64,
        minting_enabled: bool,
        mint_price: u64,
        royalty_bps: u64,
        royalty_min_amount: u64,
        platform_drop_fee: u64,
        drop_creation_fee: u64,
        platform_wallet: address,
    }

    struct Nft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        media_url: 0x2::url::Url,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        rarity: u64,
        creator: address,
        mint_price: u64,
        max_copies: u64,
        copies_minted: u64,
        is_original: bool,
        original_nft_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct PlatformTreasury has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        mint_price: u64,
    }

    struct MintingStatusChanged has copy, drop {
        admin: address,
        enabled: bool,
    }

    struct MintPriceChanged has copy, drop {
        admin: address,
        old_price: u64,
        new_price: u64,
    }

    struct RoyaltyChanged has copy, drop {
        admin: address,
        old_bps: u64,
        new_bps: u64,
        old_min_amount: u64,
        new_min_amount: u64,
    }

    struct PlatformDropFeeChanged has copy, drop {
        admin: address,
        old_drop_fee: u64,
        new_drop_fee: u64,
    }

    struct DropCreationFeeChanged has copy, drop {
        admin: address,
        old_creation_fee: u64,
        new_creation_fee: u64,
    }

    struct PlatformWalletChanged has copy, drop {
        admin: address,
        old_wallet: address,
        new_wallet: address,
    }

    struct NftDropConfigured has copy, drop {
        nft_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        mint_price: u64,
        max_copies: u64,
    }

    struct NftCopyMinted has copy, drop {
        original_nft_id: 0x2::object::ID,
        copy_nft_id: 0x2::object::ID,
        minter: address,
        creator: address,
        mint_price: u64,
        creator_earnings: u64,
        platform_fee: u64,
    }

    public fun transfer(arg0: Nft, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Nft>(arg0, arg1);
    }

    public fun admin_burn(arg0: Nft, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let Nft {
            id              : v0,
            name            : _,
            description     : _,
            media_url       : _,
            attributes      : _,
            rarity          : _,
            creator         : _,
            mint_price      : _,
            max_copies      : _,
            copies_minted   : _,
            is_original     : _,
            original_nft_id : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun assert_mintable(arg0: &Config) {
        if (arg0.max_supply > 0) {
            assert!(arg0.mint_count < arg0.max_supply, 0);
        };
    }

    public fun attributes(arg0: &Nft) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.attributes
    }

    public fun burn(arg0: Nft, arg1: &mut 0x2::tx_context::TxContext) {
        let Nft {
            id              : v0,
            name            : _,
            description     : _,
            media_url       : _,
            attributes      : _,
            rarity          : _,
            creator         : _,
            mint_price      : _,
            max_copies      : _,
            copies_minted   : _,
            is_original     : _,
            original_nft_id : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun configure_nft_drop(arg0: &mut Nft, arg1: u64, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &Config, arg5: &mut PlatformTreasury, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(arg0.creator == v0, 10);
        assert!(arg0.is_original, 10);
        assert!(arg1 > 0, 7);
        let v1 = arg4.drop_creation_fee;
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v2 >= v1, 2);
        let arg3 = if (v2 == v1) {
            arg3
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v2 - v1, arg6), v0);
            arg3
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg5.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        arg0.mint_price = arg1;
        arg0.max_copies = arg2;
        let v3 = NftDropConfigured{
            nft_id     : 0x2::object::uid_to_inner(&arg0.id),
            creator    : arg0.creator,
            name       : arg0.name,
            mint_price : arg1,
            max_copies : arg2,
        };
        0x2::event::emit<NftDropConfigured>(v3);
    }

    public entry fun consolidate_royalty_fees(arg0: &mut 0x2::transfer_policy::TransferPolicy<Nft>, arg1: &0x2::transfer_policy::TransferPolicyCap<Nft>, arg2: &mut PlatformTreasury, arg3: &AdminCap, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::transfer_policy::withdraw<Nft>(arg0, arg1, 0x1::option::none<u64>(), arg4)));
    }

    public fun description(arg0: &Nft) : &0x1::string::String {
        &arg0.description
    }

    public fun drop_creation_fee(arg0: &Config) : u64 {
        arg0.drop_creation_fee
    }

    public fun get_nft_drop_info(arg0: &Nft) : (address, u64, u64, u64, bool) {
        (arg0.creator, arg0.mint_price, arg0.max_copies, arg0.copies_minted, arg0.is_original)
    }

    fun impl_mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : Nft {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg3)) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, *0x1::vector::borrow<0x1::string::String>(&arg3, v1), *0x1::vector::borrow<0x1::string::String>(&arg4, v1));
            v1 = v1 + 1;
        };
        Nft{
            id              : 0x2::object::new(arg6),
            name            : arg0,
            description     : arg1,
            media_url       : 0x2::url::new_unsafe(0x1::string::to_ascii(arg2)),
            attributes      : v0,
            rarity          : arg5,
            creator         : 0x2::tx_context::sender(arg6),
            mint_price      : 0,
            max_copies      : 0,
            copies_minted   : 0,
            is_original     : true,
            original_nft_id : 0x1::option::none<0x2::object::ID>(),
        }
    }

    fun init(arg0: ONCHAINPIXELDROP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<ONCHAINPIXELDROP>(arg0, arg1);
        let v1 = 0x2::tx_context::sender(arg1);
        let (v2, v3) = 0x2::transfer_policy::new<Nft>(&v0, arg1);
        setup_display(0x2::display::new<Nft>(&v0, arg1), v1);
        setup_rules(v2, v3, v1);
        let v4 = Config{
            id                 : 0x2::object::new(arg1),
            max_supply         : 0,
            mint_count         : 0,
            minting_enabled    : true,
            mint_price         : 100000000,
            royalty_bps        : 200,
            royalty_min_amount : 100000000,
            platform_drop_fee  : 150000000,
            drop_creation_fee  : 250000000,
            platform_wallet    : v1,
        };
        0x2::transfer::share_object<Config>(v4);
        let v5 = PlatformTreasury{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<PlatformTreasury>(v5);
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v6, v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v1);
    }

    public fun is_minting_enabled(arg0: &Config) : bool {
        arg0.minting_enabled
    }

    public fun is_nft_available_for_copying(arg0: &Nft) : bool {
        if (arg0.is_original) {
            if (arg0.mint_price > 0) {
                arg0.max_copies == 0 || arg0.copies_minted < arg0.max_copies
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun max_supply(arg0: &Config) : u64 {
        arg0.max_supply
    }

    public fun media_url(arg0: &Nft) : &0x2::url::Url {
        &arg0.media_url
    }

    public fun mint_count(arg0: &Config) : u64 {
        arg0.mint_count
    }

    public entry fun mint_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: u64, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut Config, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg7.minting_enabled, 1);
        assert_mintable(arg7);
        let v0 = arg7.mint_price;
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg6);
        assert!(v1 >= v0, 2);
        let v2 = 0x2::tx_context::sender(arg8);
        let arg6 = if (v1 == v0) {
            arg6
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg6, v1 - v0, arg8), v2);
            arg6
        };
        let v3 = impl_mint(arg0, arg1, arg2, arg3, arg4, arg5, arg8);
        let v4 = NFTMinted{
            object_id  : 0x2::object::uid_to_inner(&v3.id),
            creator    : v2,
            name       : v3.name,
            mint_price : v0,
        };
        0x2::event::emit<NFTMinted>(v4);
        arg7.mint_count = arg7.mint_count + 1;
        0x2::transfer::public_transfer<Nft>(v3, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg6, arg7.platform_wallet);
    }

    public entry fun mint_nft_copy(arg0: &mut Nft, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &Config, arg3: &mut PlatformTreasury, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.mint_price > 0, 8);
        assert!(arg0.is_original, 8);
        if (arg0.max_copies > 0) {
            assert!(arg0.copies_minted < arg0.max_copies, 9);
        };
        let v0 = arg0.mint_price + arg2.platform_drop_fee;
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= v0, 2);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg1, v0, arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg4), arg0.creator);
        0x2::balance::join<0x2::sui::SUI>(&mut arg3.balance, 0x2::balance::split<0x2::sui::SUI>(&mut v1, arg2.platform_drop_fee));
        let v2 = Nft{
            id              : 0x2::object::new(arg4),
            name            : arg0.name,
            description     : arg0.description,
            media_url       : arg0.media_url,
            attributes      : arg0.attributes,
            rarity          : arg0.rarity,
            creator         : arg0.creator,
            mint_price      : 0,
            max_copies      : 0,
            copies_minted   : 0,
            is_original     : false,
            original_nft_id : 0x1::option::some<0x2::object::ID>(0x2::object::uid_to_inner(&arg0.id)),
        };
        let v3 = 0x2::tx_context::sender(arg4);
        let v4 = NftCopyMinted{
            original_nft_id  : 0x2::object::uid_to_inner(&arg0.id),
            copy_nft_id      : 0x2::object::uid_to_inner(&v2.id),
            minter           : v3,
            creator          : arg0.creator,
            mint_price       : arg0.mint_price,
            creator_earnings : 0x2::balance::value<0x2::sui::SUI>(&v1),
            platform_fee     : arg2.platform_drop_fee,
        };
        0x2::event::emit<NftCopyMinted>(v4);
        arg0.copies_minted = arg0.copies_minted + 1;
        0x2::transfer::public_transfer<Nft>(v2, v3);
    }

    public entry fun mint_nft_drop(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: u64, arg6: u64, arg7: address, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: &mut Config, arg10: &mut PlatformTreasury, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg9.minting_enabled, 1);
        assert_mintable(arg9);
        let v0 = arg6 + arg9.platform_drop_fee;
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg8);
        assert!(v1 >= v0, 2);
        let v2 = 0x2::tx_context::sender(arg11);
        let arg8 = if (v1 == v0) {
            arg8
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg8, v1 - v0, arg11), v2);
            arg8
        };
        let v3 = 0x2::coin::into_balance<0x2::sui::SUI>(arg8);
        0x2::balance::join<0x2::sui::SUI>(&mut arg10.balance, 0x2::balance::split<0x2::sui::SUI>(&mut v3, arg9.platform_drop_fee));
        let v4 = 0x2::coin::from_balance<0x2::sui::SUI>(v3, arg11);
        let v5 = impl_mint(arg0, arg1, arg2, arg3, arg4, arg5, arg11);
        let v6 = NFTMinted{
            object_id  : 0x2::object::uid_to_inner(&v5.id),
            creator    : v2,
            name       : v5.name,
            mint_price : arg6,
        };
        0x2::event::emit<NFTMinted>(v6);
        arg9.mint_count = arg9.mint_count + 1;
        0x2::transfer::public_transfer<Nft>(v5, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, arg7);
    }

    public fun mint_price(arg0: &Config) : u64 {
        arg0.mint_price
    }

    public fun name(arg0: &Nft) : &0x1::string::String {
        &arg0.name
    }

    public fun original_nft_id(arg0: &Nft) : 0x1::option::Option<0x2::object::ID> {
        arg0.original_nft_id
    }

    public fun platform_drop_fee(arg0: &Config) : u64 {
        arg0.platform_drop_fee
    }

    public fun platform_treasury_balance(arg0: &PlatformTreasury) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun rarity(arg0: &Nft) : u64 {
        arg0.rarity
    }

    public fun royalty_bps(arg0: &Config) : u64 {
        arg0.royalty_bps
    }

    public fun royalty_min_amount(arg0: &Config) : u64 {
        arg0.royalty_min_amount
    }

    public entry fun set_drop_creation_fee(arg0: u64, arg1: &AdminCap, arg2: &mut Config, arg3: &mut 0x2::tx_context::TxContext) {
        arg2.drop_creation_fee = arg0;
        let v0 = DropCreationFeeChanged{
            admin            : 0x2::tx_context::sender(arg3),
            old_creation_fee : arg2.drop_creation_fee,
            new_creation_fee : arg0,
        };
        0x2::event::emit<DropCreationFeeChanged>(v0);
    }

    public entry fun set_mint_price(arg0: u64, arg1: &AdminCap, arg2: &mut Config, arg3: &mut 0x2::tx_context::TxContext) {
        arg2.mint_price = arg0;
        let v0 = MintPriceChanged{
            admin     : 0x2::tx_context::sender(arg3),
            old_price : arg2.mint_price,
            new_price : arg0,
        };
        0x2::event::emit<MintPriceChanged>(v0);
    }

    public entry fun set_minting_enabled(arg0: bool, arg1: &AdminCap, arg2: &mut Config, arg3: &mut 0x2::tx_context::TxContext) {
        arg2.minting_enabled = arg0;
        let v0 = MintingStatusChanged{
            admin   : 0x2::tx_context::sender(arg3),
            enabled : arg0,
        };
        0x2::event::emit<MintingStatusChanged>(v0);
    }

    public entry fun set_platform_drop_fee(arg0: u64, arg1: &AdminCap, arg2: &mut Config, arg3: &mut 0x2::tx_context::TxContext) {
        arg2.platform_drop_fee = arg0;
        let v0 = PlatformDropFeeChanged{
            admin        : 0x2::tx_context::sender(arg3),
            old_drop_fee : arg2.platform_drop_fee,
            new_drop_fee : arg0,
        };
        0x2::event::emit<PlatformDropFeeChanged>(v0);
    }

    public entry fun set_platform_wallet(arg0: address, arg1: &AdminCap, arg2: &mut Config, arg3: &mut 0x2::tx_context::TxContext) {
        arg2.platform_wallet = arg0;
        let v0 = PlatformWalletChanged{
            admin      : 0x2::tx_context::sender(arg3),
            old_wallet : arg2.platform_wallet,
            new_wallet : arg0,
        };
        0x2::event::emit<PlatformWalletChanged>(v0);
    }

    fun setup_display(arg0: 0x2::display::Display<Nft>, arg1: address) {
        0x2::display::add<Nft>(&mut arg0, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Nft>(&mut arg0, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Nft>(&mut arg0, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{media_url}"));
        0x2::display::add<Nft>(&mut arg0, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::add<Nft>(&mut arg0, 0x1::string::utf8(b"rarity"), 0x1::string::utf8(b"{rarity}"));
        0x2::display::add<Nft>(&mut arg0, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(b"OnChain Pixel"));
        0x2::display::add<Nft>(&mut arg0, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(b"OnChain Pixel NFT Collection - Create and mint pixel art NFTs on Sui"));
        0x2::display::add<Nft>(&mut arg0, 0x1::string::utf8(b"collection_image_url"), 0x1::string::utf8(b"https://example.com/collection-image.png"));
        0x2::display::add<Nft>(&mut arg0, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://onchainpixel.com"));
        0x2::display::add<Nft>(&mut arg0, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"OnChain Pixel"));
        0x2::display::update_version<Nft>(&mut arg0);
        0x2::transfer::public_transfer<0x2::display::Display<Nft>>(arg0, arg1);
    }

    fun setup_rules(arg0: 0x2::transfer_policy::TransferPolicy<Nft>, arg1: 0x2::transfer_policy::TransferPolicyCap<Nft>, arg2: address) {
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Nft>(&mut arg0, &arg1, 200, 100000000);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<Nft>(&mut arg0, &arg1);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Nft>>(arg1, arg2);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Nft>>(arg0);
    }

    public fun update_description(arg0: &mut Nft, arg1: 0x1::string::String, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.description = arg1;
    }

    public fun update_media_url(arg0: &mut Nft, arg1: 0x1::string::String, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.media_url = 0x2::url::new_unsafe(0x1::string::to_ascii(arg1));
    }

    public entry fun update_royalty_policy(arg0: &mut 0x2::transfer_policy::TransferPolicy<Nft>, arg1: &0x2::transfer_policy::TransferPolicyCap<Nft>, arg2: u64, arg3: u64, arg4: &AdminCap, arg5: &mut Config, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 1000, 3);
        0x2::transfer_policy::remove_rule<Nft, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Config>(arg0, arg1);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Nft>(arg0, arg1, (arg2 as u16), arg3);
        arg5.royalty_bps = arg2;
        arg5.royalty_min_amount = arg3;
        let v0 = RoyaltyChanged{
            admin          : 0x2::tx_context::sender(arg6),
            old_bps        : arg5.royalty_bps,
            new_bps        : arg2,
            old_min_amount : arg5.royalty_min_amount,
            new_min_amount : arg3,
        };
        0x2::event::emit<RoyaltyChanged>(v0);
    }

    public entry fun withdraw_platform_fees(arg0: &mut PlatformTreasury, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) > 0, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.balance), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

