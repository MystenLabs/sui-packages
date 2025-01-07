module 0x7b88fab9dbed55f525ab6f23c49a6c2603a372c558be63904668b10af6043e17::bluemove_nft {
    struct BlueMoveNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        img_url: 0x1::string::String,
        url: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct BLUEMOVE_NFT has drop {
        dummy_field: bool,
    }

    struct MintedStore has store, key {
        id: 0x2::object::UID,
        minted: u64,
        minted_owner: u64,
        urls: vector<0x1::string::String>,
        members: vector<address>,
        start_time: u64,
        expired_time: u64,
        nft_per_user: u64,
        total_nfts: u64,
        price_per_item: u64,
        fund_address: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct MintedByUser has store {
        minted: u64,
    }

    struct MintNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public entry fun claim_token_to_fund(arg0: &mut MintedStore, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.fund_address == 0x2::tx_context::sender(arg1), 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.balance)), arg1), arg0.fund_address);
    }

    fun init(arg0: BLUEMOVE_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"img_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator_image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{img_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Test Mint"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://hungry-kitties.com/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Hungry Kitties"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs.bluemove.net/uploads/hungry-kitties/logo.webp"));
        let v4 = 0x2::package::claim<BLUEMOVE_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<BlueMoveNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<BlueMoveNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<BlueMoveNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = MintedStore{
            id             : 0x2::object::new(arg1),
            minted         : 0,
            minted_owner   : 0,
            urls           : 0x1::vector::empty<0x1::string::String>(),
            members        : 0x1::vector::empty<address>(),
            start_time     : 1682848800000,
            expired_time   : 1682935200000,
            nft_per_user   : 1,
            total_nfts     : 3000,
            price_per_item : 1000000000,
            fund_address   : @0x7a4a4427be66e1a616bd74cccbadbcc11d9ab048af9239c6737cc2ba1568b4c9,
            balance        : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<MintedStore>(v6);
    }

    public entry fun mint_with_quantity(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x2::clock::Clock, arg2: &mut MintedStore, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == arg3 * arg2.price_per_item, 3);
        assert!(arg2.start_time <= v1 && arg2.expired_time >= v1, 4);
        if (!0x2::dynamic_field::exists_with_type<address, MintedByUser>(&arg2.id, v0)) {
            let v2 = MintedByUser{minted: 0};
            0x2::dynamic_field::add<address, MintedByUser>(&mut arg2.id, v0, v2);
        };
        let v3 = 0x2::dynamic_field::borrow_mut<address, MintedByUser>(&mut arg2.id, v0);
        assert!(arg3 <= arg2.nft_per_user - v3.minted, 2);
        while (arg3 > 0) {
            assert!(arg2.minted < arg2.total_nfts, 1);
            assert!(v3.minted < arg2.nft_per_user, 2);
            let v4 = 0x1::string::utf8(b"Hungry Kitties BlueMove Test #");
            let v5 = num_str(arg2.minted + 1);
            0x1::string::append(&mut v4, v5);
            let v6 = 0x1::string::utf8(b"https://static.bluemove.net/hungry-kitties/");
            0x1::string::append(&mut v6, v5);
            0x1::string::append(&mut v6, 0x1::string::utf8(b".json"));
            let v7 = 0x1::string::utf8(b"https://ipfs.bluemove.net/uploads/hungry-kitties/images/");
            0x1::string::append(&mut v7, v5);
            0x1::string::append(&mut v7, 0x1::string::utf8(b".webp"));
            let v8 = BlueMoveNFT{
                id        : 0x2::object::new(arg4),
                name      : v4,
                img_url   : v7,
                url       : v6,
                image_url : v7,
            };
            let v9 = MintNFTEvent{
                object_id : 0x2::object::uid_to_inner(&v8.id),
                creator   : v0,
                name      : v8.name,
            };
            0x2::event::emit<MintNFTEvent>(v9);
            0x2::transfer::public_transfer<BlueMoveNFT>(v8, v0);
            arg2.minted = arg2.minted + 1;
            v3.minted = v3.minted + 1;
            arg3 = arg3 - 1;
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg0));
    }

    public entry fun mint_with_quantity_owner(arg0: &mut MintedStore, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.fund_address == v0, 5);
        if (!0x2::dynamic_field::exists_with_type<address, MintedByUser>(&arg0.id, v0)) {
            let v1 = MintedByUser{minted: 0};
            0x2::dynamic_field::add<address, MintedByUser>(&mut arg0.id, v0, v1);
        };
        let v2 = 0x2::dynamic_field::borrow_mut<address, MintedByUser>(&mut arg0.id, v0);
        while (arg1 > 0) {
            assert!(arg0.minted + arg0.minted_owner < 3000, 1);
            let v3 = 0x1::string::utf8(b"Hungry Kitties BlueMove Test #");
            let v4 = num_str(arg0.total_nfts);
            0x1::string::append(&mut v3, v4);
            let v5 = 0x1::string::utf8(b"https://static.bluemove.net/hungry-kitties/");
            0x1::string::append(&mut v5, v4);
            0x1::string::append(&mut v5, 0x1::string::utf8(b".json"));
            let v6 = 0x1::string::utf8(b"https://ipfs.bluemove.net/uploads/hungry-kitties/images/");
            0x1::string::append(&mut v6, v4);
            0x1::string::append(&mut v6, 0x1::string::utf8(b".webp"));
            let v7 = BlueMoveNFT{
                id        : 0x2::object::new(arg3),
                name      : v3,
                img_url   : v6,
                url       : v5,
                image_url : v6,
            };
            let v8 = MintNFTEvent{
                object_id : 0x2::object::uid_to_inner(&v7.id),
                creator   : v0,
                name      : v7.name,
            };
            0x2::event::emit<MintNFTEvent>(v8);
            0x2::transfer::public_transfer<BlueMoveNFT>(v7, arg2);
            arg0.minted_owner = arg0.minted_owner + 1;
            arg0.total_nfts = arg0.total_nfts - 1;
            v2.minted = v2.minted + 1;
            arg1 = arg1 - 1;
        };
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

    public entry fun update_time_to_mint(arg0: &mut MintedStore, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.fund_address == 0x2::tx_context::sender(arg3), 5);
        arg0.start_time = arg1;
        arg0.expired_time = arg2;
    }

    // decompiled from Move bytecode v6
}

