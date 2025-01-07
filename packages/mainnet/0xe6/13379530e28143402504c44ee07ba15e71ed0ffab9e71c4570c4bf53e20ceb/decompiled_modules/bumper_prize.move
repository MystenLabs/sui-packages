module 0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::bumper_prize {
    struct NFTMetaData has store, key {
        id: 0x2::object::UID,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        name: 0x1::string::String,
    }

    struct RandomIndex has copy, drop {
        obj: 0x2::object::ID,
        index: u64,
    }

    struct NFT has key {
        id: 0x2::object::UID,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        name: 0x1::string::String,
    }

    struct BUMPER_PRIZE has drop {
        dummy_field: bool,
    }

    struct BumperPrizeList has store, key {
        id: 0x2::object::UID,
        item_count: u64,
        bumper_item: vector<0x2::object::ID>,
        wallet_address: vector<address>,
    }

    public(friend) fun add_other_nft_in_event_bumper<T0: store + key>(arg0: &mut BumperPrizeList, arg1: T0) {
        let v0 = 0x2::object::id<T0>(&arg1);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.bumper_item, v0);
        0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut arg0.id, v0, arg1);
        arg0.item_count = arg0.item_count + 1;
    }

    public(friend) fun claim_bumper_prize<T0: store + key>(arg0: &mut BumperPrizeList, arg1: u64, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.item_count != 0, 1);
        let v0 = 0x1::vector::length<address>(&arg0.wallet_address);
        assert!(v0 != 0, 2);
        let v1 = if (v0 == 1) {
            0
        } else {
            0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::rand::rng(0, v0, arg3) % v0
        };
        arg0.item_count = arg0.item_count - 1;
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, arg2), *0x1::vector::borrow<address>(&arg0.wallet_address, v1));
        0x1::vector::swap_remove<0x2::object::ID>(&mut arg0.bumper_item, arg1);
        0x1::vector::swap_remove<address>(&mut arg0.wallet_address, v1);
    }

    public(friend) fun create_bumper_list(arg0: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = BumperPrizeList{
            id             : 0x2::object::new(arg0),
            item_count     : 0,
            bumper_item    : 0x1::vector::empty<0x2::object::ID>(),
            wallet_address : 0x1::vector::empty<address>(),
        };
        0x2::transfer::public_share_object<BumperPrizeList>(v0);
        0x2::object::id<BumperPrizeList>(&v0)
    }

    public(friend) fun create_bumper_prize(arg0: &mut BumperPrizeList, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = NFTMetaData{
            id          : 0x2::object::new(arg4),
            image_url   : arg2,
            description : arg1,
            name        : arg3,
        };
        let v1 = 0x2::object::id<NFTMetaData>(&v0);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.bumper_item, v1);
        0x2::dynamic_object_field::add<0x2::object::ID, NFTMetaData>(&mut arg0.id, v1, v0);
        arg0.item_count = arg0.item_count + 1;
    }

    public(friend) fun get_random_in_bumper(arg0: &BumperPrizeList, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.item_count != 0, 1);
        assert!(0x1::vector::length<address>(&arg0.wallet_address) != 0, 2);
        let v0 = arg0.item_count;
        let v1 = if (v0 == 1) {
            0
        } else {
            0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::rand::rng(0, v0, arg1) % v0
        };
        let v2 = RandomIndex{
            obj   : *0x1::vector::borrow<0x2::object::ID>(&arg0.bumper_item, v1),
            index : v1,
        };
        0x2::event::emit<RandomIndex>(v2);
    }

    fun init(arg0: BUMPER_PRIZE, arg1: &mut 0x2::tx_context::TxContext) {
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
        let v4 = 0x2::package::claim<BUMPER_PRIZE>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<NFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<NFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun set_wallet_address(arg0: &mut BumperPrizeList, arg1: address) {
        0x1::vector::push_back<address>(&mut arg0.wallet_address, arg1);
    }

    // decompiled from Move bytecode v6
}

