module 0xf428abce3f3da3ef541ca4603cd32b71929169ea1131993b22589bc6ba41afeb::collection {
    struct Collection has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        creator: address,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        collection: address,
        owner: address,
        listed: bool,
        price: u64,
    }

    struct Marketplace has key {
        id: 0x2::object::UID,
        nfts: 0x2::table::Table<0x2::object::ID, NFT>,
    }

    struct MintConfig has key {
        id: 0x2::object::UID,
        receiver: address,
        fee_amount: u64,
    }

    entry fun buy_nft(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<0x2::object::ID, NFT>(&arg0.nfts, arg1), 4);
        let v1 = 0x2::table::borrow<0x2::object::ID, NFT>(&arg0.nfts, arg1);
        assert!(v1.listed, 4);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == v1.price, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v1.owner);
        let v2 = 0x2::table::remove<0x2::object::ID, NFT>(&mut arg0.nfts, arg1);
        v2.owner = v0;
        v2.listed = false;
        v2.price = 0;
        0x2::transfer::transfer<NFT>(v2, v0);
    }

    entry fun create_collection(arg0: &MintConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg0.fee_amount, 6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.receiver);
        let v1 = Collection{
            id          : 0x2::object::new(arg4),
            name        : arg2,
            description : arg3,
            creator     : v0,
        };
        0x2::transfer::transfer<Collection>(v1, v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Marketplace{
            id   : 0x2::object::new(arg0),
            nfts : 0x2::table::new<0x2::object::ID, NFT>(arg0),
        };
        0x2::transfer::share_object<Marketplace>(v0);
        let v1 = MintConfig{
            id         : 0x2::object::new(arg0),
            receiver   : 0x2::tx_context::sender(arg0),
            fee_amount : 20000000,
        };
        0x2::transfer::share_object<MintConfig>(v1);
    }

    entry fun list_nft(arg0: &mut Marketplace, arg1: NFT, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 1);
        assert!(arg2 > 0, 2);
        arg1.listed = true;
        arg1.price = arg2;
        0x2::table::add<0x2::object::ID, NFT>(&mut arg0.nfts, 0x2::object::id<NFT>(&arg1), arg1);
    }

    entry fun mint_nft(arg0: &Collection, arg1: &MintConfig, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(arg0.creator == v0, 0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == arg1.fee_amount, 6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg1.receiver);
        let v1 = 0x2::object::id<Collection>(arg0);
        let v2 = NFT{
            id          : 0x2::object::new(arg6),
            name        : arg3,
            description : arg4,
            image_url   : arg5,
            collection  : 0x2::object::id_to_address(&v1),
            owner       : v0,
            listed      : false,
            price       : 0,
        };
        0x2::transfer::transfer<NFT>(v2, v0);
    }

    entry fun unlist_nft(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<0x2::object::ID, NFT>(&arg0.nfts, arg1), 3);
        assert!(0x2::table::borrow<0x2::object::ID, NFT>(&arg0.nfts, arg1).owner == v0, 3);
        let v1 = 0x2::table::remove<0x2::object::ID, NFT>(&mut arg0.nfts, arg1);
        v1.listed = false;
        v1.price = 0;
        0x2::transfer::transfer<NFT>(v1, v0);
    }

    // decompiled from Move bytecode v7
}

