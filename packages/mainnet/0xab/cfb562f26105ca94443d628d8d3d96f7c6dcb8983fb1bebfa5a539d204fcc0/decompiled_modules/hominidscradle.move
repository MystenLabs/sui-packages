module 0xabcfb562f26105ca94443d628d8d3d96f7c6dcb8983fb1bebfa5a539d204fcc0::hominidscradle {
    struct MintConfig has key {
        id: 0x2::object::UID,
        owner: address,
        funds: 0x2::balance::Balance<0x2::sui::SUI>,
        freemint: 0x2::table::Table<address, u64>,
        whitelist: 0x2::table::Table<address, u64>,
        public_list: 0x2::table::Table<address, u64>,
        whitelist_price: u64,
        public_price: u64,
        max_mint_freemint: u64,
        max_mint_whitelist: u64,
        max_mint_public: u64,
        minted: u64,
        supply: u64,
        base_name: 0x1::string::String,
        base_image_url: 0x1::string::String,
        base_url: 0x1::string::String,
        rarities: vector<0x1::string::String>,
    }

    struct HominidsCradle has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        url: 0x1::string::String,
        rarity: 0x1::string::String,
    }

    struct HOMINIDSCRADLE has drop {
        dummy_field: bool,
    }

    public entry fun add_freemint(arg0: &mut MintConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        0x2::table::add<address, u64>(&mut arg0.freemint, arg1, 0);
    }

    public entry fun add_whitelist(arg0: &mut MintConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        0x2::table::add<address, u64>(&mut arg0.whitelist, arg1, 0);
    }

    public entry fun deploy_rarity(arg0: &mut MintConfig, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        0x1::vector::push_back<0x1::string::String>(&mut arg0.rarities, 0x1::string::utf8(arg1));
    }

    public entry fun free_mint(arg0: &mut MintConfig, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.minted + 1 <= arg0.supply, 7);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, u64>(&arg0.freemint, v0), 1);
        assert!(*0x2::table::borrow<address, u64>(&arg0.freemint, v0) + 1 <= arg0.max_mint_freemint, 4);
        let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.freemint, v0);
        *v1 = *v1 + 1;
        internal_mint(arg0, v0, arg1);
    }

    fun init(arg0: HOMINIDSCRADLE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://era-homi.xyz/nft/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Hominids X Cradle partnership collection, art of the Hominids and the AI generation of cradle."));
        let v4 = 0x2::package::claim<HOMINIDSCRADLE>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<HominidsCradle>(&v4, v0, v2, arg1);
        0x2::display::update_version<HominidsCradle>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<HominidsCradle>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = MintConfig{
            id                 : 0x2::object::new(arg1),
            owner              : 0x2::tx_context::sender(arg1),
            funds              : 0x2::balance::zero<0x2::sui::SUI>(),
            freemint           : 0x2::table::new<address, u64>(arg1),
            whitelist          : 0x2::table::new<address, u64>(arg1),
            public_list        : 0x2::table::new<address, u64>(arg1),
            whitelist_price    : 5000000000,
            public_price       : 10000000000,
            max_mint_freemint  : 1,
            max_mint_whitelist : 1,
            max_mint_public    : 10,
            minted             : 0,
            supply             : 333,
            base_name          : 0x1::string::utf8(b"Hominids X Cradle #"),
            base_image_url     : 0x1::string::utf8(b"https://hominids.io/hominids_ipfs/cradle/"),
            base_url           : 0x1::string::utf8(b"https://hominids.io/hominids_ipfs/cradle/json/"),
            rarities           : 0x1::vector::empty<0x1::string::String>(),
        };
        0x2::transfer::share_object<MintConfig>(v6);
    }

    fun internal_mint(arg0: &mut MintConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.minted;
        let v1 = v0 + 1;
        let v2 = arg0.base_name;
        0x1::string::append(&mut v2, num_str(v1));
        let v3 = arg0.base_image_url;
        0x1::string::append(&mut v3, num_str(v1));
        0x1::string::append(&mut v3, 0x1::string::utf8(b".png"));
        let v4 = arg0.base_url;
        0x1::string::append(&mut v4, num_str(v1));
        0x1::string::append(&mut v4, 0x1::string::utf8(b".json"));
        0x1::debug::print<0x1::string::String>(&v2);
        let v5 = *0x1::vector::borrow<0x1::string::String>(&arg0.rarities, v0);
        0x1::debug::print<0x1::string::String>(&v5);
        let v6 = HominidsCradle{
            id        : 0x2::object::new(arg2),
            name      : v2,
            image_url : v3,
            url       : v4,
            rarity    : v5,
        };
        0x2::transfer::transfer<HominidsCradle>(v6, arg1);
        arg0.minted = arg0.minted + 1;
    }

    fun num_str(arg0: u64) : 0x1::string::String {
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 / 10 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10 + 48) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::push_back<u8>(&mut v0, ((arg0 + 48) as u8));
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    public entry fun public_mint(arg0: &mut MintConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.minted + 1 <= arg0.supply, 7);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg0.public_price, 1);
        if (0x2::table::contains<address, u64>(&arg0.public_list, v0)) {
            assert!(*0x2::table::borrow<address, u64>(&arg0.public_list, v0) + 1 <= arg0.max_mint_public, 6);
            let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.public_list, v0);
            *v1 = *v1 + 1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.public_list, v0, 1);
        };
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.funds, arg1);
        internal_mint(arg0, v0, arg2);
    }

    public entry fun update_freemint_max(arg0: &mut MintConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.max_mint_freemint = arg1;
    }

    public entry fun update_public_max(arg0: &mut MintConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.max_mint_public = arg1;
    }

    public entry fun update_public_price(arg0: &mut MintConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.public_price = arg1;
    }

    public entry fun update_whitelist_max(arg0: &mut MintConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.max_mint_whitelist = arg1;
    }

    public entry fun update_whitelist_price(arg0: &mut MintConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.whitelist_price = arg1;
    }

    public entry fun whitelist_mint(arg0: &mut MintConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.minted + 1 <= arg0.supply, 7);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, u64>(&arg0.whitelist, v0), 1);
        assert!(*0x2::table::borrow<address, u64>(&arg0.whitelist, v0) + 1 <= arg0.max_mint_whitelist, 5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg0.whitelist_price, 1);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.funds, arg1);
        let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.whitelist, v0);
        *v1 = *v1 + 1;
        internal_mint(arg0, v0, arg2);
    }

    public entry fun withdraw(arg0: &mut MintConfig, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.funds, 0x2::balance::value<0x2::sui::SUI>(&arg0.funds), arg1), arg0.owner);
    }

    // decompiled from Move bytecode v6
}

