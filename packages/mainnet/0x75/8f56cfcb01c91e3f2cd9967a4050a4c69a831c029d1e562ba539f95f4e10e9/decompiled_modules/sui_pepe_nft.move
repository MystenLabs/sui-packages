module 0x758f56cfcb01c91e3f2cd9967a4050a4c69a831c029d1e562ba539f95f4e10e9::sui_pepe_nft {
    struct SuiPepeNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        img_url: 0x1::string::String,
        url: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct SUI_PEPE_NFT has drop {
        dummy_field: bool,
    }

    struct Share has store, key {
        id: 0x2::object::UID,
        current_mint: u64,
        start: u64,
        total_nfts: u64,
        price: u64,
        admin: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct UserInfo has store {
        is_mint: bool,
    }

    fun init(arg0: SUI_PEPE_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"img_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{img_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"$SPEPE The biggest airdrop on SUI mainnet. #Sui no airdrop, #SuiPepe will airdrop. We will make the biggest airdrop ever. Don't lose opportunity to get our airdrop. Join with us. Website: https://sui-pepe.xyz. Twitter: https://twitter.com/pepesuicoins"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://sui-pepe.xyz"));
        let v4 = 0x2::package::claim<SUI_PEPE_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<SuiPepeNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<SuiPepeNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SuiPepeNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = Share{
            id           : 0x2::object::new(arg1),
            current_mint : 0,
            start        : 16831377890,
            total_nfts   : 10000,
            price        : 5000000000,
            admin        : @0xf44119724657477034e343c0287f1a8bddb0cf3db47e265225d336b57e9b42de,
            balance      : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Share>(v6);
    }

    public entry fun mint(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x2::clock::Clock, arg2: &mut Share, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg2.start <= 0x2::clock::timestamp_ms(arg1), 0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == arg2.price, 0);
        if (!0x2::dynamic_field::exists_with_type<address, UserInfo>(&arg2.id, v0)) {
            let v1 = UserInfo{is_mint: false};
            0x2::dynamic_field::add<address, UserInfo>(&mut arg2.id, v0, v1);
        };
        let v2 = 0x2::dynamic_field::borrow_mut<address, UserInfo>(&mut arg2.id, v0);
        assert!(!v2.is_mint, 0);
        assert!(arg2.current_mint < arg2.total_nfts, 0);
        let v3 = 0x1::string::utf8(b"SuiPepe NFT #");
        let v4 = num_str(arg2.current_mint + 1);
        0x1::string::append(&mut v3, v4);
        let v5 = 0x1::string::utf8(b"https://api.sui-pepe.xyz/uploads/sui-pepe/");
        0x1::string::append(&mut v5, v4);
        0x1::string::append(&mut v5, 0x1::string::utf8(b".webp"));
        let v6 = SuiPepeNFT{
            id        : 0x2::object::new(arg3),
            name      : v3,
            img_url   : v5,
            url       : v5,
            image_url : v5,
        };
        0x2::transfer::public_transfer<SuiPepeNFT>(v6, v0);
        arg2.current_mint = arg2.current_mint + 1;
        v2.is_mint = true;
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg0));
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

    public entry fun update(arg0: &mut Share, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 0);
        arg0.start = arg1;
    }

    public entry fun withdraw_sui(arg0: &mut Share, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(arg0.admin == v0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.balance)), arg1), v0);
    }

    // decompiled from Move bytecode v6
}

