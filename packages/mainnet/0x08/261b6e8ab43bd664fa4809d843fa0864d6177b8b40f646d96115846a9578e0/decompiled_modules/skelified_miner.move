module 0x5a0ef86ef845c060bf6af44ed382ba17ed4a8d5ed9d9b25a6b2773e2111db14a::skelified_miner {
    struct SKELIFIED_MINER has drop {
        dummy_field: bool,
    }

    struct Attribute has drop, store {
        key: 0x1::string::String,
        value: 0x1::string::String,
    }

    struct TradeportAttributes has drop, store {
        contents: vector<Attribute>,
    }

    struct SkelifiedNft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        metadata_url: 0x1::string::String,
        external_url: 0x1::string::String,
        source_filename: 0x1::string::String,
        minted_by: address,
        minted_at_ms: u64,
        collection_id: 0x2::object::ID,
        sequence: u64,
        attributes: vector<Attribute>,
    }

    struct SkelifiedTradeportNft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        metadata_url: 0x1::string::String,
        external_url: 0x1::string::String,
        source_filename: 0x1::string::String,
        minted_by: address,
        minted_at_ms: u64,
        collection_id: 0x2::object::ID,
        sequence: u64,
        attributes: TradeportAttributes,
    }

    struct Collection has store, key {
        id: 0x2::object::UID,
        mint_fee_mist: u64,
        mint_fee_bones: u64,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        next_sequence: u64,
        minted_from_source: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
    }

    struct CollectionOwnerCap has store, key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
    }

    fun assert_owner_cap(arg0: &CollectionOwnerCap, arg1: &Collection) {
        assert!(arg0.collection_id == 0x2::object::id<Collection>(arg1), 2);
    }

    fun assert_valid_attributes(arg0: &vector<Attribute>) {
        assert!(0x1::vector::length<Attribute>(arg0) <= 32, 4);
        let v0 = 0;
        while (v0 < 0x1::vector::length<Attribute>(arg0)) {
            let v1 = 0x1::vector::borrow<Attribute>(arg0, v0);
            assert!(0x1::string::length(&v1.key) <= 64, 5);
            assert!(0x1::string::length(&v1.value) <= 256, 6);
            v0 = v0 + 1;
        };
    }

    fun attributes_from_string_vectors(arg0: vector<0x1::string::String>, arg1: vector<0x1::string::String>) : vector<Attribute> {
        assert!(0x1::vector::length<0x1::string::String>(&arg0) == 0x1::vector::length<0x1::string::String>(&arg1), 7);
        let v0 = 0x1::vector::empty<Attribute>();
        while (!0x1::vector::is_empty<0x1::string::String>(&arg0)) {
            let v1 = Attribute{
                key   : 0x1::vector::pop_back<0x1::string::String>(&mut arg0),
                value : 0x1::vector::pop_back<0x1::string::String>(&mut arg1),
            };
            0x1::vector::push_back<Attribute>(&mut v0, v1);
        };
        0x1::vector::destroy_empty<0x1::string::String>(arg0);
        0x1::vector::destroy_empty<0x1::string::String>(arg1);
        0x1::vector::reverse<Attribute>(&mut v0);
        v0
    }

    public fun create_collection(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : (Collection, CollectionOwnerCap) {
        create_collection_with_fees(arg0, 1000000000, 30000000, arg1)
    }

    entry fun create_collection_and_keep(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_collection(arg0, arg1);
        0x2::transfer::public_transfer<CollectionOwnerCap>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Collection>(v0);
    }

    public fun create_collection_with_fees(arg0: &0x2::package::Publisher, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (Collection, CollectionOwnerCap) {
        assert!(0x2::package::from_package<SkelifiedNft>(arg0), 3);
        let v0 = new_collection_internal(arg1, arg2, arg3);
        let v1 = CollectionOwnerCap{
            id            : 0x2::object::new(arg3),
            collection_id : 0x2::object::id<Collection>(&v0),
        };
        (v0, v1)
    }

    entry fun create_collection_with_fees_and_keep(arg0: &0x2::package::Publisher, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_collection_with_fees(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<CollectionOwnerCap>(v1, 0x2::tx_context::sender(arg3));
        0x2::transfer::share_object<Collection>(v0);
    }

    fun init(arg0: SKELIFIED_MINER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SKELIFIED_MINER>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{external_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://skelsui.com"));
        let v5 = 0x2::display::new_with_fields<SkelifiedNft>(&v0, v1, v3, arg1);
        0x2::display::update_version<SkelifiedNft>(&mut v5);
        let v6 = Collection{
            id                 : 0x2::object::new(arg1),
            mint_fee_mist      : 1000000000,
            mint_fee_bones     : 30000000,
            treasury           : 0x2::balance::zero<0x2::sui::SUI>(),
            next_sequence      : 0,
            minted_from_source : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg1),
        };
        let v7 = CollectionOwnerCap{
            id            : 0x2::object::new(arg1),
            collection_id : 0x2::object::id<Collection>(&v6),
        };
        let (v8, v9) = 0x2::transfer_policy::new<SkelifiedNft>(&v0, arg1);
        let v10 = v9;
        let v11 = v8;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<SkelifiedNft>(&mut v11, &v10);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<SkelifiedNft>(&mut v11, &v10, 1000, 0);
        0x2::transfer::public_transfer<0x2::display::Display<SkelifiedNft>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<CollectionOwnerCap>(v7, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<SkelifiedNft>>(v10, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<SkelifiedNft>>(v11);
        0x2::transfer::share_object<Collection>(v6);
    }

    entry fun init_tradeport_type(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<SkelifiedTradeportNft>(arg0), 3);
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{external_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://skelsui.com"));
        let v4 = 0x2::display::new_with_fields<SkelifiedTradeportNft>(arg0, v0, v2, arg1);
        0x2::display::update_version<SkelifiedTradeportNft>(&mut v4);
        let (v5, v6) = 0x2::transfer_policy::new<SkelifiedTradeportNft>(arg0, arg1);
        let v7 = v6;
        let v8 = v5;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<SkelifiedTradeportNft>(&mut v8, &v7);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<SkelifiedTradeportNft>(&mut v8, &v7, 1000, 0);
        0x2::transfer::public_transfer<0x2::display::Display<SkelifiedTradeportNft>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<SkelifiedTradeportNft>>(v7, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<SkelifiedTradeportNft>>(v8);
    }

    public fun mine(arg0: &mut Collection, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: vector<Attribute>, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = mint_internal_with_sui(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        0x2::transfer::public_transfer<SkelifiedNft>(v0, 0x2::tx_context::sender(arg10));
    }

    public fun mine_tradeport(arg0: &mut Collection, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: vector<Attribute>, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = mint_tradeport_internal_with_sui(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        0x2::transfer::public_transfer<SkelifiedTradeportNft>(v0, 0x2::tx_context::sender(arg10));
    }

    public fun mine_tradeport_with_attribute_strings(arg0: &mut Collection, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: vector<0x1::string::String>, arg8: vector<0x1::string::String>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = mint_tradeport_internal_with_sui(arg0, arg1, arg2, arg3, arg4, arg5, arg6, attributes_from_string_vectors(arg7, arg8), arg9, arg10, arg11);
        0x2::transfer::public_transfer<SkelifiedTradeportNft>(v0, 0x2::tx_context::sender(arg11));
    }

    public fun mine_tradeport_with_bones(arg0: &mut Collection, arg1: &mut 0x1c35d45f8ba03a6f8de2fb2cab17e897811ac1259956b09405d1ccf50fc7349d::bones::BonesTreasury, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: vector<Attribute>, arg9: 0x2::token::Token<0x1c35d45f8ba03a6f8de2fb2cab17e897811ac1259956b09405d1ccf50fc7349d::bones::BONES>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = mint_tradeport_internal_with_bones(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        0x2::transfer::public_transfer<SkelifiedTradeportNft>(v0, 0x2::tx_context::sender(arg11));
    }

    public fun mine_tradeport_with_bones_attribute_strings(arg0: &mut Collection, arg1: &mut 0x1c35d45f8ba03a6f8de2fb2cab17e897811ac1259956b09405d1ccf50fc7349d::bones::BonesTreasury, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: vector<0x1::string::String>, arg9: vector<0x1::string::String>, arg10: 0x2::token::Token<0x1c35d45f8ba03a6f8de2fb2cab17e897811ac1259956b09405d1ccf50fc7349d::bones::BONES>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = mint_tradeport_internal_with_bones(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, attributes_from_string_vectors(arg8, arg9), arg10, arg11, arg12);
        0x2::transfer::public_transfer<SkelifiedTradeportNft>(v0, 0x2::tx_context::sender(arg12));
    }

    public fun mine_with_attribute_strings(arg0: &mut Collection, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: vector<0x1::string::String>, arg8: vector<0x1::string::String>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = mint_internal_with_sui(arg0, arg1, arg2, arg3, arg4, arg5, arg6, attributes_from_string_vectors(arg7, arg8), arg9, arg10, arg11);
        0x2::transfer::public_transfer<SkelifiedNft>(v0, 0x2::tx_context::sender(arg11));
    }

    public fun mine_with_bones(arg0: &mut Collection, arg1: &mut 0x1c35d45f8ba03a6f8de2fb2cab17e897811ac1259956b09405d1ccf50fc7349d::bones::BonesTreasury, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: vector<Attribute>, arg9: 0x2::token::Token<0x1c35d45f8ba03a6f8de2fb2cab17e897811ac1259956b09405d1ccf50fc7349d::bones::BONES>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = mint_internal_with_bones(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        0x2::transfer::public_transfer<SkelifiedNft>(v0, 0x2::tx_context::sender(arg11));
    }

    public fun mine_with_bones_attribute_strings(arg0: &mut Collection, arg1: &mut 0x1c35d45f8ba03a6f8de2fb2cab17e897811ac1259956b09405d1ccf50fc7349d::bones::BonesTreasury, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: vector<0x1::string::String>, arg9: vector<0x1::string::String>, arg10: 0x2::token::Token<0x1c35d45f8ba03a6f8de2fb2cab17e897811ac1259956b09405d1ccf50fc7349d::bones::BONES>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = mint_internal_with_bones(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, attributes_from_string_vectors(arg8, arg9), arg10, arg11, arg12);
        0x2::transfer::public_transfer<SkelifiedNft>(v0, 0x2::tx_context::sender(arg12));
    }

    public fun mint_fee_bones(arg0: &Collection) : u64 {
        arg0.mint_fee_bones
    }

    public fun mint_fee_mist(arg0: &Collection) : u64 {
        arg0.mint_fee_mist
    }

    fun mint_internal_with_bones(arg0: &mut Collection, arg1: &mut 0x1c35d45f8ba03a6f8de2fb2cab17e897811ac1259956b09405d1ccf50fc7349d::bones::BonesTreasury, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: vector<Attribute>, arg9: 0x2::token::Token<0x1c35d45f8ba03a6f8de2fb2cab17e897811ac1259956b09405d1ccf50fc7349d::bones::BONES>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : SkelifiedNft {
        assert_valid_attributes(&arg8);
        assert!(!0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.minted_from_source, arg7), 0);
        0x1c35d45f8ba03a6f8de2fb2cab17e897811ac1259956b09405d1ccf50fc7349d::bones::spend_exact(arg1, arg9, arg0.mint_fee_bones, arg11);
        mint_nft(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg10, arg11)
    }

    fun mint_internal_with_sui(arg0: &mut Collection, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: vector<Attribute>, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : SkelifiedNft {
        assert_valid_attributes(&arg7);
        assert!(!0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.minted_from_source, arg6), 0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg8) == arg0.mint_fee_mist, 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, 0x2::coin::into_balance<0x2::sui::SUI>(arg8));
        mint_nft(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9, arg10)
    }

    fun mint_nft(arg0: &mut Collection, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: vector<Attribute>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : SkelifiedNft {
        let v0 = SkelifiedNft{
            id              : 0x2::object::new(arg9),
            name            : arg1,
            description     : arg2,
            image_url       : arg3,
            metadata_url    : arg4,
            external_url    : arg5,
            source_filename : arg6,
            minted_by       : 0x2::tx_context::sender(arg9),
            minted_at_ms    : 0x2::clock::timestamp_ms(arg8),
            collection_id   : 0x2::object::id<Collection>(arg0),
            sequence        : arg0.next_sequence,
            attributes      : arg7,
        };
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg0.minted_from_source, v0.source_filename, 0x2::object::id<SkelifiedNft>(&v0));
        arg0.next_sequence = arg0.next_sequence + 1;
        v0
    }

    fun mint_tradeport_internal_with_bones(arg0: &mut Collection, arg1: &mut 0x1c35d45f8ba03a6f8de2fb2cab17e897811ac1259956b09405d1ccf50fc7349d::bones::BonesTreasury, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: vector<Attribute>, arg9: 0x2::token::Token<0x1c35d45f8ba03a6f8de2fb2cab17e897811ac1259956b09405d1ccf50fc7349d::bones::BONES>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : SkelifiedTradeportNft {
        assert_valid_attributes(&arg8);
        assert!(!0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.minted_from_source, arg7), 0);
        0x1c35d45f8ba03a6f8de2fb2cab17e897811ac1259956b09405d1ccf50fc7349d::bones::spend_exact(arg1, arg9, arg0.mint_fee_bones, arg11);
        mint_tradeport_nft(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg10, arg11)
    }

    fun mint_tradeport_internal_with_sui(arg0: &mut Collection, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: vector<Attribute>, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : SkelifiedTradeportNft {
        assert_valid_attributes(&arg7);
        assert!(!0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.minted_from_source, arg6), 0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg8) == arg0.mint_fee_mist, 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, 0x2::coin::into_balance<0x2::sui::SUI>(arg8));
        mint_tradeport_nft(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9, arg10)
    }

    fun mint_tradeport_nft(arg0: &mut Collection, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: vector<Attribute>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : SkelifiedTradeportNft {
        let v0 = TradeportAttributes{contents: arg7};
        let v1 = SkelifiedTradeportNft{
            id              : 0x2::object::new(arg9),
            name            : arg1,
            description     : arg2,
            image_url       : arg3,
            metadata_url    : arg4,
            external_url    : arg5,
            source_filename : arg6,
            minted_by       : 0x2::tx_context::sender(arg9),
            minted_at_ms    : 0x2::clock::timestamp_ms(arg8),
            collection_id   : 0x2::object::id<Collection>(arg0),
            sequence        : arg0.next_sequence,
            attributes      : v0,
        };
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg0.minted_from_source, v1.source_filename, 0x2::object::id<SkelifiedTradeportNft>(&v1));
        arg0.next_sequence = arg0.next_sequence + 1;
        v1
    }

    fun new_collection_internal(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Collection {
        Collection{
            id                 : 0x2::object::new(arg2),
            mint_fee_mist      : arg0,
            mint_fee_bones     : arg1,
            treasury           : 0x2::balance::zero<0x2::sui::SUI>(),
            next_sequence      : 0,
            minted_from_source : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg2),
        }
    }

    public fun royalty_fee_amount(arg0: &0x2::transfer_policy::TransferPolicy<SkelifiedNft>, arg1: u64) : u64 {
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<SkelifiedNft>(arg0, arg1)
    }

    public fun set_mint_fee(arg0: &CollectionOwnerCap, arg1: &mut Collection, arg2: u64) {
        assert_owner_cap(arg0, arg1);
        arg1.mint_fee_mist = arg2;
    }

    public fun set_mint_fee_bones(arg0: &CollectionOwnerCap, arg1: &mut Collection, arg2: u64) {
        assert_owner_cap(arg0, arg1);
        arg1.mint_fee_bones = arg2;
    }

    public fun treasury_balance_mist(arg0: &Collection) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.treasury)
    }

    public fun withdraw_royalties(arg0: &mut 0x2::transfer_policy::TransferPolicy<SkelifiedNft>, arg1: &0x2::transfer_policy::TransferPolicyCap<SkelifiedNft>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_royalties_coin(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun withdraw_royalties_coin(arg0: &mut 0x2::transfer_policy::TransferPolicy<SkelifiedNft>, arg1: &0x2::transfer_policy::TransferPolicyCap<SkelifiedNft>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = if (arg2 == 0) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>(arg2)
        };
        0x2::transfer_policy::withdraw<SkelifiedNft>(arg0, arg1, v0, arg3)
    }

    public fun withdraw_treasury(arg0: &CollectionOwnerCap, arg1: &mut Collection, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_treasury_coin(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun withdraw_treasury_coin(arg0: &CollectionOwnerCap, arg1: &mut Collection, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_owner_cap(arg0, arg1);
        let v0 = if (arg2 == 0) {
            0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.treasury)
        } else {
            0x2::balance::split<0x2::sui::SUI>(&mut arg1.treasury, arg2)
        };
        0x2::coin::from_balance<0x2::sui::SUI>(v0, arg3)
    }

    // decompiled from Move bytecode v7
}

