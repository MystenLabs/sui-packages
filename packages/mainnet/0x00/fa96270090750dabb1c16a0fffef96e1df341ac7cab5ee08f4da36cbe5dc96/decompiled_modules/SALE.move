module 0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::SALE {
    struct SALE has drop {
        dummy_field: bool,
    }

    struct TransferEvent has copy, drop {
        from: address,
        to: address,
        id: 0x2::object::ID,
        amount: u64,
        royalty: u64,
        asset_id: u64,
    }

    struct BatchTransferEvent has copy, drop {
        from: address,
        recipients: vector<address>,
        token_ids: vector<0x2::object::ID>,
        amounts: vector<u64>,
        collection_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct SaleStatusChanged<phantom T0> has copy, drop {
        sale_id: 0x2::object::ID,
        is_active: bool,
        changed_by: address,
        timestamp: u64,
    }

    struct PriceUpdated<phantom T0> has copy, drop {
        sale_id: 0x2::object::ID,
        new_price: u64,
    }

    struct DebugEvent has copy, drop {
        message: 0x1::string::String,
        token_id: 0x2::object::ID,
        sender: address,
        recipient: address,
    }

    struct NFTSale<phantom T0> has store, key {
        id: 0x2::object::UID,
        price_per_nft: u64,
        currency_balance: 0x2::balance::Balance<T0>,
        creator: address,
        collection_id: 0x2::object::ID,
        is_active: bool,
        nft_count: u64,
        asset_ids: vector<u64>,
        creator_name: 0x1::string::String,
        sale_title: 0x1::string::String,
        width_cm: 0x1::option::Option<u64>,
        height_cm: 0x1::option::Option<u64>,
        creation_year: 0x1::option::Option<u64>,
        medium: 0x1::option::Option<0x1::string::String>,
        provenance: 0x1::option::Option<0x1::string::String>,
        authenticity: 0x1::option::Option<0x1::string::String>,
        signature: 0x1::option::Option<0x1::string::String>,
        about_sale: 0x1::string::String,
    }

    struct NFTListingEvent<phantom T0> has copy, drop {
        sale_id: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        asset_id: u64,
        price: u64,
    }

    struct NFTListing<phantom T0> has store, key {
        id: 0x2::object::UID,
        nft: 0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::NFT,
        sale_id: 0x2::object::ID,
        asset_id: u64,
        price: u64,
    }

    struct NFTFieldKey<phantom T0> has copy, drop, store {
        asset_id: u64,
    }

    struct SaleCreated<phantom T0> has copy, drop {
        sale_id: 0x2::object::ID,
        creator: address,
        nft_count: u64,
        price_per_nft: u64,
        collection_id: 0x2::object::ID,
    }

    struct PriceUpdateEvent<phantom T0> has copy, drop {
        sale_id: 0x2::object::ID,
        old_price: u64,
        new_price: u64,
        changed_by: address,
        timestamp: u64,
        collection_id: 0x2::object::ID,
    }

    struct NFTPurchased<phantom T0> has copy, drop {
        sale_id: 0x2::object::ID,
        buyer: address,
        nft_ids: vector<0x2::object::ID>,
        amount_paid: u64,
    }

    struct CurrencyWithdrawn<phantom T0> has copy, drop {
        sale_id: 0x2::object::ID,
        amount: u64,
        recipient: address,
    }

    struct CurrencyWithdrawSplit<phantom T0> has copy, drop {
        sale_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
        percentage: u64,
    }

    public fun add_nft_to_sale<T0>(arg0: &mut NFTSale<T0>, arg1: 0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::NFT, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = DebugEvent{
            message   : 0x1::string::utf8(b"Adding NFT to sale"),
            token_id  : v0,
            sender    : v1,
            recipient : v1,
        };
        0x2::event::emit<DebugEvent>(v2);
        let v3 = NFTFieldKey<T0>{asset_id: arg2};
        0x2::dynamic_field::add<NFTFieldKey<T0>, 0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::NFT>(&mut arg0.id, v3, arg1);
        let v4 = NFTListingEvent<T0>{
            sale_id    : v0,
            listing_id : v0,
            asset_id   : arg2,
            price      : arg0.price_per_nft,
        };
        0x2::event::emit<NFTListingEvent<T0>>(v4);
    }

    public entry fun add_nfts_to_sale<T0>(arg0: &mut NFTSale<T0>, arg1: vector<0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::NFT>, arg2: vector<u64>, arg3: &mut 0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::CollectionCap, arg4: vector<0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::UserBalance>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::object::uid_to_inner(&arg0.id);
        assert!(v0 == arg0.creator, 2);
        assert!(arg0.is_active, 10);
        let v2 = 0x1::vector::length<u64>(&arg2);
        assert!(0x1::vector::length<0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::NFT>(&arg1) >= v2, 6);
        assert!(v2 <= 200, 20);
        assert!(safe_add(arg0.nft_count, v2) <= 1000000000, 19);
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::UserBalance>(&arg4)) {
            v3 = safe_add(v3, 0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::get_user_balance_amount(0x1::vector::borrow<0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::UserBalance>(&arg4, v4)));
            v4 = v4 + 1;
        };
        assert!(v3 >= v2, 9);
        assert!(0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::get_nft_collection_id(0x1::vector::borrow<0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::NFT>(&arg1, 0)) == arg0.collection_id, 8);
        assert!(0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::get_collection_cap_id(arg3) == arg0.collection_id, 8);
        let v5 = 0x1::vector::empty<0x2::object::ID>();
        let v6 = 0x1::vector::empty<u64>();
        let v7 = 0;
        while (v7 < 0x1::vector::length<0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::UserBalance>(&arg4) && v2 > 0) {
            let v8 = 0x1::vector::borrow_mut<0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::UserBalance>(&mut arg4, v7);
            let v9 = 0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::get_user_balance_amount(v8);
            if (v9 > 0) {
                if (v9 <= v2) {
                    v2 = v2 - v9;
                    0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::set_user_balance_amount(v8, 0);
                } else {
                    0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::set_user_balance_amount(v8, v9 - v2);
                    v2 = 0;
                };
            };
            v7 = v7 + 1;
        };
        let v10 = 0;
        while (v10 < v2) {
            let v11 = 0x1::vector::pop_back<0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::NFT>(&mut arg1);
            assert!(0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::get_nft_collection_id(&v11) == arg0.collection_id, 8);
            0x1::vector::push_back<0x2::object::ID>(&mut v5, 0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::get_nft_id(&v11));
            0x1::vector::push_back<u64>(&mut v6, 1);
            let v12 = 0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::get_nft_asset_id(&v11);
            let v13 = NFTFieldKey<T0>{asset_id: v12};
            0x2::dynamic_field::add<NFTFieldKey<T0>, 0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::NFT>(&mut arg0.id, v13, v11);
            0x1::vector::push_back<u64>(&mut arg0.asset_ids, v12);
            let v14 = NFTListingEvent<T0>{
                sale_id    : v1,
                listing_id : v1,
                asset_id   : v12,
                price      : arg0.price_per_nft,
            };
            0x2::event::emit<NFTListingEvent<T0>>(v14);
            v10 = v10 + 1;
        };
        while (!0x1::vector::is_empty<0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::NFT>(&arg1)) {
            0x2::transfer::public_transfer<0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::NFT>(0x1::vector::pop_back<0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::NFT>(&mut arg1), v0);
        };
        while (!0x1::vector::is_empty<0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::UserBalance>(&arg4)) {
            0x2::transfer::public_transfer<0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::UserBalance>(0x1::vector::pop_back<0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::UserBalance>(&mut arg4), v0);
        };
        0x1::vector::destroy_empty<0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::NFT>(arg1);
        0x1::vector::destroy_empty<0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::UserBalance>(arg4);
        arg0.nft_count = safe_add(arg0.nft_count, v2);
        let v15 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v15, v0);
        let v16 = BatchTransferEvent{
            from          : v0,
            recipients    : v15,
            token_ids     : v5,
            amounts       : v6,
            collection_id : arg0.collection_id,
            timestamp     : 0x2::tx_context::epoch(arg5),
        };
        0x2::event::emit<BatchTransferEvent>(v16);
        let v17 = SaleCreated<T0>{
            sale_id       : v1,
            creator       : v0,
            nft_count     : v2,
            price_per_nft : arg0.price_per_nft,
            collection_id : arg0.collection_id,
        };
        0x2::event::emit<SaleCreated<T0>>(v17);
    }

    public fun borrow_nft<T0>(arg0: &NFTSale<T0>, arg1: u64) : &0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::NFT {
        let v0 = NFTFieldKey<T0>{asset_id: arg1};
        0x2::dynamic_field::borrow<NFTFieldKey<T0>, 0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::NFT>(&arg0.id, v0)
    }

    public fun borrow_nft_mut<T0>(arg0: &mut NFTSale<T0>, arg1: u64) : &mut 0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::NFT {
        let v0 = NFTFieldKey<T0>{asset_id: arg1};
        0x2::dynamic_field::borrow_mut<NFTFieldKey<T0>, 0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::NFT>(&mut arg0.id, v0)
    }

    public fun calculate_split_amount(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1 / 100
    }

    public fun can_remove_from_sale<T0>(arg0: &NFTSale<T0>, arg1: &NFTListing<T0>, arg2: address) : bool {
        if (arg0.is_active) {
            if (arg0.creator == arg2) {
                arg1.sale_id == 0x2::object::uid_to_inner(&arg0.id)
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun check_deny_list(arg0: &0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::CollectionCap, arg1: address) : bool {
        0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::is_denied(arg0, arg1)
    }

    public entry fun close_sale<T0>(arg0: &mut NFTSale<T0>, arg1: &0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::CollectionCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.creator, 2);
        assert!(!0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::is_denied(arg1, v0), 12);
        assert!(arg0.is_active, 10);
        assert!(0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::get_collection_cap_id(arg1) == arg0.collection_id, 8);
        let v1 = DebugEvent{
            message   : 0x1::string::utf8(b"Closing sale"),
            token_id  : 0x2::object::uid_to_inner(&arg0.id),
            sender    : v0,
            recipient : v0,
        };
        0x2::event::emit<DebugEvent>(v1);
        arg0.is_active = false;
        let v2 = SaleStatusChanged<T0>{
            sale_id    : 0x2::object::uid_to_inner(&arg0.id),
            is_active  : false,
            changed_by : v0,
            timestamp  : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<SaleStatusChanged<T0>>(v2);
        let v3 = DebugEvent{
            message   : 0x1::string::utf8(b"Sale closed successfully"),
            token_id  : 0x2::object::uid_to_inner(&arg0.id),
            sender    : v0,
            recipient : v0,
        };
        0x2::event::emit<DebugEvent>(v3);
    }

    public entry fun create_nft_sale<T0>(arg0: vector<0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::NFT>, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<vector<u8>>, arg9: 0x1::option::Option<vector<u8>>, arg10: 0x1::option::Option<vector<u8>>, arg11: 0x1::option::Option<vector<u8>>, arg12: vector<u8>, arg13: &mut 0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::CollectionCap, arg14: vector<0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::UserBalance>, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg15);
        assert!(arg2 <= 10000000000000000000, 21);
        assert!(arg2 > 0, 7);
        assert!(arg1 <= 200, 20);
        assert!(0x1::vector::length<0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::NFT>(&arg0) >= arg1, 30);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::UserBalance>(&arg14)) {
            v1 = safe_add(v1, 0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::get_user_balance_amount(0x1::vector::borrow<0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::UserBalance>(&arg14, v2)));
            v2 = v2 + 1;
        };
        assert!(v1 >= arg1, 9);
        let v3 = 0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::get_nft_collection_id(0x1::vector::borrow<0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::NFT>(&arg0, 0));
        assert!(0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::get_collection_cap_id(arg13) == v3, 8);
        let v4 = if (0x1::option::is_some<vector<u8>>(&arg8)) {
            0x1::option::some<0x1::string::String>(0x1::string::utf8(0x1::option::destroy_some<vector<u8>>(arg8)))
        } else {
            0x1::option::none<0x1::string::String>()
        };
        let v5 = if (0x1::option::is_some<vector<u8>>(&arg9)) {
            0x1::option::some<0x1::string::String>(0x1::string::utf8(0x1::option::destroy_some<vector<u8>>(arg9)))
        } else {
            0x1::option::none<0x1::string::String>()
        };
        let v6 = if (0x1::option::is_some<vector<u8>>(&arg10)) {
            0x1::option::some<0x1::string::String>(0x1::string::utf8(0x1::option::destroy_some<vector<u8>>(arg10)))
        } else {
            0x1::option::none<0x1::string::String>()
        };
        let v7 = if (0x1::option::is_some<vector<u8>>(&arg11)) {
            0x1::option::some<0x1::string::String>(0x1::string::utf8(0x1::option::destroy_some<vector<u8>>(arg11)))
        } else {
            0x1::option::none<0x1::string::String>()
        };
        let v8 = NFTSale<T0>{
            id               : 0x2::object::new(arg15),
            price_per_nft    : arg2,
            currency_balance : 0x2::balance::zero<T0>(),
            creator          : v0,
            collection_id    : 0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::get_collection_cap_id(arg13),
            is_active        : true,
            nft_count        : arg1,
            asset_ids        : 0x1::vector::empty<u64>(),
            creator_name     : 0x1::string::utf8(arg3),
            sale_title       : 0x1::string::utf8(arg4),
            width_cm         : arg5,
            height_cm        : arg6,
            creation_year    : arg7,
            medium           : v4,
            provenance       : v5,
            authenticity     : v6,
            signature        : v7,
            about_sale       : 0x1::string::utf8(arg12),
        };
        let v9 = 0x2::object::uid_to_inner(&v8.id);
        let v10 = 0;
        while (v10 < 0x1::vector::length<0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::UserBalance>(&arg14) && arg1 > 0) {
            let v11 = 0x1::vector::borrow_mut<0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::UserBalance>(&mut arg14, v10);
            let v12 = 0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::get_user_balance_amount(v11);
            if (v12 > 0) {
                if (v12 <= arg1) {
                    arg1 = arg1 - v12;
                    0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::set_user_balance_amount(v11, 0);
                } else {
                    0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::set_user_balance_amount(v11, v12 - arg1);
                    arg1 = 0;
                };
            };
            v10 = v10 + 1;
        };
        let v13 = 0;
        while (v13 < arg1) {
            let v14 = 0x1::vector::pop_back<0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::NFT>(&mut arg0);
            let v15 = 0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::get_nft_asset_id(&v14);
            let v16 = NFTFieldKey<T0>{asset_id: v15};
            0x2::dynamic_field::add<NFTFieldKey<T0>, 0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::NFT>(&mut v8.id, v16, v14);
            0x1::vector::push_back<u64>(&mut v8.asset_ids, v15);
            let v17 = NFTListingEvent<T0>{
                sale_id    : v9,
                listing_id : v9,
                asset_id   : v15,
                price      : arg2,
            };
            0x2::event::emit<NFTListingEvent<T0>>(v17);
            v13 = v13 + 1;
        };
        while (!0x1::vector::is_empty<0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::UserBalance>(&arg14)) {
            let v18 = 0x1::vector::pop_back<0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::UserBalance>(&mut arg14);
            if (0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::get_user_balance_amount(&v18) > 0) {
                0x2::transfer::public_transfer<0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::UserBalance>(v18, v0);
                continue
            };
            0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::cleanup_empty_balance(v18);
        };
        while (!0x1::vector::is_empty<0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::NFT>(&arg0)) {
            0x2::transfer::public_transfer<0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::NFT>(0x1::vector::pop_back<0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::NFT>(&mut arg0), v0);
        };
        0x1::vector::destroy_empty<0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::NFT>(arg0);
        0x1::vector::destroy_empty<0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::UserBalance>(arg14);
        let v19 = SaleCreated<T0>{
            sale_id       : v9,
            creator       : v0,
            nft_count     : arg1,
            price_per_nft : arg2,
            collection_id : v3,
        };
        0x2::event::emit<SaleCreated<T0>>(v19);
        0x2::transfer::public_share_object<NFTSale<T0>>(v8);
    }

    public fun get_about_sale<T0>(arg0: &NFTSale<T0>) : 0x1::string::String {
        arg0.about_sale
    }

    public fun get_authenticity<T0>(arg0: &NFTSale<T0>) : 0x1::option::Option<0x1::string::String> {
        arg0.authenticity
    }

    public fun get_available_asset_ids<T0>(arg0: &NFTSale<T0>) : &vector<u64> {
        &arg0.asset_ids
    }

    public fun get_available_nft_count<T0>(arg0: &NFTSale<T0>) : u64 {
        arg0.nft_count
    }

    public fun get_collection_id(arg0: &0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::NFT) : 0x2::object::ID {
        0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::get_nft_collection_id(arg0)
    }

    public fun get_creation_year<T0>(arg0: &NFTSale<T0>) : 0x1::option::Option<u64> {
        arg0.creation_year
    }

    public fun get_creator_name<T0>(arg0: &NFTSale<T0>) : 0x1::string::String {
        arg0.creator_name
    }

    public fun get_dimensions<T0>(arg0: &NFTSale<T0>) : (0x1::option::Option<u64>, 0x1::option::Option<u64>) {
        (arg0.width_cm, arg0.height_cm)
    }

    public fun get_full_sale_status<T0>(arg0: &NFTSale<T0>) : (address, u64, u64, 0x2::object::ID, bool, u64) {
        (arg0.creator, arg0.nft_count, arg0.price_per_nft, arg0.collection_id, arg0.is_active, 0x2::balance::value<T0>(&arg0.currency_balance))
    }

    public fun get_listing_asset_id<T0>(arg0: &NFTListing<T0>) : u64 {
        arg0.asset_id
    }

    public fun get_listing_details<T0>(arg0: &NFTListing<T0>) : (0x2::object::ID, u64, u64) {
        (arg0.sale_id, arg0.asset_id, arg0.price)
    }

    public fun get_listing_price<T0>(arg0: &NFTListing<T0>) : u64 {
        arg0.price
    }

    public fun get_medium<T0>(arg0: &NFTSale<T0>) : 0x1::option::Option<0x1::string::String> {
        arg0.medium
    }

    public fun get_nft_count<T0>(arg0: &NFTSale<T0>) : u64 {
        arg0.nft_count
    }

    public fun get_nft_from_listing<T0>(arg0: &NFTListing<T0>) : &0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::NFT {
        &arg0.nft
    }

    public fun get_nft_info(arg0: &0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::NFT) : (0x2::object::ID, 0x2::object::ID, address) {
        (0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::get_nft_id(arg0), 0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::get_nft_collection_id(arg0), 0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::get_nft_creator(arg0))
    }

    public fun get_price_per_nft<T0>(arg0: &NFTSale<T0>) : u64 {
        arg0.price_per_nft
    }

    public fun get_provenance<T0>(arg0: &NFTSale<T0>) : 0x1::option::Option<0x1::string::String> {
        arg0.provenance
    }

    public fun get_sale_balance<T0>(arg0: &NFTSale<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.currency_balance)
    }

    public fun get_sale_info<T0>(arg0: &NFTSale<T0>) : (address, u64, u64, 0x2::object::ID, bool) {
        (arg0.creator, arg0.nft_count, arg0.price_per_nft, arg0.collection_id, arg0.is_active)
    }

    public fun get_sale_listings<T0>(arg0: &NFTSale<T0>) : u64 {
        arg0.nft_count
    }

    public fun get_sale_nft_count<T0>(arg0: &NFTSale<T0>) : u64 {
        arg0.nft_count
    }

    public fun get_sale_title<T0>(arg0: &NFTSale<T0>) : 0x1::string::String {
        arg0.sale_title
    }

    public fun get_signature<T0>(arg0: &NFTSale<T0>) : 0x1::option::Option<0x1::string::String> {
        arg0.signature
    }

    public fun has_nft<T0>(arg0: &NFTSale<T0>, arg1: u64) : bool {
        let v0 = NFTFieldKey<T0>{asset_id: arg1};
        0x2::dynamic_field::exists_<NFTFieldKey<T0>>(&arg0.id, v0)
    }

    public fun has_nft_in_sale<T0>(arg0: &NFTSale<T0>, arg1: u64) : bool {
        let v0 = NFTFieldKey<T0>{asset_id: arg1};
        0x2::dynamic_field::exists_<NFTFieldKey<T0>>(&arg0.id, v0)
    }

    public fun is_sale_creator<T0>(arg0: &NFTSale<T0>, arg1: address) : bool {
        arg0.creator == arg1
    }

    public entry fun purchase_nfts<T0>(arg0: &mut NFTSale<T0>, arg1: 0x2::coin::Coin<T0>, arg2: vector<u64>, arg3: &0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::CollectionCap, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg0.is_active, 10);
        assert!(!0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::is_denied(arg3, v0), 12);
        let v1 = 0x1::vector::length<u64>(&arg2);
        assert!(v1 > 0 && v1 <= 200, 16);
        let v2 = safe_mul(arg0.price_per_nft, v1);
        assert!(0x2::coin::value<T0>(&arg1) >= v2, 9);
        let v3 = 0;
        while (v3 < v1) {
            let v4 = *0x1::vector::borrow<u64>(&arg2, v3);
            assert!(0x1::vector::contains<u64>(&arg0.asset_ids, &v4), 17);
            let v5 = NFTFieldKey<T0>{asset_id: v4};
            assert!(0x2::dynamic_field::exists_<NFTFieldKey<T0>>(&arg0.id, v5), 17);
            v3 = v3 + 1;
        };
        0x2::balance::join<T0>(&mut arg0.currency_balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, v2, arg4)));
        if (0x2::coin::value<T0>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        } else {
            0x2::coin::destroy_zero<T0>(arg1);
        };
        let v6 = 0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::create_user_balance(arg0.collection_id, v1, arg4);
        assert!(0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::get_user_balance_amount(&v6) == v1, 27);
        assert!(0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::get_user_balance_collection_id(&v6) == arg0.collection_id, 28);
        0x2::transfer::public_transfer<0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::UserBalance>(v6, v0);
        while (!0x1::vector::is_empty<u64>(&arg2)) {
            let v7 = 0x1::vector::pop_back<u64>(&mut arg2);
            let v8 = NFTFieldKey<T0>{asset_id: v7};
            assert!(0x2::dynamic_field::exists_<NFTFieldKey<T0>>(&arg0.id, v8), 17);
            let v9 = NFTFieldKey<T0>{asset_id: v7};
            let v10 = 0x2::dynamic_field::remove<NFTFieldKey<T0>, 0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::NFT>(&mut arg0.id, v9);
            0x2::transfer::public_transfer<0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::NFT>(v10, v0);
            let v11 = false;
            let v12 = 0;
            while (v12 < 0x1::vector::length<u64>(&arg0.asset_ids)) {
                if (*0x1::vector::borrow<u64>(&arg0.asset_ids, v12) == v7) {
                    0x1::vector::swap_remove<u64>(&mut arg0.asset_ids, v12);
                    v11 = true;
                    break
                };
                v12 = v12 + 1;
            };
            assert!(v11, 26);
            let v13 = TransferEvent{
                from     : arg0.creator,
                to       : v0,
                id       : 0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::get_nft_id(&v10),
                amount   : 1,
                royalty  : 0,
                asset_id : v7,
            };
            0x2::event::emit<TransferEvent>(v13);
            arg0.nft_count = safe_sub(arg0.nft_count, 1);
        };
        let v14 = NFTPurchased<T0>{
            sale_id     : 0x2::object::uid_to_inner(&arg0.id),
            buyer       : v0,
            nft_ids     : 0x1::vector::empty<0x2::object::ID>(),
            amount_paid : v2,
        };
        0x2::event::emit<NFTPurchased<T0>>(v14);
    }

    fun remove_asset_id_from_vector(arg0: &mut vector<u64>, arg1: u64) {
        let v0 = 0;
        let v1 = false;
        while (v0 < 0x1::vector::length<u64>(arg0)) {
            if (*0x1::vector::borrow<u64>(arg0, v0) == arg1) {
                0x1::vector::swap_remove<u64>(arg0, v0);
                v1 = true;
                break
            };
            v0 = v0 + 1;
        };
        assert!(v1, 26);
    }

    public entry fun remove_nfts_from_sale<T0>(arg0: &mut NFTSale<T0>, arg1: vector<u64>, arg2: &mut 0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::CollectionCap, arg3: vector<0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::UserBalance>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg0.creator, 2);
        assert!(arg0.is_active, 10);
        assert!(0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::get_collection_cap_id(arg2) == arg0.collection_id, 8);
        let v1 = 0x1::vector::length<u64>(&arg1);
        assert!(v1 > 0, 16);
        assert!(v1 <= 200, 20);
        assert!(v1 <= arg0.nft_count, 16);
        let v2 = DebugEvent{
            message   : 0x1::string::utf8(b"Starting remove_nfts_from_sale"),
            token_id  : 0x2::object::uid_to_inner(&arg0.id),
            sender    : v0,
            recipient : v0,
        };
        0x2::event::emit<DebugEvent>(v2);
        let v3 = 0;
        while (v3 < v1) {
            let v4 = *0x1::vector::borrow<u64>(&arg1, v3);
            let v5 = DebugEvent{
                message   : 0x1::string::utf8(b"Processing asset ID"),
                token_id  : 0x2::object::uid_to_inner(&arg0.id),
                sender    : v0,
                recipient : v0,
            };
            0x2::event::emit<DebugEvent>(v5);
            if (!0x1::vector::contains<u64>(&arg0.asset_ids, &v4)) {
                let v6 = DebugEvent{
                    message   : 0x1::string::utf8(b"Asset ID not found in sale.asset_ids"),
                    token_id  : 0x2::object::uid_to_inner(&arg0.id),
                    sender    : v0,
                    recipient : v0,
                };
                0x2::event::emit<DebugEvent>(v6);
            };
            assert!(0x1::vector::contains<u64>(&arg0.asset_ids, &v4), 17);
            let v7 = NFTFieldKey<T0>{asset_id: v4};
            if (!0x2::dynamic_field::exists_<NFTFieldKey<T0>>(&arg0.id, v7)) {
                let v8 = DebugEvent{
                    message   : 0x1::string::utf8(b"Asset ID not found in dynamic fields"),
                    token_id  : 0x2::object::uid_to_inner(&arg0.id),
                    sender    : v0,
                    recipient : v0,
                };
                0x2::event::emit<DebugEvent>(v8);
            };
            let v9 = NFTFieldKey<T0>{asset_id: v4};
            assert!(0x2::dynamic_field::exists_<NFTFieldKey<T0>>(&arg0.id, v9), 17);
            let v10 = NFTFieldKey<T0>{asset_id: v4};
            let v11 = &mut arg0.asset_ids;
            remove_asset_id_from_vector(v11, v4);
            0x2::transfer::public_transfer<0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::NFT>(0x2::dynamic_field::remove<NFTFieldKey<T0>, 0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::NFT>(&mut arg0.id, v10), v0);
            v3 = v3 + 1;
        };
        let v12 = v1;
        let v13 = 0;
        while (v13 < 0x1::vector::length<0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::UserBalance>(&arg3) && v12 > 0) {
            let v14 = 0x1::vector::borrow_mut<0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::UserBalance>(&mut arg3, v13);
            let v15 = 0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::get_user_balance_amount(v14);
            if (v15 < v12) {
                0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::set_user_balance_amount(v14, 0);
                v12 = safe_sub(v12, v15);
            } else {
                0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::set_user_balance_amount(v14, safe_sub(v15, v12));
                v12 = 0;
            };
            v13 = v13 + 1;
        };
        if (v12 > 0) {
            0x2::transfer::public_transfer<0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::UserBalance>(0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::create_user_balance(arg0.collection_id, v12, arg4), v0);
        };
        while (!0x1::vector::is_empty<0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::UserBalance>(&arg3)) {
            0x2::transfer::public_transfer<0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::UserBalance>(0x1::vector::pop_back<0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::UserBalance>(&mut arg3), v0);
        };
        arg0.nft_count = safe_sub(arg0.nft_count, v1);
        let v16 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v16, v0);
        let v17 = BatchTransferEvent{
            from          : v0,
            recipients    : v16,
            token_ids     : 0x1::vector::empty<0x2::object::ID>(),
            amounts       : 0x1::vector::empty<u64>(),
            collection_id : arg0.collection_id,
            timestamp     : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<BatchTransferEvent>(v17);
        let v18 = DebugEvent{
            message   : 0x1::string::utf8(b"Successfully removed NFTs from sale"),
            token_id  : 0x2::object::uid_to_inner(&arg0.id),
            sender    : v0,
            recipient : v0,
        };
        0x2::event::emit<DebugEvent>(v18);
        0x1::vector::destroy_empty<0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::UserBalance>(arg3);
    }

    public entry fun reopen_sale<T0>(arg0: &mut NFTSale<T0>, arg1: &0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::CollectionCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.creator, 2);
        assert!(!0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::is_denied(arg1, v0), 12);
        assert!(!arg0.is_active, 11);
        assert!(0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::get_collection_cap_id(arg1) == arg0.collection_id, 8);
        let v1 = DebugEvent{
            message   : 0x1::string::utf8(b"Reopening sale"),
            token_id  : 0x2::object::uid_to_inner(&arg0.id),
            sender    : v0,
            recipient : v0,
        };
        0x2::event::emit<DebugEvent>(v1);
        assert!(arg0.nft_count > 0, 6);
        arg0.is_active = true;
        let v2 = SaleStatusChanged<T0>{
            sale_id    : 0x2::object::uid_to_inner(&arg0.id),
            is_active  : true,
            changed_by : v0,
            timestamp  : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<SaleStatusChanged<T0>>(v2);
        let v3 = DebugEvent{
            message   : 0x1::string::utf8(b"Sale reopened successfully"),
            token_id  : 0x2::object::uid_to_inner(&arg0.id),
            sender    : v0,
            recipient : v0,
        };
        0x2::event::emit<DebugEvent>(v3);
    }

    fun safe_add(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 <= 18446744073709551615 - arg1, 18);
        arg0 + arg1
    }

    fun safe_mul(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        assert!(arg0 <= 18446744073709551615 / arg1, 18);
        arg0 * arg1
    }

    fun safe_sub(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 >= arg1, 9);
        arg0 - arg1
    }

    public entry fun update_sale_price<T0>(arg0: &mut NFTSale<T0>, arg1: u64, arg2: &0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::CollectionCap, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.creator, 2);
        assert!(!0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::is_denied(arg2, v0), 12);
        assert!(arg0.is_active, 10);
        assert!(0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::get_collection_cap_id(arg2) == arg0.collection_id, 8);
        assert!(arg1 > 0, 7);
        assert!(arg1 <= 10000000000000000000, 21);
        assert!(arg1 != arg0.price_per_nft, 7);
        let v1 = DebugEvent{
            message   : 0x1::string::utf8(b"Updating sale price"),
            token_id  : 0x2::object::uid_to_inner(&arg0.id),
            sender    : v0,
            recipient : v0,
        };
        0x2::event::emit<DebugEvent>(v1);
        arg0.price_per_nft = arg1;
        let v2 = PriceUpdateEvent<T0>{
            sale_id       : 0x2::object::uid_to_inner(&arg0.id),
            old_price     : arg0.price_per_nft,
            new_price     : arg1,
            changed_by    : v0,
            timestamp     : 0x2::tx_context::epoch(arg3),
            collection_id : arg0.collection_id,
        };
        0x2::event::emit<PriceUpdateEvent<T0>>(v2);
        let v3 = PriceUpdated<T0>{
            sale_id   : 0x2::object::uid_to_inner(&arg0.id),
            new_price : arg1,
        };
        0x2::event::emit<PriceUpdated<T0>>(v3);
        let v4 = DebugEvent{
            message   : 0x1::string::utf8(b"Sale price updated successfully"),
            token_id  : 0x2::object::uid_to_inner(&arg0.id),
            sender    : v0,
            recipient : v0,
        };
        0x2::event::emit<DebugEvent>(v4);
    }

    public fun validate_percentages(arg0: &vector<u64>) : bool {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg0)) {
            v0 = v0 + *0x1::vector::borrow<u64>(arg0, v1);
            v1 = v1 + 1;
        };
        v0 == 100
    }

    public fun verify_collection_match(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        assert!(arg0 == arg1, 8);
        assert!(arg0 == arg2, 8);
    }

    public fun verify_listing<T0>(arg0: &NFTSale<T0>, arg1: &NFTListing<T0>, arg2: u64) : bool {
        if (arg1.sale_id == 0x2::object::uid_to_inner(&arg0.id)) {
            if (arg1.asset_id == arg2) {
                arg1.price == arg0.price_per_nft
            } else {
                false
            }
        } else {
            false
        }
    }

    public entry fun verify_upgrade(arg0: &0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::verify_admin(arg0, 0x2::tx_context::sender(arg1)), 29);
    }

    public entry fun withdraw_currency<T0>(arg0: &mut NFTSale<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: &0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::CollectionCap, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg0.creator, 2);
        assert!(!0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::is_denied(arg3, v0), 12);
        let v1 = 0x2::balance::value<T0>(&arg0.currency_balance);
        assert!(v1 > 0, 22);
        let v2 = 0x1::vector::length<address>(&arg1);
        assert!(v2 > 0, 25);
        assert!(v2 == 0x1::vector::length<u64>(&arg2), 23);
        let v3 = 0;
        while (v3 < v2) {
            assert!(!0xfa96270090750dabb1c16a0fffef96e1df341ac7cab5ee08f4da36cbe5dc96::ART20::is_denied(arg3, *0x1::vector::borrow<address>(&arg1, v3)), 12);
            v3 = v3 + 1;
        };
        let v4 = 0;
        let v5 = 0;
        while (v5 < 0x1::vector::length<u64>(&arg2)) {
            let v6 = *0x1::vector::borrow<u64>(&arg2, v5);
            assert!(v6 > 0 && v6 <= 100, 23);
            v4 = safe_add(v4, v6);
            v5 = v5 + 1;
        };
        assert!(v4 == 100, 24);
        let v7 = DebugEvent{
            message   : 0x1::string::utf8(b"Starting currency withdrawal"),
            token_id  : 0x2::object::uid_to_inner(&arg0.id),
            sender    : v0,
            recipient : v0,
        };
        0x2::event::emit<DebugEvent>(v7);
        let v8 = 0;
        v5 = 0;
        while (v5 < v2) {
            let v9 = *0x1::vector::borrow<address>(&arg1, v5);
            let v10 = *0x1::vector::borrow<u64>(&arg2, v5);
            let v11 = v1 * v10 / 100;
            assert!(v11 > 0, 23);
            let v12 = safe_add(v8, v11);
            v8 = v12;
            assert!(v12 <= v1, 18);
            let v13 = CurrencyWithdrawSplit<T0>{
                sale_id    : 0x2::object::uid_to_inner(&arg0.id),
                recipient  : v9,
                amount     : v11,
                percentage : v10,
            };
            0x2::event::emit<CurrencyWithdrawSplit<T0>>(v13);
            let v14 = DebugEvent{
                message   : 0x1::string::utf8(b"Processing split payment"),
                token_id  : 0x2::object::uid_to_inner(&arg0.id),
                sender    : v0,
                recipient : v9,
            };
            0x2::event::emit<DebugEvent>(v14);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.currency_balance, v11), arg4), v9);
            v5 = v5 + 1;
        };
        assert!(0x2::balance::value<T0>(&arg0.currency_balance) == v1 - v8, 18);
        let v15 = CurrencyWithdrawn<T0>{
            sale_id   : 0x2::object::uid_to_inner(&arg0.id),
            amount    : v8,
            recipient : v0,
        };
        0x2::event::emit<CurrencyWithdrawn<T0>>(v15);
        let v16 = DebugEvent{
            message   : 0x1::string::utf8(b"Currency withdrawal completed successfully"),
            token_id  : 0x2::object::uid_to_inner(&arg0.id),
            sender    : v0,
            recipient : v0,
        };
        0x2::event::emit<DebugEvent>(v16);
    }

    // decompiled from Move bytecode v6
}

