module 0x40bc8ef4c45c1606a26b1e6b165d85dca43efe52dafc52d7693d7602ef9da5e8::nft_pass {
    struct NFT_PASS has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintCap has store, key {
        id: 0x2::object::UID,
        total_supply: u64,
    }

    struct Global has store, key {
        id: 0x2::object::UID,
        level_up_points: vector<u64>,
    }

    struct GenesisNFTPass has store, key {
        id: 0x2::object::UID,
        level: u64,
    }

    fun init(arg0: NFT_PASS, arg1: &mut 0x2::tx_context::TxContext) {
        init_config_and_cap(arg1);
        init_publisher_and_display(arg0, arg1);
    }

    fun init_config_and_cap(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Global{
            id              : 0x2::object::new(arg0),
            level_up_points : vector[1000, 2000, 3000, 4000],
        };
        0x2::transfer::share_object<Global>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v2, v0);
        let v3 = MintCap{
            id           : 0x2::object::new(arg0),
            total_supply : 0,
        };
        0x2::transfer::public_transfer<MintCap>(v3, v0);
    }

    fun init_publisher_and_display(arg0: NFT_PASS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"GiroSwap Genesis NFT Pass"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://giroswap.com/"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://giroswap.com/assets/nft/{level}.png}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"GiroSwap Genesis NFT Pass is a pass specially designed for early supporters of GiroSwap, aiming to provide them with unique privileges and benefits."));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://giroswap.com/"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"GiroSwap"));
        let v5 = 0x2::package::claim<NFT_PASS>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<GenesisNFTPass>(&v5, v1, v3, arg1);
        0x2::display::update_version<GenesisNFTPass>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, v0);
        0x2::transfer::public_transfer<0x2::display::Display<GenesisNFTPass>>(v6, v0);
    }

    public entry fun level_up(arg0: &Global, arg1: &mut 0x40bc8ef4c45c1606a26b1e6b165d85dca43efe52dafc52d7693d7602ef9da5e8::implements::Global, arg2: &mut GenesisNFTPass, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.level < 0x1::vector::length<u64>(&arg0.level_up_points), 1);
        0x40bc8ef4c45c1606a26b1e6b165d85dca43efe52dafc52d7693d7602ef9da5e8::implements::consume_points(arg1, 0x2::tx_context::sender(arg3), *0x1::vector::borrow<u64>(&arg0.level_up_points, arg2.level));
        arg2.level = arg2.level + 1;
    }

    public fun mint(arg0: &mut MintCap, arg1: &mut 0x2::tx_context::TxContext) : GenesisNFTPass {
        let v0 = GenesisNFTPass{
            id    : 0x2::object::new(arg1),
            level : 0,
        };
        arg0.total_supply = arg0.total_supply + 1;
        v0
    }

    public entry fun mint_and_transfer(arg0: &mut MintCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<GenesisNFTPass>(mint(arg0, arg2), arg1);
    }

    public entry fun set_leve_lup_points(arg0: &mut Global, arg1: &AdminCap, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.level_up_points = arg2;
    }

    // decompiled from Move bytecode v6
}

