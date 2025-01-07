module 0x1ce2b30245d0b3bf5cbf5df07f8fbb188706413033b93c469a9d61876ad62859::BADJENOS {
    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        metadata: 0x1::string::String,
        creator: address,
    }

    struct BADJENOS has drop {
        dummy_field: bool,
    }

    fun general_mint(arg0: &mut 0x1ce2b30245d0b3bf5cbf5df07f8fbb188706413033b93c469a9d61876ad62859::collection::Collection, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1ce2b30245d0b3bf5cbf5df07f8fbb188706413033b93c469a9d61876ad62859::collection::getMetaDataUri(arg0);
        let v1 = 0x1::string::length(&v0);
        let v2 = 0x1ce2b30245d0b3bf5cbf5df07f8fbb188706413033b93c469a9d61876ad62859::collection::getMinted(arg0) + 1;
        assert!(v2 <= 0x1ce2b30245d0b3bf5cbf5df07f8fbb188706413033b93c469a9d61876ad62859::collection::getCollectionSupply(arg0), 0x1ce2b30245d0b3bf5cbf5df07f8fbb188706413033b93c469a9d61876ad62859::err::supply_maxed_out());
        let v3 = 0x1::string::sub_string(&v0, 0, v1);
        let v4 = *0x1::string::bytes(&v3);
        0x1::vector::append<u8>(&mut v4, b"/");
        let v5 = to_string(v2);
        0x1::vector::append<u8>(&mut v4, *0x1::string::bytes(&v5));
        0x1::vector::append<u8>(&mut v4, b".json");
        let v6 = 0x1::string::sub_string(&v0, 0, v1);
        let v7 = *0x1::string::bytes(&v6);
        0x1::vector::append<u8>(&mut v7, b"/");
        let v8 = to_string(v2);
        0x1::vector::append<u8>(&mut v7, *0x1::string::bytes(&v8));
        0x1::vector::append<u8>(&mut v7, b".png");
        let v9 = 0x1ce2b30245d0b3bf5cbf5df07f8fbb188706413033b93c469a9d61876ad62859::collection::getCollectionName(arg0);
        let v10 = *0x1::string::bytes(&v9);
        0x1::vector::append<u8>(&mut v10, b" #");
        let v11 = to_string(v2);
        0x1::vector::append<u8>(&mut v10, *0x1::string::bytes(&v11));
        let v12 = NFT{
            id          : 0x2::object::new(arg1),
            name        : 0x1::string::utf8(v10),
            description : 0x1ce2b30245d0b3bf5cbf5df07f8fbb188706413033b93c469a9d61876ad62859::collection::getCollectionDescription(arg0),
            url         : 0x2::url::new_unsafe_from_bytes(v7),
            metadata    : 0x1::string::utf8(v4),
            creator     : 0x1ce2b30245d0b3bf5cbf5df07f8fbb188706413033b93c469a9d61876ad62859::collection::getCreator(arg0),
        };
        0x2::transfer::transfer<NFT>(v12, 0x2::tx_context::sender(arg1));
        0x1ce2b30245d0b3bf5cbf5df07f8fbb188706413033b93c469a9d61876ad62859::collection::inscreaseMinted(arg0);
    }

    fun init(arg0: BADJENOS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://twitter.com/SUIPEPE_NFT"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{creator}"));
        let v4 = 0x2::package::claim<BADJENOS>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<NFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<NFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun public_mint(arg0: &mut 0x1ce2b30245d0b3bf5cbf5df07f8fbb188706413033b93c469a9d61876ad62859::collection::Collection, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x1ce2b30245d0b3bf5cbf5df07f8fbb188706413033b93c469a9d61876ad62859::collection::getAdmin(arg0) != 0x2::tx_context::sender(arg2)) {
            assert!(0x1ce2b30245d0b3bf5cbf5df07f8fbb188706413033b93c469a9d61876ad62859::collection::getPublicPrice(arg0) <= 0x2::coin::value<0x2::sui::SUI>(&arg1), 0x1ce2b30245d0b3bf5cbf5df07f8fbb188706413033b93c469a9d61876ad62859::err::coin_amount_below_price());
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, 0x1ce2b30245d0b3bf5cbf5df07f8fbb188706413033b93c469a9d61876ad62859::collection::getPublicPrice(arg0) * 0x1ce2b30245d0b3bf5cbf5df07f8fbb188706413033b93c469a9d61876ad62859::collection::getLaunchpadFee(arg0) / 100, arg2), 0x1ce2b30245d0b3bf5cbf5df07f8fbb188706413033b93c469a9d61876ad62859::collection::getAdmin(arg0));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x1ce2b30245d0b3bf5cbf5df07f8fbb188706413033b93c469a9d61876ad62859::collection::getCreator(arg0));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x1ce2b30245d0b3bf5cbf5df07f8fbb188706413033b93c469a9d61876ad62859::collection::getAdmin(arg0));
        };
        general_mint(arg0, arg2);
    }

    public fun to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 != 0) {
            0x1::vector::push_back<u8>(&mut v0, ((48 + arg0 % 10) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    public entry fun whitelist_mint(arg0: &mut 0x1ce2b30245d0b3bf5cbf5df07f8fbb188706413033b93c469a9d61876ad62859::collection::Collection, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x1ce2b30245d0b3bf5cbf5df07f8fbb188706413033b93c469a9d61876ad62859::collection::getAdmin(arg0) != 0x2::tx_context::sender(arg2)) {
            assert!(0x1ce2b30245d0b3bf5cbf5df07f8fbb188706413033b93c469a9d61876ad62859::collection::getWhiteListPrice(arg0) <= 0x2::coin::value<0x2::sui::SUI>(&arg1), 0x1ce2b30245d0b3bf5cbf5df07f8fbb188706413033b93c469a9d61876ad62859::err::coin_amount_below_price());
            let v0 = vector[];
            let v1 = 0x2::tx_context::sender(arg2);
            assert!(0x1::vector::contains<address>(&v0, &v1), 0);
            0x1ce2b30245d0b3bf5cbf5df07f8fbb188706413033b93c469a9d61876ad62859::collection::addWhitelistAddress(arg0, arg2);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, 0x1ce2b30245d0b3bf5cbf5df07f8fbb188706413033b93c469a9d61876ad62859::collection::getWhiteListPrice(arg0) * 0x1ce2b30245d0b3bf5cbf5df07f8fbb188706413033b93c469a9d61876ad62859::collection::getLaunchpadFee(arg0) / 100, arg2), 0x1ce2b30245d0b3bf5cbf5df07f8fbb188706413033b93c469a9d61876ad62859::collection::getAdmin(arg0));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x1ce2b30245d0b3bf5cbf5df07f8fbb188706413033b93c469a9d61876ad62859::collection::getCreator(arg0));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x1ce2b30245d0b3bf5cbf5df07f8fbb188706413033b93c469a9d61876ad62859::collection::getAdmin(arg0));
        };
        general_mint(arg0, arg2);
    }

    // decompiled from Move bytecode v6
}

