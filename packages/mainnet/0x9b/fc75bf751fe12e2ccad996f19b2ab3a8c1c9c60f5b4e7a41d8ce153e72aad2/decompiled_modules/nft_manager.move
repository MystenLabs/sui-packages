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
        (0x1::string::utf8(b"WTQdGVTdg9x-n7dE2MPljsMN6pzULA3fXEqW8u_o7ycBdwKMAg"), 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>())
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
        let v10 = 0x1::vector::swap_remove<NftTemplate>(0x2::table::borrow_mut<u16, vector<NftTemplate>>(&mut arg0.items, v5), v6);
        let v11 = 0x2::table::borrow_mut<u8, u64>(&mut arg0.remaining_supply, arg1);
        *v11 = *v11 - 1;
        (v10.code, v10.attributes)
    }

    // decompiled from Move bytecode v7
}

