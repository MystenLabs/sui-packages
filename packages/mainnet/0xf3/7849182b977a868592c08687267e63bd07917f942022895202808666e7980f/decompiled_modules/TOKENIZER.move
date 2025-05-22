module 0xf37849182b977a868592c08687267e63bd07917f942022895202808666e7980f::TOKENIZER {
    struct TOKENIZER has drop {
        dummy_field: bool,
    }

    struct TokenizedCollection has store, key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
        tokens_per_nft: u64,
        total_nfts: u64,
        total_tokens: u64,
        creator: address,
        is_active: bool,
        creation_time: u64,
    }

    struct TokenRegistry has key {
        id: 0x2::object::UID,
        collections: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
        collection_count: u64,
        total_backed_tokens: u64,
    }

    struct TokenizedCollectionCreated has copy, drop {
        collection_id: 0x2::object::ID,
        tokenized_collection_id: 0x2::object::ID,
        tokens_per_nft: u64,
        initial_nft_mint: u64,
        total_tokens: u64,
        creator: address,
        timestamp: u64,
    }

    struct TokenizedCollectionExtended has copy, drop {
        collection_id: 0x2::object::ID,
        tokenized_collection_id: 0x2::object::ID,
        additional_nfts: u64,
        additional_tokens: u64,
        new_total_nfts: u64,
        new_total_tokens: u64,
        timestamp: u64,
    }

    struct TokenizedCollectionFrozen has copy, drop {
        collection_id: 0x2::object::ID,
        tokenized_collection_id: 0x2::object::ID,
        total_nfts: u64,
        total_tokens: u64,
        timestamp: u64,
    }

    struct TokenRatioUpdated has copy, drop {
        collection_id: 0x2::object::ID,
        tokenized_collection_id: 0x2::object::ID,
        old_ratio: u64,
        new_ratio: u64,
        updater: address,
        timestamp: u64,
    }

    public fun calculate_nfts_redeemable(arg0: &TokenizedCollection, arg1: u64) : u64 {
        arg1 / arg0.tokens_per_nft
    }

    public fun calculate_redemption_cost(arg0: &TokenizedCollection, arg1: u64) : u64 {
        safe_mul(arg1, arg0.tokens_per_nft)
    }

    public entry fun freeze_minting(arg0: &mut TokenizedCollection, arg1: &mut 0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::CollectionCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == 0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::get_collection_creator(arg1), 10);
        assert!(arg0.collection_id == 0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::get_collection_cap_id(arg1), 1);
        assert!(arg0.is_active, 2);
        0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::freeze_minting(arg1, arg3);
        arg0.is_active = false;
        let v0 = TokenizedCollectionFrozen{
            collection_id           : arg0.collection_id,
            tokenized_collection_id : 0x2::object::uid_to_inner(&arg0.id),
            total_nfts              : arg0.total_nfts,
            total_tokens            : arg0.total_tokens,
            timestamp               : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<TokenizedCollectionFrozen>(v0);
    }

    public fun get_collection_info(arg0: &TokenizedCollection) : (0x2::object::ID, u64, u64, u64, address, bool, u64) {
        (arg0.collection_id, arg0.tokens_per_nft, arg0.total_nfts, arg0.total_tokens, arg0.creator, arg0.is_active, arg0.creation_time)
    }

    public fun get_registry_stats(arg0: &TokenRegistry) : (u64, u64) {
        (arg0.collection_count, arg0.total_backed_tokens)
    }

    public fun get_tokenized_collection_id(arg0: &TokenRegistry, arg1: 0x2::object::ID) : 0x2::object::ID {
        assert!(0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.collections, arg1), 6);
        *0x2::table::borrow<0x2::object::ID, 0x2::object::ID>(&arg0.collections, arg1)
    }

    public fun get_tokens_per_nft(arg0: &TokenizedCollection) : u64 {
        arg0.tokens_per_nft
    }

    fun init(arg0: TOKENIZER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKENIZER>(arg0, 9, b"CICC-USD", b"Council of International Chambers of Commerce", b"Tokenized representation of real world assets backed by ART20 NFTs and Pagged to USD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://salmon-accused-puma-149.mypinata.cloud/ipfs/bafkreifufqxd6etuy47bosqlwwu5coffoup2a5rrpi3jqrcvdygodgnueu?pinataGatewayToken=Nc4R8TH9sXtjJQUiqvn_ZXvRnNYOlp6eH8lT7JTr0zEUEZV2BjEMU-81HiF2dy5x")), arg1);
        let v2 = v0;
        let v3 = TokenRegistry{
            id                  : 0x2::object::new(arg1),
            collections         : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg1),
            collection_count    : 0,
            total_backed_tokens : 0,
        };
        0x2::transfer::share_object<TokenRegistry>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<TOKENIZER>>(0x2::coin::mint<TOKENIZER>(&mut v2, 100000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKENIZER>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKENIZER>>(v1);
    }

    public fun is_collection_active(arg0: &TokenizedCollection) : bool {
        arg0.is_active
    }

    public fun is_collection_registered(arg0: &TokenRegistry, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.collections, arg1)
    }

    public entry fun mint_additional(arg0: &mut TokenRegistry, arg1: &mut TokenizedCollection, arg2: &mut 0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::CollectionCap, arg3: &mut 0x2::coin::TreasuryCap<TOKENIZER>, arg4: u64, arg5: &mut 0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::TokenIdCounter, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == 0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::get_collection_creator(arg2), 10);
        assert!(arg1.collection_id == 0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::get_collection_cap_id(arg2), 1);
        assert!(arg1.is_active, 2);
        assert!(arg4 > 0, 3);
        let v0 = safe_mul(arg4, arg1.tokens_per_nft);
        assert!(arg0.total_backed_tokens + v0 <= 1000000000000000000, 11);
        0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::mint_additional_art20(arg2, arg4, arg5, 0x1::vector::empty<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::UserBalance>(), arg6, arg7);
        arg1.total_nfts = arg1.total_nfts + arg4;
        arg1.total_tokens = arg1.total_tokens + v0;
        arg0.total_backed_tokens = arg0.total_backed_tokens + v0;
        let v1 = TokenizedCollectionExtended{
            collection_id           : arg1.collection_id,
            tokenized_collection_id : 0x2::object::uid_to_inner(&arg1.id),
            additional_nfts         : arg4,
            additional_tokens       : v0,
            new_total_nfts          : arg1.total_nfts,
            new_total_tokens        : arg1.total_tokens,
            timestamp               : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<TokenizedCollectionExtended>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TOKENIZER>>(0x2::coin::mint<TOKENIZER>(arg3, v0, arg7), 0x2::tx_context::sender(arg7));
    }

    fun safe_mul(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        assert!(arg0 <= 18446744073709551615 / arg1, 8);
        arg0 * arg1
    }

    public entry fun tokenize_existing_collection(arg0: &0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::CollectionCap, arg1: u64, arg2: &mut TokenRegistry, arg3: &mut 0x2::coin::TreasuryCap<TOKENIZER>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == 0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::get_collection_creator(arg0), 10);
        let v0 = 0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::get_collection_cap_id(arg0);
        let v1 = 0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::get_collection_current_supply(arg0);
        assert!(v1 > 0, 3);
        assert!(arg1 > 0, 4);
        assert!(!0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg2.collections, v0), 5);
        let v2 = safe_mul(v1, arg1);
        assert!(arg2.total_backed_tokens + v2 <= 1000000000000000000, 11);
        let v3 = TokenizedCollection{
            id             : 0x2::object::new(arg5),
            collection_id  : v0,
            tokens_per_nft : arg1,
            total_nfts     : v1,
            total_tokens   : v2,
            creator        : 0x2::tx_context::sender(arg5),
            is_active      : true,
            creation_time  : 0x2::clock::timestamp_ms(arg4),
        };
        let v4 = 0x2::object::uid_to_inner(&v3.id);
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg2.collections, v0, v4);
        arg2.collection_count = arg2.collection_count + 1;
        arg2.total_backed_tokens = arg2.total_backed_tokens + v2;
        let v5 = TokenizedCollectionCreated{
            collection_id           : v0,
            tokenized_collection_id : v4,
            tokens_per_nft          : arg1,
            initial_nft_mint        : v1,
            total_tokens            : v2,
            creator                 : 0x2::tx_context::sender(arg5),
            timestamp               : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<TokenizedCollectionCreated>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<TOKENIZER>>(0x2::coin::mint<TOKENIZER>(arg3, v2, arg5), 0x2::tx_context::sender(arg5));
        0x2::transfer::share_object<TokenizedCollection>(v3);
    }

    public entry fun transfer_treasury_cap(arg0: 0x2::coin::TreasuryCap<TOKENIZER>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKENIZER>>(arg0, arg1);
    }

    public entry fun update_token_ratio(arg0: &mut TokenizedCollection, arg1: &0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::CollectionCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == 0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::get_collection_creator(arg1), 10);
        assert!(v0 == arg0.creator, 10);
        assert!(arg0.is_active, 2);
        assert!(arg2 > 0, 4);
        arg0.tokens_per_nft = arg2;
        let v1 = TokenRatioUpdated{
            collection_id           : arg0.collection_id,
            tokenized_collection_id : 0x2::object::uid_to_inner(&arg0.id),
            old_ratio               : arg0.tokens_per_nft,
            new_ratio               : arg2,
            updater                 : 0x2::tx_context::sender(arg4),
            timestamp               : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TokenRatioUpdated>(v1);
    }

    // decompiled from Move bytecode v6
}

