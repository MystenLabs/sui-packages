module 0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::protocol {
    struct Content has copy, drop, store {
        title: 0x1::string::String,
        pinned: bool,
    }

    struct DummyWallet has key {
        id: 0x2::object::UID,
        balance: 0x2::coin::Coin<0xde6e090a0ff9c83a69c0d102fbe4f340de89743203e847c4a9542db1cd4d6132::dummy::DUMMY>,
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

    public fun add_links(arg0: &mut DummyNFT, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>, arg3: vector<bool>, arg4: &mut 0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::RewardPool, arg5: &mut DummyWallet, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg1)) {
            let v1 = Content{
                title  : *0x1::vector::borrow<0x1::string::String>(&arg2, v0),
                pinned : *0x1::vector::borrow<bool>(&arg3, v0),
            };
            0x2::table::add<0x1::string::String, Content>(&mut arg0.content_links, *0x1::vector::borrow<0x1::string::String>(&arg1, v0), v1);
            v0 = v0 + 1;
        };
        let v2 = 0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_mutable_reference_to_reward_balance(arg4);
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, 0x1::string::utf8(b"link_cap_dummy"))) {
            let v3 = 0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(&mut arg0.id, 0x1::string::utf8(b"link_cap_dummy"));
            if (*v3 < 300) {
                if (*v3 + 0x1::vector::length<0x1::string::String>(&arg1) >= 300) {
                    *v3 = *v3 + 300 - *v3;
                    0x2::coin::put<0xde6e090a0ff9c83a69c0d102fbe4f340de89743203e847c4a9542db1cd4d6132::dummy::DUMMY>(0x2::coin::balance_mut<0xde6e090a0ff9c83a69c0d102fbe4f340de89743203e847c4a9542db1cd4d6132::dummy::DUMMY>(&mut arg5.balance), 0x2::coin::take<0xde6e090a0ff9c83a69c0d102fbe4f340de89743203e847c4a9542db1cd4d6132::dummy::DUMMY>(v2, (300 - *v3) * 100000000, arg6));
                } else {
                    *v3 = *v3 + 0x1::vector::length<0x1::string::String>(&arg1);
                    0x2::coin::put<0xde6e090a0ff9c83a69c0d102fbe4f340de89743203e847c4a9542db1cd4d6132::dummy::DUMMY>(0x2::coin::balance_mut<0xde6e090a0ff9c83a69c0d102fbe4f340de89743203e847c4a9542db1cd4d6132::dummy::DUMMY>(&mut arg5.balance), 0x2::coin::take<0xde6e090a0ff9c83a69c0d102fbe4f340de89743203e847c4a9542db1cd4d6132::dummy::DUMMY>(v2, 0x1::vector::length<0x1::string::String>(&arg1) * 100000000, arg6));
                };
            };
        } else {
            0x2::dynamic_field::add<0x1::string::String, u64>(&mut arg0.id, 0x1::string::utf8(b"link_cap_dummy"), 0x1::vector::length<0x1::string::String>(&arg1));
            0x2::coin::put<0xde6e090a0ff9c83a69c0d102fbe4f340de89743203e847c4a9542db1cd4d6132::dummy::DUMMY>(0x2::coin::balance_mut<0xde6e090a0ff9c83a69c0d102fbe4f340de89743203e847c4a9542db1cd4d6132::dummy::DUMMY>(&mut arg5.balance), 0x2::coin::take<0xde6e090a0ff9c83a69c0d102fbe4f340de89743203e847c4a9542db1cd4d6132::dummy::DUMMY>(v2, 0x1::vector::length<0x1::string::String>(&arg1) * 100000000, arg6));
        };
    }

    public fun calculate_mint_fee(arg0: 0x1::string::String, arg1: &0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::PriceModel, arg2: &0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::GoldList, arg3: &0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::ReservedDummyNFTList, arg4: &0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::FrequentWordList) : u64 {
        let v0 = *0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_reference_to_base_price(arg1) / 10;
        let v1 = 0x1::string::utf8(0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::validation::convert_dummy_nft_name_to_handle(0x1::string::as_bytes(&arg0)));
        if (0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::validation::query_gold_dummy_nft(arg2, v1)) {
            v0 = *0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_reference_to_base_price(arg1) * *0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_reference_to_gold_multipliers(arg1);
        } else if (0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::validation::query_resereve_dummy_nft(arg3, v1)) {
            v0 = *0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_reference_to_base_price(arg1) * *0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_reference_to_premium_multipliers(arg1);
        } else {
            let v2 = 0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::validation::get_word_list(arg0);
            let v3 = 0x1::vector::length<0x1::string::String>(&v2);
            let v4 = 0;
            let v5 = 0;
            let v6 = 0;
            let v7 = 0;
            let v8 = 0;
            let v9 = 0;
            let v10 = 0;
            let v11 = 0;
            let v12 = 0;
            while (v12 < v3) {
                let v13 = *0x1::vector::borrow<0x1::string::String>(&v2, v12);
                if (0x1::vector::contains<0x1::string::String>(0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_reference_from_tier_One(arg4), &v13)) {
                    v4 = v4 + 1;
                } else if (0x1::vector::contains<0x1::string::String>(0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_reference_from_tier_Two(arg4), &v13)) {
                    v5 = v5 + 1;
                } else if (0x1::vector::contains<0x1::string::String>(0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_reference_from_tier_Three(arg4), &v13)) {
                    v6 = v6 + 1;
                } else if (0x1::vector::contains<0x1::string::String>(0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_reference_from_tier_Four(arg4), &v13)) {
                    v7 = v7 + 1;
                } else if (0x1::vector::contains<0x1::string::String>(0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_reference_from_tier_Five(arg4), &v13)) {
                    v8 = v8 + 1;
                } else if (0x1::vector::contains<0x1::string::String>(0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_reference_from_tier_Six(arg4), &v13)) {
                    v9 = v9 + 1;
                } else if (0x1::vector::length<u8>(0x1::string::as_bytes(&v13)) == 5) {
                    v10 = v10 + 1;
                } else if (0x1::vector::length<u8>(0x1::string::as_bytes(&v13)) == 6) {
                    v11 = v11 + 1;
                };
                v12 = v12 + 1;
            };
            let v14 = v4 + v5 + v6 + v7 + v8 + v9;
            let v15 = v3 - v14;
            if (v15 >= 3) {
                v0 = *0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_reference_to_base_price(arg1) / 10;
            } else if (v3 == 1 && v14 == 1) {
                v0 = *0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_reference_to_base_price(arg1) * *0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_reference_to_gold_multipliers(arg1);
            } else if (v3 == 1 && v10 > 0) {
                v0 = *0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_reference_to_base_price(arg1) * *0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_reference_to_tier_one_multipliers(arg1);
            } else if (v3 == 1 && v11 > 0) {
                v0 = *0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_reference_to_base_price(arg1) * *0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_reference_to_tier_five_multipliers(arg1);
            } else if (v3 == 2 && v14 > 0 || v15 < 2 && v14 >= 1) {
                if (v4 > 0) {
                    v0 = *0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_reference_to_base_price(arg1) * *0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_reference_to_tier_one_multipliers(arg1);
                } else if (v5 > 0) {
                    v0 = *0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_reference_to_base_price(arg1) * *0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_reference_to_tier_two_multipliers(arg1);
                } else if (v6 > 0) {
                    v0 = *0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_reference_to_base_price(arg1) * *0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_reference_to_tier_three_multipliers(arg1);
                } else if (v7 > 0) {
                    v0 = *0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_reference_to_base_price(arg1) * *0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_reference_to_tier_four_multipliers(arg1);
                } else if (v8 > 0) {
                    v0 = *0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_reference_to_base_price(arg1) * *0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_reference_to_tier_five_multipliers(arg1);
                } else if (v9 > 0) {
                    v0 = *0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_reference_to_base_price(arg1) * *0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_reference_to_tier_six_multipliers(arg1);
                };
            } else if (v15 == 2 && v14 >= 1) {
                if (v4 > 0) {
                    v0 = *0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_reference_to_base_price(arg1) * *0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_reference_to_tier_one_multipliers(arg1) / 2;
                } else if (v5 > 0) {
                    v0 = *0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_reference_to_base_price(arg1) * *0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_reference_to_tier_two_multipliers(arg1) / 2;
                } else if (v6 > 0) {
                    v0 = *0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_reference_to_base_price(arg1) * *0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_reference_to_tier_three_multipliers(arg1) / 2;
                } else if (v7 > 0) {
                    v0 = *0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_reference_to_base_price(arg1) * *0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_reference_to_tier_four_multipliers(arg1) / 2;
                } else if (v8 > 0) {
                    v0 = *0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_reference_to_base_price(arg1) * *0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_reference_to_tier_five_multipliers(arg1) / 2;
                } else if (v9 > 0) {
                    v0 = *0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_reference_to_base_price(arg1) * *0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_reference_to_tier_six_multipliers(arg1) / 2;
                };
            };
        };
        if (v0 <= 10000000000) {
            v0 = 10000000000;
        };
        v0
    }

    public fun depositFromDummyWalletToDummyWallet(arg0: &mut DummyWallet, arg1: &mut DummyWallet, arg2: &mut DummyNFT, arg3: u64, arg4: &mut 0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::RewardPool, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::uid_to_address(&arg2.id) == arg1.owner, 42);
        0x2::coin::put<0xde6e090a0ff9c83a69c0d102fbe4f340de89743203e847c4a9542db1cd4d6132::dummy::DUMMY>(0x2::coin::balance_mut<0xde6e090a0ff9c83a69c0d102fbe4f340de89743203e847c4a9542db1cd4d6132::dummy::DUMMY>(&mut arg0.balance), 0x2::coin::take<0xde6e090a0ff9c83a69c0d102fbe4f340de89743203e847c4a9542db1cd4d6132::dummy::DUMMY>(0x2::coin::balance_mut<0xde6e090a0ff9c83a69c0d102fbe4f340de89743203e847c4a9542db1cd4d6132::dummy::DUMMY>(&mut arg1.balance), arg3, arg5));
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg2.id, 0x1::string::utf8(b"transfer_cap_dummy"))) {
            let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(&mut arg2.id, 0x1::string::utf8(b"transfer_cap_dummy"));
            if (*v0 <= 1000) {
                *v0 = *v0 + 10;
                0x2::coin::put<0xde6e090a0ff9c83a69c0d102fbe4f340de89743203e847c4a9542db1cd4d6132::dummy::DUMMY>(0x2::coin::balance_mut<0xde6e090a0ff9c83a69c0d102fbe4f340de89743203e847c4a9542db1cd4d6132::dummy::DUMMY>(&mut arg1.balance), 0x2::coin::take<0xde6e090a0ff9c83a69c0d102fbe4f340de89743203e847c4a9542db1cd4d6132::dummy::DUMMY>(0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_mutable_reference_to_reward_balance(arg4), 1000000000, arg5));
            };
        } else {
            0x2::dynamic_field::add<0x1::string::String, u64>(&mut arg2.id, 0x1::string::utf8(b"transfer_cap_dummy"), 10);
            0x2::coin::put<0xde6e090a0ff9c83a69c0d102fbe4f340de89743203e847c4a9542db1cd4d6132::dummy::DUMMY>(0x2::coin::balance_mut<0xde6e090a0ff9c83a69c0d102fbe4f340de89743203e847c4a9542db1cd4d6132::dummy::DUMMY>(&mut arg1.balance), 0x2::coin::take<0xde6e090a0ff9c83a69c0d102fbe4f340de89743203e847c4a9542db1cd4d6132::dummy::DUMMY>(0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_mutable_reference_to_reward_balance(arg4), 1000000000, arg5));
        };
    }

    public fun depositToDummyWallet(arg0: &mut DummyWallet, arg1: 0x2::coin::Coin<0xde6e090a0ff9c83a69c0d102fbe4f340de89743203e847c4a9542db1cd4d6132::dummy::DUMMY>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::put<0xde6e090a0ff9c83a69c0d102fbe4f340de89743203e847c4a9542db1cd4d6132::dummy::DUMMY>(0x2::coin::balance_mut<0xde6e090a0ff9c83a69c0d102fbe4f340de89743203e847c4a9542db1cd4d6132::dummy::DUMMY>(&mut arg0.balance), arg1);
    }

    public fun get_dummy_nft_object_id(arg0: 0x1::string::String, arg1: &DummyNFTList) : 0x2::object::ID {
        let v0 = 0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::validation::convert_dummy_nft_name_to_handle(0x1::string::as_bytes(&arg0));
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
        0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::royalty_policy::new_royalty_policy<DummyNFT>(&mut v8, &v7, 500, 0x2::tx_context::sender(arg1));
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

    public entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut DummyNFTList, arg4: &0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::ReservedDummyNFTList, arg5: &0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::BlackList, arg6: &0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::FrequentWordList, arg7: &0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::BlockList, arg8: &0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::PriceModel, arg9: &0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::GoldList, arg10: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg11: u64, arg12: &mut 0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::ContractManager, arg13: &mut 0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::RewardPool, arg14: &mut 0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::Dummy2Pool, arg15: 0x1::string::String, arg16: &mut 0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::CouponInfo, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::validation::convert_dummy_nft_name_to_handle(0x1::string::as_bytes(&arg0));
        if (arg15 == 0x1::string::utf8(b"") || 0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::check_is_coupon_special(arg15, arg16) == false) {
            assert!(0x1::string::length(&arg0) >= 5, 0);
        };
        assert!(0x1::string::length(&arg0) <= 63, 0);
        assert!(0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::validation::query_block_dummy_nft(arg7, 0x1::string::utf8(v0)) == false, 1);
        assert!(0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::validation::query_black_list_dummy_nft(arg5, 0x1::string::utf8(v0)) == false, 2);
        assert!(0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::validation::hasMultipleSpacesBetweenChar(arg0) == false, 3);
        assert!(0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::validation::isValidName(arg0), 4);
        let v1 = calculate_mint_fee(arg0, arg8, arg9, arg4, arg6);
        let v2 = v1;
        if (arg15 != 0x1::string::utf8(b"")) {
            let v3 = 0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::claim_coupon_discount_percentage(arg15, arg16, arg17, arg18);
            assert!(v3 != 0, 7);
            v2 = v1 - v1 * v3 / 100;
        };
        if (arg11 > 0) {
            v2 = v2 + arg11 * 1000000000;
            purchase_dummy2(arg11, arg14, arg18);
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(arg10) >= v2, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg10), v2), arg18), 0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_mutable_reference_to_contract_manager(arg12));
        let v4 = 0x2::tx_context::sender(arg18);
        let v5 = 0x2::object::new(arg18);
        let v6 = DummyWallet{
            id      : 0x2::object::new(arg18),
            balance : 0x2::coin::zero<0xde6e090a0ff9c83a69c0d102fbe4f340de89743203e847c4a9542db1cd4d6132::dummy::DUMMY>(arg18),
            owner   : 0x2::object::uid_to_address(&v5),
        };
        let v7 = DummyNFT{
            id                    : v5,
            dummy_nft_name        : arg0,
            handle                : 0x1::string::utf8(v0),
            dummy_nft_description : arg1,
            dummy_wallet          : 0x2::object::uid_to_address(&v6.id),
            url                   : arg2,
            content_links         : 0x2::table::new<0x1::string::String, Content>(arg18),
        };
        let v8 = MintDummyNFTEvent{
            object_id : 0x2::object::uid_to_inner(&v7.id),
            creator   : v4,
            name      : v7.dummy_nft_name,
        };
        0x2::event::emit<MintDummyNFTEvent>(v8);
        0x2::coin::put<0xde6e090a0ff9c83a69c0d102fbe4f340de89743203e847c4a9542db1cd4d6132::dummy::DUMMY>(0x2::coin::balance_mut<0xde6e090a0ff9c83a69c0d102fbe4f340de89743203e847c4a9542db1cd4d6132::dummy::DUMMY>(&mut v6.balance), 0x2::coin::take<0xde6e090a0ff9c83a69c0d102fbe4f340de89743203e847c4a9542db1cd4d6132::dummy::DUMMY>(0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_mutable_reference_to_reward_balance(arg13), 10000000000, arg18));
        0x2::transfer::share_object<DummyWallet>(v6);
        registry(arg3, 0x1::string::utf8(v0), 0x2::object::uid_to_inner(&v7.id));
        0x2::transfer::transfer<DummyNFT>(v7, v4);
    }

    fun purchase_dummy2(arg0: u64, arg1: &mut 0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::Dummy2Pool, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x7e9121e499172f1f47157f220ab845d90f4ff7e1ad2e554e4e03ba0df19bd39d::dummy2::DUMMY2>>(0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::withdraw_dummy2(arg1, arg0 * 5000000000, arg2), 0x2::tx_context::sender(arg2));
    }

    public fun query_dummy_nft_flag_status(arg0: &0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::BlackList, arg1: &0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::BlockList, arg2: &DummyNFTList, arg3: 0x1::string::String) : u8 {
        let v0 = 0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::validation::convert_dummy_nft_name_to_handle(0x1::string::as_bytes(&arg3));
        if (0x2::table::contains<0x1::string::String, bool>(0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_reference_from_black_list(arg0), 0x1::string::utf8(v0))) {
            1
        } else if (0x2::table::contains<0x1::string::String, bool>(0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_reference_from_block_list(arg1), 0x1::string::utf8(v0))) {
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
        0x2::transfer::public_transfer<0x2::coin::Coin<0xde6e090a0ff9c83a69c0d102fbe4f340de89743203e847c4a9542db1cd4d6132::dummy::DUMMY>>(0x2::coin::take<0xde6e090a0ff9c83a69c0d102fbe4f340de89743203e847c4a9542db1cd4d6132::dummy::DUMMY>(0x2::coin::balance_mut<0xde6e090a0ff9c83a69c0d102fbe4f340de89743203e847c4a9542db1cd4d6132::dummy::DUMMY>(&mut arg0.balance), arg2, arg4), arg3);
    }

    public fun update_links(arg0: &mut DummyNFT, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: vector<bool>, arg5: &mut 0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::RewardPool, arg6: &mut DummyWallet, arg7: &mut 0x2::tx_context::TxContext) {
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
                        0x2::coin::put<0xde6e090a0ff9c83a69c0d102fbe4f340de89743203e847c4a9542db1cd4d6132::dummy::DUMMY>(0x2::coin::balance_mut<0xde6e090a0ff9c83a69c0d102fbe4f340de89743203e847c4a9542db1cd4d6132::dummy::DUMMY>(&mut arg6.balance), 0x2::coin::take<0xde6e090a0ff9c83a69c0d102fbe4f340de89743203e847c4a9542db1cd4d6132::dummy::DUMMY>(0x52c7907d968f47ad5d95cc9f7c53f42056e0860be46491d8618363ce795431cf::admin::get_mutable_reference_to_reward_balance(arg5), 100000000, arg7));
                    };
                };
                v2 = v2 + 1;
            };
        };
    }

    public fun withdrawlFromDummyWallet(arg0: &mut DummyNFT, arg1: &mut DummyWallet, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::uid_to_address(&arg0.id) == arg1.owner, 42);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xde6e090a0ff9c83a69c0d102fbe4f340de89743203e847c4a9542db1cd4d6132::dummy::DUMMY>>(0x2::coin::take<0xde6e090a0ff9c83a69c0d102fbe4f340de89743203e847c4a9542db1cd4d6132::dummy::DUMMY>(0x2::coin::balance_mut<0xde6e090a0ff9c83a69c0d102fbe4f340de89743203e847c4a9542db1cd4d6132::dummy::DUMMY>(&mut arg1.balance), arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

