module 0x1624a78e4ea737c12f95515e40d53f0ffac2f499639f19359d0611893aa644e9::collection {
    struct NFT has store, key {
        id: 0x2::object::UID,
        number: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        rarity: 0x1::string::String,
    }

    struct COLLECTION has drop {
        dummy_field: bool,
    }

    struct MintCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintConfig has key {
        id: 0x2::object::UID,
        admin: address,
        treasury: address,
        mint_price_mist: u64,
    }

    struct Pool has key {
        id: 0x2::object::UID,
        nfts: vector<NFT>,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        number: u64,
        name: 0x1::string::String,
        recipient: address,
    }

    struct NFTPurchased has copy, drop {
        object_id: 0x2::object::ID,
        number: u64,
        buyer: address,
        price_mist: u64,
    }

    public entry fun batch_deposit(arg0: &MintCap, arg1: &mut Pool, arg2: vector<u64>, arg3: vector<vector<u8>>, arg4: vector<vector<u8>>, arg5: vector<vector<u8>>, arg6: vector<vector<u8>>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u64>(&arg2);
        assert!(0x1::vector::length<vector<u8>>(&arg3) == v0, 0);
        assert!(0x1::vector::length<vector<u8>>(&arg4) == v0, 0);
        assert!(0x1::vector::length<vector<u8>>(&arg5) == v0, 0);
        assert!(0x1::vector::length<vector<u8>>(&arg6) == v0, 0);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = NFT{
                id          : 0x2::object::new(arg7),
                number      : *0x1::vector::borrow<u64>(&arg2, v1),
                name        : 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg3, v1)),
                description : 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg4, v1)),
                image_url   : 0x2::url::new_unsafe_from_bytes(*0x1::vector::borrow<vector<u8>>(&arg5, v1)),
                rarity      : 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg6, v1)),
            };
            let v3 = NFTMinted{
                object_id : 0x2::object::id<NFT>(&v2),
                number    : v2.number,
                name      : v2.name,
                recipient : @0x0,
            };
            0x2::event::emit<NFTMinted>(v3);
            0x1::vector::push_back<NFT>(&mut arg1.nfts, v2);
            v1 = v1 + 1;
        };
    }

    public entry fun burn(arg0: NFT) {
        let NFT {
            id          : v0,
            number      : _,
            name        : _,
            description : _,
            image_url   : _,
            rarity      : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &NFT) : &0x1::string::String {
        &arg0.description
    }

    public fun image_url(arg0: &NFT) : &0x2::url::Url {
        &arg0.image_url
    }

    fun init(arg0: COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"rarity"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://black-persistent-capybara-279.mypinata.cloud/ipfs/bafybeibcs6wmqckyw2xmsl3u2m6si2uww5orz4l6ewbmio5scmllvux7le/"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Tree NFT Collection"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{rarity}"));
        let v5 = 0x2::package::claim<COLLECTION>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<NFT>(&v5, v1, v3, arg1);
        0x2::display::update_version<NFT>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, v0);
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v6, v0);
        let v7 = MintCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<MintCap>(v7, v0);
        let v8 = MintConfig{
            id              : 0x2::object::new(arg1),
            admin           : v0,
            treasury        : @0x956624f2fbbdf16bb5e334b550efd975ff7677e34bbd4e18cb6f485756af6c08,
            mint_price_mist : 25000000000,
        };
        0x2::transfer::share_object<MintConfig>(v8);
        let v9 = Pool{
            id   : 0x2::object::new(arg1),
            nfts : 0x1::vector::empty<NFT>(),
        };
        0x2::transfer::share_object<Pool>(v9);
    }

    public entry fun mint(arg0: &MintCap, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = NFT{
            id          : 0x2::object::new(arg7),
            number      : arg1,
            name        : 0x1::string::utf8(arg2),
            description : 0x1::string::utf8(arg3),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg4),
            rarity      : 0x1::string::utf8(arg5),
        };
        let v1 = NFTMinted{
            object_id : 0x2::object::id<NFT>(&v0),
            number    : arg1,
            name      : v0.name,
            recipient : arg6,
        };
        0x2::event::emit<NFTMinted>(v1);
        0x2::transfer::public_transfer<NFT>(v0, arg6);
    }

    public fun mint_price_mist(arg0: &MintConfig) : u64 {
        arg0.mint_price_mist
    }

    public fun name(arg0: &NFT) : &0x1::string::String {
        &arg0.name
    }

    public fun number(arg0: &NFT) : u64 {
        arg0.number
    }

    public fun pool_size(arg0: &Pool) : u64 {
        0x1::vector::length<NFT>(&arg0.nfts)
    }

    public entry fun purchase(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &MintConfig, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1::vector::is_empty<NFT>(&arg0.nfts), 5);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 >= arg2.mint_price_mist, 4);
        if (v1 > arg2.mint_price_mist) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v1 - arg2.mint_price_mist, arg3), v0);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg2.treasury);
        let v2 = 0x1::vector::pop_back<NFT>(&mut arg0.nfts);
        let v3 = NFTPurchased{
            object_id  : 0x2::object::id<NFT>(&v2),
            number     : v2.number,
            buyer      : v0,
            price_mist : arg2.mint_price_mist,
        };
        0x2::event::emit<NFTPurchased>(v3);
        0x2::transfer::public_transfer<NFT>(v2, v0);
    }

    public fun rarity(arg0: &NFT) : &0x1::string::String {
        &arg0.rarity
    }

    public entry fun set_mint_price(arg0: &mut MintConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        assert!(arg1 > 0, 3);
        arg0.mint_price_mist = arg1;
    }

    public entry fun set_treasury(arg0: &mut MintConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        assert!(arg1 != @0x0, 2);
        arg0.treasury = arg1;
    }

    public fun treasury(arg0: &MintConfig) : address {
        arg0.treasury
    }

    // decompiled from Move bytecode v6
}

