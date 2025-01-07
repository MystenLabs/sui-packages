module 0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::protocol {
    struct Content has copy, drop, store {
        title: 0x1::string::String,
        pinned: bool,
    }

    struct MovieWallet has key {
        id: 0x2::object::UID,
        balance: 0x2::coin::Coin<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>,
        owner: address,
    }

    struct Channel has store, key {
        id: 0x2::object::UID,
        channel_name: 0x1::string::String,
        handle: 0x1::string::String,
        channel_description: 0x1::string::String,
        movie_wallet: address,
        url: 0x1::string::String,
        content_links: 0x2::table::Table<0x1::string::String, Content>,
    }

    struct MintChannelEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct ChannelList has key {
        id: 0x2::object::UID,
        version: u64,
        list: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
    }

    struct PROTOCOL has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: Channel, arg1: address) {
        0x2::transfer::public_transfer<Channel>(arg0, arg1);
    }

    public fun add_links(arg0: &mut Channel, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>, arg3: vector<bool>, arg4: &mut 0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::RewardPool, arg5: &mut MovieWallet, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg1)) {
            let v1 = Content{
                title  : *0x1::vector::borrow<0x1::string::String>(&arg2, v0),
                pinned : *0x1::vector::borrow<bool>(&arg3, v0),
            };
            0x2::table::add<0x1::string::String, Content>(&mut arg0.content_links, *0x1::vector::borrow<0x1::string::String>(&arg1, v0), v1);
            v0 = v0 + 1;
        };
        let v2 = 0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_mutable_reference_to_reward_balance(arg4);
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, 0x1::string::utf8(b"MOVIE_REWARD_CAP"))) {
            let v3 = 0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(&mut arg0.id, 0x1::string::utf8(b"MOVIE_REWARD_CAP"));
            if (*v3 < 4500) {
                if (*v3 + 0x1::vector::length<0x1::string::String>(&arg1) * 10 >= 4500) {
                    0x2::coin::put<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>(0x2::coin::balance_mut<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>(&mut arg5.balance), 0x2::coin::take<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>(v2, (4500 - *v3) * 100000000, arg6));
                    *v3 = *v3 + 4500 - *v3;
                } else {
                    0x2::coin::put<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>(0x2::coin::balance_mut<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>(&mut arg5.balance), 0x2::coin::take<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>(v2, 0x1::vector::length<0x1::string::String>(&arg1) * 10 * 100000000, arg6));
                    *v3 = *v3 + 0x1::vector::length<0x1::string::String>(&arg1) * 10;
                };
            };
        } else {
            0x2::dynamic_field::add<0x1::string::String, u64>(&mut arg0.id, 0x1::string::utf8(b"MOVIE_REWARD_CAP"), 0x1::vector::length<0x1::string::String>(&arg1) * 10);
            0x2::coin::put<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>(0x2::coin::balance_mut<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>(&mut arg5.balance), 0x2::coin::take<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>(v2, 0x1::vector::length<0x1::string::String>(&arg1) * 10 * 100000000, arg6));
        };
    }

    public fun authority_mint_blocked_name(arg0: &0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::ContractPublisher, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut ChannelList, arg5: &mut 0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::BlockList, arg6: &0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::BlackList, arg7: address, arg8: &mut 0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::RewardPool, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::validation::convert_channel_name_to_handle(0x1::string::as_bytes(&arg1));
        assert!(0x1::string::length(&arg1) <= 63, 11);
        assert!(0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::validation::query_black_list_channel(arg6, 0x1::string::utf8(v0)) == false, 13);
        assert!(0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::validation::query_block_channel(arg5, 0x1::string::utf8(v0)), 19);
        0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::remove_from_blocklist(arg0, arg5, arg1);
        let v1 = 0x2::object::new(arg9);
        let v2 = MovieWallet{
            id      : 0x2::object::new(arg9),
            balance : 0x2::coin::zero<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>(arg9),
            owner   : 0x2::object::uid_to_address(&v1),
        };
        let v3 = Channel{
            id                  : v1,
            channel_name        : arg1,
            handle              : 0x1::string::utf8(v0),
            channel_description : arg2,
            movie_wallet        : 0x2::object::uid_to_address(&v2.id),
            url                 : arg3,
            content_links       : 0x2::table::new<0x1::string::String, Content>(arg9),
        };
        let v4 = MintChannelEvent{
            object_id : 0x2::object::uid_to_inner(&v3.id),
            creator   : arg7,
            name      : v3.channel_name,
        };
        0x2::event::emit<MintChannelEvent>(v4);
        0x2::coin::put<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>(0x2::coin::balance_mut<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>(&mut v2.balance), 0x2::coin::take<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>(0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_mutable_reference_to_reward_balance(arg8), 50000000000, arg9));
        0x2::transfer::share_object<MovieWallet>(v2);
        registry(arg4, 0x1::string::utf8(v0), 0x2::object::uid_to_inner(&v3.id));
        0x2::transfer::transfer<Channel>(v3, arg7);
    }

    public fun calculate_mint_fee(arg0: 0x1::string::String, arg1: &0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::PriceModel, arg2: &0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::GoldList, arg3: &0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::ReservedChannelList, arg4: &0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::FrequentWordList) : u64 {
        let v0 = *0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_reference_to_base_price(arg1) / 10;
        let v1 = 0x1::string::utf8(0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::validation::convert_channel_name_to_handle(0x1::string::as_bytes(&arg0)));
        if (0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::validation::query_gold_channel(arg2, v1)) {
            v0 = *0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_reference_to_base_price(arg1) * *0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_reference_to_gold_multipliers(arg1);
        } else if (0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::validation::query_resereve_channel(arg3, v1)) {
            v0 = *0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_reference_to_base_price(arg1) * *0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_reference_to_premium_multipliers(arg1);
        } else {
            let v2 = 0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::validation::get_word_list(arg0);
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
                if (0x1::vector::contains<0x1::string::String>(0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_reference_from_tier_One(arg4), &v13)) {
                    v4 = v4 + 1;
                } else if (0x1::vector::contains<0x1::string::String>(0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_reference_from_tier_Two(arg4), &v13)) {
                    v5 = v5 + 1;
                } else if (0x1::vector::contains<0x1::string::String>(0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_reference_from_tier_Three(arg4), &v13)) {
                    v6 = v6 + 1;
                } else if (0x1::vector::contains<0x1::string::String>(0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_reference_from_tier_Four(arg4), &v13)) {
                    v7 = v7 + 1;
                } else if (0x1::vector::contains<0x1::string::String>(0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_reference_from_tier_Five(arg4), &v13)) {
                    v8 = v8 + 1;
                } else if (0x1::vector::contains<0x1::string::String>(0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_reference_from_tier_Six(arg4), &v13)) {
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
                v0 = *0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_reference_to_base_price(arg1) / 10;
            } else if (v3 == 1 && v14 == 1) {
                v0 = *0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_reference_to_base_price(arg1) * *0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_reference_to_gold_multipliers(arg1);
            } else if (v3 == 1 && v10 > 0) {
                v0 = *0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_reference_to_base_price(arg1) * *0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_reference_to_tier_one_multipliers(arg1);
            } else if (v3 == 1 && v11 > 0) {
                v0 = *0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_reference_to_base_price(arg1) * *0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_reference_to_tier_five_multipliers(arg1);
            } else if (v3 == 2 && v14 > 0 || v15 < 2 && v14 >= 1) {
                if (v4 > 0) {
                    v0 = *0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_reference_to_base_price(arg1) * *0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_reference_to_tier_one_multipliers(arg1);
                } else if (v5 > 0) {
                    v0 = *0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_reference_to_base_price(arg1) * *0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_reference_to_tier_two_multipliers(arg1);
                } else if (v6 > 0) {
                    v0 = *0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_reference_to_base_price(arg1) * *0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_reference_to_tier_three_multipliers(arg1);
                } else if (v7 > 0) {
                    v0 = *0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_reference_to_base_price(arg1) * *0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_reference_to_tier_four_multipliers(arg1);
                } else if (v8 > 0) {
                    v0 = *0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_reference_to_base_price(arg1) * *0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_reference_to_tier_five_multipliers(arg1);
                } else if (v9 > 0) {
                    v0 = *0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_reference_to_base_price(arg1) * *0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_reference_to_tier_six_multipliers(arg1);
                };
            } else if (v15 == 2 && v14 >= 1) {
                if (v4 > 0) {
                    v0 = *0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_reference_to_base_price(arg1) * *0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_reference_to_tier_one_multipliers(arg1) / 2;
                } else if (v5 > 0) {
                    v0 = *0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_reference_to_base_price(arg1) * *0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_reference_to_tier_two_multipliers(arg1) / 2;
                } else if (v6 > 0) {
                    v0 = *0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_reference_to_base_price(arg1) * *0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_reference_to_tier_three_multipliers(arg1) / 2;
                } else if (v7 > 0) {
                    v0 = *0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_reference_to_base_price(arg1) * *0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_reference_to_tier_four_multipliers(arg1) / 2;
                } else if (v8 > 0) {
                    v0 = *0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_reference_to_base_price(arg1) * *0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_reference_to_tier_five_multipliers(arg1) / 2;
                } else if (v9 > 0) {
                    v0 = *0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_reference_to_base_price(arg1) * *0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_reference_to_tier_six_multipliers(arg1) / 2;
                };
            };
        };
        if (v0 <= 10000000000) {
            v0 = 10000000000;
        };
        v0
    }

    public fun depositFromMovieWalletToMovieWallet(arg0: &mut MovieWallet, arg1: &mut MovieWallet, arg2: &mut Channel, arg3: u64, arg4: &mut 0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::RewardPool, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::uid_to_address(&arg2.id) == arg1.owner, 10);
        0x2::coin::put<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>(0x2::coin::balance_mut<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>(&mut arg0.balance), 0x2::coin::take<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>(0x2::coin::balance_mut<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>(&mut arg1.balance), arg3, arg5));
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg2.id, 0x1::string::utf8(b"MOVIE_REWARD_CAP"))) {
            let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(&mut arg2.id, 0x1::string::utf8(b"MOVIE_REWARD_CAP"));
            let v1 = 0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_mutable_reference_to_reward_balance(arg4);
            if (*v0 <= 4500) {
                if (*v0 + 100 >= 4500) {
                    0x2::coin::put<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>(0x2::coin::balance_mut<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>(&mut arg1.balance), 0x2::coin::take<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>(v1, (4500 - *v0) * 100000000, arg5));
                    *v0 = *v0 + 4500 - *v0;
                } else {
                    0x2::coin::put<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>(0x2::coin::balance_mut<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>(&mut arg1.balance), 0x2::coin::take<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>(v1, 10000000000, arg5));
                    *v0 = *v0 + 100;
                };
            };
        } else {
            0x2::dynamic_field::add<0x1::string::String, u64>(&mut arg2.id, 0x1::string::utf8(b"MOVIE_REWARD_CAP"), 100);
            0x2::coin::put<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>(0x2::coin::balance_mut<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>(&mut arg1.balance), 0x2::coin::take<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>(0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_mutable_reference_to_reward_balance(arg4), 10000000000, arg5));
        };
    }

    public fun depositToMovieWallet(arg0: &mut MovieWallet, arg1: 0x2::coin::Coin<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::put<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>(0x2::coin::balance_mut<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>(&mut arg0.balance), arg1);
    }

    public fun get_channel_object_id(arg0: 0x1::string::String, arg1: &ChannelList) : 0x2::object::ID {
        let v0 = 0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::validation::convert_channel_name_to_handle(0x1::string::as_bytes(&arg0));
        assert!(0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg1.list, 0x1::string::utf8(v0)), 17);
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{channel_name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://wildchannels.com/channel/{channel_name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Your Channel Your Network"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://wildchannels.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"MECHA"));
        let v4 = 0x2::package::claim<PROTOCOL>(arg0, arg1);
        let (v5, v6) = 0x2::transfer_policy::new<Channel>(&v4, arg1);
        let v7 = v6;
        let v8 = v5;
        0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::royalty_policy::new_royalty_policy<Channel>(&mut v8, &v7, 500, @0xc4b90789691abca8930eae09536be626baff2dbf17957b3110fc04c89ee711a4);
        let v9 = 0x2::display::new_with_fields<Channel>(&v4, v0, v2, arg1);
        0x2::display::update_version<Channel>(&mut v9);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Channel>>(v9, 0x2::tx_context::sender(arg1));
        let v10 = 0x1::string::utf8(b"Wild Channels");
        let v11 = 0x2::object::new(arg1);
        let v12 = MovieWallet{
            id      : 0x2::object::new(arg1),
            balance : 0x2::coin::zero<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>(arg1),
            owner   : 0x2::object::uid_to_address(&v11),
        };
        let v13 = Channel{
            id                  : v11,
            channel_name        : v10,
            handle              : 0x1::string::utf8(0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::validation::convert_channel_name_to_handle(0x1::string::as_bytes(&v10))),
            channel_description : 0x1::string::utf8(x"57696c64204368616e6e656ce284a2"),
            movie_wallet        : 0x2::object::uid_to_address(&v12.id),
            url                 : 0x1::string::utf8(b"https://pcpi2c2ecencz63a3gndugtv3dalrc3iea7nztwp6q7zpkdlnpfa.arweave.net/eJ6NC0QRGiz7YNmaOhp12MC4i2ggPtzOz_Q_l6hra8o"),
            content_links       : 0x2::table::new<0x1::string::String, Content>(arg1),
        };
        let v14 = ChannelList{
            id      : 0x2::object::new(arg1),
            version : 1,
            list    : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg1),
        };
        0x2::transfer::share_object<ChannelList>(v14);
        0x2::transfer::share_object<MovieWallet>(v12);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Channel>>(v8);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Channel>>(v7, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<Channel>(v13, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut ChannelList, arg4: &0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::ReservedChannelList, arg5: &0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::BlackList, arg6: &0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::FrequentWordList, arg7: &0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::BlockList, arg8: &0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::PriceModel, arg9: &0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::GoldList, arg10: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg11: &mut 0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::ContractManager, arg12: &mut 0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::RewardPool, arg13: vector<u8>, arg14: &mut 0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::CouponInfo, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::validation::convert_channel_name_to_handle(0x1::string::as_bytes(&arg0));
        if (0x1::string::utf8(arg13) == 0x1::string::utf8(b"") || 0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::check_is_coupon_special(arg13, arg14) == false) {
            assert!(0x1::string::length(&arg0) >= 5, 11);
        };
        assert!(0x1::string::length(&arg0) <= 63, 11);
        assert!(0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::validation::query_block_channel(arg7, 0x1::string::utf8(v0)) == false, 12);
        assert!(0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::validation::query_black_list_channel(arg5, 0x1::string::utf8(v0)) == false, 13);
        assert!(0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::validation::isValidName(arg0), 15);
        let v1 = calculate_mint_fee(arg0, arg8, arg9, arg4, arg6);
        let v2 = v1;
        if (0x1::string::utf8(arg13) != 0x1::string::utf8(b"")) {
            let v3 = 0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::claim_coupon_discount_percentage(arg13, arg14, arg15, arg16);
            assert!(v3 != 0, 18);
            v2 = v1 - v1 * v3 / 100;
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(arg10) >= v2, 16);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg10), v2), arg16), 0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_mutable_reference_to_contract_manager(arg11));
        let v4 = 0x2::tx_context::sender(arg16);
        let v5 = 0x2::object::new(arg16);
        let v6 = MovieWallet{
            id      : 0x2::object::new(arg16),
            balance : 0x2::coin::zero<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>(arg16),
            owner   : 0x2::object::uid_to_address(&v5),
        };
        let v7 = Channel{
            id                  : v5,
            channel_name        : arg0,
            handle              : 0x1::string::utf8(v0),
            channel_description : arg1,
            movie_wallet        : 0x2::object::uid_to_address(&v6.id),
            url                 : arg2,
            content_links       : 0x2::table::new<0x1::string::String, Content>(arg16),
        };
        let v8 = MintChannelEvent{
            object_id : 0x2::object::uid_to_inner(&v7.id),
            creator   : v4,
            name      : v7.channel_name,
        };
        0x2::event::emit<MintChannelEvent>(v8);
        0x2::coin::put<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>(0x2::coin::balance_mut<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>(&mut v6.balance), 0x2::coin::take<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>(0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_mutable_reference_to_reward_balance(arg12), 50000000000, arg16));
        0x2::transfer::share_object<MovieWallet>(v6);
        registry(arg3, 0x1::string::utf8(v0), 0x2::object::uid_to_inner(&v7.id));
        0x2::transfer::transfer<Channel>(v7, v4);
    }

    public fun query_channel_flag_status(arg0: &0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::BlackList, arg1: &0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::BlockList, arg2: &ChannelList, arg3: 0x1::string::String) : u8 {
        let v0 = 0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::validation::convert_channel_name_to_handle(0x1::string::as_bytes(&arg3));
        if (0x2::table::contains<0x1::string::String, bool>(0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_reference_from_black_list(arg0), 0x1::string::utf8(v0))) {
            1
        } else if (0x2::table::contains<0x1::string::String, bool>(0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_reference_from_block_list(arg1), 0x1::string::utf8(v0))) {
            2
        } else if (0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg2.list, 0x1::string::utf8(v0))) {
            3
        } else {
            0
        }
    }

    fun registry(arg0: &mut ChannelList, arg1: 0x1::string::String, arg2: 0x2::object::ID) {
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg0.list, arg1, arg2);
    }

    public entry fun update_channel_url(arg0: &mut Channel, arg1: 0x1::string::String) {
        arg0.url = arg1;
    }

    public fun update_display(arg0: &mut 0x2::display::Display<Channel>, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        0x2::display::edit<Channel>(arg0, arg1, arg2);
        0x2::display::update_version<Channel>(arg0);
    }

    public fun update_links(arg0: &mut Channel, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: vector<bool>, arg5: &mut 0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::RewardPool, arg6: &mut MovieWallet, arg7: &mut 0x2::tx_context::TxContext) {
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
                    let v6 = 0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(&mut arg0.id, 0x1::string::utf8(b"MOVIE_REWARD_CAP"));
                    let v7 = 0xc90cf2d853b8ee8d592ee61bbbfa4e41bcc0150bae6b53f347376d7fb34e5f9b::admin::get_mutable_reference_to_reward_balance(arg5);
                    if (*v6 < 4500) {
                        if (*v6 + 10 > 4500) {
                            0x2::coin::put<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>(0x2::coin::balance_mut<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>(&mut arg6.balance), 0x2::coin::take<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>(v7, (4500 - *v6) * 100000000, arg7));
                            *v6 = *v6 + 4500 - *v6;
                        } else {
                            0x2::coin::put<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>(0x2::coin::balance_mut<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>(&mut arg6.balance), 0x2::coin::take<0xca21eeed96a49846e09e880cf960deeae437fdf396bf6962bf86d40be87db740::movie::MOVIE>(v7, 1000000000, arg7));
                            *v6 = *v6 + 10;
                        };
                    };
                };
                v2 = v2 + 1;
            };
        };
    }

    // decompiled from Move bytecode v6
}

