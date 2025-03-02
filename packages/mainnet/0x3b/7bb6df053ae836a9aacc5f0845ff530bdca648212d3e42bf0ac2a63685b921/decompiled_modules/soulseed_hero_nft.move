module 0x3b7bb6df053ae836a9aacc5f0845ff530bdca648212d3e42bf0ac2a63685b921::soulseed_hero_nft {
    struct SOULSEED_HERO_NFT has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct SoulSeedHeroNFT has store, key {
        id: 0x2::object::UID,
        hero_id: u64,
        name: 0x1::string::String,
        collection: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
        stats_id: 0x2::object::ID,
        creator: address,
        mint_time: u64,
    }

    struct NFTStats has key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        stat_names: vector<0x1::string::String>,
    }

    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        hero_id: u64,
        creator: address,
        recipient: address,
    }

    struct NFTTransferred has copy, drop {
        nft_id: 0x2::object::ID,
        hero_id: u64,
        from: address,
        to: address,
    }

    public entry fun add_stat<T0: copy + drop + store>(arg0: &AdminCap, arg1: &mut NFTStats, arg2: 0x1::string::String, arg3: T0) {
        assert!(!0x2::dynamic_field::exists_<0x1::string::String>(&arg1.id, arg2), 1);
        0x2::dynamic_field::add<0x1::string::String, T0>(&mut arg1.id, arg2, arg3);
        0x1::vector::push_back<0x1::string::String>(&mut arg1.stat_names, arg2);
    }

    public fun get_collection(arg0: &SoulSeedHeroNFT) : &0x1::string::String {
        &arg0.collection
    }

    public fun get_creator(arg0: &SoulSeedHeroNFT) : address {
        arg0.creator
    }

    public fun get_description(arg0: &SoulSeedHeroNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun get_hero_id(arg0: &SoulSeedHeroNFT) : u64 {
        arg0.hero_id
    }

    public fun get_image(arg0: &SoulSeedHeroNFT) : &0x1::string::String {
        &arg0.url
    }

    public fun get_mint_time(arg0: &SoulSeedHeroNFT) : u64 {
        arg0.mint_time
    }

    public fun get_name(arg0: &SoulSeedHeroNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun get_stat<T0: store>(arg0: &NFTStats, arg1: 0x1::string::String) : &T0 {
        0x2::dynamic_field::borrow<0x1::string::String, T0>(&arg0.id, arg1)
    }

    public fun get_stat_names(arg0: &NFTStats) : &vector<0x1::string::String> {
        &arg0.stat_names
    }

    fun init(arg0: SOULSEED_HERO_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SOULSEED_HERO_NFT>(arg0, arg1);
        let v1 = 0x2::tx_context::sender(arg1);
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v2, v1);
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"collection_cover_url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"collection_description"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"collection_name"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"collection"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"media_url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"mint_time"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"hero_id"));
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"https://soulseed.io/images/hero_collection.jpg"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"Powerful Heroes to play in the SoulSeed Gaming Platform!"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"SoulSeed Heroes"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"SoulSeed Heroes"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"https://hero.soulseed.io"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{creator}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{mint_time}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{hero_id}"));
        let v7 = 0x2::display::new_with_fields<SoulSeedHeroNFT>(&v0, v3, v5, arg1);
        0x2::display::add<SoulSeedHeroNFT>(&mut v7, 0x1::string::utf8(b"type"), 0x1::string::utf8(b"NFT"));
        0x2::display::update_version<SoulSeedHeroNFT>(&mut v7);
        0x2::transfer::public_share_object<0x2::display::Display<SoulSeedHeroNFT>>(v7);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v1);
    }

    public entry fun mint(arg0: &AdminCap, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 0);
        let v0 = NFTStats{
            id         : 0x2::object::new(arg7),
            nft_id     : 0x2::object::id_from_address(@0x0),
            stat_names : 0x1::vector::empty<0x1::string::String>(),
        };
        let v1 = SoulSeedHeroNFT{
            id          : 0x2::object::new(arg7),
            hero_id     : arg1,
            name        : arg2,
            collection  : arg3,
            description : arg4,
            url         : arg5,
            stats_id    : 0x2::object::id<NFTStats>(&v0),
            creator     : 0x2::tx_context::sender(arg7),
            mint_time   : 0x2::tx_context::epoch(arg7),
        };
        let v2 = 0x2::object::id<SoulSeedHeroNFT>(&v1);
        v0.nft_id = v2;
        let v3 = NFTMinted{
            nft_id    : v2,
            hero_id   : arg1,
            creator   : 0x2::tx_context::sender(arg7),
            recipient : arg6,
        };
        0x2::event::emit<NFTMinted>(v3);
        0x2::transfer::share_object<NFTStats>(v0);
        0x2::transfer::transfer<SoulSeedHeroNFT>(v1, arg6);
    }

    public entry fun modify_stat<T0: copy + drop + store>(arg0: &AdminCap, arg1: &mut NFTStats, arg2: 0x1::string::String, arg3: T0) {
        assert!(0x2::dynamic_field::exists_<0x1::string::String>(&arg1.id, arg2), 1);
        0x2::dynamic_field::remove<0x1::string::String, T0>(&mut arg1.id, arg2);
        0x2::dynamic_field::add<0x1::string::String, T0>(&mut arg1.id, arg2, arg3);
    }

    public entry fun transfer_nft(arg0: SoulSeedHeroNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = NFTTransferred{
            nft_id  : 0x2::object::id<SoulSeedHeroNFT>(&arg0),
            hero_id : arg0.hero_id,
            from    : 0x2::tx_context::sender(arg2),
            to      : arg1,
        };
        0x2::event::emit<NFTTransferred>(v0);
        0x2::transfer::transfer<SoulSeedHeroNFT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

