module 0x7accef943d6f6ef1ba3528f1b68c9e3e6f7901949806517eb535d44454738c4d::batch_nft {
    struct Hero has store, key {
        id: 0x2::object::UID,
        number: u64,
    }

    struct NFTStorage has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        project_url: 0x1::string::String,
        creator: 0x1::string::String,
        available_nfts: vector<Hero>,
        total_created: u64,
        distributed: u64,
    }

    struct BATCH_NFT has drop {
        dummy_field: bool,
    }

    struct BatchMintEvent has copy, drop {
        storage_id: 0x2::object::ID,
        count: u64,
        total_created: u64,
    }

    struct DistributeEvent has copy, drop {
        nft_id: 0x2::object::ID,
        nft_number: u64,
        recipient: address,
        remaining: u64,
    }

    public entry fun create_storage(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = NFTStorage{
            id             : 0x2::object::new(arg5),
            name           : arg0,
            description    : arg1,
            image_url      : arg2,
            project_url    : arg3,
            creator        : arg4,
            available_nfts : 0x1::vector::empty<Hero>(),
            total_created  : 0,
            distributed    : 0,
        };
        0x2::transfer::share_object<NFTStorage>(v0);
    }

    public entry fun distribute_batch_multiple(arg0: &mut NFTStorage, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(0x1::vector::length<Hero>(&arg0.available_nfts) >= v0, 2);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<address>(&arg1, v1);
            let v3 = 0x1::vector::pop_back<Hero>(&mut arg0.available_nfts);
            arg0.distributed = arg0.distributed + 1;
            let v4 = DistributeEvent{
                nft_id     : 0x2::object::id<Hero>(&v3),
                nft_number : v3.number,
                recipient  : v2,
                remaining  : 0x1::vector::length<Hero>(&arg0.available_nfts),
            };
            0x2::event::emit<DistributeEvent>(v4);
            0x2::transfer::transfer<Hero>(v3, v2);
            v1 = v1 + 1;
        };
    }

    public entry fun distribute_batch_single(arg0: &mut NFTStorage, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<Hero>(&arg0.available_nfts) >= arg2, 1);
        let v0 = 0;
        while (v0 < arg2) {
            let v1 = 0x1::vector::pop_back<Hero>(&mut arg0.available_nfts);
            arg0.distributed = arg0.distributed + 1;
            let v2 = DistributeEvent{
                nft_id     : 0x2::object::id<Hero>(&v1),
                nft_number : v1.number,
                recipient  : arg1,
                remaining  : 0x1::vector::length<Hero>(&arg0.available_nfts),
            };
            0x2::event::emit<DistributeEvent>(v2);
            0x2::transfer::transfer<Hero>(v1, arg1);
            v0 = v0 + 1;
        };
    }

    public entry fun distribute_custom(arg0: &mut NFTStorage, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1);
        let v1 = 0x1::vector::length<u64>(&arg2);
        assert!(v0 == v1, 4);
        let v2 = 0;
        let v3 = 0;
        while (v3 < v1) {
            v2 = v2 + *0x1::vector::borrow<u64>(&arg2, v3);
            v3 = v3 + 1;
        };
        assert!(0x1::vector::length<Hero>(&arg0.available_nfts) >= v2, 5);
        let v4 = 0;
        while (v4 < v0) {
            let v5 = *0x1::vector::borrow<address>(&arg1, v4);
            let v6 = 0;
            while (v6 < *0x1::vector::borrow<u64>(&arg2, v4)) {
                let v7 = 0x1::vector::pop_back<Hero>(&mut arg0.available_nfts);
                arg0.distributed = arg0.distributed + 1;
                let v8 = DistributeEvent{
                    nft_id     : 0x2::object::id<Hero>(&v7),
                    nft_number : v7.number,
                    recipient  : v5,
                    remaining  : 0x1::vector::length<Hero>(&arg0.available_nfts),
                };
                0x2::event::emit<DistributeEvent>(v8);
                0x2::transfer::transfer<Hero>(v7, v5);
                v6 = v6 + 1;
            };
            v4 = v4 + 1;
        };
    }

    public entry fun distribute_equal(arg0: &mut NFTStorage, arg1: vector<address>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(0x1::vector::length<Hero>(&arg0.available_nfts) >= v0 * arg2, 3);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<address>(&arg1, v1);
            let v3 = 0;
            while (v3 < arg2) {
                let v4 = 0x1::vector::pop_back<Hero>(&mut arg0.available_nfts);
                arg0.distributed = arg0.distributed + 1;
                let v5 = DistributeEvent{
                    nft_id     : 0x2::object::id<Hero>(&v4),
                    nft_number : v4.number,
                    recipient  : v2,
                    remaining  : 0x1::vector::length<Hero>(&arg0.available_nfts),
                };
                0x2::event::emit<DistributeEvent>(v5);
                0x2::transfer::transfer<Hero>(v4, v2);
                v3 = v3 + 1;
            };
            v1 = v1 + 1;
        };
    }

    public entry fun distribute_nft(arg0: &mut NFTStorage, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1::vector::is_empty<Hero>(&arg0.available_nfts), 0);
        let v0 = 0x1::vector::pop_back<Hero>(&mut arg0.available_nfts);
        arg0.distributed = arg0.distributed + 1;
        let v1 = DistributeEvent{
            nft_id     : 0x2::object::id<Hero>(&v0),
            nft_number : v0.number,
            recipient  : arg1,
            remaining  : 0x1::vector::length<Hero>(&arg0.available_nfts),
        };
        0x2::event::emit<DistributeEvent>(v1);
        0x2::transfer::transfer<Hero>(v0, arg1);
    }

    public fun get_available_count(arg0: &NFTStorage) : u64 {
        0x1::vector::length<Hero>(&arg0.available_nfts)
    }

    public fun get_storage_info(arg0: &NFTStorage) : (0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String) {
        (arg0.name, arg0.description, arg0.image_url, arg0.project_url, arg0.creator)
    }

    public fun get_storage_stats(arg0: &NFTStorage) : (u64, u64, u64) {
        (arg0.total_created, arg0.distributed, 0x1::vector::length<Hero>(&arg0.available_nfts))
    }

    fun init(arg0: BATCH_NFT, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name} #{number}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{project_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{project_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{creator}"));
        let v4 = 0x2::package::claim<BATCH_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Hero>(&v4, v0, v2, arg1);
        0x2::display::update_version<Hero>(&mut v5);
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"available"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"total_created"));
        let v8 = 0x1::vector::empty<0x1::string::String>();
        let v9 = &mut v8;
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{name} Storage"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"NFT Collection Storage: {description}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{project_url}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{creator}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{available_nfts}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{total_created}"));
        let v10 = 0x2::display::new_with_fields<NFTStorage>(&v4, v6, v8, arg1);
        0x2::display::update_version<NFTStorage>(&mut v10);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Hero>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFTStorage>>(v10, 0x2::tx_context::sender(arg1));
    }

    public entry fun pre_mint_batch(arg0: &mut NFTStorage, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg1) {
            let v1 = Hero{
                id     : 0x2::object::new(arg2),
                number : arg0.total_created + 1,
            };
            0x1::vector::push_back<Hero>(&mut arg0.available_nfts, v1);
            arg0.total_created = arg0.total_created + 1;
            v0 = v0 + 1;
        };
        let v2 = BatchMintEvent{
            storage_id    : 0x2::object::id<NFTStorage>(arg0),
            count         : arg1,
            total_created : arg0.total_created,
        };
        0x2::event::emit<BatchMintEvent>(v2);
    }

    public entry fun regular_mint(arg0: &mut NFTStorage, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.total_created + 1;
        arg0.total_created = arg0.total_created + 1;
        arg0.distributed = arg0.distributed + 1;
        let v1 = Hero{
            id     : 0x2::object::new(arg2),
            number : v0,
        };
        let v2 = DistributeEvent{
            nft_id     : 0x2::object::id<Hero>(&v1),
            nft_number : v0,
            recipient  : arg1,
            remaining  : 0x1::vector::length<Hero>(&arg0.available_nfts),
        };
        0x2::event::emit<DistributeEvent>(v2);
        0x2::transfer::transfer<Hero>(v1, arg1);
    }

    // decompiled from Move bytecode v6
}

