module 0xddd0dccbab2f8618350a60e33dbced2a52f3e3bc6b400cea7a12a4866cf46ea8::protocol {
    struct Content has copy, drop, store {
        title: 0x1::string::String,
        pinned: bool,
    }

    struct DummyWallet has key {
        id: 0x2::object::UID,
        balance: 0x2::coin::Coin<0xc02af64372bf36dd8c1eae7361281bb4fb32af104c18e4af8b8d2e55f1cd0d1e::dummy::DUMMY>,
        owner: address,
    }

    struct DummyNFT has store, key {
        id: 0x2::object::UID,
        dummy_nft_name: 0x1::string::String,
        handle: 0x1::string::String,
        dummy_nft_description: 0x1::string::String,
        dummy_wallet: address,
        url: 0x1::string::String,
        content_links: 0x2::table::Table<0x1::string::String, Content>,
    }

    struct MintDummyNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct DummyNFTList has key {
        id: 0x2::object::UID,
        version: u64,
        list: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
    }

    struct PROTOCOL has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: DummyNFT, arg1: address) {
        0x2::transfer::public_transfer<DummyNFT>(arg0, arg1);
    }

    public fun add_links(arg0: &mut DummyNFT, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>, arg3: vector<bool>, arg4: &mut 0xddd0dccbab2f8618350a60e33dbced2a52f3e3bc6b400cea7a12a4866cf46ea8::admin::RewardPool, arg5: &mut DummyWallet, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg1)) {
            let v1 = Content{
                title  : *0x1::vector::borrow<0x1::string::String>(&arg2, v0),
                pinned : *0x1::vector::borrow<bool>(&arg3, v0),
            };
            0x2::table::add<0x1::string::String, Content>(&mut arg0.content_links, *0x1::vector::borrow<0x1::string::String>(&arg1, v0), v1);
            v0 = v0 + 1;
        };
        let v2 = 0xddd0dccbab2f8618350a60e33dbced2a52f3e3bc6b400cea7a12a4866cf46ea8::admin::get_mutable_reference_to_reward_balance(arg4);
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, 0x1::string::utf8(b"link_cap_dummy"))) {
            let v3 = 0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(&mut arg0.id, 0x1::string::utf8(b"link_cap_dummy"));
            if (*v3 < 300) {
                if (*v3 + 0x1::vector::length<0x1::string::String>(&arg1) >= 300) {
                    *v3 = *v3 + 300 - *v3;
                    0x2::coin::put<0xc02af64372bf36dd8c1eae7361281bb4fb32af104c18e4af8b8d2e55f1cd0d1e::dummy::DUMMY>(0x2::coin::balance_mut<0xc02af64372bf36dd8c1eae7361281bb4fb32af104c18e4af8b8d2e55f1cd0d1e::dummy::DUMMY>(&mut arg5.balance), 0x2::coin::take<0xc02af64372bf36dd8c1eae7361281bb4fb32af104c18e4af8b8d2e55f1cd0d1e::dummy::DUMMY>(v2, (300 - *v3) * 100000000, arg6));
                } else {
                    *v3 = *v3 + 0x1::vector::length<0x1::string::String>(&arg1);
                    0x2::coin::put<0xc02af64372bf36dd8c1eae7361281bb4fb32af104c18e4af8b8d2e55f1cd0d1e::dummy::DUMMY>(0x2::coin::balance_mut<0xc02af64372bf36dd8c1eae7361281bb4fb32af104c18e4af8b8d2e55f1cd0d1e::dummy::DUMMY>(&mut arg5.balance), 0x2::coin::take<0xc02af64372bf36dd8c1eae7361281bb4fb32af104c18e4af8b8d2e55f1cd0d1e::dummy::DUMMY>(v2, 0x1::vector::length<0x1::string::String>(&arg1) * 100000000, arg6));
                };
            };
        } else {
            0x2::dynamic_field::add<0x1::string::String, u64>(&mut arg0.id, 0x1::string::utf8(b"link_cap_dummy"), 0x1::vector::length<0x1::string::String>(&arg1));
            0x2::coin::put<0xc02af64372bf36dd8c1eae7361281bb4fb32af104c18e4af8b8d2e55f1cd0d1e::dummy::DUMMY>(0x2::coin::balance_mut<0xc02af64372bf36dd8c1eae7361281bb4fb32af104c18e4af8b8d2e55f1cd0d1e::dummy::DUMMY>(&mut arg5.balance), 0x2::coin::take<0xc02af64372bf36dd8c1eae7361281bb4fb32af104c18e4af8b8d2e55f1cd0d1e::dummy::DUMMY>(v2, 0x1::vector::length<0x1::string::String>(&arg1) * 100000000, arg6));
        };
    }

    public fun calculate_mint_fee(arg0: 0x1::string::String, arg1: &0xddd0dccbab2f8618350a60e33dbced2a52f3e3bc6b400cea7a12a4866cf46ea8::admin::PriceModel, arg2: &0xddd0dccbab2f8618350a60e33dbced2a52f3e3bc6b400cea7a12a4866cf46ea8::admin::GoldList, arg3: &0xddd0dccbab2f8618350a60e33dbced2a52f3e3bc6b400cea7a12a4866cf46ea8::admin::ReservedDummyNFTList, arg4: &0xddd0dccbab2f8618350a60e33dbced2a52f3e3bc6b400cea7a12a4866cf46ea8::admin::FrequentWordList) : u64 {
        1000
    }

    public fun depositFromDummyWalletToDummyWallet(arg0: &mut DummyWallet, arg1: &mut DummyWallet, arg2: &mut DummyNFT, arg3: u64, arg4: &mut 0xddd0dccbab2f8618350a60e33dbced2a52f3e3bc6b400cea7a12a4866cf46ea8::admin::RewardPool, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::uid_to_address(&arg2.id) == arg1.owner, 42);
        0x2::coin::put<0xc02af64372bf36dd8c1eae7361281bb4fb32af104c18e4af8b8d2e55f1cd0d1e::dummy::DUMMY>(0x2::coin::balance_mut<0xc02af64372bf36dd8c1eae7361281bb4fb32af104c18e4af8b8d2e55f1cd0d1e::dummy::DUMMY>(&mut arg0.balance), 0x2::coin::take<0xc02af64372bf36dd8c1eae7361281bb4fb32af104c18e4af8b8d2e55f1cd0d1e::dummy::DUMMY>(0x2::coin::balance_mut<0xc02af64372bf36dd8c1eae7361281bb4fb32af104c18e4af8b8d2e55f1cd0d1e::dummy::DUMMY>(&mut arg1.balance), arg3, arg5));
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg2.id, 0x1::string::utf8(b"transfer_cap_dummy"))) {
            let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(&mut arg2.id, 0x1::string::utf8(b"transfer_cap_dummy"));
            if (*v0 <= 1000) {
                *v0 = *v0 + 10;
                0x2::coin::put<0xc02af64372bf36dd8c1eae7361281bb4fb32af104c18e4af8b8d2e55f1cd0d1e::dummy::DUMMY>(0x2::coin::balance_mut<0xc02af64372bf36dd8c1eae7361281bb4fb32af104c18e4af8b8d2e55f1cd0d1e::dummy::DUMMY>(&mut arg1.balance), 0x2::coin::take<0xc02af64372bf36dd8c1eae7361281bb4fb32af104c18e4af8b8d2e55f1cd0d1e::dummy::DUMMY>(0xddd0dccbab2f8618350a60e33dbced2a52f3e3bc6b400cea7a12a4866cf46ea8::admin::get_mutable_reference_to_reward_balance(arg4), 1000000000, arg5));
            };
        } else {
            0x2::dynamic_field::add<0x1::string::String, u64>(&mut arg2.id, 0x1::string::utf8(b"transfer_cap_dummy"), 10);
            0x2::coin::put<0xc02af64372bf36dd8c1eae7361281bb4fb32af104c18e4af8b8d2e55f1cd0d1e::dummy::DUMMY>(0x2::coin::balance_mut<0xc02af64372bf36dd8c1eae7361281bb4fb32af104c18e4af8b8d2e55f1cd0d1e::dummy::DUMMY>(&mut arg1.balance), 0x2::coin::take<0xc02af64372bf36dd8c1eae7361281bb4fb32af104c18e4af8b8d2e55f1cd0d1e::dummy::DUMMY>(0xddd0dccbab2f8618350a60e33dbced2a52f3e3bc6b400cea7a12a4866cf46ea8::admin::get_mutable_reference_to_reward_balance(arg4), 1000000000, arg5));
        };
    }

    public fun depositToDummyWallet(arg0: &mut DummyWallet, arg1: 0x2::coin::Coin<0xc02af64372bf36dd8c1eae7361281bb4fb32af104c18e4af8b8d2e55f1cd0d1e::dummy::DUMMY>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::put<0xc02af64372bf36dd8c1eae7361281bb4fb32af104c18e4af8b8d2e55f1cd0d1e::dummy::DUMMY>(0x2::coin::balance_mut<0xc02af64372bf36dd8c1eae7361281bb4fb32af104c18e4af8b8d2e55f1cd0d1e::dummy::DUMMY>(&mut arg0.balance), arg1);
    }

    public fun get_dummy_nft_object_id(arg0: 0x1::string::String, arg1: &DummyNFTList) : 0x2::object::ID {
        let v0 = 0xddd0dccbab2f8618350a60e33dbced2a52f3e3bc6b400cea7a12a4866cf46ea8::validation::convert_dummy_nft_name_to_handle(0x1::string::as_bytes(&arg0));
        assert!(0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg1.list, 0x1::string::utf8(v0)), 6);
        *0x2::table::borrow<0x1::string::String, 0x2::object::ID>(&arg1.list, 0x1::string::utf8(v0))
    }

    fun init(arg0: PROTOCOL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{dummy_nft_name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://www.dummy.network/nft/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{dummy_nft_description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://www.dummy.network/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"DUMMY"));
        let v4 = 0x2::package::claim<PROTOCOL>(arg0, arg1);
        let (v5, v6) = 0x2::transfer_policy::new<DummyNFT>(&v4, arg1);
        let v7 = v6;
        let v8 = v5;
        0xddd0dccbab2f8618350a60e33dbced2a52f3e3bc6b400cea7a12a4866cf46ea8::royalty_policy::new_royalty_policy<DummyNFT>(&mut v8, &v7, 500, 0x2::tx_context::sender(arg1));
        let v9 = 0x2::display::new_with_fields<DummyNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<DummyNFT>(&mut v9);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<DummyNFT>>(v9, 0x2::tx_context::sender(arg1));
        let v10 = DummyNFTList{
            id      : 0x2::object::new(arg1),
            version : 1,
            list    : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg1),
        };
        0x2::transfer::share_object<DummyNFTList>(v10);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<DummyNFT>>(v8);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<DummyNFT>>(v7, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut DummyNFTList, arg4: &0xddd0dccbab2f8618350a60e33dbced2a52f3e3bc6b400cea7a12a4866cf46ea8::admin::ReservedDummyNFTList, arg5: &0xddd0dccbab2f8618350a60e33dbced2a52f3e3bc6b400cea7a12a4866cf46ea8::admin::BlackList, arg6: &0xddd0dccbab2f8618350a60e33dbced2a52f3e3bc6b400cea7a12a4866cf46ea8::admin::FrequentWordList, arg7: &0xddd0dccbab2f8618350a60e33dbced2a52f3e3bc6b400cea7a12a4866cf46ea8::admin::BlockList, arg8: &0xddd0dccbab2f8618350a60e33dbced2a52f3e3bc6b400cea7a12a4866cf46ea8::admin::PriceModel, arg9: &0xddd0dccbab2f8618350a60e33dbced2a52f3e3bc6b400cea7a12a4866cf46ea8::admin::GoldList, arg10: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg11: u64, arg12: &mut 0xddd0dccbab2f8618350a60e33dbced2a52f3e3bc6b400cea7a12a4866cf46ea8::admin::ContractManager, arg13: &mut 0xddd0dccbab2f8618350a60e33dbced2a52f3e3bc6b400cea7a12a4866cf46ea8::admin::RewardPool, arg14: &mut 0xddd0dccbab2f8618350a60e33dbced2a52f3e3bc6b400cea7a12a4866cf46ea8::admin::Dummy2Pool, arg15: 0x1::string::String, arg16: &mut 0xddd0dccbab2f8618350a60e33dbced2a52f3e3bc6b400cea7a12a4866cf46ea8::admin::CouponInfo, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xddd0dccbab2f8618350a60e33dbced2a52f3e3bc6b400cea7a12a4866cf46ea8::validation::convert_dummy_nft_name_to_handle(0x1::string::as_bytes(&arg0));
        if (arg15 == 0x1::string::utf8(b"") || 0xddd0dccbab2f8618350a60e33dbced2a52f3e3bc6b400cea7a12a4866cf46ea8::admin::check_is_coupon_special(arg15, arg16) == false) {
            assert!(0x1::string::length(&arg0) >= 5, 0);
        };
        assert!(0x1::string::length(&arg0) <= 63, 0);
        assert!(0xddd0dccbab2f8618350a60e33dbced2a52f3e3bc6b400cea7a12a4866cf46ea8::validation::query_block_dummy_nft(arg7, 0x1::string::utf8(v0)) == false, 1);
        assert!(0xddd0dccbab2f8618350a60e33dbced2a52f3e3bc6b400cea7a12a4866cf46ea8::validation::query_black_list_dummy_nft(arg5, 0x1::string::utf8(v0)) == false, 2);
        assert!(0xddd0dccbab2f8618350a60e33dbced2a52f3e3bc6b400cea7a12a4866cf46ea8::validation::hasMultipleSpacesBetweenChar(arg0) == false, 3);
        assert!(0xddd0dccbab2f8618350a60e33dbced2a52f3e3bc6b400cea7a12a4866cf46ea8::validation::isValidName(arg0), 4);
        let v1 = 0x2::tx_context::sender(arg18);
        purchase_dummy2(arg11, arg14, arg18);
        let v2 = 0x2::object::new(arg18);
        let v3 = DummyWallet{
            id      : 0x2::object::new(arg18),
            balance : 0x2::coin::zero<0xc02af64372bf36dd8c1eae7361281bb4fb32af104c18e4af8b8d2e55f1cd0d1e::dummy::DUMMY>(arg18),
            owner   : 0x2::object::uid_to_address(&v2),
        };
        let v4 = DummyNFT{
            id                    : v2,
            dummy_nft_name        : arg0,
            handle                : 0x1::string::utf8(v0),
            dummy_nft_description : arg1,
            dummy_wallet          : 0x2::object::uid_to_address(&v3.id),
            url                   : arg2,
            content_links         : 0x2::table::new<0x1::string::String, Content>(arg18),
        };
        let v5 = MintDummyNFTEvent{
            object_id : 0x2::object::uid_to_inner(&v4.id),
            creator   : v1,
            name      : v4.dummy_nft_name,
        };
        0x2::event::emit<MintDummyNFTEvent>(v5);
        0x2::coin::put<0xc02af64372bf36dd8c1eae7361281bb4fb32af104c18e4af8b8d2e55f1cd0d1e::dummy::DUMMY>(0x2::coin::balance_mut<0xc02af64372bf36dd8c1eae7361281bb4fb32af104c18e4af8b8d2e55f1cd0d1e::dummy::DUMMY>(&mut v3.balance), 0x2::coin::take<0xc02af64372bf36dd8c1eae7361281bb4fb32af104c18e4af8b8d2e55f1cd0d1e::dummy::DUMMY>(0xddd0dccbab2f8618350a60e33dbced2a52f3e3bc6b400cea7a12a4866cf46ea8::admin::get_mutable_reference_to_reward_balance(arg13), 10000000000, arg18));
        0x2::transfer::share_object<DummyWallet>(v3);
        registry(arg3, 0x1::string::utf8(v0), 0x2::object::uid_to_inner(&v4.id));
        0x2::transfer::transfer<DummyNFT>(v4, v1);
    }

    fun purchase_dummy2(arg0: u64, arg1: &mut 0xddd0dccbab2f8618350a60e33dbced2a52f3e3bc6b400cea7a12a4866cf46ea8::admin::Dummy2Pool, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd3f33f40648efbb658fdf85edf16419c096fc467e6fa6f91b5e80fb1c082ea8a::dummy2::DUMMY2>>(0xddd0dccbab2f8618350a60e33dbced2a52f3e3bc6b400cea7a12a4866cf46ea8::admin::withdraw_dummy2(arg1, arg0 * 5000000000, arg2), 0x2::tx_context::sender(arg2));
    }

    public fun query_dummy_nft_flag_status(arg0: &0xddd0dccbab2f8618350a60e33dbced2a52f3e3bc6b400cea7a12a4866cf46ea8::admin::BlackList, arg1: &0xddd0dccbab2f8618350a60e33dbced2a52f3e3bc6b400cea7a12a4866cf46ea8::admin::BlockList, arg2: &DummyNFTList, arg3: 0x1::string::String) : u8 {
        let v0 = 0xddd0dccbab2f8618350a60e33dbced2a52f3e3bc6b400cea7a12a4866cf46ea8::validation::convert_dummy_nft_name_to_handle(0x1::string::as_bytes(&arg3));
        if (0x2::table::contains<0x1::string::String, bool>(0xddd0dccbab2f8618350a60e33dbced2a52f3e3bc6b400cea7a12a4866cf46ea8::admin::get_reference_from_black_list(arg0), 0x1::string::utf8(v0))) {
            1
        } else if (0x2::table::contains<0x1::string::String, bool>(0xddd0dccbab2f8618350a60e33dbced2a52f3e3bc6b400cea7a12a4866cf46ea8::admin::get_reference_from_block_list(arg1), 0x1::string::utf8(v0))) {
            2
        } else if (0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg2.list, 0x1::string::utf8(v0))) {
            3
        } else {
            0
        }
    }

    fun registry(arg0: &mut DummyNFTList, arg1: 0x1::string::String, arg2: 0x2::object::ID) {
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg0.list, arg1, arg2);
    }

    public fun transferDummyToAddress(arg0: &mut DummyWallet, arg1: &mut DummyNFT, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::uid_to_address(&arg1.id) == arg0.owner, 42);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc02af64372bf36dd8c1eae7361281bb4fb32af104c18e4af8b8d2e55f1cd0d1e::dummy::DUMMY>>(0x2::coin::take<0xc02af64372bf36dd8c1eae7361281bb4fb32af104c18e4af8b8d2e55f1cd0d1e::dummy::DUMMY>(0x2::coin::balance_mut<0xc02af64372bf36dd8c1eae7361281bb4fb32af104c18e4af8b8d2e55f1cd0d1e::dummy::DUMMY>(&mut arg0.balance), arg2, arg4), arg3);
    }

    public fun update_links(arg0: &mut DummyNFT, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: vector<bool>, arg5: &mut 0xddd0dccbab2f8618350a60e33dbced2a52f3e3bc6b400cea7a12a4866cf46ea8::admin::RewardPool, arg6: &mut DummyWallet, arg7: &mut 0x2::tx_context::TxContext) {
        if (0x1::vector::length<0x1::string::String>(&arg1) > 0) {
            let v0 = 0;
            while (v0 < 0x1::vector::length<0x1::string::String>(&arg1)) {
                let v1 = *0x1::vector::borrow<0x1::string::String>(&arg1, v0);
                if (0x2::table::contains<0x1::string::String, Content>(&arg0.content_links, v1)) {
                    0x2::table::remove<0x1::string::String, Content>(&mut arg0.content_links, v1);
                };
                v0 = v0 + 1;
            };
        };
        if (0x1::vector::length<0x1::string::String>(&arg3) > 0) {
            let v2 = 0;
            while (v2 < 0x1::vector::length<0x1::string::String>(&arg2)) {
                let v3 = *0x1::vector::borrow<0x1::string::String>(&arg2, v2);
                if (0x2::table::contains<0x1::string::String, Content>(&arg0.content_links, v3)) {
                    let v4 = Content{
                        title  : *0x1::vector::borrow<0x1::string::String>(&arg3, v2),
                        pinned : *0x1::vector::borrow<bool>(&arg4, v2),
                    };
                    *0x2::table::borrow_mut<0x1::string::String, Content>(&mut arg0.content_links, v3) = v4;
                } else {
                    let v5 = Content{
                        title  : *0x1::vector::borrow<0x1::string::String>(&arg3, v2),
                        pinned : *0x1::vector::borrow<bool>(&arg4, v2),
                    };
                    0x2::table::add<0x1::string::String, Content>(&mut arg0.content_links, v3, v5);
                    let v6 = 0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(&mut arg0.id, 0x1::string::utf8(b"link_cap_dummy"));
                    if (*v6 < 300) {
                        *v6 = *v6 + 1;
                        0x2::coin::put<0xc02af64372bf36dd8c1eae7361281bb4fb32af104c18e4af8b8d2e55f1cd0d1e::dummy::DUMMY>(0x2::coin::balance_mut<0xc02af64372bf36dd8c1eae7361281bb4fb32af104c18e4af8b8d2e55f1cd0d1e::dummy::DUMMY>(&mut arg6.balance), 0x2::coin::take<0xc02af64372bf36dd8c1eae7361281bb4fb32af104c18e4af8b8d2e55f1cd0d1e::dummy::DUMMY>(0xddd0dccbab2f8618350a60e33dbced2a52f3e3bc6b400cea7a12a4866cf46ea8::admin::get_mutable_reference_to_reward_balance(arg5), 100000000, arg7));
                    };
                };
                v2 = v2 + 1;
            };
        };
    }

    public fun withdrawlFromDummyWallet(arg0: &mut DummyNFT, arg1: &mut DummyWallet, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::uid_to_address(&arg0.id) == arg1.owner, 42);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc02af64372bf36dd8c1eae7361281bb4fb32af104c18e4af8b8d2e55f1cd0d1e::dummy::DUMMY>>(0x2::coin::take<0xc02af64372bf36dd8c1eae7361281bb4fb32af104c18e4af8b8d2e55f1cd0d1e::dummy::DUMMY>(0x2::coin::balance_mut<0xc02af64372bf36dd8c1eae7361281bb4fb32af104c18e4af8b8d2e55f1cd0d1e::dummy::DUMMY>(&mut arg1.balance), arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

