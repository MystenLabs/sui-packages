module 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::nft_manager {
    struct NftTemplate has drop, store {
        code: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct ImageStorage has store {
        items: 0x2::table::Table<u16, vector<NftTemplate>>,
        chunk_counts: 0x2::table::Table<u8, u16>,
        remaining_supply: 0x2::table::Table<u8, u64>,
        archive_stages: 0x2::table::Table<0x1::string::String, 0x2::vec_map::VecMap<u8, 0x1::string::String>>,
    }

    public(friend) fun add_items(arg0: &mut ImageStorage, arg1: u8, arg2: vector<0x1::string::String>, arg3: vector<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>) {
        let v0 = 0x1::vector::length<0x1::string::String>(&arg2);
        if (v0 == 0) {
            return
        };
        if (!0x2::table::contains<u8, u16>(&arg0.chunk_counts, arg1)) {
            0x2::table::add<u8, u16>(&mut arg0.chunk_counts, arg1, 0);
            0x2::table::add<u8, u64>(&mut arg0.remaining_supply, arg1, 0);
        };
        let v1 = 0;
        while (v1 < v0) {
            let v2 = (arg1 as u16) * 1000 + *0x2::table::borrow<u8, u16>(&arg0.chunk_counts, arg1);
            if (!0x2::table::contains<u16, vector<NftTemplate>>(&arg0.items, v2)) {
                0x2::table::add<u16, vector<NftTemplate>>(&mut arg0.items, v2, 0x1::vector::empty<NftTemplate>());
            };
            let v3 = 0x2::table::borrow_mut<u16, vector<NftTemplate>>(&mut arg0.items, v2);
            let v4 = 0x1::vector::length<NftTemplate>(v3);
            if (v4 >= 150) {
                let v5 = 0x2::table::borrow_mut<u8, u16>(&mut arg0.chunk_counts, arg1);
                *v5 = *v5 + 1;
                continue
            };
            let v6 = 150 - v4;
            let v7 = v0 - v1;
            let v8 = if (v6 < v7) {
                v6
            } else {
                v7
            };
            let v9 = 0;
            while (v9 < v8) {
                let v10 = *0x1::vector::borrow<0x1::string::String>(&arg2, v1);
                if (!0x2::table::contains<0x1::string::String, 0x2::vec_map::VecMap<u8, 0x1::string::String>>(&arg0.archive_stages, v10)) {
                    0x2::table::add<0x1::string::String, 0x2::vec_map::VecMap<u8, 0x1::string::String>>(&mut arg0.archive_stages, v10, 0x2::vec_map::empty<u8, 0x1::string::String>());
                };
                let v11 = NftTemplate{
                    code       : v10,
                    attributes : *0x1::vector::borrow<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg3, v1),
                };
                0x1::vector::push_back<NftTemplate>(v3, v11);
                v1 = v1 + 1;
                v9 = v9 + 1;
            };
        };
        let v12 = 0x2::table::borrow_mut<u8, u64>(&mut arg0.remaining_supply, arg1);
        *v12 = *v12 + (v0 as u64);
    }

    public(friend) fun add_nft_stage(arg0: &mut ImageStorage, arg1: 0x1::string::String, arg2: u8, arg3: 0x1::string::String) {
        if (!0x2::table::contains<0x1::string::String, 0x2::vec_map::VecMap<u8, 0x1::string::String>>(&arg0.archive_stages, arg1)) {
            0x2::table::add<0x1::string::String, 0x2::vec_map::VecMap<u8, 0x1::string::String>>(&mut arg0.archive_stages, arg1, 0x2::vec_map::empty<u8, 0x1::string::String>());
        };
        let v0 = 0x2::table::borrow_mut<0x1::string::String, 0x2::vec_map::VecMap<u8, 0x1::string::String>>(&mut arg0.archive_stages, arg1);
        if (0x2::vec_map::contains<u8, 0x1::string::String>(v0, &arg2)) {
            *0x2::vec_map::get_mut<u8, 0x1::string::String>(v0, &arg2) = arg3;
        } else {
            0x2::vec_map::insert<u8, 0x1::string::String>(v0, arg2, arg3);
        };
    }

    public(friend) fun get_code_for_level(arg0: &ImageStorage, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u16) : 0x1::string::String {
        let v0 = ((arg3 / 1000) as u8);
        assert!(0x2::table::contains<0x1::string::String, 0x2::vec_map::VecMap<u8, 0x1::string::String>>(&arg0.archive_stages, arg1), 1);
        let v1 = 0x2::table::borrow<0x1::string::String, 0x2::vec_map::VecMap<u8, 0x1::string::String>>(&arg0.archive_stages, arg1);
        if (v0 == 0) {
            arg1
        } else if (0x2::vec_map::contains<u8, 0x1::string::String>(v1, &v0)) {
            *0x2::vec_map::get<u8, 0x1::string::String>(v1, &v0)
        } else {
            arg2
        }
    }

    public(friend) fun get_level0_metadata() : (0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>) {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v1 = &mut v0;
        sync_level_and_stage_attributes(v1, 0);
        (0x1::string::utf8(b"WTQdGVTdg9x-n7dE2MPljsMN6pzULA3fXEqW8u_o7ycBdwKMAg"), v0)
    }

    public(friend) fun get_remaining_supply(arg0: &ImageStorage, arg1: u8) : u64 {
        if (!0x2::table::contains<u8, u64>(&arg0.remaining_supply, arg1)) {
            return 0
        };
        *0x2::table::borrow<u8, u64>(&arg0.remaining_supply, arg1)
    }

    public(friend) fun new_storage(arg0: &mut 0x2::tx_context::TxContext) : ImageStorage {
        ImageStorage{
            items            : 0x2::table::new<u16, vector<NftTemplate>>(arg0),
            chunk_counts     : 0x2::table::new<u8, u16>(arg0),
            remaining_supply : 0x2::table::new<u8, u64>(arg0),
            archive_stages   : 0x2::table::new<0x1::string::String, 0x2::vec_map::VecMap<u8, 0x1::string::String>>(arg0),
        }
    }

    public(friend) fun remove_items_by_codes(arg0: &mut ImageStorage, arg1: u8, arg2: &vector<0x1::string::String>) : u64 {
        let v0 = 0x1::vector::length<0x1::string::String>(arg2);
        if (v0 == 0) {
            return 0
        };
        assert!(0x2::table::contains<u8, u16>(&arg0.chunk_counts, arg1), 2);
        let v1 = (arg1 as u16) * 1000;
        let v2 = 0;
        let v3 = 0;
        while (v3 < v0) {
            let v4 = 0x1::vector::borrow<0x1::string::String>(arg2, v3);
            let v5 = false;
            let v6 = 0;
            while (v6 <= *0x2::table::borrow<u8, u16>(&arg0.chunk_counts, arg1)) {
                let v7 = v1 + v6;
                if (0x2::table::contains<u16, vector<NftTemplate>>(&arg0.items, v7)) {
                    let v8 = 0x2::table::borrow_mut<u16, vector<NftTemplate>>(&mut arg0.items, v7);
                    let v9 = 0;
                    while (v9 < 0x1::vector::length<NftTemplate>(v8)) {
                        if (&0x1::vector::borrow<NftTemplate>(v8, v9).code == v4) {
                            let NftTemplate {
                                code       : v10,
                                attributes : _,
                            } = 0x1::vector::swap_remove<NftTemplate>(v8, v9);
                            if (0x2::table::contains<0x1::string::String, 0x2::vec_map::VecMap<u8, 0x1::string::String>>(&arg0.archive_stages, v10)) {
                                0x2::table::remove<0x1::string::String, 0x2::vec_map::VecMap<u8, 0x1::string::String>>(&mut arg0.archive_stages, v10);
                            };
                            v2 = v2 + 1;
                            v5 = true;
                            break
                        };
                        v9 = v9 + 1;
                    };
                };
                if (v5) {
                    break
                };
                v6 = v6 + 1;
            };
            assert!(v5, 2);
            v3 = v3 + 1;
        };
        let v12 = 0x2::table::borrow_mut<u8, u64>(&mut arg0.remaining_supply, arg1);
        if (*v12 >= v2) {
            *v12 = *v12 - v2;
        } else {
            *v12 = 0;
        };
        let v13 = *0x2::table::borrow<u8, u16>(&arg0.chunk_counts, arg1);
        while (v13 > 0) {
            let v14 = v1 + v13;
            if (0x2::table::contains<u16, vector<NftTemplate>>(&arg0.items, v14)) {
                if (0x1::vector::is_empty<NftTemplate>(0x2::table::borrow<u16, vector<NftTemplate>>(&arg0.items, v14))) {
                    0x1::vector::destroy_empty<NftTemplate>(0x2::table::remove<u16, vector<NftTemplate>>(&mut arg0.items, v14));
                    v13 = v13 - 1;
                    continue
                } else {
                    break
                };
            };
            v13 = v13 - 1;
        };
        *0x2::table::borrow_mut<u8, u16>(&mut arg0.chunk_counts, arg1) = v13;
        v2
    }

    public(friend) fun reset_rarity_pool(arg0: &mut ImageStorage, arg1: u8) : u64 {
        let (v0, _) = reset_rarity_pool_batch(arg0, arg1, 65535);
        v0
    }

    public(friend) fun reset_rarity_pool_batch(arg0: &mut ImageStorage, arg1: u8, arg2: u16) : (u64, u64) {
        if (!0x2::table::contains<u8, u16>(&arg0.chunk_counts, arg1) || arg2 == 0) {
            return (0, get_remaining_supply(arg0, arg1))
        };
        let v0 = *0x2::table::borrow<u8, u16>(&arg0.chunk_counts, arg1);
        let v1 = (arg1 as u16) * 1000;
        let v2 = 0;
        let v3 = 0;
        while (v2 < arg2) {
            let v4 = v1 + v0;
            if (0x2::table::contains<u16, vector<NftTemplate>>(&arg0.items, v4)) {
                let v5 = 0x2::table::remove<u16, vector<NftTemplate>>(&mut arg0.items, v4);
                while (!0x1::vector::is_empty<NftTemplate>(&v5)) {
                    let NftTemplate {
                        code       : v6,
                        attributes : _,
                    } = 0x1::vector::pop_back<NftTemplate>(&mut v5);
                    if (0x2::table::contains<0x1::string::String, 0x2::vec_map::VecMap<u8, 0x1::string::String>>(&arg0.archive_stages, v6)) {
                        0x2::table::remove<0x1::string::String, 0x2::vec_map::VecMap<u8, 0x1::string::String>>(&mut arg0.archive_stages, v6);
                    };
                    v3 = v3 + 1;
                };
                0x1::vector::destroy_empty<NftTemplate>(v5);
            };
            v2 = v2 + 1;
            if (v0 == 0) {
                break
            };
            v0 = v0 - 1;
        };
        if (!0x2::table::contains<u16, vector<NftTemplate>>(&arg0.items, v1)) {
            *0x2::table::borrow_mut<u8, u16>(&mut arg0.chunk_counts, arg1) = 0;
            *0x2::table::borrow_mut<u8, u64>(&mut arg0.remaining_supply, arg1) = 0;
        } else {
            *0x2::table::borrow_mut<u8, u16>(&mut arg0.chunk_counts, arg1) = v0;
            let v8 = 0x2::table::borrow_mut<u8, u64>(&mut arg0.remaining_supply, arg1);
            if (*v8 >= v3) {
                *v8 = *v8 - v3;
            } else {
                *v8 = 0;
            };
        };
        (v3, *0x2::table::borrow<u8, u64>(&arg0.remaining_supply, arg1))
    }

    public(friend) fun reveal_nft(arg0: &mut ImageStorage, arg1: u8, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) : (0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>) {
        let v0 = get_remaining_supply(arg0, arg1);
        assert!(v0 > 0, 0);
        let v1 = 0x2::random::new_generator(arg2, arg3);
        let v2 = 0x2::random::generate_u64_in_range(&mut v1, 0, v0 - 1);
        let v3 = (arg1 as u16) * 1000;
        let v4 = 0;
        let v5 = v3;
        let v6 = 0;
        let v7 = 0;
        while (v7 <= *0x2::table::borrow<u8, u16>(&arg0.chunk_counts, arg1)) {
            let v8 = v3 + v7;
            if (0x2::table::contains<u16, vector<NftTemplate>>(&arg0.items, v8)) {
                let v9 = 0x1::vector::length<NftTemplate>(0x2::table::borrow<u16, vector<NftTemplate>>(&arg0.items, v8));
                if (v9 > 0 && v4 + v9 > v2) {
                    v5 = v8;
                    v6 = v2 - v4;
                    break
                };
                v4 = v4 + v9;
            };
            v7 = v7 + 1;
        };
        let v10 = 0x2::table::borrow_mut<u8, u64>(&mut arg0.remaining_supply, arg1);
        *v10 = *v10 - 1;
        let NftTemplate {
            code       : v11,
            attributes : v12,
        } = 0x1::vector::swap_remove<NftTemplate>(0x2::table::borrow_mut<u16, vector<NftTemplate>>(&mut arg0.items, v5), v6);
        let v13 = v12;
        let v14 = &mut v13;
        sync_level_and_stage_attributes(v14, 1);
        (v11, v13)
    }

    public(friend) fun sync_level_and_stage_attributes(arg0: &mut 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg1: u16) {
        upsert_attribute(arg0, 0x1::string::utf8(b"Level"), 0x1::u16::to_string(arg1));
        upsert_attribute(arg0, 0x1::string::utf8(b"Stage"), 0x1::string::utf8(b"0"));
    }

    public(friend) fun upsert_attribute(arg0: &mut 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(arg0, &arg1)) {
            *0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(arg0, &arg1) = arg2;
        } else {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(arg0, arg1, arg2);
        };
    }

    // decompiled from Move bytecode v7
}

