module 0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::character_nft {
    struct CHARACTER_NFT has drop {
        dummy_field: bool,
    }

    struct Character has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        lore: 0x1::string::String,
        image_url: 0x1::string::String,
        attributes: 0x1::string::String,
        mmr: u64,
        edition: u64,
        minted_at: u64,
    }

    struct MintCounter has key {
        id: 0x2::object::UID,
        total_minted: u64,
    }

    struct MintCap has store, key {
        id: 0x2::object::UID,
    }

    struct CollectionMetadata has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        symbol: 0x1::string::String,
        website: 0x1::string::String,
        twitter: 0x1::string::String,
        discord: 0x1::string::String,
        total_supply: u64,
        royalty_percentage: u64,
    }

    struct CharacterBurned has copy, drop {
        nft_id: 0x2::object::ID,
        owner: address,
        edition: u64,
        timestamp: u64,
    }

    struct CharacterMinted has copy, drop {
        nft_id: 0x2::object::ID,
        owner: address,
        name: 0x1::string::String,
        edition: u64,
        kiosk_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct TransferPolicyCreated has copy, drop {
        policy_id: 0x2::object::ID,
        royalty_basis_points: u16,
        min_amount: u64,
    }

    struct KioskCreated has copy, drop {
        kiosk_id: 0x2::object::ID,
        owner: address,
        timestamp: u64,
    }

    struct BundleUpgraded has copy, drop {
        receipt_id: 0x2::object::ID,
        owner: address,
        additional_payment: u64,
        timestamp: u64,
    }

    struct CollectionMetadataCreated has copy, drop {
        metadata_id: 0x2::object::ID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        royalty_percentage: u64,
    }

    public fun burn(arg0: Character, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let Character {
            id         : v0,
            name       : _,
            lore       : _,
            image_url  : _,
            attributes : _,
            mmr        : _,
            edition    : v6,
            minted_at  : _,
        } = arg0;
        let v8 = v0;
        let v9 = CharacterBurned{
            nft_id    : 0x2::object::uid_to_inner(&v8),
            owner     : 0x2::tx_context::sender(arg2),
            edition   : v6,
            timestamp : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<CharacterBurned>(v9);
        0x2::object::delete(v8);
    }

    public fun burn_from_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &0x2::transfer_policy::TransferPolicy<Character>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        burn(0x2::kiosk::take<Character>(arg0, arg1, arg2), arg4, arg5);
    }

    public fun create_kiosk(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        let v2 = v0;
        let v3 = KioskCreated{
            kiosk_id  : 0x2::object::id<0x2::kiosk::Kiosk>(&v2),
            owner     : 0x2::tx_context::sender(arg0),
            timestamp : 0,
        };
        0x2::event::emit<KioskCreated>(v3);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun get_character_info(arg0: &Character) : (0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, u64, u64, u64) {
        (arg0.name, arg0.lore, arg0.image_url, arg0.attributes, arg0.mmr, arg0.edition, arg0.minted_at)
    }

    public fun get_collection_info(arg0: &CollectionMetadata) : (0x1::string::String, 0x1::string::String, 0x1::string::String, u64, u64) {
        (arg0.name, arg0.description, arg0.symbol, arg0.total_supply, arg0.royalty_percentage)
    }

    public fun get_collection_name(arg0: &CollectionMetadata) : 0x1::string::String {
        arg0.name
    }

    public fun get_edition(arg0: &Character) : u64 {
        arg0.edition
    }

    public fun get_image_url(arg0: &Character) : 0x1::string::String {
        arg0.image_url
    }

    public fun get_mmr(arg0: &Character) : u64 {
        arg0.mmr
    }

    public fun get_name(arg0: &Character) : 0x1::string::String {
        arg0.name
    }

    public fun get_royalty_percentage(arg0: &CollectionMetadata) : u64 {
        arg0.royalty_percentage
    }

    public fun get_total_minted(arg0: &MintCounter) : u64 {
        arg0.total_minted
    }

    fun init(arg0: CHARACTER_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CHARACTER_NFT>(arg0, arg1);
        let v1 = 0x2::display::new<Character>(&v0, arg1);
        0x2::display::add<Character>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Character>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{lore}"));
        0x2::display::add<Character>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Character>(&mut v1, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::add<Character>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://kapogian.xyz"));
        0x2::display::add<Character>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Kapogian Team"));
        0x2::display::add<Character>(&mut v1, 0x1::string::utf8(b"edition"), 0x1::string::utf8(b"#{edition}"));
        0x2::display::add<Character>(&mut v1, 0x1::string::utf8(b"mmr"), 0x1::string::utf8(b"{mmr}"));
        0x2::display::update_version<Character>(&mut v1);
        let (v2, v3) = 0x2::transfer_policy::new<Character>(&v0, arg1);
        let v4 = v2;
        let v5 = 500;
        let v6 = TransferPolicyCreated{
            policy_id            : 0x2::object::id<0x2::transfer_policy::TransferPolicy<Character>>(&v4),
            royalty_basis_points : v5,
            min_amount           : 1000000,
        };
        0x2::event::emit<TransferPolicyCreated>(v6);
        let v7 = 0x2::object::new(arg1);
        let v8 = CollectionMetadata{
            id                 : v7,
            name               : 0x1::string::utf8(b"Kapogian Characters"),
            description        : 0x1::string::utf8(b"Official Kapogian Character NFT Collection with physical merchandise redemption"),
            symbol             : 0x1::string::utf8(b"KAPO"),
            website            : 0x1::string::utf8(b"https://kapogian.xyz"),
            twitter            : 0x1::string::utf8(b"https://twitter.com/kapogian"),
            discord            : 0x1::string::utf8(b"https://discord.gg/kapogian"),
            total_supply       : 0,
            royalty_percentage : (v5 as u64),
        };
        let v9 = CollectionMetadataCreated{
            metadata_id        : 0x2::object::uid_to_inner(&v7),
            name               : 0x1::string::utf8(b"Kapogian Characters"),
            symbol             : 0x1::string::utf8(b"KAPO"),
            royalty_percentage : (v5 as u64),
        };
        0x2::event::emit<CollectionMetadataCreated>(v9);
        0x2::transfer::share_object<CollectionMetadata>(v8);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Character>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Character>>(v4);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Character>>(v3, 0x2::tx_context::sender(arg1));
        let v10 = MintCounter{
            id           : 0x2::object::new(arg1),
            total_minted : 0,
        };
        0x2::transfer::share_object<MintCounter>(v10);
        let v11 = MintCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<MintCap>(v11, 0x2::tx_context::sender(arg1));
    }

    public fun mint_character(arg0: &mut MintCounter, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: &0x2::transfer_policy::TransferPolicy<Character>, arg11: &0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::admin::AdminRegistry, arg12: &0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::treasury::TreasuryConfig, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::admin::assert_mint_active(arg11);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= 0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::treasury::base_mint_price(arg12), 1);
        let (v1, v2) = 0x2::kiosk::new(arg14);
        let v3 = v2;
        let v4 = v1;
        let v5 = 0x2::object::id<0x2::kiosk::Kiosk>(&v4);
        let v6 = 0x2::tx_context::sender(arg14);
        let v7 = KioskCreated{
            kiosk_id  : v5,
            owner     : v6,
            timestamp : 0x2::clock::timestamp_ms(arg13),
        };
        0x2::event::emit<KioskCreated>(v7);
        0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::treasury::process_payment(arg12, arg1, 0, arg14);
        arg0.total_minted = arg0.total_minted + 1;
        let v8 = arg0.total_minted;
        let v9 = 0x2::clock::timestamp_ms(arg13);
        let v10 = 0x2::object::new(arg14);
        let v11 = 0x2::object::uid_to_inner(&v10);
        let v12 = Character{
            id         : v10,
            name       : arg2,
            lore       : arg3,
            image_url  : arg4,
            attributes : arg5,
            mmr        : arg6,
            edition    : v8,
            minted_at  : v9,
        };
        0x2::kiosk::lock<Character>(&mut v4, &v3, arg10, v12);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v4);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v3, v6);
        let v13 = CharacterMinted{
            nft_id    : v11,
            owner     : v6,
            name      : 0x1::string::utf8(b"Character"),
            edition   : v8,
            kiosk_id  : v5,
            timestamp : v9,
        };
        0x2::event::emit<CharacterMinted>(v13);
        0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::order_receipt::create_receipt(v11, v6, arg7, arg8, arg9, v0, arg13, arg14);
    }

    public fun mint_to_existing_kiosk(arg0: &mut MintCounter, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: &mut 0x2::kiosk::Kiosk, arg11: &0x2::kiosk::KioskOwnerCap, arg12: &0x2::transfer_policy::TransferPolicy<Character>, arg13: &0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::admin::AdminRegistry, arg14: &0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::treasury::TreasuryConfig, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::admin::assert_mint_active(arg13);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= 0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::treasury::base_mint_price(arg14), 1);
        assert!(0x2::kiosk::has_access(arg10, arg11), 2);
        0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::treasury::process_payment(arg14, arg1, 0, arg16);
        arg0.total_minted = arg0.total_minted + 1;
        let v1 = arg0.total_minted;
        let v2 = 0x2::clock::timestamp_ms(arg15);
        let v3 = 0x2::object::new(arg16);
        let v4 = 0x2::object::uid_to_inner(&v3);
        let v5 = Character{
            id         : v3,
            name       : arg2,
            lore       : arg3,
            image_url  : arg4,
            attributes : arg5,
            mmr        : arg6,
            edition    : v1,
            minted_at  : v2,
        };
        let v6 = 0x2::tx_context::sender(arg16);
        0x2::kiosk::lock<Character>(arg10, arg11, arg12, v5);
        let v7 = CharacterMinted{
            nft_id    : v4,
            owner     : v6,
            name      : 0x1::string::utf8(b"Character"),
            edition   : v1,
            kiosk_id  : 0x2::object::id<0x2::kiosk::Kiosk>(arg10),
            timestamp : v2,
        };
        0x2::event::emit<CharacterMinted>(v7);
        0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::order_receipt::create_receipt(v4, v6, arg7, arg8, arg9, v0, arg15, arg16);
    }

    public(friend) fun update_mmr(arg0: &mut Character, arg1: u64) {
        arg0.mmr = arg1;
    }

    public fun upgrade_to_bundle(arg0: &mut 0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::order_receipt::OrderReceipt, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x1::string::String, arg3: &0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::admin::AdminRegistry, arg4: &0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::treasury::TreasuryConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::admin::assert_mint_active(arg3);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= 0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::treasury::bundle_upgrade_price(arg4), 5);
        assert!(0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::order_receipt::get_buyer(arg0) == 0x2::tx_context::sender(arg6), 4);
        0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::treasury::process_payment(arg4, arg1, 1, arg6);
        0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::order_receipt::update_encrypted_shipping(arg0, arg2, arg5, arg6);
        let v1 = BundleUpgraded{
            receipt_id         : 0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::order_receipt::get_receipt_id(arg0),
            owner              : 0x2::tx_context::sender(arg6),
            additional_payment : v0,
            timestamp          : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<BundleUpgraded>(v1);
    }

    // decompiled from Move bytecode v7
}

