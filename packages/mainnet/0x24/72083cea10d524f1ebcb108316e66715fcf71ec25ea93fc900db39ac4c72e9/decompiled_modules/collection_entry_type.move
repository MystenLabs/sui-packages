module 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type {
    struct CollectionEntry has store {
        nft_id: 0x2::object::ID,
        image_url: 0x2::url::Url,
        title: 0x1::string::String,
        creator: address,
        overall_support_index: u64,
        supporter_count: u64,
        total_support: u64,
        last_supporter_amount: u64,
        supporters: 0x2::linked_table::LinkedTable<address, CollectionEntrySupporter>,
        index: u64,
        purchase_cap: 0x2::kiosk::PurchaseCap<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft_type::CollectionNft>,
        timestamp_ms: u64,
    }

    struct CollectionEntrySupporter has store {
        nft_id: 0x2::object::ID,
        index: u64,
        supporter: address,
        support: 0x2::balance::Balance<0x2::sui::SUI>,
        timestamp_ms: u64,
    }

    struct CollectionEntrySupporterInfo has copy, drop, store {
        nft_id: 0x2::object::ID,
        index: u64,
        supporter: address,
        support_amount: u64,
        timestamp_ms: u64,
    }

    struct CollectionEntryInfo has copy, drop, store {
        nft_id: 0x2::object::ID,
        image_url: 0x2::url::Url,
        title: 0x1::string::String,
        creator: address,
        overall_support_index: u64,
        supporter_count: u64,
        total_support: u64,
        last_supporter_amount: u64,
        supporters: vector<CollectionEntrySupporterInfo>,
        index: u64,
        timestamp_ms: u64,
    }

    public(friend) fun add_supporter(arg0: &mut CollectionEntry, arg1: address, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) : CollectionEntrySupporterInfo {
        assert_valid_support(arg0, 0x2::coin::value<0x2::sui::SUI>(&arg2));
        let v0 = &mut arg0.supporters;
        let v1 = arg0.nft_id;
        let v2 = 0x2::linked_table::length<address, CollectionEntrySupporter>(v0);
        let v3 = 0x2::clock::timestamp_ms(arg5);
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v5 = CollectionEntrySupporter{
            nft_id       : v1,
            index        : v2,
            supporter    : arg1,
            support      : 0x2::coin::into_balance<0x2::sui::SUI>(arg2),
            timestamp_ms : v3,
        };
        0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_events::emit_collection_entry_supported(v1, arg0.image_url, arg0.title, arg1, v4, v2, arg4, v3);
        arg0.total_support = arg0.total_support + v4;
        arg0.overall_support_index = arg3;
        arg0.supporter_count = arg0.supporter_count + 1;
        arg0.last_supporter_amount = v4;
        0x2::linked_table::push_back<address, CollectionEntrySupporter>(v0, arg1, v5);
        CollectionEntrySupporterInfo{
            nft_id         : v1,
            index          : v2,
            supporter      : arg1,
            support_amount : v4,
            timestamp_ms   : v3,
        }
    }

    public fun assert_valid_support(arg0: &CollectionEntry, arg1: u64) {
        assert!(arg1 == min_support_amount() << (0x2::linked_table::length<address, CollectionEntrySupporter>(&arg0.supporters) as u8), 0);
    }

    public(friend) fun create(arg0: 0x2::object::ID, arg1: 0x2::url::Url, arg2: 0x1::string::String, arg3: address, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: 0x2::kiosk::PurchaseCap<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft_type::CollectionNft>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : CollectionEntry {
        let v0 = CollectionEntry{
            nft_id                : arg0,
            image_url             : arg1,
            title                 : arg2,
            creator               : arg3,
            overall_support_index : arg4,
            supporter_count       : 0,
            total_support         : 0,
            last_supporter_amount : 0,
            supporters            : 0x2::linked_table::new<address, CollectionEntrySupporter>(arg9),
            index                 : arg5,
            purchase_cap          : arg7,
            timestamp_ms          : 0x2::clock::timestamp_ms(arg6),
        };
        0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_events::emit_collection_entry_submitted(arg0, arg3, arg1, arg2, v0.index, arg8, v0.timestamp_ms);
        v0
    }

    public(friend) fun delete_entry(arg0: CollectionEntry) : (0x2::linked_table::LinkedTable<address, CollectionEntrySupporter>, 0x2::kiosk::PurchaseCap<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft_type::CollectionNft>) {
        let (v0, _, _, _, _, _, _, _, _, v9, v10, _) = destructure_entry(arg0);
        0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_events::emit_collection_entry_removed(v0);
        (v9, v10)
    }

    public(friend) fun destructure_entry(arg0: CollectionEntry) : (0x2::object::ID, 0x2::url::Url, 0x1::string::String, address, u64, u64, u64, u64, u64, 0x2::linked_table::LinkedTable<address, CollectionEntrySupporter>, 0x2::kiosk::PurchaseCap<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft_type::CollectionNft>, u64) {
        let CollectionEntry {
            nft_id                : v0,
            image_url             : v1,
            title                 : v2,
            creator               : v3,
            overall_support_index : v4,
            supporter_count       : v5,
            total_support         : v6,
            last_supporter_amount : v7,
            supporters            : v8,
            index                 : v9,
            purchase_cap          : v10,
            timestamp_ms          : v11,
        } = arg0;
        (v0, v1, v2, v3, v5, v6, v4, v7, v9, v8, v10, v11)
    }

    public(friend) fun destructure_supporter(arg0: CollectionEntrySupporter) : (0x2::object::ID, address, 0x2::balance::Balance<0x2::sui::SUI>, u64, u64) {
        let CollectionEntrySupporter {
            nft_id       : v0,
            index        : v1,
            supporter    : v2,
            support      : v3,
            timestamp_ms : v4,
        } = arg0;
        (v0, v2, v3, v1, v4)
    }

    public fun entry_info_last_supporter_amount(arg0: &CollectionEntryInfo) : u64 {
        arg0.last_supporter_amount
    }

    public fun entry_info_nft_id(arg0: &CollectionEntryInfo) : 0x2::object::ID {
        arg0.nft_id
    }

    public fun entry_info_supporter_count(arg0: &CollectionEntryInfo) : u64 {
        arg0.supporter_count
    }

    public fun entry_info_total_support(arg0: &CollectionEntryInfo) : u64 {
        arg0.total_support
    }

    public fun entry_nft_id(arg0: &CollectionEntry) : 0x2::object::ID {
        arg0.nft_id
    }

    public fun entry_overall_support_index(arg0: &CollectionEntry) : u64 {
        arg0.overall_support_index
    }

    public(friend) fun entry_to_entry_info(arg0: &CollectionEntry) : CollectionEntryInfo {
        let v0 = 0x1::vector::empty<CollectionEntrySupporterInfo>();
        let v1 = 0x2::linked_table::front<address, CollectionEntrySupporter>(&arg0.supporters);
        while (0x1::option::is_some<address>(v1)) {
            let v2 = *0x1::option::borrow<address>(v1);
            0x1::vector::push_back<CollectionEntrySupporterInfo>(&mut v0, supporter_to_supporter_info(0x2::linked_table::borrow<address, CollectionEntrySupporter>(&arg0.supporters, v2)));
            v1 = 0x2::linked_table::next<address, CollectionEntrySupporter>(&arg0.supporters, v2);
        };
        CollectionEntryInfo{
            nft_id                : arg0.nft_id,
            image_url             : arg0.image_url,
            title                 : arg0.title,
            creator               : arg0.creator,
            overall_support_index : arg0.overall_support_index,
            supporter_count       : arg0.supporter_count,
            total_support         : arg0.total_support,
            last_supporter_amount : arg0.last_supporter_amount,
            supporters            : v0,
            index                 : arg0.index,
            timestamp_ms          : arg0.timestamp_ms,
        }
    }

    public fun entry_total_support(arg0: &CollectionEntry) : u64 {
        arg0.total_support
    }

    public(friend) fun increase_support(arg0: &mut CollectionEntry, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut CollectionEntrySupporterInfo, arg6: u64) : u64 {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v1 = 0x2::linked_table::borrow_mut<address, CollectionEntrySupporter>(&mut arg0.supporters, arg2);
        let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v2) <= 0x2::balance::value<0x2::sui::SUI>(&v1.support) * 2, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut v1.support, v2);
        0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_events::emit_collection_entry_supported(arg0.nft_id, arg0.image_url, arg0.title, v1.supporter, v0, v1.index, arg6, 0x2::clock::timestamp_ms(arg4));
        arg0.total_support = arg0.total_support + v0;
        arg0.overall_support_index = arg3;
        if (arg0.supporter_count - 1 == v1.index) {
            arg0.last_supporter_amount = 0x2::balance::value<0x2::sui::SUI>(&v1.support);
        };
        arg5.support_amount = v0;
        v0
    }

    public fun last_supporter_amount(arg0: &mut CollectionEntry, arg1: u64) {
        arg0.last_supporter_amount = arg1;
    }

    public fun min_support_amount() : u64 {
        250000000
    }

    public(friend) fun remove_supporter(arg0: address, arg1: &mut CollectionEntry) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = &mut arg1.supporters;
        let (v1, v2, v3, _, _) = destructure_supporter(0x2::linked_table::remove<address, CollectionEntrySupporter>(v0, arg0));
        let v6 = v3;
        let v7 = 0x2::linked_table::length<address, CollectionEntrySupporter>(v0);
        let v8 = 0;
        if (v7 > 0) {
            let v9 = *0x1::option::borrow<address>(0x2::linked_table::front<address, CollectionEntrySupporter>(v0));
            let v10 = 0;
            loop {
                if (0x2::linked_table::contains<address, CollectionEntrySupporter>(v0, v9)) {
                    let v11 = 0x2::linked_table::borrow_mut<address, CollectionEntrySupporter>(v0, v9);
                    v11.index = v10;
                    v8 = 0x2::balance::value<0x2::sui::SUI>(&v11.support);
                };
                v10 = v10 + 1;
                if (v10 >= v7) {
                    break
                };
                let v12 = 0x1::option::borrow<address>(0x2::linked_table::next<address, CollectionEntrySupporter>(v0, v9));
                v9 = *v12;
            };
        };
        let v13 = 0x2::balance::value<0x2::sui::SUI>(&v6);
        arg1.supporter_count = v7;
        arg1.total_support = arg1.total_support - v13;
        arg1.last_supporter_amount = v8;
        0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_events::emit_collection_entry_support_removed(v1, v2, v13);
        v6
    }

    public fun supporter_index(arg0: &CollectionEntrySupporter) : u64 {
        arg0.index
    }

    public fun supporter_info_amount(arg0: &CollectionEntrySupporterInfo) : u64 {
        arg0.support_amount
    }

    public fun supporter_info_index(arg0: &CollectionEntrySupporterInfo) : u64 {
        arg0.index
    }

    public fun supporter_support_amount(arg0: &CollectionEntrySupporter) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.support)
    }

    public fun supporter_support_mut(arg0: &mut CollectionEntrySupporter) : &mut 0x2::balance::Balance<0x2::sui::SUI> {
        &mut arg0.support
    }

    public fun supporter_supporter(arg0: &CollectionEntrySupporter) : address {
        arg0.supporter
    }

    public(friend) fun supporter_to_supporter_info(arg0: &CollectionEntrySupporter) : CollectionEntrySupporterInfo {
        CollectionEntrySupporterInfo{
            nft_id         : arg0.nft_id,
            index          : arg0.index,
            supporter      : arg0.supporter,
            support_amount : 0x2::balance::value<0x2::sui::SUI>(&arg0.support),
            timestamp_ms   : arg0.timestamp_ms,
        }
    }

    public fun supporters(arg0: &CollectionEntry) : &0x2::linked_table::LinkedTable<address, CollectionEntrySupporter> {
        &arg0.supporters
    }

    public fun supporters_mut(arg0: &mut CollectionEntry) : &mut 0x2::linked_table::LinkedTable<address, CollectionEntrySupporter> {
        &mut arg0.supporters
    }

    // decompiled from Move bytecode v6
}

