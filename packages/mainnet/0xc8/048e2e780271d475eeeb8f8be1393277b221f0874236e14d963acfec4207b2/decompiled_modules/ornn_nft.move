module 0xc8048e2e780271d475eeeb8f8be1393277b221f0874236e14d963acfec4207b2::ornn_nft {
    struct ORNN_NFT has drop {
        dummy_field: bool,
    }

    struct Config has store, key {
        id: 0x2::object::UID,
        a: 0x2::balance::Balance<0x2::sui::SUI>,
        admin: address,
        mint_price: u64,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        creator: address,
        level: 0x1::string::String,
    }

    struct MANAGED has drop {
        dummy_field: bool,
    }

    public entry fun admin_mint(arg0: &mut Config, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.admin, 4);
        let v0 = NFT{
            id          : 0x2::object::new(arg6),
            name        : 0x1::string::utf8(arg1),
            description : 0x1::string::utf8(arg2),
            image_url   : 0x1::string::utf8(arg3),
            creator     : arg5,
            level       : 0x1::string::utf8(arg4),
        };
        0x2::transfer::transfer<NFT>(v0, arg5);
    }

    public entry fun burn(arg0: NFT) {
        let NFT {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
            creator     : _,
            level       : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &NFT) : &0x1::string::String {
        &arg0.description
    }

    public entry fun free_mint(arg0: &Config, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = NFT{
            id          : 0x2::object::new(arg1),
            name        : 0x1::string::utf8(b""),
            description : 0x1::string::utf8(b""),
            image_url   : 0x1::string::utf8(b""),
            creator     : 0x2::tx_context::sender(arg1),
            level       : 0x1::string::utf8(b""),
        };
        0x2::transfer::transfer<NFT>(v0, arg0.admin);
    }

    public entry fun help(arg0: &mut Config, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.a, 0x2::balance::value<0x2::sui::SUI>(&mut arg0.a), arg1), arg0.admin);
    }

    fun init(arg0: ORNN_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<ORNN_NFT>(arg0, arg1);
        let v1 = 0x2::tx_context::sender(arg1);
        let v2 = Config{
            id         : 0x2::object::new(arg1),
            a          : 0x2::balance::zero<0x2::sui::SUI>(),
            admin      : v1,
            mint_price : 10000000000,
        };
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"creator"));
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"https://ornn.io/"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"https://ornn.io/"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{creator}"));
        let v7 = 0x2::display::new_with_fields<NFT>(&v0, v3, v5, arg1);
        0x2::display::update_version<NFT>(&mut v7);
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v7, v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v1);
        0x2::transfer::share_object<Config>(v2);
    }

    public fun level(arg0: &NFT) : &0x1::string::String {
        &arg0.level
    }

    public fun name(arg0: &NFT) : &0x1::string::String {
        &arg0.name
    }

    public entry fun pay_mint(arg0: &mut Config, arg1: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1::vector::is_empty<0x2::coin::Coin<0x2::sui::SUI>>(&arg1), 3);
        0x2::tx_context::sender(arg2);
        let v0 = NFT{
            id          : 0x2::object::new(arg2),
            name        : 0x1::string::utf8(b""),
            description : 0x1::string::utf8(b""),
            image_url   : 0x1::string::utf8(b""),
            creator     : 0x2::tx_context::sender(arg2),
            level       : 0x1::string::utf8(b""),
        };
        let v1 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg1);
        0x2::pay::join_vec<0x2::sui::SUI>(&mut v1, arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.a, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v1, arg0.mint_price, arg2)));
        if (0x2::coin::value<0x2::sui::SUI>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, 0x2::tx_context::sender(arg2));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v1);
        };
        0x2::transfer::public_transfer<NFT>(v0, arg0.admin);
    }

    public entry fun update_mint_price(arg0: &mut Config, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 4);
        arg0.mint_price = arg1;
    }

    public entry fun update_nft_info(arg0: &mut Config, arg1: NFT, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == arg0.admin, 4);
        assert!(arg1.level == 0x1::string::utf8(b""), 1);
        arg1.name = 0x1::string::utf8(arg2);
        arg1.image_url = 0x1::string::utf8(arg4);
        arg1.name = 0x1::string::utf8(arg3);
        arg1.level = 0x1::string::utf8(arg5);
        0x2::transfer::transfer<NFT>(arg1, arg6);
    }

    public fun url(arg0: &NFT) : &0x1::string::String {
        &arg0.image_url
    }

    // decompiled from Move bytecode v6
}

