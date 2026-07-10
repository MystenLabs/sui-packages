module 0x17fb1d31c2468121f97080cb7e9d05552db902056c4379d4860aa11491f343fe::soyara_genesis_pass {
    struct SOYARA_GENESIS_PASS has drop {
        dummy_field: bool,
    }

    struct SoyaraGenesisPass has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        serial_number: u64,
        image_url: 0x2::url::Url,
        attributes_keys: vector<0x1::string::String>,
        attributes_values: vector<0x1::string::String>,
    }

    struct NftGlobalConfig has store, key {
        id: 0x2::object::UID,
        deployer_address: address,
        total_minted: u64,
        max_supply: u64,
        mint_price_mist: u64,
        nft_image_url: 0x1::string::String,
        royalty_bps: u16,
        is_mint_active: bool,
    }

    struct NftAdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun batch_mint(arg0: &mut NftGlobalConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : vector<SoyaraGenesisPass> {
        assert!(arg0.is_mint_active, 2);
        assert!(arg2 > 0, 5);
        assert!(arg0.total_minted + arg2 <= arg0.max_supply, 3);
        let v0 = arg2 * arg0.mint_price_mist;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v0, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v0, arg3), arg0.deployer_address);
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
        let v1 = 0x1::vector::empty<SoyaraGenesisPass>();
        let v2 = 0;
        while (v2 < arg2) {
            arg0.total_minted = arg0.total_minted + 1;
            let v3 = arg0.total_minted;
            let v4 = 0x1::string::utf8(b"Soyara Genesis Pass #");
            0x1::string::append(&mut v4, u64_to_string(v3));
            let v5 = 0x1::vector::empty<0x1::string::String>();
            let v6 = &mut v5;
            0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"Tier"));
            0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"Daily Reward"));
            let v7 = 0x1::vector::empty<0x1::string::String>();
            let v8 = &mut v7;
            0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"Genesis Pass"));
            0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"10 SDT/Day"));
            let v9 = SoyaraGenesisPass{
                id                : 0x2::object::new(arg3),
                name              : v4,
                description       : 0x1::string::utf8(b"Official Soyara Genesis Pass. Stake this pass in the Soyara Staking Pool to earn 10 Soyara Diamond (SDT) per day."),
                serial_number     : v3,
                image_url         : 0x2::url::new_unsafe(0x1::string::to_ascii(arg0.nft_image_url)),
                attributes_keys   : v5,
                attributes_values : v7,
            };
            0x1::vector::push_back<SoyaraGenesisPass>(&mut v1, v9);
            v2 = v2 + 1;
        };
        v1
    }

    public fun batch_mint_and_transfer(arg0: &mut NftGlobalConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = batch_mint(arg0, arg1, arg2, arg3);
        while (!0x1::vector::is_empty<SoyaraGenesisPass>(&v0)) {
            0x2::transfer::public_transfer<SoyaraGenesisPass>(0x1::vector::pop_back<SoyaraGenesisPass>(&mut v0), 0x2::tx_context::sender(arg3));
        };
        0x1::vector::destroy_empty<SoyaraGenesisPass>(v0);
    }

    fun init(arg0: SOYARA_GENESIS_PASS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SOYARA_GENESIS_PASS>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"serial_number"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://soyara.pro"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Soyara Genesis Pass Deployer"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"#{serial_number}"));
        let v5 = 0x2::display::new_with_fields<SoyaraGenesisPass>(&v0, v1, v3, arg1);
        0x2::display::update_version<SoyaraGenesisPass>(&mut v5);
        let (v6, v7) = 0x2::transfer_policy::new<SoyaraGenesisPass>(&v0, arg1);
        let v8 = NftGlobalConfig{
            id               : 0x2::object::new(arg1),
            deployer_address : 0x2::tx_context::sender(arg1),
            total_minted     : 0,
            max_supply       : 10000,
            mint_price_mist  : 5000000000,
            nft_image_url    : 0x1::string::utf8(b"https://emerald-working-cattle-906.mypinata.cloud/ipfs/bafybeiak4di2foc4ky2r6ii27745qjnwxumfvzkxiiqkql32ddldtkk75i?pinataGatewayToken=qIKTZuFY8AgJUGydNhAhzeBV1Mn5Wt_gp2XSTE77b3RqaJAQao-MiY5QiKILOAhD"),
            royalty_bps      : 1000,
            is_mint_active   : true,
        };
        let v9 = NftAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<NftGlobalConfig>(v8);
        0x2::transfer::public_share_object<0x2::display::Display<SoyaraGenesisPass>>(v5);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<SoyaraGenesisPass>>(v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<SoyaraGenesisPass>>(v7, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<NftAdminCap>(v9, 0x2::tx_context::sender(arg1));
    }

    public fun max_supply(arg0: &NftGlobalConfig) : u64 {
        arg0.max_supply
    }

    public fun mint(arg0: &mut NftGlobalConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : SoyaraGenesisPass {
        assert!(arg0.is_mint_active, 2);
        assert!(arg0.total_minted < arg0.max_supply, 3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg0.mint_price_mist, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, arg0.mint_price_mist, arg2), arg0.deployer_address);
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg2));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
        arg0.total_minted = arg0.total_minted + 1;
        let v0 = arg0.total_minted;
        let v1 = 0x1::string::utf8(b"Soyara Genesis Pass #");
        0x1::string::append(&mut v1, u64_to_string(v0));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Tier"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Daily Reward"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Genesis Pass"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"10 SDT/Day"));
        SoyaraGenesisPass{
            id                : 0x2::object::new(arg2),
            name              : v1,
            description       : 0x1::string::utf8(b"Official Soyara Genesis Pass. Stake this pass in the Soyara Staking Pool to earn 10 Soyara Diamond (SDT) per day."),
            serial_number     : v0,
            image_url         : 0x2::url::new_unsafe(0x1::string::to_ascii(arg0.nft_image_url)),
            attributes_keys   : v2,
            attributes_values : v4,
        }
    }

    public fun mint_price_mist(arg0: &NftGlobalConfig) : u64 {
        arg0.mint_price_mist
    }

    public fun nft_image_url(arg0: &NftGlobalConfig) : 0x1::string::String {
        arg0.nft_image_url
    }

    public fun serial_number(arg0: &SoyaraGenesisPass) : u64 {
        arg0.serial_number
    }

    public fun set_deployer_address(arg0: &NftAdminCap, arg1: &mut NftGlobalConfig, arg2: address) {
        arg1.deployer_address = arg2;
    }

    public fun set_max_supply(arg0: &NftAdminCap, arg1: &mut NftGlobalConfig, arg2: u64) {
        arg1.max_supply = arg2;
    }

    public fun set_mint_price(arg0: &NftAdminCap, arg1: &mut NftGlobalConfig, arg2: u64) {
        arg1.mint_price_mist = arg2;
    }

    public fun set_nft_image_url(arg0: &NftAdminCap, arg1: &mut NftGlobalConfig, arg2: 0x1::string::String) {
        arg1.nft_image_url = arg2;
    }

    public fun toggle_mint(arg0: &NftAdminCap, arg1: &mut NftGlobalConfig, arg2: bool) {
        arg1.is_mint_active = arg2;
    }

    public fun total_minted(arg0: &NftGlobalConfig) : u64 {
        arg0.total_minted
    }

    fun u64_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = b"";
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    // decompiled from Move bytecode v7
}

