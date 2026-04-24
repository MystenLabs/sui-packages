module 0x7be3eacfc20b23c7c6f0105a3d5ddea8d98958280948f5b581086bc9a9de159d::crusher {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct CollectionConfig has key {
        id: 0x2::object::UID,
        admin: address,
        minted: u64,
        max_supply: u64,
        mint_price: u64,
        crush_fee: u64,
        pool: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct CrusherNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        crush_count: u64,
        rarity: 0x1::string::String,
        serial: u64,
    }

    struct CrushEvent has copy, drop {
        nft_id: 0x2::object::ID,
        target_id: 0x2::object::ID,
        crusher: address,
        crush_count: u64,
        rarity: 0x1::string::String,
    }

    struct MintEvent has copy, drop {
        nft_id: 0x2::object::ID,
        minter: address,
        serial: u64,
    }

    public fun crush_count(arg0: &CrusherNFT) : u64 {
        arg0.crush_count
    }

    public entry fun crush_nft(arg0: &mut CrusherNFT, arg1: CrusherNFT, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut CollectionConfig, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= arg3.crush_fee, 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg3.pool, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg2, arg3.crush_fee, arg4)));
        let CrusherNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
            crush_count : _,
            rarity      : _,
            serial      : _,
        } = arg1;
        0x2::object::delete(v0);
        arg0.crush_count = arg0.crush_count + 1;
        arg0.rarity = get_rarity(arg0.crush_count);
        arg0.url = get_url(arg0.crush_count);
        let v7 = CrushEvent{
            nft_id      : 0x2::object::id<CrusherNFT>(arg0),
            target_id   : 0x2::object::id<CrusherNFT>(&arg1),
            crusher     : 0x2::tx_context::sender(arg4),
            crush_count : arg0.crush_count,
            rarity      : arg0.rarity,
        };
        0x2::event::emit<CrushEvent>(v7);
    }

    public entry fun execute_crush<T0: store + key>(arg0: &mut CrusherNFT, arg1: T0, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut CollectionConfig, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= arg3.crush_fee, 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg3.pool, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg2, arg3.crush_fee, arg4)));
        0x2::transfer::public_transfer<T0>(arg1, @0x0);
        arg0.crush_count = arg0.crush_count + 1;
        arg0.rarity = get_rarity(arg0.crush_count);
        arg0.url = get_url(arg0.crush_count);
        let v0 = CrushEvent{
            nft_id      : 0x2::object::id<CrusherNFT>(arg0),
            target_id   : 0x2::object::id<T0>(&arg1),
            crusher     : 0x2::tx_context::sender(arg4),
            crush_count : arg0.crush_count,
            rarity      : arg0.rarity,
        };
        0x2::event::emit<CrushEvent>(v0);
    }

    fun get_rarity(arg0: u64) : 0x1::string::String {
        if (arg0 >= 500) {
            0x1::string::utf8(b"LEGEND")
        } else if (arg0 >= 200) {
            0x1::string::utf8(b"EPIC")
        } else if (arg0 >= 50) {
            0x1::string::utf8(b"RARE")
        } else {
            0x1::string::utf8(b"COMMON")
        }
    }

    fun get_url(arg0: u64) : 0x2::url::Url {
        if (arg0 >= 500) {
            0x2::url::new_unsafe_from_bytes(b"https://pink-added-bovid-23.mypinata.cloud/ipfs/bafybeigky3iu3zwo7k7lzueyy5kduuwsc7jrag6hkxnann25w63btjafvq")
        } else if (arg0 >= 200) {
            0x2::url::new_unsafe_from_bytes(b"https://pink-added-bovid-23.mypinata.cloud/ipfs/bafybeihxez6ozvrvmg7sapvxw3adt2g7yfhvq635ehkj6bqlldc36jm2ya")
        } else if (arg0 >= 50) {
            0x2::url::new_unsafe_from_bytes(b"https://pink-added-bovid-23.mypinata.cloud/ipfs/bafybeif5ekrt3ixcmj4ndzf4hoeg6bjzliodg6jp6vwris4cjyb7vate6y")
        } else {
            0x2::url::new_unsafe_from_bytes(b"https://pink-added-bovid-23.mypinata.cloud/ipfs/bafybeietaedemjbeid2e4a4hvvf5zh2em6mn3d47n43nfri6mwe7kiesvm")
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v2 = CollectionConfig{
            id         : 0x2::object::new(arg0),
            admin      : v0,
            minted     : 0,
            max_supply : 1000,
            mint_price : 5000000000,
            crush_fee  : 100000000,
            pool       : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<CollectionConfig>(v2);
    }

    public entry fun mint(arg0: &mut CollectionConfig, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= arg0.mint_price, 1);
        assert!(arg0.minted < arg0.max_supply, 2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pool, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg1, arg0.mint_price, arg2)));
        arg0.minted = arg0.minted + 1;
        let v0 = arg0.minted;
        let v1 = CrusherNFT{
            id          : 0x2::object::new(arg2),
            name        : 0x1::string::utf8(b"Scam Crusher"),
            description : 0x1::string::utf8(b"Crush scams on SUI. The more you crush, the rarer you become."),
            url         : get_url(0),
            crush_count : 0,
            rarity      : get_rarity(0),
            serial      : v0,
        };
        let v2 = MintEvent{
            nft_id : 0x2::object::id<CrusherNFT>(&v1),
            minter : 0x2::tx_context::sender(arg2),
            serial : v0,
        };
        0x2::event::emit<MintEvent>(v2);
        0x2::transfer::public_transfer<CrusherNFT>(v1, 0x2::tx_context::sender(arg2));
    }

    public fun pool_balance(arg0: &CollectionConfig) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.pool)
    }

    public fun rarity(arg0: &CrusherNFT) : &0x1::string::String {
        &arg0.rarity
    }

    public fun serial(arg0: &CrusherNFT) : u64 {
        arg0.serial
    }

    public entry fun update_crush_fee(arg0: &AdminCap, arg1: &mut CollectionConfig, arg2: u64) {
        arg1.crush_fee = arg2;
    }

    public entry fun update_max_supply(arg0: &AdminCap, arg1: &mut CollectionConfig, arg2: u64) {
        arg1.max_supply = arg2;
    }

    public entry fun update_mint_price(arg0: &AdminCap, arg1: &mut CollectionConfig, arg2: u64) {
        arg1.mint_price = arg2;
    }

    public entry fun withdraw(arg0: &AdminCap, arg1: &mut CollectionConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.pool) >= arg2, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.pool, arg2), arg3), arg1.admin);
    }

    // decompiled from Move bytecode v7
}

