module 0xa02e929c44834ecb28d50c078eefbc5e9d9af9aad19a3f6833007fc6c34ba69d::tusk {
    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        token_id: u64,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct CollectionManager has key {
        id: 0x2::object::UID,
        total_minted: u64,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        owner: address,
    }

    struct ProjectOwner has store, key {
        id: 0x2::object::UID,
    }

    struct NFTMinted has copy, drop {
        nft_id: address,
        token_id: u64,
        minter: address,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct NFTUpdated has copy, drop {
        nft_id: address,
        token_id: u64,
        new_image_url: 0x1::string::String,
        new_attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        updated_by: address,
    }

    struct FundsWithdrawn has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct TUSK has drop {
        dummy_field: bool,
    }

    fun generate_random_attributes(arg0: u64, arg1: &0x2::tx_context::TxContext) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v1 = 0x2::bcs::to_bytes<u64>(&arg0);
        let v2 = 0x2::tx_context::epoch(arg1);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&v2));
        let v3 = 0x2::hash::keccak256(&v1);
        let v4 = vector[b"blue", b"red", b"green", b"yellow", b"purple", b"orange", b"black", b"white"];
        let v5 = vector[b"robot", b"human", b"alien", b"zombie", b"ghost", b"animal", b"cyborg"];
        let v6 = vector[b"normal", b"angry", b"sleepy", b"surprised", b"cool", b"cute", b"laser"];
        let v7 = vector[b"smile", b"frown", b"open", b"grin", b"shocked", b"neutral", b"tongue"];
        let v8 = vector[b"hat", b"glasses", b"earrings", b"necklace", b"crown", b"mask", b"none"];
        let v9 = vector[b"legendary", b"rare", b"uncommon", b"common", b"unique", b"standard", b"none"];
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"background"), 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&v4, get_random_index(&v3, 0, 0x1::vector::length<vector<u8>>(&v4)))));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"body"), 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&v5, get_random_index(&v3, 1, 0x1::vector::length<vector<u8>>(&v5)))));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"eyes"), 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&v6, get_random_index(&v3, 2, 0x1::vector::length<vector<u8>>(&v6)))));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"mouth"), 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&v7, get_random_index(&v3, 3, 0x1::vector::length<vector<u8>>(&v7)))));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"accessory"), 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&v8, get_random_index(&v3, 4, 0x1::vector::length<vector<u8>>(&v8)))));
        let v10 = get_random_index(&v3, 5, 100);
        let v11 = if (v10 < 5) {
            *0x1::vector::borrow<vector<u8>>(&v9, 0)
        } else if (v10 < 15) {
            *0x1::vector::borrow<vector<u8>>(&v9, 1)
        } else if (v10 < 35) {
            *0x1::vector::borrow<vector<u8>>(&v9, 2)
        } else if (v10 < 85) {
            *0x1::vector::borrow<vector<u8>>(&v9, 3)
        } else if (v10 < 95) {
            *0x1::vector::borrow<vector<u8>>(&v9, 4)
        } else {
            *0x1::vector::borrow<vector<u8>>(&v9, 5)
        };
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"special"), 0x1::string::utf8(v11));
        v0
    }

    fun generate_random_id(arg0: u64, arg1: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::bcs::to_bytes<address>(&v0);
        let v2 = 0x2::tx_context::epoch(arg1);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&v2));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg0));
        let v3 = 0x2::hash::keccak256(&v1);
        let v4 = 0x1::vector::empty<u8>();
        let v5 = 0;
        while (v5 < 8) {
            if (v5 < 0x1::vector::length<u8>(&v3)) {
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v3, v5));
            };
            v5 = v5 + 1;
        };
        let v6 = 0;
        v5 = 0;
        while (v5 < 0x1::vector::length<u8>(&v4)) {
            let v7 = v6 << 8;
            v6 = v7 + (*0x1::vector::borrow<u8>(&v4, v5) as u64);
            v5 = v5 + 1;
        };
        v6 % 100 + arg0 * 100 + 1
    }

    public fun get_attributes(arg0: &NFT) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.attributes
    }

    public fun get_description(arg0: &NFT) : &0x1::string::String {
        &arg0.description
    }

    public fun get_image_url(arg0: &NFT) : &0x1::string::String {
        &arg0.image_url
    }

    public fun get_max_supply() : u64 {
        100
    }

    public fun get_name(arg0: &NFT) : &0x1::string::String {
        &arg0.name
    }

    fun get_random_index(arg0: &vector<u8>, arg1: u64, arg2: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        let v0 = arg1 * 4 % 0x1::vector::length<u8>(arg0);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 4 && v0 + v2 < 0x1::vector::length<u8>(arg0)) {
            let v3 = v1 << 8;
            v1 = v3 + (*0x1::vector::borrow<u8>(arg0, v0 + v2) as u64);
            v2 = v2 + 1;
        };
        v1 % arg2
    }

    public fun get_token_id(arg0: &NFT) : u64 {
        arg0.token_id
    }

    public fun get_total_minted(arg0: &CollectionManager) : u64 {
        arg0.total_minted
    }

    public fun get_treasury_balance(arg0: &CollectionManager) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.treasury)
    }

    fun init(arg0: TUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<TUSK>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"token_id"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"attributes"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"background"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"body"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"eyes"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"mouth"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"accessory"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"special"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{token_id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{attributes}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{attributes.background}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{attributes.body}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{attributes.eyes}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{attributes.mouth}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{attributes.accessory}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{attributes.special}"));
        let v5 = 0x2::display::new_with_fields<NFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<NFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        let v6 = CollectionManager{
            id           : 0x2::object::new(arg1),
            total_minted : 0,
            treasury     : 0x2::balance::zero<0x2::sui::SUI>(),
            owner        : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<CollectionManager>(v6);
        let v7 = ProjectOwner{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<ProjectOwner>(v7, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut CollectionManager, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.total_minted < 100, 4);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 1000, 0);
        process_payment(arg0, arg1, arg2);
        let v0 = generate_random_id(arg0.total_minted, arg2);
        let v1 = 0x1::string::utf8(b"TUSK NFT #");
        0x1::string::append(&mut v1, u64_to_string(v0));
        let v2 = 0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeibjpeexzxrcmadl4grgcheudmkhscqy3lh7xpsasvi3ingrca6g2y/");
        0x1::string::append(&mut v2, u64_to_string(v0));
        0x1::string::append(&mut v2, 0x1::string::utf8(b".png"));
        let v3 = NFT{
            id          : 0x2::object::new(arg2),
            name        : v1,
            description : 0x1::string::utf8(b"A Community Taken Tusk NFT Collection"),
            image_url   : v2,
            token_id    : v0,
            attributes  : generate_random_attributes(v0, arg2),
        };
        arg0.total_minted = arg0.total_minted + 1;
        let v4 = NFTMinted{
            nft_id     : 0x2::object::uid_to_address(&v3.id),
            token_id   : v0,
            minter     : 0x2::tx_context::sender(arg2),
            attributes : v3.attributes,
        };
        0x2::event::emit<NFTMinted>(v4);
        0x2::transfer::public_transfer<NFT>(v3, 0x2::tx_context::sender(arg2));
    }

    fun process_payment(arg0: &mut CollectionManager, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        if (v0 > 1000) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.treasury, v0 - 1000), arg2), 0x2::tx_context::sender(arg2));
        };
    }

    fun u64_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0x1::vector::length<u8>(&v0);
        while (v2 > 0) {
            v2 = v2 - 1;
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, v2));
        };
        0x1::string::utf8(v1)
    }

    public entry fun update_nft(arg0: &ProjectOwner, arg1: &mut NFT, arg2: vector<u8>, arg3: vector<vector<u8>>, arg4: &mut 0x2::tx_context::TxContext) {
        arg1.image_url = 0x1::string::utf8(arg2);
        if (0x1::vector::length<vector<u8>>(&arg3) > 0) {
            arg1.attributes = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
            let v0 = 0;
            while (v0 + 1 < 0x1::vector::length<vector<u8>>(&arg3)) {
                0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg1.attributes, 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg3, v0)), 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg3, v0 + 1)));
                v0 = v0 + 2;
            };
        };
        let v1 = NFTUpdated{
            nft_id         : 0x2::object::uid_to_address(&arg1.id),
            token_id       : arg1.token_id,
            new_image_url  : arg1.image_url,
            new_attributes : arg1.attributes,
            updated_by     : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<NFTUpdated>(v1);
    }

    public entry fun withdraw_funds(arg0: &ProjectOwner, arg1: &mut CollectionManager, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.owner, 3);
        let v0 = FundsWithdrawn{
            amount    : arg2,
            recipient : arg1.owner,
        };
        0x2::event::emit<FundsWithdrawn>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.treasury, arg2), arg3), arg1.owner);
    }

    // decompiled from Move bytecode v6
}

