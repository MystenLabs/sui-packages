module 0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::market_event {
    struct MarketCreatedEvent has copy, drop {
        market_id: 0x2::object::ID,
        collection_list: 0x2::object::ID,
        owner: address,
    }

    struct CollectionCreatedEvent has copy, drop {
        collection_id: 0x2::object::ID,
        creator_address: address,
    }

    struct ItemListedEvent has copy, drop {
        collection_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        operator: address,
        price: u64,
        nft_type: 0x1::ascii::String,
        ft_type: 0x1::ascii::String,
        is_new_collection: bool,
    }

    struct ItemBuyEvent has copy, drop {
        collection_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        from: address,
        to: address,
        nft_type: 0x1::ascii::String,
        ft_type: 0x1::ascii::String,
        price: u64,
    }

    struct CollectionWithdrawalEvent has copy, drop {
        collection_id: 0x2::object::ID,
        from: address,
        to: address,
        nft_type: 0x1::ascii::String,
        ft_type: 0x1::ascii::String,
        price: u64,
    }

    struct ItemDeListedEvent has copy, drop {
        collection_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        operator: address,
        nft_type: 0x1::ascii::String,
        ft_type: 0x1::ascii::String,
        price: u64,
    }

    struct ItemAdjustPriceEvent has copy, drop {
        collection_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        operator: address,
        nft_type: 0x1::ascii::String,
        ft_type: 0x1::ascii::String,
        price: u64,
    }

    public fun collection_withdrawal(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: u64) {
        let v0 = CollectionWithdrawalEvent{
            collection_id : arg0,
            from          : arg1,
            to            : arg2,
            nft_type      : arg3,
            ft_type       : arg4,
            price         : arg5,
        };
        0x2::event::emit<CollectionWithdrawalEvent>(v0);
    }

    public fun item_adjust_price_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: u64) {
        let v0 = ItemAdjustPriceEvent{
            collection_id : arg0,
            item_id       : arg1,
            operator      : arg2,
            nft_type      : arg3,
            ft_type       : arg4,
            price         : arg5,
        };
        0x2::event::emit<ItemAdjustPriceEvent>(v0);
    }

    public fun item_buy_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: address, arg4: 0x1::ascii::String, arg5: 0x1::ascii::String, arg6: u64) {
        let v0 = ItemBuyEvent{
            collection_id : arg0,
            item_id       : arg1,
            from          : arg2,
            to            : arg3,
            nft_type      : arg4,
            ft_type       : arg5,
            price         : arg6,
        };
        0x2::event::emit<ItemBuyEvent>(v0);
    }

    public fun item_delisted_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address, arg4: 0x1::ascii::String, arg5: 0x1::ascii::String, arg6: u64) {
        let v0 = ItemDeListedEvent{
            collection_id : arg0,
            item_id       : arg1,
            listing_id    : arg2,
            operator      : arg3,
            nft_type      : arg4,
            ft_type       : arg5,
            price         : arg6,
        };
        0x2::event::emit<ItemDeListedEvent>(v0);
    }

    public fun item_list_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address, arg4: u64, arg5: 0x1::ascii::String, arg6: 0x1::ascii::String, arg7: bool) {
        let v0 = ItemListedEvent{
            collection_id     : arg0,
            item_id           : arg1,
            listing_id        : arg2,
            operator          : arg3,
            price             : arg4,
            nft_type          : arg5,
            ft_type           : arg6,
            is_new_collection : arg7,
        };
        0x2::event::emit<ItemListedEvent>(v0);
    }

    public fun market_created_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address) {
        let v0 = MarketCreatedEvent{
            market_id       : arg0,
            collection_list : arg1,
            owner           : arg2,
        };
        0x2::event::emit<MarketCreatedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

