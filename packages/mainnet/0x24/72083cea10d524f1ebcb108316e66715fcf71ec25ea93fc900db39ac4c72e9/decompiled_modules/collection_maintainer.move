module 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer {
    struct COLLECTION_MAINTAINER has drop {
        dummy_field: bool,
    }

    struct CollectionAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct CollectionMaintainer has key {
        id: 0x2::object::UID,
        election_index: u64,
        bundle_count: u64,
        bundle_fee: u64,
        bundle_discount: u64,
        bundle_valid_purchases: vector<u64>,
        ai_art_ticket_count: u64,
        ai_title_ticket_count: u64,
        nft_mint_count: u64,
        entry_count: u64,
        support_count: u64,
        ai_art_ticket_fee: u64,
        ai_title_ticket_fee: u64,
        nft_mint_fee: u64,
        entry_fee: u64,
        support_fee: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        minted_images: 0x2::table::Table<vector<u8>, 0x2::object::ID>,
        entries: 0x2::table::Table<0x2::object::ID, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntry>,
        supports: 0x2::table::Table<address, 0x2::linked_table::LinkedTable<0x2::object::ID, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntrySupporterInfo>>,
        ordered_support_levels: 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::CritbitTree<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::CritbitTree<0x2::object::ID>>,
        nft_transfer_policy: 0x2::transfer_policy::TransferPolicy<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft_type::CollectionNft>,
        pending_elected: 0x1::option::Option<0x2::object::ID>,
        official_nfts: 0x2::linked_table::LinkedTable<0x2::object::ID, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_official_nft::CollectionOfficialNftRecord>,
        pending_official_nfts: 0x2::table::Table<address, vector<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_official_nft::CollectionOfficialNft>>,
        accounts: 0x2::table::Table<address, 0x2::balance::Balance<0x2::sui::SUI>>,
        royalties: 0x2::table::Table<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>,
        scheduled_remove_supporters: 0x2::linked_table::LinkedTable<address, vector<0x2::object::ID>>,
        public_key: vector<u8>,
        paused: bool,
        version: u64,
    }

    public fun balance(arg0: &CollectionMaintainer) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun account_balance(arg0: &CollectionMaintainer, arg1: address) : u64 {
        if (!0x2::table::contains<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.accounts, arg1)) {
            return 0
        };
        0x2::balance::value<0x2::sui::SUI>(0x2::table::borrow<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.accounts, arg1))
    }

    public(friend) fun add_minted_image(arg0: &mut CollectionMaintainer, arg1: vector<u8>, arg2: 0x2::object::ID) {
        assert_maintainer_version_and_paused(arg0);
        assert!(!is_image_minted(arg1, arg0), 8);
        0x2::table::add<vector<u8>, 0x2::object::ID>(&mut arg0.minted_images, arg1, arg2);
    }

    public entry fun admin_remove_entry(arg0: &mut CollectionMaintainer, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &CollectionAdminCap, arg4: &mut 0x2::tx_context::TxContext) {
        assert_maintainer_version(arg0);
        let v0 = remove_entry(arg0, arg2, arg1, arg4);
        0x2::transfer::public_transfer<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft_type::CollectionNft>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun ai_art_ticket_count(arg0: &CollectionMaintainer) : u64 {
        arg0.ai_art_ticket_count
    }

    public fun ai_art_ticket_price(arg0: &CollectionMaintainer) : u64 {
        arg0.ai_art_ticket_fee
    }

    public fun ai_title_ticket_count(arg0: &CollectionMaintainer) : u64 {
        arg0.ai_title_ticket_count
    }

    public fun ai_title_ticket_price(arg0: &CollectionMaintainer) : u64 {
        arg0.ai_title_ticket_fee
    }

    public fun assert_maintainer_paused(arg0: &CollectionMaintainer) {
        assert!(!arg0.paused, 10);
    }

    public fun assert_maintainer_version(arg0: &CollectionMaintainer) {
        assert!(arg0.version == 1, 0);
    }

    public fun assert_maintainer_version_and_paused(arg0: &CollectionMaintainer) {
        assert_maintainer_version(arg0);
        assert_maintainer_paused(arg0);
    }

    public fun bundle_count(arg0: &CollectionMaintainer) : u64 {
        arg0.bundle_count
    }

    public fun bundle_discount(arg0: &CollectionMaintainer) : u64 {
        arg0.bundle_discount
    }

    public fun bundle_price(arg0: &CollectionMaintainer) : u64 {
        arg0.bundle_fee
    }

    public fun bundle_valid_purchases(arg0: &CollectionMaintainer) : vector<u64> {
        arg0.bundle_valid_purchases
    }

    public entry fun change_ai_art_ticket_fee(arg0: &mut CollectionMaintainer, arg1: u64, arg2: &CollectionAdminCap) {
        assert_maintainer_version(arg0);
        arg0.ai_art_ticket_fee = arg1;
    }

    public entry fun change_ai_title_ticket_fee(arg0: &mut CollectionMaintainer, arg1: u64, arg2: &CollectionAdminCap) {
        assert_maintainer_version(arg0);
        arg0.ai_title_ticket_fee = arg1;
    }

    public entry fun change_bundle_fee(arg0: &mut CollectionMaintainer, arg1: u64, arg2: &CollectionAdminCap) {
        assert_maintainer_version(arg0);
        arg0.bundle_fee = arg1;
    }

    public entry fun change_bundle_valid_purchases(arg0: &mut CollectionMaintainer, arg1: vector<u64>, arg2: &CollectionAdminCap) {
        assert_maintainer_version(arg0);
        arg0.bundle_valid_purchases = arg1;
    }

    public entry fun change_entry_fee(arg0: &mut CollectionMaintainer, arg1: u64, arg2: &CollectionAdminCap) {
        assert_maintainer_version(arg0);
        arg0.entry_fee = arg1;
    }

    public entry fun change_nft_mint_fee(arg0: &mut CollectionMaintainer, arg1: u64, arg2: &CollectionAdminCap) {
        assert_maintainer_version(arg0);
        arg0.nft_mint_fee = arg1;
    }

    public entry fun change_support_fee(arg0: &mut CollectionMaintainer, arg1: u64, arg2: &CollectionAdminCap) {
        assert_maintainer_version(arg0);
        arg0.support_fee = arg1;
    }

    public entry fun claim_nfts(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut CollectionMaintainer, arg3: &mut 0x2::tx_context::TxContext) {
        assert_maintainer_version(arg2);
        assert!(0x2::kiosk::has_access(arg0, arg1), 6);
        assert!(0x2::table::contains<address, vector<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_official_nft::CollectionOfficialNft>>(&arg2.pending_official_nfts, 0x2::tx_context::sender(arg3)), 5);
        let v0 = 0x2::table::remove<address, vector<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_official_nft::CollectionOfficialNft>>(&mut arg2.pending_official_nfts, 0x2::tx_context::sender(arg3));
        while (0x1::vector::length<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_official_nft::CollectionOfficialNft>(&v0) > 0) {
            0x2::kiosk::place<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_official_nft::CollectionOfficialNft>(arg0, arg1, 0x1::vector::pop_back<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_official_nft::CollectionOfficialNft>(&mut v0));
        };
        0x1::vector::destroy_empty<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_official_nft::CollectionOfficialNft>(v0);
    }

    public entry fun collect_royalties(arg0: &mut 0x2::transfer_policy::TransferPolicy<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_official_nft::CollectionOfficialNft>, arg1: &mut CollectionMaintainer, arg2: &0x2::transfer_policy::TransferPolicyCap<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_official_nft::CollectionOfficialNft>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_maintainer_version(arg1);
        let v0 = 0x2::transfer_policy::withdraw<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_official_nft::CollectionOfficialNft>(arg0, arg2, 0x1::option::none<u64>(), arg3);
        let v1 = 0x2::linked_table::length<0x2::object::ID, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_official_nft::CollectionOfficialNftRecord>(&arg1.official_nfts);
        let v2 = 0x2::linked_table::front<0x2::object::ID, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_official_nft::CollectionOfficialNftRecord>(&arg1.official_nfts);
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&v0) / v1;
        assert!(v3 > 0, 12);
        let v4 = 0;
        while (v4 < v1) {
            if (0x1::option::is_none<0x2::object::ID>(v2)) {
                break
            };
            let v5 = *0x1::option::borrow<0x2::object::ID>(v2);
            if (0x2::table::contains<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>(&arg1.royalties, v5)) {
                0x2::balance::join<0x2::sui::SUI>(0x2::table::borrow_mut<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg1.royalties, v5), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v0, v3, arg3)));
            } else {
                0x2::table::add<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg1.royalties, v5, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v0, v3, arg3)));
            };
            0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_official_nft::add_royalties(0x2::linked_table::borrow_mut<0x2::object::ID, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_official_nft::CollectionOfficialNftRecord>(&mut arg1.official_nfts, v5), v3);
            let v6 = v4 + 1;
            v4 = v6;
            if (v6 >= v1) {
                break
            };
            v2 = 0x2::linked_table::next<0x2::object::ID, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_official_nft::CollectionOfficialNftRecord>(&arg1.official_nfts, v5);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::coin::into_balance<0x2::sui::SUI>(v0));
    }

    public entry fun complete_election(arg0: &mut CollectionMaintainer, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::clock::Clock, arg3: &CollectionAdminCap, arg4: &mut 0x2::tx_context::TxContext) {
        assert_maintainer_version(arg0);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.pending_elected), 4);
        let v0 = 0x1::option::extract<0x2::object::ID>(&mut arg0.pending_elected);
        assert!(0x2::kiosk::has_item(arg1, v0), 6);
        arg0.election_index = arg0.election_index + 1;
        let (v1, v2, v3, v4, _, v6, _, _, _, v10, v11, v12) = 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::destructure_entry(0x2::table::remove<0x2::object::ID, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntry>(&mut arg0.entries, v0));
        let v13 = v10;
        let v14 = v1;
        let v15 = &mut arg0.scheduled_remove_supporters;
        let v16 = 0x2::linked_table::length<address, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntrySupporter>(&v13);
        let v17 = 0x1::vector::empty<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_official_nft::CollectionOfficialSupporter>();
        let v18 = *0x1::option::borrow<address>(0x2::linked_table::front<address, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntrySupporter>(&v13));
        let v19 = 0;
        loop {
            if (0x2::linked_table::contains<address, vector<0x2::object::ID>>(v15, v18)) {
                let v20 = 0x2::linked_table::borrow_mut<address, vector<0x2::object::ID>>(v15, v18);
                let (v21, v22) = 0x1::vector::index_of<0x2::object::ID>(v20, &v14);
                if (v21) {
                    0x1::vector::swap_remove<0x2::object::ID>(v20, v22);
                };
            };
            0x1::vector::push_back<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_official_nft::CollectionOfficialSupporter>(&mut v17, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_official_nft::create_supporter(0x2::linked_table::borrow<address, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntrySupporter>(&v13, v18)));
            v19 = v19 + 1;
            if (v19 >= v16) {
                break
            };
            let v23 = 0x1::option::borrow<address>(0x2::linked_table::next<address, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntrySupporter>(&v13, v18));
            v18 = *v23;
        };
        let v24 = 0;
        let v25 = 0;
        let v26 = 0x2::coin::zero<0x2::sui::SUI>(arg4);
        while (0x2::linked_table::length<address, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntrySupporter>(&v13) > 0) {
            let (_, v28) = 0x2::linked_table::pop_front<address, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntrySupporter>(&mut v13);
            let (_, v30, v31, _, _) = 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::destructure_supporter(v28);
            if (v30 != v4) {
                0x2::coin::join<0x2::sui::SUI>(&mut v26, 0x2::coin::from_balance<0x2::sui::SUI>(v31, arg4));
                let v34 = arg0.election_index;
                mint_official_nft(v34, v30, v2, v3, v4, v6, v17, v24 + 1, arg2, arg0, arg4);
            } else {
                let v35 = 0x2::coin::from_balance<0x2::sui::SUI>(v31, arg4);
                v25 = v25 + 0x2::coin::value<0x2::sui::SUI>(&v35);
                0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, v35);
            };
            v24 = v24 + 1;
        };
        0x2::linked_table::destroy_empty<address, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntrySupporter>(v13);
        let v36 = arg0.election_index;
        mint_official_nft(v36, v4, v2, v3, v4, v6, v17, 0, arg2, arg0, arg4);
        let v37 = 0x2::coin::value<0x2::sui::SUI>(&v26);
        let v38 = 0x1::vector::empty<0x2::coin::Coin<0x2::sui::SUI>>();
        0x1::vector::push_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut v38, v26);
        let (v39, v40) = merge_and_split(v38, 1, v37 * 50 / 100, arg4);
        let (v41, v42) = 0x2::kiosk::purchase_with_cap<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft_type::CollectionNft>(arg1, v11, v39);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft_type::CollectionNft>(&arg0.nft_transfer_policy, v42);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, v40);
        0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_events::emit_collection_election_ended(v14, v2, v3, v4, v25 + v37, v16, arg0.election_index, v12);
        0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft_type::burn(v41);
    }

    public(friend) fun create_maintainer(arg0: 0x2::transfer_policy::TransferPolicy<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft_type::CollectionNft>, arg1: &mut 0x2::tx_context::TxContext) : CollectionMaintainer {
        CollectionMaintainer{
            id                          : 0x2::object::new(arg1),
            election_index              : 0,
            bundle_count                : 0,
            bundle_fee                  : 10000000,
            bundle_discount             : 20,
            bundle_valid_purchases      : vector[1],
            ai_art_ticket_count         : 0,
            ai_title_ticket_count       : 0,
            nft_mint_count              : 0,
            entry_count                 : 0,
            support_count               : 0,
            ai_art_ticket_fee           : 30000000,
            ai_title_ticket_fee         : 20000000,
            nft_mint_fee                : 500000000,
            entry_fee                   : 300000000,
            support_fee                 : 100000000,
            balance                     : 0x2::balance::zero<0x2::sui::SUI>(),
            minted_images               : 0x2::table::new<vector<u8>, 0x2::object::ID>(arg1),
            entries                     : 0x2::table::new<0x2::object::ID, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntry>(arg1),
            supports                    : 0x2::table::new<address, 0x2::linked_table::LinkedTable<0x2::object::ID, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntrySupporterInfo>>(arg1),
            ordered_support_levels      : 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::new<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::CritbitTree<0x2::object::ID>>(arg1),
            nft_transfer_policy         : arg0,
            pending_elected             : 0x1::option::none<0x2::object::ID>(),
            official_nfts               : 0x2::linked_table::new<0x2::object::ID, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_official_nft::CollectionOfficialNftRecord>(arg1),
            pending_official_nfts       : 0x2::table::new<address, vector<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_official_nft::CollectionOfficialNft>>(arg1),
            accounts                    : 0x2::table::new<address, 0x2::balance::Balance<0x2::sui::SUI>>(arg1),
            royalties                   : 0x2::table::new<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>(arg1),
            scheduled_remove_supporters : 0x2::linked_table::new<address, vector<0x2::object::ID>>(arg1),
            public_key                  : x"82689ac2217991cfe50760807d73798b232c69b96d1caa0e320d764de98490e1",
            paused                      : false,
            version                     : 1,
        }
    }

    public fun election_index(arg0: &CollectionMaintainer) : u64 {
        arg0.election_index
    }

    public fun entries(arg0: &CollectionMaintainer, arg1: vector<0x2::object::ID>) : vector<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntryInfo> {
        let v0 = 0x1::vector::empty<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntryInfo>();
        while (0x1::vector::length<0x2::object::ID>(&arg1) > 0) {
            0x1::vector::push_back<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntryInfo>(&mut v0, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::entry_to_entry_info(0x2::table::borrow<0x2::object::ID, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntry>(&arg0.entries, 0x1::vector::pop_back<0x2::object::ID>(&mut arg1))));
        };
        v0
    }

    public fun entry(arg0: &CollectionMaintainer, arg1: 0x2::object::ID) : 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntryInfo {
        assert!(0x2::table::contains<0x2::object::ID, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntry>(&arg0.entries, arg1), 3);
        0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::entry_to_entry_info(0x2::table::borrow<0x2::object::ID, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntry>(&arg0.entries, arg1))
    }

    public fun entry_count(arg0: &CollectionMaintainer) : u64 {
        arg0.entry_count
    }

    public fun entry_position(arg0: &CollectionMaintainer, arg1: 0x2::object::ID) : u64 {
        let (v0, v1) = 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::find_leaf<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::CritbitTree<0x2::object::ID>>(&arg0.ordered_support_levels, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::entry_total_support(0x2::table::borrow<0x2::object::ID, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntry>(&arg0.entries, arg1)));
        assert!(v0, 3);
        let (v2, v3) = 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::max_leaf<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::CritbitTree<0x2::object::ID>>(&arg0.ordered_support_levels);
        let v4 = v3;
        let v5 = v2;
        let v6 = 0;
        let v7;
        loop {
            let v8 = 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::borrow_leaf_by_index<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::CritbitTree<0x2::object::ID>>(&arg0.ordered_support_levels, v4);
            if (v4 == v1) {
                let (v9, v10) = 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::min_leaf<0x2::object::ID>(v8);
                let v11 = v10;
                let v12 = v9;
                v7 = 0;
                loop {
                    v7 = v7 + 1;
                    if (0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::borrow_leaf_by_index<0x2::object::ID>(v8, v11) == &arg1) {
                        /* goto 13 */
                        break
                    };
                    if (v7 >= 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::size<0x2::object::ID>(v8)) {
                        break
                    };
                    let (v13, v14) = 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::next_leaf<0x2::object::ID>(v8, v12);
                    v11 = v14;
                    v12 = v13;
                };
            } else {
                v6 = v6 + 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::size<0x2::object::ID>(v8);
            };
            let (v15, v16) = 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::previous_leaf<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::CritbitTree<0x2::object::ID>>(&arg0.ordered_support_levels, v5);
            v4 = v16;
            v5 = v15;
        };
        /* label 13 */
        v6 + v7
    }

    public fun entry_supporters(arg0: &CollectionMaintainer, arg1: 0x2::object::ID) : vector<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntrySupporterInfo> {
        let v0 = 0x1::vector::empty<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntrySupporterInfo>();
        let v1 = 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::supporters(0x2::table::borrow<0x2::object::ID, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntry>(&arg0.entries, arg1));
        let v2 = 0x2::linked_table::front<address, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntrySupporter>(v1);
        while (0x1::option::is_some<address>(v2)) {
            let v3 = *0x1::option::borrow<address>(v2);
            0x1::vector::push_back<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntrySupporterInfo>(&mut v0, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::supporter_to_supporter_info(0x2::linked_table::borrow<address, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntrySupporter>(v1, v3)));
            v2 = 0x2::linked_table::next<address, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntrySupporter>(v1, v3);
        };
        v0
    }

    public(friend) fun increment_ai_art_ticket_count(arg0: &mut CollectionMaintainer) : u64 {
        arg0.ai_art_ticket_count = arg0.ai_art_ticket_count + 1;
        arg0.ai_art_ticket_count
    }

    public(friend) fun increment_ai_title_ticket_count(arg0: &mut CollectionMaintainer) : u64 {
        arg0.ai_title_ticket_count = arg0.ai_title_ticket_count + 1;
        arg0.ai_title_ticket_count
    }

    public(friend) fun increment_bundle_count(arg0: u64, arg1: &mut CollectionMaintainer) : u64 {
        arg1.bundle_count = arg1.bundle_count + arg0;
        arg1.bundle_count
    }

    public(friend) fun increment_entry_count(arg0: &mut CollectionMaintainer) : u64 {
        arg0.entry_count = arg0.entry_count + 1;
        arg0.entry_count
    }

    public(friend) fun increment_nft_mint_count(arg0: &mut CollectionMaintainer) : u64 {
        arg0.nft_mint_count = arg0.nft_mint_count + 1;
        arg0.nft_mint_count
    }

    fun init(arg0: COLLECTION_MAINTAINER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<COLLECTION_MAINTAINER>(arg0, arg1);
        let (v1, v2) = 0x2::transfer_policy::new<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft_type::CollectionNft>(&v0, arg1);
        let (v3, v4) = 0x2::transfer_policy::new<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_official_nft::CollectionOfficialNft>(&v0, arg1);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft_type::CollectionNft>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_official_nft::CollectionOfficialNft>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_official_nft::CollectionOfficialNft>>(v3);
        let v5 = CollectionAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<CollectionAdminCap>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<CollectionMaintainer>(create_maintainer(v1, arg1));
    }

    public fun is_image_minted(arg0: vector<u8>, arg1: &CollectionMaintainer) : bool {
        0x2::table::contains<vector<u8>, 0x2::object::ID>(&arg1.minted_images, arg0)
    }

    public fun is_valid_bundle_purchase(arg0: &CollectionMaintainer, arg1: &u64) : bool {
        0x1::vector::contains<u64>(&arg0.bundle_valid_purchases, arg1)
    }

    public entry fun kiosk_and_claim_nfts(arg0: &mut CollectionMaintainer, arg1: &mut 0x2::tx_context::TxContext) {
        assert_maintainer_version(arg0);
        let (v0, v1) = 0x2::kiosk::new(arg1);
        let v2 = v1;
        let v3 = v0;
        assert!(0x2::table::contains<address, vector<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_official_nft::CollectionOfficialNft>>(&arg0.pending_official_nfts, 0x2::tx_context::sender(arg1)), 5);
        let v4 = 0x2::table::remove<address, vector<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_official_nft::CollectionOfficialNft>>(&mut arg0.pending_official_nfts, 0x2::tx_context::sender(arg1));
        while (0x1::vector::length<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_official_nft::CollectionOfficialNft>(&v4) > 0) {
            0x2::kiosk::place<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_official_nft::CollectionOfficialNft>(&mut v3, &v2, 0x1::vector::pop_back<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_official_nft::CollectionOfficialNft>(&mut v4));
        };
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, 0x2::tx_context::sender(arg1));
        0x1::vector::destroy_empty<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_official_nft::CollectionOfficialNft>(v4);
    }

    fun merge_and_split(arg0: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = arg2 * arg1;
        let v1 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0);
        0x2::pay::join_vec<0x2::sui::SUI>(&mut v1, arg0);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&v1);
        assert!(v2 >= v0, v2);
        (0x2::coin::split<0x2::sui::SUI>(&mut v1, v0, arg3), v1)
    }

    entry fun migrate(arg0: &mut CollectionMaintainer, arg1: &CollectionAdminCap) {
        assert!(arg0.version < 1, 11);
        arg0.version = 1;
    }

    fun mint_official_nft(arg0: u64, arg1: address, arg2: 0x2::url::Url, arg3: 0x1::string::String, arg4: address, arg5: u64, arg6: vector<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_official_nft::CollectionOfficialSupporter>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut CollectionMaintainer, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_official_nft::mint(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg10);
        let v1 = 0x2::object::id<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_official_nft::CollectionOfficialNft>(&v0);
        0x2::linked_table::push_back<0x2::object::ID, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_official_nft::CollectionOfficialNftRecord>(&mut arg9.official_nfts, v1, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_official_nft::create_nft_record(v1));
        if (0x2::table::contains<address, vector<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_official_nft::CollectionOfficialNft>>(&arg9.pending_official_nfts, arg1)) {
            0x1::vector::push_back<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_official_nft::CollectionOfficialNft>(0x2::table::borrow_mut<address, vector<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_official_nft::CollectionOfficialNft>>(&mut arg9.pending_official_nfts, arg1), v0);
        } else {
            let v2 = 0x1::vector::empty<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_official_nft::CollectionOfficialNft>();
            0x1::vector::push_back<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_official_nft::CollectionOfficialNft>(&mut v2, v0);
            0x2::table::add<address, vector<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_official_nft::CollectionOfficialNft>>(&mut arg9.pending_official_nfts, arg1, v2);
        };
    }

    fun move_entry_by_support(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::table::Table<0x2::object::ID, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntry>, arg5: &mut 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::CritbitTree<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::CritbitTree<0x2::object::ID>>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::borrow_mut_leaf_by_key<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::CritbitTree<0x2::object::ID>>(arg5, arg1);
        0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::remove_leaf_by_key<0x2::object::ID>(v0, arg2);
        if (0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::is_empty<0x2::object::ID>(v0)) {
            0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::destroy_empty<0x2::object::ID>(0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::remove_leaf_by_key<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::CritbitTree<0x2::object::ID>>(arg5, arg1));
        };
        let v1 = 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::entry_total_support(0x2::table::borrow_mut<0x2::object::ID, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntry>(arg4, arg0));
        let (v2, v3) = 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::find_leaf<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::CritbitTree<0x2::object::ID>>(arg5, v1);
        let v4 = v3;
        if (!v2) {
            v4 = 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::insert_leaf<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::CritbitTree<0x2::object::ID>>(arg5, v1, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::new<0x2::object::ID>(arg6));
        };
        0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::insert_leaf<0x2::object::ID>(0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::borrow_mut_leaf_by_index<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::CritbitTree<0x2::object::ID>>(arg5, v4), arg3, arg0);
    }

    public fun nft_mint_count(arg0: &CollectionMaintainer) : u64 {
        arg0.nft_mint_count
    }

    public fun paused(arg0: &CollectionMaintainer) : bool {
        arg0.paused
    }

    public(friend) fun pay_for_ai_art_ticket(arg0: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg1: &mut CollectionMaintainer, arg2: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<0x2::sui::SUI>) {
        assert_maintainer_version_and_paused(arg1);
        let (v0, v1) = merge_and_split(arg0, 1, arg1.ai_art_ticket_fee, arg2);
        let v2 = v0;
        0x2::coin::put<0x2::sui::SUI>(&mut arg1.balance, v2);
        (0x2::coin::value<0x2::sui::SUI>(&v2), v1)
    }

    public(friend) fun pay_for_ai_title_ticket(arg0: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg1: &mut CollectionMaintainer, arg2: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<0x2::sui::SUI>) {
        assert_maintainer_version_and_paused(arg1);
        let (v0, v1) = merge_and_split(arg0, 1, arg1.ai_title_ticket_fee, arg2);
        let v2 = v0;
        0x2::coin::put<0x2::sui::SUI>(&mut arg1.balance, v2);
        (0x2::coin::value<0x2::sui::SUI>(&v2), v1)
    }

    public(friend) fun pay_for_bundle(arg0: u64, arg1: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg2: &mut CollectionMaintainer, arg3: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<0x2::sui::SUI>) {
        assert_maintainer_version_and_paused(arg2);
        let (v0, v1) = merge_and_split(arg1, arg0, arg2.bundle_fee * (100 - arg2.bundle_discount) / 100, arg3);
        let v2 = v0;
        0x2::coin::put<0x2::sui::SUI>(&mut arg2.balance, v2);
        (0x2::coin::value<0x2::sui::SUI>(&v2), v1)
    }

    public(friend) fun pay_for_nft_mint(arg0: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg1: &mut CollectionMaintainer, arg2: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<0x2::sui::SUI>) {
        let (v0, v1) = merge_and_split(arg0, 1, arg1.nft_mint_fee, arg2);
        let v2 = v0;
        0x2::coin::put<0x2::sui::SUI>(&mut arg1.balance, v2);
        (0x2::coin::value<0x2::sui::SUI>(&v2), v1)
    }

    public entry fun pay_maintainer(arg0: &mut CollectionMaintainer, arg1: &CollectionAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        assert!(v0 > 0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v0, arg2), 0x2::tx_context::sender(arg2));
    }

    public fun pending_elected(arg0: &CollectionMaintainer) : 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntryInfo {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.pending_elected), 4);
        entry(arg0, *0x1::option::borrow<0x2::object::ID>(&arg0.pending_elected))
    }

    public fun pending_official_nfts(arg0: &CollectionMaintainer, arg1: address) : &vector<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_official_nft::CollectionOfficialNft> {
        0x2::table::borrow<address, vector<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_official_nft::CollectionOfficialNft>>(&arg0.pending_official_nfts, arg1)
    }

    public fun public_key(arg0: &CollectionMaintainer) : vector<u8> {
        arg0.public_key
    }

    public(friend) fun remove_entry(arg0: &mut CollectionMaintainer, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft_type::CollectionNft {
        let v0 = 0x2::table::remove<0x2::object::ID, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntry>(&mut arg0.entries, arg2);
        let v1 = 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::entry_total_support(&v0);
        let (v2, v3) = 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::delete_entry(v0);
        let v4 = v2;
        let (v5, v6) = 0x2::kiosk::purchase_with_cap<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft_type::CollectionNft>(arg1, v3, 0x2::coin::zero<0x2::sui::SUI>(arg3));
        let v7 = &mut arg0.scheduled_remove_supporters;
        while (0x2::linked_table::length<address, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntrySupporter>(&v4) > 0) {
            let (_, v9) = 0x2::linked_table::pop_front<address, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntrySupporter>(&mut v4);
            let (_, v11, v12, _, _) = 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::destructure_supporter(v9);
            let v15 = v12;
            if (0x2::linked_table::contains<address, vector<0x2::object::ID>>(v7, v11)) {
                let v16 = 0x2::linked_table::borrow_mut<address, vector<0x2::object::ID>>(v7, v11);
                let (v17, v18) = 0x1::vector::index_of<0x2::object::ID>(v16, &arg2);
                if (v17) {
                    0x1::vector::swap_remove<0x2::object::ID>(v16, v18);
                };
            };
            if (0x2::table::contains<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.accounts, v11)) {
                0x2::balance::join<0x2::sui::SUI>(0x2::table::borrow_mut<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.accounts, v11), v15);
            } else {
                0x2::table::add<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.accounts, v11, v15);
            };
            if (0x2::table::contains<address, 0x2::linked_table::LinkedTable<0x2::object::ID, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntrySupporterInfo>>(&arg0.supports, v11)) {
                0x2::linked_table::remove<0x2::object::ID, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntrySupporterInfo>(0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<0x2::object::ID, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntrySupporterInfo>>(&mut arg0.supports, v11), arg2);
            };
            0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_events::emit_collection_entry_support_removed(arg2, v11, 0x2::balance::value<0x2::sui::SUI>(&v15));
        };
        let v19 = &mut arg0.ordered_support_levels;
        let v20 = 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::borrow_mut_leaf_by_key<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::CritbitTree<0x2::object::ID>>(v19, v1);
        0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::remove_leaf_by_key<0x2::object::ID>(v20, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::entry_overall_support_index(&v0));
        if (0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::is_empty<0x2::object::ID>(v20)) {
            0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::destroy_empty<0x2::object::ID>(0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::remove_leaf_by_key<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::CritbitTree<0x2::object::ID>>(v19, v1));
        };
        0x2::linked_table::destroy_empty<address, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntrySupporter>(v4);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft_type::CollectionNft>(&arg0.nft_transfer_policy, v6);
        v5
    }

    public entry fun remove_scheduled_support(arg0: &mut CollectionMaintainer, arg1: &CollectionAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert_maintainer_version(arg0);
        let v0 = &mut arg0.scheduled_remove_supporters;
        let v1 = 0;
        while (v1 < 0x2::linked_table::length<address, vector<0x2::object::ID>>(v0)) {
            let (v2, v3) = 0x2::linked_table::pop_back<address, vector<0x2::object::ID>>(v0);
            let v4 = v3;
            while (0x1::vector::length<0x2::object::ID>(&v4) > 0) {
                let v5 = 0x1::vector::pop_back<0x2::object::ID>(&mut v4);
                if (0x2::table::contains<0x2::object::ID, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntry>(&arg0.entries, v5)) {
                    let v6 = 0x2::table::borrow_mut<0x2::object::ID, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntry>(&mut arg0.entries, v5);
                    let v7 = 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::entry_total_support(v6);
                    let v8 = 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::entry_overall_support_index(v6);
                    if (0x2::table::contains<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.accounts, v2)) {
                        0x2::balance::join<0x2::sui::SUI>(0x2::table::borrow_mut<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.accounts, v2), 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::remove_supporter(v2, v6));
                    } else {
                        0x2::table::add<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.accounts, v2, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::remove_supporter(v2, v6));
                    };
                    let v9 = &mut arg0.entries;
                    let v10 = &mut arg0.ordered_support_levels;
                    move_entry_by_support(v5, v7, v8, v8, v9, v10, arg2);
                };
                if (0x2::table::contains<address, 0x2::linked_table::LinkedTable<0x2::object::ID, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntrySupporterInfo>>(&arg0.supports, v2)) {
                    0x2::linked_table::remove<0x2::object::ID, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntrySupporterInfo>(0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<0x2::object::ID, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntrySupporterInfo>>(&mut arg0.supports, v2), v5);
                };
            };
            v1 = v1 + 1;
        };
    }

    public fun royalty_balance(arg0: &CollectionMaintainer, arg1: 0x2::object::ID) : u64 {
        0x2::balance::value<0x2::sui::SUI>(0x2::table::borrow<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.royalties, arg1))
    }

    public entry fun schedule_remove_support(arg0: 0x2::object::ID, arg1: &mut CollectionMaintainer, arg2: &mut 0x2::tx_context::TxContext) {
        assert_maintainer_version_and_paused(arg1);
        assert!(0x2::table::contains<0x2::object::ID, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntry>(&arg1.entries, arg0), 3);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::linked_table::contains<address, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntrySupporter>(0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::supporters(0x2::table::borrow<0x2::object::ID, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntry>(&mut arg1.entries, arg0)), v0), 3);
        let v1 = &mut arg1.scheduled_remove_supporters;
        if (0x2::linked_table::contains<address, vector<0x2::object::ID>>(v1, v0)) {
            let v2 = 0x2::linked_table::borrow_mut<address, vector<0x2::object::ID>>(v1, v0);
            assert!(!0x1::vector::contains<0x2::object::ID>(v2, &arg0), 7);
            0x1::vector::push_back<0x2::object::ID>(v2, arg0);
        } else {
            let v3 = 0x1::vector::empty<0x2::object::ID>();
            0x1::vector::push_back<0x2::object::ID>(&mut v3, arg0);
            0x2::linked_table::push_back<address, vector<0x2::object::ID>>(v1, v0, v3);
        };
        0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_events::emit_collection_support_scheduled_for_removal(arg0, v0);
    }

    public entry fun set_paused(arg0: bool, arg1: &mut CollectionMaintainer, arg2: &CollectionAdminCap) {
        arg1.paused = arg0;
    }

    public entry fun set_pending_elected(arg0: &mut CollectionMaintainer, arg1: &CollectionAdminCap) {
        assert_maintainer_version(arg0);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.pending_elected), 9);
        let (_, v1) = 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::max_leaf<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::CritbitTree<0x2::object::ID>>(&arg0.ordered_support_levels);
        let v2 = 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::borrow_mut_leaf_by_index<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::CritbitTree<0x2::object::ID>>(&mut arg0.ordered_support_levels, v1);
        let (_, v4) = 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::min_leaf<0x2::object::ID>(v2);
        if (0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::size<0x2::object::ID>(v2) == 1) {
            0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::destroy_empty<0x2::object::ID>(0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::remove_leaf_by_index<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::CritbitTree<0x2::object::ID>>(&mut arg0.ordered_support_levels, v1));
        };
        arg0.pending_elected = 0x1::option::some<0x2::object::ID>(0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::remove_leaf_by_index<0x2::object::ID>(v2, v4));
    }

    public(friend) fun submit_entry(arg0: 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft_type::CollectionNft, arg1: &mut CollectionMaintainer, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        arg1.entry_count = arg1.entry_count + 1;
        let v0 = arg1.entry_count + arg1.support_count;
        let v1 = 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft_type::id(&arg0);
        0x2::kiosk::place<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft_type::CollectionNft>(arg2, arg3, arg0);
        let (v2, v3) = 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::find_leaf<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::CritbitTree<0x2::object::ID>>(&arg1.ordered_support_levels, 0);
        let v4 = if (v2) {
            0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::remove_leaf_by_index<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::CritbitTree<0x2::object::ID>>(&mut arg1.ordered_support_levels, v3)
        } else {
            0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::new<0x2::object::ID>(arg6)
        };
        0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::insert_leaf<0x2::object::ID>(&mut v4, v0, v1);
        0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::insert_leaf<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::CritbitTree<0x2::object::ID>>(&mut arg1.ordered_support_levels, 0, v4);
        0x2::table::add<0x2::object::ID, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntry>(&mut arg1.entries, v1, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::create(v1, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft_type::image_url(&arg0), 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft_type::title(&arg0), 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft_type::creator(&arg0), v0, arg1.entry_count, arg4, 0x2::kiosk::list_with_purchase_cap<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft_type::CollectionNft>(arg2, arg3, v1, 0, arg6), arg5, arg6));
    }

    public(friend) fun submit_entry_and_pay(arg0: 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft_type::CollectionNft, arg1: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg2: &mut CollectionMaintainer, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let (v0, v1) = merge_and_split(arg1, 1, arg2.entry_fee, arg6);
        let v2 = v0;
        0x2::coin::put<0x2::sui::SUI>(&mut arg2.balance, v2);
        submit_entry(arg0, arg2, arg3, arg4, arg5, 0x2::coin::value<0x2::sui::SUI>(&v2), arg6);
        v1
    }

    public entry fun support(arg0: 0x2::object::ID, arg1: u64, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: &mut CollectionMaintainer, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_maintainer_version_and_paused(arg3);
        assert!(arg1 > 0, 2);
        assert!(arg1 % 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::min_support_amount() == 0, 2);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = &mut arg3.scheduled_remove_supporters;
        if (0x2::linked_table::contains<address, vector<0x2::object::ID>>(v1, v0)) {
            assert!(!0x1::vector::contains<0x2::object::ID>(0x2::linked_table::borrow<address, vector<0x2::object::ID>>(v1, v0), &arg0), 7);
        };
        arg3.support_count = arg3.support_count + 1;
        let v2 = arg3.entry_count + arg3.support_count;
        let v3 = 0x2::table::borrow_mut<0x2::object::ID, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntry>(&mut arg3.entries, arg0);
        if (0x2::table::contains<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg3.accounts, v0)) {
            0x1::vector::push_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::table::remove<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg3.accounts, v0), arg5));
        };
        let (v4, v5) = merge_and_split(arg2, 1, arg3.support_fee, arg5);
        let v6 = v4;
        0x2::coin::put<0x2::sui::SUI>(&mut arg3.balance, v6);
        let v7 = 0x1::vector::empty<0x2::coin::Coin<0x2::sui::SUI>>();
        0x1::vector::push_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut v7, v5);
        let (v8, v9) = merge_and_split(v7, 1, arg1, arg5);
        if (0x2::linked_table::contains<address, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntrySupporter>(0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::supporters(v3), v0)) {
            0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::increase_support(v3, v8, v0, v2, arg4, 0x2::linked_table::borrow_mut<0x2::object::ID, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntrySupporterInfo>(0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<0x2::object::ID, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntrySupporterInfo>>(&mut arg3.supports, v0), arg0), 0x2::coin::value<0x2::sui::SUI>(&v6));
        } else if (0x2::table::contains<address, 0x2::linked_table::LinkedTable<0x2::object::ID, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntrySupporterInfo>>(&arg3.supports, v0)) {
            0x2::linked_table::push_back<0x2::object::ID, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntrySupporterInfo>(0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<0x2::object::ID, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntrySupporterInfo>>(&mut arg3.supports, v0), arg0, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::add_supporter(v3, v0, v8, v2, 0x2::coin::value<0x2::sui::SUI>(&v6), arg4));
        } else {
            let v10 = 0x2::linked_table::new<0x2::object::ID, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntrySupporterInfo>(arg5);
            0x2::linked_table::push_back<0x2::object::ID, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntrySupporterInfo>(&mut v10, arg0, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::add_supporter(v3, v0, v8, v2, 0x2::coin::value<0x2::sui::SUI>(&v6), arg4));
            0x2::table::add<address, 0x2::linked_table::LinkedTable<0x2::object::ID, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntrySupporterInfo>>(&mut arg3.supports, v0, v10);
        };
        let v11 = &mut arg3.entries;
        let v12 = &mut arg3.ordered_support_levels;
        move_entry_by_support(arg0, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::entry_total_support(v3), 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::entry_overall_support_index(v3), v2, v11, v12, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v9, 0x2::tx_context::sender(arg5));
    }

    public fun support_count(arg0: &CollectionMaintainer) : u64 {
        arg0.support_count
    }

    public fun supports(arg0: &CollectionMaintainer, arg1: address) : vector<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntrySupporterInfo> {
        if (!0x2::table::contains<address, 0x2::linked_table::LinkedTable<0x2::object::ID, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntrySupporterInfo>>(&arg0.supports, arg1)) {
            return 0x1::vector::empty<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntrySupporterInfo>()
        };
        let v0 = 0x2::table::borrow<address, 0x2::linked_table::LinkedTable<0x2::object::ID, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntrySupporterInfo>>(&arg0.supports, arg1);
        let v1 = 0x1::vector::empty<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntrySupporterInfo>();
        let v2 = 0x2::linked_table::front<0x2::object::ID, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntrySupporterInfo>(v0);
        while (0x1::option::is_some<0x2::object::ID>(v2)) {
            let v3 = *0x1::option::borrow<0x2::object::ID>(v2);
            0x1::vector::push_back<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntrySupporterInfo>(&mut v1, *0x2::linked_table::borrow<0x2::object::ID, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntrySupporterInfo>(v0, v3));
            v2 = 0x2::linked_table::next<0x2::object::ID, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntrySupporterInfo>(v0, v3);
        };
        v1
    }

    public fun ticket_units_for_ai_art_ticket(arg0: &CollectionMaintainer) : u64 {
        arg0.ai_art_ticket_fee / arg0.bundle_fee
    }

    public fun ticket_units_for_ai_title_ticket(arg0: &CollectionMaintainer) : u64 {
        arg0.ai_art_ticket_fee / arg0.bundle_fee
    }

    public fun ticket_units_for_entry(arg0: &CollectionMaintainer) : u64 {
        arg0.entry_fee / arg0.bundle_fee
    }

    public fun ticket_units_for_nft_mint(arg0: &CollectionMaintainer) : u64 {
        arg0.nft_mint_fee / arg0.bundle_fee
    }

    public fun top_entries(arg0: &CollectionMaintainer, arg1: u64) : vector<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntryInfo> {
        let v0 = 0;
        let (v1, v2) = 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::max_leaf<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::CritbitTree<0x2::object::ID>>(&arg0.ordered_support_levels);
        let v3 = v2;
        let v4 = v1;
        let v5 = 0x1::vector::empty<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntryInfo>();
        loop {
            let v6 = 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::borrow_leaf_by_index<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::CritbitTree<0x2::object::ID>>(&arg0.ordered_support_levels, v3);
            let (v7, v8) = 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::min_leaf<0x2::object::ID>(v6);
            let v9 = v8;
            let v10 = v7;
            let v11 = 0;
            loop {
                0x1::vector::push_back<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntryInfo>(&mut v5, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::entry_to_entry_info(0x2::table::borrow<0x2::object::ID, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntry>(&arg0.entries, *0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::borrow_leaf_by_index<0x2::object::ID>(v6, v9))));
                v11 = v11 + 1;
                if (v11 >= 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::size<0x2::object::ID>(v6) || 0x1::vector::length<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_entry_type::CollectionEntryInfo>(&v5) >= arg1) {
                    break
                };
                let (v12, v13) = 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::next_leaf<0x2::object::ID>(v6, v10);
                v9 = v13;
                v10 = v12;
            };
            v0 = v0 + 1;
            if (v0 >= 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::size<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::CritbitTree<0x2::object::ID>>(&arg0.ordered_support_levels)) {
                break
            };
            let (v14, v15) = 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::previous_leaf<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::critbit::CritbitTree<0x2::object::ID>>(&arg0.ordered_support_levels, v4);
            v3 = v15;
            v4 = v14;
        };
        v5
    }

    public entry fun update_public_key(arg0: vector<u8>, arg1: &mut CollectionMaintainer, arg2: &CollectionAdminCap) {
        assert_maintainer_version(arg1);
        arg1.public_key = arg0;
    }

    public fun version(arg0: &CollectionMaintainer) : u64 {
        arg0.version
    }

    public entry fun withdraw_account(arg0: &mut CollectionMaintainer, arg1: &mut 0x2::tx_context::TxContext) {
        assert_maintainer_version(arg0);
        assert!(0x2::table::contains<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.accounts, 0x2::tx_context::sender(arg1)), 1);
        let v0 = 0x2::table::remove<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.accounts, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v0, arg1), 0x2::tx_context::sender(arg1));
        0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_events::emit_account_balance_withdrawn(0x2::tx_context::sender(arg1), 0x2::balance::value<0x2::sui::SUI>(&v0));
    }

    public entry fun withdraw_royalties(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &mut CollectionMaintainer, arg4: &mut 0x2::tx_context::TxContext) {
        assert_maintainer_version(arg3);
        assert!(0x2::kiosk::has_access(arg1, arg2), 6);
        assert!(0x2::kiosk::has_item(arg1, arg0), 6);
        withdraw_royalties_for_nft_id(arg0, arg3, arg4);
    }

    public entry fun withdraw_royalties_direct(arg0: &0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_official_nft::CollectionOfficialNft, arg1: &mut CollectionMaintainer, arg2: &mut 0x2::tx_context::TxContext) {
        assert_maintainer_version(arg1);
        withdraw_royalties_for_nft_id(0x2::object::id<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_official_nft::CollectionOfficialNft>(arg0), arg1, arg2);
    }

    public(friend) fun withdraw_royalties_for_nft_id(arg0: 0x2::object::ID, arg1: &mut CollectionMaintainer, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>(&arg1.royalties, arg0), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::table::remove<0x2::object::ID, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg1.royalties, arg0), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

