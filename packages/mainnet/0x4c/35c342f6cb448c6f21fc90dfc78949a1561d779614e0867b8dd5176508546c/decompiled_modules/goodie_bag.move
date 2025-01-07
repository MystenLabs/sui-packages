module 0x9eea9fa6f1730073268edb3b6b8d5b4795026721d7015e306fde47a610b59d66::goodie_bag {
    struct NFTMetaData has store, key {
        id: 0x2::object::UID,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        name: 0x1::string::String,
        special: bool,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        name: 0x1::string::String,
    }

    struct GOODIE_BAG has drop {
        dummy_field: bool,
    }

    struct Participation_Info has store, key {
        id: 0x2::object::UID,
        stall_name: 0x1::string::String,
        stall_description: 0x1::string::String,
        stall_location: 0x1::string::String,
    }

    struct RandomIndex has copy, drop {
        obj: 0x2::object::ID,
        index: u64,
    }

    struct Point has copy, drop {
        nft_owner: address,
        point: u64,
    }

    struct GoodieBagList has store, key {
        id: 0x2::object::UID,
        item_count: u64,
        goodie_bag_item: vector<0x2::object::ID>,
        has_claimed: 0x2::table::Table<address, bool>,
        merkle_root: vector<u8>,
        calculated_hash: 0x1::string::String,
        leaf_used: 0x2::table::Table<vector<u8>, bool>,
        stall_name: 0x1::string::String,
        stall_description: 0x1::string::String,
        stall_location: 0x1::string::String,
        cool_down_period: 0x2::table::Table<address, u64>,
        user_points_per_stall: 0x2::table::Table<address, u64>,
    }

    struct Participation_NFT has key {
        id: 0x2::object::UID,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        name: 0x1::string::String,
        booth_points: u64,
    }

    struct PopList has store, key {
        id: 0x2::object::UID,
        stall_owner: vector<address>,
        user_received: 0x2::table::Table<address, bool>,
        user_trait_count: 0x2::table::Table<address, u64>,
    }

    public(friend) fun add_other_nft<T0: store + key>(arg0: &mut GoodieBagList, arg1: T0) {
        let v0 = 0x2::object::id<T0>(&arg1);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.goodie_bag_item, v0);
        0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut arg0.id, v0, arg1);
        arg0.item_count = arg0.item_count + 1;
    }

    fun add_participation_info(arg0: address, arg1: Participation_NFT, arg2: &mut PopList, arg3: &GoodieBagList, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, bool>(&arg2.user_received, arg0), 7);
        let v0 = Participation_Info{
            id                : 0x2::object::new(arg4),
            stall_name        : arg3.stall_name,
            stall_description : arg3.stall_description,
            stall_location    : arg3.stall_location,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, Participation_Info>(&mut arg1.id, 0x2::object::id<Participation_Info>(&v0), v0);
        0x2::transfer::transfer<Participation_NFT>(arg1, arg0);
    }

    fun check_cool_down_period(arg0: &mut GoodieBagList, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, u64>(&arg0.cool_down_period, arg1)) {
            0x2::table::add<address, u64>(&mut arg0.cool_down_period, arg1, 0);
        };
        assert!(0x2::clock::timestamp_ms(arg2) > *0x2::table::borrow<address, u64>(&arg0.cool_down_period, arg1), 10);
    }

    public(friend) fun claim_goodie_bag<T0: store + key>(arg0: vector<u8>, arg1: vector<vector<u8>>, arg2: vector<vector<u8>>, arg3: &mut GoodieBagList, arg4: Participation_NFT, arg5: &mut PopList, arg6: u64, arg7: 0x2::object::ID, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(!0x2::table::contains<address, bool>(&arg3.has_claimed, v0), 1);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg3.leaf_used, arg0), 5);
        assert!(verify_merkle(arg0, arg1, arg2) == arg3.merkle_root, 4);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg3.id, arg7), v0);
        arg3.item_count = arg3.item_count - 1;
        0x1::vector::swap_remove<0x2::object::ID>(&mut arg3.goodie_bag_item, arg6);
        0x2::table::add<address, bool>(&mut arg3.has_claimed, v0, true);
        0x2::table::add<vector<u8>, bool>(&mut arg3.leaf_used, arg0, true);
        add_participation_info(v0, arg4, arg5, arg3, arg8);
    }

    public(friend) fun create_goodie_bag(arg0: &mut GoodieBagList, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = NFTMetaData{
            id          : 0x2::object::new(arg4),
            image_url   : arg2,
            description : arg1,
            name        : arg3,
            special     : true,
        };
        let v1 = 0x2::object::id<NFTMetaData>(&v0);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.goodie_bag_item, v1);
        0x2::dynamic_object_field::add<0x2::object::ID, NFTMetaData>(&mut arg0.id, v1, v0);
        arg0.item_count = arg0.item_count + 1;
    }

    public(friend) fun create_goodie_bag_list(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = GoodieBagList{
            id                    : 0x2::object::new(arg3),
            item_count            : 0,
            goodie_bag_item       : 0x1::vector::empty<0x2::object::ID>(),
            has_claimed           : 0x2::table::new<address, bool>(arg3),
            merkle_root           : 0x1::vector::empty<u8>(),
            calculated_hash       : 0x1::string::utf8(b""),
            leaf_used             : 0x2::table::new<vector<u8>, bool>(arg3),
            stall_name            : arg0,
            stall_description     : arg2,
            stall_location        : arg1,
            cool_down_period      : 0x2::table::new<address, u64>(arg3),
            user_points_per_stall : 0x2::table::new<address, u64>(arg3),
        };
        0x2::transfer::public_share_object<GoodieBagList>(v0);
        0x2::object::id<GoodieBagList>(&v0)
    }

    public(friend) fun create_pop_object(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PopList{
            id               : 0x2::object::new(arg0),
            stall_owner      : 0x1::vector::empty<address>(),
            user_received    : 0x2::table::new<address, bool>(arg0),
            user_trait_count : 0x2::table::new<address, u64>(arg0),
        };
        0x2::transfer::public_share_object<PopList>(v0);
    }

    public fun get_random_goodie(arg0: &mut GoodieBagList, arg1: &0x9eea9fa6f1730073268edb3b6b8d5b4795026721d7015e306fde47a610b59d66::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0x9eea9fa6f1730073268edb3b6b8d5b4795026721d7015e306fde47a610b59d66::version::checkVersion(arg1, 2);
        assert!(!0x2::table::contains<address, bool>(&arg0.has_claimed, 0x2::tx_context::sender(arg2)), 1);
        let v0 = arg0.item_count;
        assert!(v0 != 0, 2);
        let v1 = if (v0 == 1) {
            0
        } else {
            0x9eea9fa6f1730073268edb3b6b8d5b4795026721d7015e306fde47a610b59d66::rand::rng(0, v0, arg2) % v0
        };
        let v2 = RandomIndex{
            obj   : *0x1::vector::borrow<0x2::object::ID>(&arg0.goodie_bag_item, v1),
            index : v1,
        };
        0x2::event::emit<RandomIndex>(v2);
    }

    fun increase_cool_down(arg0: &mut GoodieBagList, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::table::remove<address, u64>(&mut arg0.cool_down_period, arg1);
        0x2::table::add<address, u64>(&mut arg0.cool_down_period, arg1, 0x2::clock::timestamp_ms(arg2) + 3600000);
    }

    public fun increase_points(arg0: Participation_NFT, arg1: &mut GoodieBagList, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        check_cool_down_period(arg1, v0, arg2, arg3);
        let v1 = 10;
        let v2 = arg0.booth_points + v1;
        arg0.booth_points = v2;
        increase_cool_down(arg1, v0, arg2, arg3);
        if (!0x2::table::contains<address, u64>(&arg1.user_points_per_stall, v0)) {
            0x2::table::add<address, u64>(&mut arg1.user_points_per_stall, v0, 0 + v1);
        } else {
            0x2::table::add<address, u64>(&mut arg1.user_points_per_stall, v0, 0x2::table::remove<address, u64>(&mut arg1.user_points_per_stall, v0) + v1);
        };
        let v3 = Point{
            nft_owner : v0,
            point     : v2,
        };
        0x2::event::emit<Point>(v3);
        0x2::transfer::transfer<Participation_NFT>(arg0, v0);
    }

    fun init(arg0: GOODIE_BAG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        let v4 = 0x2::package::claim<GOODIE_BAG>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<NFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<NFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mint_participation_token(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut PopList, arg5: &GoodieBagList, arg6: &0x9eea9fa6f1730073268edb3b6b8d5b4795026721d7015e306fde47a610b59d66::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0x9eea9fa6f1730073268edb3b6b8d5b4795026721d7015e306fde47a610b59d66::version::checkVersion(arg6, 2);
        assert!(!0x2::table::contains<address, bool>(&arg4.user_received, arg0), 8);
        let v0 = Participation_NFT{
            id           : 0x2::object::new(arg7),
            image_url    : arg1,
            description  : arg2,
            name         : arg3,
            booth_points : 0,
        };
        0x2::table::add<address, bool>(&mut arg4.user_received, arg0, true);
        let v1 = Participation_Info{
            id                : 0x2::object::new(arg7),
            stall_name        : arg5.stall_name,
            stall_description : arg5.stall_description,
            stall_location    : arg5.stall_location,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, Participation_Info>(&mut v0.id, 0x2::object::id<Participation_Info>(&v1), v1);
        0x2::transfer::transfer<Participation_NFT>(v0, arg0);
    }

    public(friend) fun set_merkle_root(arg0: vector<u8>, arg1: &mut GoodieBagList) {
        arg1.merkle_root = arg0;
    }

    fun verify_merkle(arg0: vector<u8>, arg1: vector<vector<u8>>, arg2: vector<vector<u8>>) : vector<u8> {
        let v0 = 0;
        let v1 = arg0;
        0x1::vector::empty<u8>();
        while (v0 < 0x1::vector::length<vector<u8>>(&arg1)) {
            let v2 = *0x1::vector::borrow<vector<u8>>(&arg2, v0);
            if (0x1::string::utf8(v2) == 0x1::string::utf8(b"left")) {
                let v3 = 0x1::vector::empty<u8>();
                0x1::vector::append<u8>(&mut v3, *0x1::vector::borrow<vector<u8>>(&arg1, v0));
                0x1::vector::append<u8>(&mut v3, v1);
                v1 = 0x1::hash::sha2_256(v3);
            } else if (0x1::string::utf8(v2) == 0x1::string::utf8(b"right")) {
                let v3 = 0x1::vector::empty<u8>();
                0x1::vector::append<u8>(&mut v3, v1);
                0x1::vector::append<u8>(&mut v3, *0x1::vector::borrow<vector<u8>>(&arg1, v0));
                v1 = 0x1::hash::sha2_256(v3);
            };
            v0 = v0 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

